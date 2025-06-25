-- 1- Comments
-- Single line Comment: use << --
-- this is single line comment
-- Multi Line Commment: use << /**/
/*this is my course backend .net from route acadmy 
i hope when i graduated i want to work at microsoft*/
-- to comment << ctrl+k,ctrl+c
-- to uncomment << ctrl+k,ctrl+u
-- #######################################################################

-- 2- Variables
-- 2.1- Global Variables:
-- to print variable << use print or select 
-- to update << use set
-- Start @@
print @@Version
print @@ServerName
select @@Language

-- 2.2- Local Variables:
-- Start @
-- to declare any local variable << use declare
declare @Name Varchar(10) = 'Mansour'
print @Name
set @name = 'mohamed'
print @name
-- #######################################################################


--3- Data Types:
-- 3.1 - Exact Numerics << int,decimal(,)
-- 3.2 - Approximate numerics << real
-- 3.3 - Date and Time << date,time
-- 3.4 - Character Strings << char,varchar(),nchar,nvarchar()
-- #######################################################################

-- Categories of SQL Server:
-- 1- DDL: Data Definition Language << Behaviour,Structure << (Create,Alter,Drop) 
-- 1.1 - Create: 
Create DataBase Company
-- to select database to make any operations << write use
Use Company
-- To Create Tables:
Create Table Employees
(
SSN int Primary key identity(1,1),  -- Identity: Auto_Generated Sql server make this 1,2,3,4
Fname Varchar(15) not null, -- not null: required to enter your name
Lname Varchar(15), -- optional
Gender Char(1) Default 'M', --	Default: when i not enter my Gender so make it Male
BirthDate date,
Dnum int,
Super_SSN int References Employees(SSN) -- References: this coulmn is a forien key
)

Create Table Departments
(
Dnum int Primary Key identity(10,10),
Dname Varchar(20) not null,
Manager_SSN int not null unique References Employees(SSN),
HiringDate date 
)

Create Table DepartmentLocations
(
DeptNum int References Departments(Dnum),
Location Varchar(30),
Primary Key (DeptNum,Location) -- Composite Primary Key
)

Create Table Projects
(
Pnum int Primary Key Identity,
Pname Varchar(15) not null,
Location Varchar(15),
City Varchar(15),
Dnum int References Departments(Dnum),
)

Create Table Dependents
(
Name Varchar(40),
BirthDate date,
Gender Char(1),
EmpId int References Employees(SSN),
Primary Key (Name,EmpId)
)

Create Table EmployeeProjects
(
ESSN int References Employees(SSN),
Epnum int References Projects(Pnum),
NumofHours int,
Primary Key (ESSN,Epnum)
)
-- #######################################################################

-- 1.2 - Alter:
-- Alter DataBase Name:
-- ÚáÔÇä ÊÚÏá Çì ÍÇÌÉ áÇÒã ãÊæÞÝÔ ÚáíåÇ 
Alter DataBase Company1
Modify name = Company

-- Alter DataBase Object:
-- Add (column,constrain)
-- Alter Alter(datatype)
-- Alter Drop (Drop coloumn,Drop constrain)

-- Add coulmn:
Alter Table Employees
Add Test int

-- Add Constrain:
-- 1:
Alter Table Employees
Add Constraint UQ_Test Unique(Test)
-- 2:
Alter Table Employees
Add Unique(Test)


-- Change Datatypes:
-- Alter Alter
Alter Table Employees
Alter Column Test bigint

-- Add forien key:
Alter Table Employees
Add Foreign Key(Dnum) References Departments(Dnum) 


-- Drop Constraint:
Alter Table Employees
Drop Constraint UQ_Test 
-- Drop coulmn:
Alter Table Employees
Drop Column Test


--1.3 - Drop:
--1.3.1- Drop DataBase:
-- Drop DataBase name
-- 1.3.2 - Drop Table: áÇÒã ãíßæäÔ ãÚÊãÏ Úáì ÍÇÌÉ 
-- Drop Table name
