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
    return render_template("1.PageTitre.html")  # Réponse envoyée au client.


@app.route("/clock")
def clock():
    return render_template("horloge.html.mako", clock=datetime.now())

@app.route("/exchange/<currency>/<sum>")
def change(currency,sum):
    sum=float(sum)
    currency_taux={'USD' : 1.10, 'EUR' : 1.06, 'GBP' : 0.88}
    try :
        taux=currency_taux[currency]
    except KeyError :
        return
    return "<p>" +str(sum) + ' CHF valent ' + str(sum*taux[currency])

@app.route("/profile/<pseudo>")
def profile(pseudo):
    db = get_db()
    cursor = db.execute("SELECT * FROM users WHERE pseudo = ?", (pseudo,))
    user = cursor.fetchone()
    if user is None:
        abort(404)
    return render_template("profile.html.mako", pseudo=pseudo, user=user)

@app.route("/welcome")
def welcome():
    logged_user = load_connected_user()
    db = get_db()
    cursor = db.execute("SELECT pseudo FROM users ORDER BY random() LIMIT 1")
    user = cursor.fetchone()
    return render_template("welcome.html.mako", magic_number=randint(1, 5000), user=user, logged_user=logged_user)

@app.route("/users")
def users():
    db = get_db()
    cursor = db.execute("SELECT pseudo FROM users")
    users = cursor.fetchall()
    return render_template("users.html.mako", users=users)

def today():
    # Pour plus d'information sur la fonction strftime, voir:
    #     https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior
    return datetime.today().strftime("%Y-%m-%d")


class ValidationError(ValueError):
    """Error in users provided values."""
    pass


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "GET":
        return render_template("register.html.mako", error=None)
    elif request.method == "POST":
        db = get_db()
        try:
            if request.form["password"] != request.form["confirm_password"]:
                raise ValidationError("Mot de passe mal confirmé!")
            db.execute(
                """
                INSERT INTO users (pseudo, password, created_at)
                VALUES (?, ?, ?);
                """,
                (request.form["pseudo"], request.form["password"], today()))
            db.commit()
            return redirect(url_for("welcome"), code=303)
        except sqlite3.IntegrityError as e:
            return render_template("register.html.mako", error='Nom d\'utilisateur déjà pris')
        except ValidationError as e:
            return render_template("register.html.mako", error=str(e))
        finally :
            db.rollback()

@app.route("/login", methods=["GET", "POST"])
def login():
    if "user_id" in session:
        return redirect(url_for('welcome'))
    if request.method == "GET":
        return render_template("login.html.mako", error=None)
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
            return render_template("login.html.mako", error=str(e))

@app.route("/logout")
def logout():
    session.clear()
    return render_template("logout.html.mako")

# Démarre l'application en mode debug.
# Attention: ce doit être la dernière instruction du script !!!
app.run(debug=True)
