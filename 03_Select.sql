USE ScuolaDB;
GO

/* ============================================================
   SELECT * ALL
   ============================================================ */

SELECT * FROM Studenti;
SELECT * FROM Corso;
SELECT * FROM Docenti;
SELECT * FROM Aule;
SELECT * FROM Iscrizioni;
SELECT * FROM DocentiCorso;
SELECT * FROM Lezioni;
SELECT * FROM Voti;

-- ESEMPIO CON AS, FROM, WHERE, ORDER BY --

SELECT	Nome + ' ' + Cognome AS [Nome Completo], 
		CodiceFiscale AS [CF], DataNascita, Email 
FROM	Studenti
WHERE	DataNascita IS NULL
ORDER BY [Nome Completo] ASC


-- ESEMPIO CON OPERATORI LOGICI --

SELECT	StudenteID, Nome, Cognome, Email
FROM	Studenti
WHERE	StudenteID = 4;

-- ESERCIZIO DIVERSO --

SELECT	* FROM	Studenti
WHERE	StudenteID != 5;

-- ESERCIZIO MAGGIORE --

SELECT	* FROM	Corso
WHERE	Crediti > 5;

-- ESERCIZIO MINORE --

SELECT	* FROM	Corso
WHERE	Crediti < 5;

-- ESERCIZIO MAGGIORE O UGUALE --

SELECT DISTINCT	
		NomeCorso,
		Descrizione,
		Crediti
FROM	Corso
WHERE	Crediti >= 5;

-- ESERCIZIO MINORE O UGUALE --

SELECT DISTINCT	
		NomeCorso,
		Descrizione,
		Crediti
FROM	Corso
WHERE	Crediti <= 5;

-- ESERCIZIO AND --

SELECT DISTINCT	
		NomeCorso,
		Descrizione,
		Crediti
FROM	Corso
WHERE	Crediti >= 5 AND Durata >= 50;

-- ESERCIZIO OR --

SELECT DISTINCT	
		NomeCorso,
		Descrizione,
		Crediti
FROM	Corso
WHERE	Crediti = 5 OR Crediti = 3;

-- ESEMPIO FILTRI --

SELECT * FROM Studenti WHERE Nome = 'Anna';

SELECT * FROM Studenti WHERE Cognome = 'Rossi';

-- ESEMPIO CONDIZIONI --

SELECT 
		Nome + ' ' + Cognome AS [Nome Completo],
		DataNascita AS [Data di nascita],
		Email
FROM	Studenti
WHERE	DataNascita > '2002'
ORDER BY [Nome Completo] ASC;

/* ============================================================
							ESERCIZIO:

   Restituire la lista degli Studenti nati tra il 2001 e il 2002
   ============================================================ */

SELECT  Nome + ' ' + Cognome AS [Nome Completo],
		DataNascita
FROM	Studenti
WHERE   DataNascita >= '2001' AND DataNascita < '2002';

-- ESEMPIO LIMIT TOP --

SELECT TOP 10 *
FROM Studenti
WHERE DataNascita IS NOT NULL;

-- ESEMPIO LISTA IN / NOT IN--

SELECT TOP 10 * FROM Corso
WHERE Crediti IN (6, 5)
ORDER BY NomeCorso ASC;

------------------------------------

SELECT TOP 10 * FROM Corso
WHERE Crediti NOT IN (6, 5)
ORDER BY NomeCorso DESC;

-- ESEMPIO BETWEEN FRA MIN E MAX --

SELECT * FROM Studenti
WHERE Nome BETWEEN 'A' AND 'G'
ORDER BY Nome ASC;

-----------------------------------

SELECT DISTINCT TOP 5 NomeCorso AS [Nome Corso], Descrizione, Durata
FROM Corso
WHERE Durata BETWEEN '30' AND '50'
ORDER BY Durata, NomeCorso ASC;

/* ============================================================
							ESERCIZIO:

				Studenti nati tra 2000 e 2002
   ============================================================ */

SELECT Nome + ' ' + Cognome AS [Nome Completo], DataNascita AS [Data di Nascita]
FROM	Studenti
WHERE DataNascita BETWEEN '2000-01-01' AND '2002-12-31'
ORDER BY DataNascita ASC;

-- ESEMPIO LIKE (%) --

SELECT DISTINCT NomeCorso AS [Nome del Corso], Descrizione, Crediti,Durata
FROM Corso
WHERE NomeCorso LIKE 'P%'
ORDER BY NomeCorso ASC;