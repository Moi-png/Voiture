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
        <a class="Droite" href="${url_for('logout')}">Déconnexion</a>
        <a class="Gauche" href="${url_for('profile')}">
                % if user['photo']:
                    <div class="HGauche">
                        <img src="/${user['photo']}" alt="Photo de profil" width="50"/>
                    </div>
                % else:
                    <div class="HGauche">
                        <img src="../static/7DefaultPhoto.jpg" alt="Photo de profil par défaut" width="50" />
                    </div>
                % endif
        </a>
    </h4>
    <br><br><br>
    <a href="${url_for('comparatif')}">
        <img src="../static/7vs.png" alt="comparatif" width="280" height="180" />
    </a>
    <br><br><br>
    <a href="${url_for('garage', vid='random')}">
        <img src="../static/7garage.png" alt="garage" width="280" height="210" />
    </a>
    <br><br><br><br>
    <a href="${url_for('contact')}">
        <img src="../static/7phone.png" alt="téléphone" width="80" height="80" />
        <img src="../static/7mail.png" alt="email" width="75" height="75" />
    </a>
</body>
</html>