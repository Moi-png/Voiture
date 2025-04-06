<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Page d'accueil</title>
    </head>
    <body>
        <h4>
            <a class="Droite" href="${url_for('logout')}"> Déconnection </a>
            <a class="Gauche" href="${url_for('profile')}"><img src="../static/7DefaultPhoto.jpg" alt="plage" width="80" height="80"></img></a>
        </h4>
        <br>
        <br>
        <br>
        <a href="${url_for('comparatif')}"><img src="../static/7vs.png" alt="plage" width="280" height="180"></img></a>
        <br>
        <br>
        <br>
        <a href="${url_for('garage')}"><img src="../static/7garage.png" alt="plage" width="280" height="210"></img></a>
        <br>
        <br>
        <br>
        <br>
        <a href="${url_for('contact')}"><img src="../static/7phone.png" alt="plage" width="80" height="80"></img><img src="../static/7mail.png" alt="plage" width="75" height="75"></img></a></li>
    </body>
</html>