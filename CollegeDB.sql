-- Create the database
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- Create the Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DOB DATE,
    Gender ENUM('Male', 'Female') NOT NULL
);

-- Create the Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT CHECK (Credits BETWEEN 1 AND 6)
);

-- Create the Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- Insert sample data into Students
INSERT INTO Students (Name, Email, DOB, Gender) VALUES 
('John Doe', 'john.doe@example.com', '2000-05-15', 'Male'),
('Jane Smith', 'jane.smith@example.com', '2001-09-22', 'Female'),
('Michael Brown', 'michael.brown@example.com', '1999-03-10', 'Male');

-- Insert sample data into Courses
INSERT INTO Courses (CourseName, Credits) VALUES 
('Database Systems', 4),
('Operating Systems', 3),
('Data Structures', 3);

-- Insert sample data into Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES 
(1, 1, CURDATE(), 'A'), -- John Doe enrolled in Database Systems
(2, 2, CURDATE(), 'B'), -- Jane Smith enrolled in Operating Systems
(3, 3, CURDATE(), 'A'), -- Michael Brown enrolled in Data Structures
(1, 3, CURDATE(), 'B'); -- John Doe enrolled in Data Structures

-- Create a view to show student details with their enrolled courses
CREATE VIEW StudentCourses AS
SELECT 
    s.StudentID, 
    s.Name AS StudentName, 
    c.CourseName, 
    e.EnrollmentDate, 
    e.Grade
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;

-- Create a function to calculate the total credits for a student
DELIMITER //

CREATE FUNCTION TotalCredits(StudentID INT) RETURNS INT
BEGIN
    DECLARE Total INT;
    SELECT SUM(c.Credits) INTO Total
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = StudentID;
    RETURN IFNULL(Total, 0); -- Return 0 if no credits are found
END //

DELIMITER ;


-- Create a trigger to prevent duplicate enrollments
DELIMITER //
CREATE TRIGGER PreventDuplicateEnrollment
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    DECLARE CountEnrollments INT;
    SELECT COUNT(*) INTO CountEnrollments
    FROM Enrollments
    WHERE StudentID = NEW.StudentID AND CourseID = NEW.CourseID;

    IF CountEnrollments > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student is already enrolled in this course';
    END IF;
END //
DELIMITER ;

-- Fetch student details with their enrolled courses
SELECT 
    s.Name AS StudentName,
    c.CourseName,
    e.Grade
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;

-- Query to fetch students with an 'A' grade
SELECT 
    Name, 
    Email 
FROM 
    Students
WHERE 
    StudentID IN (SELECT StudentID FROM Enrollments WHERE Grade = 'A');

-- Query to fetch courses with the total number of enrolled students
SELECT 
    c.CourseName,
    COUNT(e.StudentID) AS TotalStudents
FROM 
    Courses c
LEFT JOIN 
    Enrollments e ON c.CourseID = e.CourseID
GROUP BY 
    c.CourseID
ORDER BY 
    TotalStudents DESC;

-- Query with clauses to filter and order data
SELECT 
    s.Name AS StudentName,
    c.CourseName,
    e.Grade
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID
WHERE 
    e.Grade = 'A'
ORDER BY 
    s.Name ASC;
    
    
    
USE CollegeDB;
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
