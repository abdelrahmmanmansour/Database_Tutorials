-- 1- Strored Procedure: DataBase Object + Layer Encapsulate Query to get better performance
-- Sp: Like Function in Programmig 
-- Body of SP : Any Query U Want 
-- Query Life Cycle:   «·Õ«Ã«  «··Ï » ⁄œÏ ⁄·ÌÂ« ⁄‘«‰ «·‰« Ã Ìÿ·⁄ „Ÿ»Êÿ
-- 1. Parsing Syntax: Check Syntax is Right or False
-- 2. Optmize Metadata: Matching Tables or Columns Name are Right or False
-- 3. Query Tree: Excuction Order
-- 4. Excuction Plan: Result Show
-- Benifits of SP:
-- 1. Improved Performance
-- 2. Stronger Security[Hidding Metadata]
-- 3. Reduce of Server Network Traffic
-- 4. Hide Logic
-- 5. Handle Errors
-- 6. Accept Input Output Paramter
----------------------------------------------------------------------------------------------
-- EX01 SP:
USE ITI
GO
Create Or Alter Procedure SP_GetStudentDataByID(@STID int)
With Encryption  -- To Encrypt it
AS
 -- Code:
     Select *
	 From Student
	 Where St_Id=@STID
GO
SP_HelpText'SP_GetStudentDataByID' --The text for object 'SP_GetStudentDataByID' is encrypted
-- To Call Any Procedure: His Name
GO
SP_GetStudentDataByID 1
Execute SP_GetStudentDataByID 1
-- When i need to put Keyword[Execute]: When i make Statement Above My SP
GO
Declare @ID int =8
Execute SP_GetStudentDataByID @ID
Go
-- EX02 SP:
Go
Create or Alter Procedure SP_GetInstructorsByDeptID(@DeptID int)
With Encryption -- To Encrypt it
AS
 -- Code:
    Select Ins_Name
	From Instructor
	Where Dept_Id= @DeptID
Go
SP_GetInstructorsByDeptID 10
Go
SP_GetInstructorsByDeptID '10'
Go
SP_GetInstructorsByDeptID 'Ali'  -- Invalid To Convert
----------------------------------------------------------------------------------------------
-- Error Handling In SP: [Try Catch Block]:
GO
Create or Alter Procedure SP_DeleteTopicID(@TpoicID int)
With Encryption -- To Encrypt it
AS
 -- Code:
    Begin Try
	-- Code:
	    Delete From Topic
	    Where Top_Id= @TpoicID
	End Try
	Begin Catch
	-- Code: Print Friendly Message
	  Print 'Sorry,U can not Delete This Topic.'
	End Catch
Go
SP_DeleteTopicID 1  -- Sorry,U can not Delete This Topic.
Execute SP_DeleteTopicID 1  -- Sorry,U can not Delete This Topic.
----------------------------------------------------------------------------------------------
-- Insert Based On Execute: Like Insert Based On Select
-- Copy Data in SP to Any Table
GO
Create or Alter Procedure SP_StudentAddresses(@Address Varchar(MAX))
With Encryption -- TO Encrypt it
AS
 -- Code:
   Select St_Id,St_Fname,St_Address
   From Student 
   Where St_Address= @Address
GO
SP_StudentAddresses 'Cairo'
Create Table StudentAddress
(
ID int Primary Key,
Fname Varchar(20),
Address Varchar(20)
)
Insert Into StudentAddress
Execute SP_StudentAddresses 'Alex'
----------------------------------------------------------------------------------------------
-- Passing Paramters:
GO
Create or Alter Procedure SP_SutractToVariable(@X int=10,@Y int=4)
With Encryption -- TO Encrypt it
AS
 -- Code:
      Print @X-@Y
GO
SP_SutractToVariable 10,5  -- Passing By Order  -- 5
GO
SP_SutractToVariable @Y=10,@X=5  -- Passing By Name  -- -5
GO
SP_SutractToVariable -- Passing Default Value   -- 6
GO
SP_SutractToVariable 14 -- Passing Default Value  -- 10
----------------------------------------------------------------------------------------------
-- Output Paramters: Return Value From SP
GO
Create or Alter Procedure GetStudentNameAndAgeByID  @ID int,@StName Varchar(20)output,@StAge int output
With Encryption -- To Encrypt it
AS
 -- Code:
   Select @StName=St_Fname,@StAge= St_Age
   From Student
   Where St_Id= @ID AND St_Fname IS Not Null AND St_Lname IS Not Null 
GO
Declare @Stname Varchar(20),@Stage int
Execute GetStudentNameAndAgeByID 10,@Stname output,@Stage output
Select @Stname AS Name,@Stage AS Age
----------------------------------------------------------------------------------------------
-- Input Output Paramter:
GO
Create or Alter Procedure GetStudentNameAndAgeByIDv01  @Data int output,@StName Varchar(20)output
With Encryption -- To Encrypt it
AS
 -- Code:
   Select @StName=St_Fname,@Data= St_Age --Output
   From Student
   Where St_Id= @Data AND St_Fname IS Not Null AND St_Lname IS Not Null 
GO
Declare @Stname Varchar(20),@Data int=1
Execute GetStudentNameAndAgeByIDV01 @Data output,@Stname output
Select @Stname AS Name,@Data AS Age
----------------------------------------------------------------------------------------------
-- Function VS View VS StoredProcedure [Most Common Question In Interview]:
-- The Same: Three are DataBase Objects,When i put Query in all << Get Better Performance

-- Differences About Body:
-- Function:[Select Statement or Select Based On Select]
-- View:[Select Statement]
-- StoredProcedure: Any thing

-- Differences About Paramter:
-- Function:Have Paramter or not
-- View:Not Have Any Paramter
-- StoredProcedure: Have Paramter or not[Input Output Paramter]

-- Differences About Return:
-- Function:Must Return Value
-- View:Not Return
-- StoredProcedure: May be or not
----------------------------------------------------------------------------------------------
-- 2- Trigger:
-- DataBase Object,Special Type of StoredProcedure
-- U can not Call it,not have paramter
-- Trriger will fire When Event Occured:
-- Server Level,DB Level,Table or View[insert,update,delete]
-- Trigger will excute After Action or Instead of Action
----------------------------------------------------------------------------------------------
-- Ex:
GO
Create or Alter Trigger Tri_Welcome
ON Student
With Encryption -- To Encrypt it
After Insert 
AS
  --Code:
  Print 'Welcome To ITI Student'
GO
Insert Into Student(St_Id,St_Fname,St_Lname,St_Address,St_Age)Values(,'Rawan','Hosny','Cairo',21)
-----------------------------------------------------------------------------------------
GO
Create or Alter Trigger Tri_WelcomeV02
ON Student
With Encryption -- To Encrypt it
After Insert 
AS
  --Code:
  Print 'Welcome To ITI Student Again'
GO
Insert Into Student(St_Id,St_Fname,St_Lname,St_Address,St_Age)Values(90,'Rawan','Hosny','Cairo',21)
-----------------------------------------------------------------------------------------
GO
Create or Alter Trigger Tri_Update
ON Student
With Encryption -- To Encrypt it
After Update
AS
 -- Code:
   Select SUSER_NAME() AS Name,GetDate() AS Time
GO
Update Student
Set St_Fname='Naser'
Where St_Id=90
-----------------------------------------------------------------------------------------
Go
Create or Alter Trigger Tri_PreventDeletOnStudentTable
ON Student
With Encryption -- To Encrypt it
Instead Of Delete
AS
 -- Code:
    -- RollBack Transaction: Delete And Back to you again.
    Print 'U can not Delete From this table'
Go
Drop  trigger Tri_PreventDeletOnStudentTable
On student
Delete From Student
Where St_Id=90   -- U can not Delete From this table + (1 row affected)
-----------------------------------------------------------------------------------------
GO
Create or Alter Trigger Tri_PreventDMLOperation
ON Department
Instead of delete,update,insert
AS
-- Code:
   Print 'Sorry,Prevent DML Operation'
GO
Delete From Department -- Sorry,Prevent DML Operation 

Update Department
Set Dept_Name='PR'
Where Dept_Id=90    -- Sorry,Prevent DML Operation

Insert Into Department(Dept_Id,Dept_Name)Values(100,'HPR') --Sorry,Prevent DML Operation
-----------------------------------------------------------------------------------------
-- Delete && Enable && Disable On Trigger:
-- Delete Trigger:
Drop Trigger Tri_WelcomeV02
-- Disable Trigger: Two Ways
-- 1-
GO
Disable Trigger Tri_Welcome
ON Student
GO
--2-
Alter Table Student
Disable Trigger Tri_Welcome

-- Enable Trigger: Two Ways
-- 1-
GO
Enable Trigger Tri_Welcome
ON Student
GO
--2-
Alter Table Student
Enable Trigger Tri_Welcome
---------------------------------------------------------------------------------------
-- Most Points In Trigger:
-- When U Fire The Trigger << Two Tables Created In RunTime[Inserted,Deleted]
-- Insert: Inserted Table Will Contain Inserted Row
-- Delete: Deleted Table Will Contain Deleted Row
-- Update: Inserted Table Will Contain New Row
--         Deleted Table Will Contain Old Row
GO
Create or Alter Trigger Tri_Updated
On Course
With Encryption -- To Encrypt it
After Update
AS
-- Code:
   Select*From inserted
   Select*From deleted
GO
Update Course
Set Crs_Name='Pytho'
Where Crs_Id=100
---------------------------------------------------------------------
GO
Create or Alter Trigger Tri_PreventAnyData
On Topic
With Encryption -- To Encrypt it
Instead of Delete
AS
 -- Code
   Select CONCAT('U can not Delete any Topic With ID= '
  ,(Select Top_id From deleted) , ' And His Name '
  ,(Select Top_Name From deleted)
  )
GO
Delete From Topic
Where Top_Id=1
---------------------------------------------------------------------
