# -*- encoding: utf-8 -*-
"""Server Web d'exemple écrit en Python avec Flask.
"""


# S'assure de pouvoir démarrer le serveur depuis n'importe quel dossier.
import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))


from flask import Flask, abort, url_for, request, redirect, session  # Importe le type Flask.
from datetime import datetime
from flask_mako import render_template, MakoTemplates
from flask_sqlite import SQLiteExtension, get_db
from random import randint
import sqlite3

def get_db():
    conn = sqlite3.connect("test.db")
    conn.row_factory = sqlite3.Row
    return conn

app = Flask("SuperSite")  # Crée une application Flask nommée "SuperSite".
app.secret_key = b'\xee\xf6\xd5\xd30o\xaf\xcb"k\xa61k\xa7h\xf1'
MakoTemplates(app)
SQLiteExtension(app)
# Indique à Flask d'appeler la fonction "index" lorsqu'un client
# requiert l'accès à la page située à la racine de notre site.
# Par exemple, l'adresse: https://www.exemple.org/
def load_connected_user():
    user_id = session.get("user_id")
    if user_id is not None:
        db=get_db()
        cursor = db.execute("SELECT * FROM users WHERE id = ?", (user_id,))
        user = cursor.fetchone
        return user


@app.route("/")
def index():
    return render_template("1.PageTitre.html.mako")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "GET":
        return render_template("2.Register.html.mako", error=None)
    db = get_db()
    try:
        email = request.form["email"]
        pseudo = request.form["pseudo"]
        password = request.form["password"]
        confirm_password = request.form["confirm_password"]
        if password != confirm_password:
            raise ValidationError("Mot de passe mal confirmé!")
        db.execute(
            """
            INSERT INTO users (email, pseudo, password)
            VALUES (?, ?, ?);
            """,
            (email, pseudo, password)
        )
        db.commit()
        return redirect(url_for("welcome"), code=303)
    except sqlite3.IntegrityError:
        db.rollback()
        return render_template("2.Register.html.mako", error="Nom d'utilisateur déjà pris")
    except ValidationError as e:
        return render_template("2.Register.html.mako", error=str(e))
    finally:
        db.close()



@app.route("/login")
def login():
    if "user_id" in session:
        return redirect(url_for('welcome'))
    if request.method == "GET":
        return render_template("2.Login.html.mako", error=None)
    elif request.method == "POST":
        db = get_db()
        try:
            cursor = db.execute("SELECT * FROM users WHERE pseudo=? LIMIT 1", (request.form['pseudo']))
            user = cursor.fetchone()
            if user is None:
                raise ValidationError("Pseudonyme invalide")
            if user['password'] != request.form['password']:
                raise ValidationError('Mot de passe invalide')
            session.clear()
            session['user_id']=user['id']
            app.logger.info("LOG IN '%s' (id=%d)", user['pseudo'], user['id'])
            return redirect(url_for("welcome"), code=303)
        except ValidationError as e:
            return render_template("2.Login.html.mako", error=str(e))


@app.route("/profile/<pseudo>")
def profile(pseudo):
    db = get_db()
    cursor = db.execute("SELECT * FROM users WHERE pseudo = ?", (pseudo,))
    user = cursor.fetchone()
    if user is None:
        abort(404)
    return render_template("5.Compte.html.mako", pseudo=pseudo, user=user)


@app.route("/logout")
def logout():
    session.clear()
    return render_template("3.Deconnection.html.mako")


@app.route("/welcome")
def welcome():
    return render_template("3.WelcomeNewUser.html.mako")

class ValidationError(ValueError):
    """Error in users provided values."""
    pass




# Démarre l'application en mode debug.
# Attention: ce doit être la dernière instruction du script !!!
app.run(debug=True)
