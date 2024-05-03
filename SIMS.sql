CREATE DATABASE Student_Information_Management_System;
USE Student_Information_Management_System;

----------------- Creating a table for students----------------------
CREATE TABLE students 
(
    student_id VARCHAR (10) PRIMARY KEY ,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender CHAR(1) CHECK(gender IN ('M', 'F')),
    address VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(20) UNIQUE NOT NULL,
    parent_name VARCHAR(15) NOT NULL,
    parent_phone_number VARCHAR(15) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

---------------- Creating a table for teachers---------------------
CREATE TABLE teachers 
(
    teacher_id VARCHAR (10) PRIMARY KEY ,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    email VARCHAR(15) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
	qualification VARCHAR (15) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

------------------ Creating a table for courses-------------------------
CREATE TABLE courses 
(
    course_id VARCHAR (10) PRIMARY KEY ,
    course_name VARCHAR(30) NOT NULL,
    course_instructor VARCHAR(10) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_instructor) REFERENCES teachers(teacher_id)
);

---------------- Creating a table for enrollments------------------------
CREATE TABLE enrollments (
    enrollment_id VARCHAR (10) PRIMARY KEY ,
    student_id VARCHAR (10)  NOT NULL,
    course_id VARCHAR (10) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

---------------- Creating a table for attendance--------------------------
CREATE TABLE attendance (
    student_id VARCHAR (10) NOT NULL,
    course_id VARCHAR (10) NOT NULL,
    date DATE NOT NULL,
    status CHAR(1) CHECK(status IN ('P', 'A')),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

----------------- Creating a table for grades-------------------------------
CREATE TABLE grades (
    student_id VARCHAR (10) NOT NULL,
    course_id VARCHAR (10) NOT NULL,
    Exam_Name VARCHAR(20) NOT NULL,
    grade DECIMAL CHECK(grade >= 0.00 AND grade <= 100.00),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

------------------ Creating a table for events------------------------------
CREATE TABLE events (
	event_id VARCHAR (10) PRIMARY KEY ,
    event_name VARCHAR(20) NOT NULL,
    event_description VARCHAR(MAX) NOT NULL,
    event_location VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

--------------------- Creating a table for event attendees-------------------------
CREATE TABLE event_attendees (
    attendee_id VARCHAR (10) NOT NULL,
    event_id VARCHAR (10) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES students(student_id) 
);

---------------------- Creating a table for Announcement------------------------------
CREATE TABLE Announcement (
    message_id VARCHAR (10) PRIMARY KEY ,
    sender_id VARCHAR (10) NOT NULL,
    receiver_id VARCHAR (10) NOT NULL,
    message VARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (sender_id) REFERENCES teachers(teacher_id) ,
    FOREIGN KEY (receiver_id) REFERENCES students(student_id)
);


******************************************************************************
---------------------------Stored Procedures----------------------------------
******************************************************************************

-----Creating a stored procedure for inserting data into the Student Information table-----
CREATE PROCEDURE 
sp_Insert_Student_Information (
    @student_id VARCHAR (10) ,
    @first_name VARCHAR(15),
    @last_name VARCHAR(15),
    @date_of_birth DATE,
    @gender CHAR(1) ,
    @address VARCHAR(50),
    @phone_number VARCHAR(15) ,
    @email VARCHAR(20) ,
    @parent_name VARCHAR(15) ,
    @parent_phone_number VARCHAR(15)
)
AS
BEGIN
    INSERT INTO students(student_id,first_name, last_name, date_of_birth, gender,
	 address, phone_number, email, parent_name, parent_phone_number)
    VALUES (@student_id,@first_name, @last_name, @date_of_birth, @gender,@address,
	 @phone_number,  @email ,@parent_name, @parent_phone_number);
END;

-----Creating a stored procedure for inserting data into the Teacher Information table-----
CREATE PROCEDURE 
sp_Insert_Teacher_Information (
    @teacher_id VARCHAR (10) ,
    @first_name VARCHAR (15),
    @last_name VARCHAR (15),
    @email VARCHAR (15) ,
    @phone_number VARCHAR(15),
	@qualification VARCHAR (15)
)
AS
BEGIN
    INSERT INTO teachers(teacher_id, first_name, last_name, email, phone_number, 
	qualification)
    VALUES (@teacher_id, @first_name , @last_name, @email, @phone_number, 
	@qualification);
END;

-----Creating a stored procedure for inserting data into the Courses Information table-----
CREATE PROCEDURE 
sp_Insert_Course_Information (
    @course_id VARCHAR (10) ,
    @course_name VARCHAR(30) ,
    @course_instructor VARCHAR (10) 
)
AS
BEGIN
    INSERT INTO courses(course_id, course_name,course_instructor)
    VALUES (@course_id, @course_name, @course_instructor);
END; 

-----Creating a stored procedure for inserting data into the Enrollment table-----
CREATE PROCEDURE 
sp_Insert_Enrollment_Information (
    @enrollment_id VARCHAR (10) ,
    @student_id VARCHAR (10) ,
    @course_id VARCHAR (10) 
)
AS
BEGIN
    INSERT INTO enrollments(enrollment_id,student_id,course_id)
    VALUES (@enrollment_id,@student_id,@course_id);
END;

-----Creating a stored procedure for inserting data into the Attendance table-----
CREATE PROCEDURE 
sp_Insert_Attendance (
    @student_id VARCHAR (10) ,
    @course_id VARCHAR (10) ,
    @date DATE ,
    @status CHAR(1)
)
AS
BEGIN
    INSERT INTO attendance( student_id, course_id,date,status)
    VALUES ( @student_id, @course_id,@date,@status);
END;

-----Creating a stored procedure for inserting data into the Grade table-----
CREATE PROCEDURE 
sp_Insert_Grade (
    @student_id VARCHAR (10) ,
    @course_id VARCHAR (10) ,
    @Exam_Name VARCHAR(20) ,
    @grade DECIMAL  
)
AS
BEGIN
    INSERT INTO grades( student_id,course_id,Exam_Name,grade)
    VALUES ( @student_id, @course_id, @Exam_Name, @grade);
END;

-----Creating a stored procedure for inserting data into the Event table-----
CREATE PROCEDURE 
sp_Insert_Event (
	@event_id VARCHAR (10),
    @event_name VARCHAR(20) ,
    @event_description VARCHAR(MAX) ,
    @event_location VARCHAR(50) ,
    @event_date DATE ,
    @event_time TIME 
)
AS
BEGIN
    INSERT INTO events( event_id ,event_name, event_description ,
	 event_location , event_date , event_time)
    VALUES ( @event_id ,@event_name, @event_description ,
	 @event_location , @event_date , @event_time);
END;

-----Creating a stored procedure for inserting data into the Event_Attendees table-----
CREATE PROCEDURE 
sp_Insert_Event_Attendees (
    @attendee_id VARCHAR (10) ,

    @event_id VARCHAR (10) 
)
AS
BEGIN
    INSERT INTO event_attendees(attendee_id, event_id  )
    VALUES ( @attendee_id, @event_id );
END;

------------------- Creating a stored procedure for inserting data into the Announcement Table
CREATE PROCEDURE 
sp_Announcement (
	@message_id VARCHAR (10) ,
    @sender_id VARCHAR (10) ,
    @receiver_id VARCHAR (10) ,
    @message VARCHAR(MAX) 
)
AS
BEGIN
    INSERT INTO Announcement( message_id , sender_id , receiver_id , message)
    VALUES ( @message_id , @sender_id , @receiver_id , @message);
END;

----------------------INSERT INTO STUDENT TABLE ------------------
EXEC sp_Insert_Student_Information  '2021-SE-40','Sarah', 'Ahmed', '2000-05-01', 'F', '123 Main St, New York, NY 10001', '555-555-1212',
'sarah.ahmed@email.com', 'Mohammed Ahmed', '555-555-1213' ;

EXEC sp_Insert_Student_Information '2021-SE-16','Mohammed', 'Ali', '1999-08-02', 'M', '456 Park Ave, New York, NY 10003', '555-555-1214',
'mohammed.ali@email.com', 'Fatima Ali', '555-555-1215';

EXEC sp_Insert_Student_Information '2021-SE-19','Fatima', 'Khan', '1998-12-03', 'Female', '789 Broadway, New York, NY 10005', '555-555-1216',
'fatima.khan@email.com', 'Hamza Khan', '555-555-1217';

EXEC sp_Insert_Student_Information '2020-SE-06','Aisha', 'Hussain', '1997-02-04', 'Female', '246 5th Ave, New York, NY 10001', '555-555-1218',
'aisha.hussain@email.com', 'Shahid Hussain', '555-555-1219';

EXEC sp_Insert_Student_Information '2020-SE-04', 'Osman', 'Raza', '1996-06-05', 'Male', '369 Lexington Ave, New York, NY 10017', '555-555-1220',
'osman.raza@email.com', 'Nazia Raza', '555-555-1221';

EXEC sp_Insert_Student_Information '2019-SE-05', 'Ayesha', 'Shah', '1995-10-06','F', '159 2nd Ave, New York, NY 10003', '555-555-1222', 
'ayesha.shah@email.com', 'Tariq Shah', '555-555-1223';

EXEC sp_Insert_Student_Information '2022-SE-16','Hassan', 'Iqbal', '1994-01-07', 'Male', '753 3rd Ave, New York, NY 10017', '555-555-1224',
'hassan.iqbal@email.com', 'Nashit Iqbal', '555-555-1225';

EXEC sp_Insert_Student_Information '2022-SE-20', 'Nashit', 'Zaman', '1993-05-08', 'Female', '951 4th Ave, New York, NY 10001', '555-555-1226', 
'nashit.zaman@email.com', 'Imran Zaman', '555-555-1227';

EXEC sp_Insert_Student_Information '2021-SE-29' , 'Zainab', 'Mahmood', '1992-09-09', 'Female', '147 5th Ave, New York, NY 10003', '555-555-1228', 
'zainab.mahmood@email.com', 'Asif Mahmood', '555-555-1229';

EXEC sp_Insert_Student_Information '2020-SE-38' ,'Imran', 'Nawaz', '1991-02-10', 'Male', '369 Lexington Ave, New York, NY 10017', '555-555-1230', 
'imran.nawaz@email.com', 'Sadia Nawaz', '555-555-12';

SELECT * FROM students;

----------------------INSERT INTO TEACHER TABLE----------------------
EXEC sp_Insert_Teacher_Information 'T1001','Aisha', 'Khan', 'aisha_khan@school.com' , '9876543210', 'M.Ed SE';
EXEC sp_Insert_Teacher_Information 'T1002', 'Tariq', 'Ahmed', 'tariq_ahmed@school.com' , '9886543210', 'M.Sc CE';
EXEC sp_Insert_Teacher_Information 'T1003', 'Nashit', 'Qureshi', 'nashit_qureshi@school.com', '9876543211', 'M.A EE';
EXEC sp_Insert_Teacher_Information 'T1004', 'Mahmood', 'Khan', 'mahmood_khan@school.com' ,'9876543212', 'B.S SE';
EXEC sp_Insert_Teacher_Information 'T1005', 'Jawad', 'Shah', 'jawad_shah@school.com' , '9876543213', 'M.A CE';
EXEC sp_Insert_Teacher_Information 'T1006', 'Nida', 'Khan', 'nida_khan@school.com' ,'9876543214', 'B.Sc EE';
EXEC sp_Insert_Teacher_Information 'T1007', 'Faris', 'Ali', 'faris_ali@school.com' ,'9876543215', 'M.Ed SE';
EXEC sp_Insert_Teacher_Information 'T1008', 'Nazia', 'Ansari', 'nazia_ansari@school.com' ,'9876543216', 'B.A CE';
EXEC sp_Insert_Teacher_Information 'T1009', 'Atif', 'Khan', 'atif_khan@school.com', '9876543217', 'M.Sc CS' ;
EXEC sp_Insert_Teacher_Information 'T1010', 'Rabia', 'Rizvi', 'rabia_rizvi@school.com' ,'9876543218', 'B.Ed SE';

SELECT * FROM teachers;

----------------------INSERT INTO COURSE TABLE----------------------
EXEC sp_Insert_Course_Information 'CS-1101' ,'Programming Fundamental' ,'T1001' ;
EXEC sp_Insert_Course_Information 'CS-1202' ,'Object Oriented Programming' ,'T1004' ;
EXEC sp_Insert_Course_Information 'CS-2104' ,'Data Structures and Algorithms' ,'T1010' ;
EXEC sp_Insert_Course_Information 'CS-1103' ,'ICT' ,'T1008' ;
EXEC sp_Insert_Course_Information 'CS-1201' ,'CA & LD' ,'T1006' ;
EXEC sp_Insert_Course_Information 'CS-2204' ,'Networking' ,'T1009' ;
EXEC sp_Insert_Course_Information 'CS-3105' ,'Machine Learning' ,'T1002' ;
EXEC sp_Insert_Course_Information 'CS-4203' ,'Digital Image Processing' ,'T1006' ;
EXEC sp_Insert_Course_Information 'CS-3106' ,'Web Design' ,'T1008' ;
EXEC sp_Insert_Course_Information 'CS-3201' ,'Web development' ,'T1007' ;

SELECT * FROM courses;

----------------------INSERT INTO ENROLLMENT TABLE----------------------
EXEC sp_Insert_Enrollment_Information 'E100','2021-SE-29','CS-2204';
EXEC sp_Insert_Enrollment_Information 'E101','2020-SE-06','CS-3105';
EXEC sp_Insert_Enrollment_Information 'E102','2021-SE-40','CS-2204';
EXEC sp_Insert_Enrollment_Information 'E103','2021-SE-19','CS-3106';
EXEC sp_Insert_Enrollment_Information 'E104','2022-SE-20','CS-1201';
EXEC sp_Insert_Enrollment_Information 'E105','2020-SE-38','CS-2204';
EXEC sp_Insert_Enrollment_Information 'E106','2019-SE-05','CS-4203';
EXEC sp_Insert_Enrollment_Information 'E107','2021-SE-29','CS-2204';
EXEC sp_Insert_Enrollment_Information 'E108','2021-SE-16','CS-2204';
EXEC sp_Insert_Enrollment_Information 'E109','2019-SE-05','CS-3201';

SELECT * FROM enrollments;

----------------------INSERT INTO ATTENDANCE TABLE----------------------
EXEC sp_Insert_Attendance '2021-SE-29' , 'CS-2204' , '2023-02-13' , 'P';
EXEC sp_Insert_Attendance '2019-SE-05' , 'CS-4203' , '2023-02-13' , 'P';
EXEC sp_Insert_Attendance '2019-SE-05' , 'CS-3201' , '2023-02-14' , 'P';
EXEC sp_Insert_Attendance '2021-SE-16' , 'CS-2204' , '2023-02-16' , 'A';
EXEC sp_Insert_Attendance '2019-SE-05' , 'CS-4203' , '2023-02-18' , 'P';
EXEC sp_Insert_Attendance '2022-SE-20' , 'CS-1201' , '2023-02-11' , 'P';
EXEC sp_Insert_Attendance '2020-SE-06' , 'CS-3105' , '2023-01-13' , 'A';
EXEC sp_Insert_Attendance '2021-SE-40' , 'CS-2204' , '2023-09-13' , 'P';
EXEC sp_Insert_Attendance '2019-SE-05' , 'CS-3201' , '2023-03-13' , 'P';
EXEC sp_Insert_Attendance '2020-SE-38' , 'CS-2204' , '2023-09-13' , 'P';

SELECT * FROM attendance;

----------------------INSERT INTO GRADE TABLE----------------------
EXEC sp_Insert_Grade '2022-SE-20' , 'CS-1201' , 'Terminal' , 100.00;
EXEC sp_Insert_Grade '2020-SE-38' , 'CS-2204' , 'Terminal' , 93.92;
EXEC sp_Insert_Grade '2020-SE-06' , 'CS-3105' , 'Mid' , 77.24;
EXEC sp_Insert_Grade '2021-SE-29' , 'CS-2204' , 'Mid' , 74.87;
EXEC sp_Insert_Grade '2021-SE-16' , 'CS-2204' , 'Mid' , 89.79;
EXEC sp_Insert_Grade '2021-SE-40' , 'CS-2204' , 'Mid' , 91.42;
EXEC sp_Insert_Grade '2019-SE-05' , 'CS-3201' , 'Terminal' , 96.34;
EXEC sp_Insert_Grade '2020-SE-06' , 'CS-3105' , 'Terminal' , 69.12;
EXEC sp_Insert_Grade '2021-SE-29' , 'CS-2204' , 'Mid' , 83.76;
EXEC sp_Insert_Grade '2019-SE-05' , 'CS-3201'  , 'Mid' , 82.83;

SELECT * FROM grades;

----------------------INSERT INTO EVENT TABLE----------------------
EXEC sp_Insert_Event 'E1','Seminar', 'A Freelancing Seminar For Students to Sell their Skills.' , 'SE Department UAJK', '2023-03-14' , '10:00:00' ;
EXEC sp_Insert_Event 'E2','Magic Show', 'A Magic Show in annual Function to Entertain Students.' , 'SE Hall', '2023-04-01' , '01:00:00' ;
EXEC sp_Insert_Event 'E3','Sport Day', 'Sport Day to Enhance Skills.' , 'SE Ground', '2023-03-15' , '12:00:00' ;
EXEC sp_Insert_Event 'E4','Workshop', 'A Workshop  on Digital Skills.' , 'SE Department UAJK', '2023-05-28' , '09:00:00' ;
EXEC sp_Insert_Event 'E5','Get Together', 'Get Together for Students of Software Engineering' , 'SE Hall', '2023-05-09' , '11:00:00' ;

SELECT * FROM events;

----------------------INSERT INTO EVENT ATTENDEES TABLE----------------------
EXEC sp_Insert_Event_Attendees '2021-SE-29' , 'E1';
EXEC sp_Insert_Event_Attendees '2020-SE-06' , 'E4';
EXEC sp_Insert_Event_Attendees '2021-SE-19' , 'E5';
EXEC sp_Insert_Event_Attendees '2019-SE-05' , 'E3' ;
EXEC sp_Insert_Event_Attendees '2020-SE-38' , 'E2';
EXEC sp_Insert_Event_Attendees '2021-SE-40' , 'E4';
EXEC sp_Insert_Event_Attendees '2020-SE-06' , 'E2';
EXEC sp_Insert_Event_Attendees '2022-SE-20' , 'E3';
EXEC sp_Insert_Event_Attendees '2022-SE-20' , 'E1';
EXEC sp_Insert_Event_Attendees '2020-SE-06' , 'E5';

SELECT * FROM event_attendees;

----------INSERT INTO MESSAGE TABLE---------------------------------
EXEC sp_Announcement  'm2','T1004' ,'2020-SE-06' ,'Remainder : Tomorrow is Seminar';
EXEC sp_Announcement  'm1','T1001' ,'2022-SE-20','Remainder : RESCHEDULE ALL THE CLASSES';

SELECT *FROM Announcement;
 
----------------------Extract DAta using Joins----------------------
Select S.student_id ,S.first_name , S.last_name, E.course_id ,  C.course_name 
FROM students AS S
INNER JOIN enrollments AS E 
ON S.student_id=E.student_id
INNER JOIN courses AS C
ON C.course_id= E.course_id;

------------------------------------------------------------------------------------------

SELECT S.student_id, S.first_name , S.last_name ,G.course_id  , G.Exam_Name , G.grade 
From students AS S
Inner join grades as G
ON S.student_id = G.student_id ;

------------------------------------------------------------------------------------------

SELECT S.student_id, S.first_name , S.last_name , A.course_id , A.date , A.status 
FROM students AS S
INNER JOIN attendance AS A
ON S.student_id = A.student_id;

------------------------------------------------------------------------------------------

SELECT S.student_id  , S.first_name  , S.last_name  , C.course_id , C.course_name  , T.first_name AS Instructor
FROM students AS S
INNER JOIN enrollments AS E
ON S.student_id=E.student_id
INNER JOIN courses AS C
ON C.course_id = E.course_id
INNER JOIN teachers AS T
ON T.teacher_id=C.course_instructor
ORDER BY S.student_id ASC ;

------------------------------------------------------------------------------------------

SELECT student_id, first_name , last_name , date_of_birth , gender
FROM students WHERE first_name LIKE LOWER('A%')
ORDER BY student_id ASC;

------------------------------------------------------------------------------------------

Select S.student_id , S.first_name , C.course_id , C.course_name , T.first_name AS Instructor, G.Exam_Name , G.grade
FROM students AS S
INNER JOIN enrollments AS E
ON S.student_id=E.student_id
INNER JOIN  courses AS C
ON E.course_id = C.course_id
INNER JOIN teachers AS T
ON T.teacher_id= C.course_instructor
INNER JOIN  grades AS G
ON G.student_id=S.student_id
ORDER BY S.student_id ASC ,  course_name ASC;

------------------------------------------------------------------------------------------
SELECT S.student_id, S.first_name , S.last_name , E.event_id,  E.event_name , E.event_location
FROM students AS S
INNER JOIN event_attendees AS EA
ON S.student_id= EA.attendee_id 
INNER JOIN events AS E
ON E.event_id = EA.event_id;

------------------------------------------------------------------------------------------
SELECT S.student_id , S.first_name , S.last_name 
FROM students AS S
WHERE S.student_id BETWEEN '2020-SE-01' AND  '2021-SE-40';

------------------------------------------------------------------------------------------

SELECT COUNT(student_id) AS TOTAL_STUDENTS
FROM students ; 

-------------------------------------------------------------------------------------------------------------------------------

SELECT S.student_id , S.first_name , S.last_name , C.course_id , C.course_name , T.first_name  AS Instructor
FROM students AS S
JOIN enrollments AS E
ON S.student_id = E.student_id 
JOIN courses AS C
ON E.course_id= C.course_id
JOIN teachers AS T
ON C.course_instructor = T.teacher_id
GROUP BY S.student_id , S.first_name , S.last_name ,S.first_name , S.last_name , C.course_id , C.course_name , T.first_name
HAVING S.student_id  BETWEEN '2021-SE-01' AND '2021-SE-40';

-------------------------------------------------------------------------------------------------------------------------------------