<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Need for stats</title>
    </head>
    <style>
        body {
            background-image: url("${url_for('static', filename='7dbackindex.jpg')}");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: all;
            background-color: black;
        }
    </style>
    <body>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <h2>
            <a href="${url_for('register')}">S'inscrire</a>
        </h2>
        <h2>
            <a href="${url_for('login')}">Se connecter</a>
        </h2>
    </body>
</html>