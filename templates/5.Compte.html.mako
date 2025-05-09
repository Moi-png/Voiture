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
            <ul>
                <li>Profil de ${pseudo}</li>
                <li><strong>Pseudo :</strong> ${user['pseudo']}</li>
                <li><strong>Email :</strong> ${user['email']}</li>
                % if user['photo']:
                    <div class="center">
                        <img src="/${user['photo']}" alt="Photo de profil" width="150" style="border-radius: 50%;" />
                    </div>
                % else:
                    <div class="center">
                        <img src="../static/7DefaultPhoto.jpg" alt="Photo de profil par défaut" width="150" />
                    </div>
                % endif
            </ul>
            <h3>Voitures likées :</h3>
            % if liked_cars:
                <ul>
                    % for car in liked_cars:
                        <li>
                            <a href="${url_for('garage', vid=car['id'])}">
                                ${car['nom']}
                            </a>
                        </li>
                    % endfor
                </ul>
            % else:
                <p>Aucune voiture likée pour le moment.</p>
            % endif
        </div>
    </body>
</html>