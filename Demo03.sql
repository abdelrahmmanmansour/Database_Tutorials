-- Functions: Block Of Query to  aviod DRY Concept(Do not repeat your self+ one of DataBase Object
-- Function Must Return Value : one value or table
-- Scalar Function: Return just Only one value
-- Table-Valued-Function: Return Table
-------------------------------------------------------------------------------------------------------------

-- Builtin Function:
-- 1- Aggregate Functions (Count,Sum,Avg,Max,Min)
Use ITI
-- 1.1: Count(Coloumn Name OR *)
Select COUNT(*) --  15 Record
From Instructor

Select COUNT(Ins_Id)  --  15
From Instructor

Select COUNT(Ins_Name) -- 15 name
From Instructor

Select COUNT(Salary)  --  14  +  null is not a value
From Instructor
----------------------------------------------------------------
--1.2: Sum(Coloumn Name must numeric)
Select Sum(Salary)  --974053.00
From Instructor

Select Sum(Dept_Id)  --400
From Instructor

Select Sum(Ins_Name)  --Invalid
From Instructor
----------------------------------------------------------------
--1.3: Avg(Coloumn Name must numeric)
Select AVg(Salary)  --69575.2142
From Instructor

Select AVg(Ins_Name)  --Invalid
From Instructor
----------------------------------------------------------------
-- 1.4- Max(Coloumn Name may numeric or string)
Select Max(Salary)  --323423.00
From Instructor

Select Max(Ins_Name)  -- max by ÇáÊÑÊíÈ ÇáÇÈÌÏì
From Instructor
----------------------------------------------------------------
-- 1.5- Min(Coloumn Name may numeric or string)
Select Min(Salary)  --2323.00
From Instructor

Select Min(Ins_Name)  -- Min by ÇáÊÑÊíÈ ÇáÇÈÌÏì
From Instructor
----------------------------------------------------------------
-- 2- Null Functions: two paramters +  Return value or null
-- 2.1: ISNull(Expression(Çááì ÇäÇ ÔÇßß ÇäÉ åíßæä È ÕÝÑ),Replacement Value)
Select St_Fname
From Student

Select St_Id,ISNULL(St_Fname,ISNULL(St_lname,'NO Name'))
From Student

Select ins_Id,ISNULL(Salary,Ins_Name) -- Invalid(How insert integer in string)
From Instructor

Select ins_Id,ISNULL(Ins_Name,Salary) -- valid insert string in integer
From Instructor
----------------------------------------------------------------
-- 2.2- Coalesce(any paramters): Return value or null
Select Coalesce(St_Fname,St_lname,'No Name')
From Student
----------------------------------------------------------------
-- 3- Covert Functions:  Convert from any DataType to any DataType(compatable)
-- 3.1- Convert(DataType,Target)
Select ISNULL(St_Fname,'NO NAME')+' '+ISNULL(CONVERT(varchar(40),St_Age),'NO AGE')
From Student
----------------------------------------------------------------
-- 3.2- Cast(Target as DataType)
Select ISNULL(St_Fname,'NO NAME')+' '+ISNULL(Cast(St_Age as Varchar(30)),'NO AGE') 
From Student
-- NOTE: when you convert from DateTime to Varchar may be convert function take third paramter
-- GetDate Function: Return My Moment ÇááÍÙÉ Çááì ÇäÇ ÝíåÇ
Select GETDATE() --2025-05-31 12:52:25.570
Select CONVERT(varchar(MAX),GETDATE()) --May 31 2025 12:53PM
Select Cast(GETDATE() as Varchar(MAX)) --May 31 2025 12:54PM
Select CONVERT(varchar(MAX),GETDATE(),101) --05/31/2025
Select CONVERT(varchar(MAX),GETDATE(),102) --2025.05.31
Select CONVERT(varchar(MAX),GETDATE(),103) --31/05/2025
Select CONVERT(varchar(MAX),GETDATE(),104) --31.05.2025
Select CONVERT(varchar(MAX),GETDATE(),107) --May 31, 2025
Select CONVERT(varchar(MAX),GETDATE(),127) --2025-05-31T12:57:21.610
Select CONVERT(nvarchar(MAX),GETDATE(),130) -- 4 Ðæ ÇáÍÌÉ 1446 12:56:39:827PM
Select CONVERT(nvarchar(MAX),GETDATE(),131) -- 4/12/1446 12:56:53:040PM
---------------------------------------------------------------------------------------------------
--  4- Date And Time Function:
Select SYSDATETIME() --2025-05-31 13:15:31.6245080
Select SYSUTCDATETIME() --2025-05-31 10:15:56.8031056
Select GETDATE() --2025-05-31 13:16:24.053
Select DATENAME(DAY,'2025/05/31') --31
Select DATENAME(MONTH,'2025/05/31') --May
Select DATENAME(YEAR,'2025/05/31') --2025
Select Day('2025/05/31') --31
Select EOMONTH('2025/05/31') --2025-05-31
Select EOMONTH('2025/04/2') --2025-04-30
Select ISDATE('2025-05-31') --1 :true
Select ISDATE('2025-05-33') --0 :false
----------------------------------------------------------------
-- 5-String Functions:
-- 5.1- Concat: Convert any paramter to varchar the concat, null empty value
Select CONCAT(St_Fname,St_Lname,St_Age)
From Student

Select UPPER(St_Fname)
From Student

Select Lower(St_Fname)
From Student

Select St_Fname,Len(St_Fname)
From Student

Select Substring('Mansour',1,3)
Select ASCII('s') -- 115
Select ASCII('S')  -- 83
Select char(83)  -- S
----------------------------------------------------------------
-- 6- Format: Display With Specific Format (time,date)
Select  FORMAT(Salary,'###,##')
From Instructor

Select Format(GETDATE(),'d') --5/31/2025
Select Format(GETDATE(),'dd') --31
Select Format(GETDATE(),'ddd') --Sat
Select Format(GETDATE(),'dddd') --Saturday
Select Format(GETDATE(),'dddd MM') --Saturday 05
Select Format(GETDATE(),'dddd MMMM') --Saturday May
Select Format(GETDATE(),'dddd MMMM yyyy') --Saturday May 2025
Select Format(GETDATE(),'dddd MMMM yyyy','ar') --ÇáÓÈÊ Ðæ ÇáÍÌÉ 1446
Select Format(GETDATE(),'dddd MMMM yyyy','en') --Saturday May 2025
Select Format(GETDATE(),'dddd MMMM yyyy hh:mm:ss:tt','ar') --ÇáÓÈÊ Ðæ ÇáÍÌÉ 1446 02:05:56:ã
Select Format(GETDATE(),'dddd MMMM yyyy hh:mm:ss:tt','en') --Saturday May 2025 02:06:26:PM
-----------------------------------------------------------------------------------------------------
-- Group By: Split table to groups:  not (*,Primary Key)
Select Dept_id,Min(Salary)
From Instructor
Where Dept_id is not null
Group By Dept_Id

Select Dept_Id,COUNT(*) -- Error: Select Coloumn with Aggregate function so must use  Group by this column
From Instructor
Where Dept_Id  is not null
Group By Dept_Id

Select Dept_Id,COUNT(*) -- Error:Where with Aggregate Function so use Having or subquery
From Instructor
Where COUNT(*) >=2
Group By Dept_Id

-- Where : Deal With Rows 
-- Having: Deal With Groups same like Where Condition after group by
Select Dept_Id,COUNT(*) 
From Instructor
Group By Dept_Id
Having COUNT(*) >=2

--  if you want to  group by multi table:
Select D.Dept_Name,S.Dept_Id,COUNT(*)
From Student S,Department D
Where S.Dept_Id is not null  AND D.Dept_Id=S.Dept_Id --PK=FK
Group By S.Dept_Id,D.Dept_Name
Having COUNT(*)>2
----------------------------------------------
-- Top: Use to get number of record from begin
Select Top(5)*
From Student

Select Top(5)St_Fname,St_Lname,St_Age
From Student
-- end 5 of record: 
Select Top(5) St_Fname
From Student
Order BY St_Id Desc

Select Top(5) St_Fname,St_lname,St_age
From Student
Where St_Age is not null
Order By St_Age
---------------------------------------------------------------------
--  Top With Ties: must use order by + if last value is repeat then display all them also
Select Top(5)with ties St_Fname,St_lname,St_age
From Student
Where St_Age is not null
Order By St_Age
-----------------------------------------------------------------------
-- Random Selection:
-- NEWID()<< Generate GUID: Global Universal ID<< Unique 32 digits
Select NEWID()

Select Top(5) St_Fname,St_Fname,St_Age
From Student
Order By NEWID()
-------------------------------------------------------------------------

