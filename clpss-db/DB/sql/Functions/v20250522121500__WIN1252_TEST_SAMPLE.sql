
-- WINDOWS-1252 Encoding Test File
-- Filename: v20250522121500__WIN1252_TEST_SAMPLE.sql

-- Developer: Test User
-- Date: 2025-05-22
-- Purpose: Verify Windows-1252 encoding support in automated workflows

DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    comments TEXT
);

-- Insert data with Windows-1252 specific characters: ù, ù, ù, ù, ù, ù, ù, ù
INSERT INTO customer (id, name, comments) VALUES
(1, 'Renùe', 'Uses the ù symbol and ùquotesùù'),
(2, 'Andrù', 'Prefers French cuisine ù trùs bon!'),
(3, 'Jùrgen', 'Technischer Leiter ù groùartige Arbeit!'),
(4, 'Marta', 'Habla espaùol con ù y mucho mùs.'),
(5, 'Franùois', 'Le garùon mange du pùtù avec goùt.');

-- Select query
SELECT * FROM customer;

-- END
