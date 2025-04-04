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
MakoTemplates(app)
SQLiteExtension(app)

@app.route("/")
def index():
    return render_template("1.PageTitre.html.mako")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "GET":
        return render_template("2.Register.html.mako", erroe=None)
    if request.method == "POST":
        pseudo = request.form.get("pseudo")
        email = request.form.get("email")
        password = request.form.get("password")
        confirm_password = request.form.get("confirm_password")

        if not pseudo or not email or not password or not confirm_password:
            return "Tous les champs sont requis.", 400

        if password != confirm_password:
            return "Les mots de passe ne correspondent pas.", 400

        db = get_db()
        cursor = db.cursor()

        # Vérifier si l'utilisateur existe déjà
        cursor.execute("SELECT id FROM user WHERE email = ? OR pseudo = ?", (email, pseudo))
        if cursor.fetchone():
            return "L'email ou le pseudo est déjà utilisé.", 400

        # Insérer l'utilisateur
        cursor.execute("INSERT INTO user (pseudo, email, password) VALUES (?, ?, ?)", (pseudo, email, password))
        db.commit()

        return redirect(url_for("welcome"))

    return render_template("2.Register.html.mako")

@app.route("/welcome")
def welcome():
    return render_template("3.WelcomeNewUser.html.mako")

app.run(debug=True)