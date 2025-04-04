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
        <form method="POST">
            <div class="form-example">
                <label for="pseudo">Pseudo : </label>
                <input type="text" name="pseudo" id="pseudo" required />
            </div>
            <br>
            <div class="form-example">
                <label for="email">Email : </label>
                <input type="email" name="email" id="email" required />
            </div>
            <br>
            <div>
                <label for="pass">Mot de passe (8 caractères minimum) : </label>
                <input type="password" id="pass" name="password" minlength="8" required />
            </div>
            <br>
            <div>
                <label for="confirm_pass">Confirmez le mot de passe : </label>
                <input type="password" id="confirm_pass" name="confirm_password" minlength="8" required />
            </div>
            <br>
            <div class="form-example">
                <input type="submit" value="S'inscrire"/>
            </div>
        </form>
    </body>
</html>
