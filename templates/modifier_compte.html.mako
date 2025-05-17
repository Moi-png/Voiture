<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
    <title>Modifier votre compte</title>
</head>
<body>
    <a class="Gauche" href="${url_for('acceuil')}">Revenir à la page d'accueil</a>
    <a class="Droite" href="${url_for('profile')}">Retour au profil</a>

    <div class="center">
        <form action="${url_for('comptec')}" method="POST" enctype="multipart/form-data">
            <label for="pseudo">Nouveau pseudo :</label>
            <input type="text" name="pseudo" value="${user['pseudo']}" required><br><br>

            <label for="email">Nouvel email :</label>
            <input type="email" name="email" value="${user['email']}" required><br><br>

            <label for="password">Nouveau mot de passe :</label>
            <input type="password" name="password"><br><br>

            <label for="photo" >Nouvelle photo de profil :</label>
            <input type="file" name="photo" ><br><br>

            <button type="submit">Enregistrer les modifications</button>
        </form>
    </div>
</body>
</html>
