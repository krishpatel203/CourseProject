-- Table with student information
CREATE TABLE Students (
    -- Unique identifier for each student
    StudentID INT PRIMARY KEY,
    
    -- Student's first name 
    FirstName VARCHAR(50) NOT NULL,
    
    -- Student Last Name
    LastName VARCHAR(50) NOT NULL,
    
    -- Student's address
    Address VARCHAR(255),
    
    -- Date of Birth
    DateOfBirth DATE
);

-- Table with Student Course
CREATE TABLE Courses (
    -- Course ID for course
    CourseID INT PRIMARY KEY,
    
    -- Name of the course 
    Name VARCHAR(100) NOT NULL,
    
    -- Credits per course
    CreditHours INT NOT NULL
);

-- Create the Enrollments table for students 
CREATE TABLE Enrollments (
    -- Enrollement for each student 
    EnrollmentID INT PRIMARY KEY,
    
    -- StudentID
    StudentID INT REFERENCES Students(StudentID),
    
    -- CourseID
    CourseID INT REFERENCES Courses(CourseID),
    
    -- Date Enrolled
    DateEnrolled DATE NOT NULL
);

-- Create the Attendance table
CREATE TABLE Attendance (
    -- AttendanceID
    AttendanceID INT PRIMARY KEY,
    
    -- EntrollementID which is a Foreign Key
    EnrollmentID INT REFERENCES Enrollments(EnrollmentID),
    
    -- Attendance Date
    AttendanceDate DATE NOT NULL,
    
    --Status for attendance/ Present or Absent
    Status VARCHAR(10) CHECK (Status IN ('Present', 'Absent'))
);

-- Insert sample data into the Students table
INSERT INTO Students VALUES (1, 'Krish', 'Patel', '123 Popular Avenue', '01/15/2003');
INSERT INTO Students VALUES (2, 'Shrey', 'Shah', '13 Walker Avenue', '10/25/2003');
INSERT INTO Students VALUES (3, 'Matt', 'Neil', '1000 Hilltop Circle', '11/20/2002');
INSERT INTO Students VALUES (4, 'Zach', 'Yankle', '7514 Talbots Landing', '06/30/2005');
INSERT INTO Students VALUES (5, 'Lamar', 'Jackson', '8 Ownings Way', '01/07/1997');

-- Insert sample data into Courses table
INSERT INTO Courses VALUES (351, 'Statistics', 3);
INSERT INTO Courses VALUES (201, 'Spanish', 3);
INSERT INTO Courses VALUES (102, 'Chemistry', 4);
INSERT INTO Courses VALUES (202, 'Computer Science', 4);
INSERT INTO Courses VALUES (303, 'Information System', 3);

-- Insert sample data into the Enrollement table
INSERT INTO Enrollments VALUES (042157, 1, 351, '04/23/2024');
INSERT INTO Enrollments VALUES (432150, 2, 201, '04/10/2024');
INSERT INTO Enrollments VALUES (109867, 3, 102, '04/15/2024');
INSERT INTO Enrollments VALUES (891236, 4, 202, '04/22/2024');
INSERT INTO Enrollments VALUES (871234, 5, 303, '04/26/2023');

-- Insert sample data into the Attendance table
INSERT INTO Attendance VALUES(2468, 042157, '11/14/2024', 'Present');
INSERT INTO Attendance VALUES(3579, 432150, '11/11/2024', 'Absent');
INSERT INTO Attendance VALUES(7890, 109867, '11/06/2024', 'Absent');
INSERT INTO Attendance VALUES(9876, 891236, '11/01/2024', 'Present');
INSERT INTO Attendance VALUES(2024, 871234, '11/13/2024', 'Present');

-- Query to retrieve all student information
SELECT StudentID, FirstName, LastName, Address, DateOfBirth
FROM Students;

-- Query to retrieve all course information
SELECT CourseID, Name, CreditHours
From Courses;

-- Query to list students along with their enrolled courses and enrollment dates
SELECT Students.StudentID, Students.FirstName, Students.LastName, Courses.Name, Enrollments.DateEnrolled
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Query to list students, their courses, attendance dates, and attendance status
SELECT Students.StudentID, Students.FirstName, Students.LastName, Courses.Name, Attendance.AttendanceDate, Attendance.Status
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
INNER JOIN Attendance ON Enrollments.EnrollmentID = Attendance.EnrollmentID;

-- Query to count the number of students enrolled in each course
SELECT Courses.Name, COUNT(Enrollments.StudentID) AS NumberOfStudents
FROM Courses
LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.Name;

-- Query to count the number of 'Present' and 'Absent' statuses in the Attendance table
SELECT Status, COUNT(Status) AS StatusCount
FROM Attendance
GROUP BY Status;

-- Select the courses that have 3 credit hours 
SELECT Name 
FROM Courses 
WHERE CreditHours = 3;

--Select Query where select student that is enrolled in Information System
SELECT Students.FirstName, Students.LastName
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.Name = 'Information System';

-- Update a student's address
UPDATE Students
SET Address = '48 Ellis Lane'
WHERE StudentID = 1;

-- Update a Course Credits Hours
UPDATE Courses
SET CreditHours = 4
WHERE CourseID = 201;


