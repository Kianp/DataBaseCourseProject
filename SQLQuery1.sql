
-- --------------------------------------------------
-- Database Project
-- --------------------------------------------------
-- Date Created: 05/12/2015 01:38:33
-- --------------------------------------------------

-- --------------------------------------------------
--  CREATE
-- --------------------------------------------------

USE [ringolastic];

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Cars]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Cars];
GO
IF OBJECT_ID(N'[dbo].[Contain_Tire]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contain_Tire];
GO
IF OBJECT_ID(N'[dbo].[Contain_Wheel]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contain_Wheel];
GO
IF OBJECT_ID(N'[dbo].[Messages]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Messages];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[Permissions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Permissions];
GO
IF OBJECT_ID(N'[dbo].[TireImageAddresses]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TireImageAddresses];
GO
IF OBJECT_ID(N'[dbo].[Tires]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tires];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[Wheel_Finish]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Wheel_Finish];
GO
IF OBJECT_ID(N'[dbo].[WheelImageAddresses]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WheelImageAddresses];
GO
IF OBJECT_ID(N'[dbo].[Wheels]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Wheels];
GO
IF OBJECT_ID(N'[dbo].[Finishes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Finishes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserId] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [TelephoneNumber] nvarchar(12),
    [MobileNumber] nvarchar(12),
    [Address] nvarchar(max),
    [IsSuperuser] bit  NOT NULL
);
GO

-- Creating table 'Permissions'
CREATE TABLE [dbo].[Permissions] (
    [PermissionId] smallint  NOT NULL,
    [UserId] int  NOT NULL,
	PRIMARY KEY ([PermissionId],[UserId]),
	FOREIGN KEY ([UserId]) REFERENCES Users(UserId) 
);
GO

-- Creating table 'Messages'
CREATE TABLE [dbo].[Messages] (
    [MessageId] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Body] nvarchar(max)  NOT NULL,
    [Date] datetime  NOT NULL DEFAULT GETDATE(),
    [UserId] int  NOT NULL,
	FOREIGN KEY ([UserId]) REFERENCES Users([UserId])
);
GO

-- Creating table 'Wheels'
CREATE TABLE [dbo].[Wheels] (
    [Id] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] nvarchar(max)  NOT NULL,
    [Country] nvarchar(max)  NOT NULL,
    [SdutCount] smallint  NOT NULL,
    [PitchCircleDiametre] float  NOT NULL,
    [RimWidth] float  NOT NULL,
    [RimSize] float  NOT NULL,
    [Model] nvarchar(max)  NOT NULL,
    [Brand] nvarchar(max)  NOT NULL,
    [Price] bigint  NOT NULL,
    [Sales] int  NOT NULL DEFAULT 0,
    [Quantity] int  NOT NULL DEFAULT 0,
    [Date] datetime  NOT NULL DEFAULT GETDATE(),
);
GO
-- Creating table 'Tires'
CREATE TABLE [dbo].[Tires] (
    [Id] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] nvarchar(max)  NOT NULL,
    [Pattern] nvarchar(max)  NOT NULL,
    [Price] bigint  NOT NULL,
    [Country] nvarchar(max)  NOT NULL,
    [SpeedRating] smallint  NOT NULL,
    [Width] float  NOT NULL,
    [Ratio] float  NOT NULL,
    [Diameter] float  NOT NULL,
    [Brand] nvarchar(max)  NOT NULL,
    [Sales] int  NOT NULL DEFAULT 0,
    [Quantity] int  NOT NULL DEFAULT 0,
    [Date] datetime  NOT NULL DEFAULT GETDATE(),
);
GO

-- Creating table 'TireImageAddresses'
CREATE TABLE [dbo].[TireImageAddresses] (
    [Index] smallint IDENTITY(1,1) NOT NULL,
    [TireId] int  NOT NULL,
    [Address] nvarchar(max)  NOT NULL,
	PRIMARY KEY ([Index],[TireId]),
	FOREIGN KEY ([TireId]) REFERENCES Tires([Id]) 
);
GO

-- Creating table 'WheelImageAddresses'
CREATE TABLE [dbo].[WheelImageAddresses] (
    [Index] smallint IDENTITY(1,1) NOT NULL,
    [WheelId] int  NOT NULL,
    [Address] nvarchar(max)  NOT NULL,
	PRIMARY KEY ([Index],[WheelId]),
	FOREIGN KEY ([WheelId]) REFERENCES Wheels([Id]) 
);
GO

-- Creating table 'Cars'
CREATE TABLE [dbo].[Cars] (
    [Id] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Brand] nvarchar(max)  NOT NULL,
    [Model] nvarchar(max)  NOT NULL,
    [Year] smallint  NOT NULL,
);
GO

-- Creating table 'Finishes'
CREATE TABLE [dbo].[Finishes] (
    [Id] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] nvarchar(max)  NOT NULL,
    [HexCode] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [State] smallint  NOT NULL DEFAULT 0,
    [Date] datetime  NOT NULL DEFAULT GETDATE(),
    [Cost] bigint  NOT NULL DEFAULT 0,
    [UserId] int  NOT NULL,
	FOREIGN KEY ([UserId]) REFERENCES Users([UserId]),
);
GO

-- Creating table 'WheelFinish'
CREATE TABLE [dbo].[Wheel_Finish] (
    [Wheels_Id] int  NOT NULL,
    [Finishes_Id] int  NOT NULL,
	PRIMARY KEY ([Wheels_Id],[Finishes_Id]),
	FOREIGN KEY ([Wheels_Id]) REFERENCES Wheels(Id),
	FOREIGN KEY ([Finishes_Id]) REFERENCES [Finishes](Id),
);
GO

-- Creating table 'Contain_Tire'
CREATE TABLE [dbo].[Contain_Tire] (
    [Orders_Id] int  NOT NULL,
    [Tires_Id] int  NOT NULL,
	[Quantity] int NOT NULL,
	PRIMARY KEY ([Tires_Id],[Orders_Id]),
	FOREIGN KEY ([Tires_Id]) REFERENCES Tires(Id),
	FOREIGN KEY ([Orders_Id]) REFERENCES Orders(Id),
);
GO

-- Creating table 'OrderWheel'
CREATE TABLE [dbo].[Contain_Wheel] (
    [Orders_Id] int  NOT NULL,
    [Wheels_Id] int  NOT NULL,
	[Quantity] int NOT NULL,
	PRIMARY KEY ([Wheels_Id],[Orders_Id]),
	FOREIGN KEY ([Wheels_Id]) REFERENCES Wheels(Id),
	FOREIGN KEY ([Orders_Id]) REFERENCES Orders(Id),
);
GO


-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------

INSERT INTO [dbo].[Users] ([Name], [Email], [TelephoneNumber], [MobileNumber],  [IsSuperuser])
VALUES ('Bardia', 'bardia.heydarinejad@gmail.com', '77496985','09197386276',1);
INSERT INTO [dbo].[Users] ([Name], [Email], [MobileNumber], [Address], [IsSuperuser])
VALUES ('Kian', 'kian.peymani@gmail.com','09123041726','tehran sohanak',1);

INSERT INTO [dbo].[Wheels] ([Name], [Country], [SdutCount], [PitchCircleDiametre], [RimWidth], [RimSize], [Model], [Brand], [Price]) 
	VALUES	('ring tala OZ', 'Germany', 2, 4.5,1.5,21,'Oz 2fz','O.Z.',400000),
			('Ring e khoob', 'Germany', 2, 4.5,1.5,21,'X435','O.Z.',500000)
--			('ESM 007 18X8.5 5X120/114.3 +20 74.1MM HYPER SILVER W/MACHINE LIP & MACHINE FACE',);

INSERT INTO [dbo].[Tires] ([Name],[Pattern], [Price], [Country], [SpeedRating], [Width], [Ratio], [Diameter], [Brand])
VALUES('Lastic jadid', 'Ice',1000000,'Iran',2,19,5.4,4.1,'Iran kavir');

INSERT INTO [dbo].[Orders] (UserId) VALUES (1);
INSERT INTO [dbo].[Orders] (UserId) VALUES (1);
INSERT INTO [dbo].[Orders] (UserId) VALUES (2);

INSERT INTO [dbo].[Contain_Wheel] ([Orders_Id],[Wheels_Id],[Quantity]) VALUES(1,1,10);
INSERT INTO [dbo].[Contain_Wheel] ([Orders_Id],[Wheels_Id],[Quantity]) VALUES(1,2,10);
INSERT INTO [dbo].[Contain_Wheel] ([Orders_Id],[Wheels_Id],[Quantity]) VALUES(2,1,10);
INSERT INTO [dbo].[Contain_Wheel] ([Orders_Id],[Wheels_Id],[Quantity]) VALUES(3,1,10);
INSERT INTO [dbo].[Contain_Tire] ([Orders_Id],[Tires_Id],[Quantity]) VALUES(1,1,10);

select Name, Orders_Id
from dbo.Wheels join dbo.Contain_Wheel on (Wheels.Id = Contain_Wheel.Wheels_Id)

