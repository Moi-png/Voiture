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
            <img src="${url_for('static', filename='7fgauche.png')}" width="50" alt="Voiture précédente" />
        </a>
        % endif
        % if next_id:
        <a class="Droite" href="${url_for('garage', vid=next_id, ordre=ordre_str)}">
            <img src="${url_for('static', filename='7fdroit.png')}" width="50" alt="Voiture suivante" />
        </a>
        % endif
        <form method="POST">
            <input type="hidden" name="action" value="signal" />
            % if is_signaled:
            <input type="image" class="HGauche" id="signalButton"
                src="${url_for('static', filename='7croixr.png')}"
                width="50" height="50" alt="Signalement" />
            % else :
            <input type="image" class="HGauche" id="signalButton"
                src="${url_for('static', filename='7croixb.png')}"
                width="50" height="50" alt="Signalement" />
            % endif
        </form>
        <p class="HHGauche">${signal_count}</p>
        <a class="Centre" href="${url_for('profile')}">
                % if user['photo']:
                    <div class="Centre">
                        <img src="/${user['photo']}" alt="Photo de profil" width="50"/>
                    </div>
                % else:
                    <div class="Centre">
                        <img src="${url_for('static', filename='7DefaultPhoto.jpg')}" alt="Photo de profil par défaut" width="50" />
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
            Moteur : ${voiture['moteur']} cylindres
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
            % if is_liked:
            <input type="image" class="downL" id="heartButton"
                src="${url_for('static', filename='7likeP.png')}"
                width="50" height="50" alt="Like" />
            % else :
            <input type="image" class="downL" id="heartButton"
                src="${url_for('static', filename='7likeV.png')}"
                width="50" height="50" alt="Like" />
            % endif
        </form>
        <p class="downLL">${like_count}</p>
        <a class="downR" href="${url_for('ajout')}">
            <img src="${url_for('static', filename='7+.png')}" alt="ajout" width="50" height="50" />
        </a>
        <a class="downC" href="${url_for('acceuil')}">
            <img src="${url_for('static', filename='7ACCEUIL.png')}" alt="accueil" width="80" />
        </a>
    </h5>
</body>
</html>