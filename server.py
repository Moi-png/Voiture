# -*- encoding: utf-8 -*-

import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))
from flask import Flask, abort, url_for, request, redirect, session
from datetime import datetime
from flask_mako import render_template, MakoTemplates
from flask_sqlite import SQLiteExtension, get_db
from random import randint
from sqlite3 import *

app = Flask("NEED4STATS")
app.secret_key = b'\xee\xf6\xd5\xd30o\xaf\xcb"k\xa61k\xa7h\xf1'
MakoTemplates(app)
SQLiteExtension(app)

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
            return redirect("welcome", code=303)
        except ValidationError as e:
            return render_template("2.Register.html.mako", error=str(e))

@app.route("/welcome")
def welcome():
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
    return render_template("3.Deconnection.html.mako")

@app.route("/acceuil")
def acceuil():
    return render_template("4.Page d'acceuil.html.mako")

app.run(debug=True)