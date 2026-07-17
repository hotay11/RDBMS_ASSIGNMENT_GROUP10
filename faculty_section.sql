-- Creating database for the project
CREATE DATABASE IF NOT EXISTS alu_db;

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


-- === Member B (Chavyra BANGADI): Classroom table ===

-- Step 1: Select the shared database so this table is created inside alu_db
USE alu_db;

-- Step 2: Create the Classroom table
-- classroom_id is the primary key, auto-incremented for each new room
-- room_number and building identify the physical location
-- capacity stores the maximum number of students the room can hold
CREATE TABLE Classroom (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number  VARCHAR(10)  NOT NULL,
    building     VARCHAR(50)  NOT NULL,
    capacity     INT          NOT NULL
);

-- Step 3: Insert 5 sample classrooms so the table has data to work with
INSERT INTO Classroom (room_number, building, capacity) VALUES
('101', 'Innovation Hall', 30),
('102', 'Innovation Hall', 25),
('201', 'Science Block',   40),
('202', 'Science Block',   35),
('305', 'Library Annex',   20);

-- Step 4: UPDATE - increase the capacity of room 201 in Science Block
-- This simulates a real-world change (e.g. the room was expanded)
UPDATE Classroom
SET capacity = 45
WHERE room_number = '201' AND building = 'Science Block';

-- Step 5: DELETE - remove room 305 in Library Annex from the table
-- This simulates a room being taken out of service
DELETE FROM Classroom
WHERE room_number = '305' AND building = 'Library Annex';

-- Step 6: SELECT with WHERE - retrieve every classroom located in Innovation Hall
-- Demonstrates filtering rows based on a specific column value
SELECT *
FROM Classroom
WHERE building = 'Innovation Hall';



-- Member C (Ezra Prince Situma): Faculty Table --

use alu_db;
CREATE TABLE Faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50)
);

INSERT INTO Faculty (name, email, department)
VALUES
('Dr. Alice Johnson','alice.johnson@alu.edu','Computer Science'),
('Prof. Brian Smith','brian.smith@alu.edu','Mathematics'),
('Dr. Catherine Brown','catherine.brown@alu.edu','Business'),
('Dr. Daniel Kim','daniel.kim@alu.edu','Engineering'),
('Prof. Emily Davis','emily.davis@alu.edu','Law');

UPDATE Faculty
SET department='Data Science'
WHERE faculty_id=1;

DELETE FROM Faculty
WHERE faculty_id=4;

SELECT *
FROM Faculty
WHERE department='Law';

-- === Member D (Manzi Luc Divin): Courses table ===
USE alu_db;

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

INSERT INTO Courses (course_name, credits, faculty_id, classroom_id) VALUES
('Introduction to Programming', 3, 1, 1),
('Database Systems', 4, 2, 2),
('Computer science', 3, 3, 3),
('Law', 2, 5, 4),
('Engineering Mechanics', 4, 1, 2);

-- UPDATE
UPDATE Courses
SET credits = 5
WHERE course_id = 2;

-- DELETE
DELETE FROM Courses
WHERE course_id = 4;

-- SELECT with WHERE
SELECT *
FROM Courses
WHERE credits = 4;
