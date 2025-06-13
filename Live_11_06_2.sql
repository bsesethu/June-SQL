/* VNB Execute each query chunk individually. Don't execute the whole thing together. */

--use Database1 No need for this line when we use Database.
SELECT * FROM [Database1].[dbo].[Subject];

SELECT * FROM [DATABASE2].[DBO].[Subject_scoring];
--Use the square brackets, it's bset practice

--Combine these two tables from differant DBs
SELECT *, 
       ROUND(((A.Subject_marks / B.Scoring_rate) / 10.0), 1) APS
FROM [Database1].[dbo].[Subject] as A
JOIN [DATABASE2].[DBO].[Subject_scoring] as B
ON A.Subject_code = B.Subject_code;


--Also why does dividing by 100 equate to zero, but dividing by 100.0 gives a result
--DEpends on what number is being divided, 60/100 = 0.6, if if we're in integer mode, it will return zero. Hence we have to make it float

use Database1
ALTER TABLE Subject
ADD Identifier varchar(255);

ALTER TABLE Subject
DROP COLUMN Identifier; --Drop is used for tables. Alter and drop go hand in hand


--This one works. Doesn't seem very usefull
--Adds a new row with 'Calculus' as Identifier
INSERT INTO [DATABASE1].[dbo].[Subject] (Identifier)
SELECT 'Calculus'
WHERE EXISTS (
    SELECT Subject_code
    FROM [DATABASE1].[dbo].[Subject]
    WHERE Subject_Code = 1
);


UPDATE Subject
SET Identifier = 'Kemet'
WHERE Subject_code = 4;

SELECT * FROM Subject;

--Delete a row from a table
DELETE FROM Subject
WHERE Subject_code is null

--Not sure what this is
ALTER TABLE [DATABASE1].[dbo].[Subject]
ADD Combined_result varchar(255);


UPDATE Subject
SET Combined_result = CONCAT(Subject_name, ' ',Identifier)
WHERE Subject_code = 4; --It's working. If this was a raaly big table, this would've taken forever. Is there no way to do it in one execution.
                        --Perhaps what's where I would then use Python..

DROP TABLE Subject_scoring;