Lektion 3 – SQL: Movies & Views

Denna lektion bygger vidare på SQL-grunderna och introducerar ett större dataset (Movies) samt arbetet med **views** – sparade SELECT-frågor. Du tränar även mer avancerad filtrering, sortering, uppdatering av data och sammanställningar.

Syftet med lektion 3
        - Kunna arbeta med en större tabell (20+ rader)
        - Skriva mer precisa SELECT-frågor
        - Träna WHERE med fler villkor
        - Öva ORDER BY, LIMIT
        - Skapa och använda **views**
        - Förstå varför views används i riktiga system
        - Förbereda inför JOINs i lektion 4

Mappstruktur för lektion 3
    I mappen Lektion3_SQL_Movies_Views finns:
        - movies_exercise.sql – alla filmuppgifter (1–10)
        - views_exercise.sql – alla övningar och exempel på vyer
        - (valfritt) screenshots

    Detta är en komplett övningsmiljö för lektion 3.

Movies-tabellen
Movies-databasen innehåller 20 filmer med:
        - MovieID
        - Title
        - ReleaseYear
        - Genre
        - Rating
        - Director
        - RuntimeMinutes

Du har tränat:
SELECT * (lista allt)
        SELECT * FROM Movies;

Filtrera på kolumner (WHERE)
        SELECT * FROM Movies WHERE Genre = 'Drama';

Sortering (ORDER BY)
        SELECT * FROM Movies ORDER BY Rating DESC;

Avgränsning (LIMIT)
        SELECT * FROM Movies LIMIT 5;

Flera villkor med AND / OR
        SELECT * FROM Movies
        WHERE Genre = 'Sci-Fi' AND Rating > 8.0;

IN – flera alternativ
        SELECT * FROM Movies WHERE Genre IN ('Drama','Crime');

BETWEEN – intervall
        SELECT * FROM Movies WHERE ReleaseYear BETWEEN 1990 AND 2000;

UPDATE – ändra data
        UPDATE Movies SET Rating = 9.0 WHERE MovieID = 1;

Mass-update
        UPDATE Movies
        SET RuntimeMinutes = RuntimeMinutes + 10
        WHERE Genre = 'Action';

Uppgifter från lektion 3 (1–10)

Du har gjort alla filmuppgifter:

1. Visa alla filmer
2. Filtrera efter genre
3. Sortera efter ReleaseYear
4. Uppdatera rating
5. Räkna filmer per genre
6. Lista specifika kolumner
7. Filmer efter visst år
8. Uppdatera flera rader
9. Topprankade filmer (LIMIT 5)
10. Filmer efter specifik regissör

Dessa finns i movies_exercise.sql och är helt färdiga.

Views – sparade SELECT-frågor
I views_exercise.sql har du lärt dig:

Skapa vy
CREATE OR REPLACE VIEW TopRatedMovies AS
        SELECT * FROM Movies WHERE Rating > 8.5;

Använda vy
        SELECT * FROM TopRatedMovies;

Ta bort vy
    DROP VIEW TopRatedMovies;

Varför views används
        - återanvänd SELECT-frågor
        - minska duplicerad logik
        - förenkla komplicerade JOINs
        - öka läsbarhet

Du skapade bl.a.:
        - SciFiMovies
        - MovieOverview
        - NolanMovies
        - StudentsWithoutCourses (i Join-databasen)

Vad jag lärde mig i lektion 3
        - Arbeta med större tabeller
        - Kombinera flera SQL-tekniker samtidigt
        - Förstå skillnaden mellan data och vyer
        - Skapa views och använda dem i fortsatta frågor
        - Förbereda struktur inför JOINs och relationer

Status: Lektion 3 KLAR
Du har gjort:
        - Alla 10 movie-uppgifter
        - Alla view-uppgifter
        - Repetition av SQL-grunder
        - Fått filstruktur för lektion 3 komplett

Du är helt redo för lektion 4 (Design & JOINs).
