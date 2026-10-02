USE ScuolaDB;
GO
 
  /* ============================================================
	 JOIN - INNER JOIN - LEFT/RIGHT JOIN - CROSS JOIN - FULL JOIN
	 ------------------------------------------------------------

	 SELECT	T1.Colonna1
			T1.Colonna2
			T2.Colonna1
			...
	 FROM Tabella1 AS T1
	 INNER JOIN Tabella2 AS T2
			ON Condizione (T1.ID = T2.ID)

    ============================================================ */

 -- ESEMPI + ESERCIZI (JOIN) --

SELECT * 
FROM Studenti AS S
INNER JOIN Iscrizioni AS I
	ON S.StudenteID = I.StudenteID;

--------------------------------------------------------

SELECT	S.Nome +  ' ' + S.Cognome AS [Nome Completo], 
		S.DataNascita AS [Data di Nascita], 
		S.CodiceFiscale AS [CF], 
		I.DataIscrizione AS [Data di iscrizione],
		C.NomeCorso + ' - ' + C.Descrizione AS [Nome e del Descrizione del Corso],
		C.Durata AS [Durata in ore]
FROM Studenti AS S
INNER JOIN Iscrizioni AS I
	ON	S.StudenteID = I.StudenteID
INNER JOIN Corso AS C
	ON I.CorsoID = C.CorsoID
WHERE S.DataNascita IS NULL
ORDER BY [Nome Completo] ASC;

--------------------------------------------------------

SELECT
    S.Nome + ' ' + S.Cognome AS [Nome Completo],
    C.NomeCorso AS [Nome Corso],
    A.NomeAula AS [Nome Aula],
    D.Nome + ' ' + D.Cognome AS [Nome Docente],
    L.Titolo AS Lezione
FROM Studenti AS S
INNER JOIN Iscrizioni AS I
    ON S.StudenteID = I.StudenteID
INNER JOIN Corso AS C
    ON I.CorsoID = C.CorsoID
INNER JOIN Lezioni AS L
    ON C.CorsoID = L.CorsoID
INNER JOIN Aule AS A
    ON L.AulaID = A.AulaID
INNER JOIN DocentiCorso AS DC
    ON C.CorsoID = DC.CorsoID
INNER JOIN Docenti AS D
    ON DC.DocenteID = D.DocenteID;

-- REPORT --
-- TOTALE CORSI, MEDIA DEI CORSI, SOMMA CREDITI, CREDITO MINIMO/MASSIMO --

SELECT
    COUNT(*) AS TotaleCorsi,
    AVG(Crediti) AS MediaCrediti,
    SUM(Crediti) AS SommaCrediti,
    MIN(Crediti) AS CreditoMinimo,
    MAX(Crediti) AS CreditoMassimo
FROM Corso;

-------------------------------------------

SELECT TOP 10 *
FROM Studenti as s
INNER JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId
WHERE DataNascita IS NOT NULL
    AND DataNascita >= '2000'
ORDER BY DataNascita asc

SELECT TOP 10 *
FROM Studenti as s
JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId
LEFT JOIN Corso c
    ON i.CorsoId = c.CorsoId    
WHERE DataNascita IS NOT NULL
    AND DataNascita <> '2000'
ORDER BY DataNascita asc

-- Restituisce le lista degli studenti non scritti
SELECT 
    s.Nome , 
    s.Cognome,
    s.DataNascita,
    s.CodiceFiscale,
    s.Email,
    s.Telefono,
    i.DataIscrizione,
    c.NomeCorso,
    c.Descrizione,
    c.Crediti,
    c.Durata
FROM Studenti s 
LEFT JOIN Iscrizioni i
    On i.StudenteId = s.StudenteId
LEFT JOIN Corso c
    On i.CorsoId = c.CorsoId

    -- Restituisce le lista degli studenti non scritti
SELECT 
    ISNULL(s.Nome + ' ' + s.Cognome, 'Studente non asseganto') AS Studente,
    ISNULL(CONVERT(VARCHAR, s.DataNascita, 105), 'N/D') AS [Data di Nascita],
    ISNULL(s.CodiceFiscale, 'CF00000') AS [CF],
    ISNULL(s.Email, 'Email non definita') AS Email,
    ISNULL(s.Telefono, '000000') AS Telefono,
    ISNULL(CONVERT(VARCHAR, i.DataIscrizione, 105), 'N/D'),
    ISNULL(c.NomeCorso, 'Non definito') AS [Nome Corso],
    ISNULL(c.Descrizione, 'Non definita') AS Descrizione,
    ISNULL(c.Crediti, 0) AS Crediti,
    ISNULL(c.Durata, 0)
FROM Studenti s 
LEFT JOIN Iscrizioni i
    On i.StudenteId = s.StudenteId
LEFT JOIN Corso c
    On i.CorsoId = c.CorsoId

-- Restituisce le lista degli studenti non scritti
SELECT 
    ISNULL(s.Nome + ' ' + s.Cognome, 'Studente non asseganto') AS Studente,
    ISNULL(CONVERT(VARCHAR, s.DataNascita, 105), 'N/D') AS [Data di Nascita],
    ISNULL(s.CodiceFiscale, 'CF00000') AS [CF],
    ISNULL(s.Email, 'Email non definita') AS Email,
    ISNULL(s.Telefono, '000000') AS Telefono,
    ISNULL(CONVERT(VARCHAR, i.DataIscrizione, 105), 'N/D'),
    ISNULL(c.NomeCorso, 'Non definito') AS [Nome Corso],
    ISNULL(c.Descrizione, 'Non definita') AS Descrizione,
    ISNULL(c.Crediti, 0) AS Crediti,
    ISNULL(c.Durata, 0)
FROM Studenti s 
LEFT JOIN Iscrizioni i
    On i.StudenteId = s.StudenteId
LEFT JOIN Corso c
    On i.CorsoId = c.CorsoId
--------------------------------------------------------------------------------------------
-- Le funzione ISNULL() restituisce valore specifito se l'espressione è null
-- Convert()
SELECT 
    Nome,
    Cognome,
    ISNULL(CONVERT(VARCHAR, DataNascita, 104), 'N/D') AS DataNascita 
FROM Studenti
where DataNascita is null;
SELECT 
    Nome,
    Cognome,
    DataNascita 
FROM Studenti
where DataNascita is null;

-----------------------------------------------------

SELECT 
    Titolo + ' ' + Descrizione AS [Materia],
    --ISNULL(LEFT(CONVERT(VARCHAR, OraInizio, 108), 2), 'N/D') as Ora,
    ISNULL(LEFT(CONVERT(VARCHAR, OraInizio, 108), 5), 'N/D') as Minuti,
    ISNULL(DATEPART(HOUR, OraInizio), 2) AS Ora,
    DATEPART(MINUTE, OraInizio) AS Minuti
FROM Lezioni;
SELECT 
    Titolo + ' ' + Descrizione AS [Materia],
    'la lezione inizia alle ' +
    CAST(DATEPART(HOUR, OraInizio) AS nvarchar(2)) + ':' + 
    RIGHT('0' + CAST(DATEPART(MINUTE, OraInizio) as nvarchar(2)), 2 ) as Orario
FROM Lezioni;
-- 108 => 09:00
SELECT
    Titolo + ' ' + Descrizione AS [Materia],
    'la lezione inizia alle ' +
    ISNULL(CONVERT(VARCHAR(5), OraInizio, 108), 'N/D') AS Ora
FROM Lezioni;

--------------------------------------------

SELECT  s.Nome + ' ' + s.Cognome as [Studente],
        s.CodiceFiscale as [CF],
        ISNULL(CONVERT(VARCHAR, i.DataIscrizione, 105), 'Data non definita') AS [Data Iscrizione]
FROM Studenti s
RIGHT JOIN Iscrizioni i
    ON i.StudenteID = s.StudenteID;

-----------------------------------------------------

