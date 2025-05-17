<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Choisir une voiture</title>
</head>
<body>
    <h1>Choisis une voiture pour commencer</h1>
    <ul>
        % for v in voitures:
        <li>
            <form method="POST" action="/garage/start">
                <input type="hidden" name="voiture_id" value="${v['id']}"/>
                <button type="submit">
                    ${v['nom']} <img src="/${v['lienimage']}" width="150"/>
                </button>
            </form>
        </li>
        % endfor
    </ul>
</body>
</html>