USE ScuolaDB;
GO

/* ============================================================
   ELIMINAZIONE TABELLE ESISTENTI
   ============================================================ */

DROP TABLE IF EXISTS Voti;
DROP TABLE IF EXISTS Lezioni;
DROP TABLE IF EXISTS DocentiCorso;
DROP TABLE IF EXISTS Iscrizioni;
DROP TABLE IF EXISTS Aule;
DROP TABLE IF EXISTS Docenti;
DROP TABLE IF EXISTS Corso;
DROP TABLE IF EXISTS Studenti;
DROP TABLE IF EXISTS Students;

/* ============================================================
   CREAZIONE TABELLE
   ============================================================ */

CREATE TABLE Studenti
(
    StudenteID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,
    DataNascita DATE NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Telefono VARCHAR(50) NOT NULL UNIQUE,
    CodiceFiscale CHAR(16) NOT NULL UNIQUE
);

CREATE TABLE Corso
(
    CorsoID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NomeCorso NVARCHAR(100) NOT NULL,
    Descrizione NVARCHAR(255) NULL,
    Crediti INT NOT NULL,
    Durata INT NOT NULL
);

CREATE TABLE Docenti
(
    DocenteID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Specializzazione NVARCHAR(50) NOT NULL
);

CREATE TABLE Aule
(
    AulaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NomeAula NVARCHAR(150) NOT NULL,
    Capacita INT NOT NULL
);

CREATE TABLE Iscrizioni
(
    IscrizioneID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    StudenteID INT NOT NULL,
    CorsoID INT NOT NULL,
    DataIscrizione DATE NOT NULL DEFAULT GETDATE(),
    Stato NVARCHAR(30) NOT NULL DEFAULT 'Attivo',

    FOREIGN KEY (StudenteID)
        REFERENCES Studenti(StudenteID),

    FOREIGN KEY (CorsoID)
        REFERENCES Corso(CorsoID),

    CONSTRAINT UQ_Iscrizione_Studente_Corso
        UNIQUE (StudenteID, CorsoID)
);

CREATE TABLE DocentiCorso
(
    DocenteCorsoID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    DocenteID INT NOT NULL,
    CorsoID INT NOT NULL,
    DataRegistrazione DATE NULL,
    DataAssegnazione DATE NULL,
    Ruolo NVARCHAR(50) NULL,

    FOREIGN KEY (DocenteID)
        REFERENCES Docenti(DocenteID),

    FOREIGN KEY (CorsoID)
        REFERENCES Corso(CorsoID),

    CONSTRAINT UQ_Docente_Corso
        UNIQUE (DocenteID, CorsoID)
);

CREATE TABLE Lezioni
(
    LezioneID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    CorsoID INT NOT NULL,
    AulaID INT NOT NULL,
    Titolo NVARCHAR(100) NOT NULL,
    Descrizione NVARCHAR(MAX) NULL,
    DataLezione DATE NOT NULL,
    OraInizio TIME NOT NULL,
    OraFine TIME NOT NULL,
    Durata INT NULL,

    FOREIGN KEY (CorsoID)
        REFERENCES Corso(CorsoID),

    FOREIGN KEY (AulaID)
        REFERENCES Aule(AulaID)
);

CREATE TABLE Voti
(
    VotoID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    StudenteID INT NOT NULL,
    CorsoID INT NOT NULL,
    Voto DECIMAL(4,1) NOT NULL,
    DataVoto DATE NOT NULL,
    Note NVARCHAR(255) NULL,
    Superato BIT NOT NULL,

    FOREIGN KEY (StudenteID)
        REFERENCES Studenti(StudenteID),

    FOREIGN KEY (CorsoID)
        REFERENCES Corso(CorsoID)
);