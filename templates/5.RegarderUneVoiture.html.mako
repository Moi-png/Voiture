<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Statistiques d'une voiture : ${voiture['nom']}</title>
    </head>
    <body>
        <h4>
            <a class="Droite" href="${url_for('garage')}"><img src="../static/7fdroit.png" alt="plage" width="50" height=""></img></a>
            <img class="Gauche" id="signalButton" src="../static/7croixb.png" width="50" height="50"
            onclick="this.src=this.src.includes('7croixb')?'../static/7croixr.png':'../static/7croixb.png'">
            <a class="Centre" href="${url_for('profile')}"><img src="../static/7DefaultPhoto.jpg" alt="plage" width="50" height=""></img></a>
        </h4>
        <p class="Gauche">
            <br><br><br><br>
            ${voiture['nom']}
            <br><br>
            Énergie : ${voiture['energie']}
            <br><br>
            Moteur : ${voiture['cylindre']} cylindres
            <br><br>
            Position : ${voiture['posmoteur']}
            <br><br>
            Puissance : ${voiture['pmax']} ch
            <br><br>
            Couple : ${voiture['mcouple']} Nm
            <br><br>
            Transmission : ${voiture['transmission']}
            <br><br>
            Boîte : ${voiture['boite']} vitesses
            <br><br>
            Masse : ${voiture['massevide']} kg
            <br><br>
            Vitesse : ${voiture['vmax']} km/h
            <br><br>
            Longueur : ${voiture['longueur']} mm
            <br><br>
            Largeur : ${voiture['largeur']} mm
            <br><br>
            Hauteur : ${voiture['hauteur']} mm
            <br><br>
        </p>
        <p class="ID">
            <img src="${voiture['lienimage']}" height="500">
        </p>
        <h5>
        <button type=button>
        <input type="image" class="downL" id="heartButton" src="../static/7likeV.png" width="50" height="50"
            onclick="this.src=this.src.includes('7likeV')?'../static/7likeP.png':'../static/7likeV.png'">
        </button>
            ##<img class="downL" id="heartButton" src="../static/7likeV.png" width="50" height="50"
            ##onclick="this.src=this.src.includes('7likeV')?'../static/7likeP.png':'../static/7likeV.png'">
            <a class="downR" href="${url_for('ajout')}"><img src="../static/7+.png" alt="plage" width="50" height="50"></img></a>
            <a class="downC" href="${url_for('acceuil')}"><img src="../static/7ACCEUIL.png" alt="plage" width="80" height=""></img></a>
        </h5>
    </body>
</html>
