<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../static/style.css">
        <meta name="author" content="Moi-png, ELPHILA">
        <title>Ajouter une voiture</title>
    </head>
    <body>
        <a href="${url_for('garage', vid='random')}"> Revenir au catalogue </a>
        <br>
        <form method="POST" action="${url_for('ajout')}" enctype="multipart/form-data">
            <br><br>
            <div class="form-example">
                <label for="photo">Image de la voiture :</label>
                <input class="field" type="file" name="photo" accept="image/*" id="lienimage" />
            </div>
            <br><br>
            <div class="form-example">
                <label for="nom">Nom de la voiture :</label>
                <input type="text" name="nom" id="nom" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="marque">Marque de la voiture :</label>
                <input type="text" name="marque" id="marque" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="energie">Énergie :</label>
                <input type="text" name="energie" id="energie" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="moteur">Moteur :</label>
                <input type="text" name="moteur" id="moteur" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="posmoteur">Position du moteur :</label>
                <input type="text" name="posmoteur" id="posmoteur" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="cylindre">Cylindrée :</label>
                <input type="text" name="cylindre" id="cylindre" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="pmax">Puissance maximale :</label>
                <input type="text" name="pmax" id="pmax" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="mcouple">Couple maximal :</label>
                <input type="text" name="mcouple" id="mcouple" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="transmission">Transmission :</label>
                <input type="text" name="transmission" id="transmission" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="boite">Boîte de vitesse :</label>
                <input type="text" name="boite" id="boite" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="massevide">Masse à vide :</label>
                <input type="text" name="massevide" id="massevide" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="vmax">Vitesse maximale :</label>
                <input type="text" name="vmax" id="vmax" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="longueur">Longueur :</label>
                <input type="text" name="longueur" id="longueur" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="largeur">Largeur :</label>
                <input type="text" name="largeur" id="largeur" required />
            </div>
            <br><br>
            <div class="form-example">
                <label for="hauteur">Hauteur :</label>
                <input type="text" name="hauteur" id="hauteur" required />
            </div>
            <br><br>
            <div class="form-example">
                <input type="submit" value="Publier la voiture"/>
            </div>
        </form>
    </body>
</html>