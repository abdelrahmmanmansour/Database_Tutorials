-- 1- DML: Data Mainpulation Language (Insert,Update,Delete)  << operations in table
-- 1.1- Insert: Insert one Row or more than one row into any table
-- Simple Insert : Insert only one row && Must be ordered
Insert Into Employees Values('Mansour','Hamed','M','2002/9/21',NULL,NULL)
Insert Into Employees Values('Ahmed','Amin','M','2002/9/21',NULL,1)
-- Insert but not ordered:
Insert Into Employees(Fname,Lname) Values('Mona','Ayman')

-- Row Constructor Insert : Insert more than one Row
Insert Into Employees Values
('Tarek','Bohram','M','2002/9/21',NULL,NULL),
('Mariam','Sayed','F','2002/9/21',NULL,NULL)
-----------------------------------------------
Insert Into Employees(Lname,Gender) Values('Samy','F')  -- not valid: Fname required insert(not allow null)
-- if you want to not insert values in any coulmn there are three Conditions:
-- 1- has Identity
-- 2- allow null
-- 3- has Default value
Insert Into Employees(Fname,Gender) Values('Hussien','M')  -- Valid
Insert Into Departments Values
('HR',1,'2002/9/21'),
('PR',2,'2002/9/21'),
('IT',3,'2002/9/21')
--------------------------------------------------
Insert Into Employees Values('Hassan','Nagy','M','2002/9/21',10,1) -- Valid
Insert Into Employees Values('Mohamed','Samy','M','2002/9/21',100,1) -- Not Valid: Dnum not exsist 100!
----------------------------------------------------------------------------------------------------------------------------


-- 1.2 - Update: Update to Row
Update Employees
Set Gender = 'F'
Where SSN =3

Update Employees
Set Lname = 'Salem'
Where SSN =10
-------------------------------------------------------------------------------------------------------------------------------
-- 1.3 - Delete : Delete Row
Delete From Employees
Where SSN =4

Delete From Departments
Where Dnum=10   -- invalid: Relationship
-- solve
Update Employees
Set Dnum=30
Where Dnum =10
-----------------------------------------------------------------------------------------------------------------------------------
-- 2- DQL : Data Query Language : Display Data (Select) : not change to data just display more than one shape Ôßá 
Select Fname,Lname
From Employees
-- áæ äÇ ÚÇæÒ ÇÓãì ÇÓã ááì åíØáÚ  use as
Select Fname +  ' ' +  Lname as 'Full Name'
From Employees
Select Fname +  ' ' +  Lname as [Full Name]
From Employees
Select  [Full Name] = Fname +  ' ' +  Lname 
From Employees
---------------------------------------------------------------
Use ITI
Select St_Id,St_Fname,St_Lname,St_Age
From Student

Select *
From Student
Where St_Age>=23 and St_Age<=33

Select *
From Student
Where St_Age Between 23 And 33

Select *
From Student
Where St_Age Not Between 23 And 33

Select *
From Student
Where St_Address='Cairo'

Select *
From Student
Where St_Address ='Cairo' or St_Address ='Alex'

Select *
From Student
Where St_Address in ('Cairo','Alex')


Select *
From Student
Where St_Address Not in ('Cairo','Alex')
-- Equal with Values BUT Null is not a value <<< use is or is not
Select *
From Student
Where St_super IS NULL

Select *
From Student
Where St_super IS Not NULL
------------------------------------------------------------------------------------------
-- Select With Like : Display thing as Pattern
-- Whildchar:
-- % <= zero or more character
-- _ <= One character
-- [] <= match with this range
-- [^] <= not match with this range
--Ex:
Select *
From Student 
Where St_Fname Like 'a%'

Select *
From Student 
Where St_Fname Like '%a'

Select *
From Student 
Where St_Fname Like '_%a'

Select *
From Student 
Where St_Fname Like '[sa]%'

Select *
From Student 
Where St_Fname Like '[^sa]%'

Select *
From Student 
Where St_Fname Like '%[%]'
------------------------------------------------------------------------------
-- Select With Distinct : not Duplication
Select Distinct St_Address
From Student
Where St_Address Is Not Null
--------------------------------------------------------------------------------
--Select with Order By: Default Asscending <= asc
Select *
From Student
Order By St_Age desc

Select *
From Student
Order By St_Fname
-- Ýì ÍÇáÉ áæ ÇáÇÓã ÇáÇæá ãÊßÑÑ äÎÊÇÑ Çä ÇÍäÇ äÞÓã È Çááì ÈÚÏ ÇáÝÇÕáÉ
Select *
From Student
Order By St_Fname,St_Lname

-- In sql start from one not zero
Select St_Fname,St_Lname,St_Address
From Student
Order By 3
---------------------------------------------------------------------------------------

-- Join
-- 1- Cross Join(Cartesian Product) <= Generate Fake Data << ÇÍäãÇáÇÊ ááãÚáæãÇÊ Çááì ÚäÏì
-- OLD Syntax : Ansi
Select S.St_Fname,D.Dept_Name
From Student S,Department D
-- New Syntax : Microsoft
Select S.St_Fname,D.Dept_Name
From Student S Cross Join Department D
---------------------------------------------------------------------
-- 2- Inner Join(Equi Join) <= Generate Real Data <= not generate null
-- OLD Syntax : Ansi
Select S.St_Fname,D.Dept_Name
From Student S,Department D
Where S.Dept_Id=D.Dept_Id -- FK=PK
-- New Syntax : Microsoft
Select S.St_Fname,D.Dept_Name
From Student S Inner Join Department D
ON S.Dept_Id=D.Dept_Id -- FK=PK
-- New Syntax : Microsoft
Select S.St_Fname,D.Dept_Name
From Student S Join Department D
ON S.Dept_Id=D.Dept_Id -- FK=PK
-----------------------------------------------------------------------
--3- Outer Join <= Also Generate Real Data <= generate null:
-- 3.1 - Left Outer Join: Foucs Left
Select S.St_Fname,D.Dept_Name
From Student S Left Join Department D
ON S.Dept_Id=D.Dept_Id

-- 3.2 - Right Outer Join: Foucs Right
Select S.St_Fname,D.Dept_Name
From Student S Right Join Department D
ON S.Dept_Id=D.Dept_Id

-- 3.3 - Full Outer Join: Foucs Left,Right
Select S.St_Fname,D.Dept_Name
From Student S Full Join Department D
ON S.Dept_Id=D.Dept_Id
-------------------------------------------------------------------------------------------
-- 4- Self Join (Special Case + Self Relationship):
Select Stud.St_Fname + ' ' + Stud.St_Lname AS [Student Nmae] , Super_St.St_Fname + ' ' + Super_St.St_Lname AS [Super_Name]
From Student Stud,Student Super_St
Where Stud.St_super=Super_St.St_Id

Select Stud.St_Fname + ' ' + Stud.St_Lname AS [Student Nmae] , Super_St.St_Fname + ' ' + Super_St.St_Lname AS [Super_Name]
From Student Stud Join Student Super_St
ON Stud.St_super=Super_St.St_Id

Select Stud.St_Fname + ' ' + Stud.St_Lname AS [Student Nmae] , Super_St.St_Fname + ' ' + Super_St.St_Lname AS [Super_Name]
From Student Stud Left Join Student Super_St
ON Stud.St_super=Super_St.St_Id

Select Stud.St_Fname + ' ' + Stud.St_Lname AS [Student Nmae] , Super_St.St_Fname + ' ' + Super_St.St_Lname AS [Super_Name]
From Student Stud Right Join Student Super_St
ON Stud.St_super=Super_St.St_Id
------------------------------------------------------------------------------------------
-- 5- Multiple Table Join(join which more than two tables)
-- OLD Syntax : Ansi
Select S.St_Fname,SC.Grade,C.Crs_Name
From Student S,Stud_Course SC, Course C
Where S.St_Id=SC.St_Id AND C.Crs_Id=SC.Crs_Id

-- New Syntax : Microsoft
Select S.St_Fname,S.St_Address,SC.Grade,C.Crs_Name
From Student S Join Stud_Course SC
ON S.St_Id=SC.St_Id
Join Course C
ON C.Crs_Id=SC.Crs_Id
Where Sc.Grade>77
------------------------------------------------------------------------------
-- DML+JOIN
Delete From Stud_Course
From Student S,Stud_Course SC
Where S.St_Id=SC.St_Id And S.St_Address='Cairo'


