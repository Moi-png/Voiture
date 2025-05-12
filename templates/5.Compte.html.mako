<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Votre compte</title>
    </head>
    <body>
        <a class="Gauche" href="${url_for('acceuil')}"> Revenir à la page d'accueil </a>    <a class="Droite" href="${url_for('garage', vid='random')}"> Retour au catalogue </a>
        <div class="center">
                % if user['photo']:
                    <div class="top">
                        <img src="/${user['photo']}" alt="Photo de profil" width="100" />
                    </div>
                % else:
                    <div class="top">
                        <img src="../static/7DefaultPhoto.jpg" alt="Photo de profil par défaut" width="100" />
                    </div>
                % endif
            <ul>
                <li>Profil de ${pseudo}</li>
                <li><strong>Pseudo :</strong> ${user['pseudo']}</li>
                <li><strong>Email :</strong> ${user['email']}</li>
                <li>
<!--                    <div>
                        <label for="photo">Photo de profil :</label>
                        <input class="field" type="file" name="photo" accept="image/*" />
                    </div>-->
                <li>Voitures likées :</li>
            % if liked_cars:
                    % for car in liked_cars:
                        <li>
                            <a href="${url_for('garage', vid=car['id'])}">
                                ${car['nom']}
                            </a>
                        </li>
                    % endfor
            % endif
        </div>
    </body>
</html>