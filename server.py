# -*- encoding: utf-8 -*-

import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))
from flask import Flask, abort, url_for, request, redirect, session
from datetime import datetime
from flask_mako import render_template, MakoTemplates
from flask_sqlite import SQLiteExtension, get_db
from random import randint, choice, sample
from sqlite3 import *
from functools import wraps

app = Flask("NEED4STATS")
app.secret_key = b'\xee\xf6\xd5\xd30o\xaf\xcb"k\xa61k\xa7h\xf1'
MakoTemplates(app)
SQLiteExtension(app)


def load_connected_user():
    user_id = session.get("user_id")
    if user_id is not None:
        db = get_db()
        cursor = db.execute("SELECT * FROM users WHERE id = ? LIMIT 1", (user_id,))
        user = cursor.fetchone()
        return user

class ValidationError(ValueError):
    """Error in users provided values."""
    pass

@app.route("/")
def index():
    if "user_id" in session:
        return redirect(url_for('acceuil'))
    return render_template("1.PageTitre.html.mako")

@app.route("/register", methods=["GET", "POST"])
def register():
    if "user_id" in session:
        return redirect(url_for('acceuil'))

    if request.method == "GET":
        return render_template("2.Register.html.mako", error=None)
    if request.method == "POST":
        try:
            if request.form["password"] != request.form["confirm_password"]:
                raise ValidationError("Les mots de passe ne correspondent pas.")

            pseudo = request.form["pseudo"]
            email = request.form["email"]
            password = request.form["password"]

            image = request.files.get("photo")
            photo_path = None

            if image and image.filename:
                ext = image.filename.rsplit(".", 1)[-1].lower()
                if ext in ("png", "jpg", "jpeg", "gif"):
                    filename = pseudo + "_" + image.filename.replace(" ", "_")
                    chemin = "static/uploads/" + filename
                    with open(chemin, "wb") as f:
                        f.write(image.read())
                    photo_path = chemin

            db = get_db()
            db.execute(
                "INSERT INTO users (pseudo, email, password, photo) VALUES (?, ?, ?, ?)",
                (pseudo, email, password, photo_path)
            )
            db.commit()

            user_id = db.execute("SELECT last_insert_rowid()").fetchone()[0]
            session.clear()
            session["user_id"] = user_id
            return redirect(url_for("welcome"), code=303)

        except ValidationError as e:
            return render_template("2.Register.html.mako", error=str(e))

@app.route("/welcome")
def welcome():
    if "user_id" not in session:
        return redirect(url_for('index'))
    return render_template("3.WelcomeNewUser.html.mako")

@app.route("/login", methods=["GET", "POST"])
def login():
    if "user_id" in session:
        return redirect(url_for('acceuil'))
    if request.method == "GET":
        return render_template("2.Login.html.mako", error=None)
    elif request.method == "POST":
        try:
            db = get_db()
            cursor = db.execute("SELECT * FROM users WHERE pseudo=? LIMIT 1",
                                (request.form["pseudo"],))
            user = cursor.fetchone()
            if user is None:
                raise ValidationError("Pseudo invalide")
            if user["password"] != request.form["password"]:
                raise ValidationError("Mot de passe invalide")

            session.clear()
            session["user_id"] = user["id"]
            app.logger.info("LOG IN '%s' (id=%d)", user['pseudo'], user['id'])
            return redirect(url_for("acceuil"), code=303)
        except ValidationError as e:
            return render_template("2.Login.html.mako", error=str(e))

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for('mlog'))

@app.route("/mlog")
def mlog():
    return render_template("3.Deconnection.html.mako")

@app.route("/acceuil")
def acceuil():
    user = load_connected_user()
    if "user_id" not in session:
        return redirect(url_for('index'))
    else:
        return render_template("4.Page d'acceuil.html.mako", user=user)

@app.route("/profile")
def profile():
    user = load_connected_user()
    if user is None:
        return redirect(url_for("index"))
    db = get_db()
    liked_cars = db.execute(
        """
        SELECT voiture.id, voiture.nom
        FROM voiture
        JOIN likes ON voiture.id = likes.voiture
        WHERE likes.user = ?
        """,
        (user["id"],)
    ).fetchall()
    db.close()
    return render_template("5.Compte.html.mako", pseudo=user["pseudo"], user=user, liked_cars=liked_cars)

@app.route("/garage/<vid>", methods=["GET", "POST"])
def garage(vid):
    if "user_id" not in session:
        return redirect(url_for("index"))
    user = load_connected_user()
    db = get_db()
    if vid == "random":
        car_ids = [row[0] for row in db.execute("SELECT id FROM voiture").fetchall()]
        db.close()
        vid = choice(car_ids)
        return redirect(url_for("garage", vid=vid))
    voiture = db.execute("SELECT * FROM voiture WHERE id = ?", (vid,)).fetchone()
    user_id = session["user_id"]
    if request.method == "POST":
        action = request.form.get("action")
        if action == "like":
            already_liked = db.execute(
                "SELECT 1 FROM likes WHERE user = ? AND voiture = ?", (user_id, vid)
            ).fetchone()
            if not already_liked:
                db.execute("INSERT INTO likes (user, voiture) VALUES (?, ?)", (user_id, vid))
            else:
                db.execute("DELETE FROM likes WHERE user = ? AND voiture = ?", (user_id, vid))
        elif action == "signal":
            already_signaled = db.execute(
                "SELECT 1 FROM signal WHERE user = ? AND voiture = ?", (user_id, vid)
            ).fetchone()
            if not already_signaled:
                db.execute("INSERT INTO signal (user, voiture) VALUES (?, ?)", (user_id, vid))
            else:
                db.execute("DELETE FROM signal WHERE user = ? AND voiture = ?", (user_id, vid))
        db.commit()
        return redirect(url_for("garage", vid=vid))
    is_liked = db.execute(
        "SELECT 1 FROM likes WHERE user = ? AND voiture = ?", (user_id, vid)
    ).fetchone() is not None
    is_signaled = db.execute(
        "SELECT 1 FROM signal WHERE user = ? AND voiture = ?", (user_id, vid)
    ).fetchone() is not None
    like_count = db.execute(
        "SELECT COUNT(*) FROM likes WHERE voiture = ?", (vid,)
    ).fetchone()[0]
    signal_count = db.execute(
        "SELECT COUNT(*) FROM signal WHERE voiture = ?", (vid,)
    ).fetchone()[0]
    db.close()
    return render_template("5.RegarderUneVoiture.html.mako", voiture=voiture, is_liked=is_liked, is_signaled=is_signaled, like_count=like_count, signal_count=signal_count, user=user)

@app.route("/comparatif")
def comparatif():
    if "user_id" not in session:
        return redirect(url_for('index'))
    else:
        db = get_db()
        total = db.execute("SELECT COUNT(*) FROM voiture").fetchone()[0]
        car_ids = [row[0] for row in db.execute("SELECT id FROM voiture").fetchall()]
        vid1, vid2 = sample(car_ids, 2)
        voiture1 = db.execute("SELECT * FROM voiture WHERE id = ?", (vid1,)).fetchone()
        voiture2 = db.execute("SELECT * FROM voiture WHERE id = ?", (vid2,)).fetchone()
        db.close()
        return render_template("5.Comparatif.html.mako", voiture1=voiture1, voiture2=voiture2, s1=vid1, s2=vid2)

@app.route("/contact")
def contact():
    if "user_id" not in session:
        return redirect(url_for('index'))
    else:
        return render_template("5.Contact.html.mako")

@app.route("/ajout", methods=["GET", "POST"])
def ajout():
    if "user_id" not in session:
        return redirect(url_for('index'))
    if request.method == "GET":
        return render_template("6.AjoutDeVoiture.html.mako", error=None)
    elif request.method == "POST":
        try:
            form = request.form
            photo = request.files["photo"]
            if not photo or photo.filename == "":
                return render_template("6.AjoutDeVoiture.html.mako", error="Veuillez ajouter une photo.")
            filename = photo.filename.replace(" ", "_")
            filepath = "static/uploads/" + filename
            with open(filepath, "wb") as f:
                f.write(photo.read())
            db = get_db()
            db.execute("""
                INSERT INTO voiture (
                    hauteur, largeur, longueur, nom, pmax, cylindre, mcouple,
                    transmission, boite, moteur, posmoteur, energie, vmax, massevide,
                    marque, lienimage
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                form["hauteur"],
                form["largeur"],
                form["longueur"],
                form["nom"],
                form["pmax"],
                form["cylindre"],
                form["mcouple"],
                form["transmission"],
                form["boite"],
                form["moteur"],
                form["posmoteur"],
                form["energie"],
                form["vmax"],
                form["massevide"],
                form["marque"],
                filepath
            ))
            db.commit()
            return redirect(url_for("garage"), code=303)
        except Exception as e:
            return render_template("6.AjoutDeVoiture.html.mako", error="Erreur : " + str(e))

app.run(debug=True)