-- UTF-8 Encoding Test File
-- Filename: v20250522120000__UTF8_TEST_SAMPLE.sql

-- 👨‍💻 Developer: Test User
-- 🗓️ Date: 2025-05-22
-- 🧪 Purpose: Verify UTF-8 encoding support in automated workflows

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
(1, 'André', 'López', 'Engineering', 'Loves programming 💻 and AI 🤖.'),
(2, '李', '王', '研发部门', '擅长Python和数据科学。'),
(3, 'Miyuki', 'さくら', '設計部門', 'アートとデザインに情熱を持っている。'),
(4, 'Zoë', 'Façade', 'Design', 'Creative strategist 🎨 with a love for UX.'),
(5, 'Jürgen', 'Özil', 'R&D', 'Expert in IoT and embedded systems 🔧.');

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
(3, '研发部门'),
(4, '設計部門'),
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
