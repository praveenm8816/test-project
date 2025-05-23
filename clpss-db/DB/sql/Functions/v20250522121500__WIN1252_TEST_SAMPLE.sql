
-- WINDOWS-1252 Encoding Test File, dsbcbdsvcdshcbjdsc
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

-- Insert data with Windows-1252 specific characters: , , , , , , , 
INSERT INTO customer (id, name, comments) VALUES
(1, 'Rene', 'Uses the  symbol and quotes'),
(2, 'Andr', 'Prefers French cuisine  trs bon!'),
(3, 'Jrgen', 'Technischer Leiter  groartige Arbeit!'),
(4, 'Marta', 'Habla espaol con  y mucho ms.'),
(5, 'Franois', 'Le garon mange du pt avec got.');

-- Select query
SELECT * FROM customer;

-- END
