CREATE DATABASE [SQLEXAM]
 CONTAINMENT = NONE
GO

USE [SQLEXAM]
GO
CREATE SCHEMA [DatabaseExam]
GO

CREATE TABLE [DatabaseExam].[Part](
	[P_PARTKEY] [int] IDENTITY(1,1) NOT NULL,
	[P_NAME] [varchar](100) NOT NULL,
	[P_MFGR] [varchar](50) NOT NULL,
	[P_BRAND] [varchar](100) NULL,
	[P_TYPE] [varchar](100) NOT NULL,
	[P_SIZE] [int] NOT NULL,
	[P_CONTAINER] [varchar](100) NOT NULL,
	[P_RETAILPRICE] [real] NOT NULL,
	[P_COMMENT] [varchar](100) NOT NULL
)
Go
CREATE TABLE [DatabaseExam].[Customer](
	[C_CUSTKEY] [int] IDENTITY(1,1) NOT NULL,
	[C_NAME] [varchar](100) NOT NULL,
	[C_ADDRESS] [varchar](50) NOT NULL,
	[C_NATIONKEY] [int] NOT NULL,
	[C_PHONE] [varchar](100) NOT NULL,
	[C_ACCTBAL] [real] NOT NULL,
	[C_MKTSEGMENT][varchar](100) NOT NULL,
	[C_COMMENT] [varchar](100) NOT NULL
)
Go
CREATE TABLE [DatabaseExam].[Nation](
	[N_NATIONKEY] [int] IDENTITY(1,1) NOT NULL,
	[N_NAME] [varchar](100) NOT NULL,
	[N_REGIONKEY] [int] NOT NULL,
	[N_COMMENT] [varchar](100) NOT NULL
)
Go
CREATE TABLE [DatabaseExam].[Region](
	[R_REGIONKEY] [int] IDENTITY(1,1) NOT NULL,
	[R_NAME] [varchar](100) NOT NULL,
	[R_COMMENT] [varchar](100) NOT NULL
)

Go
CREATE TABLE [DatabaseExam].[Orders](
	[O_ORDERKEY] [int] IDENTITY(1,1) NOT NULL,
	[O_CUSTKEY] [int]  NULL,
	[O_ORDERSTATUS] [varchar](10) NOT NULL,
	[O_PARTKEY] [int] NOT NULL,
	[O_LINENUMBER] [int] NOT NULL,
	[O_QUANTITY] [int] NOT NULL,
	[O_TOTALPRICE] [real] NOT NULL,
	[O_ORDERDATE] [date] NULL,
	[O_ORDERPRIORITY] [varchar](MAX) NOT NULL,
	[O_CLERK][varchar](MAX) NOT NULL,
	[O_SHIPPRIORITY] [varchar](10) NOT NULL,
	[O_COMMENT] [varchar](100) NOT NULL
)
Go

-- import the file
BULK INSERT [SQLEXAM].[DatabaseExam].[Part]
FROM 'C:\Users\Mahira\Desktop\mystudy\daboot\Data_Analytics_Final_Exam\DATA\part.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO
-- QUESTION 1
SELECT TOP 100 * FROM [DatabaseExam].[CUSTOMER_] 
SELECT TOP 100 * FROM [DatabaseExam].[NATION_]
SELECT TOP 100 * FROM [DatabaseExam].[ORDERS_]
SELECT TOP 100 * FROM [DatabaseExam].[PART_]
SELECT TOP 100 * FROM [DatabaseExam].[REGION_]


-- QUESTION 2
select COUNT(c.C_CUSTKEY) AS NUMBEROFCUSTOMER from [DatabaseExam].[CUSTOMER_] c
inner join [DatabaseExam].[NATION_] n
on c.C_NATIONKEY = n.N_NATIONKEY
WHERE n.N_NAME = 'RUSSIA' and SUBSTRING(C.C_PHONE, 8, 3) = '683'



-- QUESTION 3
SELECT COUNT(O.O_ORDERKEY) as numberofOrders, COUNT(DISTINCT O.O_ORDERKEY) as amountofUniqueOrders FROM [DatabaseExam].[CUSTOMER_] C
INNER JOIN [DatabaseExam].[ORDERS_] O 
ON C.C_CUSTKEY = O.O_CUSTKEY
WHERE YEAR(O.O_ORDERDATE) = 1998 AND C.C_NAME = 'Customer#000058843'


-- QUESTION 4.1
SELECT TOP 10 C.C_CUSTKEY, SUM(O.O_TOTALPRICE) AS TOTAL_SALES FROM [DatabaseExam].[CUSTOMER_] C
INNER JOIN [DatabaseExam].[ORDERS_] O ON C.C_CUSTKEY = O.O_CUSTKEY
INNER JOIN [DatabaseExam].[NATION_] N ON N.N_NATIONKEY = C.C_NATIONKEY
INNER JOIN [DatabaseExam].[REGION_] R ON R.R_REGIONKEY =N_NATIONKEY
WHERE R.R_NAME = 'EUROPE'
GROUP BY (C.C_CUSTKEY)
ORDER BY TOTAL_SALES DESC

-- QUESTION 4.2
SELECT TOP 10 O_CLERK, SUM(O.O_TOTALPRICE) AS TOTAL_SALES FROM [DatabaseExam].[ORDERS_] O 
INNER JOIN [DatabaseExam].[CUSTOMER_] C ON C.C_CUSTKEY = O.O_CUSTKEY
INNER JOIN [DatabaseExam].[NATION_] N ON N.N_NATIONKEY = C.C_NATIONKEY
INNER JOIN [DatabaseExam].[REGION_] R ON R.R_REGIONKEY =N_NATIONKEY
WHERE R.R_NAME = 'EUROPE'
GROUP BY (O.O_CLERK)
ORDER BY TOTAL_SALES DESC

-- QUESTION 4.3
SELECT TOP 10 P.P_PARTKEY, SUM(O.O_TOTALPRICE) AS TOTAL_SALES FROM [DatabaseExam].[PART_] P
INNER JOIN [DatabaseExam].[ORDERS_] O ON P.P_PARTKEY = O.O_PARTKEY
INNER JOIN [DatabaseExam].[CUSTOMER_] C ON C.C_CUSTKEY = O.O_CUSTKEY
INNER JOIN [DatabaseExam].[NATION_] N ON N.N_NATIONKEY = C.C_NATIONKEY
INNER JOIN [DatabaseExam].[REGION_] R ON R.R_REGIONKEY =N_NATIONKEY
WHERE R.R_NAME = 'EUROPE'
GROUP BY (P.P_PARTKEY)
ORDER BY TOTAL_SALES DESC