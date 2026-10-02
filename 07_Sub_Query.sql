/*
	SUB-QUERY: QUERY DENTRO UN'ALTRA QUERY:
	- FILTRA DATI USANDO RISULTATI DI ALTRE TABLE
	- CALCOLA VALORI INTERMEDI
	- SOSTIUISCE JOIN PERLOGICA PIU' COMPATTA
	- CREARE CONDIZIONI AVANZATE NEL WHERE/HAVING/SELECT
*/

-- ESERCIZIO 
-- SUBQUERY - WHERE
-- TROVARE STUDENTI CHE HANNO PRESO IL VOTO MASSIMO IN TUTTA LA SCUOLA


SELECT	s.Nome, 
		s.Cognome,
		v.Voto
FROM Studenti s
JOIN Voti v
	ON s.StudenteID = v.StudenteID
WHERE v.Voto =	(
	SELECT CAST(MAX(Voto) AS INT) [Voto Massimo] -- 30
	FROM Voti
				);

--------------------------------------------------------------------

--ESERCIZIO
-- SUBQUERY - SELECT
-- MOSTRARE OGNI STUDENTE CON LA MEDIA DEI SUOI VOTI (SENZA GROUP BY)

SELECT CONCAT(s.Nome, ' ', s.Cognome) [Nome Completo],
		s.CodiceFiscale [CF]
FROM Studenti s
JOIN Voti v
	ON s.StudenteID = v.StudenteID
WHERE v.Voto = (
	SELECT AVG(v.Voto) [Media Voti] -- 25.90
	FROM Voti v
			);

-- seconda opzione --

SELECT
    CONCAT(s.Nome, ' ', s.Cognome) AS [Nome Completo],
    s.CodiceFiscale AS [CF],
    (
        SELECT AVG(v.Voto)
        FROM Voti v
        WHERE v.StudenteID = s.StudenteID
    ) AS [Media Voti]
FROM Studenti s;

--------------------------------------------------------------------

-- TROVARE GLI STUDENTI CHE HANNO PRESO ALMENO UN VOTO >= 28

SELECT Nome, Cognome
FROM Studenti 
WHERE StudenteID IN (
			SELECT StudenteID
			FROM Voti 
			WHERE Voto >= 28
					);

------------------------------------------

-- SUBQUERY CON EXISTS
-- MOSTRARE GLI STUDENTI CHE HANNO ALMENO UN VOTO REGISTRAT0

SELECT CONCAT(s.Nome, ' ', s.Cognome) [Studente]
FROM Studenti s
WHERE EXISTS (
			SELECT 1
			FROM Voti v
			WHERE s.StudenteID = v.StudenteID
			);

------------------------------------------

-- MOSTRARE GLI STUDENTI CHE HANNO PRESO UN VOTO MAGGIORE DELLA MEDIA

SELECT CONCAT(s.Nome, ' ', s.Cognome) AS [Nome Studente]
FROM Studenti s
INNER JOIN Voti v
	ON s.StudenteID = v.StudenteID
WHERE v.Voto > (
				SELECT AVG(Voto)
				FROM Voti
				)

------------------------------------------


	
	