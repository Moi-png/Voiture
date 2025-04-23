pragma encoding="UTF-8";

create table users (
  id integer primary key,
  email text not null,
  pseudo text not null,
  password text not null
);


create table voiture (
    id integer primary key,
    signal integer not null,
    likes integer not null,
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
    energie text not null,
    vmax integer not null,
    massevide integer not null,
    marque text not null,
    lienimage text not null
);



INSERT INTO voiture (
    signal, likes, hauteur, largeur, longueur, nom, pmax, cylindre, mcouple,
    transmission, boite, moteur, posmoteur, energie, vmax, massevide, marque, lienimage
) VALUES (
    1, 0, 1165, 1900, 4300, 'Lamborghini Gallardo', 560, 10, 540,
    4, 6, 1, 'centrale', 'essence', 325, 1410, 'Lamborghini', 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Lamborghini_Gallardo_LP560-4.jpg'
);

INSERT INTO voiture (
    signal, likes, hauteur, largeur, longueur, nom, pmax, cylindre, mcouple,
    transmission, boite, moteur, posmoteur, energie, vmax, massevide, marque, lienimage
) VALUES (
    1, 0, 1136, 2030, 4797, 'Lamborghini Aventador', 770, 12, 720,
    4, 7, 1, 'centrale', 'essence', 350, 1575, 'Lamborghini', 'https://cdn.motor1.com/images/mgl/4JyZA/s1/lamborghini-aventador-lp-780-4-ultimae.jpg'
);


DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS voiture;



