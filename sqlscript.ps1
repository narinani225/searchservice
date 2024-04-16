param (
    [string]$ServerInstance,
    [string]$Database,
    [string]$Username,
    [string]$Password
)

Install-Module -Name SqlServer -Scope CurrentUser -Force

# Import the SQL Server module 
Import-Module -Name SqlServer

$query = @"
/****** Object:  Table [dbo].[Applications]    Script Date: 19-03-2024 01:47:42 ******/
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
      NULL,
    [IsDeleted] [bit] NULL,
    [CreatedTS] [datetime] NULL,
    [ModifiedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
    [Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
# More table creation scripts...
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Username $Username -Password $Password -query $query
