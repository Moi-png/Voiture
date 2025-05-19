pragma encoding="UTF-8";

create table users (
  id integer primary key,
  email text not null,
  pseudo text not null,
  password text not null,
  photo text default null
);
create table voiture (
    id integer primary key,
    hauteur integer not null,
    largeur integer not null,
    longueur integer not null,
    nom text unique not null,
    pmax integer not null,
    mcouple integer not null,
    transmission integer not null,
    boite integer not null,
    moteur integer not null,
    posmoteur text not null,
    energie text not null,
    vmax integer not null,
    massevide integer not null,
    marque text ,
    lienimage text not null
);
create table likes (
  id integer primary key,
  user integer not null,
  voiture integer not null
);
create table signal (
  id integer primary key,
  user integer not null,
  voiture integer not null
);

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS voiture;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS signal;



