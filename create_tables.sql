USE [GardnerSql]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 4/3/2021 8:37:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---- Customer ----
CREATE TABLE [dbo].[Customer](
	[CustID] [int] IDENTITY(1,1) PRIMARY KEY,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_FirstName]  DEFAULT ('') FOR [FirstName]
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_LastName]  DEFAULT ('') FOR [LastName]
GO

CREATE INDEX [IDX_Customer_FirstName] ON [dbo].[Customer] ([FirstName])
GO
CREATE INDEX [IDX_Customer_LastName] ON [dbo].[Customer] ([LastName])
GO


---- Order ----
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) PRIMARY KEY,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustID])
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO

CREATE INDEX [IDX_Order_OrderDate] ON [dbo].[Order] ([OrderDate])
GO

---- OrderLine ----
CREATE TABLE [dbo].[OrderLine](
	[OrderLineId] [int] IDENTITY(1,1) PRIMARY KEY,
	[OrdID] [int] NOT NULL,
	[ItemName] [nvarchar](100) NOT NULL,
	[Cost] [decimal](19, 4) NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_Order] FOREIGN KEY([OrdID])
REFERENCES [dbo].[Order] ([OrderID])
GO

ALTER TABLE [dbo].[OrderLine] ADD  CONSTRAINT [DF_OrderLine_Cost]  DEFAULT (0.00) FOR [Cost]
GO

ALTER TABLE [dbo].[OrderLine] ADD  CONSTRAINT [DF_OrderLine_Quantity]  DEFAULT (0) FOR [Quantity]
GO

ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_Order]
GO

CREATE INDEX [IDX_OrderLine_Cost] ON [dbo].[OrderLine] ([Cost])
GO