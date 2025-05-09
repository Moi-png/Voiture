<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Formulaire d'inscription</title>
    </head>
    <body class="center">
        <div class="top-text">
            <br>
            <p>
                Pour vous connecter, suivez <a href="${url_for('login')}">ce lien</a>
            </p>
            <br>
        </div>
        <form method="POST" enctype="multipart/form-data">
            <label for="pseudo">Pseudo :</label>
            <input type="text" name="pseudo" required />

            <label for="email">Email :</label>
            <input type="email" name="email" required />

            <label for="password">Mot de passe :</label>
            <input type="password" name="password" required />

            <label for="confirm_password">Confirmer :</label>
            <input type="password" name="confirm_password" required />

            <label for="photo">Photo de profil :</label>
            <input type="file" name="photo" accept="image/*" />
            <div>
            % if error is not None :
            <p style="color: red">${error}</p>
            % endif
            </div>
            <br>
            <div class="form-example">
                <input class="field" type="submit" value="S'inscrire"/>
            </div>
        </form>
    </body>
</html>

