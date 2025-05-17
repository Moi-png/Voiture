<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
    <meta name="author" content="Moi-png, ELPHILA">
    <title>Statistiques d'une voiture : ${voiture['nom']}</title>
</head>
<body>
    <h4>
        % if prev_id:
        <a class="Droitee" href="${url_for('garage', vid=prev_id, ordre=ordre_str)}">
            <img src="../static/7fgauche.png" width="50" alt="Voiture précédente" />
        </a>
        % endif
        % if next_id:
        <a class="Droite" href="${url_for('garage', vid=next_id, ordre=ordre_str)}">
            <img src="../static/7fdroit.png" width="50" alt="Voiture suivante" />
        </a>
        % endif
        <form method="POST">
            <input type="hidden" name="action" value="signal" />
            <input type="image" class="HGauche" id="signalButton"
                src="../static/${'7croixr.png' if is_signaled else '7croixb.png'}"
                width="50" height="50" alt="Signalement" />
        </form>
        <p class="HHGauche">${signal_count}</p>
        <a class="Centre" href="${url_for('profile')}">
                % if user['photo']:
                    <div class="Centre">
                        <img src="/${user['photo']}" alt="Photo de profil" width="50"/>
                    </div>
                % else:
                    <div class="Centre">
                        <img src="../static/7DefaultPhoto.jpg" alt="Photo de profil par défaut" width="50" />
                    </div>
                % endif
        </a>
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
        <img src="/${voiture['lienimage']}" height="500" />
    </p>
    <h5>
        <form method="POST">
            <input type="hidden" name="action" value="like" />
            <input type="image" class="downL" id="heartButton"
                src="../static/${'7likeP.png' if is_liked else '7likeV.png'}"
                width="50" height="50" alt="Like" />
        </form>
        <p class="downLL">${like_count}</p>
        <a class="downR" href="${url_for('ajout')}">
            <img src="../static/7+.png" alt="ajout" width="50" height="50" />
        </a>
        <a class="downC" href="${url_for('acceuil')}">
            <img src="../static/7ACCEUIL.png" alt="accueil" width="80" />
        </a>
    </h5>
</body>
</html>