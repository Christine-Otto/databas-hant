Lektion 6 – Transaktioner, Administration & Drift

Lektion 6 handlar om hur databaser hanteras i verkliga system: säkerhet, transaktioner, användarhantering, säkerhetskopiering, rättigheter, samt hur databasen beter sig när flera användare arbetar samtidigt. Detta är en mer praktisk och driftsinriktad del av kursen.

Syftet med lektion 6
        - Förstå vad **transaktioner** är och varför de används
        - Kunna använda `START TRANSACTION`, `COMMIT`, `ROLLBACK`
        - Hantera användare och rättigheter
        - Skapa och ta bort användare i MariaDB
        - Ge och ta bort privilegier
        - Förstå databasadministration på grundnivå
        - Lära dig backups och restores
        - Förstå ACID och varför det är viktigt

ACID – kärnan i en transaktion
Transaktioner i databaser följer ACID-principen:

**A – Atomicity**
        Allt lyckas eller allt misslyckas. Ingen halvfärdig data.

**C – Consistency**
        Databasen ska alltid befinna sig i ett giltigt tillstånd.

**I – Isolation**
        Transaktioner ska inte störa varandra.

**D – Durability**
        När en transaktion är committad ska den sparas permanent.

Transaktioner i SQL
Transaktioner används när du gör flera ändringar som hör ihop.

        Starta en transaktion
        START TRANSACTION;

        Spara ändringarna
        COMMIT;

        Ångra allt i transaktionen
        ROLLBACK;

Exempel

START TRANSACTION;
        UPDATE Accounts SET Balance = Balance - 100 WHERE ID = 1;
        UPDATE Accounts SET Balance = Balance + 100 WHERE ID = 2;
        COMMIT;

Om något går fel → `ROLLBACK;` så att inga pengar "försvinner".

Isolation Levels (översikt)
Olika nivåer som avgör hur transaktioner isoleras från varandra:
        - Read Uncommitted
        - Read Committed
        - Repeatable Read
        - Serializable

I denna kurs räcker det att förstå att högre isolering = säkrare men långsammare.

Användarhantering i MariaDB
I lektion 6 ingår även att skapa och administrera användare.
    Skapa användare:
                CREATE USER 'användare'@'localhost' IDENTIFIED BY 'lösenord';

    Ge rättigheter
                GRANT ALL PRIVILEGES ON databas.* TO 'användare'@'localhost';

    Ta bort rättigheter
                REVOKE ALL PRIVILEGES ON databas.* FROM 'användare'@'localhost';

    Ta bort användare
                DROP USER 'användare'@'localhost';

    Uppdatera privilegier
                FLUSH PRIVILEGES;

Säkerhetskopiering & återställning
    Backup (export)
                Använd `mysqldump`:
                mysqldump -u root -p databas > backup.sql

    Restore (import)
                mysql -u root -p databas < backup.sql

Detta är grunden i alla databasadmins arbete.

Roller & säkerhet
          - Begränsa rättigheter per användare
          - Använd minst privilegium-principen
          - Konton för utveckling ska inte ha adminrättigheter

Miniövningar för lektion 6
          1. Skapa en ny användare och ge SELECT-rättigheter.
          2. Ta bort INSERT-rättigheter från samma användare.
          3. Skapa en transaktion och ändra flera rader.
          4. Testa att göra en ROLLBACK.
          5. Ta backup på school-databasen.
          6. Återskapa den i en testdatabas.

Vad du lärde dig i lektion 6
          - Hur databaser skyddas från dataförlust
          - Varför transaktioner är livsvikiga i riktiga system
          - Hur man använder COMMIT och ROLLBACK
          - Hur man skapar och styr rättigheter för användare
          - Hur backup och restore fungerar

Status: Lektion 6
Du har nu en full förståelse av:
          - Transaktioner (START → COMMIT/ROLLBACK)
          - ACID
          - Användarhantering
          - Privilegier i MariaDB
          - Backup/restore

Redo för Lektion 7: NoSQL och alternativa databassystem!
