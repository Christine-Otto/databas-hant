-- =========================================================
-- SQL-ÖVNINGAR: TEACHERS OCH STUDENTS  (ÖVNINGSFIL)
-- Fil: extra_forts_exercise.sql
--
-- Fokus:
--   - Bygga ett litet "skolregister" med två tabeller:
--       * Teachers
--       * Students
--   - Öva:
--       * Grundläggande CRUD (SELECT, INSERT, UPDATE, DELETE)
--       * LIKE
--       * Mängdoperatorer (UNION, UNION ALL, IN osv.)
--       * IN, BETWEEN, NOT, AND, OR
--       * Transaktioner (START TRANSACTION, COMMIT, ROLLBACK)
--
-- OBS:
--   Detta är ENDAST ÖVNINGARNA.
--   Du skriver själv SQL-satserna under varje uppgift.
--   Lösningar finns i en separat lösningsfil.
-- =========================================================


-- =========================================================
-- STEG 0: Rensa bort gamla tabeller om de finns
-- Syfte:
--   - Göra filen körbar flera gånger utan "already exists"-fel
-- =========================================================

DROP TABLE IF EXISTS Teachers;
DROP TABLE IF EXISTS Students;


-- =========================================================
-- STEG 1: Skapa tabellen Teachers
-- Syfte:
--   - Skapa tabellen för lärare
--   - Träna på AUTO_INCREMENT + PRIMARY KEY + NOT NULL
-- =========================================================

CREATE TABLE Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,  -- autogenererat id
    name VARCHAR(100) NOT NULL,                 -- lärarens namn
    salary DECIMAL(10, 2) NOT NULL,             -- lön
    hiring_date DATE NOT NULL,                  -- anställningsdatum
    employment_id INT NOT NULL                  -- anställningsnummer
);


-- =========================================================
-- STEG 2: Skapa tabellen Students
-- Syfte:
--   - Skapa tabellen för studenter
--   - Träna på AUTO_INCREMENT + olika datatyper
-- =========================================================

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- autogenererat id
    name VARCHAR(100) NOT NULL,                 -- studentens namn
    age INT NOT NULL,                           -- ålder
    class VARCHAR(50) NOT NULL,                 -- klass, t.ex. 'DevOps'
    enrollment_year CHAR(4) NOT NULL            -- startår, t.ex. '2020'
);


-- =========================================================
-- STEG 3: Infoga testdata
-- Syfte:
--   - Få lämpliga exempelrader i båda tabellerna
--   - Dessa INSERT-satser finns i "legacy-materialet"
--   - Här skriver du in dem själv eller hittar på egna värden
-- =========================================================

-- TODO: Lägg in INSERT-satserna för Teachers här
-- Exempel-skelett:
-- INSERT INTO Teachers (name, salary, hiring_date, employment_id)
-- VALUES
--   ('Förnamn Efternamn', 45000.00, '2020-01-15', 1001),
--   (...);

-- TODO: Lägg in INSERT-satserna för Students här
-- Exempel-skelett:
-- INSERT INTO Students (name, age, class, enrollment_year)
-- VALUES
--   ('Student Namn', 21, 'DevOps', '2020'),
--   (...);



/* =========================================================
   UPPGIFTER: GRUNDLÄGGANDE CRUD
   ========================================================= */

-- 1. Visa alla lärare.
--    Tips: SELECT * FROM Teachers är en bra start.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Teachers;



-- 2. Visa namn och anställningsdatum.
--    Tips: Välj endast de två kolumnerna.

-- Skriv din lösning här:
-- SELECT name, hiring_date
-- FROM Teachers;



-- 3. Studenter som är 20 år eller äldre.
--    Tips: WHERE age >= 20.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 4. Lägg till en ny student.
--    Tips: Ange name, age, class, enrollment_year i INSERT.

-- Skriv din lösning här:
-- INSERT INTO Students (name, age, class, enrollment_year)
-- VALUES (...);



-- 5. Öka alla löner med 1000.
--    Tips: UPDATE Teachers SET salary = salary + 1000;

-- Skriv din lösning här:
-- UPDATE Teachers
-- SET ...;



-- 6. Ta bort en lärare via teacher_id.
--    Tips: DELETE FROM Teachers WHERE teacher_id = ...;

-- Skriv din lösning här:
-- DELETE FROM Teachers
-- WHERE ...;



-- 7. Sortera studenter efter ålder (fallande).
--    Tips: ORDER BY age DESC.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- ORDER BY ...;



-- 8. Räkna antalet lärare.
--    Tips: COUNT(*) returnerar totalen.

-- Skriv din lösning här:
-- SELECT COUNT(*) AS teacher_count
-- FROM Teachers;



-- 9. Hitta studenter vars namn börjar på E.
--    Tips: WHERE name LIKE 'E%'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 10. Studenter som anslöt mellan 2019 och 2021.
--     Tips: WHERE enrollment_year BETWEEN '2019' AND '2021'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



/* =========================================================
   UPPGIFTER: LIKE
   ========================================================= */

-- 1. Namn som börjar på E.
--    Tips: name LIKE 'E%'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 2. Namn som slutar på n.
--    Tips: name LIKE '%n'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 3. Namn som innehåller "an".
--    Tips: name LIKE '%an%'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 4. Namn som börjar på A och går i DevOps.
--    Tips: name LIKE 'A%' AND class = 'DevOps'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 5. Fem bokstäver i förnamnet.
--    Tips: _ matchar en bokstav, använd fem stycken.
--          T.ex. '_____ %' om du har för- + efternamn i samma fält.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 6. Namn som börjar på A eller B.
--    Tips: name LIKE 'A%' OR name LIKE 'B%'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



/* =========================================================
   UPPGIFTER: MÄNGDOPERATORER
   (Arbeta med namn från både Teachers och Students)
   ========================================================= */

-- 1. Alla unika namn.
--    Tips: UNION tar bort dubbletter.

-- Skriv din lösning här:
-- SELECT name FROM Teachers
-- UNION
-- SELECT name FROM Students;



-- 2. Alla namn inklusive dubbletter.
--    Tips: UNION ALL behåller allt.

-- Skriv din lösning här:
-- SELECT name FROM Teachers
-- UNION ALL
-- SELECT name FROM Students;



-- 3. Gemensamma namn.
--    Tips: Använd IN eller INNER JOIN för att hitta namn som finns i båda.

-- Skriv din lösning här:
-- SELECT name
-- FROM Teachers
-- WHERE name IN (SELECT name FROM Students);



-- 4. Lärarnamn som saknas bland studenter.
--    Tips: NOT IN eller LEFT JOIN ... WHERE student_name IS NULL.

-- Skriv din lösning här:
-- SELECT name
-- FROM Teachers
-- WHERE ...;



-- 5. Studentnamn som saknas bland lärare.
--    Tips: samma tänk fast tvärtom.

-- Skriv din lösning här:
-- SELECT name
-- FROM Students
-- WHERE ...;



-- 6. Namn som börjar på A i båda tabellerna.
--    Tips: filtrera innan du kombinerar.

-- Skriv din lösning här:
-- SELECT name FROM Teachers WHERE name LIKE 'A%'
-- UNION
-- SELECT name FROM Students WHERE name LIKE 'A%';



-- 7. Samtliga namn sorterade alfabetiskt.
--    Tips: UNION ALL följt av ORDER BY name.

-- Skriv din lösning här:
-- SELECT name FROM Teachers
-- UNION ALL
-- SELECT name FROM Students
-- ORDER BY name;



-- 8. Gemensamma namn som slutar på "son".
--    Tips: filtrera båda källorna med LIKE '%son' innan jämförelsen.

-- Skriv din lösning här:
-- SELECT name
-- FROM Teachers
-- WHERE name LIKE '%son'
--   AND name IN (
--       SELECT name FROM Students WHERE name LIKE '%son'
--   );



-- 9. Lärarnamn som börjar på J och inte delas med studenter.
--    Tips: name LIKE 'J%' AND name NOT IN (SELECT name FROM Students).

-- Skriv din lösning här:
-- SELECT name
-- FROM Teachers
-- WHERE ...;



/* =========================================================
   UPPGIFTER: IN, BETWEEN, NOT, AND, OR
   (Arbeta främst mot Students)
   ========================================================= */

-- 1. Studenter i DevOps eller Java.
--    Tips: class IN ('DevOps', 'Java').

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 2. Studenter mellan 19 och 21 år.
--    Tips: age BETWEEN 19 AND 21.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 3. Studenter som inte är i DevOps eller Java.
--    Tips: class NOT IN ('DevOps', 'Java').

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 4. Studenter som inte är mellan 19 och 21 år.
--    Tips: age NOT BETWEEN 19 AND 21.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 5. Över 21 år och i DevOps.
--    Tips: age > 21 AND class = 'DevOps'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 6. .NET-studenter eller de över 21.
--    Tips: class = '.NET' OR age > 21.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 7. Java-studenter som är >=21 eller <20.
--    Tips: class = 'Java' AND (age >= 21 OR age < 20).

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 8. Inte DevOps men över 21.
--    Tips: class <> 'DevOps' AND age > 21.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



-- 9. Inte mellan 19–21, klass DevOps/.NET, namn börjar på A.
--    Tips: kombinera age NOT BETWEEN 19 AND 21,
--          class IN ('DevOps', '.NET'),
--          name LIKE 'A%'.

-- Skriv din lösning här:
-- SELECT ...
-- FROM Students
-- WHERE ...;



/* =========================================================
   UPPGIFTER: TRANSAKTIONER
   ========================================================= */

-- 1. Uppdatera ålder och ångra.
--    Tips:
--      START TRANSACTION;
--      UPDATE ...
--      ROLLBACK;

-- Skriv din lösning här:
-- START TRANSACTION;
-- UPDATE Students
-- SET age = age + 1
-- WHERE student_id = ...;
-- -- Kontrollera med SELECT om du vill
-- ROLLBACK;



-- 2. Radera student och ångra.
--    Tips: samma mönster: DELETE ... + ROLLBACK.

-- Skriv din lösning här:
-- START TRANSACTION;
-- DELETE FROM Students
-- WHERE student_id = ...;
-- -- Kontrollera antal rader
-- ROLLBACK;



-- 3. Öka lön och kontrollera innan COMMIT.
--    Tips: UPDATE, SELECT, sedan COMMIT eller ROLLBACK.

-- Skriv din lösning här:
-- START TRANSACTION;
-- UPDATE Teachers
-- SET salary = salary + 1000
-- WHERE teacher_id = ...;
-- SELECT salary FROM Teachers WHERE teacher_id = ...;
-- -- COMMIT eller ROLLBACK här



-- 4. Flera ändringar med ROLLBACK.
--    Tips: gör flera UPDATE/DELETE och sedan ROLLBACK.

-- Skriv din lösning här:
-- START TRANSACTION;
-- -- flera UPDATE / DELETE här
-- ROLLBACK;



-- 5. Lägg till och ta bort i samma transaktion.
--    Tips: INSERT + DELETE, sedan besluta COMMIT/ROLLBACK.

-- Skriv din lösning här:
-- START TRANSACTION;
-- INSERT INTO Students (...);
-- DELETE FROM Students WHERE ...;
-- -- COMMIT eller ROLLBACK



-- 6. Uppdatera båda tabellerna.
--    Tips: två UPDATE i samma transaktion.

-- Skriv din lösning här:
-- START TRANSACTION;
-- UPDATE Students SET ...;
-- UPDATE Teachers SET ...;
-- -- COMMIT eller ROLLBACK



-- 7. Villkorad COMMIT.
--    Tips:
--      - uppdatera lön
--      - kolla SELECT salary
--      - COMMIT om villkor uppfylls, annars ROLLBACK (manuellt).

-- Skriv din lösning här:
-- START TRANSACTION;
-- UPDATE Teachers SET salary = salary + 2000 WHERE teacher_id = ...;
-- SELECT salary FROM Teachers WHERE teacher_id = ...;
-- -- Bestäm: COMMIT; eller ROLLBACK;



-- 8. Säker radering.
--    Tips:
--      - radera en rad
--      - kolla COUNT(*)
--      - COMMIT om antalet är rimligt.

-- Skriv din lösning här:
-- START TRANSACTION;
-- DELETE FROM Students WHERE student_id = ...;
-- SELECT COUNT(*) FROM Students;
-- -- COMMIT eller ROLLBACK



-- 9. Kombinera flera kommandon.
--    Tips: blanda INSERT, UPDATE, DELETE i samma transaktion.

-- Skriv din lösning här:
-- START TRANSACTION;
-- -- INSERT ...
-- -- UPDATE ...
-- -- DELETE ...
-- -- COMMIT eller ROLLBACK



-- =========================================================
-- SLUTKOLL: Visa allt i båda tabellerna
-- =========================================================

SELECT * FROM Teachers;
SELECT * FROM Students;
