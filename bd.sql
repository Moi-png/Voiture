pragma encoding="UTF-8";

create table users (
  id integer primary key,
  email text unique not null,
  pseudo text unique not null,
  password text not null,
  FOREIGN KEY (voiture_id)
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