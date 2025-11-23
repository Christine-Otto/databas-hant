-- =========================================================
-- LEKTION 6 – EXERCISES: TRANSAKTIONER & ADMINISTRATION
-- Databashantering – DevOps 2025
-- =========================================================
-- Detta skript innehåller alla praktiska övningar för lektion 6.
-- Fokuserar på: TRANSAKTIONER, COMMIT/ROLLBACK, ANVÄNDARHANTERING,
-- PRIVILEGIER, BACKUP/RESTORE (simulerat).
-- =========================================================


-- =========================================================
-- ÖVNING 1 – TESTA EN ENKEL TRANSAKTION
-- =========================================================
-- Vi skapar en liten tabell för att testa transaktioner.

CREATE TABLE IF NOT EXISTS BankAccounts (
    AccountID INT PRIMARY KEY,
    Owner VARCHAR(100),
    Balance DECIMAL(10,2)
);

INSERT IGNORE INTO BankAccounts VALUES
(1, 'Anna', 1000.00),
(2, 'Björn', 1000.00);

-- Starta en transaktion
START TRANSACTION;

-- För över 100 kr från Anna till Björn
UPDATE BankAccounts SET Balance = Balance - 100 WHERE AccountID = 1;
UPDATE BankAccounts SET Balance = Balance + 100 WHERE AccountID = 2;

-- Spara ändringarna
COMMIT;

SELECT * FROM BankAccounts;


-- =========================================================
-- ÖVNING 2 – ROLLBACK
-- =========================================================
-- Testa att ångra ändringar.

START TRANSACTION;

UPDATE BankAccounts SET Balance = Balance - 500 WHERE AccountID = 1;
UPDATE BankAccounts SET Balance = Balance + 500 WHERE AccountID = 2;

-- Ångra ALLT
ROLLBACK;

SELECT * FROM BankAccounts;


-- =========================================================
-- ÖVNING 3 – SKAPA EN ANVÄNDARE
-- =========================================================
-- OBS: Byt lösenord innan du kör!

-- Skapa användare (endast local access)
CREATE USER IF NOT EXISTS 'testuser'@'localhost' IDENTIFIED BY 'password123';

-- Visa användare
SELECT User, Host FROM mysql.user;


-- =========================================================
-- ÖVNING 4 – GE RÄTTIGHETER
-- =========================================================
-- Ge SELECT och INSERT på school-databasen

GRANT SELECT, INSERT ON school.* TO 'testuser'@'localhost';

-- Uppdatera rättigheterna
FLUSH PRIVILEGES;

-- Visa användarens rättigheter
SHOW GRANTS FOR 'testuser'@'localhost';


-- =========================================================
-- ÖVNING 5 – TA BORT RÄTTIGHETER
-- =========================================================

REVOKE INSERT ON school.* FROM 'testuser'@'localhost';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'testuser'@'localhost';


-- =========================================================
-- ÖVNING 6 – RADERA ANVÄNDARE
-- =========================================================

DROP USER IF EXISTS 'testuser'@'localhost';

SELECT User, Host FROM mysql.user;


-- =========================================================
-- ÖVNING 7 – SIMULERA BACKUP/RESTORE (LOGISK ÖVNING)
-- =========================================================
-- Här kör vi inte backup
-- men visar de faktiska kommandona som används i MariaDB.
-- Dessa körs i terminal – inte SQLTools.

-- BACKUP (exportera databas)
-- mysqldump -u root -p school > school_backup.sql;

-- RESTORE (importera databas)
-- mysql -u root -p school < school_backup.sql;


-- =========================================================
-- ÖVNING 8 – TRANSAKTION + ISOLATION (VALFRI EXTRA)
-- =========================================================
-- Visa nuvarande isolationsnivå:
SHOW VARIABLES LIKE 'transaction_isolation';

-- Ändra isolationsnivå (valfritt, kräver ofta rättigheter):
-- SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;


-- =========================================================
-- SLUT – DU ÄR KLAR MED LEKTION 6 ÖVNINGAR!
-- =========================================================