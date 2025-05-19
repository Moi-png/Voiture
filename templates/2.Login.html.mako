<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Formulaire de connection</title>
    </head>
    <body class="center">
        <div class="top-text">
            <br>
            <p>
                Pour vous inscrire, suivez <a href="${url_for('register')}">ce lien</a>
            </p>
            <br>
        </div>
        <form method="POST" action="">
            <div class="form-example">
                <label for="pseudo">Pseudo : </label>
                <input type="text" name="pseudo" id="pseudo" required />
            </div>
            <br>
            <div>
                <label for="pass">Mot de passe : </label>
                <input type="password" id="pass" name="password" minlength="8" required />
            </div>
            <div>
        % if error:
            <p style="color: red;">${error}</p>
        % endif
        </div>
            <br>
            <div class="form-example">
                <input type="submit" value="Se connecter"/>
            </div>
        </form>
    </body>
</html>