<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
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
        <form onsubmit="redirectAfterSubmit(event)">
            <div class="form-example">
                <label for="name">Pseudo : </label>
                <input type="text" name="name" id="name" required />
            </div>
            <br>
            <div>
                <label for="pass">Mot de passe : </label>
                <input type="password" id="pass" name="password" minlength="8" +required />
            </div>
              <br>
            <div class="form-example">
                <input type="submit" value="Se connecter"/>
            </div>
        </form>
    </body>
</html>