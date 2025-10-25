-- Save this as employee_data.sql
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary INTEGER
);

INSERT INTO employees (name, department, salary) VALUES
('John', 'Engineering', 75000),
('Alice', 'Marketing', 62000),
('Bob', 'Engineering', 68000),
('Diana', 'HR', 60000),
('Eve', 'Marketing', 64000);
