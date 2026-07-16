-- === Member B: Classroom table ===
USE alu_db;

CREATE TABLE Classroom (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number  VARCHAR(10)  NOT NULL,
    building     VARCHAR(50)  NOT NULL,
    capacity     INT          NOT NULL
);

INSERT INTO Classroom (room_number, building, capacity) VALUES
('101', 'Innovation Hall', 30),
('102', 'Innovation Hall', 25),
('201', 'Science Block',   40),
('202', 'Science Block',   35),
('305', 'Library Annex',   20);

-- UPDATE
UPDATE Classroom
SET capacity = 45
WHERE room_number = '201' AND building = 'Science Block';

-- DELETE
DELETE FROM Classroom
WHERE room_number = '305' AND building = 'Library Annex';

-- SELECT with WHERE
SELECT *
FROM Classroom
WHERE building = 'Innovation Hall';
