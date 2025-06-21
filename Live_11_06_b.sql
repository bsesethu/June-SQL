SELECT TOP (1000) [Student_no]
      ,[Student_name]
      ,[Student_surname]
      ,[Insert_date]
  FROM [Student_automation].[dbo].[Student_details]

--Generating a random string value
SELECT SUBSTRING(NEWID(), 8, 4);  
  
SELECT REPLACE(CONVERT(VARCHAR(64),NEWID()),'-','');--Remove '-'

--2nd option
DECLARE @x varchar(255)
SELECT @x = (SELECT crypt_gen_random(5) AS x --I don't know what this is or means
             FOR XML PATH('root'), TYPE).value('/root[1]/x[1]', 'varchar(255)')
SELECT len(@x), @x