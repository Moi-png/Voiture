pragma encoding="UTF-8";

create table users (
  id integer primary key,
  email text not null,
  pseudo text not null,
  password text not null
);


create table voiture (
    id integer primary key,
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

INSERT INTO voiture (hauteur, largeur, longueur, nom, pmax, cylindre, mcouple, transmission, boite, moteur, posmoteur, energie, vmax, massevide, marque, lienimage) VALUES
(1433, 1903, 4794, 'BMW M3 G80', 480, 6, 550, 4, 6, 1, 'avant', 'essence', 250, 1705, 'BMW', 'https://hips.hearstapps.com/hmg-prod/images/2025-bmw-m3-110-66562ddceaf59.jpg?crop=0.824xw:0.618xh;0.0737xw,0.274xh&resize=2048:*'),

(1460, 1950, 4995, 'Audi RS6 Avant C8', 600, 8, 800, 4, 8, 1, 'avant', 'essence', 305, 2150, 'Audi', 'https://i0.wp.com/pdlv.fr/wp-content/uploads/2022/03/fiche-technique-audi-rs-6-2020.jpg?resize=780%2C470&ssl=1'),

(1297, 1852, 4499, 'Porsche 911 Carrera (992)', 385, 6, 450, 4, 8, 1, 'arrière', 'essence', 293, 1505, 'Porsche', 'https://upload.wikimedia.org/wikipedia/commons/3/38/Porsche_992_Carrera_S_coupe_IMG_5832.jpg'),

(1213, 1952, 4568, 'Ferrari 488 GTB', 670, 8, 760, 4, 7, 1, 'centrale', 'essence', 330, 1370, 'Ferrari', 'https://www.largus.fr/images/photos/rsi/_G_JPG/Voitures/FERRARI/488_GTB/I/Ph1/Coupe_2_portes/TROISQUARTAVANT1.jpg'),

(1196, 1930, 4544, 'McLaren 720S', 720, 8, 770, 4, 7, 1, 'centrale', 'essence', 341, 1283, 'McLaren', 'https://upload.wikimedia.org/wikipedia/commons/4/43/McLaren_720S_IMG_0933.jpg'),

(1284, 1940, 4569, 'Mercedes-AMG GT S', 510, 8, 650, 4, 7, 1, 'avant', 'essence', 310, 1645, 'Mercedes-Benz', 'https://groupe-leuba.ch/wp-content/uploads/2024/02/meredes-amg-gt-coupe-9.jpg'),

(1379, 1895, 4694, 'Nissan GT-R R35', 570, 6, 637, 4, 6, 1, 'avant', 'essence', 315, 1740, 'Nissan', 'https://www-europe.nissan-cdn.net/content/dam/Nissan/fr/vehicles/GT-R%202016/refonte-2023/header.jpg'),

(1234, 1934, 4630, 'Chevrolet Corvette C8', 502, 8, 637, 4, 8, 1, 'centrale', 'essence', 312, 1530, 'Chevrolet', 'https://www.autosprint.ch/wp-content/uploads/2024/07/Chevrolet-Corvette-ZR1_6_autosprint.ch_.jpg'),

(1381, 1916, 4784, 'Ford Mustang GT', 450, 8, 529, 4, 6, 1, 'avant', 'essence', 250, 1680, 'Ford', 'https://media.ed.edmunds-media.com/ford/mustang/2025/oem/2025_ford_mustang_coupe_dark-horse_fq_oem_1_1600.jpg'),

(1294, 1854, 4380, 'Toyota GR Supra (A90)', 340, 6, 500, 4, 8, 1, 'avant', 'essence', 250, 1495, 'Toyota', 'https://upload.wikimedia.org/wikipedia/commons/0/06/Toyota_Supra_GR_Genf_2019_1Y7A5645.jpg');

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS voiture;



