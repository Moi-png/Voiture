<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Statistiques d'une voiture : Lamborghini Gallardo</title>
    </head>
    <body>
        <h4>
            <a class="Droite" href="${url_for('garagee')}"><img src="../static/7fdroit.png" alt="plage" width="80" height="80"></img></a>
            <a class="Gauche" href="${url_for('garagee')}"><img src="../static/7fgauche.png" alt="plage" width="80" height="80"></img></a>
            <a class="Centre" href="${url_for('profile')}"><img src="../static/7DefaultPhoto.jpg" alt="plage" width="80" height="80"></img></a>
        </h4>
        <p class="center-voiture" class="Gauche">
            Lamborghini Gallardo
            <br>
            <br>
            Énergie : essence
            <br><br>
            Moteur : V10, 40 soupapes
            <br><br>
            Position du moteur : Centrale arrière
            <br><br>
            Puissance maximale : De 500 à 570 ch
            <br><br>
            Couple maximal : De 500 à 540 N m
            <br><br>
            Transmission : intégrale
            <br><br>
            Boîte de vitesse : Manuelle ou automatique 6 vitesses
            <br><br>
            Masse à vide : De 1330 à 1430 kg
            <br><br>
            Vitesse maximale : 315 km/h
            <br><br>
            Accélération de 0 à 100 km/h : 3,8 s
            <br><br>
            Longueur : 4300 mm
            <br><br>
            Largeur	: 1900 mm
            <br><br>
            Hauteur	: 1165 mm
        </p>
        <p class="ID">
            <img src="../static/7LamborghiniGallardo.jpg" alt="plage" width="" height="500"></img>
        </p>
        <h5>
            <img class ="downL" id="heartButton" src="../static/7likeV.png" alt="coeur blanc" width="100" height="100" onclick="this.src = this.src.includes('../static/7likeV.png') ? '../static/7likeP.png' : '../static/7likeV.png'"></img>
            <a class ="downR" href="${url_for('ajout')}"><img src="../static/7+.png" alt="plage" width="100" height="100"></img></a>
            <a class ="downC" href="${url_for('acceuil')}"><img src="../static/7ACCEUIL.png" alt="plage" width="100" height=""></img></a>
        </h5>
    </body>
</html>