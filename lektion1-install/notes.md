
Lektion 1 – SQL Intro & Installation

Databashantering – DevOps 2025
                Denna lektion handlar om att sätta upp en fungerande SQL-miljö, förstå grundstrukturen och kunna köra de första enkla kommandona i MariaDB.

Syftet med lektion 1
            - Installera MariaDB (databasmotor)
            - Installera VS Code som utvecklingsmiljö
            - Installera SQLTools i VS Code
            - Testa första SQL-kommandona
            - Verifiera att allt fungerar som det ska
            -Skapa mappstruktur för kursen

Installationer som är gjorda
            - MariaDB installerad
            - Version: MariaDB 12.x
            - Startas via kommandot: mysql -u root -p

VS Code installerat
            Extensions:
            - SQLTools
            - SQLTools MariaDB/MySQL Driver
            - (Valfritt: Material Icon Theme)

Kommandoterminal fungerar
            - Vi kan starta MariaDB via: mysql -u root -p

SQLTools-anslutning i VS Code
            - Connection name: Local MariaDB
            - Host: localhost
            - User: root
            - Port: 3306
            - Status: Connection successful

Mappstruktur skapad för kursen
            Grundstruktur i Databashantering:
                Lektion1_SQL_Intro_Installation
                Lektion2_SQL_Grunder_Products
                Lektion3_SQL_Movies_Views
                Lektion4_Design_och_Joins
                Lektion5_Index_och_Functions
                Bonus

Lektion 1 innehåller denna notes-fil samt eventuella skärmdumpar.

Första SQL-kommandona (testade och fungerar)
            -- Test att databasen fungerar
            SELECT 1;

            -- Visa alla databaser
            SHOW DATABASES;

            -- Välj databas
            USE school;

            -- Testa enkel SELECT
            SELECT 'Hej från MariaDB!';

Vad jag lärde mig i lektion 1
            - Vad en databas är (databas → tabeller → rader → kolumner)
            - Vad SQL betyder (Structured Query Language)
            - Skillnaden mellan SQL-motor (MariaDB) och SQL-editor (VS Code)
            - Hur man kör SQL i terminalen
            - Hur man kör SQL i VS Code med SQLTools
            - Hur filstrukturen i kursen ska se ut
