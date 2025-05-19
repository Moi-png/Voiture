# -*- encoding: utf-8 -*-

import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))
from flask import Flask, abort, url_for, request, redirect, session
from datetime import datetime
from flask_mako import render_template, MakoTemplates
from flask_sqlite import SQLiteExtension, get_db
from random import randint, choice, sample, shuffle
from sqlite3 import *

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
            db.execute("INSERT INTO users (pseudo, email, password, photo) VALUES (?, ?, ?, ?)",(pseudo, email, password, photo_path))
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
    if "user_id" not in session:
        return redirect(url_for("index"))
    db = get_db()
    liked_cars = db.execute("""SELECT voiture.id, voiture.nom FROM voiture JOIN likes ON voiture.id = likes.voiture WHERE likes.user = ?""", (user["id"],)).fetchall()
    db.close()
    return render_template("5.Compte.html.mako", pseudo=user["pseudo"], user=user, liked_cars=liked_cars)

@app.route("/comptec", methods=["GET", "POST"])
def comptec():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    user_id = session['user_id']
    db = get_db()
    if request.method == "POST":
        pseudo = request.form['pseudo']
        email = request.form['email']
        password = request.form['password']
        photo_file = request.files['photo']
        photo_path = None
        if photo_file and photo_file.filename != '':
            filename = photo_file.filename
            photo_path = os.path.join("static/uploads", filename)
            photo_file.save(photo_path)
        if password.strip():
            if photo_path:
                db.execute("""
                    UPDATE users SET pseudo=?, email=?, password=?, photo=?
                    WHERE id=?
                """, (pseudo, email, password, photo_path, user_id))
            else:
                db.execute("""
                    UPDATE users SET pseudo=?, email=?, password=?
                    WHERE id=?
                """, (pseudo, email, password, user_id))
        else:
            if photo_path:
                db.execute("""
                    UPDATE users SET pseudo=?, email=?, photo=?
                    WHERE id=?
                """, (pseudo, email, photo_path, user_id))
            else:
                db.execute("""
                    UPDATE users SET pseudo=?, email=?
                    WHERE id=?
                """, (pseudo, email, user_id))
        db.commit()
        return redirect(url_for('profile'))
    user = db.execute("SELECT * FROM users WHERE id=?", (user_id,)).fetchone()
    return render_template("modifier_compte.html.mako", user=user)

@app.route("/garage/start", methods=["GET", "POST"])
def garage_start():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    db = get_db()
    voitures = db.execute("SELECT * FROM voiture").fetchall()
    if request.method == "POST":
        voiture_id_raw = request.form.get("voiture_id")
        try:
            start_vid = int(voiture_id_raw)
        except (ValueError, TypeError):
            db.close()
            return "ID de voiture invalide", 400
        car_ids = [v["id"] for v in voitures]
        shuffle(car_ids)
        if start_vid in car_ids:
            car_ids.remove(start_vid)
        car_ids.insert(0, start_vid)
        ordre_str = ",".join(str(i) for i in car_ids)
        db.close()
        return redirect(url_for("garage", vid=start_vid, ordre=ordre_str))
    db.close()
    return render_template("5.choisir_voiture.html.mako", voitures=voitures)

@app.route("/garage/<vid>", methods=["GET", "POST"])
def garage(vid):
    if "user_id" not in session:
        return redirect(url_for("index"))
    db = get_db()
    user_id = session["user_id"]
    user = load_connected_user()
    ordre_str = request.args.get("ordre")
    voitures = db.execute("SELECT * FROM voiture").fetchall()
    car_ids = [v["id"] for v in voitures]
    if not ordre_str:
        try:
            start_vid = int(vid)
        except ValueError:
            db.close()
            return redirect(url_for("garage_start"))
        if start_vid not in car_ids:
            db.close()
            return redirect(url_for("garage_start"))
        shuffle(car_ids)
        car_ids.remove(start_vid)
        car_ids.insert(0, start_vid)
        ordre_str = ",".join(str(i) for i in car_ids)
        db.close()
        return redirect(url_for("garage", vid=start_vid, ordre=ordre_str))
    try:
        ordre = [int(x) for x in ordre_str.split(",") if x.strip()]
    except ValueError:
        db.close()
        return "Ordre invalide", 400
    if vid == "random":
        if not ordre:
            db.close()
            return redirect(url_for("garage_start"))
        vid = ordre[0]
    else:
        try:
            vid = int(vid)
        except ValueError:
            db.close()
            return "ID de voiture invalide", 400
    if vid not in ordre:
        db.close()
        return redirect(url_for("garage_start"))
    index = ordre.index(vid)
    prev_id = ordre[index - 1] if index > 0 else None
    next_id = ordre[index + 1] if index + 1 < len(ordre) else None
    voiture = db.execute("SELECT * FROM voiture WHERE id = ?", (vid,)).fetchone()
    if not voiture:
        db.close()
        return "Voiture introuvable", 404
    if request.method == "POST":
        action = request.form.get("action")
        if action == "like":
            already = db.execute("SELECT 1 FROM likes WHERE user = ? AND voiture = ?", (user_id, vid)).fetchone()
            if not already:
                db.execute("INSERT INTO likes (user, voiture) VALUES (?, ?)", (user_id, vid))
            else:
                db.execute("DELETE FROM likes WHERE user = ? AND voiture = ?", (user_id, vid))
        elif action == "signal":
            already = db.execute("SELECT 1 FROM signal WHERE user = ? AND voiture = ?", (user_id, vid)).fetchone()
            if not already:
                db.execute("INSERT INTO signal (user, voiture) VALUES (?, ?)", (user_id, vid))
            else:
                db.execute("DELETE FROM signal WHERE user = ? AND voiture = ?", (user_id, vid))
        db.commit()
        return redirect(url_for("garage", vid=vid, ordre=ordre_str))
    is_liked = db.execute("SELECT 1 FROM likes WHERE user = ? AND voiture = ?", (user_id, vid)).fetchone() is not None
    is_signaled = db.execute("SELECT 1 FROM signal WHERE user = ? AND voiture = ?", (user_id, vid)).fetchone() is not None
    like_count = db.execute("SELECT COUNT(*) FROM likes WHERE voiture = ?", (vid,)).fetchone()[0]
    signal_count = db.execute("SELECT COUNT(*) FROM signal WHERE voiture = ?", (vid,)).fetchone()[0]
    db.close()
    return render_template("5.RegarderUneVoiture.html.mako",voiture=voiture,is_liked=is_liked,is_signaled=is_signaled,like_count=like_count,signal_count=signal_count,user=user,prev_id=prev_id,next_id=next_id,ordre_str=ordre_str)

@app.route("/comparatif", methods=["GET", "POST"])
def comparatif():
    if "user_id" not in session:
        return redirect(url_for('index'))
    db = get_db()
    voitures = db.execute("SELECT id, nom FROM voiture").fetchall()
    db.close()
    if request.method == "POST":
        vid1 = request.form.get("voiture_gauche")
        vid2 = request.form.get("voiture_droite")
        return redirect(url_for("comparatiff", s1=vid1, s2=vid2))
    return render_template("5.choice.html.mako", voitures=voitures)

@app.route("/comparatif/<s1>/<s2>")
def comparatiff(s1, s2):
    if "user_id" not in session:
        return redirect(url_for('index'))
    db = get_db()
    voiture1 = db.execute("SELECT * FROM voiture WHERE id = ?", (s1,)).fetchone()
    voiture2 = db.execute("SELECT * FROM voiture WHERE id = ?", (s2,)).fetchone()
    db.close()
    return render_template("5.Comparatif.html.mako", voiture1=voiture1, voiture2=voiture2)

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
            db.execute("""INSERT INTO voiture (hauteur, largeur, longueur, nom, pmax, mcouple, transmission, boite, moteur, posmoteur, energie, vmax, massevide, lienimage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""", (
                form["hauteur"],
                form["largeur"],
                form["longueur"],
                form["nom"],
                form["pmax"],
                form["mcouple"],
                form["transmission"],
                form["boite"],
                form["moteur"],
                form["posmoteur"],
                form["energie"],
                form["vmax"],
                form["massevide"],
                filepath
            ))
            db.commit()
            return redirect(url_for("garage"), code=303)
        except Exception as e:
            return render_template("6.AjoutDeVoiture.html.mako", error="Erreur : " + str(e))

app.run(debug=True)