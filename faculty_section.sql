-- === Member A (Joshua hotay): Students table ===

USE alu_db;

-- Create table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    enrollment_date DATE
);

-- Insert 5 sample rows
INSERT INTO Students (first_name, last_name, date_of_birth, email, enrollment_date) VALUES
('Aisha', 'Karenzi', '2008-03-15', 'aisha.k@school.edu', '2023-09-01'),
('Brian', 'Mugisha', '2007-11-02', 'brian.m@school.edu', '2023-09-01'),
('Cynthia', 'Iradukunda', '2008-06-20', 'cynthia.i@school.edu', '2023-09-01'),
('David', 'Niyonsenga', '2007-01-10', 'david.n@school.edu', '2023-09-01'),
('Esther', 'Uwimana', '2008-09-05', 'esther.u@school.edu', '2023-09-01');

-- UPDATE: change a student's email
UPDATE Students SET email = 'aisha.karenzi@school.edu' WHERE student_id = 1;

-- DELETE: remove a student
DELETE FROM Students WHERE student_id = 5;

-- SELECT with WHERE: find students enrolled on a specific date
SELECT * FROM Students WHERE enrollment_date = '2023-09-01';
SELECT * FROM Students;