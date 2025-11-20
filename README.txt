README – Arbetssätt i Databashantering

DevOps25 – MariaDB, VS Code och DBeaver

Den här guiden förklarar de tre arbetssätt du använder i databashantering:
            1. **DBeaver** – grafiskt verktyg (GUI)
            2. **VS Code + SQL-filer** – där du skriver dina SQL-övningar
            3. **VS Code + MariaDB-terminalen** – där du kör SQL och ser resultat

Alla tre arbetar mot **samma MariaDB-databas**, men på olika sätt.

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

DBeaver – grafiskt databasverktyg (GUI)
Vad är DBeaver?
            DBeaver är ett visuellt (grafiskt) program som låter dig se databasen med ögonen.
            Det fungerar ungefär som ett “Excel för databaser”.

            Du kan:
                - se tabeller
                - öppna rader visuellt
                - sortera, filtrera, söka
                - köra SQL-frågor i ett editorfönster
                - få en tydlig överblick över hela databasen

Perfekt när man lär sig och vill SE vad som händer.

Varför använder man DBeaver?
                - För att kontrollera resultat efter att du kört SQL-filer
                - För att visualisera data i tabeller (t.ex. Movies, Teachers, Students)
                - För att förstå datatyper, relationer och struktur
                - För att dubbelkolla att INSERT/UPDATE/DELETE fungerat korrekt

Hur startar du DBeaver?
Starta programmet som vanligt från din dator.
Hur ansluter du till MariaDB i DBeaver?
                1. Klicka på **New Connection**
                2. Välj **MariaDB**
                3. Fyll i:
                        * Host: `localhost`
                        * Port: `3306`
                        * User: `root`
                        * Password: ditt MariaDB-lösenord
                        * Database: t.ex. `school`
                4. Tryck **Test Connection**
                5. Spara

                Nu ser du alla tabeller i vänstermenyn.

Hur använder du DBeaver?
                * Expandera databasen
                * Expandera “Tables”
                * Högerklicka på en tabell → **View Data**
                * Se rader i tabellen visuellt
                * Skriv SQL i fliken "SQL Editor"

Efter du kör SQL i VS Code-terminalen → tryck **Refresh** för att se ändringarna.

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

VS Code + SQL-filer (.sql)
Vad är det?
        Det här är miljön där du **skriver all SQL-kod**.

Du arbetar med `.sql`-filer, en per lektionsövning, t.ex.:
                * `products_exercise.sql`
                * `movies_exercise.sql`
                * `teachers_students_exercise.sql`

Det här är precis som professionella utvecklare gör.

Varför använder man SQL-filer i VS Code?
                * Du kan spara allt du jobbar med
                * Du har ordning och struktur i din kursmapp
                * Du kan köra samma fil om och om igen
                * Det blir snyggt och organiserat för alla lektioner
                * Perfekt combo med Git längre fram

Hur använder du det?
                1. Öppna VS Code
                2. Öppna mappen `DATABASHANTERING`
                3. Klicka på valfri `.sql`-fil
                4. Skriv dina SQL-kommandon
                5. Spara filen (`Ctrl + S`)

                Du kör filerna i terminalen (se nästa arbetssätt).

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

VS Code + MariaDB-terminalen
Vad är det?
        Terminalen i VS Code där du kör kommandon direkt mot MariaDB.
        Det är här SQL-koden “på riktigt” körs mot din databas.
        Det är också exakt så riktiga DevOps och backendutvecklare jobbar.

Varför använder man terminalen?
                * För att köra hela SQL-filer
                * För att testa SQL-rader snabbt
                * För transaktioner (START TRANSACTION, COMMIT, ROLLBACK)
                * För att göra ändringar direkt i databasen
                * För att jobba proffsigt och snabbt

Hur startar du terminalen i VS Code?
                Menyrad → **Terminal** → **New Terminal**

    Eller tangentbord:
                Ctrl + Shift + ö

Hur loggar du in i MariaDB?
                mariadb -u root -p
    Sedan:
                USE school;

Hur kör du en hel SQL-fil?
Sätt 1 – Kör filen utifrån (snabbt)
                mariadb -u root -p school < teachers_students_exercise.sql

Sätt 2 – Kör filen inifrån MariaDB-shell
                SOURCE teachers_students_exercise.sql;

Resultat visas direkt i terminalen.

Hur testar du att tabellerna finns?
    SHOW TABLES;
                SELECT * FROM Teachers;
                SELECT * FROM Students;

När ska du använda terminalen?
                * När du jobbar igenom lektionsövningar
                * När du kör `.sql`-filer som skapar tabeller
                * När du testar CRUD / JOIN / INDEX / TRANSACTION
                * När du vill se SQL-respons direkt

------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

Hur alla tre sätt hänger ihop

| Arbetssätt              | Vad gör man där?                | När använder man det?                              |
| ----------------------- | ------------------------------- | -------------------------------------------------- |
| **DBeaver**             | Visuell inspektion av databasen | När du vill *se* tabeller och data                 |
| **VS Code + SQL-filer** | Skriva + spara all SQL-kod      | När du jobbar med övningar & lösningar             |
| **VS Code + Terminal**  | Köra SQL, skapa tabeller, testa | När du vill exekvera filer & köra SQL “på riktigt” |

Alla tre använder **samma MariaDB-databas** på `localhost:3306`.
Så ändringar i ett verktyg syns automatiskt i de andra.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------         

Sammanfattning
                * Du skriver SQL i VS Code
                * Du kör SQL i VS Code-terminalen
                * Du ser resultatet visuellt i DBeaver

Det är en **professionell arbetsprocess** — exakt som i riktiga DevOps-jobb.

