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
        <p>
            Vos voitures likées
            <br>
        </p>
        ##<p class="Centre">
          ##  <a href="${url_for('garage')}"><img src="../static/7LamborghiniGallardoD.jpg" alt="plage" width="" height="300"></img></a>
        ##</p>
        <div class="center">
        <h1>Profil de ${pseudo}</h1>
        <ul>
            <li>ID: ${user['id']}</li>
            <li>Pseudo: ${user['pseudo']}</li>
            <li>Email: ${user['email']}</li>
        </ul>
        </div>
    </body>
</html>