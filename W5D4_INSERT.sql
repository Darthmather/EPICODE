-- Popolamento della tabella Conducente
INSERT INTO Conducente (ID_Conducente, Nome, Cognome, AnnoNascita, ID_Patente, Stato)
VALUES
(1, 'Mario', 'Rossi', 1985, 12345, 'illeso'),
(2, 'Giulia', 'Verdi', 1990, NULL, 'ferito'),
(3, 'Luca', 'Bianchi', 1978, 67890, 'deceduto'),
(4, 'Anna', 'Neri', 2000, 54321, 'ferito');

-- Popolamento della tabella Veicolo
INSERT INTO Veicolo (Targa, Tipo, Marca_Modello, Anno_immatricolazione, ID_Conducente)
VALUES
('AB123CD', 'auto', 'Fiat Panda', 2015, 1),
('EF456GH', 'moto', 'Yamaha YZF', 2018, 2),
('IJ789KL', 'camion', 'Mercedes Actros', 2010, 3),
('MN012OP', 'bici', 'Bianchi', 2021, 4);

-- Popolamento della tabella Autorità
INSERT INTO Autorità (ID_Autorità, Tipo, Contatto)
VALUES
(1, 'Polizia', 'polizia@example.com'),
(2, 'Carabinieri', 'carabinieri@example.com'),
(3, 'Vigili urbani', 'vigili@example.com');

-- Popolamento della tabella Infrazione
INSERT INTO Infrazione (ID_Infrazione, Tipo, Gravità)
VALUES
(1, 'eccesso di velocità', 'alta'),
(2, 'guida in stato di ebbrezza', 'grave'),
(3, 'mancata precedenza', 'media');

-- Popolamento della tabella Incidente
INSERT INTO Incidente (ID_Incidente, Data, Ora, Località, Tipo_di_strada, Condizioni_meteo, Targa, ID_Autorità, ID_Infrazione)
VALUES
(1, '2025-12-01', '14:30:00', 'Via Roma, Milano', 'urbana', 'sereno', 'AB123CD', 1, 1),
(2, '2025-12-02', '09:15:00', 'Corso Buenos Aires, Milano', 'urbana', 'nebbia', 'EF456GH', 2, 2),
(3, '2025-12-03', '17:00:00', 'Autostrada A1, Firenze', 'autostrada', 'pioggia', 'IJ789KL', 3, 3),
(4, '2025-12-04', '12:00:00', 'Via Verde, Roma', 'extraurbana', 'sereno', 'MN012OP', 1, NULL);

-- Popolamento della tabella Incidente_Veicolo
INSERT INTO Incidente_Veicolo (ID_Incidente, Targa)
VALUES
(1, 'AB123CD'),
(2, 'EF456GH'),
(2, 'AB123CD'), -- Incidente 2 coinvolge anche l'auto di Mario Rossi
(3, 'IJ789KL'),
(4, 'MN012OP');