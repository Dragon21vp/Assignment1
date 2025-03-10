﻿--Role
SET IDENTITY_INSERT [dbo].[Role] ON 
INSERT INTO [dbo].[Role] (RoleID, RoleName) VALUES (0,N'Admin')
INSERT INTO [dbo].[Role] (RoleID, RoleName) VALUES (1,N'Department Manager')
INSERT INTO [dbo].[Role] (RoleID, RoleName) VALUES (2,N'Group Leader')
INSERT INTO [dbo].[Role] (RoleID, RoleName) VALUES (3,N'Staff')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO

--Department
INSERT INTO [dbo].[Department] (DepartmentName) VALUES (N'IT')
INSERT INTO [dbo].[Department] (DepartmentName) VALUES (N'QA')
INSERT INTO [dbo].[Department] (DepartmentName) VALUES (N'Sale')

--Status
INSERT INTO [dbo].[Status] (StatusName) VALUES (N'Inprogress')
INSERT INTO [dbo].[Status] (StatusName) VALUES (N'Approved')
INSERT INTO [dbo].[Status] (StatusName) VALUES (N'Rejected')
INSERT INTO [dbo].[Status] (StatusName) VALUES (N'Canceled')

--User
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'admin', N'123', N'Admin', N'admin@gmail.com', '0987-654-321', 1, 0, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'dpit', N'123', N'Trịnh Trần Phương Tuấn', N'j97@gmail.com', '0987-654-322', 1, 1, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'dpqa', N'123', N'Sơn Tùng MTP', N'mtp@gmail.com', '0987-654-323', 2, 1, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'dpsale', N'123', N'Soobin Hoàng Sơn', N'soobin@gmail.com', '0987-654-444', 3, 1, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'grit', N'123', N'Hà Anh Tuấn', N'hat@gmail.com', '0987-654-324', 1, 2, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'grqa', N'123', N'Phan Mạnh Quỳnh', N'pmq@gmail.com', '0987-654-325', 2, 2, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'grsale', N'123', N'KICM', N'kicm@gmail.com', '0987-654-326', 3, 2, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'stit1', N'123', N'MCK', N'mck@gmail.com', '0987-654-327', 1, 3, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'stit2', N'123', N'Wxdie', N'wxdie@gmail.com', '0987-654-328', 1, 3, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'stqa1', N'123', N'TLinh', N'tlinh@gmail.com', '0987-654-329', 2, 3, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'stqa2', N'123', N'Bình Gold', N'binhgold@gmail.com', '0987-654-330', 2, 3, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'stsale1', N'123', N'Phúc Du', N'phucdu@gmail.com', '0987-654-331', 3, 3, 1)
INSERT INTO [dbo].Users (Username, Password, Name, Email, Phone, DepartmentID, RoleID, Status) 
VALUES (N'stsale2', N'123', N'Bray', N'bray@gmail.com', '0987-654-332', 3, 3, 1)


--Application
INSERT INTO [dbo].Application (UserId, StartDate, EndDate, Title, Reason, StatusID) 
VALUES (2, CAST(N'2025-03-05' AS Date), CAST(N'2025-03-07' AS Date), N'Đơn xin nghỉ ốm', N'Tôi bị ốm', 1)
INSERT INTO [dbo].Application (UserId, StartDate, EndDate, Title, Reason, StatusID, ApproverID) 
VALUES (2, CAST(N'2025-03-05' AS Date), CAST(N'2025-03-07' AS Date), N'Đơn xin nghỉ ốm', N'Tôi bị ốm', 2, 2)
INSERT INTO [dbo].Application (UserId, StartDate, EndDate, Title, Reason, StatusID, ApproverID) 
VALUES (2, CAST(N'2025-03-05' AS Date), CAST(N'2025-03-07' AS Date), N'Đơn xin nghỉ ốm', N'Tôi bị ốm', 3, 2)
INSERT INTO [dbo].Application (UserId, StartDate, EndDate, Title, Reason, StatusID) 
VALUES (8, CAST(N'2025-03-05' AS Date), CAST(N'2025-03-07' AS Date), N'Đơn xin nghỉ ốm', N'Tôi bị ốm', 1)
INSERT INTO [dbo].Application (UserId, StartDate, EndDate, Title, Reason, StatusID, ApproverID) 
VALUES (8, CAST(N'2025-03-05' AS Date), CAST(N'2025-03-07' AS Date), N'Đơn xin nghỉ ốm', N'Tôi bị ốm', 2, 2)
INSERT INTO [dbo].Application (UserId, StartDate, EndDate, Title, Reason, StatusID, ApproverID) 
VALUES (8, CAST(N'2025-03-05' AS Date), CAST(N'2025-03-07' AS Date), N'Đơn xin nghỉ ốm', N'Tôi bị ốm', 3, 2)