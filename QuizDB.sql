USE [master]
GO
/****** Object:  Database [QuizDB]    Script Date: 6/2/2020 3:18:17 PM ******/
CREATE DATABASE [QuizDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuizDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuizDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuizDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuizDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuizDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuizDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuizDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuizDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuizDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuizDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuizDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuizDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuizDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuizDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuizDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuizDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuizDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuizDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuizDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuizDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuizDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuizDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuizDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuizDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuizDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuizDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuizDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuizDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuizDB] SET RECOVERY FULL 
GO
ALTER DATABASE [QuizDB] SET  MULTI_USER 
GO
ALTER DATABASE [QuizDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuizDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuizDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuizDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuizDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuizDB', N'ON'
GO
USE [QuizDB]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 6/2/2020 3:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Questions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](500) NULL,
	[Answer1] [nvarchar](200) NULL,
	[Answer2] [nvarchar](200) NULL,
	[Answer3] [nvarchar](200) NULL,
	[Answer4] [nvarchar](200) NULL,
	[CorrectAnswer] [int] NULL,
	[CreateDate] [datetime] NULL,
	[SubjectID] [varchar](10) NULL,
	[Status] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuizHistory]    Script Date: 6/2/2020 3:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuizHistory](
	[ID] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Time] [datetime] NULL,
	[Subject] [varchar](10) NULL,
	[Result] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuizQuestionHistory]    Script Date: 6/2/2020 3:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuizQuestionHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Question] [varchar](200) NULL,
	[Option1] [varchar](200) NULL,
	[Option2] [varchar](200) NULL,
	[Option3] [varchar](200) NULL,
	[Option4] [varchar](200) NULL,
	[CorrectAnswer] [varchar](10) NULL,
	[UserAnswer] [varchar](10) NULL,
	[Result] [bit] NULL,
	[QuizID] [varchar](100) NULL,
 CONSTRAINT [PK__QuizQues__3214EC2797656A5B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 6/2/2020 3:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[ID] [varchar](10) NOT NULL,
	[Name] [varchar](20) NULL,
	[Questions] [int] NULL,
	[Minutes] [int] NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/2/2020 3:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Email] [varchar](100) NOT NULL,
	[Name] [varchar](50) NULL,
	[Password] [varchar](64) NULL,
	[Role] [varchar](20) NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (3, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', 2, CAST(N'2020-05-24 13:36:49.883' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (4, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', 1, CAST(N'2020-05-24 14:02:42.820' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (5, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (6, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (7, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (8, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (9, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (10, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (11, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (12, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'deActive')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (13, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (14, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (15, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (16, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (17, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (18, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (19, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (20, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (21, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (22, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (23, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (24, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (25, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (26, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (27, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', 4, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (28, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (29, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (30, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (31, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (32, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'deActive')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (33, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (34, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, NULL, N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (36, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, CAST(N'2020-05-25 22:30:13.247' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (37, N'10 + 20 = ?', N'10', N'20', N'30', N'40', 2, CAST(N'2020-05-26 12:02:04.947' AS DateTime), N'Math', N'deActive')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (38, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', 2, CAST(N'2020-05-31 14:15:42.003' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (39, N'2 + 5 = ?', N'7', N'8', N'9', N'10', 1, CAST(N'2020-05-31 14:19:20.783' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (40, N'9 + 10 = ?', N'16', N'17', N'18', N'19', 4, CAST(N'2020-05-31 14:19:44.580' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (41, N'6 + 9 = ?', N'13', N'16', N'15', N'17', 3, CAST(N'2020-05-31 14:21:53.093' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (42, N'1 + 2', N'1', N'2', N'3', N'4', 3, CAST(N'2020-05-31 14:22:51.170' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (43, N'10 + 10', N'10', N'20', N'90', N'30', 2, CAST(N'2020-05-31 14:23:21.290' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (44, N'99 + 1', N'99', N'100', N'101', N'102', 2, CAST(N'2020-05-31 14:24:22.830' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (45, N'60 + 30', N'50', N'60', N'70', N'90', 4, CAST(N'2020-05-31 14:24:38.010' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (46, N'5 + 6', N'10', N'11', N'12', N'13', 2, CAST(N'2020-05-31 14:25:44.363' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (47, N'3 + 4', N'3', N'4', N'6', N'7', 4, CAST(N'2020-05-31 14:25:59.113' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (48, N'7 + 20', N'27', N'28', N'29', N'30', 1, CAST(N'2020-05-31 14:26:17.887' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (49, N'3 + 3', N'3', N'4', N'5', N'6', 4, CAST(N'2020-05-31 14:26:32.787' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (50, N'9 + 9 ', N'17', N'18', N'19', N'20', 2, CAST(N'2020-05-31 14:26:51.777' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (51, N'10 * 20', N'100', N'200', N'300', N'400', 2, CAST(N'2020-05-31 14:27:13.323' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (52, N'9 / 3', N'1', N'2', N'3', N'4', 3, CAST(N'2020-05-31 14:27:32.420' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (53, N'15 / 7.5', N'1', N'3', N'4', N'2', 4, CAST(N'2020-05-31 14:27:48.900' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (54, N'9 * 9', N'81', N'82', N'83', N'84', 1, CAST(N'2020-05-31 14:28:06.523' AS DateTime), N'math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (55, N'11 * 10', N'100', N'150', N'120', N'110', 4, CAST(N'2020-05-31 14:28:24.613' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (56, N'12 + 13', N'24', N'26', N'25', N'27', 3, CAST(N'2020-05-31 14:28:41.920' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (57, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', 3, CAST(N'2020-05-31 15:02:28.787' AS DateTime), N'Math', N'Active')
INSERT [dbo].[Questions] ([ID], [Content], [Answer1], [Answer2], [Answer3], [Answer4], [CorrectAnswer], [CreateDate], [SubjectID], [Status]) VALUES (58, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', 3, CAST(N'2020-05-31 15:02:50.407' AS DateTime), N'Math', N'Active')
SET IDENTITY_INSERT [dbo].[Questions] OFF
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:32:28', N'w', CAST(N'2020-05-30 22:32:28.427' AS DateTime), N'Math', 4)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:33:29', N'w', CAST(N'2020-05-30 22:33:29.430' AS DateTime), N'Math', 4)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:35:40', N'w', CAST(N'2020-05-30 22:35:40.083' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:37:53', N'w', CAST(N'2020-05-30 22:37:53.657' AS DateTime), N'Math', 0.64516127109527588)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:37:56', N'w', CAST(N'2020-05-30 22:37:56.013' AS DateTime), N'Math', 0.625)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:38:18', N'w', CAST(N'2020-05-30 22:38:18.217' AS DateTime), N'Math', 0.60606062412261963)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:38:19', N'w', CAST(N'2020-05-30 22:38:19.710' AS DateTime), N'Math', 0.58823531866073608)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:39:06', N'w', CAST(N'2020-05-30 22:39:06.360' AS DateTime), N'Math', 0.57142859697341919)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:47:04', N'w', CAST(N'2020-05-30 22:47:04.560' AS DateTime), N'Math', 0.83333331346511841)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:47:06', N'w', CAST(N'2020-05-30 22:47:06.747' AS DateTime), N'Math', 1.0810810327529907)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:23', N'w', CAST(N'2020-05-30 22:49:23.633' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:24', N'w', CAST(N'2020-05-30 22:49:24.240' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:29', N'w', CAST(N'2020-05-30 22:49:29.730' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:34', N'w', CAST(N'2020-05-30 22:49:34.180' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:38', N'w', CAST(N'2020-05-30 22:49:38.257' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:42', N'w', CAST(N'2020-05-30 22:49:42.190' AS DateTime), N'Math', 0.32258063554763794)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 22:49:48', N'w', CAST(N'2020-05-30 22:49:48.797' AS DateTime), N'Math', 0.64516127109527588)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-30 23:02:35', N'w', CAST(N'2020-05-30 23:02:35.580' AS DateTime), N'Math', 0.64516127109527588)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 12:22:46', N'w', CAST(N'2020-05-31 12:22:46.947' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 12:31:55', N'w', CAST(N'2020-05-31 12:31:55.323' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 12:32:01', N'w', CAST(N'2020-05-31 12:32:01.347' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 12:32:06', N'w', CAST(N'2020-05-31 12:32:06.077' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 12:34:27', N'w', CAST(N'2020-05-31 12:34:27.827' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 14:31:26', N'w', CAST(N'2020-05-31 14:31:26.540' AS DateTime), N'Math', 9.8000001907348633)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 15:03:31', N'w', CAST(N'2020-05-31 15:03:31.507' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 15:10:05', NULL, CAST(N'2020-05-31 15:10:05.103' AS DateTime), N'Math', 10)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 15:13:14', N'w', CAST(N'2020-05-31 15:13:14.173' AS DateTime), N'Math', 1.2000000476837158)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 15:14:03', N'w', CAST(N'2020-05-31 15:14:03.610' AS DateTime), N'Math', 0.20000000298023224)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-05-31 15:14:18', N'w', CAST(N'2020-05-31 15:14:18.467' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-06-02 12:49:05', N'z@zz.zzz', CAST(N'2020-06-02 12:49:05.370' AS DateTime), N'Math', 0.800000011920929)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-06-02 12:52:17', N'z@zz.zzz', CAST(N'2020-06-02 12:52:17.650' AS DateTime), N'Math', 10.600000381469727)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-06-02 12:57:10', N'z@zz.zzz', CAST(N'2020-06-02 12:57:10.553' AS DateTime), N'Math', 10)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-06-02 14:03:29', NULL, CAST(N'2020-06-02 14:03:29.223' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-06-02 14:06:18', NULL, CAST(N'2020-06-02 14:06:18.560' AS DateTime), N'Math', 0)
INSERT [dbo].[QuizHistory] ([ID], [Email], [Time], [Subject], [Result]) VALUES (N'Math2020-06-02 14:55:11', N'z@zz.zzz', CAST(N'2020-06-02 14:55:11.037' AS DateTime), N'Math', 5)
SET IDENTITY_INSERT [dbo].[QuizQuestionHistory] ON 

INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (1, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option4', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (2, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (3, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (4, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (5, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (6, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (7, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (8, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (9, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (10, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option4', 1, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (11, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (12, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (13, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (14, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (15, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (16, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (17, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (18, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (19, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (20, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', N'option1', 1, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (21, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (22, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (23, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (24, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (25, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (26, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (27, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (28, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (29, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (30, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (31, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-30 23:02:35')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (32, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 12:22:46')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (33, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 12:31:55')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (34, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 12:32:01')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (35, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 12:32:06')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (36, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 12:34:27')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (37, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', N'option1', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (38, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (39, N'5 + 6', N'10', N'11', N'12', N'13', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (40, N'9 * 9', N'81', N'82', N'83', N'84', N'option1', N'option1', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (41, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (42, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', N'option4', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (43, N'11 * 10', N'100', N'150', N'120', N'110', N'option4', N'option4', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (44, N'3 + 3', N'3', N'4', N'5', N'6', N'option4', N'option4', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (45, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (46, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (47, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', N'option1', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (48, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (49, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (50, N'9 + 9 ', N'17', N'18', N'19', N'20', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (51, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (52, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (53, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (54, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (55, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (56, N'6 + 9 = ?', N'13', N'16', N'15', N'17', N'option3', N'option3', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (57, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (58, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (59, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (60, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (61, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (62, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (63, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (64, N'2 + 5 = ?', N'7', N'8', N'9', N'10', N'option1', N'option1', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (65, N'1 + 2', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (66, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (67, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (68, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (69, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (70, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option2', 0, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (71, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (72, N'60 + 30', N'50', N'60', N'70', N'90', N'option4', N'option4', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (73, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (74, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (75, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (76, N'15 / 7.5', N'1', N'3', N'4', N'2', N'option4', N'option4', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (77, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (78, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (79, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', N'option3', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (80, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (81, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (82, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (83, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (84, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (85, N'9 + 10 = ?', N'16', N'17', N'18', N'19', N'option4', N'option4', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (86, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 14:31:26')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (87, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (88, N'9 + 9 ', N'17', N'18', N'19', N'20', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (89, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (90, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (91, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (92, N'2 + 5 = ?', N'7', N'8', N'9', N'10', N'option1', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (93, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (94, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (95, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (96, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (97, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (98, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (99, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', NULL, 0, N'Math2020-05-31 15:03:31')
GO
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (100, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (101, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (102, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (103, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (104, N'11 * 10', N'100', N'150', N'120', N'110', N'option4', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (105, N'1 + 2', N'1', N'2', N'3', N'4', N'option3', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (106, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (107, N'9 * 9', N'81', N'82', N'83', N'84', N'option1', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (108, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (109, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (110, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (111, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (112, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (113, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (114, N'5 + 6', N'10', N'11', N'12', N'13', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (115, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (116, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (117, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (118, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (119, N'15 / 7.5', N'1', N'3', N'4', N'2', N'option4', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (120, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (121, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (122, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (123, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (124, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (125, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (126, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (127, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (128, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (129, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (130, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (131, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (132, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (133, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (134, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (135, N'6 + 9 = ?', N'13', N'16', N'15', N'17', N'option3', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (136, N'3 + 3', N'3', N'4', N'5', N'6', N'option4', NULL, 0, N'Math2020-05-31 15:03:31')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (137, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (138, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (139, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (140, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option4', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (141, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (142, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (143, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (144, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', N'option1', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (145, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (146, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (147, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', N'option1', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (148, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (149, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (150, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (151, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (152, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (153, N'2 + 5 = ?', N'7', N'8', N'9', N'10', N'option1', N'option1', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (154, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (155, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (156, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (157, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (158, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (159, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (160, N'60 + 30', N'50', N'60', N'70', N'90', N'option4', N'option4', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (161, N'9 + 9 ', N'17', N'18', N'19', N'20', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (162, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (163, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (164, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (165, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (166, N'9 * 9', N'81', N'82', N'83', N'84', N'option1', N'option1', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (167, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (168, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (169, N'9 + 10 = ?', N'16', N'17', N'18', N'19', N'option4', N'option4', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (170, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (171, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (172, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (173, N'3 + 3', N'3', N'4', N'5', N'6', N'option4', N'option4', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (174, N'5 + 6', N'10', N'11', N'12', N'13', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (175, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', N'option4', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (176, N'1 + 2', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (177, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (178, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (179, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (180, N'11 * 10', N'100', N'150', N'120', N'110', N'option4', N'option4', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (181, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (182, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (183, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', N'option3', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (184, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (185, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (186, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-05-31 15:10:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (187, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (188, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (189, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (190, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (191, N'60 + 30', N'50', N'60', N'70', N'90', N'option4', N'option4', 1, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (192, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (193, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (194, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (195, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (196, N'1 + 2', N'1', N'2', N'3', N'4', N'option3', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (197, N'2 + 5 = ?', N'7', N'8', N'9', N'10', N'option1', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (198, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (199, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
GO
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (200, N'11 * 10', N'100', N'150', N'120', N'110', N'option4', N'option4', 1, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (201, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (202, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (203, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (204, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (205, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (206, N'9 * 9', N'81', N'82', N'83', N'84', N'option1', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (207, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (208, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (209, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (210, N'5 + 6', N'10', N'11', N'12', N'13', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (211, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (212, N'9 + 10 = ?', N'16', N'17', N'18', N'19', N'option4', N'option4', 1, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (213, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (214, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (215, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (216, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (217, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (218, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (219, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', N'option4', 1, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (220, N'15 / 7.5', N'1', N'3', N'4', N'2', N'option4', N'option4', 1, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (221, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (222, N'9 + 9 ', N'17', N'18', N'19', N'20', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (223, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (224, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (225, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (226, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (227, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (228, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (229, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (230, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (231, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (232, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (233, N'6 + 9 = ?', N'13', N'16', N'15', N'17', N'option3', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (234, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (235, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option4', 0, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (236, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option4', 1, N'Math2020-05-31 15:13:14')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (237, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option4', 1, N'Math2020-05-31 15:14:03')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (238, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-05-31 15:14:18')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (239, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:49:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (240, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:49:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (241, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:49:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (242, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:49:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (243, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-06-02 12:49:05')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (244, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (245, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (246, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (247, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (248, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (249, N'9 + 10 = ?', N'16', N'17', N'18', N'19', N'option4', N'option4', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (250, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (251, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (252, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (253, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (254, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (255, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (256, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (257, N'60 + 30', N'50', N'60', N'70', N'90', N'option4', N'option4', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (258, N'2 + 5 = ?', N'7', N'8', N'9', N'10', N'option1', N'option1', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (259, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (260, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (261, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (262, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (263, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (264, N'1 + 2', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (265, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (266, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', N'option3', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (267, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (268, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (269, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (270, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (271, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (272, N'3 + 3', N'3', N'4', N'5', N'6', N'option4', N'option4', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (273, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (274, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (275, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (276, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (277, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (278, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (279, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (280, N'6 + 9 = ?', N'13', N'16', N'15', N'17', N'option3', N'option3', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (281, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (282, N'9 * 9', N'81', N'82', N'83', N'84', N'option1', N'option1', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (283, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (284, N'9 + 9 ', N'17', N'18', N'19', N'20', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (285, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', N'option1', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (286, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (287, N'5 + 6', N'10', N'11', N'12', N'13', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (288, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (289, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (290, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', N'option4', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (291, N'11 * 10', N'100', N'150', N'120', N'110', N'option4', N'option4', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (292, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option2', 0, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (293, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (294, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (295, N'15 / 7.5', N'1', N'3', N'4', N'2', N'option4', N'option4', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (296, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (297, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', N'option1', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (298, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:52:17')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (299, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
GO
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (300, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (301, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', N'option3', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (302, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (303, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (304, N' 1 + 100 = ?', N'10', N'101', N'200', N'500', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (305, N'1 + 2', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (306, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (307, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (308, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (309, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (310, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (311, N'9 + 9 ', N'17', N'18', N'19', N'20', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (312, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (313, N'15 / 7.5', N'1', N'3', N'4', N'2', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (314, N'60 + 30', N'50', N'60', N'70', N'90', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (315, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (316, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (317, N'6 + 9 = ?', N'13', N'16', N'15', N'17', N'option3', N'option3', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (318, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (319, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', N'option1', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (320, N'9 + 10 = ?', N'16', N'17', N'18', N'19', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (321, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', N'option1', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (322, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (323, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (324, N'11 * 10', N'100', N'150', N'120', N'110', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (325, N'3 + 3', N'3', N'4', N'5', N'6', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (326, N'5 + 6', N'10', N'11', N'12', N'13', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (327, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (328, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (329, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (330, N'2 + 5 = ?', N'7', N'8', N'9', N'10', N'option1', N'option1', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (331, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (332, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (333, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (334, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (335, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (336, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (337, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (338, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (339, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (340, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (341, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (342, N'10 + 20 = ?', N'10', N'20', N'30', N'Hello World', N'option4', N'option4', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (343, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (344, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (345, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (346, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (347, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (348, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 12:57:10')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (349, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', NULL, 0, N'Math2020-06-02 14:03:29')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (350, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', NULL, 0, N'Math2020-06-02 14:06:18')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (351, N'1000 * 1000 = ?', N'1 trieu', N'1 ty', N'1000', N'100000', N'option1', N'option1', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (352, N'3 + 4', N'3', N'4', N'6', N'7', N'option4', N'option4', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (353, N'99 + 1 = ?', N'10', N'100', N'1000', N'10000', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (354, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (355, N'7 + 20', N'27', N'28', N'29', N'30', N'option1', N'option1', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (356, N'10 * 20', N'100', N'200', N'300', N'400', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (357, N'10 + 10', N'10', N'20', N'90', N'30', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (358, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (359, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (360, N'15 / 7.5', N'1', N'3', N'4', N'2', N'option4', N'option4', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (361, N'99 + 1', N'99', N'100', N'101', N'102', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (362, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (363, N'60 + 30', N'50', N'60', N'70', N'90', N'option4', N'option4', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (364, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (365, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (366, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (367, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (368, N'1 trieu gom may chu so', N'11', N'9', N'10', N'8', N'option3', N'option3', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (369, N'9 / 3', N'1', N'2', N'3', N'4', N'option3', N'option3', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (370, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (371, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (372, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (373, N'9 + 10 = ?', N'16', N'17', N'18', N'19', N'option4', N'option4', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (374, N'12 + 13', N'24', N'26', N'25', N'27', N'option3', N'option3', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (375, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', N'option2', 1, N'Math2020-06-02 14:55:11')
INSERT [dbo].[QuizQuestionHistory] ([ID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer], [UserAnswer], [Result], [QuizID]) VALUES (376, N'10 + 20 = ?', N'10', N'20', N'30', N'40', N'option2', NULL, 0, N'Math2020-06-02 14:55:11')
SET IDENTITY_INSERT [dbo].[QuizQuestionHistory] OFF
INSERT [dbo].[Subject] ([ID], [Name], [Questions], [Minutes]) VALUES (N'Math', N'Math', 50, 50)
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'a@a.a', N'Hieu', N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb', N'Student', N'New')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'e@e.e', N'e', N'e', N'admin', N'Active')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'hieuptse130099@gmail.com', N'Pham Trung Hieu', N'2267024bb107b0a9d3327a92c4066243fc6d28aadb19ef0a0fc561f36ee6641f', N'Student', N'Active')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'qq@qq.qqq', N'q', N'8e35c2cd3bf6641bdb0e2050b76932cbb2e6034a0ddacc1d9bea82a6ba57f7cf', N'Admin', N'New')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'w', N'w', N'50e721e49c013f00c62cf59f2163542a9d8df02464efeb615d31051b0fddc326', N'Student', N'Active')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'z', N'z', N'594e519ae499312b29433b7dd8a97ff068defcba9755b6d5d00e84c524d67b06', N'Student', N'Active')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Status]) VALUES (N'z@zz.zzz', N'Hieu', N'594e519ae499312b29433b7dd8a97ff068defcba9755b6d5d00e84c524d67b06', N'Student', N'Active')
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([ID])
GO
ALTER TABLE [dbo].[QuizHistory]  WITH CHECK ADD FOREIGN KEY([Email])
REFERENCES [dbo].[User] ([Email])
GO
ALTER TABLE [dbo].[QuizHistory]  WITH CHECK ADD FOREIGN KEY([Subject])
REFERENCES [dbo].[Subject] ([ID])
GO
ALTER TABLE [dbo].[QuizQuestionHistory]  WITH CHECK ADD  CONSTRAINT [FK_QuizQuestionHistory_QuizHistory] FOREIGN KEY([QuizID])
REFERENCES [dbo].[QuizHistory] ([ID])
GO
ALTER TABLE [dbo].[QuizQuestionHistory] CHECK CONSTRAINT [FK_QuizQuestionHistory_QuizHistory]
GO
USE [master]
GO
ALTER DATABASE [QuizDB] SET  READ_WRITE 
GO
