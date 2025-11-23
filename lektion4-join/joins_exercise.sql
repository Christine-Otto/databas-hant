Här kommer en **färdig, noggrant kommenterad `joins_exercise.sql`** som du kan klistra in direkt i din fil i VS Code. 💛
Ingen markdown, bara ren text.

---

-- =========================================================
-- JOINS_EXERCISE.SQL
-- Lektion 4 – Databasdesign & JOINs (Students, Courses, Enrollments)
-- Komplett övningsfil med kommentarer så du kan plugga och repetera.
-- =========================================================

-- =========================================================
-- STEG 1: SKAPA TABELLERNA (OM DE INTE REDAN FINNS)
-- =========================================================
-- Vi använder tre tabeller:
--   Students     – elever
--   Courses      – kurser
--   Enrollments  – koppling mellan elev och kurs (many-to-many)
----------------------------------------------------------------

-- IF NOT EXISTS gör att skriptet inte kraschar om tabellen redan finns.

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
-- STEG 2: FYLL PÅ MED EXEMPEL-DATA
-- =========================================================
-- INSERT IGNORE gör att samma rad inte läggs in två gånger
-- om du kör skriptet flera gånger.

INSERT IGNORE INTO Students (StudentID, FirstName, LastName) VALUES
(1, 'Anna',    'Andersson'),
(2, 'Björn',   'Berg'),
(3, 'Cecilia', 'Carlsson'),
(4, 'David',   'Dahl'),
(5, 'Erik',    'Ek');

INSERT IGNORE INTO Courses (CourseID, CourseName, Teacher) VALUES
(10, 'Databaser',      'Maria Nilsson'),
(11, 'Programmering',  'Oskar Svensson'),
(12, 'Nätverk',        'Lina Johansson');

INSERT IGNORE INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(100, 1, 10, 'A'),
(101, 1, 11, 'B'),
(102, 2, 10, 'C'),
(103, 2, 12, 'B'),
(104, 3, 11, 'A'),
(105, 4, 10, 'B');
-- Notera: Student 5 (Erik) är INTE inskriven på någon kurs ännu.

-- =========================================================
-- STEG 3: KONTROLLERA ATT DATA FINNS
-- =========================================================

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;

-- =========================================================
-- GRUND – VAD ÄR EN JOIN?
-- =========================================================
-- En JOIN kopplar ihop rader från flera tabeller baserat på en relation.
-- Här kopplar vi ihop:
--   Students.StudentID   ↔ Enrollments.StudentID
--   Courses.CourseID     ↔ Enrollments.CourseID
------------------------------------------------

-- Vi använder tabellalias:
--   s = Students
--   e = Enrollments
--   c = Courses
-- Detta gör frågorna enklare att läsa.

-- =========================================================
-- ÖVNING 1 – INNER JOIN: VISA ELEVER MED SINA KURSER
-- =========================================================
-- INNER JOIN tar bara med rader där det finns match i båda tabellerna.
-- Här ser vi bara elever som HAR minst en kurs.

SELECT
s.StudentID,
s.FirstName,
s.LastName,
c.CourseName,
e.Grade
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID = c.CourseID
ORDER BY s.StudentID, c.CourseName;

-- =========================================================
-- ÖVNING 2 – LEFT JOIN: VISA ALLA ELEVER (ÄVEN UTAN KURS)
-- =========================================================
-- LEFT JOIN tar med ALLA rader i vänster tabell (Students),
-- även om det inte finns några rader i Enrollments.
-- Elever utan kurs får NULL i kurskolumnerna.

SELECT
s.StudentID,
s.FirstName,
s.LastName,
c.CourseName,
e.Grade
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c     ON e.CourseID = c.CourseID
ORDER BY s.StudentID;

-- =========================================================
-- ÖVNING 3 – VILKA KURSER LÄSER EN VISST ELEV?
-- =========================================================
-- Exempel: Alla kurser som Anna (StudentID = 1) läser.

SELECT
s.StudentID,
s.FirstName,
s.LastName,
c.CourseName,
e.Grade
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID = c.CourseID
WHERE s.StudentID = 1;

-- =========================================================
-- ÖVNING 4 – FILTRERA PÅ KURS: VEM LÄSER “DATABASER”?
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
WHERE c.CourseName = 'Databaser'
ORDER BY s.LastName, s.FirstName;

-- =========================================================
-- ÖVNING 5 – ANTAL KURSER PER ELEV (GROUP BY + JOIN)
-- =========================================================
-- Vi vill se hur många kurser varje elev är inskriven på.
-- LEFT JOIN gör att elever utan kurser också syns (med 0).

SELECT
s.StudentID,
CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
COUNT(e.CourseID) AS NumberOfCourses
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName
ORDER BY NumberOfCourses DESC, StudentName;

-- =========================================================
-- ÖVNING 6 – VISA ELEVER SOM INTE HAR NÅGON KURS
-- =========================================================
-- LEFT JOIN + WHERE e.EnrollmentID IS NULL
-- betyder: elever där det inte fanns någon matchning i Enrollments.

SELECT
s.StudentID,
s.FirstName,
s.LastName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL;

-- =========================================================
-- ÖVNING 7 – VILKA ELEVER HAR BETYG 'A' PÅ NÅGON KURS?
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
WHERE e.Grade = 'A'
ORDER BY s.LastName, s.FirstName;

-- =========================================================
-- ÖVNING 8 – HUR MÅNGA ELEVER HAR VARJE KURS?
-- =========================================================
-- Vi räknar antal elever per kurs med COUNT + GROUP BY.

SELECT
c.CourseName,
COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
ORDER BY NumberOfStudents DESC, c.CourseName;

-- =========================================================
-- ÖVNING 9 – KURSER MED FLER ÄN 1 ELEV (HAVING)
-- =========================================================
-- WHERE kan inte filtrera på ett COUNT-resultat,
-- därför använder vi HAVING för att begränsa grupperna.

SELECT
c.CourseName,
COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(e.StudentID) > 1
ORDER BY NumberOfStudents DESC;

-- =========================================================
-- EXTRAÖVNINGAR (FRIVILLIGA)
-- =========================================================
-- 1. Visa alla elever som läser mer än 1 kurs.
--    Tips: använd GROUP BY på Students + HAVING COUNT(*) > 1.
--------------------------------------------------------------

-- 2. Visa alla kurser där minst en elev har betyg A.
--    Tips: WHERE Grade = 'A' + DISTINCT.
-----------------------------------------

-- 3. Visa en lista över elever + hur många kurser de har,
--    sorterat så att elever utan kurser hamnar längst ner.
-----------------------------------------------------------

-- Exempel-lösning till 1:
-- SELECT
--   s.StudentID,
--   CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
--   COUNT(e.CourseID) AS NumberOfCourses
-- FROM Students s
-- JOIN Enrollments e ON s.StudentID = e.StudentID
-- GROUP BY s.StudentID, s.FirstName, s.LastName
-- HAVING COUNT(e.CourseID) > 1;
-- =========================================================

-- =========================================================
-- SAMMANFATTNING – VAD TRÄNAR DU I JOINS_EXERCISE.SQL?
-- =========================================================
-- ✔ Hur tabeller hänger ihop (Students, Courses, Enrollments)
-- ✔ PRIMARY KEY och FOREIGN KEY i praktiken
-- ✔ INNER JOIN – bara rader med match på båda sidor
-- ✔ LEFT JOIN  – alla rader från vänster tabell, även utan match
-- ✔ Flera JOINs i samma fråga (3 tabeller)
-- ✔ Filtrering efter JOIN (WHERE c.CourseName = ...)
-- ✔ GROUP BY och COUNT tillsammans med JOIN
-- ✔ HAVING för att filtrera på aggregat (t.ex. COUNT)
-- ✔ Hitta rader utan match (LEFT JOIN + IS NULL)
-------------------------------------------------

-- Tillsammans med lektion4_notes.md har du nu allt du behöver
-- för att förstå JOINs och relationer i lektion 4.
-- =========================================================
