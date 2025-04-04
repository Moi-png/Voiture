pragma encoding="UTF-8";

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL,
  pseudo TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
);

create table voiture (
    id integer primary key,
    signal integer not null,
    hauteur integer not null,
    largeur integer not null,
    longueur integer not null,
    nom text unique not null,
    pmax integer not null,
    cylindre integer not null,
    mcouple integer not null,
    transmission integer not null,
    boite integer not null,
    moteur integer not null,
    posmoteur text not null,
    energie integer not null,
    vmax integer not null,
    massevide integer not null,
    marque text not null,
    lienimage text not null
);

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS voiture;