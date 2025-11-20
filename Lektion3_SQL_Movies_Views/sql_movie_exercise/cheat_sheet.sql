-- =========================================================
-- SQL CHEAT SHEET – GRUNDLÄGGANDE KOMMANDON
-- =========================================================
-- Denna sammanfattning hjälper dig snabbt förstå de vanligaste
-- SQL-kommandona som används i kursen Databashantering.

-- =========================================================
-- SELECT – HÄMTA DATA
-- =========================================================
-- Hämta alla rader och kolumner:
-- SELECT * FROM Tabell;

-- Hämta specifika kolumner:
-- SELECT Kolumn1, Kolumn2 FROM Tabell;

-- Undvika duplicerade värden:
-- SELECT DISTINCT Kolumn FROM Tabell;


-- =========================================================
-- WHERE – FILTRERA DATA
-- =========================================================
-- Jämförelser:
-- WHERE Kolumn = värde
-- WHERE Kolumn > värde
-- WHERE Kolumn < värde

-- Flera villkor:
-- WHERE Kolumn = 'Drama' AND Rating > 8.0
-- WHERE Genre = 'Sci-Fi' OR Genre = 'Action'

-- IN – flera värden i samma kolumn:
-- WHERE Genre IN ('Drama', 'Crime')

-- BETWEEN – intervall:
-- WHERE Rating BETWEEN 8.0 AND 9.0

-- LIKE – mönstersökning:
-- WHERE Title LIKE 'The%'
-- WHERE Director LIKE '%Nolan%'


-- =========================================================
-- ORDER BY – SORTERA
-- =========================================================
-- Sortera stigande eller fallande:
-- ORDER BY ReleaseYear ASC;
-- ORDER BY Rating DESC;

-- Flera sorteringskolumner:
-- ORDER BY Genre ASC, Rating DESC;


-- =========================================================
-- LIMIT – BEGRÄNSA ANTAL RADER
-- =========================================================
-- Top 5 filmer:
-- SELECT * FROM Movies ORDER BY Rating DESC LIMIT 5;


-- =========================================================
-- UPDATE – ÄNDRA DATA
-- =========================================================
-- Ändra en rad:
-- UPDATE Movies SET Rating = 9.0 WHERE MovieID = 1;

-- Ändra flera rader:
-- UPDATE Movies SET RuntimeMinutes = RuntimeMinutes + 10
-- WHERE Genre = 'Action';


-- =========================================================
-- DELETE – TA BORT DATA
-- =========================================================
-- Ta bort en film:
-- DELETE FROM Movies WHERE MovieID = 5;


-- =========================================================
-- INSERT – LÄGGA TILL DATA
-- =========================================================
-- INSERT INTO Movies (MovieID, Title, ReleaseYear, Genre, Rating)
-- VALUES (21, 'New Movie', 2025, 'Sci-Fi', 7.5);


-- =========================================================
-- GROUP BY – GRUPPERA DATA
-- =========================================================
-- Antal filmer per genre:
-- SELECT Genre, COUNT(*)
-- FROM Movies
-- GROUP BY Genre;

-- Med sortering:
-- SELECT Genre, COUNT(*) AS NumberOfMovies
-- FROM Movies
-- GROUP BY Genre
-- ORDER BY NumberOfMovies DESC;


-- =========================================================
-- HAVING – FILTRERA EFTER AGGREGAT
-- =========================================================
-- Visa bara genrer som har fler än 3 filmer:
-- SELECT Genre, COUNT(*) AS Antal
-- FROM Movies
-- GROUP BY Genre
-- HAVING COUNT(*) > 3;


-- =========================================================
-- ALIAS – EGET NAMN PÅ KOLUMN
-- =========================================================
-- SELECT Title AS FilmTitel, Rating AS Betyg
-- FROM Movies;


-- =========================================================
-- TIPS FÖR BRA SQL-SKRIVANDE
-- =========================================================
-- ✔ Skriv nyckelord i UPPERCASE (SELECT, WHERE, ORDER BY)
-- ✔ Skriv tabell- och kolumnnamn i lowercase eller mixedCase
-- ✔ Använd alltid ; i slutet av varje sats
-- ✔ Testa logiken med SELECT efter varje UPDATE/DELETE
-- ✔ Arbeta i små steg och dubbelkolla resultatet
-- ✔ Kommentarer börjar med -- och är jättebra att använda!
-- =========================================================
