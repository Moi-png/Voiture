<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Votre compte</title>
    </head>
    <body>
        <a class="Gauche" href="${url_for('acceuil')}"> Revenir à la page d'accueil </a>    <a class="Droite" href="${url_for('garage')}"> Retour au catalogue </a>
        <div class="center">
            <ul class="profil">
                <li class="titre">Profil de ${pseudo}</li>
                <li><strong>Pseudo :</strong> ${user['pseudo']}</li>
                <li><strong>Email :</strong> ${user['email']}</li>
            </ul>
        </div>
    </body>
</html>