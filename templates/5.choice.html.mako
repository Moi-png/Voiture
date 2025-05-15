<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Choix de voitures</title>
    <link rel="stylesheet" type="text/css" href="../static/style.css">
</head>
<body>
    <h2>Choisissez deux voitures à comparer :</h2>
    <form method="POST" action="${url_for('comparatif')}">
        <div style="display: flex; justify-content: space-between; width: 60%;">
            <div>
                <label for="voiture_gauche">Voiture de gauche :</label><br>
                <select name="voiture_gauche" required>
                    % for v in voitures:
                        <option value="${v['id']}">${v['nom']}</option>
                    % endfor
                </select>
            </div>
            <div>
                <label for="voiture_droite">Voiture de droite :</label><br>
                <select name="voiture_droite" required>
                    % for v in voitures:
                        <option value="${v['id']}">${v['nom']}</option>
                    % endfor
                </select>
            </div>
        </div>
        <br><br>
        <button type="submit">Comparer</button>
    </form>
    <br>
    <a href="${url_for('acceuil')}">Revenir à la page d'accueil</a>
</body>
</html>
