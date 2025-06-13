CREATE Database Database1
CREATE Database Database2

use Database1
CREATE TABLE Subject(
	Subject_code int,
	Subject_name varchar(255),
	Subject_marks int
);

INSERT INTO Subject
	Values (1, 'Mathematics', 80),
		   (2, 'English', 40),
		   (3, 'Xhosa', 60),
		   (4, 'History', 55);

use Database2
CREATE TABLE Subject_scoring(
	Subject_code int,
	Scoring_rate int,
	Suject_prize varchar(255)
);
	
INSERT INTO Subject_scoring
	values (1, 10, 'Cash'),
		   (2, 12, 'Bubble gum'),
		   (3, 15, 'Skate board'),
		   (4, 5, 'Domestos');