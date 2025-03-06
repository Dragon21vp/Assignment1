USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'SE1940_Prj')
BEGIN
	ALTER DATABASE [SE1940_Prj] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [SE1940_Prj] SET ONLINE;
	DROP DATABASE [SE1940_Prj] ;
END

GO

CREATE DATABASE [SE1940_Prj]
GO

USE [SE1940_Prj]
GO

/*******************************************************************************  
    Drop all tables if they exist  
*******************************************************************************/

-- Khai báo biến để chứa truy vấn động  
DECLARE @sql nvarchar(MAX)  
SET @sql = N''  

-- Tạo truy vấn để xóa tất cả các ràng buộc khóa ngoại (Foreign Key Constraints)  
SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA)  -- Lấy schema của bảng  
    + N'.' + QUOTENAME(KCU1.TABLE_NAME)  -- Lấy tên bảng  
    + N' DROP CONSTRAINT '  -- Lệnh xóa ràng buộc  
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10)  -- Lấy tên của ràng buộc  

FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC  -- Lấy danh sách khóa ngoại  

-- Liên kết với bảng chứa thông tin khóa chính và bảng liên quan  
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1  
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA  
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME  

-- Thực thi lệnh để xóa tất cả ràng buộc khóa ngoại  
EXECUTE(@sql)  

GO  -- Chia khối lệnh trong SQL Server

-- Khai báo biến để chứa truy vấn xóa tất cả các bảng  
DECLARE @sql2 NVARCHAR(max)=''  

-- Tạo truy vấn để xóa toàn bộ bảng trong database  
SELECT @sql2 += 'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '  
FROM INFORMATION_SCHEMA.TABLES  
WHERE TABLE_TYPE = 'BASE TABLE'  -- Chỉ lấy những bảng thông thường (không phải view)  

-- Thực thi truy vấn xóa toàn bộ bảng  
EXEC Sp_executesql @sql2  

GO  -- Kết thúc khối lệnh

--Role
CREATE TABLE [Role] (
    RoleID integer PRIMARY KEY IDENTITY(1, 1),
    RoleName VARCHAR(255) not null,
	Password VARCHAR(255)
);
GO

--Department
CREATE TABLE [Department] (
    DepartmentID integer PRIMARY KEY IDENTITY(1, 1),
    DepartmentName VARCHAR(1000) not null
);
GO

--Status
CREATE TABLE [Status] (
    StatusID integer PRIMARY KEY IDENTITY(1, 1),
    StatusName VARCHAR(255) not null
);
GO

--User
CREATE TABLE [Users] (
    UserID integer PRIMARY KEY IDENTITY(1, 1),
    Username VARCHAR(255) UNIQUE,
	Password VARCHAR(255),
    Name NVARCHAR(255) not null,
	Email VARCHAR(255) UNIQUE,
	Phone VARCHAR(20) UNIQUE,
	DepartmentID INT not null,
	RoleID int,
	Status INT
	FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
	FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);
GO

--Application
CREATE TABLE [Application] (
    ApplicationID integer PRIMARY KEY IDENTITY(1, 1),
    UserID INT not null,
	StartDate DATE,
	EndDate DATE,
	Title NVARCHAR(300),
	Reason NVARCHAR(1500),
	StatusID INT,
	ApproverID INT,
	IsCancel INT
	FOREIGN KEY (UserID) REFERENCES Users(UserID),
	FOREIGN KEY (ApproverID) REFERENCES Users(UserID)
);
GO

