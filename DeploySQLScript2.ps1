
Install-Module -Name SqlServer -Scope CurrentUser

# Import the SQL Server module 
Import-Module -Name SqlServer
$serverInstance = "rg-workspace-sql-server.database.windows.net"
$database = "test-db"
$username = "Workspaceadmin"
$password = "admin@2024#2103"
$query ="/****** Object:  Table [dbo].[Applications]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationID] [int] NULL,
	[ApplicationName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfigurationAttributes]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationAttributes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Container]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Container](
	[ContainerId] [int] NOT NULL,
	[ContainerName] [varchar](255) NULL,
	[ContainerType] [varchar](50) NULL,
	[CreatedTS] [date] NULL,
	[ModifiedTS] [date] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContainerId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSources]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSources](
	[DataSourceIndexID] [int] IDENTITY(1,1) NOT NULL,
	[DataSourceName] [varchar](100) NULL,
	[CloudProviderName] [varchar](100) NULL,
	[DataSourceIndexName] [varchar](255) NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
	[IndexAliasName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DataSourceIndexID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourcesAccessibleByUserRole]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourcesAccessibleByUserRole](
	[AccessibleDataSourceID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NULL,
	[RoleID] [int] NULL,
	[DataSourceIndexID] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccessibleDataSourceID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceTypes]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceTypes](
	[TypeId] [varchar](25) NOT NULL,
	[TypeName] [varchar](255) NOT NULL,
 CONSTRAINT [Constraint_Name] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DisplayDataCardFields]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DisplayDataCardFields](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [varchar](100) NOT NULL,
	[IsActive] [bit] NULL,
	[IsVisible] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
	[DataSourceIndexId] [int] NULL,
	[DisplayOrder] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IndexFieldDataTypes]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndexFieldDataTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookUp_IndexFieldAnalyzers]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookUp_IndexFieldAnalyzers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Analyzer] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedTs] [datetime] NULL,
	[ModifiedTs] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookup_IndexFieldDataTypes]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookup_IndexFieldDataTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DataType] [varchar](100) NULL,
	[DataTypeDefinition] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedTs] [datetime] NULL,
	[ModifiedTs] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organizations]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizations](
	[OrganizationID] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationName] [varchar](100) NULL,
	[Address] [varchar](255) NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
	[LogoUrl] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFilterConfigurations]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFilterConfigurations](
	[ConfigurationID] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationID] [int] NULL,
	[ApplicationID] [int] NULL,
	[UserID] [int] NULL,
	[FilterName] [varchar](100) NULL,
	[FilterCriteria] [varchar](max) NULL,
	[IsDefault] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ConfigurationID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMappings]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMappings](
	[UserRoleID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NULL,
	[UserID] [int] NULL,
	[RoleID] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 19-03-2024 01:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedTS] [datetime] NULL,
	[ModifiedTS] [datetime] NULL,
	[FullName] [varchar](300) NOT NULL,
	[FirstName] [varchar](300) NULL,
	[LastName] [varchar](300) NULL,
	[Password] [varchar](500) NULL,
	[EmailAddress] [varchar](500) NULL,
	[IsAzureLogin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Applications] ON 

INSERT [dbo].[Applications] ([ApplicationID], [OrganizationID], [ApplicationName], [IsActive], [CreatedTS], [ModifiedTS]) VALUES (1, 1, N'EWS Workspace Search', 1, CAST(N'2024-03-12T13:56:09.030' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Applications] OFF
GO
SET IDENTITY_INSERT [dbo].[Organizations] ON 

INSERT [dbo].[Organizations] ([OrganizationID], [OrganizationName], [Address], [IsActive], [CreatedTS], [ModifiedTS], [LogoUrl]) VALUES (1, N'Client Organization', N'Organization Address', 1, CAST(N'2024-03-12T13:55:17.947' AS DateTime), NULL, N'Logo URL')
SET IDENTITY_INSERT [dbo].[Organizations] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoleMappings] ON 

INSERT [dbo].[UserRoleMappings] ([UserRoleID], [ApplicationID], [UserID], [RoleID], [IsActive], [CreatedTS], [ModifiedTS], [IsDeleted]) VALUES (1, 1, 1, 1, 1, CAST(N'2024-03-12T15:05:51.113' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[UserRoleMappings] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([RoleID], [RoleName], [IsActive], [CreatedTS], [ModifiedTS], [IsDeleted]) VALUES (1, N'Administrator', 1, CAST(N'2024-03-12T15:02:55.403' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [IsActive], [CreatedTS], [ModifiedTS], [FullName], [FirstName], [LastName], [Password], [EmailAddress], [IsAzureLogin]) VALUES (1, 1, CAST(N'2024-03-12T15:04:58.260' AS DateTime), NULL, N'Administrator', N'Admin', N'Account', N'/MvtT+k+nQsgJkNNUX3vvw==', N'admin@workspacesearch.com', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Configur__B0EBDF2F06D0E858]    Script Date: 19-03-2024 01:48:10 ******/
ALTER TABLE [dbo].[ConfigurationAttributes] ADD UNIQUE NONCLUSTERED 
(
	[AttributeName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__IndexFie__A88707A659D0FFB9]    Script Date: 19-03-2024 01:48:10 ******/
ALTER TABLE [dbo].[IndexFieldDataTypes] ADD UNIQUE NONCLUSTERED 
(
	[FieldName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Users_EmailAddress]    Script Date: 19-03-2024 01:48:10 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UK_Users_EmailAddress] UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applications] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Applications] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[ConfigurationAttributes] ADD  DEFAULT ((1)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ConfigurationAttributes] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[DataSources] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DataSources] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[DataSourcesAccessibleByUserRole] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DataSourcesAccessibleByUserRole] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[DisplayDataCardFields] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DisplayDataCardFields] ADD  DEFAULT ((0)) FOR [IsVisible]
GO
ALTER TABLE [dbo].[DisplayDataCardFields] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[IndexFieldDataTypes] ADD  DEFAULT ((1)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[IndexFieldDataTypes] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[LookUp_IndexFieldAnalyzers] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[LookUp_IndexFieldAnalyzers] ADD  DEFAULT (getdate()) FOR [CreatedTs]
GO
ALTER TABLE [dbo].[Lookup_IndexFieldDataTypes] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Lookup_IndexFieldDataTypes] ADD  DEFAULT (getdate()) FOR [CreatedTs]
GO
ALTER TABLE [dbo].[Organizations] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Organizations] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[UserFilterConfigurations] ADD  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[UserFilterConfigurations] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserFilterConfigurations] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[UserRoleMappings] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserRoleMappings] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[UserRoles] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserRoles] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[UserRoles] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedTS]
GO
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organizations] ([OrganizationID])
GO
ALTER TABLE [dbo].[DataSourcesAccessibleByUserRole]  WITH CHECK ADD FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[DataSourcesAccessibleByUserRole]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRoles] ([RoleID])
GO
ALTER TABLE [dbo].[DisplayDataCardFields]  WITH CHECK ADD FOREIGN KEY([DataSourceIndexId])
REFERENCES [dbo].[DataSources] ([DataSourceIndexID])
GO
ALTER TABLE [dbo].[UserFilterConfigurations]  WITH CHECK ADD FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[UserFilterConfigurations]  WITH CHECK ADD FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organizations] ([OrganizationID])
GO
ALTER TABLE [dbo].[UserFilterConfigurations]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserRoleMappings]  WITH CHECK ADD FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Applications] ([ApplicationID])
GO
ALTER TABLE [dbo].[UserRoleMappings]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRoles] ([RoleID])
GO
ALTER TABLE [dbo].[UserRoleMappings]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[GetUserFilterConfigurations]    Script Date: 19-03-2024 01:48:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserFilterConfigurations] (
	@UserID INT,
	@RetMessage VARCHAR(100) OUT,
	@RetVal BIT OUT
)
AS
BEGIN
	BEGIN TRY
		
		SELECT UserID,FilterName,FilterCriteria,IsDefault FROM UserFilterConfigurations WITH(NOLOCK)
		WHERE IsActive = 1 AND UserID = @UserID
		
		SET @RetVal = 1
		SET @RetMessage = 'User Filters Fetched Successfully !!'
	END TRY
	BEGIN CATCH
		SET @RetVal = 0
		SET @RetMessage = 'SQL Error'	
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[SaveUserFilterConfigurations]    Script Date: 19-03-2024 01:48:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveUserFilterConfigurations](
	@OrganizationID INT,
	@ApplicationID INT,
	@UserID INT,
	@FilterName VARCHAR(100) = NULL,
	@FilterCriteria VARCHAR(MAX) = NULL,
	@RetMessage VARCHAR(100) OUT,
	@RetVal BIT OUT
)
AS 
BEGIN
	BEGIN TRY
		
		INSERT INTO UserFilterConfigurations WITH(ROWLOCK)(OrganizationID,ApplicationID,UserId,FilterName,FilterCriteria)
		VALUES(@OrganizationID,@ApplicationID,@UserID,@FilterName,@FilterCriteria)
	
		SET @RetVal = 1
		SET @RetMessage = 'User Filter Saved Successfully !!'
	
	END TRY
	BEGIN CATCH
		SET @RetVal = 0
		SET @RetMessage = 'SQL Error'	
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[UpdateUserFilterConfigurationStatus]    Script Date: 19-03-2024 01:48:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateUserFilterConfigurationStatus] (
	@FilterConfigurationID INT,
	@FilterStatus BIT,
	@RetMessage VARCHAR(100) OUT,
	@RetVal BIT OUT
)
AS
BEGIN
	BEGIN TRY
		
		Update UserFilterConfigurations WITH(ROWLOCK)
		SET IsDefault = @FilterStatus
		WHERE ConfigurationID = @FilterConfigurationID
		
		SET @RetVal = 1
		SET @RetMessage = 'User Filter Status Updated !!'
	END TRY
	BEGIN CATCH
		SET @RetVal = 0
		SET @RetMessage = 'SQL Error'	
	END CATCH
END
GO
"

Invoke-Sqlcmd -ServerInstance $serverInstance -Database $database -Username $username -Password $password -query $query
