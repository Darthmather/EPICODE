-- Creazione della tabella Conducente
CREATE TABLE Conducente (
    ID_Conducente INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    AnnoNascita INT,
    ID_Patente INT NULL,
    Stato ENUM('ferito', 'illeso', 'deceduto')
);

-- Creazione della tabella Veicolo
CREATE TABLE Veicolo (
    Targa VARCHAR(15) PRIMARY KEY,
    Tipo ENUM('auto', 'moto', 'camion', 'bici'),
    Marca_Modello VARCHAR(100),
    Anno_immatricolazione INT,
    ID_Conducente INT,
    FOREIGN KEY (ID_Conducente) REFERENCES Conducente(ID_Conducente) ON DELETE SET NULL
);

-- Creazione della tabella Autorità
CREATE TABLE Autorità (
    ID_Autorità INT PRIMARY KEY,
    Tipo ENUM('Polizia', 'Carabinieri', 'Vigili urbani'),
    Contatto VARCHAR(100)
);

-- Creazione della tabella Infrazione
CREATE TABLE Infrazione (
    ID_Infrazione INT PRIMARY KEY,
    Tipo ENUM('eccesso di velocità', 'guida in stato di ebbrezza', 'mancata precedenza'),
    Gravità VARCHAR(50)
);

-- Creazione della tabella Incidente
CREATE TABLE Incidente (
    ID_Incidente INT PRIMARY KEY,
    Data DATE,
    Ora TIME,
    Località VARCHAR(255),
    Tipo_di_strada ENUM('urbana', 'extraurbana', 'autostrada'),
    Condizioni_meteo VARCHAR(100),
    Targa VARCHAR(15),
    ID_Autorità INT,
    ID_Infrazione INT,
    FOREIGN KEY (Targa) REFERENCES Veicolo(Targa) ON DELETE CASCADE,
    FOREIGN KEY (ID_Autorità) REFERENCES Autorità(ID_Autorità),
    FOREIGN KEY (ID_Infrazione) REFERENCES Infrazione(ID_Infrazione)
);

-- Creazione della tabella Incidente_Veicolo per gestire la relazione molti-a-molti
CREATE TABLE Incidente_Veicolo (
    ID_Incidente INT,
    Targa VARCHAR(15),
    PRIMARY KEY (ID_Incidente, Targa),
    FOREIGN KEY (ID_Incidente) REFERENCES Incidente(ID_Incidente) ON DELETE CASCADE,
    FOREIGN KEY (Targa) REFERENCES Veicolo(Targa) ON DELETE CASCADE
);
