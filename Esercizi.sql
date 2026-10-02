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
	ON s.StudenteID = v.StudenteID
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

SELECT	'Studente senza corso' AS Tipo,
		CONCAT(s.Nome, ' ', s.Cognome) AS Nome,
		NULL AS Corso,
		NULL AS Voto
FROM Studenti AS s
LEFT JOIN Iscrizioni AS i
	ON s.StudenteID = i.StudenteID
WHERE i.IscrizioneID IS NULL


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
		v.Voto
FROM Studenti AS s
FULL JOIN Voti AS v
    ON s.StudenteID = v.StudenteID;