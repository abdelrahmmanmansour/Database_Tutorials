-- 1- TCL: Tranaction Control Language[Control Tarnactions to your DataBase]
-- 1.1- Implicit Tranaction: one Tranaction[DML(Insert,Update,Delete)]:
USE ITI
Insert Into Student(St_Id,St_Fname)Values(20,'Ayman')
-- 1.2- Explict Tranaction: Set Of Implicit Tranaction(Need to Control it):
-- EX:
Create Table Parent
(ParentID int Primary Key)
Create Table Child
(
 ChildID int Primary Key,
 ParentID int References Parent(ParentID)
)
Insert Into Parent Values(1),(2),(3)
Insert Into Child Values(1,1)
Insert Into Child Values(2,13) -- Famous Error: Conflicted with the FOREIGN KEY
Insert Into Child Values(3,3)
Delete From Child
-- How Can i Handle This << USE TCL[Explicit Transaction] Category:
-- Begin Transaction 
-- Your Set Of Implicit Transaction
-- Commit Tran | Roolback Tran
Begin Transaction
   Insert Into Child Values(1,1)
   Insert Into Child Values(2,13) 
   Insert Into Child Values(3,3)
Commit Tran -- ÑæÍ äÝÐ ÏÉ ÚáØæá

Begin Transaction
   Insert Into Child Values(1,1)
   Insert Into Child Values(2,13) 
   Insert Into Child Values(3,3)
RollBack Tran -- ÑæÍ äÝÐ æÇÑÌÚ Ýì ßáÇãß ãä ÊÇäì æáßä ãÔ åíÓãÚ Ý ÇáÌÏæá

-- ÈÓ äÇ ÇáæÞÊì ÚÇæÒ íäÝÐ ßá ÍÇÌÉ ÕÍ ÈÓ áæ Ýì ÇíÑæÑ ÇÑÌÚ Ý ßáÇãß 
-- Using Try Catch With TCL:
Begin Try
Begin Transaction
   Insert Into Child Values(1,1)
   Insert Into Child Values(2,13) 
   Insert Into Child Values(3,3)
Commit Tran
End Try
Begin Catch
Rollback Tran  -- ÇÑÍÚ Ýì ßáÇãß
End Catch

Begin Try
Begin Transaction
   Insert Into Child Values(1,1)
   Insert Into Child Values(2,13) 
   Insert Into Child Values(3,3)
Commit Tran
End Try
Begin Catch
Commit Tran -- äÝÐ ÇáÍÇÌÉÇáÕÍ ÝÞØ
End Catch

Begin Try
Begin Transaction
   Insert Into Child Values(1,1)
   Insert Into Child Values(2,3) 
   Insert Into Child Values(3,3)
Commit Tran
End Try
Begin Catch
Commit Tran -- äÝÐ ÇáÍÇÌÉÇáÕÍ ÝÞØ
End Catch
-----------------------------------------------------------------------------------------
-- Index: Improve Operations On DataBase
-- B-Tree: ÇáÍÇÌÉ Çááì ÈÑÊÈ ãä ÎáÇáåÇÇì ÌÏæá ÚäÏì ÈãÚáæãíÉ ÇáãÝÊÇÍ ÇáÇÕáì
-- Clustered Index[Default]-< ON Primary Key
-- If i want to Search on any Coloumn not Primary Key(Create index on it): ÚáÔÇä áãÇÇÓÑÔ íßæä ÈäÝÓ ÇáÓÑÚÉ
-- Types Of Indexes:
-- Clustered Index: Reach to Data itself
-- Non-Clustered Index: Reach to Address to Data
-- SO Create Index[DataBase Object]:
Create Clustered Index IndextoFname
ON Student(st_fname) -- Cannot create more than one clustered index on table 'Student'
-- Drop Index id01 on student
Create NONClustered Index id1
ON Student(st_fname)

Select*
From Student
Where St_Fname='Ahmed'

-- Create Unique Index:
Create Unique Index id3
ON Parent(Parentid)
-- SQL-Server-Profiler: tool help to know who table which more operation on it
-----------------------------------------------------------------------------------------
-- Index View:
GO
Create or Alter View V_StudentDepartment
With Encryption,SchemaBinding -- to Encypt it
AS
   Select S.St_Id,S.St_Fname,D.Dept_Id
   From dbo.Student S,dbo.Department D
   Where D.Dept_Id=S.Dept_Id   --PK=FK
GO
Select*From V_StudentDepartment  -- This table not have primary key [not have index]
GO
Create Unique Clustered Index Ix01 -- must shemaBinding on view + not forget dbo.tables
ON V_StudentDepartment(St_Id)
Go

Select *
From V_StudentDepartment
Where St_Id=5
-----------------------------------------------------------------------------------------
-- DCL: Data Control Language[Data Control(Permissions)][Using Wizard]
-- 1.Properties<<Security<<Change from Windows Authntcation Mode to Sql Server and Windows Authntcation Mode
-- 2.Restart
-- 3.Create Users On Server:
-- Click On Security << Login << New Login << Put Login Name[With Sql Server Authntcation] << Then Password
-- Not Enfrorce password policy << Ok
-- then Disconnect << Connect << Sql Server Authntcation << name+password+trust << ok
-- Given permission to user to accsess spesfic DataBase[Windows Authntcation] 
-- ITI DataBase << Security << Users << New user << select my user
-- Create Schema and transfer all table 
-----------------------------------------------------------------------------------------