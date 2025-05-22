
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

-- Insert data with Windows-1252 specific characters: €, ‚, “, ”, …, ñ, ü, ç
INSERT INTO customer (id, name, comments) VALUES
(1, 'Renée', 'Uses the € symbol and “quotes”…'),
(2, 'André', 'Prefers French cuisine – très bon!'),
(3, 'Jürgen', 'Technischer Leiter – großartige Arbeit!'),
(4, 'Marta', 'Habla español con ñ y mucho más.'),
(5, 'François', 'Le garçon mange du pâté avec goût.');

-- Select query
SELECT * FROM customer;

-- END
