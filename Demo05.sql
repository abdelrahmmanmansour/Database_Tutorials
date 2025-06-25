-- Functions : Block OF Query + Must Return Value+ have Parameter or not
-- 1. Scalar Function << Return only one value
-- 2. Table-Valued-Function << Return Table
-- 2.1- Inline Table-Valued-Function     <<          Return Table       
-- 2.2- Multistatements Table-Valued-Function   <<    Return Table		

-- Any Function Consist:
-- Signuture:(Name,Return Type,Paramter)
-- Body: Code(Select Statement or Insert Based on Select)
-----------------------------------------------------------------------------------------
-- 1.User Defiend Functions(UDF):
-- 1.1- Scalar Function:
Use ITI
-- EX 1: 
-- Create Function Take Student_ID then Return His Fullname:
GO
Create Function GetStudentNameByStudentID(@StudentID int)
Returns Varchar(MAX)-- Return Type
-- Scope in Scalar Function:(Begin && End)
Begin
    -- Code:
	Declare @StudentFulllName Varchar(MAX)
	Select @StudentFulllName= St_Fname+' '+St_Lname
	From Student
	Where St_Id= @StudentID

	Return @StudentFulllName
End
GO
Select dbo.GetStudentNameByStudentID(16) AS [Full  Name] -- Hasssan Mohmed 
Select dbo.GetStudentNameByStudentID('16') AS [Full  Name] -- Hasssan Mohmed Valid
Print dbo.GetStudentNameByStudentID(1)  -- Ahmed Hassan   
-----------------------------------------------------------------------------------------

-- Ex 2:
-- Create Function Take Department Name then Return Name of Manager:
GO
Create Function GetNameOfManagerByDepartmentName(@DepartmentName Varchar(MAX))
Returns Varchar(MAX)  -- Return Type
-- Scope in Scalar Function:(Begin && End)
Begin
  -- Code
  Declare @InstructorName Varchar(MAX)
  Select @InstructorName= INS.Ins_Name
  From Department DEP inner Join Instructor INS
  ON INS.Ins_Id=DEP.Dept_Manager AND DEP.Dept_Name= @DepartmentName

  Return @InstructorName
End
GO
Select dbo.GetNameOfManagerByDepartmentName('SD') AS[Department Name] --Ahmed
Print dbo.GetNameOfManagerByDepartmentName('SD')  -- Ahmed
Print dbo.GetNameOfManagerByDepartmentName('JAVA')  -- Yasmin
-----------------------------------------------------------------------------------------

-- 1.2- Table Valued Function:
-- 1.2.1- Inline Table Valued Function: Simple Select
-- EX: 
-- Create Function Take Department ID Then Return All Instructors:
GO
Create Function GetAllInstructorsBYDepartmentID(@DepartmentID int)
Returns Table  -- Return Type
AS Return
(
-- Code
  Select Ins_Id,Ins_Name,Dept_Id
  From Instructor
  Where Dept_Id= @DepartmentID
)
GO
Select * From GetAllInstructorsBYDepartmentID(10)
Select * From dbo.GetAllInstructorsBYDepartmentID(20)
-----------------------------------------------------------------------------------------

-- 1.2.2- Multistatements Table-Valued-Function: (Select + Logic[if,while loop])
-- EX:
-- Create Function Take Format [first,last,full] Return Name based on format:
Go
Create Function GetNameBasedOnFormat(@Format Varchar(MAX))
Returns @T Table(St_ID int,St_Name Varchar(MAX))
AS
Begin
-- LOGIC:
   if @Format='First'
   -- Run This:
   Insert Into @T
   Select St_Id,St_Fname
   From Student
   else if  @Format='Last'
   -- Run This:
   Insert Into @T
   Select St_Id,St_Lname
   From Student
   else if  @Format='Full'
   -- Run This:
   Insert Into @T
   Select St_Id,Concat(St_Fname,St_Lname)
   From Student

   Return
End
Go
Select*From GetNameBasedOnFormat('First')
Select*From GetNameBasedOnFormat('Last')
Select*From GetNameBasedOnFormat('Full')
-----------------------------------------------------------------------------------------

-- 2-UDF_View(DataBase Object+ Virtual Table):
--Body of view[only Select Statement]+Block of Query+Saved Query+NOT(Functio&&Take Paramter)

-- Benifits:
-- 1. Simplfy Query
-- 2. Hidden MetaData(Columsn Name,Tables)
-- 3. Abstract Logic of Query
Go
Create View V_StudetData
as
   Select St_Id,St_Age
   From Student
Go
Select*From V_StudetData

-- 2- View:
-- 2.1- Standard View[Select Statement]:
-- NOTE: IF i Want to update on View <<< use Alter
Go
Create View V_StudentsCairo
AS
   Select St_Id,St_Fname,St_Address
   From Student
   Where St_Address='Cairo'
Go
Select*From V_StudentsCairo

Go
Create or Alter View V_StudentsCairo
AS
   Select St_Id,St_Fname,St_Address,St_Age
   From Student
   Where St_Address='Cairo'
Go
Select*From V_StudentsCairo

Go
Create or Alter View V_StudentsAlex
AS
   Select St_Id,St_Fname,St_Address,St_Age
   From Student
   Where St_Address='Alex'
Go
Select*From V_StudentsAlex

GO
Create View V_StudentsDepartments
AS
    Select s.St_Id,s.St_Fname,d.Dept_Id,d.Dept_Name
	From Student S,Department D
	Where S.Dept_Id=D.Dept_Id
Go
Select*From V_StudentsDepartments
Where Dept_Id>10

--Note:SP_HelpText'Name Of View': Display A Query that Result of This View So Encrtp it.
GO
Sp_HelpText'V_StudentsDepartments'
Go

Go
Create Or Alter View V_StudentsDepartments
With Encryption -- TO Encrypt View
AS
    Select s.St_Id,s.St_Fname,d.Dept_Id,d.Dept_Name
	From Student S,Department D
	Where S.Dept_Id=D.Dept_Id
Go

GO
Sp_HelpText'V_StudentsDepartments'
-- The text for object 'V_StudentsDepartments' is encrypted.
Go

Select*From V_StudentsDepartments


-- 2.2- Partioned View: More than one Select Statement
Select*From V_StudentsCairo
Where St_Age>21 
Union All
Select*From V_StudentsAlex
Where St_Age>24 
-----------------------------------------------------------------------------------------
-- View With DML(insert,update,delete):
-- ãáÇÍÙÉ Çá İíæ íÚÊÈÑ ÔÈÇß ááÌÏæá
-- 1. Insert:
-- Must insert primary Key to keep constrains.
Insert Into V_StudetData Values(500,99)
-- note: Invalid use View With DML with more than table but ok seperate table.
Insert Into V_StudentsDepartments Values(50,'mona',60,'HR') -- Invalid
Insert Into V_StudentsDepartments(St_Id,St_Fname)Values(50,'mona') -- valid
Insert Into V_StudentsDepartments(Dept_Id,Dept_Name)Values(90,'hr')-- valid

-- 2. Update:
Update V_StudentsCairo
Set St_Fname='Maha'
Where St_Id=11

-- 3. Delete:
Delete From V_StudentsCairo
Where St_Id=11
-----------------------------------------------------------------------------------------
-- View With Check Option:
-- áæ äÇ ÚÇãá İíæ æÍÇØØ ØÈÚÇ İ ÔÑØ İ áæÚãáÊ ÊÚÏíá Çæ ÇÖÇİÉ æÇáÔÑØ ÛáØ İ 
-- İ ÈÇáÊÇáì åíØáÚ ÇíÑæÑ íäÈåäì Çä ÇáÇÖÇİÉ Çááì ÇäÊ ÚãáÊåÇ ãÔ ãÊæÇİŞÉ ãÚ ÇáÔÑØ
-- EX:
GO
Create Or Alter View V_StudentsCairo  
AS  
   Select St_Id,St_Fname,St_Address,St_Age  
   From Student  
   Where St_Address='Cairo'
GO

Select*From V_StudentsCairo
--not logic because condition so use  With Check Option:
Insert Into V_StudentsCairo Values(100,'Mansour','Alex',21)

GO
Create Or Alter View V_StudentsCairo  
AS  
   Select St_Id,St_Fname,St_Address,St_Age  
   From Student  
   Where St_Address='Cairo' With Check Option
GO

Insert Into V_StudentsCairo Values(101,'Mansour','Alex',21) -- invalid[Check Option]
Insert Into V_StudentsCairo Values(105,'Mansour','Cairo',21) -- valid
-----------------------------------------------------------------------------------------