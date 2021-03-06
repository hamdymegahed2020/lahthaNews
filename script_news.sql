USE [DB_9E3E00_news89aa]
GO
/****** Object:  UserDefinedFunction [dbo].[NumberOfFollowers]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create FUNCTION  [dbo].[NumberOfFollowers]
(
@SubNesourceID int
)
RETURNS int
AS
BEGIN
-- Declare the return variable here
	DECLARE @n int

 
set @n=(SELECT  count(*)
  FROM  [UserFollowing] where SubNesourceID=@SubNesourceID )
 
 
	RETURN @n

END



GO
/****** Object:  UserDefinedFunction [dbo].[PostTimeLeft]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE FUNCTION [dbo].[PostTimeLeft]
(
@datePost datetime
)
RETURNS nvarchar(50)
AS
BEGIN
-- Declare the return variable here
	DECLARE @DateMessage nvarchar(50)

declare @day int 
declare @hour int
set @day=(SELECT DATEDIFF(day, @datePost,getdate())) 
if(@day>1)
begin
set @DateMessage=(SELECT CONVERT(varchar, @datePost, 101) )
end
else --if lease than on day send message with hours =========
begin
set @hour =(SELECT DATEDIFF(hour, @datePost,getdate())) -- get hours
if(@hour>1) 
begin
if(@hour>23)
set @DateMessage=N'  منذ  '  + '1'  +  N' يوم ';
else
set @DateMessage=N'  منذ  '  +  convert(varchar,@hour)  +  N' ساعة ';
end
else
begin --if lease than on hour send message with minute =========
declare @minute int
 set  @minute=(SELECT DATEDIFF(minute, @datePost,getdate())) -- get minute
if(@minute>0)
begin
if(@minute>59)
set @DateMessage=N'  منذ  '  + '1'  +  N' ساعة ';
else
set @DateMessage=N' منذ  '  +  convert(varchar,@minute)  +  N'   دقيقة ';

end
else
begin
declare @second int 
set @second =(SELECT DATEDIFF(second, @datePost,getdate())) -- get second
if(@second>0)
set @DateMessage=N' منذ  '  +  convert(varchar,@second)  +  N'   ثانية ';
else
set @DateMessage=N'الأن' 

end

end

end--===========================================
	RETURN @DateMessage

END


GO
/****** Object:  UserDefinedFunction [dbo].[PsotTime]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE FUNCTION [dbo].[PsotTime]
(
@datePost datetime
)
RETURNS nvarchar(50)
AS
BEGIN
-- Declare the return variable here
	DECLARE @DateMessage nvarchar(50)

declare @day int 
set @day=(SELECT DATEDIFF(day, @datePost,getdate())) 
if(@day>0)
set @DateMessage=(SELECT CONVERT(varchar, @datePost, 101) )
else --if lease than on day send message with hours =========
begin
declare @hour int
set @hour =(SELECT DATEDIFF(hour, @datePost,getdate())) -- get hours
if(@hour>0)
set @DateMessage=N'  منذ  '  +  convert(varchar,@hour)  +  N' ساعة ';
else
begin --if lease than on hour send message with minute =========
declare @minute int
 set  @minute=(SELECT DATEDIFF(minute, @datePost,getdate())) -- get minute
if(@minute>0)
set @DateMessage=N' منذ  '  +  convert(varchar,@minute)  +  N'   دقيقة ';
else
begin
declare @second int 
set @second =(SELECT DATEDIFF(second, @datePost,getdate())) -- get second
if(@second>0)
set @DateMessage=N' منذ  '  +  convert(varchar,@second)  +  N'   ثانية ';
else
set @DateMessage=N'الأن' 

end

end

end--===========================================
	RETURN @DateMessage

END


GO
/****** Object:  Table [dbo].[AgrementType]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgrementType](
	[AgrementTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AgrementTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_AgrementType] PRIMARY KEY CLUSTERED 
(
	[AgrementTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CheckService]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckService](
	[CheckID] [int] NULL,
	[CheckDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CommentAgrement]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentAgrement](
	[AgrementLikeDislike] [bit] NULL,
	[CommentID] [bigint] NULL,
	[DateAgrement] [datetime] NULL,
	[NumberClaims] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[UserID] [int] NULL,
	[NewsID] [bigint] NULL,
	[CommentDetials] [nchar](10) NULL,
	[CommentDate] [datetime] NULL,
	[CommentID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountriesID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CountriesName] [nvarchar](70) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountriesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvestmentCountries]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvestmentCountries](
	[CountriesID] [int] NULL,
	[InvestmentID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Investments]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Investments](
	[InvestmentID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[InvestmentTitle] [nvarchar](350) NULL,
	[InvestmentImage] [nvarchar](250) NULL,
	[InvestmentLink] [nvarchar](250) NULL,
	[InvestmentDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[InverstmentPostion] [int] NULL,
 CONSTRAINT [PK_Investments] PRIMARY KEY CLUSTERED 
(
	[InvestmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[News]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [bigint] IDENTITY(1,1) NOT NULL,
	[SubNesourceID] [int] NULL,
	[NewsTitle] [nvarchar](450) NULL,
	[NewsDetails] [nvarchar](max) NULL,
	[NewsDate] [datetime] NULL,
	[ReadFromWebsiteLink] [nvarchar](450) NULL,
	[DateIN] [datetime] NULL,
 CONSTRAINT [PK_NewsV] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NewsAgrements]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsAgrements](
	[AgrementLikeDislike] [bit] NULL,
	[NewsID] [bigint] NULL,
	[DateAgrement] [datetime] NULL,
	[NumberClaims] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NewsImages]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsImages](
	[NewsID] [bigint] NULL,
	[NewsLink] [nvarchar](450) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Readers]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Readers](
	[NewsID] [bigint] NULL,
	[UserID] [int] NULL,
	[DateRead] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Resources]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resources](
	[NesourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ResourcesName] [nvarchar](70) NULL,
	[NesourceDateAdd] [datetime] NULL,
	[ImageLink] [nvarchar](150) NULL,
 CONSTRAINT [PK_Resources] PRIMARY KEY CLUSTERED 
(
	[NesourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubNesources]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubNesources](
	[SubNesourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SubNesourceName] [nvarchar](70) NULL,
	[NesourceID] [int] NULL,
	[DateRegister] [datetime] NULL,
	[SubNesourceLink] [varchar](250) NULL,
	[ChannelImage] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[SubResourcesTypeID] [int] NULL,
	[ResourcesNewType] [bit] NULL,
	[BacugroundPicture] [nvarchar](250) NULL,
	[DetailsConatinTag] [nvarchar](150) NULL,
	[ImageTag] [varchar](50) NULL,
 CONSTRAINT [PK_SubNesources] PRIMARY KEY CLUSTERED 
(
	[SubNesourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubResourcesType]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubResourcesType](
	[SubResourcesTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SubResourcesTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_SubResourcesType] PRIMARY KEY CLUSTERED 
(
	[SubResourcesTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserFollowing]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFollowing](
	[UserID] [int] NULL,
	[SubNesourceID] [int] NULL,
	[DateRegister] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[UserEmail] [nvarchar](150) NULL,
	[UserPassword] [nvarchar](50) NULL,
	[UserTypeID] [int] NULL,
	[PhoneMac] [varchar](250) NULL,
	[DateRegister] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserType](
	[UserTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserTypeName] [nvarchar](70) NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[NewsView]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NewsView]
AS
SELECT      dbo.SubNesources.NesourceID, dbo.News.NewsTitle, dbo.News.NewsDetails, dbo.News.NewsDate, dbo.News.ReadFromWebsiteLink,
                             (SELECT        MIN(NewsLink) AS Expr1
                                FROM            dbo.NewsImages
                                WHERE        (NewsID = dbo.News.NewsID)) AS PicturLink, dbo.News.NewsID, dbo.SubNesources.SubNesourceName, dbo.SubNesources.ChannelImage, dbo.SubNesources.SubNesourceID, 
                         dbo.News.DateIN 
					 
FROM            dbo.SubNesources

 INNER JOIN

                         dbo.News ON dbo.SubNesources.SubNesourceID = dbo.News.SubNesourceID
						
						 
			 




GO
/****** Object:  View [dbo].[NewsViewNoDetails]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NewsViewNoDetails]
AS
SELECT        dbo.SubNesources.NesourceID, dbo.News.NewsTitle, dbo.News.NewsDate, dbo.News.ReadFromWebsiteLink,
                             (SELECT        MIN(NewsLink) AS Expr1
                               FROM            dbo.NewsImages
                               WHERE        (NewsID = dbo.News.NewsID)) AS PicturLink, dbo.News.NewsID, dbo.SubNesources.SubNesourceName, dbo.SubNesources.ChannelImage, dbo.SubNesources.SubNesourceID, 
                         dbo.News.DateIN
FROM            dbo.SubNesources INNER JOIN
                         dbo.News ON dbo.SubNesources.SubNesourceID = dbo.News.SubNesourceID

GO
/****** Object:  View [dbo].[ResourcesForUser]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ResourcesForUser]
AS
SELECT DISTINCT dbo.Resources.NesourceID, dbo.Resources.NesourceDateAdd, dbo.Resources.ResourcesName, dbo.Resources.ImageLink, dbo.UserFollowing.UserID, dbo.SubNesources.IsActive
FROM            dbo.Resources INNER JOIN
                         dbo.SubNesources ON dbo.Resources.NesourceID = dbo.SubNesources.NesourceID INNER JOIN
                         dbo.UserFollowing ON dbo.SubNesources.SubNesourceID = dbo.UserFollowing.SubNesourceID AND dbo.SubNesources.IsActive = 1

GO
/****** Object:  View [dbo].[SubResourcesLastNews]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SubResourcesLastNews]
AS
SELECT        dbo.SubNesources.SubNesourceLink, ISNULL(MAX(dbo.News.NewsDate), '1990-01-01') AS NewsDate, dbo.SubNesources.SubNesourceID, dbo.SubNesources.SubResourcesTypeID, 
                         dbo.SubNesources.DetailsConatinTag, dbo.SubNesources.ImageTag
FROM            dbo.SubNesources LEFT OUTER JOIN
                         dbo.News ON dbo.SubNesources.SubNesourceID = dbo.News.SubNesourceID
WHERE        (dbo.SubNesources.IsActive = 1)
GROUP BY dbo.SubNesources.SubNesourceLink, dbo.SubNesources.SubNesourceID, dbo.SubNesources.SubResourcesTypeID, dbo.SubNesources.DetailsConatinTag, dbo.SubNesources.ImageTag



GO
/****** Object:  View [dbo].[UserChannelFollow]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
CREATE VIEW [dbo].[UserChannelFollow] -- this view display the channle that fallowed by userd
AS
SELECT      
                       dbo.SubNesources.SubNesourceName, dbo.SubNesources.ChannelImage , 
                         dbo.SubNesources.SubNesourceID,
						 UserFollowing.UserID 
FROM            dbo.SubNesources  
						 inner join UserFollowing
 on dbo.SubNesources.SubNesourceID=UserFollowing.SubNesourceID 
    






GO
ALTER TABLE [dbo].[CommentAgrement] ADD  CONSTRAINT [DF_CommentAgrement_AgrementLikeDislike]  DEFAULT ((1)) FOR [AgrementLikeDislike]
GO
ALTER TABLE [dbo].[CommentAgrement] ADD  CONSTRAINT [DF_CommentAgrement_NumberClams]  DEFAULT ((0)) FOR [NumberClaims]
GO
ALTER TABLE [dbo].[Investments] ADD  CONSTRAINT [DF_Investments_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Investments] ADD  CONSTRAINT [DF_Investments_InverstmentPostion]  DEFAULT ((0)) FOR [InverstmentPostion]
GO
ALTER TABLE [dbo].[NewsAgrements] ADD  CONSTRAINT [DF_NewsAgrements_AgrementLikeDislike]  DEFAULT ((1)) FOR [AgrementLikeDislike]
GO
ALTER TABLE [dbo].[NewsAgrements] ADD  CONSTRAINT [DF_NewsAgrements_NumberClaims]  DEFAULT ((0)) FOR [NumberClaims]
GO
ALTER TABLE [dbo].[SubNesources] ADD  CONSTRAINT [DF_SubNesources_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SubNesources] ADD  CONSTRAINT [DF_SubNesources_ResourcesNewType]  DEFAULT ((0)) FOR [ResourcesNewType]
GO
ALTER TABLE [dbo].[CommentAgrement]  WITH CHECK ADD  CONSTRAINT [FK_CommentAgrement_Comments] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comments] ([CommentID])
GO
ALTER TABLE [dbo].[CommentAgrement] CHECK CONSTRAINT [FK_CommentAgrement_Comments]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_News] FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_News]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[InvestmentCountries]  WITH CHECK ADD  CONSTRAINT [FK_InvestmentCountries_Countries] FOREIGN KEY([CountriesID])
REFERENCES [dbo].[Countries] ([CountriesID])
GO
ALTER TABLE [dbo].[InvestmentCountries] CHECK CONSTRAINT [FK_InvestmentCountries_Countries]
GO
ALTER TABLE [dbo].[InvestmentCountries]  WITH CHECK ADD  CONSTRAINT [FK_InvestmentCountries_Investments] FOREIGN KEY([InvestmentID])
REFERENCES [dbo].[Investments] ([InvestmentID])
GO
ALTER TABLE [dbo].[InvestmentCountries] CHECK CONSTRAINT [FK_InvestmentCountries_Investments]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_SubNesources1] FOREIGN KEY([SubNesourceID])
REFERENCES [dbo].[SubNesources] ([SubNesourceID])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_SubNesources1]
GO
ALTER TABLE [dbo].[NewsAgrements]  WITH CHECK ADD  CONSTRAINT [FK_NewsAgrements_News] FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[NewsAgrements] CHECK CONSTRAINT [FK_NewsAgrements_News]
GO
ALTER TABLE [dbo].[NewsImages]  WITH CHECK ADD  CONSTRAINT [FK_NewsImages_News] FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NewsImages] CHECK CONSTRAINT [FK_NewsImages_News]
GO
ALTER TABLE [dbo].[Readers]  WITH CHECK ADD  CONSTRAINT [FK_Readers_News] FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Readers] CHECK CONSTRAINT [FK_Readers_News]
GO
ALTER TABLE [dbo].[Readers]  WITH CHECK ADD  CONSTRAINT [FK_Readers_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Readers] CHECK CONSTRAINT [FK_Readers_Users]
GO
ALTER TABLE [dbo].[SubNesources]  WITH CHECK ADD  CONSTRAINT [FK_SubNesources_Resources] FOREIGN KEY([NesourceID])
REFERENCES [dbo].[Resources] ([NesourceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubNesources] CHECK CONSTRAINT [FK_SubNesources_Resources]
GO
ALTER TABLE [dbo].[UserFollowing]  WITH CHECK ADD  CONSTRAINT [FK_UserFollowing_SubNesources] FOREIGN KEY([SubNesourceID])
REFERENCES [dbo].[SubNesources] ([SubNesourceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserFollowing] CHECK CONSTRAINT [FK_UserFollowing_SubNesources]
GO
ALTER TABLE [dbo].[UserFollowing]  WITH CHECK ADD  CONSTRAINT [FK_UserFollowing_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserFollowing] CHECK CONSTRAINT [FK_UserFollowing_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[UserType] ([UserTypeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserType]
GO
/****** Object:  StoredProcedure [dbo].[AddDefultChannels]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE procedure  [dbo].[AddDefultChannels](@UserID int)with execute as owner
as

begin
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,5,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,18,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,20,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,22,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,24,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,25,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,30,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,31,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,35,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,36,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,44,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,54,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,66,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,68,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,71,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,78,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,85,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,87,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,100,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,102,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,117,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,126,getdate())
insert into UserFollowing (UserID,SubNesourceID,DateRegister)values(@UserID,131,getdate())

END
 


GO
/****** Object:  StoredProcedure [dbo].[GetMySubNesources]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE procedure   [dbo].[GetMySubNesources](@UserID int ,@NesourceID int)
as
begin
SELECT        dbo.SubNesources.SubNesourceID, dbo.SubNesources.SubNesourceName, dbo.SubNesources.ChannelImage,
1 as IsFollow  
 ,dbo.NumberOfFollowers(dbo.SubNesources.SubNesourceID) as NumberOfFollowers
FROM     SubNesources
 
   
						 where   IsActive=1 and
						 SubNesourceID in(
select  SubNesourceID from  UserFollowing where UserID=@UserID) and SubNesources.NesourceID=@NesourceID
						 end


GO
/****** Object:  StoredProcedure [dbo].[GetNews]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 --select count(*) from news
 
 
 --GetNews 1,2010,10,0,0,'%',0
CREATE procedure  [dbo].[GetNews]( @UserID int,  @StratFrom int, @EndTo int,@SubNesourceID int=0,@NewsID int =0,@q nvarchar(15)='%',@Type int=0)
as
begin
-- get the one who have id more thand the current on
declare @NewsDate datetime
 declare @NewsMax bigint
 set @NewsDate=(select DateIN from News where NewsID=@NewsID)
 set @StratFrom=@StratFrom-1

IF(@Type=0) -- in cuase we get allnews
begin
 if(@SubNesourceID=0) --incuase get all news
 begin
 IF (@q='%') -- if he search only on his resourcess *************************************
 begin
 select * from
( -- select all from class
 --select ((ROW_NUMBER() OVER(ORDER BY  NewsID DESC))+ @StratFrom) AS [Row],* from
 --(
SELECT      
ROW_NUMBER() OVER(ORDER BY  DateIN DESC)  AS [Row],
  NewsTitle, --new title
  SubNesourceID  -- channel id
,  (SELECT  MIN(NewsLink) AS Expr1
 FROM            dbo.NewsImages
  WHERE        (NewsID =  NewsViewNoDetails.NewsID)) AS PicturLink  --link of new picture
 ,null  as InvestmentLink  -- inverstment link
,  [dbo].PostTimeLeft( DateIN) as NewsDateN,  -- new date
 NewsID, --new id
  SubNesourceName, -- channl name
   ChannelImage -- channel image
 ,(SELECT count(NewsID) FROM [Readers] where NewsID= NewsViewNoDetails.NewsID) as readers -- number of reader
  FROM NewsViewNoDetails
   -- bring all news  with search query with limit number of records
 -- get listof channel that user follow
   where
     SubNesourceID in(select SubNesourceID from UserFollowing where UserFollowing.UserID=@UserID)
  -- in cuase get new of one channel
and (@NewsID=0 or ((DateIN<=@NewsDate) and(@NewsID<>0))) -- get only the previous news incuase we load more
   ORDER BY DateIN DESC OFFSET @StratFrom ROWS FETCH NEXT 20 ROWS ONLY
 -- ) as newnews
 -- where ( newnews.Row between   @StratFrom and  @EndTo )
 
  ---  add advenstments
 union all
  SELECT  InverstmentPostion  AS Row, [InvestmentTitle] as NewsTitle , 
 null as SubNesourceID
      
      ,[InvestmentImage] as PicturLink
      ,[InvestmentLink]
      ,N'اعلان مدفوع' as  NewsDateN
	 , [InvestmentID] as NewsID, 
	null  as SubNesourceName,
	null as   ChannelImage
	,null  as readers
  FROM [Investments]
  where IsActive=1 and InverstmentPostion between @StratFrom and  @EndTo 
    ) as alltables
 order by  [Row]
 end
 --*********************************************************************8
 else -- if he dsearch on all resourcess in the system***************************
 begin
 select * from
( -- select all from class
--select * from
--(
SELECT     NewsTitle, --new title
ROW_NUMBER() OVER(ORDER BY  DateIN DESC) AS Row, --row number
  SubNesourceID  -- channel id
,  (SELECT  MIN(NewsLink) AS Expr1
 FROM            dbo.NewsImages
  WHERE        (NewsID =  NewsViewNoDetails.NewsID)) AS PicturLink  --link of new picture
 ,null  as InvestmentLink  -- inverstment link
,  [dbo].PostTimeLeft( DateIN) as NewsDateN,  -- new date
    

 NewsID, --new id
  SubNesourceName, -- channl name
   ChannelImage -- channel image
 ,(SELECT count(NewsID) FROM [Readers] where NewsID= NewsViewNoDetails.NewsID) as readers -- number of reader
  FROM NewsViewNoDetails
   -- bring all news  with search query with limit number of records
 -- get listof channel that user follow
   where  -- in cuase get new of one channel
   (@NewsID=0 or ((NewsID<=@NewsID) and(@NewsID<>0))) -- get only the previous news incuase we load more
   
  and (    NewsViewNoDetails.NewsTitle like   @q  )   -- query for search
     ORDER BY DateIN DESC OFFSET @StratFrom ROWS FETCH NEXT 20 ROWS ONLY
 
 --) as newnews
 -- where ( newnews.Row between   @StratFrom and  @EndTo )
 
  ---  add advenstments
 union all
  SELECT   [InvestmentTitle] as NewsTitle , InverstmentPostion  AS Row,
 null as SubNesourceID
      
      ,[InvestmentImage] as PicturLink
      ,[InvestmentLink]
      ,N'اعلان مدفوع' as  NewsDateN
	 , [InvestmentID] as NewsID, 
	null  as SubNesourceName,
	null as   ChannelImage
	,null  as readers
  FROM [Investments]
  where IsActive=1 and InverstmentPostion between @StratFrom and  @EndTo   ) as alltables
 order by  [Row]
 end
 --**************************************************************
 end
else --incuase get news for one channel
 begin
 select * from
( -- select all from class
--select * from
--(
SELECT    NewsTitle, --new title
ROW_NUMBER() OVER(ORDER BY  DateIN DESC) AS Row, --row number
  SubNesourceID  -- channel id
,  (SELECT  MIN(NewsLink) AS Expr1
 FROM            dbo.NewsImages
  WHERE        (NewsID =  NewsViewNoDetails.NewsID)) AS PicturLink  --link of new picture
 ,null  as InvestmentLink  -- inverstment link
,  [dbo].PostTimeLeft( DateIN) as NewsDateN,  -- new date
    

 NewsID, --new id
  SubNesourceName, -- channl name
   ChannelImage -- channel image
 ,(SELECT count(NewsID) FROM [Readers] where NewsID= NewsViewNoDetails.NewsID) as readers -- number of reader
  FROM NewsViewNoDetails
   -- bring all news  with search query with limit number of records
 -- get listof channel that user follow
   where    -- in cuase get new of one channel
  (@NewsID=0 or ((NewsID<=@NewsID) and(@NewsID<>0))) -- get only the previous news incuase we load more
  and   ( SubNesourceID=@SubNesourceID  ) 
  and (    NewsViewNoDetails.NewsTitle like   @q  )   -- query for search
   ORDER BY DateIN DESC OFFSET @StratFrom ROWS FETCH NEXT 20 ROWS ONLY
 
 --) as newnews
--  where ( newnews.Row between   @StratFrom and  @EndTo )
 
  ---  add advenstments
 union all
  SELECT   [InvestmentTitle] as NewsTitle , InverstmentPostion  AS Row,
 null as SubNesourceID
      
      ,[InvestmentImage] as PicturLink
      ,[InvestmentLink]
      ,N'اعلان مدفوع' as  NewsDateN
	 , [InvestmentID] as NewsID, 
	null  as SubNesourceName,
	null as   ChannelImage
	,null  as readers
  FROM [Investments]
  where IsActive=1 and InverstmentPostion between @StratFrom and  @EndTo   ) as alltables
 order by  [Row]
 end

 end

 else IF(@Type=1) -- in cause we get history brouse news
 begin

--select * from
--(


SELECT     
ROW_NUMBER() OVER(ORDER BY DateIN DESC) AS Row,
 NewsViewNoDetails.SubNesourceID
,   NewsTitle
,(SELECT  MIN(NewsLink) AS Expr1
 FROM            dbo.NewsImages
  WHERE        (NewsID =  NewsViewNoDetails.NewsID)) AS PicturLink  
 ,null  as InvestmentLink
,  [dbo].PostTimeLeft(DateIN) as NewsDateN, 
    
	
 NewsID, SubNesourceName, ChannelImage
 ,(SELECT count(NewsID) FROM [Readers] where NewsID=NewsViewNoDetails.NewsID) as readers
  FROM NewsViewNoDetails  
 
 where   (NewsViewNoDetails.NewsID
 in(

 SELECT  [NewsID]
 
  FROM  [Readers]
where   UserID =@UserID 
 )
 )   
 and NewsTitle like  @q -- for search
   ORDER BY DateIN DESC OFFSET @StratFrom ROWS FETCH NEXT 20 ROWS ONLY
-- ) as newnews
 --where ( newnews.Row between   @StratFrom and  @EndTo )
 --order by  [Row]   

 end
  else IF(@Type=2) -- in cause we get most visit
 begin
 select * from
(


SELECT  
ROW_NUMBER() OVER(ORDER BY (SELECT count(NewsID) FROM [Readers] where NewsID=NewsViewNoDetails.NewsID) DESC) AS Row,
 NewsViewNoDetails.SubNesourceID
, NewsTitle
, (SELECT  MIN(NewsLink) AS Expr1
 FROM            dbo.NewsImages
  WHERE        (NewsID =  NewsViewNoDetails.NewsID)) AS PicturLink 
 ,null  as InvestmentLink
,  [dbo].PostTimeLeft(DateIN) as NewsDateN, 
    

 NewsID, SubNesourceName, ChannelImage
 ,(SELECT count(NewsID) FROM [Readers] where NewsID=NewsViewNoDetails.NewsID) as readers
  FROM NewsViewNoDetails 
 
 where   (@NewsID=0 or ((NewsID<=@NewsID) and(@NewsID<>0)))
 and NewsTitle like  @q -- for search

 ) as newnews
  where ( newnews.Row between   @StratFrom and  @EndTo )
 
  end
 end
















GO
/****** Object:  StoredProcedure [dbo].[GetNewsDetials]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--   select  dbo.PostTimeLeft('2015-08-28 13:19:09.000') 
--exec GetNews 1,1,100 
CREATE procedure  [dbo].[GetNewsDetials]( @NewsID int )
as
begin
 

SELECT  
ROW_NUMBER() OVER(ORDER BY DateIN DESC) AS Row,
 NesourceID,PicturLink, NewsTitle,
  NewsDetails, 
  [dbo].PostTimeLeft(DateIN) as NewsDateN, 
   ReadFromWebsiteLink, NewsView.SubNesourceID,

 NewsID, SubNesourceName, ChannelImage FROM NewsView
 
  
  where  
  NewsID=@NewsID 
 end


GO
/****** Object:  StoredProcedure [dbo].[GetOneSubNesources]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
--exec GetOneSubNesources 1,68
create procedure   [dbo].[GetOneSubNesources](@UserID int ,@SubNesourceID int)
as
begin
SELECT        dbo.SubNesources.SubNesourceID, dbo.SubNesources.SubNesourceName, dbo.SubNesources.ChannelImage,
(SELECT CASE WHEN dbo.UserFollowing.UserID IS NULL THEN 0 ELSE 1  END )as IsFollow  
 ,dbo.NumberOfFollowers(dbo.SubNesources.SubNesourceID) as NumberOfFollowers
FROM            dbo.SubNesources LEFT OUTER JOIN
                         dbo.UserFollowing
						  ON dbo.SubNesources.SubNesourceID = dbo.UserFollowing.SubNesourceID
						 and dbo.UserFollowing.UserID=@UserID
						 where  (dbo.SubNesources.SubNesourceID=@SubNesourceID)
						 order by dbo.SubNesources.SubNesourceName
						 end


GO
/****** Object:  StoredProcedure [dbo].[GetSubNesources]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE procedure   [dbo].[GetSubNesources](@UserID int ,@NesourceID int)
as
begin
SELECT        dbo.SubNesources.SubNesourceID, dbo.SubNesources.SubNesourceName, dbo.SubNesources.ChannelImage,
(SELECT CASE WHEN dbo.UserFollowing.UserID IS NULL THEN 0 ELSE 1  END )as IsFollow  
 ,dbo.NumberOfFollowers(dbo.SubNesources.SubNesourceID) as NumberOfFollowers
FROM            dbo.SubNesources LEFT OUTER JOIN
                         dbo.UserFollowing
						  ON dbo.SubNesources.SubNesourceID = dbo.UserFollowing.SubNesourceID
						 and dbo.UserFollowing.UserID=@UserID
						 where NesourceID =@NesourceID and IsActive=1
						 order by dbo.SubNesources.SubNesourceName
						 end


GO
/****** Object:  StoredProcedure [dbo].[IsGetNews]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--   select  dbo.PostTimeLeft('2015-08-28 13:19:09.000') 
--select count(exec  IsGetNews 1,0,6590) 
CREATE procedure  [dbo].[IsGetNews]( @UserID int,@SubNesourceID int=0,@NewsID int =0 ,@q nvarchar(15)='%')
as

begin
 -- get the one who have id more thand the current on
declare @NewsDate datetime
--declare @NewsMax bigint
 set @NewsDate=(select DateIN from News where NewsID=@NewsID)
--set  @NewsMax= (
--select max( NewsID) from   News where NewsID>@NewsID and  NewsDate <@NewsDate 

--)  --deprectaed
--if(@NewsMax>0)
--set @NewsID=@NewsMax
 


SELECT count(*) as
CountItem FROM NewsView
 inner join UserFollowing
 on UserFollowing.SubNesourceID=NewsView.SubNesourceID and  (UserFollowing.UserID=@UserID  )
 

 
  where  (NewsView.NesourceID=@SubNesourceID or @SubNesourceID=0)  and ((NewsID> @NewsID) and(DateIN>@NewsDate))
   and NewsTitle like  @q -- for search
 
 end


GO
/****** Object:  StoredProcedure [dbo].[IsGetNewsWithHeader]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--   select  dbo.PostTimeLeft('2015-08-28 13:19:09.000') 
--select count(exec  IsGetNewsWithHeader 1,0,6590) 
CREATE procedure  [dbo].[IsGetNewsWithHeader]( @UserID int,@SubNesourceID int=0,@NewsID int =0 ,@q nvarchar(15)='%')
as

begin
 -- get the one who have id more thand the current on
declare @NewsDate datetime
declare @NewsMax bigint
 set @NewsDate=(select DateIN from News where NewsID=@NewsID)
set  @NewsMax= (
select max( NewsID) from   News where NewsID>@NewsID and  DateIN <@NewsDate 

)  --deprectaed
if(@NewsMax>0)
set @NewsID=@NewsMax
 


SELECT  NewsTitle,NewsID  FROM NewsView
 inner join UserFollowing
 on UserFollowing.SubNesourceID=NewsView.SubNesourceID and  (UserFollowing.UserID=@UserID  )
 

 
  where  (NewsView.NesourceID=@SubNesourceID or @SubNesourceID=0)  and (NewsID> @NewsID) 
   and NewsTitle like  @q -- for search
 order by NewsDate DESC
 end


GO
/****** Object:  StoredProcedure [dbo].[myChannel]    Script Date: 1/23/2016 2:43:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE procedure  [dbo].[myChannel](@SubNesourceID int)
as

SELECT [SubNesourceID]
      ,[SubNesourceName]
      
      ,[SubNesourceLink]
      ,[ChannelImage]
     
      ,[BacugroundPicture]
	  ,(
	  SELECT count(*) 
  FROM  [UserFollowing] where UserFollowing.SubNesourceID=SubNesources.SubNesourceID) as Followers
  FROM [SubNesources]
  where SubNesources.SubNesourceID=@SubNesourceID

 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SubNesources"
            Begin Extent = 
               Top = 32
               Left = 105
               Bottom = 200
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "News"
            Begin Extent = 
               Top = 6
               Left = 351
               Bottom = 136
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewsViewNoDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewsViewNoDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Resources"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 182
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SubNesources"
            Begin Extent = 
               Top = 6
               Left = 261
               Bottom = 178
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "UserFollowing"
            Begin Extent = 
               Top = 16
               Left = 639
               Bottom = 129
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ResourcesForUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ResourcesForUser'
GO
