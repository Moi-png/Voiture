<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Formulaire d'inscription</title>
    </head>
    <script>
        function redirectAfterSubmit(event) {
            event.preventDefault();
            alert("Vous êtes connecté !");
            window.location.href = "${url_for('welcome')}";
        }
    </script>
    <body class="center">
        <div class="top-text">
            <br>
            <p>
                Pour vous connecter, suivez <a href="${url_for('login')}">ce lien</a>
            </p>
            <br>
        </div>
        <form onsubmit="redirectAfterSubmit(event)">
            <div class="form-example">
                <label for="name">Pseudo : </label>
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
                <input type="password" id="pass" name="password" minlength="8" +required />
            </div>
            <br>
            <div class="form-example">
                <input type="submit" value="S'inscrire"/>
            </div>
        </form>
    </body>
</html>

