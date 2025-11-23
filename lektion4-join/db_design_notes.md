Syftet med lektion 4

            - Förstå relationer mellan tabeller
            - Förstå PRIMARY KEY och FOREIGN KEY i praktiken
            - Lära dig läsa och skapa ER-diagram
            - Använda INNER JOIN, LEFT JOIN och fler joins korrekt
            - Kunna kombinera 2–3 tabeller i en SELECT
            - Bygga en many-to-many-relation via en mellantabell
            - Förbereda inför mer avancerade frågor i kommande lektioner

Mappstruktur för lektion 4

I mappen Lektion4_Design_och_Joins finns:
            - joins_exercise.sql – alla JOIN-övningar (Students, Courses, Enrollments)
            - db_design_notes.md – teori om ER-diagram, design, relationer

Viktiga begrepp i design & relationer
    PRIMARY KEY (unik nyckel)
              Identifierar en rad i tabellen. Exempel: `StudentID`, `CourseID`.

    FOREIGN KEY (främmande nyckel)
              Pekar på en primärnyckel i en annan tabell.

    Exempel:
  `Enrollments.StudentID → Students.StudentID`
  `Enrollments.CourseID → Courses.CourseID`

Relationstyper
    1 → M (en till många)
          En kurs kan ha många studenter.

    M → M (många till många)
          En student kan läsa många kurser → kräver mellantabell.
    
    1 → 1 (ovanligt)

Mellantabell (junction table)

Tabellen **Enrollments** skapar kopplingen mellan Students och Courses.
Tabellen som används i JOIN-övningarna

Du jobbar med tre tabeller:
    Students
        - StudentID
        - FirstName
        - LastName

    Courses
        - CourseID
        - CourseName
        - Teacher

    Enrollments
        - EnrollmentID
        - StudentID (FK)
        - CourseID (FK)
        - Grade

JOIN-typer du lär dig
    INNER JOIN
        Visar *endast* rader som matchar i båda tabellerna.

    LEFT JOIN
        Visar *alla* rader i vänster tabell, även om det saknas match i höger.

    RIGHT JOIN
        MariaDB saknar full RIGHT JOIN, men kan simuleras genom att byta plats på tabellerna.

Flera JOINs samtidigt
Du lär dig att kombinera:
        FROM Students s
        JOIN Enrollments e ON s.StudentID = e.StudentID
        JOIN Courses c ON e.CourseID = c.CourseID

Övningar i joins_exercise.sql
Du tränar på:
        1. INNER JOIN – visa studenter med sina kurser
        2. LEFT JOIN – visa alla studenter, även utan kurser
        3. Filtrera resultatet (t.ex. kurser för StudentID = 1)
        4. JOIN + WHERE (t.ex. elever som läser “Databaser”)
        5. GROUP BY + JOIN (antal kurser per elev)
        6. LEFT JOIN + IS NULL (elever utan kurser)
        7. JOIN + villkor (t.ex. betyg A)
        8. Antal elever per kurs
        9. HAVING + JOIN (kurser med fler än 1 elev)

Vad jag lärde mig i lektion 4
        - Hur tabeller hänger ihop i riktiga system
        - Hur man skapar relationer via foreign keys
        - Hur man ritar och tolkar ER-diagram
        - Hur JOINs kombinerar information mellan tabeller
        - Hur LEFT JOIN visar icke-matchande data
        - Hur man grupperar resultat från flera tabeller
        - Hur man filtrerar både före och efter JOIN

Status: Lektion 4 KLAR
Du har:
        - Full JOIN-övningsfil klar
        - Teorifil om design och ER-diagram
        - Förstått relationer mellan tabeller
        - Förberett all SQL inför lektionspassen

Redo för Lektion 5 (Index & Optimering)! 
