-- Create Sequences
CREATE SEQUENCE seq_student_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_course_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_enrollment_id START WITH 1 INCREMENT BY 1;

-- Create Tables
CREATE TABLE Students (
    StudentID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Email VARCHAR2(100),
    EnrollmentDate DATE
);

CREATE TABLE Courses (
    CourseID NUMBER PRIMARY KEY,
    CourseName VARCHAR2(100),
    Instructor VARCHAR2(100)
);

CREATE TABLE Enrollments (
    EnrollmentID NUMBER PRIMARY KEY,
    StudentID NUMBER,
    CourseID NUMBER,
    EnrollmentDate DATE,
    CONSTRAINT fk_student FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_course FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Triggers
CREATE OR REPLACE TRIGGER trg_students_before_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    SELECT seq_student_id.NEXTVAL INTO :NEW.StudentID FROM dual;
END;

CREATE OR REPLACE TRIGGER trg_courses_before_insert
BEFORE INSERT ON Courses
FOR EACH ROW
BEGIN
    SELECT seq_course_id.NEXTVAL INTO :NEW.CourseID FROM dual;
END;

CREATE OR REPLACE TRIGGER trg_enrollments_before_insert
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    SELECT seq_enrollment_id.NEXTVAL INTO :NEW.EnrollmentID FROM dual;
END;

-- Insert Data
INSERT INTO Students (Name, Email, EnrollmentDate)
VALUES ('John Doe', 'john.doe@example.com', TO_DATE('2023-08-20', 'YYYY-MM-DD'));

select * from students;

INSERT INTO Students (Name, Email, EnrollmentDate)
VALUES ('Jane Smith', 'jane.smith@example.com', TO_DATE('2023-08-21', 'YYYY-MM-DD'));

INSERT INTO Courses (CourseName, Instructor)
VALUES ('Database Systems', 'Dr. Alice Johnson');

INSERT INTO Courses (CourseName, Instructor)
VALUES ('Operating Systems', 'Dr. Bob Williams');

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
VALUES (1, 1, TO_DATE('2023-08-25', 'YYYY-MM-DD'));

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
VALUES (2, 2, TO_DATE('2023-08-26', 'YYYY-MM-DD'));

-- Queries
SELECT * FROM Students;

SELECT * FROM Courses;

SELECT Students.Name, Courses.CourseName, Enrollments.EnrollmentDate
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Database Systems';

SELECT Courses.CourseName, COUNT(Enrollments.StudentID) AS NumberOfStudents
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Courses.CourseName;





