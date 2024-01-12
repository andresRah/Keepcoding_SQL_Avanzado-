--DROP DATABASE IF EXISTS keepcoding;
--CREATE DATABASE keepcoding;

DROP TABLE IF EXISTS "Students" CASCADE;
CREATE TABLE "Students" (
  "StudentID" int PRIMARY KEY,
  "FirstName" varchar(255),
  "LastName" varchar(255),
  "Email" varchar(255),
  "Phone" varchar(255),
  "Address" varchar(255),
  "EnrollmentDate" timestamp
);
-- INSERT statements for Students table
INSERT INTO "Students" ("StudentID", "FirstName", "LastName", "Email", "Phone", "Address", "EnrollmentDate") VALUES (1, 'John', 'Doe', 'john@example.com', '1234567890', '123 Street', '2023-01-01');
INSERT INTO "Students" ("StudentID", "FirstName", "LastName", "Email", "Phone", "Address", "EnrollmentDate") VALUES (2, 'Jane', 'Smith', 'jane@example.com', '0987654321', '456 Avenue', '2023-01-02');

DROP TABLE IF EXISTS "Bootcamps" CASCADE;
CREATE TABLE "Bootcamps" (
  "BootcampID" int PRIMARY KEY,
  "Title" varchar(255),
  "StartDate" timestamp,
  "EndDate" timestamp,
  "Description" text,
  "Price" decimal,
  "Location" varchar(255)
);

-- INSERT statements for Bootcamps table
INSERT INTO "Bootcamps" ("BootcampID", "Title", "StartDate", "EndDate", "Description", "Price", "Location") VALUES (1, 'Full Stack Development', '2023-02-01', '2023-08-01', 'Learn full stack web development', 5000, 'New York');
INSERT INTO "Bootcamps" ("BootcampID", "Title", "StartDate", "EndDate", "Description", "Price", "Location") VALUES (2, 'Data Science', '2023-03-01', '2023-09-01', 'Become a data science expert', 5500, 'San Francisco');

DROP TABLE IF EXISTS "Modules" CASCADE;
CREATE TABLE "Modules" (
  "ModuleID" int PRIMARY KEY,
  "Name" varchar(255),
  "Description" text,
  "Duration" int,
  "BootcampID" int
);

-- INSERT statements for Modules table
INSERT INTO "Modules" ("ModuleID", "Name", "Description", "Duration", "BootcampID") VALUES (1, 'Intro to Programming', 'Basics of programming', 10, 1);
INSERT INTO "Modules" ("ModuleID", "Name", "Description", "Duration", "BootcampID") VALUES (2, 'Advanced Database Concepts', 'In-depth database techniques', 15, 2);

DROP TABLE IF EXISTS "Teachers" CASCADE;
CREATE TABLE "Teachers" (
  "TeacherID" int PRIMARY KEY,
  "FirstName" varchar(255),
  "LastName" varchar(255),
  "Email" varchar(255),
  "Phone" varchar(255),
  "Expertise" varchar(255)
);

INSERT INTO "Teachers" ("TeacherID", "FirstName", "LastName", "Email", "Phone", "Expertise") VALUES (1, 'Marco', 'Regalia', 'marco@outlook.es', '5834567844', 'Java');
INSERT INTO "Teachers" ("TeacherID", "FirstName", "LastName", "Email", "Phone", "Expertise") VALUES (2, 'Fernando', 'Cordero', 'fernando@gmail.com', '9834588890', 'SQL');

DROP TABLE IF EXISTS "Student_bootcamp_enrollment" CASCADE;
CREATE TABLE "Student_bootcamp_enrollment" (
  "EnrollmentID" int PRIMARY KEY,
  "StudentID" int,
  "BootcampID" int,
  "EnrollmentDate" timestamp
);

INSERT INTO "Student_bootcamp_enrollment" ("EnrollmentID", "StudentID", "BootcampID", "EnrollmentDate") VALUES (1, 1, 1, '2023-12-01');
INSERT INTO "Student_bootcamp_enrollment" ("EnrollmentID", "StudentID", "BootcampID", "EnrollmentDate") VALUES (2, 2, 1, '2023-11-01');

DROP TABLE IF EXISTS "Teacher_module" CASCADE;
CREATE TABLE "Teacher_module" (
  "AssignmentID" int PRIMARY KEY,
  "TeacherID" int,
  "ModuleID" int
);

INSERT INTO "Teacher_module" ("AssignmentID", "TeacherID", "ModuleID") VALUES (1, 1, 1);
INSERT INTO "Teacher_module" ("AssignmentID", "TeacherID", "ModuleID") VALUES (2, 2, 1);

DROP TABLE IF EXISTS "Student_module_progress" CASCADE;
CREATE TABLE "Student_module_progress" (
  "ProgressID" int PRIMARY KEY,
  "StudentID" int,
  "ModuleID" int,
  "CompletionDate" timestamp,
  "IsCurrentlyEnrolled" boolean
);

INSERT INTO "Student_module_progress" ("ProgressID", "StudentID", "ModuleID", "CompletionDate", "IsCurrentlyEnrolled") VALUES (1, 1, 1, '2024-01-09', false);
INSERT INTO "Student_module_progress" ("ProgressID", "StudentID", "ModuleID", "CompletionDate", "IsCurrentlyEnrolled") VALUES (2, 2, 1, '2024-01-09', false);

ALTER TABLE "Modules" ADD FOREIGN KEY ("BootcampID") REFERENCES "Bootcamps" ("BootcampID");

ALTER TABLE "Student_bootcamp_enrollment" ADD FOREIGN KEY ("StudentID") REFERENCES "Students" ("StudentID");

ALTER TABLE "Student_bootcamp_enrollment" ADD FOREIGN KEY ("BootcampID") REFERENCES "Bootcamps" ("BootcampID");

ALTER TABLE "Teacher_module" ADD FOREIGN KEY ("TeacherID") REFERENCES "Teachers" ("TeacherID");

ALTER TABLE "Teacher_module" ADD FOREIGN KEY ("ModuleID") REFERENCES "Modules" ("ModuleID");

ALTER TABLE "Student_module_progress" ADD FOREIGN KEY ("StudentID") REFERENCES "Students" ("StudentID");

ALTER TABLE "Student_module_progress" ADD FOREIGN KEY ("ModuleID") REFERENCES "Modules" ("ModuleID");

