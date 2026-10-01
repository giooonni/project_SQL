USE ScuolaDB;
GO

/* ============================================================
							FUNZIONI

				 COUNT | SUM | AVG | MIN | MAX
   ------------------------------------------------------------
					 GROUP BY | HAVING
   ============================================================ */

-- ESEMPIO COUNT --

SELECT COUNT(StudenteID) AS [Numero totale degli Studenti] 
FROM Studenti;

--------------------------------

-- ESEMPIO COUNT + UNION ALL --

SELECT 'Studenti' AS Tabella, 
		COUNT(*) AS [Numero Righe]
FROM Studenti

UNION ALL

SELECT 'Corsi',	
		COUNT(*)
FROM Corso

UNION ALL

SELECT 'Docenti',
		COUNT(*)
FROM Docenti

UNION ALL

SELECT 'Aule',
		COUNT(*)
FROM Aule

UNION ALL

SELECT 'Iscrzioni', 
		COUNT(*)
FROM Iscrizioni

UNION ALL

SELECT 'DocentiCorso',
		COUNT(*)
FROM DocentiCorso

UNION ALL

SELECT 'Lezioni',
		COUNT(*)
FROM Lezioni

UNION ALL

SELECT 'Voti',
		COUNT(*)
FROM Voti

-- ESEMPIO SOMMA (SUM + GROUP BY) --

SELECT SUM(Crediti) AS [Totale Crediti]
FROM Corso

-- ESEMPIO MEDIA (AVG) --

SELECT AVG(Crediti) AS [Media Crediti]
FROM Corso;

-------------------------------------------

SELECT AVG(Durata) AS [Media Durata Corsi]
FROM Corso;

-- ESEMPIO MINIMO (MIN) --

SELECT MIN(Crediti) AS [Minimo Crediti]
FROM Corso;

-- ESEMPIO MASSIMO (MAX) --

SELECT MAX(Crediti) AS [Minimo Crediti]
FROM Corso;

-- ESEMPIO GROUP BY --

SELECT Specializzazione,
		COUNT(*) AS [Totale Docenti per Specializzazione] 
FROM Docenti
GROUP BY Specializzazione;

 /* ============================================================
							ESERCIZIO:

		 Solo docenti che hanno corso che iniziano per 'd'
 ============================================================ */

 SELECT Nome + ' ' + Cognome AS [Nome Docente], Specializzazione,
		COUNT(*) AS [Totale Docenti]
 FROM Docenti
 WHERE Specializzazione LIKE 'D%'
 GROUP BY Nome, Cognome, Specializzazione
 ORDER BY Specializzazione ASC;


-- ESEMPIO HAVING (FILTRO GRUPPI) --

SELECT Specializzazione,
		COUNT(*) AS [Totale Docenti]
FROM Docenti
GROUP BY Specializzazione
HAVING	COUNT(*) >= 2;

-------------------------------------------



