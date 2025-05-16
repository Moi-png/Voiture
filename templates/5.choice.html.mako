<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Choix de voitures</title>
    <link rel="stylesheet" type="text/css" href="${url_for('static', filename='style.css')}">
</head>
<body>
    <h2>Choisissez deux voitures à comparer :</h2>
    <form method="POST" action="${url_for('comparatif')}" >
        <div class="CR">
            <label for="voiture_gauche">Voiture de gauche :</label><br>
            <select name="voiture_gauche" required>
                % for v in voitures:
                    <option value="${v['id']}">${v['nom']}</option>
                % endfor
            </select>
        </div>
        <div class="CL">
            <label for="voiture_droite">Voiture de droite :</label><br>
            <select name="voiture_droite" required>
                % for v in voitures:
                    <option value="${v['id']}">${v['nom']}</option>
                % endfor
            </select>
        </div>
        <br><br>
        <button type="submit">Comparer</button>
    </form>
    <br>
    <a class="downC" href="${url_for('acceuil')}">
        <img src="../static/7ACCEUIL.png" alt="accueil" width="80" />
    </a>
</body>
</html>
