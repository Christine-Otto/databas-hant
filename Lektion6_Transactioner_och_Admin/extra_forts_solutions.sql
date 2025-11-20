-- =========================================================
-- LÖSNINGAR: Teachers och Students
-- Källa: "Lösningar: Teachers och Students"
--
-- Förutsätter:
--   - Att tabellerna Teachers och Students redan finns
--   - Att de är fyllda med data enligt övningsfilen
--
-- Innehåll:
--   - Grundläggande CRUD
--   - LIKE-övningar
--   - Mängdoperatorer
--   - IN, BETWEEN, NOT, AND, OR
--   - Transaktioner (START TRANSACTION, COMMIT/ROLLBACK)
-- =========================================================



/* =========================================================
   AVSNITT 1: GRUNDLÄGGANDE CRUD
   ========================================================= */

-- 1. Visa alla lärare.
--    Hämtar alla kolumner och rader i tabellen Teachers.
SELECT *
FROM Teachers;


-- 2. Visa namn och anställningsdatum.
--    Hämtar bara två kolumner: name och hiring_date.
SELECT
    name,
    hiring_date
FROM Teachers;


-- 3. Studenter som är 20 år eller äldre.
--    Filtrerar med WHERE på ålder >= 20.
SELECT *
FROM Students
WHERE age >= 20;


-- 4. Lägg till en ny student.
--    Lägger till en rad i Students med angivna värden.
INSERT INTO Students (name, age, class, enrollment_year)
VALUES ('Erik Svensson', 21, 'DevOps', '2020');


-- 5. Öka alla löner med 1000.
--    Uppdaterar salary-kolumnen för ALLA lärare.
UPDATE Teachers
SET salary = salary + 1000;


-- 6. Ta bort en lärare via teacher_id.
--    Tar bort just den lärare vars teacher_id = 1.
DELETE FROM Teachers
WHERE teacher_id = 1;


-- 7. Sortera studenter efter ålder (fallande).
--    Sorterar så att äldsta studenten hamnar först.
SELECT *
FROM Students
ORDER BY age DESC;


-- 8. Räkna antalet lärare.
--    COUNT(*) räknar hur många rader det finns i Teachers.
SELECT COUNT(*) AS teacher_count
FROM Teachers;


-- 9. Hitta studenter vars namn börjar på E.
--    LIKE 'E%' betyder: namn som börjar med bokstaven E.
SELECT *
FROM Students
WHERE name LIKE 'E%';


-- 10. Studenter som anslöt mellan 2019 och 2021.
--     BETWEEN inkluderar både start- och slutvärdet.
SELECT *
FROM Students
WHERE enrollment_year BETWEEN '2019' AND '2021';



/* =========================================================
   AVSNITT 2: LIKE-ÖVNINGAR
   ========================================================= */

-- 1. Börjar på E.
--    Samma som tidigare: prefixmatchning med 'E%'.
SELECT *
FROM Students
WHERE name LIKE 'E%';


-- 2. Slutar på n.
--    '%n' betyder: valfri början, men slutar med n.
SELECT *
FROM Students
WHERE name LIKE '%n';


-- 3. Innehåller "an".
--    '%an%' betyder: "an" någonstans i strängen.
SELECT *
FROM Students
WHERE name LIKE '%an%';


-- 4. Börjar på A och går i DevOps.
--    Kombination av mönstermatchning + vanligt likhetskrav.
SELECT *
FROM Students
WHERE name LIKE 'A%'
  AND class = 'DevOps';


-- 5. Fem bokstäver i förnamnet.
--    '_____ %' = fem valfria tecken, sedan mellanslag och efternamn.
SELECT *
FROM Students
WHERE name LIKE '_____ %';


-- 6. Börjar på A eller B.
--    Två LIKE-villkor kombineras med OR.
SELECT *
FROM Students
WHERE name LIKE 'A%'
   OR name LIKE 'B%';



/* =========================================================
   AVSNITT 3: MÄNGDOPERATORER
   ========================================================= */

-- 1. Alla unika namn.
--    UNION slår ihop två resultat och tar bort dubbletter.
SELECT name FROM Teachers
UNION
SELECT name FROM Students;


-- 2. Alla namn inklusive dubbletter.
--    UNION ALL behåller alla rader, även om de är identiska.
SELECT name FROM Teachers
UNION ALL
SELECT name FROM Students;


-- 3. Gemensamma namn.
--    Väljer bara de namn i Teachers som också finns i Students.
SELECT name
FROM Teachers
WHERE name IN (SELECT name FROM Students);


-- 4. Lärarnamn som saknas bland studenter.
--    name NOT IN (...) = finns inte i resultatet från Students.
SELECT name
FROM Teachers
WHERE name NOT IN (SELECT name FROM Students);


-- 5. Studentnamn som saknas bland lärare.
--    Samma princip, men nu tvärtom.
SELECT name
FROM Students
WHERE name NOT IN (SELECT name FROM Teachers);


-- 6. Namn som börjar på A i båda tabellerna.
--    Filtrerar först per tabell, sedan UNION för att ta unika.
SELECT name FROM Teachers WHERE name LIKE 'A%'
UNION
SELECT name FROM Students WHERE name LIKE 'A%';


-- 7. Samtliga namn sorterade alfabetiskt.
--    UNION ALL för att behålla dubbletter, sedan ORDER BY name.
SELECT name FROM Teachers
UNION ALL
SELECT name FROM Students
ORDER BY name;


-- 8. Gemensamma namn som slutar på "son".
--    Begränsar Teachers till namn som slutar på "son" och
--    kontrollerar att de också finns i Students med samma slut.
SELECT name
FROM Teachers
WHERE name LIKE '%son'
  AND name IN (
      SELECT name
      FROM Students
      WHERE name LIKE '%son'
  );


-- 9. Lärarnamn som börjar på J och inte delas.
--    Börjar på J, men finns INTE bland Students.
SELECT name
FROM Teachers
WHERE name LIKE 'J%'
  AND name NOT IN (SELECT name FROM Students);



/* =========================================================
   AVSNITT 4: IN, BETWEEN, NOT, AND, OR
   ========================================================= */

-- 1. Studenter i DevOps eller Java.
--    IN (...) testar om värdet är ett av alternativen.
SELECT *
FROM Students
WHERE class IN ('DevOps', 'Java');


-- 2. Studenter mellan 19 och 21 år.
--    BETWEEN 19 AND 21 inkluderar 19, 20, 21.
SELECT *
FROM Students
WHERE age BETWEEN 19 AND 21;


-- 3. Inte DevOps eller Java.
--    NOT IN = klass är något annat än de listade.
SELECT *
FROM Students
WHERE class NOT IN ('DevOps', 'Java');


-- 4. Inte mellan 19 och 21 år.
--    NOT BETWEEN innebär: <19 eller >21.
SELECT *
FROM Students
WHERE age NOT BETWEEN 19 AND 21;


-- 5. Över 21 år och i DevOps.
--    Båda villkor måste vara sanna (AND).
SELECT *
FROM Students
WHERE age > 21
  AND class = 'DevOps';


-- 6. .NET eller över 21.
--    Minst ett av villkoren måste vara sant (OR).
SELECT *
FROM Students
WHERE class = '.NET'
   OR age > 21;


-- 7. Java och (≥21 eller <20).
--    Parenteserna styr ordningen på AND/OR-logiken.
SELECT *
FROM Students
WHERE class = 'Java'
  AND (age >= 21 OR age < 20);


-- 8. Inte DevOps men över 21.
--    <> betyder "inte lika med".
SELECT *
FROM Students
WHERE class <> 'DevOps'
  AND age > 21;


-- 9. Inte 19–21, klass DevOps/.NET, namn börjar på A.
--    Tre villkor kedjade med AND, en blandning av NOT BETWEEN, IN och LIKE.
SELECT *
FROM Students
WHERE age NOT BETWEEN 19 AND 21
  AND class IN ('DevOps', '.NET')
  AND name LIKE 'A%';



/* =========================================================
   AVSNITT 5: TRANSAKTIONER
   ========================================================= */

-- OBS:
--   Dessa exempel visar transaktioner (START TRANSACTION, ROLLBACK).
--   I verklig användning skulle du ofta använda COMMIT
--   när du är nöjd med ändringarna.


-- 1. Uppdatera ålder och ångra.
--    Ökar åldern på student_id = 1, tittar, sedan ROLLBACK.
START TRANSACTION;
UPDATE Students
SET age = age + 1
WHERE student_id = 1;

SELECT * FROM Students
WHERE student_id = 1;

ROLLBACK;


-- 2. Radera student och ångra.
--    Tar bort en student, räknar antalet, sedan ROLLBACK.
START TRANSACTION;
DELETE FROM Students
WHERE student_id = 2;

SELECT COUNT(*) FROM Students;

ROLLBACK;


-- 3. Öka lön och kontrollera innan COMMIT.
--    Här visar lösningen ROLLBACK,
--    men kommentaren påminner om att det kunde varit COMMIT.
START TRANSACTION;
UPDATE Teachers
SET salary = salary + 1000
WHERE teacher_id = 1;

SELECT salary
FROM Teachers
WHERE teacher_id = 1;

-- COMMIT eller ROLLBACK beroende på resultatet
ROLLBACK;


-- 4. Flera ändringar med ROLLBACK.
--    Ändrar flera rader, räknar, sedan ROLLBACK.
START TRANSACTION;
UPDATE Students
SET age = age + 1
WHERE class = 'Java';

DELETE FROM Students
WHERE age > 22;

SELECT COUNT(*)
FROM Students;

ROLLBACK;


-- 5. Lägg till och ta bort i samma transaktion.
--    Blandar INSERT och DELETE, sedan ROLLBACK.
START TRANSACTION;
INSERT INTO Students (name, age, class, enrollment_year)
VALUES ('Ny Student', 19, 'Python', '2024');

DELETE FROM Students
WHERE student_id = 3;

SELECT COUNT(*)
FROM Students;

ROLLBACK;


-- 6. Uppdatera båda tabellerna.
--    Ökar ålder på alla studenter, sänker lön på alla lärare.
START TRANSACTION;
UPDATE Students
SET age = age + 1;

UPDATE Teachers
SET salary = salary - 500;

SELECT AVG(age)    AS avg_age
FROM Students;

SELECT AVG(salary) AS avg_salary
FROM Teachers;

ROLLBACK;


-- 7. Villkorad COMMIT.
--    Kommentarerna beskriver: COMMIT om ett villkor uppfylls.
START TRANSACTION;
UPDATE Teachers
SET salary = salary + 2000
WHERE teacher_id = 4;

SELECT salary
FROM Teachers
WHERE teacher_id = 4;

-- COMMIT om lönen är < 60000, annars ROLLBACK
ROLLBACK;


-- 8. Säker radering.
--    Raderar en student, kollar hur många som är kvar,
--    COMMIT/ROLLBACK beroende på ett villkor (beskrivs i kommentar).
START TRANSACTION;
DELETE FROM Students
WHERE student_id = 5;

SELECT COUNT(*) FROM Students;

-- COMMIT om antalet > 10, annars ROLLBACK
ROLLBACK;


-- 9. Kombinera flera kommandon.
--    INSERT i Teachers, UPDATE i Students, DELETE i Teachers.
START TRANSACTION;
INSERT INTO Teachers (name, salary, hiring_date, employment_id)
VALUES ('Ny Lärare', 45000, '2020-01-01', 2100);

UPDATE Students
SET class = 'Data'
WHERE class = '.NET';

DELETE FROM Teachers
WHERE salary < 40000;

SELECT COUNT(*) AS teacher_count
FROM Teachers;

SELECT COUNT(*) AS student_count
FROM Students;

ROLLBACK;
