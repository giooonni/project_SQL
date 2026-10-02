/*
	RESTITUIRE MEDIA VOTO DEGLI STUDENTI.
	CAMPI DA VISUALIZZARE:
		NOME COMPLETO STUDENTE
		CF
		VOTO
*/

SELECT	s.Nome + ' ' + s.cognome as [nome completo],
		s.codicefiscale as [cf],
		avg(v.Voto) as [media voto]
FROM Studenti s
INNER JOIN Voti v
	ON v.StudenteID = s.StudenteID
GROUP BY s.Nome, s.Cognome, s.CodiceFiscale;

SELECT	s.Nome + ' ' + s.cognome as [nome completo],
		s.codicefiscale as [cf],
		avg(v.Voto) as [media voto]
FROM Studenti s
INNER JOIN Voti v
	ON v.StudenteID = s.StudenteID
GROUP BY s.Nome, s.Cognome, s.CodiceFiscale;


----------------------------------------

/*
	CONCAT()
*/


SELECT	CONCAT(s.Nome, ' ', s.cognome) as [nome completo],
		s.codicefiscale as [cf],
		cast(avg(v.Voto) as int) as [media voto] -- CAST(INT) = FLOAT -> INT
FROM Studenti s
INNER JOIN Voti v
	ON s.StudenteID = v.StudenteID
GROUP BY s.Nome, s.Cognome, s.CodiceFiscale;

---------------------------------------------

/*
	RESTITUIRE LISTA STUDENTI ISCRITTI AD UN CORSO CON DATA NASCITA = NULL
	- NOME COMPLETO
	- DATA NASCITA
	- CF
	- CORSO
	- VOTO
	- DOCENTE
	- AULE
*/


SELECT	CONCAT(s.Nome, ' ', s.Cognome) AS NomeCompleto,
		ISNULL(CONVERT(VARCHAR, s.DataNascita, 120), 'N/D') as [data di nascita],
		s.CodiceFiscale AS CF,
		c.NomeCorso AS Corso,
		v.Voto,
		CONCAT(d.Nome, ' ', d.Cognome) AS Docente,
		a.NomeAula as [Aula]
FROM	Studenti AS s

INNER JOIN Iscrizioni  i
    ON s.StudenteID = i.StudenteID

INNER JOIN Corso  c
    ON i.CorsoID = c.CorsoID

INNER JOIN Voti  v
    ON s.StudenteID = v.StudenteID
    AND c.CorsoID = v.CorsoID

INNER JOIN DocentiCorso  dc
    ON c.CorsoID = dc.CorsoID

INNER JOIN Docenti d
    ON dc.DocenteID = d.DocenteID

INNER JOIN Lezioni l
	ON c.CorsoID = l.CorsoID

INNER JOIN Aule a
	ON l.AulaID = a.AulaID

WHERE s.DataNascita IS NULL

-- GROUP BY s.Nome, s.Cognome, s.CodiceFiscale;

----------------------------------------

-- 1. Studenti con voto >= 28

SELECT	'Studente con voto >= 28' AS Esito,
		CONCAT(s.Nome, ' ', s.Cognome) AS Nome,
		NULL AS Corso,
		v.Voto
FROM Studenti AS s
INNER JOIN Voti AS v
    ON s.StudenteID = v.StudenteID
WHERE v.Voto >= 28


-- 2. Studenti senza corsi

SELECT	-- 'Studente senza corso' AS Tipo,
		CONCAT(s.Nome, ' ', s.Cognome) AS Nome,
		'CORSO ' + ISNULL(c.NomeCorso, 'N/D') AS Corso		
FROM Studenti AS s
LEFT JOIN Iscrizioni AS i
	ON s.StudenteID = i.StudenteID
LEFT JOIN Corso AS c
	ON c.CorsoID = i.CorsoID
WHERE i.IscrizioneID IS NULL

--------------------------------------

SELECT 
    Titolo + ' ' + Descrizione AS [Materia],
    'la lezione inizia alle ' +
    CAST(DATEPART(HOUR, OraInizio) AS nvarchar(2)) + ':' + 
    RIGHT('0' + CAST(DATEPART(MINUTE, OraInizio) as nvarchar(2)), 2 ) as Orario
FROM Lezioni;


-- 3. Corsi senza studenti

SELECT	'Corso senza studenti' AS Tipo,
		NULL AS Nome,
		c.NomeCorso AS Corso,
		NULL AS Voto
FROM	Corso AS c
FULL JOIN Iscrizioni AS i
    ON c.CorsoID = i.CorsoID
WHERE i.IscrizioneID IS NULL;

-- FULL JOIN

SELECT CONCAT(s.Nome, ' ', s.Cognome) AS NomeStudente,
		ISNULL(v.Voto, 0) AS Voto
FROM Studenti AS s
FULL OUTER JOIN Voti AS v
    ON s.StudenteID = v.StudenteID;

--------------------------


SELECT 
    ISNULL(c.NomeCorso, 'Non defuinito') AS Corso,
    CAST(ISNULL(c.Crediti, 0) as INT) as Crediti,
    CAST(ISNULL(c.Durata,  0) as INT) as Durata
FROM Studenti s 
LEFT JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId
LEFT JOIN Corso c
    ON c.CorsoId = i.CorsoId
WHERE c.CorsoId IS NOT NULL
ORDER by s.Nome ASC;

--------------------------------

SELECT 
    ISNULL(c.NomeCorso, 'Non defuinito') AS Corso,
    CAST(ISNULL(c.Crediti, 0) as INT) as Crediti,
    CAST(ISNULL(c.Durata,  0) as INT) as Durata
FROM Studenti s 
LEFT JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId
LEFT JOIN Corso c
    ON c.CorsoId = i.CorsoId
WHERE c.CorsoId IS NOT NULL
ORDER by s.Nome ASC;