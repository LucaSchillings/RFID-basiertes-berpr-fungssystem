-- Benutzer
INSERT INTO Benutzer (Benutzername, Passwort, Email, RFID) VALUES 
('LucaSchillings', 'Passwort', 'SchillingsL611@sus-am-bktm.de','D4 BF 33 60'),
('Benutzer2', 'Passwort2', 'benutzer2@example.com',''),
('Benutzer3', 'Passwort3', 'benutzer3@example.com','');

-- Räume
INSERT INTO Räume (RaumID, Raumname, Kapazität, Ausstattung) VALUES 
(108,'Raum 108', 20, 'Rechner, Monitor,Peripherie'),
(109,'Raum 109', 0, 'Access Point, TV'),
(110,'Raum 110', 1, 'Rechner, Monitor, Peripherie'),
(111,'Raum 111', 1, 'Rechner, Monitor,Peripherie'),
(112,'Raum 112', 0, 'Access Point, TV'),
(113,'Raum 113', 1, 'Rechner, Monitor, Peripherie'),
(114,'Raum 114', 1, 'Rechner, Monitor,Peripherie');

-- Arbeitsplätze
INSERT INTO Arbeitsplätze (ArbeitsplatzBez, Standort, Ausstattung, RaumID) VALUES 
-- Raum 108
('AP01','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP02','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP03','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP04','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP05','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP06','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP07','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP08','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP09','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP10','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP11','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP12','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP13','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP14','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP15','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP16','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP17','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP18','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP19','Raum108', 'Rechner, Monitor,Peripherie',108),
('AP20','Raum108', 'Rechner, Monitor,Peripherie',108),

-- Raum 110
('AP01','Raum110', 'Rechner, Monitor,Peripherie',110),
-- Raum 111
('AP01','Raum111', 'Rechner, Monitor,Peripherie',111),
--Raum 113
('AP01','Raum112', 'Rechner, Monitor,Peripherie',112);


-- Buchung
INSERT INTO Buchung (BenutzerID, ArbeitsplatzID, Datum, Startzeit, Endzeit) VALUES 
(1, 2, '2023-11-25', '09:00:00', '12:00:00'),
(1, 3, '2023-11-26', '14:00:00', '17:00:00'),
(1, 4, '2023-11-27', '10:00:00', '13:00:00');

-- Rechnungen
INSERT INTO Rechnungen (Kosten, Rechnungsdatum, BuchungsID) VALUES 
(50.00, '2023-11-25', 5),
(30.00, '2023-11-26', 6),
(45.00, '2023-11-27', 7);

-- Admin
INSERT INTO Admin (Benutzername, Passwort) VALUES 
('Admin', 'Passwort');
