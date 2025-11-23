-- =========================================================
-- MOVIES EXERCISE - FILMDB
-- Samlad lösning för alla övningar
-- =========================================================


-- =========================================================
-- (VALFRITT) SKAPA TABELLEN MOVIES OM DEN INTE FINNS
-- Kör detta om du vill kunna återskapa databasen från början
-- =========================================================
CREATE TABLE IF NOT EXISTS Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255),
    ReleaseYear INT,
    Genre VARCHAR(100),
    Rating DECIMAL(3,1)
);



-- =========================================================
-- (VALFRITT) INFOGA 20 FILMER
-- INSERT IGNORE gör att du slipper fel om raden redan finns
-- =========================================================
INSERT IGNORE INTO Movies (MovieID, Title, ReleaseYear, Genre, Rating)
VALUES
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
-- FÖRBERED TABELLEN FÖR ALLA ÖVNINGAR
-- Lägg till Director och RuntimeMinutes om de saknas
-- =========================================================
ALTER TABLE Movies
    ADD COLUMN IF NOT EXISTS Director VARCHAR(255);

ALTER TABLE Movies
    ADD COLUMN IF NOT EXISTS RuntimeMinutes INT;



-- =========================================================
-- FYLL I REGISSÖR (Director) FÖR ALLA 20 FILMER
-- (KAN KÖRAS SÄKERT FLERA GÅNGER)
-- =========================================================
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
-- (VALFRITT) SÄTT RUNTIME FÖR FILMER (EXEMPELVÄRDEN)
-- Används i uppgift 8
-- =========================================================
UPDATE Movies SET RuntimeMinutes = 148 WHERE MovieID = 1;   -- Inception
UPDATE Movies SET RuntimeMinutes = 169 WHERE MovieID = 2;   -- Interstellar
UPDATE Movies SET RuntimeMinutes = 152 WHERE MovieID = 3;   -- The Dark Knight
UPDATE Movies SET RuntimeMinutes = 195 WHERE MovieID = 4;   -- Titanic
UPDATE Movies SET RuntimeMinutes = 136 WHERE MovieID = 5;   -- The Matrix
UPDATE Movies SET RuntimeMinutes = 162 WHERE MovieID = 6;   -- Avatar
UPDATE Movies SET RuntimeMinutes = 155 WHERE MovieID = 7;   -- Gladiator
UPDATE Movies SET RuntimeMinutes = 175 WHERE MovieID = 8;   -- The Godfather
UPDATE Movies SET RuntimeMinutes = 142 WHERE MovieID = 9;   -- Shawshank
UPDATE Movies SET RuntimeMinutes = 142 WHERE MovieID = 10;  -- Forrest Gump
UPDATE Movies SET RuntimeMinutes = 154 WHERE MovieID = 11;  -- Pulp Fiction
UPDATE Movies SET RuntimeMinutes = 88  WHERE MovieID = 12;  -- Lion King
UPDATE Movies SET RuntimeMinutes = 127 WHERE MovieID = 13;  -- Jurassic Park
UPDATE Movies SET RuntimeMinutes = 116 WHERE MovieID = 14;  -- Back to the Future
UPDATE Movies SET RuntimeMinutes = 132 WHERE MovieID = 15;  -- Parasite
UPDATE Movies SET RuntimeMinutes = 120 WHERE MovieID = 16;  -- Social Network
UPDATE Movies SET RuntimeMinutes = 128 WHERE MovieID = 17;  -- La La Land
UPDATE Movies SET RuntimeMinutes = 143 WHERE MovieID = 18;  -- Avengers
UPDATE Movies SET RuntimeMinutes = 133 WHERE MovieID = 19;  -- Spider-Man: Homecoming
UPDATE Movies SET RuntimeMinutes = 122 WHERE MovieID = 20;  -- Joker



-- =========================================================
-- UPPGIFT 1: VÄLJ ALLA FILMER
-- Lista varje rad och kolumn i tabellen
-- =========================================================
SELECT *
FROM Movies;



-- =========================================================
-- UPPGIFT 2: FILTRERA EFTER GENRE
-- Visa filmer i en genre du anger (ändra genren vid behov)
-- Exempel: visa alla Sci-Fi-filmer
-- =========================================================
SELECT *
FROM Movies
WHERE Genre = 'Sci-Fi';



-- =========================================================
-- UPPGIFT 3: SORTERA EFTER ReleaseYear
-- Visa filmer kronologiskt (äldst först)
-- =========================================================
SELECT *
FROM Movies
ORDER BY ReleaseYear ASC;



-- =========================================================
-- UPPGIFT 4: UPPDATERA FILMDATA
-- Ändra Rating på en film (exempel: höj rating på Inception)
-- =========================================================
UPDATE Movies
SET Rating = 9.0
WHERE Title = 'Inception';

-- Kontrollera ändringen
SELECT Title, Rating
FROM Movies
WHERE Title = 'Inception';



-- =========================================================
-- UPPGIFT 5: RÄKNA FILMER PER GENRE
-- Gruppera per genre och räkna hur många filmer varje genre har
-- =========================================================
SELECT Genre,
       COUNT(*) AS NumberOfMovies
FROM Movies
GROUP BY Genre
ORDER BY NumberOfMovies DESC;



-- =========================================================
-- UPPGIFT 6: HÄMTA SPECIFIKA KOLUMNER
-- Lista bara Title och Director
-- =========================================================
SELECT Title, Director
FROM Movies
ORDER BY Title ASC;



-- =========================================================
-- UPPGIFT 7: FILMER EFTER VISST ÅR
-- Välj filmer som har ReleaseYear större än ett valt år
-- Exempel: filmer efter år 2010
-- =========================================================
SELECT *
FROM Movies
WHERE ReleaseYear > 2010
ORDER BY ReleaseYear ASC;



-- =========================================================
-- UPPGIFT 8: UPPDATERA FLERA RADER
-- Öka RuntimeMinutes för en hel genre
-- Exempel: alla Action-filmer får +10 minuter
-- =========================================================
UPDATE Movies
SET RuntimeMinutes = RuntimeMinutes + 10
WHERE Genre = 'Action';

-- Kontrollera ändringen
SELECT Title, Genre, RuntimeMinutes
FROM Movies
WHERE Genre = 'Action';



-- =========================================================
-- UPPGIFT 9: TOPPRANKADE FILMER
-- Visa de fem filmer med högst Rating
-- =========================================================
SELECT *
FROM Movies
ORDER BY Rating DESC
LIMIT 5;



-- =========================================================
-- UPPGIFT 10: FILMER AV SPECIFIK REGISSÖR
-- Filtrera på en regissör du väljer
-- Exempel: alla filmer av Christopher Nolan
-- =========================================================
SELECT *
FROM Movies
WHERE Director = 'Christopher Nolan';

