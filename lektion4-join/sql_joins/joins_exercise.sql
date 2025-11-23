-- =========================================================
-- JOINS EXERCISE – SCHOOL-DATABASEN
-- =========================================================
-- Syfte: Träna på INNER JOIN, LEFT JOIN, RIGHT JOIN (alt),
-- flera tabeller, gruppering och filtrering.
--
-- Tabeller i detta skript:
--   Students      – elever
--   Courses       – kurser
--   Enrollments   – koppling mellan elever och kurser (many-to-many)
--
-- Allting är skrivet för databasen "school".
-- =========================================================


-- =========================================================
-- FÖRBEREDELSE: SKAPA TABELLER (SÄKERT MED IF NOT EXISTS)
-- =========================================================

CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName  VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Courses (
    CourseID   INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Teacher    VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID    INT,
    CourseID     INT,
    Grade        CHAR(1),
    CONSTRAINT fk_enroll_student FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_enroll_course  FOREIGN KEY (CourseID)  REFERENCES Courses(CourseID)
);



-- =========================================================
-- FYLL PÅ MED TESTDATA (INSERT IGNORE = TÅL ATT KÖRAS FLERA GÅNGER)
-- =========================================================

INSERT IGNORE INTO Students (StudentID, FirstName, LastName) VALUES
    (1, 'Anna',   'Andersson'),
    (2, 'Björn',  'Berg'),
    (3, 'Cecilia','Carlsson'),
    (4, 'David',  'Dahl'),
    (5, 'Erik',   'Ek');

INSERT IGNORE INTO Courses (CourseID, CourseName, Teacher) VALUES
    (10, 'Databaser',   'Maria Nilsson'),
    (11, 'Programmering', 'Oskar Svensson'),
    (12, 'Nätverk',     'Lina Johansson');

INSERT IGNORE INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
    (100, 1, 10, 'A'),
    (101, 1, 11, 'B'),
    (102, 2, 10, 'C'),
    (103, 2, 12, 'B'),
    (104, 3, 11, 'A'),
    (105, 4, 10, 'B');
    -- Notera: Student 5 (Erik) är inte inskriven på någon kurs än.



-- =========================================================
-- UPPGIFT 1 – INNER JOIN (STANDARDJOIN)
-- Lista alla elever som är inskrivna på en kurs,
-- tillsammans med kursens namn.
-- =========================================================

SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID = c.CourseID;



-- =========================================================
-- UPPGIFT 2 – LEFT JOIN
-- Lista alla elever, även de som INTE har några kurser.
-- Om eleven saknar kurs ska kurskolumnen bli NULL.
-- =========================================================

SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c     ON e.CourseID = c.CourseID
ORDER BY s.StudentID;



-- =========================================================
-- UPPGIFT 3 – VILKA KURSER HAR EN VIS ELEV?
-- Exempel: alla kurser som Anna (StudentID = 1) läser.
-- =========================================================

SELECT
    s.FirstName,
    s.LastName,
    c.CourseName,
    e.Grade
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID = c.CourseID
WHERE s.StudentID = 1;



-- =========================================================
-- UPPGIFT 4 – FILTRERA MED JOIN
-- Visa alla elever som läser kursen "Databaser".
-- =========================================================

SELECT
    s.FirstName,
    s.LastName,
    c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Databaser';



-- =========================================================
-- UPPGIFT 5 – RÄKNA ANTALET KURSER PER ELEV (GROUP BY + JOIN)
-- =========================================================

SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    COUNT(e.CourseID) AS NumberOfCourses
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName
ORDER BY NumberOfCourses DESC;



-- =========================================================
-- UPPGIFT 6 – HÄMTA ELEVER SOM INTE HAR NÅGON KURS
-- Tips: använd LEFT JOIN + WHERE ... IS NULL
-- =========================================================

SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL;



-- =========================================================
-- UPPGIFT 7 – VILKA ELEVER HAR BETYG 'A' PÅ NÅGON KURS?
-- =========================================================

SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName,
    e.Grade
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID = c.CourseID
WHERE e.Grade = 'A';



-- =========================================================
-- UPPGIFT 8 – ANTAL ELEVER PER KURS
-- =========================================================

SELECT
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
ORDER BY NumberOfStudents DESC;



-- =========================================================
-- UPPGIFT 9 – JOIN + HAVING
-- Visa de kurser som har fler än 1 elev.
-- =========================================================

SELECT
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(e.StudentID) > 1;



-- =========================================================
-- JOIN CHEAT SHEET – KORT ÖVERSIKT
-- =========================================================
-- INNER JOIN:
--  - Tar bara med rader där det finns matchande värden
--    i båda tabellerna.
--
--   SELECT ...
--   FROM A
--   INNER JOIN B ON A.id = B.a_id;
--
-- LEFT JOIN:
--  - Tar med ALLA rader från vänster tabell (A),
--    och matchar från höger tabell (B) om det finns.
--    Saknas match → B-kolumnerna blir NULL.
--
--   SELECT ...
--   FROM A
--   LEFT JOIN B ON A.id = B.a_id;
--
-- RIGHT JOIN (finns ej alltid i MariaDB, kan ersättas med LEFT JOIN
--             genom att byta plats på tabellerna):
--
--   SELECT ...
--   FROM B
--   LEFT JOIN A ON B.a_id = A.id;
--
-- Flera JOINs:
--   SELECT ...
--   FROM A
--   JOIN B ON ...
--   JOIN C ON ...;
--
-- Bra mönster att komma ihåg:
--   1. Börja med FROM + huvuddtabell (t.ex. Students).
--   2. Lägg till JOIN + ON med kopplingen.
--   3. Testa alltid först med SELECT * för att se om resultatet ser rimligt ut.
--   4. Lägg på WHERE, GROUP BY, HAVING och ORDER BY i nästa steg.
-- =========================================================
