--CREATE Database Student_automation
--DROP TABLE Student_details
--Always comment this out once you're done with it

--CREATE TABLE Student_details(
	Student_no int IDENTITY(1, 10), -- IDENTITY to automatically assign values
	Student_name varchar(255),
	Student_surname varchar(255),
	Insert_date DATETIME default GETDATE()
);

INSERT INTO Student_details(Student_name, Student_surname)
	values ('Sesethu', 'Bango')
