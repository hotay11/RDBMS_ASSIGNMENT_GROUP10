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

-- Step 1: Create the Courses table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- Step 2: Insert 5 sample courses
INSERT INTO Courses (course_name, credits, faculty_id, classroom_id) VALUES
('Introduction to Programming', 3, 1, 1),
('Database Systems', 4, 2, 2),
('Computer Science', 3, 3, 3),
('Law', 2, 5, 4),
('Engineering Mechanics', 4, 1, 2);

-- Step 3: UPDATE - increase credits for Database Systems
UPDATE Courses
SET credits = 5
WHERE course_id = 2;  -- course_id for Database Systems

-- Step 4: DELETE - remove Law course
DELETE FROM Courses
WHERE course_id = 4;  -- course_id for Law

-- Step 5: SELECT with WHERE - find all courses worth 4 credits
SELECT *
FROM Courses
WHERE credits = 4;

-- == MEMBER E (Bugingo Nshuti Brandon)  (Student_Courses, Student_Activities) ==
USE alu_db;
-- 1. Extra_Curricular_Activities table
CREATE TABLE Extra_Curricular_Activities (
    activity_id     INT AUTO_INCREMENT PRIMARY KEY,
    activity_name   VARCHAR(100) NOT NULL,
    activity_type   VARCHAR(50),          
    meeting_day     VARCHAR(20),
    advisor_id      INT,          
    CONSTRAINT fk_activity_advisor
        FOREIGN KEY (advisor_id) REFERENCES Faculty(faculty_id)
);

-- 2. Junction table: Student_Courses (many-to-many: Students - Courses)
CREATE TABLE Student_Courses (
    student_id      INT NOT NULL,
    course_id       INT NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_sc_student
        FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_sc_course
        FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 3. Junction table: Student_Activities (many-to-many: Students - Activities)
CREATE TABLE Student_Activities (
    student_id      INT NOT NULL,
    activity_id     INT NOT NULL,
    join_date       DATE,
    PRIMARY KEY (student_id, activity_id),
    CONSTRAINT fk_sa_student
        FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_sa_activity
        FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
);

-- INSERT statements Extra_Curricular_Activities (5 sample rows)
INSERT INTO Extra_Curricular_Activities (activity_name, activity_type, meeting_day, advisor_id) VALUES
('Football Club',        'Sports', 'Monday',    1),
('Debate Society',       'Club',   'Wednesday', 2),
('Chess Club',           'Club',   'Tuesday',   3),
('School Choir',         'Music',  'Thursday',  1),
('Robotics Team',        'STEM',   'Friday',    2);

-- INSERT statements  Student_Courses (sample enrollments)
INSERT INTO Student_Courses (student_id, course_id, enrollment_date) VALUES
(1, 1, '2026-01-15'),
(1, 2, '2026-01-15'),
(2, 1, '2026-01-16'),
(3, 3, '2026-01-16'),
(4, 2, '2026-01-17');

-- INSERT statements Student_Activities (sample participation)
INSERT INTO Student_Activities (student_id, activity_id, join_date) VALUES
(1, 1, '2026-01-20'),
(2, 1, '2026-01-20'),
(3, 2, '2026-01-21'),
(4, 3, '2026-01-22'),
(2, 4, '2026-01-23');

-- MEMBER E — Individual UPDATE / DELETE / SELECT

-- UPDATE: change the meeting day of the Chess Club
UPDATE Extra_Curricular_Activities
SET meeting_day = 'Saturday'
WHERE activity_name = 'Chess Club';

-- DELETE: remove a specific student's activity record
DELETE FROM Student_Activities
WHERE student_id = 4 AND activity_id = 4;

-- SELECT with WHERE: all activities advised by faculty_id = 1
SELECT activity_id, activity_name, activity_type, meeting_day
FROM Extra_Curricular_Activities
WHERE advisor_id = 1;

-- MEMBER (Prince Ganza): Data Integrity Checks and Join Queries
-- Check Courses -> Faculty
SELECT * FROM Courses c
LEFT JOIN Faculty f ON c.faculty_id = f.faculty_id
WHERE c.faculty_id IS NOT NULL AND f.faculty_id IS NULL;

-- Check Courses -> Classroom
SELECT * FROM Courses c
LEFT JOIN Classroom cl ON c.classroom_id = cl.classroom_id
WHERE c.classroom_id IS NOT NULL AND cl.classroom_id IS NULL;

-- Check Student_Courses -> Students and Courses
SELECT * FROM Student_Courses sc
LEFT JOIN Students s ON sc.student_id = s.student_id
LEFT JOIN Courses c ON sc.course_id = c.course_id
WHERE s.student_id IS NULL OR c.course_id IS NULL;

-- Check Student_Activities -> Students and Activities
SELECT * FROM Student_Activities sa
LEFT JOIN Students s ON sa.student_id = s.student_id
LEFT JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
WHERE s.student_id IS NULL OR a.activity_id IS NULL;

-- Check Extra_Curricular_Activities -> Faculty
SELECT * FROM Extra_Curricular_Activities a
LEFT JOIN Faculty f ON a.advisor_id = f.faculty_id
WHERE a.advisor_id IS NOT NULL AND f.faculty_id IS NULL;

-- Normalization Check:
-- All information is stored only once in its own table (Students, Classroom,
--It is referenced only by other tables such as -- Faculty, Courses, Extra_Curricular_Activities.
-- In terms of the ID, but not repeating information such as names or departments. The many-to-many
-- relationships between Students and Courses and between Students and Activities.
--Using junction tables (Student_Courses, Student_Activities) correctly solves the problems: --
-- student, registration, and date information, while eliminating duplicate student, registration, and date data.
--Data for -- course, or activity.

-- Join Query 1: Student enrolled in a course, taught by faculty, in a classroom
SELECT s.first_name, s.last_name, co.course_name, f.name AS faculty_name, cl.room_number
FROM Students s
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses co ON sc.course_id = co.course_id
JOIN Faculty f ON co.faculty_id = f.faculty_id
JOIN Classroom cl ON co.classroom_id = cl.classroom_id;

-- Join Query 2: Student participates in an activity, advised by faculty
SELECT s.first_name, s.last_name, a.activity_name, f.name AS advisor_name
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f ON a.advisor_id = f.faculty_id;

-- Join Query 3: Faculty and the courses they teach, with classroom location
SELECT f.name AS faculty_name, co.course_name, cl.room_number, cl.building
FROM Faculty f
JOIN Courses co ON f.faculty_id = co.faculty_id
JOIN Classroom cl ON co.classroom_id = cl.classroom_id;

-- Aggregate Query: number of students enrolled per course
SELECT co.course_name, COUNT(sc.student_id) AS num_students
FROM Courses co
LEFT JOIN Student_Courses sc ON co.course_id = sc.course_id
GROUP BY co.course_name;