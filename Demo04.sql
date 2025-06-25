-- SubQuery: Query inside Query.
-- Output of SubQuery(Inner Query) AS Input to Another Query(Outer Query).
USE ITI
-- EXamples:
Select AVG(St_Age)
From Student --26

Select St_Id,St_Fname,St_Age
From Student
Where St_Age> (Select AVG(St_Age)From Student)

Select Count(*)
From Student --22

Select St_Id,(Select Count(*)From Student)
From Student

Select Distinct Dept_Id
From Student
Where Dept_Id is not null

Select Dept_Name
From Department
Where Dept_Id in (Select Distinct Dept_Id
From Student
Where Dept_Id is not null)

-- Best Practice Using Join
Select Distinct Dep.Dept_Name,ST.Dept_Id 
From Student ST,Department DEP
Where DEP.Dept_Id=ST.Dept_Id

Select St_Id
From Student
Where St_Address='Mansoura'

Delete From Stud_Course
Where St_Id in(Select St_Id
From Student
Where St_Address='Mansoura')

Select Max(Salary)
From Instructor

Select Salary
From Instructor 
Order By Salary DESC  --323423.00

Select Max(Salary)
From Instructor
Where Salary!= (Select Max(Salary)
From Instructor)  --323423.00


Select top(1) * From

(Select TOP(2) Ins_Id,Ins_Name,Salary
From Instructor
Order by Salary DESC) AS T  

Order by Salary
------------------------------------------------------------------------------------
-- Built in Functions:
-- Ranking Function:    — Ì» ·«Ï ÃœÊ·
--  Ranking Function(Row_Number,Dence_Rank,Rank,Ntile) must order by
-- 1. Row_Number: ﬂ· Ê«Õœ ·Â  — Ì» „⁄Ì‰ Õ Ï ·Ê ·Â„ ‰›” «·—ﬁ„
-- 2. Dence_Rank: ﬂ· Ê«Õœ ·Â  — Ì» „Œ ·› »” ·Ê «·« ‰‰Ì‰ ·Â„ ‰›” «·—ﬁ„ Ì«ŒœÊ« ‰›” «· — Ì»
-- 3. Rank: same Dence_Rank but (past rank+how many repeat)

Select Ins_Id,Ins_Name,Salary,ROW_NUMBER() over(order by salary ) as RN
From Instructor

Select Ins_Id,Ins_Name,Salary,Dense_Rank() over(order by salary ) as RN
From Instructor

Select Ins_Id,Ins_Name,Salary,Rank() over(order by salary ) as RN
From Instructor

--Using Top:
Select Top(2)*
From Student
order by St_Age DESC

-- Using Ranking Function:

Select St_Id,St_Fname,St_Age,ROW_NUMBER()over (order by st_age Desc) as RN
From Student
Where RN<=2 -- invalid because exuction order

Select * From 
(Select St_Id,St_Fname,St_Age,ROW_NUMBER()over (order by st_age Desc) as RN
From Student) as T
Where RN <=2


--Using Top:
Select Top(1)* From 

(Select top(5)* 
From Student
Where st_age is not null
Order by st_age )  as T
Order by  st_age DESC

-- Using Ranking Function:

Select * From 
(Select *,Rank()over(order by st_age)as RN
From Student
Where St_Age is not null) as T
Where RN =8


Select * From
(Select st_id,St_Fname,St_Age,Dept_id,ROW_NUMBER() over(partition by Dept_id order by st_age)as RN
From Student
Where St_Age is not null AND  Dept_id is not null)as T
Where Rn  =1

Select * From

(Select *,ROW_NUMBER()over(Partition by Dept_id order by salary) as Rn
From Instructor
Where Dept_Id is not null AND Salary is not  null) as T

Where RN=1
--------------------------------------------------------------------------------------
-- 1.4- Ntile(int): »ﬁ”„ ⁄‰ ÿ—Ìﬁ ⁄œœ „⁄Ì‰
Select Ins_Id,Ins_Name,Salary,NTILE(3)over(order by Salary DESC) as RN
From Instructor
Where Salary is not  null
----------------------------------------------------------------------------------------

-- Excuction Order:    — Ì»  ‰›Ì– «·«ﬂÊ«œ
-- 1- from/join/on
-- 2- Where
-- 3- Group By
-- 4- Having
-- 5- Select
-- 6- Distinct
-- 7- Order By
-- 8- Top
--------------------------------------------------------------------------------------------
-- Union Family: Union - Union ALL - Intersect- Except 
-- Note: must be same number of coloumn + compatable
Select St_Fname,St_Lname
From Student
Union All
Select Ins_Name
From Instructor   --invalid
-- Union: Get all values between two set without Duplication
Select St_Fname
From Student
Union
Select Ins_Name
From Instructor

-- Union All : Get all values between two set with Duplication
Select St_Fname
From Student
Union All
Select Ins_Name
From Instructor

-- Intersect : Get all values Common two set 
Select St_Fname
From Student
Intersect
Select Ins_Name
From Instructor

-- Except : Get all values that appear in one set and not appear in another set
Select St_Fname
From Student
Except
Select Ins_Name
From Instructor

Select Ins_Name
From Instructor
Except
Select St_Fname
From Student
--------------------------------------------------------------------------------------------------

-- Select Into && Insert Based on Select:
--DDL(Structure) Select Into: Copy to Table
-- Structure with Data:
Select* into Newttable
From Student
Select St_Fname,St_Age into Newttable1
From Student
--Structure without Data: put condition never Excute
Select * into Newttable2
From Student
Where 1=2
----------------------------------------------------------
-- Insert Based on Select: ·Ê ⁄‰œÏ ÃœÊ· ›«÷Ï …⁄«Ê“«‰”Œ ›Ì… œ« «
Insert into Newttable2
Select *  From Student
--------------------------------------------------------------------------
-- Interview:
-- Drop vs Delete vs Truncate:
--Truncate:  DDL to delete table and recreate it  &&  performance better
----------------------------------------------------------------------------