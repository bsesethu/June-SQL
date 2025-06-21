SELECT TOP (1000) [Student_no]
      ,[Student_name]
      ,[Student_surname]
      ,[Insert_date]
  FROM [Student_automation].[dbo].[Student_details]
  ORDER BY [Insert_date];

  DELETE FROM Student_details
  WHERE Insert_date > '2025-06-18 17:00' AND Insert_date < '2025-06-18 21:00'
