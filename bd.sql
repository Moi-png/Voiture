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

INSERT INTO voiture (hauteur, largeur, longueur, nom, pmax, mcouple, transmission, boite, moteur, posmoteur, energie, vmax, massevide, marque, lienimage) VALUES
(1136, 2030, 4780, 'Lamborghini Aventador', 770, 720, 4, 7, 12, 'centrale arrière', 'essence', 350, 1575, 'Lamborghini', 'static/uploads/aventador.jpg'),

(1433, 1903, 4794, 'BMW M3 G80', 480, 550, 4, 6, 6, 'avant', 'essence', 250, 1705, 'BMW', 'static/uploads/m3g80.jpg'),

(1460, 1950, 4995, 'Audi RS6 Avant C8', 600, 800, 4, 8, 8, 'avant', 'essence', 305, 2150, 'Audi', 'static/uploads/rs6.jpg'),

(1297, 1852, 4499, 'Porsche 911 Carrera (992)', 385, 450, 4, 8, 6, 'arrière', 'essence', 293, 1505, 'Porsche', 'static/uploads/911carrera.jpg'),

(1196, 1930, 4544, 'McLaren 720S', 720, 770, 4, 7, 8, 'centrale', 'essence', 341, 1283, 'McLaren', 'static/uploads/mclaren.jpg'),

(1284, 1940, 4569, 'Mercedes-AMG GT S', 510, 650, 4, 7, 8, 'avant', 'essence', 310, 1645, 'Mercedes-Benz', 'static/uploads/amg.jpg'),

(1379, 1895, 4694, 'Nissan GT-R R35', 570, 637, 4, 6, 6, 'avant', 'essence', 315, 1740, 'Nissan', 'static/uploads/nissan.jpg'),

(1234, 1934, 4630, 'Chevrolet Corvette C8', 502, 637, 4, 8, 8, 'centrale', 'essence', 312, 1530, 'Chevrolet', 'static/uploads/corvette.jpg'),

(1381, 1916, 4784, 'Ford Mustang GT', 450, 529, 4, 6, 8, 'avant', 'essence', 250, 1680, 'Ford', 'static/uploads/mustang.jpg'),

(1294, 1854, 4380, 'Toyota GR Supra (A90)', 340, 500, 4, 8, 6, 'avant', 'essence', 250, 1495, 'Toyota', 'static/uploads/toyota.jpg'),

(1445, 1964, 4710, 'Audi RS6 Avant', 600, 800, 4, 8, 8, 'avant', 'essence', 305, 2075, 'Audi', 'static/uploads/rs66.jpg'),

(1381, 1992, 4689, 'BMW M4', 510, 650, 3, 6, 6, 'avant', 'essence', 290, 1725, 'BMW', 'static/uploads/m4.jpg'),

(1411, 1850, 4570, 'Alfa Romeo Giulia Quadrifoglio', 510, 600, 3, 6, 6, 'avant', 'essence', 307, 1580, 'Alfa Romeo', 'static/uploads/giulia.jpg'),

(1296, 1877, 4379, 'Porsche 911 Turbo S', 650, 800, 4, 8, 6, 'arrière', 'essence', 330, 1640, 'Porsche', 'static/uploads/911.jpg'),

(1457, 1845, 4665, 'Mercedes-AMG C63 S', 510, 700, 3, 9, 8, 'avant', 'essence', 290, 1710, 'Mercedes-Benz', 'static/uploads/c63.jpg'),

(1280, 1800, 4390, 'Ferrari 488 GTB', 670, 760, 3, 7, 8, 'centrale arrière', 'essence', 330, 1475, 'Ferrari', 'static/uploads/ferrari488.jpg'),

(1450, 1830, 4710, 'Tesla Model S Plaid', 1020, 1420, 4, 1, 0, 'avant', 'électrique', 322, 2162, 'Tesla', 'static/uploads/tesla.jpg'),

(1461, 1801, 4799, 'Peugeot 508 PSE', 360, 520, 4, 8, 4, 'avant', 'hybride', 250, 1850, 'Peugeot', 'static/uploads/peugeot.jpg'),

(1205, 1871, 4411, 'Toyota GR Supra', 340, 500, 3, 8, 6, 'avant', 'essence', 250, 1495, 'Toyota', 'static/uploads/supra.jpg');

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS voiture;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS signal;



