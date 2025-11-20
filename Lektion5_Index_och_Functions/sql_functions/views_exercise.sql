-- =========================================================
-- VIEWS EXERCISE – SQL VYER (LEKTION 3)
-- =========================================================
-- Syfte:
--   - Förstå vad en VIEW är
--   - Skapa, uppdatera och använda vyer
--   - Förenkla SELECT-frågor genom återanvändning
--
-- Vyer är "sparade SELECT-frågor" som du kan använda
-- som en tabell. Inga extra data lagras — bara en vy.
-- =========================================================


-- =========================================================
-- DEL 1 – VYER I MOVIES-DATABASEN
-- =========================================================

-- 1. Skapa vy: Alla filmer med rating över 8.5
CREATE OR REPLACE VIEW TopRatedMovies AS
SELECT *
FROM Movies
WHERE Rating > 8.5;

-- Testa vyn:
-- SELECT * FROM TopRatedMovies;


-- 2. Skapa vy: Alla Sci-Fi-filmer
CREATE OR REPLACE VIEW SciFiMovies AS
SELECT *
FROM Movies
WHERE Genre = 'Sci-Fi';

-- Testa:
-- SELECT * FROM SciFiMovies;


-- 3. Skapa vy: Snygg sammanställning av filmdata
CREATE OR REPLACE VIEW MovieOverview AS
SELECT
    MovieID,
    Title,
    Director,
    Genre,
    Rating,
    ReleaseYear,
    RuntimeMinutes
FROM Movies
ORDER BY Rating DESC;

-- Testa:
-- SELECT * FROM MovieOverview;


-- 4. Skapa vy: Filmer av Christopher Nolan
CREATE OR REPLACE VIEW NolanMovies AS
SELECT *
FROM Movies
WHERE Director = 'Christopher Nolan';

-- Testa:
-- SELECT * FROM NolanMovies;



-- =========================================================
-- DEL 2 – VYER I SCHOOL-DATABASEN (JOIN-DATABASEN)
-- =========================================================

-- 5. Vy: Elev + kurs + betyg (JOIN som vy)
CREATE OR REPLACE VIEW StudentCourseView AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName,
    e.Grade
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c     ON e.CourseID = c.CourseID;

-- Testa vyn:
-- SELECT * FROM StudentCourseView;


-- 6. Vy: Elever utan kurser
CREATE OR REPLACE VIEW StudentsWithoutCourses AS
SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL;

-- Testa:
-- SELECT * FROM StudentsWithoutCourses;


-- 7. Vy: Kurser med antal studenter
CREATE OR REPLACE VIEW CoursesWithCounts AS
SELECT
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

-- Testa:
-- SELECT * FROM CoursesWithCounts;



-- =========================================================
-- DEL 3 – ÖVNINGSUPPGIFTER (för dig att köra själv)
-- =========================================================

-- Uppgift 1:
-- Skapa en vy som visar alla filmer som släpptes efter 2010.
-- Namnge vyn: RecentMovies

-- Uppgift 2:
-- Skapa en vy som visar "betyg A" elever från StudentCourseView.

-- Uppgift 3:
-- Skapa en vy som visar alla kurser som har fler än 1 elev.
-- (TIPs: använd HAVING)

-- Uppgift 4:
-- Skapa en vy som visar Drama-filmer med rating över 8.0.

-- Uppgift 5:
-- Skapa vy: MovieShort (Title, Genre, Rating — inget mer)



-- =========================================================
-- DEL 4 – LÖSNINGAR TILL ÖVNINGSUPPGIFTER
-- =========================================================

-- Lösning till uppgift 1
CREATE OR REPLACE VIEW RecentMovies AS
SELECT *
FROM Movies
WHERE ReleaseYear > 2010;

-- Lösning till uppgift 2
CREATE OR REPLACE VIEW AGradeStudents AS
SELECT *
FROM StudentCourseView
WHERE Grade = 'A';

-- Lösning till uppgift 3
CREATE OR REPLACE VIEW PopularCourses AS
SELECT
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(e.StudentID) > 1;

-- Lösning till uppgift 4
CREATE OR REPLACE VIEW DramaHighRated AS
SELECT *
FROM Movies
WHERE Genre = 'Drama' AND Rating > 8.0;

-- Lösning till uppgift 5
CREATE OR REPLACE VIEW MovieShort AS
SELECT Title, Genre, Rating
FROM Movies;



-- =========================================================
-- CHEAT SHEET – VIEW (VYER)
-- =========================================================
-- Skapa ny vy:
--   CREATE VIEW VyNamn AS SELECT ...;

-- Uppdatera existerande vy:
--   CREATE OR REPLACE VIEW VyNamn AS SELECT ...;

-- Ta bort en vy:
--   DROP VIEW VyNamn;

-- Använda en vy:
--   SELECT * FROM VyNamn;

-- Fördelar:
--   ✔ återanvänd SELECT-frågor
--   ✔ gör SQL renare
--   ✔ förenklar JOINs
--   ✔ låser logik på ett ställe
-- =========================================================
