-- =========================================================
-- LEKTION 7 – NO SQL & ANDRA DATABASER (ÖVNINGAR)
-- Databashantering – DevOps 2025
-- =========================================================
-- Denna övningsfil är teoretisk + praktisk där det är möjligt.
-- NoSQL körs inte i MariaDB, men vi jämför och simulerar strukturer.
-- Här tränar du:
--   ✔ Konvertera SQL-data → NoSQL-format (JSON)
--   ✔ Förstå dokumentdatabas-struktur
--   ✔ Förstå key-value och grafmodeller
--   ✔ Kombinera SQL + NoSQL i verkliga scenarier
-- =========================================================


-- =========================================================
-- ÖVNING 1 – KONVERTERA SQL-TABELL → JSON-DOKUMENT
-- =========================================================
-- Ta 1 rad från Movies-tabellen och "översätt" den till JSON.
-- (Detta är inte körbar SQL — men en jämförelseövning.)

-- SQL-version:
-- SELECT * FROM Movies WHERE MovieID = 1;

-- NoSQL / Dokumentdatabas-version:
-- {
--   "MovieID": 1,
--   "Title": "Inception",
--   "ReleaseYear": 2010,
--   "Genre": ["Sci-Fi", "Action"],
--   "Rating": 8.8,
--   "Director": {
--       "FirstName": "Christopher",
--       "LastName": "Nolan"
--   }
-- }


-- =========================================================
-- ÖVNING 2 – GÖR OM EN SQL-RELATION TILL DOKUMENTFORMAT
-- =========================================================
-- Vi har Students, Courses och Enrollments som relationsdata.
-- I NoSQL kan man ibland lägga in allt i ett enda dokument.

-- Exempel på hur STUDENT + KURSER kan se ut i en dokumentdatabas:
-- {
--   "StudentID": 1,
--   "Name": "Anna Andersson",
--   "Courses": [
--       { "CourseID": 10, "CourseName": "Databaser", "Grade": "A" },
--       { "CourseID": 11, "CourseName": "Programmering", "Grade": "B" }
--   ]
-- }


-- =========================================================
-- ÖVNING 3 – KEY-VALUE STORE (REDIS-LIKNANDE)
-- =========================================================
-- Skriv hur en orderrad från Orders-tabellen skulle se ut
-- i ett key-value-system.

-- SQL-version:
-- SELECT * FROM Orders WHERE OrderID = 1;

-- Key-Value representation:
-- KEY: order:1
-- VALUE:
-- {
--   "CustomerName": "Anna Andersson",
--   "City": "Stockholm",
--   "TotalAmount": 1200.50,
--   "OrderDate": "2024-01-10"
-- }


-- =========================================================
-- ÖVNING 4 – GRAF-DATABASMODELL (Neo4j-stil)
-- =========================================================
-- Grafdatabaser representerar relationer som "noder" och "edges".
-- Här översätter du Students + Courses till en grafmodell.

-- Noder:
-- (Student {id: 1, name: "Anna"})
-- (Course  {id: 10, name: "Databaser"})
-- (Course  {id: 11, name: "Programmering"})

-- Relationer:
-- (Student)-[:ENROLLED_IN {grade: "A"}]->(Course)


-- =========================================================
-- ÖVNING 5 – JÄMFÖR SQL & NoSQL
-- =========================================================
-- Fyll i svaren (teoretiskt) direkt i filen.

-- 5a. När är SQL bättre än NoSQL?
-- Svar:

-- 5b. När är NoSQL bättre än SQL?
-- Svar:

-- 5c. Ge exempel på en app som använder båda.
-- Svar:


-- =========================================================
-- ÖVNING 6 – SKAPA ETT EGET NO SQL-DOKUMENT
-- =========================================================
-- Välj valfri tabell du har (Products, Movies, Students, Courses).
-- Skriv hur en rad i den tabellen skulle se ut som JSON.

-- Exempel:
-- {
--   "ProductID": 1,
--   "ProductName": "Apple",
--   "Price": 5.00,
--   "Category": "Food"
-- }


-- =========================================================
-- ÖVNING 7 – HYBRIDMODELL (SQL + NoSQL)
-- =========================================================
-- Skriv ett scenario där du kombinerar SQL + NoSQL i samma system.
-- (Väldigt vanligt i moderna företag.)

-- Exempelidéer:
-- SQL för kunder/order, NoSQL för loggar
-- SQL för filmer, NoSQL för rekommendationer
-- SQL för användare, NoSQL för sessionsdata

-- Svar:


-- =========================================================
-- SLUT PÅ LEKTION 7-ÖVNINGAR
-- =========================================================
