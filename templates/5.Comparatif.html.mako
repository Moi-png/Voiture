<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Comparateur de voitures</title>
    </head>
    <body>
        <p class="CL">
            <strong>${voiture1['nom']}</strong>
            <br><br>
            Énergie : ${voiture1['energie']}
            <br><br>
            Moteur :
            <span class="${'highlight' if int(voiture1['moteur']) > int(voiture2['moteur']) else ''}">
                ${voiture1['moteur']} cylindres
            </span>
            <br><br>
            Puissance :
            <span class="${'highlight' if int(voiture1['pmax']) > int(voiture2['pmax']) else ''}">
                ${voiture1['pmax']} ch
            </span>
            <br><br>
            Couple :
            <span class="${'highlight' if int(voiture1['mcouple']) > int(voiture2['mcouple']) else ''}">
                ${voiture1['mcouple']} Nm
            </span>
            <br><br>
            Boîte :
            <span class="${'highlight' if int(voiture1['boite']) > int(voiture2['boite']) else ''}">
                ${voiture1['boite']} vitesses
            </span>
            <br><br>
            Masse :
            <span class="${'highlight' if int(voiture1['massevide']) < int(voiture2['massevide']) else ''}">
                ${voiture1['massevide']} kg
            </span>
            <br><br>
            Vitesse :
            <span class="${'highlight' if int(voiture1['vmax']) > int(voiture2['vmax']) else ''}">
                ${voiture1['vmax']} km/h
            </span>
            <br><br>
            Longueur :
            <span class="${'highlight' if int(voiture1['longueur']) > int(voiture2['longueur']) else ''}">
                ${voiture1['longueur']} mm
            </span>
            <br><br>
            Largeur :
            <span class="${'highlight' if int(voiture1['largeur']) > int(voiture2['largeur']) else ''}">
                ${voiture1['largeur']} mm
            </span>
            <br><br>
            Hauteur :
            <span class="${'highlight' if int(voiture1['hauteur']) > int(voiture2['hauteur']) else ''}">
                ${voiture1['hauteur']} mm
            </span>
            <br><br>
            <img src="/${voiture1['lienimage']}" height="250">
        </p>
        <p class="CR">
            <strong>${voiture2['nom']}</strong>
            <br><br>
            Énergie : ${voiture2['energie']}
            <br><br>
            Moteur :
            <span class="${'highlight' if int(voiture2['moteur']) > int(voiture1['moteur']) else ''}">
                ${voiture2['moteur']} cylindres
            </span>
            <br><br>
            Puissance :
            <span class="${'highlight' if int(voiture2['pmax']) > int(voiture1['pmax']) else ''}">
                ${voiture2['pmax']} ch
            </span>
            <br><br>
            Couple :
            <span class="${'highlight' if int(voiture2['mcouple']) > int(voiture1['mcouple']) else ''}">
                ${voiture2['mcouple']} Nm
            </span>
            <br><br>
            Boîte :
            <span class="${'highlight' if int(voiture2['boite']) > int(voiture1['boite']) else ''}">
                ${voiture2['boite']} vitesses
            </span>
            <br><br>
            Masse :
            <span class="${'highlight' if int(voiture2['massevide']) < int(voiture1['massevide']) else ''}">
                ${voiture2['massevide']} kg
            </span>
            <br><br>
            Vitesse :
            <span class="${'highlight' if int(voiture2['vmax']) > int(voiture1['vmax']) else ''}">
                ${voiture2['vmax']} km/h
            </span>
            <br><br>
            Longueur :
            <span class="${'highlight' if int(voiture2['longueur']) > int(voiture1['longueur']) else ''}">
                ${voiture2['longueur']} mm
            </span>
            <br><br>
            Largeur :
            <span class="${'highlight' if int(voiture2['largeur']) > int(voiture1['largeur']) else ''}">
                ${voiture2['largeur']} mm
            </span>
            <br><br>
            Hauteur :
            <span class="${'highlight' if int(voiture2['hauteur']) > int(voiture1['hauteur']) else ''}">
                ${voiture2['hauteur']} mm
            </span>
            <br><br>
            <img src="/${voiture2['lienimage']}" height="250">
        </p>
        <a class="downC" href="${url_for('accueil')}">
            <img src="${url_for('static', filename='7accueil.png')}" alt="accueil" width="80" />
        </a>
        <a class="downCC" href="${url_for('comparatif')}"><img src="${url_for('static', filename='7vs.png')}" alt="plage" width="100" height=""></a>
    </body>
</html>