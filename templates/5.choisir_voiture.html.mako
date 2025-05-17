<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Choix de voitures</title>
    <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
</head>
<body>
    <h2>Choisissez une voiture à regarder :</h2>
    <form method="POST" action="${url_for('garage_start')}" class="centerrr">
        <div>
            <label for="voiture_id">Voiture :</label><br>
            <select name="voiture_id" id="voiture_id" required>
                % for v in voitures:
                    <option value="${v['id']}">${v['nom']}</option>
                % endfor
            </select>
        </div>
        <button class="centerr" type="submit">Regarder</button>
    </form>
    <br>
    <a class="downC" href="${url_for('acceuil')}">
        <img src="${url_for('static', filename='7ACCEUIL.png')}" alt="accueil" width="80" />
    </a>
</body>
</html>