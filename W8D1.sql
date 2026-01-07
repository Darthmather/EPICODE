/*Req #1.1*/
CREATE TABLE region (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Città VARCHAR(100) NOT NULL,
    Regione VARCHAR(100) NOT NULL,
    AreaGeografica VARCHAR(100) NOT NULL
);

/*Req #1.3*/
INSERT INTO region (Città, Regione, AreaGeografica) VALUES
('Milano', 'Lombardia', 'Nord'),
('Roma', 'Lazio', 'Centro'),
('Napoli', 'Campania', 'Sud');

/*Req #1.2*/
CREATE TABLE store (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    DataApertura DATE NOT NULL,
    IDRegion INT,
    FOREIGN KEY (IDRegion) REFERENCES Region(ID)
);

/*Req #1.3*/
INSERT INTO store (Nome, DataApertura, IDRegion) VALUES
('SegaDoes', '2021-12-12', 1),
('WhatNinten', '2022-05-20', 2),
('Dont', '2024-08-30', 3);

/*Req 1.4*/
/*Update data*/
START TRANSACTION;
	UPDATE store
	SET DataApertura = '2022-07-15'
	WHERE ID = 1;
COMMIT;

/*Creating data and then deleting rows*/
INSERT INTO region (Città, Regione, AreaGeografica) VALUES
('Lower Manhattan', 'New York', 'US');

INSERT INTO store (Nome, DataApertura, IDRegion) VALUES
('Remember Me', '2001-09-11', 4);

START TRANSACTION;
	DELETE FROM store
	WHERE ID = 4;
COMMIT; 

START TRANSACTION;
	DELETE FROM region
    WHERE ID = 4;
ROLLBACK;