<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Votre compte</title>
    </head>
    <body>
        <a class="Gauche" href="${url_for('accueil')}"><img src="${url_for('static', filename='7accueil.png')}" alt="accueil" width="80" /></a>    <a class="Droite" href="${url_for('garage', vid='random')}"> Retour au catalogue </a>
        <div class="center">
                % if user['photo']:
                    <div class="top">
                        <img src="/${user['photo']}" alt="Photo de profil" width="100" />
                    </div>
                % else:
                    <div class="top">
                        <img src="${url_for('static', filename='7DefaultPhoto.jpg')}" alt="Photo de profil par défaut" width="100" />
                    </div>
                % endif
            <ul>
                <li>Profil de ${pseudo}</li>
                <li><strong>Pseudo :</strong> ${user['pseudo']}</li>
                <li><strong>Email :</strong> ${user['email']}</li>
                <li>
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
        <a class="downC" href="${url_for('comptec')}">Modifier</a>
    </body>
</html>