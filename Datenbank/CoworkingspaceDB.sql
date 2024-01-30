DROP DATABASE IF EXISTS CoworkingspaceDB;
GO
CREATE DATABASE CoworkingspaceDB;
GO
USE CoworkingspaceDB;
GO

CREATE TABLE Benutzer(
    BenutzerID INT PRIMARY KEY IDENTITY,
    Benutzername varchar(255) NOT NULL,
    Passwort varchar(255) NOT NULL,
    Email varchar(255)NOT NULL,
    RFID varchar(255)
);

CREATE TABLE Räume(
    RaumID INT PRIMARY,
    Raumname varchar(255) NOT NULL,
    Kapazität INT NOT NULL,
    Ausstattung varchar(255)
);

CREATE TABLE Arbeitsplätze(
    ArbeitsplatzID INT PRIMARY KEY IDENTITY,
    ArbeitsplatzBez varchar(255) NOT NULL,
    Standort varchar(255) NOT NULL,
    Ausstattung varchar(255) NOT NULL
);

CREATE TABLE Buchung(
    BuchungsID INT PRIMARY KEY IDENTITY,
    Datum DATE NOT NULL,
    Startzeit TIME,
    Endzeit TIME
);

CREATE TABLE Rechnungen(
    RechnungsID INT PRIMARY KEY IDENTITY,
    Kosten MONEY NOT NULL,
    Rechnungsdatum DATE NOT NULL
);

CREATE TABLE Admin(
    AdminID INT PRIMARY KEY IDENTITY,
    Benutzername varchar(255) NOT NULL,
    Passwort varchar(255) NOT NULL
);

ALTER TABLE Arbeitsplätze ADD RaumID INT NOT NULL;
ALTER TABLE Arbeitsplätze
ADD CONSTRAINT RaumID
FOREIGN KEY (RaumID)
REFERENCES Räume(RaumID);

ALTER TABLE Buchung ADD BenutzerID INT NOT NULL;
ALTER TABLE Buchung
ADD CONSTRAINT BenutzerID
FOREIGN KEY (BenutzerID)
REFERENCES Benutzer(BenutzerID);

ALTER TABLE Buchung ADD ArbeitsplatzID INT NOT NULL;
ALTER TABLE Buchung
ADD CONSTRAINT ArbeitsplatzID
FOREIGN KEY (ArbeitsplatzID)
REFERENCES Arbeitsplätze(ArbeitsplatzID);

ALTER TABLE Rechnungen ADD BuchungsID INT NOT NULL;
ALTER TABLE Rechnungen
ADD CONSTRAINT BuchungsID
FOREIGN KEY (BuchungsID)
REFERENCES Buchung(BuchungsID);