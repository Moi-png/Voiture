# -*- encoding: utf-8 -*-

import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))
from flask import Flask, abort, url_for, request, redirect, session
from datetime import datetime
from flask_mako import render_template, MakoTemplates
from flask_sqlite import SQLiteExtension, get_db
from random import randint
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

def redirect_if_logged_in(view_func):
    @wraps(view_func)
    def wrapped_view(*args, **kwargs):
        if "user_id" in session:
            return redirect(url_for("acceuil"))
        return view_func(*args, **kwargs)
    return wrapped_view

class ValidationError(ValueError):
    """Error in users provided values."""
    pass

@app.route("/")
@redirect_if_logged_in
def index():
    return render_template("1.PageTitre.html.mako")

@app.route("/register", methods=["GET", "POST"])
@redirect_if_logged_in
def register():
    if request.method == "GET":
        return render_template("2.Register.html.mako", error=None)
    elif request.method == "POST":
        try:
            if request.form["password"] != request.form["confirm_password"]:
                raise ValidationError("Les mots de passe ne correspondent pas.")
            db = get_db()
            db.execute(
                """
                INSERT INTO users (pseudo, email, password)
                VALUES (?,?,?);
                """,
                (request.form["pseudo"], request.form["email"], request.form["password"]))
            db.commit()
            user_id = db.execute("SELECT last_insert_rowid()").fetchone()[0]
            session.clear()
            session["user_id"] = user_id
            return redirect("welcome", code=303)
        except ValidationError as e:
            return render_template("2.Register.html.mako", error=str(e))

@app.route("/welcome")
@redirect_if_logged_in
def welcome():
    return render_template("3.WelcomeNewUser.html.mako")

@app.route("/login", methods=["GET", "POST"])
@redirect_if_logged_in
def login():
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
    if "user_id" not in session:
        return redirect(url_for('index'))
    else:
        return render_template("4.Page d'acceuil.html.mako")

@app.route("/profile")
def profile():
    user = load_connected_user()
    if user is None:
        return redirect(url_for("index"))
    pseudo = user["pseudo"]
    email = user["email"]
    return render_template("5.Compte.html.mako", pseudo=pseudo, user=user)

@app.route("/garage")
def garage():
    if "user_id" not in session:
        return redirect(url_for('index'))
    else:
        s = "SELECT count(*) FROM voiture"
        x = randint(1,s)
        "SELECT * FROM voitures WHERE id = x"
        return render_template("5.RegarderUneVoiture.html.mako")

@app.route("/comparatif")
def comparatif():
    if "user_id" not in session:
        return redirect(url_for('index'))
    else:
        return render_template("5.Comparatif.html.mako")

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
            db = get_db()
            db.execute("""
                INSERT INTO voiture (
                    signal, hauteur, largeur, longueur, nom, pmax, cylindre, mcouple,
                    transmission, boite, moteur, posmoteur, energie, vmax, massevide,
                    marque, lienimage
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                0,
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
                form["lienimage"]
            ))
            db.commit()
            return redirect(url_for("garage"), code=303)
        except Exception as e:
            return render_template("6.AjoutDeVoiture.html.mako", error="Erreur : " + str(e))

app.run(debug=True)