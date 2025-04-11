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
            <a class="Droite" href="${url_for('garage')}"><img src="../static/7fdroit.png" alt="plage" width="80" height="80"></img></a>
            <a class="Gauche" href="${url_for('garage')}"><img src="../static/7fgauche.png" alt="plage" width="80" height="80"></img></a>
            <a class="Centre" href="${url_for('profile')}"><img src="../static/7DefaultPhoto.jpg" alt="plage" width="80" height="80"></img></a>
        </h4>
        <p class="center-voiture" class="Gauche">
            ${voiture['nom']}
            <br><br>
            Énergie : ${voiture['energie']}
            <br><br>
            Moteur : ${voiture['cylindre']} cylindres
            <br><br>
            Position du moteur : ${voiture['posmoteur']}
            <br><br>
            Puissance maximale : ${voiture['pmax']} ch
            <br><br>
            Couple maximal : ${voiture['mcouple']} N m
            <br><br>
            Transmission : ${voiture['transmission']}
            <br><br>
            Boîte de vitesse : ${voiture['boite']} vitesses
            <br><br>
            Masse à vide : ${voiture['massevide']} kg
            <br><br>
            Vitesse maximale : ${voiture['vmax']} km/h
            <br><br>
            Longueur : ${voiture['longueur']} mm
            <br><br>
            Largeur	: ${voiture['largeur']} mm
            <br><br>
            Hauteur	: ${voiture['hauteur']} mm
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