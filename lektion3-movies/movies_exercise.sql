-- =========================================================
-- MOVIES_EXERCISE.SQL
-- Lektion 3 – Movies, SELECT-övningar, WHERE, ORDER BY, LIMIT, GROUP BY, UPDATE, VIEWS
-- Komplett och noggrant kommenterat skript för hela Movie-övningen.
-- =========================================================


-- =========================================================
-- STEG 1: SKAPA TABELLEN (om den inte redan finns)
-- =========================================================
-- Tabellen används för alla filmövningar i lektion 3.
-- Kolumner:
--   MovieID         – unikt ID för varje film
--   Title           – filmens namn
--   ReleaseYear     – år då filmen släpptes
--   Genre           – kategori (Drama, Sci-Fi, Action, etc.)
--   Rating          – betyg (1–10, decimal)
--   Director        – regissör (läggs till i nästa steg)
--   RuntimeMinutes  – längd på filmen i minuter

CREATE TABLE IF NOT EXISTS Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255),
    ReleaseYear INT,
    Genre VARCHAR(100),
    Rating DECIMAL(3,1)
);


-- =========================================================
-- STEG 2: LÄGG TILL SAKNADE KOLUMNER (Director + Runtime)
-- =========================================================
-- Dessa kolumner läggs endast till om de inte redan finns.
-- Detta gör skriptet säkert att köra flera gånger.

ALTER TABLE Movies
    ADD COLUMN IF NOT EXISTS Director VARCHAR(255);

ALTER TABLE Movies
    ADD COLUMN IF NOT EXISTS RuntimeMinutes INT;


-- =========================================================
-- STEG 3: INFOGA 20 FILMER (INSERT IGNORE = inget kraschar)
-- =========================================================
-- Om filmerna redan finns ignoreras dubbletter.

INSERT IGNORE INTO Movies (MovieID, Title, ReleaseYear, Genre, Rating) VALUES
    (1, 'Inception', 2010, 'Sci-Fi', 8.8),
    (2, 'Interstellar', 2014, 'Sci-Fi', 8.6),
    (3, 'The Dark Knight', 2008, 'Action', 9.0),
    (4, 'Titanic', 1997, 'Romance', 7.8),
    (5, 'The Matrix', 1999, 'Sci-Fi', 8.7),
    (6, 'Avatar', 2009, 'Fantasy', 7.8),
    (7, 'Gladiator', 2000, 'Action', 8.5),
    (8, 'The Godfather', 1972, 'Crime', 9.2),
    (9, 'The Shawshank Redemption', 1994, 'Drama', 9.3),
    (10, 'Forrest Gump', 1994, 'Drama', 8.8),
    (11, 'Pulp Fiction', 1994, 'Crime', 8.9),
    (12, 'The Lion King', 1994, 'Animation', 8.5),
    (13, 'Jurassic Park', 1993, 'Sci-Fi', 8.1),
    (14, 'Back to the Future', 1985, 'Sci-Fi', 8.5),
    (15, 'Parasite', 2019, 'Thriller', 8.6),
    (16, 'The Social Network', 2010, 'Drama', 7.7),
    (17, 'La La Land', 2016, 'Musical', 8.0),
    (18, 'The Avengers', 2012, 'Superhero', 8.0),
    (19, 'Spider-Man: Homecoming', 2017, 'Superhero', 7.4),
    (20, 'Joker', 2019, 'Drama', 8.4);


-- =========================================================
-- STEG 4: FYLL I REGISSÖRER FÖR SAMTLIGA FILMER
-- =========================================================
-- UPDATE-kommandon körs per film. Detta gör skriptet säkert även vid upprepade körningar.

UPDATE Movies SET Director = 'Christopher Nolan' WHERE MovieID IN (1, 2, 3);
UPDATE Movies SET Director = 'James Cameron' WHERE MovieID IN (4, 6);
UPDATE Movies SET Director = 'Lana Wachowski, Lilly Wachowski' WHERE MovieID IN (5, 20);
UPDATE Movies SET Director = 'Ridley Scott' WHERE MovieID = 7;
UPDATE Movies SET Director = 'Francis Ford Coppola' WHERE MovieID = 8;
UPDATE Movies SET Director = 'Frank Darabont' WHERE MovieID = 9;
UPDATE Movies SET Director = 'Robert Zemeckis' WHERE MovieID IN (10, 14);
UPDATE Movies SET Director = 'Quentin Tarantino' WHERE MovieID = 11;
UPDATE Movies SET Director = 'Roger Allers, Rob Minkoff' WHERE MovieID = 12;
UPDATE Movies SET Director = 'Steven Spielberg' WHERE MovieID = 13;
UPDATE Movies SET Director = 'Bong Joon-ho' WHERE MovieID = 15;
UPDATE Movies SET Director = 'David Fincher' WHERE MovieID = 16;
UPDATE Movies SET Director = 'Damien Chazelle' WHERE MovieID = 17;
UPDATE Movies SET Director = 'Joss Whedon' WHERE MovieID = 18;
UPDATE Movies SET Director = 'Jon Watts' WHERE MovieID = 19;


-- =========================================================
-- STEG 5: FYLL I RUNTIME (FILMENS LÄNGD)
-- =========================================================
-- Dessa värden är för att kunna göra uppgift 8 (mass-update).

UPDATE Movies SET RuntimeMinutes = 148 WHERE MovieID = 1;
UPDATE Movies SET RuntimeMinutes = 169 WHERE MovieID = 2;
UPDATE Movies SET RuntimeMinutes = 152 WHERE MovieID = 3;
UPDATE Movies SET RuntimeMinutes = 195 WHERE MovieID = 4;
UPDATE Movies SET RuntimeMinutes = 136 WHERE MovieID = 5;
UPDATE Movies SET RuntimeMinutes = 162 WHERE MovieID = 6;
UPDATE Movies SET RuntimeMinutes = 155 WHERE MovieID = 7;
UPDATE Movies SET RuntimeMinutes = 175 WHERE MovieID = 8;
UPDATE Movies SET RuntimeMinutes = 142 WHERE MovieID = 9;
UPDATE Movies SET RuntimeMinutes = 142 WHERE MovieID = 10;
UPDATE Movies SET RuntimeMinutes = 154 WHERE MovieID = 11;
UPDATE Movies SET RuntimeMinutes = 88  WHERE MovieID = 12;
UPDATE Movies SET RuntimeMinutes = 127 WHERE MovieID = 13;
UPDATE Movies SET RuntimeMinutes = 116 WHERE MovieID = 14;
UPDATE Movies SET RuntimeMinutes = 132 WHERE MovieID = 15;
UPDATE Movies SET RuntimeMinutes = 120 WHERE MovieID = 16;
UPDATE Movies SET RuntimeMinutes = 128 WHERE MovieID = 17;
UPDATE Movies SET RuntimeMinutes = 143 WHERE MovieID = 18;
UPDATE Movies SET RuntimeMinutes = 133 WHERE MovieID = 19;
UPDATE Movies SET RuntimeMinutes = 122 WHERE MovieID = 20;


-- =========================================================
-- ÖVNING 1 – VISA ALLA FILMER
-- =========================================================
SELECT *
FROM Movies;


-- =========================================================
-- ÖVNING 2 – FILTRERA EFTER GENRE
-- =========================================================
SELECT *
FROM Movies
WHERE Genre = 'Sci-Fi';


-- =========================================================
-- ÖVNING 3 – SORTERA EFTER RELEASEYEAR
-- =========================================================
SELECT *
FROM Movies
ORDER BY ReleaseYear ASC;


-- =========================================================
-- ÖVNING 4 – UPPDATERA RATING
-- =========================================================
UPDATE Movies
SET Rating = 9.0
WHERE Title = 'Inception';

SELECT Title, Rating
FROM Movies
WHERE Title = 'Inception';


-- =========================================================
-- ÖVNING 5 – RÄKNA FILMER PER GENRE (GROUP BY)
-- =========================================================
SELECT Genre,
       COUNT(*) AS NumberOfMovies
FROM Movies
GROUP BY Genre
ORDER BY NumberOfMovies DESC;


-- =========================================================
-- ÖVNING 6 – HÄMTA SPECIFIKA KOLUMNER
-- =========================================================
SELECT Title, Director
FROM Movies
ORDER BY Title ASC;


-- =========================================================
-- ÖVNING 7 – FILMER EFTER VISST ÅR
-- =========================================================
SELECT *
FROM Movies
WHERE ReleaseYear > 2010
ORDER BY ReleaseYear ASC;


-- =========================================================
-- ÖVNING 8 – MASS-UPDATE (öka runtime på*/}
-- filmer med låg rating)
-- =========================================================     
UPDATE Movies
SET RuntimeMinutes = RuntimeMinutes + 10
WHERE Rating < 8.0;
SELECT Title, RuntimeMinutes, Rating
FROM Movies
WHERE Rating < 8.0;
-- =========================================================   
-- ÖVNING 9 – SKAPA EN VIEW FÖR HÖGT BETYG
-- =========================================================
CREATE OR REPLACE VIEW HighRatedMovies AS
SELECT *
FROM Movies
WHERE Rating >= 8.5;
-- Testa vyn
SELECT *
FROM HighRatedMovies
ORDER BY Rating DESC;
-- =========================================================
--      SLUT PÅ MOVIES_EXERCISE.SQL     
        