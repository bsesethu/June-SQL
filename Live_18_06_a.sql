--This is a challenge. Get the random generator working
DECLARE @x varchar(255)
SELECT @x = (SELECT crypt_gen_random(5) AS x --I don't know what this is or means
             FOR XML PATH('root'), TYPE).value('/root[1]/x[1]', 'varchar(255)')
--SELECT len(@x), @x
DECLARE @y varchar(255)
SELECT @y = (SELECT crypt_gen_random(5) AS y --I don't know what this is or means
             FOR XML PATH('root'), TYPE).value('/root[1]/y[1]', 'varchar(255)')


INSERT INTO Student_details(Student_name, Student_surname)
--	VALUES ('Dave', 'Sopela')
	VALUES (@x, @y)
	

	--This works!! This whole thing absolutly works
--This query just won't work in the jobs 'steps' thing