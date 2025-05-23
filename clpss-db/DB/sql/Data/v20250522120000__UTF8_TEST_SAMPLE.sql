-- UTF-8 Encoding Test Files,sample test file
-- Filename: v20250522120000__UTF8_TEST_SAMPLE.sql

-- ????? Developer: Test Users
-- ??? Date: 2025-05-22
-- ?? Purpose: Verify UTF-8 encoding support in automated workflows

DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department VARCHAR(100),
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert multilingual & special characters
INSERT INTO employee (id, first_name, last_name, department, bio) VALUES
(1, 'Andr?', 'L?pez', 'Engineering', 'Loves programming ?? and AI ??.'),
(2, '?', '?', '????', '??Python??????'),
(3, 'Miyuki', '???', '????', '??????????????????'),
(4, 'Zo?', 'Fa?ade', 'Design', 'Creative strategist ?? with a love for UX.'),
(5, 'J?rgen', '?zil', 'R&D', 'Expert in IoT and embedded systems ??.');

-- Simple SELECT
SELECT * FROM employee;

-- Advanced JOIN
DROP TABLE IF EXISTS department;

CREATE TABLE department (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO department (id, name) VALUES
(1, 'Engineering'),
(2, 'Design'),
(3, '????'),
(4, '????'),
(5, 'R&D');

SELECT e.first_name, e.last_name, d.name AS dept_name
FROM employee e
JOIN department d ON e.department = d.name;

-- Stored function (PostgreSQL-style)
CREATE OR REPLACE FUNCTION get_employee_count()
RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM employee);
END;
$$ LANGUAGE plpgsql;

-- View
CREATE OR REPLACE VIEW vw_engineers AS
SELECT * FROM employee WHERE department = 'Engineering';

-- END
