USE [master]
GO
/****** Object:  Database [WitcherDB]    Script Date: 27.05.2021 18:49:07 ******/
CREATE DATABASE [WitcherDB]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WitcherDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WitcherDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WitcherDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WitcherDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WitcherDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WitcherDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WitcherDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WitcherDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WitcherDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WitcherDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WitcherDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WitcherDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WitcherDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WitcherDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WitcherDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WitcherDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WitcherDB] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [WitcherDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WitcherDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [WitcherDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WitcherDB] SET  MULTI_USER 
GO
ALTER DATABASE [WitcherDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WitcherDB] SET ENCRYPTION ON
GO
ALTER DATABASE [WitcherDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [WitcherDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [WitcherDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
USE [WitcherDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 27.05.2021 18:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Activity]    Script Date: 27.05.2021 18:49:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Beast]    Script Date: 27.05.2021 18:49:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beast](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDImage] [int] NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IDClass] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bestiary]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bestiary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[IDFeature] [int] NULL,
	[IDBeast] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Character]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Character](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IDRace] [int] NULL,
	[IDActivity] [int] NULL,
	[IDImage] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Components]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Components](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDImage] [int] NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Location] [nvarchar](max) NOT NULL,
	[IDEquipmentType] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentStructure]    Script Date: 27.05.2021 18:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentStructure](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](128) NOT NULL,
	[IDEquipment] [int] NULL,
	[IDComponent] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentType]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Image]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Link] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IDTypeLocation] [int] NULL,
	[IDCountry] [int] NULL,
	[IDImage] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationType]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Potion]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Potion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IDPotionType] [int] NULL,
	[IDImage] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PotionStructure]    Script Date: 27.05.2021 18:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PotionStructure](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[IDIngredient] [int] NULL,
	[IDPotion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PotionType]    Script Date: 27.05.2021 18:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PotionType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Race]    Script Date: 27.05.2021 18:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Race](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 27.05.2021 18:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Activity] ON 

INSERT [dbo].[Activity] ([ID], [Name]) VALUES (10, N'Бард')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (2, N'Ведьмак')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (9, N'Военный деятель')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (3, N'Государственный деятель')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (7, N'Искуситель')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (13, N'Любитель убегать')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (6, N'Наёмник')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (14, N'Наместник')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (1, N'Неизвестно')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (12, N'Предприниматель')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (8, N'Рыцарь')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (11, N'Философ')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (4, N'Чародей')
INSERT [dbo].[Activity] ([ID], [Name]) VALUES (5, N'Чародейка')
SET IDENTITY_INSERT [dbo].[Activity] OFF
SET IDENTITY_INSERT [dbo].[Beast] ON 

INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (1, 11, N'Альгуль', N'Это разновидность гуля, который питается не только трупами, но нередко нападает и на живых. Чаще всего их можно встретить в склепах и на полях сражений в окружении простых гулей.
Внешне он похож на гуля. Простые смертные не видят разницы между этими падальщиками. Но именно это внешнее сходство альгулей и гулей делает их иногда даже более опасными, нежели королей кладбищ — цеметавров и гравейров, которые несколько сильнее тех же альгулей.', 2)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (2, 18, N'Суккуб', N'Суккубы — родственные бесам, сильванам и чертам реликты Сопряжения Сфер. Суккубы почти во всем выглядят как молодые привлекательные девушки, которые могут иметь различный тон кожи и цвет волос, но не стоит обманываться — они не являются ни женщинами, ни людьми; суккубы также имеют козьи ноги с копытцами до примерно середины бедра, хвосты с кисточками и рога, которые могут быть козьими или бараньими, или иметь практически любую другую форму.

Их тела и лица часто украшены татуировками и узорами различными красками. Они предпочитают почти не носить одежды, лишь набедренные повязки, часто предстают топлес. Кроме того, Вара обладала также перепончатыми крыльями и была способна принимать облик молодой стройной человеческой девушки с длинными тёмно-русыми волосами, полными губами и веснушками, практически ничем не отличаясь от обычной женщины кроме красного цвета глаз. Неизвестно, являлось ли подобное изменение облика некой формой иллюзии или магии, или неким контролем разума, заставлявшим окружающих не замечать ее истинную сущность, или Вара действительно была способна трансформировать свое тело. Неизвестно также, какую природу носили ее крылья и могла ли она с помощью них полноценно летать, и почему крыльев нет у остальных известных суккубов.', 10)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (3, 17, N'Волколак', N'Волколаком можно стать в результате проклятья или родиться таковым, если оба или даже один из родителей является оборотнем. В зависимости от первопричины ликантропии, условий проклятья и превращения и личностных качеств индивида, ликантроп может обращаться либо по своей воле, либо в определенные периоды, например, в полнолуние, либо же вообще перманентно оставаться волком, и как терять контроль после обращения, так и сохранять разум, приобретая исключительно преимущества волчьего организма. Кроме того, даже в человеческом обличье волколаки имеют невероятно тонкие нюх и слух, которым уступают даже ведьмачьи, а также обладают ускоренной регенерацией, нечеловеческими ловкостью и скоростью.

Разумеется, разумный, осознающий свои действия волколак — большая редкость, и чаще оборотни не контролируют процесс трансформации и то, что творят, будучи волками — ими движут животная жажда крови и инстинкты хищника. Принимая вновь человеческое обличье, люди обычно не помнят зверств, которые они сотворили в облике волколака. Несмотря на потерю контроля, волколаки сохраняют общую «производительность» человеческого разума и несравнимо умнее животных, а, временами, даже могут приходить в сознание и говорить. Волколаки особенно активны в полнолуние. Охотятся они, как правило, в одиночку, однако, могут контролировать обычных волков и призвать их себе на помощь в случае опасности.', 5)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (4, 20, N'Виверна', N'Летающий ящер, на Старшей Речи носит название «wywerna» или «wiwerna», а на общей — выворотка.

Являются частью естественной экосистемы мира. Легко поддаются приручению у друидов. Территориальные животные. Они живут и охотятся в одиночку, хотя бывают периоды, когда они спариваются. Нападают на любого нарушителя их территорий, кроме тех, кто гораздо тяжелее их самих, те же драконы, например. Они питаются в основном мясом животных, которых легко хватать с воздуха, — вот почему они так любят питаться овцами.

Кметы довольно часто путают их с драконами. Ведьмаки, однако, сразу же узнают этих тварей, которые ходят по земле на двух сильных мускулистых ногах. Они также знают, что в бою с ними необходимо избегать ядовитого жала на конце хвоста и мощной пасти, ощетинившейся во все стороны смертельными зубами. Так что, если путник, наткнувшийся на виверну, не ведьмак или друид, ему лучше не связываться с виверной.', 9)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (5, 19, N'Волк', N'Волки живут в дикой природе, а когда они начинают испытывать голод, приближаются к человеческим поселениям и охотятся на домашних животных и их хозяев. Уничтожение волков — задача королевских егерей и лесников, но порой приходится заниматься этим и ведьмакам на большаке. В каждой волчьей стае есть вожак — самый крупный и сильный представитель своего вида.

Крупнее большинства видов собак, но могут различаться в размерах и иметь разные оттенки меха, как и собаки.', 8)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (6, 13, N'Гаргулья', N'Гарryльи – каменные статуи, оживленные с помощью магии, чтобы защищать лаборатории и жилища чародеев от вторжения незваных гостей. Один только их облик отпугивает большую часть взломщиков. Те же, кто не пугается при виде этих рогатых и крылатых чудовищ, обычно умирают вскоре после, разорванные каменными костями.', 12)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (7, 14, N'Грифон', N'Грифон составляет гибрид льва и орла: от первого он имеет туловище, гриву, задние лапы и хвост с кисточкой, а от второго – голову и крылья. Все четыре конечности этих существ оканчиваются сильно загнутыми острыми когтями – по два на передних и по три на задних. На своих могучих крыльях с размахом более пяти метров грифоны способны летать, развивая огромную скорость и используя изящество своего полета в качестве преимущества в охоте. На земле, однако, грифоны чувствуют себя не менее комфортно, обладая кошачьими грацией и ловкостью, хотя в бою и стараются по возможности подняться в воздух. Как правило, их шкура имеет песочно-желтый окрас, грива и кисточка на хвосте темнее остального меха, обычно черные или коричневые, клюв – черный, а оперение крыльев – темное, серое или бурое. Грифоны – крупные создания, обычно достигающие 3 метров в холке и обладающие массой в несколько центнеров.', 10)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (8, 16, N'Леший', N'Леший обычно питается лесными зверями, не трогая человека, но если двуногий пришелец, явившись в лес, оскорбляет природу — леший не будет ждать (особенно, когда голоден): подкрадётся и свернёт шею, либо пробьёт голову сухим, костистым кулаком. Иногда это почитаемое существо может лечить других лесных жителей и призывать накеров или воронов на защиту леса. Его атаки неторопливы, но смертельны.

Нечто, что «живет только, чтобы убивать», а когда они убивают кого-то или что-то, то не оставляют почти ничего для падальщиков. Раньше лешие встречались очень часто и повсеместно; сейчас же встретить лешего — большая редкость.', 10)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (9, 12, N'Катакан', N'Эти монстры выглядят как огромные 2,5 метровые нетопыри серо-лилового цвета разной степени интенсивности и темноты оттенков. Они имеют длинные усы и бороду, заостренные уши, а также длинные когти, которые растут всю жизнь, и зубы, которые имеют тенденцию желтеть, затупляться и не вырастают снова в случае потери. Катаканы предпочитают запасаться пищей, которая долгие годы может перевариваться в их желудках. У этого вида очень сильные ноги, которые позволяют им прыгать на большие расстояния или быстро перемещаться, не давая противнику выгадать время для удара. Многие особи имеют слабость к блестящим драгоценностям, бижутерии и украшениям, а некоторые — к крови пьяниц.

Несмотря на то, что форма нетопыря является для катаканов первоначальной и естественной, эти существа также способны трансформировать свое тело и принимать человеческую форму, либо же приобретают эту возможность с возрастом. В частности это объясняет, почему Губерт Рейк и вампир из новиградских катакомб выглядят как люди и могут перекидываться в нетопыря. Вероятно, подобно истинным высшим вампирам, катаканы выбирают вести разный образ жизни: либо хищнически-звериный, обитая в катакомбах, подземельях в форме нетопыря и охотясь на неудачливых путников и животных на поверности, либо более-менее цивилизованно живут в социуме как люди, питаясь аккуратнее и скрытнее.', 7)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (10, 15, N'Полуденница', N'Эта разновидность призраков, встречается в ясный и погожий день, когда солнце высоко. Родственна полуночницам, появляющимся только в ночное время. Полуденница выглядит как измождённая и скорбная девушка, с очень загорелой кожей и длинными белыми волосами. Веки несчастной зашиты грубой ниткой, одета она в изодранное белое платье.

В группе — весьма опасный и серьезный противник даже для ведьмака. По одиночке же она не столь опасна. Покачивающиеся колосья на полях в безветренный день объявляют о прибытии полудениц. Они водят хороводы при свете дня и пытаются завлечь крестьян к себе в круг. Никто ещё не выходил из него живым.

Полуденницы в основном обитают на обработанных полях и лугах, где появляются примерно в полдень. Хоть они и являются призраками, но в то же время сохраняют сильную связь с реальным миром, они видят смертных, но не понимают их, потому что мертвые не могут слышать живых', 4)
INSERT [dbo].[Beast] ([ID], [IDImage], [Name], [Description], [IDClass]) VALUES (11, 49, N'Бес', N'Является родственным с суккубами, сильванами и чертами видом и очень похож на последних: огромное существо, передвигающееся на четырех конечностях, имеет огромные рога, третий глаз во лбу. Передние лапы беса четырехпалые и заканчиваются короткими когтями, а один из пальцев является прибылым, задние же конечности оканчиваются копытами. Также имеет хвост с кисточкой. Голова вытянутая, широкая пасть, полная острых зубов с длинными выдающимися клыками на обеих челюстях. Покрытая пигментными пятнами кожа и недлинная шерсть, растущая вокруг головы, на локтях, в паху и на задних лапах, могут носить очень разный окрас: от светлого и белого до красного, болотного и черного. Брюхо беса обычно имеет другой окрас в сравнении с остальным телом. Также ввиду различия в цвете разные участки шкуры могут образовывать «тигриные» полосы.

Бесы гораздо крупнее чертов, а также отличаются от них формой рогов — обычно они ветвистые, оленьи, но иногда встречаются и развесистые лосиные «лопаты». Эти существа обладают дьявольской физической силой, отличными способностями к регенерации, а также могут гипнотизировать противников с помощью третьего глаза. Эти существа предпочитают обитать в лесных чащобах, непролазных болотах или неглубоких пещерах, яростно охраняют свою территорию и свирепо расправляются с любым конкурентом. Бесы всеядны и не брезгуют ни мясом, ни растительной пищей.', 6)
SET IDENTITY_INSERT [dbo].[Beast] OFF
SET IDENTITY_INSERT [dbo].[Bestiary] ON 

INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (1, N'Стайные', 2, 1)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (3, N'Кладбища, склепы,  места сражений', 3, 1)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (4, N'Масло против трупоедов, знак Аксий', 5, 1)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (6, N'Одиночные', 2, 2)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (7, N'Близ людских поселений', 3, 2)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (8, N'Масло против гибридов, Знак Квен', 5, 2)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (9, N'Одиночки/Стайные', 2, 3)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (10, N'В городах или около людских селений', 3, 3)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (11, N'Лунная пыль, Чертов гриб, Масло против проклятых, Знак Игни', 5, 3)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (12, N'Стайные', 2, 4)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (13, N'Горная местность', 3, 4)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (14, N'Иволга, Масло против драконидов, Знак Аард, Картечь (бомба)', 5, 4)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (16, N'Стайные', 2, 5)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (17, N'Дикая природа, окрестности людских поселений', 3, 5)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (18, N'Картечь (бомба), Знак Игни', 5, 5)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (19, N'Одиночные', 2, 6)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (20, N'Знак Квен, Масло против магических тварей, Двимеритовая бомба', 5, 6)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (21, N'Физические атаки', 6, 6)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (22, N'Одиночки', 2, 7)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (23, N'Скеллиге, Велен, около Оксенфурта, вблизи Белого Сада', 3, 7)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (24, N'Малсо против гибридов, Картечь, Знак Аард', 5, 7)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (25, N'Одиночки', 2, 8)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (26, N'Древние чащи', 3, 8)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (27, N'Знак Игни,  Двимеритовая бомба, Масло против реликтов', 5, 8)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (28, N'Одиночки', 2, 9)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (29, N'Людские поселение', 3, 9)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (30, N'Масло против вампиров, Чертов гриб, Лунная пыль, Знак Ирден, Знаг Игни', 5, 9)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (31, N'Одиночки', 2, 10)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (32, N'Знак Ирден, Лунная пыль, Масло против призраков', 5, 10)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (33, N'Перемещается в нематериальной форме. Принимает материальную форму во время атаки.', 6, 10)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (34, N'Одиночки', 2, 11)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (36, N'Чащи лесов, болота, пещеры', 3, 11)
INSERT [dbo].[Bestiary] ([ID], [Value], [IDFeature], [IDBeast]) VALUES (37, N'Знак Игни, Масло против реликтов, Знак Квен, Самум, Северный ветер', 5, 11)
SET IDENTITY_INSERT [dbo].[Bestiary] OFF
SET IDENTITY_INSERT [dbo].[Character] ON 

INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (1, N'Геральт из Ривии', N'Геральт обладает весьма примечательным, хотя и на редкость несносным характером. Годы, проведённые на большаке среди различного рода и степени маргинальных личностей, скитания по всему свету, бесчисленное количество схваток и передряг выработали в Геральте ряд качеств, которые в течение его приключений позволяли ему выживать и выходить относительным победителем из любой ситуации. Основными чертами характера ведьмака являются сдержанность, молчаливость, прямолинейность, честность, красноречие, любознательность, рассудительность, скрытность, умеренность во всем и способности не терять самообладание в любой ситуации и подлаживаться к любым условиям в силу «прирожденного оппортунизма». Также Геральт опытен и практичен, неприхотлив и независим. Кроме того он отличается сильнейшим гуманизмом, хотя и не питает иллюзий об устройстве мира и его обитателях и не наивен. Ведьмак сообразителен, разумен и, как правило, способен принимать взвешенные и продуманные решения. Несмотря на склонность к бродяжничеству и неспособность долго жить в одном месте, что связано как с чертами характера, так и с образом жизни, Геральт высоко ценит дом и удобства, не отказываясь от них при возможности. Тем не менее, несмотря на всю свою дальновидность и определенную степень мудрости, Геральт остёр на язык, грубоват, саркастичен и вообще обладает специфическим чувством юмора.', 2, 2, 1)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (2, N'Йеннифэр из Венгерберга', N'Йеннифэр предстаёт женщиной необыкновенной красоты — красивые фиалковые глаза, роскошные чёрные волосы, закрученные в тугие, ниспадающие на плечи локоны, переливающиеся как перья павлина, стройная фигура. Для подчеркивания привлекательности не гнушается применять магические эликсиры.

В книгах Геральт видит её, как на свой манер привлекательную, но далеко не классическую красавицу: немного длинноватый нос, немного узковатые губы, не слишком большая грудь, подбородок, скошенный чуть больше, чем следовало бы, не очень правильные брови.

Как и многие чародейки, Йеннифэр наделена весьма непростым, а порой просто невыносимым характером. Одна из второстепенных персонажей, жрица Фрейи Сигрдрифа, описывает ее как женщину мудрую и, в принципе, добрую. Но абсолютно беспринципную, безжалостную и жестокую.

В одежде Йеннифэр предпочитает сочетание черного и белого цвета. На шее носит обсидиановую звезду с активными бриллиантами, являющуюся сильным магическим артефактом. Пользуется духами с ароматом сирени и крыжовника.', 2, 5, 4)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (3, N'Цирилла Фиона Элен Рианнон', N'Цирилла Фиона Элен Рианнон. Что я могу о ней рассказать? Что друзья зовут её Цири, появилась на свет она в 1251 году, у неё пепельные волосы и шрам на щеке? Всё это так. И с виду Цирилла, которую я хорошо знаю и которую впервые увидел много-много лет назад, была не сказать чтобы совсем обычной, нет, она была очень даже примечательной, но глядя на неё нельзя было и представить, сколь она необыкновенна. Ибо Цирилла - умелая ведьмачка, наследница нескольких королевских тронов, последняя носительница Старшей Крови, могущественный Исток, обладательница исключительных магических способностей, Повелительница Времени и Пространства. Разве имеет значение цвет её волос и дата рождения?
Я мог бы сказать, что она приёмная дочь Геральта, но это было бы грубым упрощением. Цири для него нечто гораздо большее. Цири - его Предназначение, Дитя-Неожиданность, связанное с его жизнью тысячами неразрывных нитей.
Следуя вековой традиции ведьмаков, Геральт привёз свою воспитанницу в Каэр Морхен. Здесь они с Весемиром обучали её искусству убивать чудовищ. Здесь же впервые раскрыли её магические таланты, и ведьмаки узнали, что девочка - Исток.
Дар Цири оказался её проклятием, и однажды именно из-за него ей пришлось скрываться ото всех - даже от Геральта.
В жизни Цири была ещё одна большая тайна. Отцом ей приходился не кто иной как нильфгаардский император Эмгыр вар Эмрейс. Его слова подтвердили страхи, поселившиеся в душе Геральта после ночного кошмара: Цири вернулась и ей грозила смертельная опасность - по следам девушки неотступно мчалась Дикая Охота.', 2, 2, 6)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (4, N'Эредин Бреакк Глас', N'Имя короля Дикой Охоты, личность повелителя кошмаров, лицо под страшной маской — все это долгое время оставалось неизвестным. Со временем же крупицы сведений постепенно сложились в цельное изображение нашего врага, но от этого внушаемый им ужас не стал меньше.
Дикая Охота в действительности оказалась элитным отрядом конницы из мира Aen Elle, народа Ольх, под командованием честолюбивого и безжалостного короля по имени Эредин Бреакк Глас. Он путешествовал тайными тропами сквозь ледяную пустоту между мирами, похищал и превращал в рабов людей нашего мира. Теперь же он охотился за Цириллой, чью силу желал использовать в своих целях. И единственным препятствием на его пути оказался Геральт из Ривии.', 3, 9, 7)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (5, N'Эмиель Регис Рогеллек Терзиефф-Годфрой', N'Эмиеля можно охарактеризовать как хладнокровного, рассудительного, высокоморального и эрудированного персонажа с богатым жизненным опытом. Он способен сохранять спокойствие независимо от обстоятельств, прекрасно контролирует свои эмоции, умеет принимать сложные и взвешенные решения. За многие годы жизни среди людей Регис идеально научился мимикрировать в человеческом обществе. Самоотвержен и предан друзьям, ради которых готов пойти на всё.', 9, 11, 10)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (6, N'Золтан Хивай', N'Краснолюд Золтан Хивай был нашим с Геральтом сердечным приятелем, товарищем еще по тем временам, когда мы вместе скитались по лесам и хлябям Бругге и Соддена. Вокруг бушевала война, а тракты дрожали под копытами нильфгаардской кавалерии. Затем, как и многие из его родичей, Золтан сражался под Бренной в рядах Добровольческой рати Махакама, которая многое сделала для победы, о чем, впрочем, предпочитают умалчивать хроники. После войны старался он наладить собственное дело и замышлял помолвку, однако судьбе было угодно, чтобы дела его сложились иначе. Золтан многажды дружбу свою с ведьмаком делами подтверждал. Подставлял он плечо в любых невзгодах, опровергая клеветников, кои утверждают, будто краснолюды все один к одному злобные, жадные сучьи дети, будто людская беда им только в радость и соседствовать с ними совершенно невозможно. Я знаю многих нелюдей, и если соседству с ними что и мешает, то только людское невежество, зависть и неблагодарность.', 5, 12, 9)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (7, N'Юлиан Альфред Панкрац де Леттенхоф', N'Родившийся в 1229 году даровитый поэт и трубадур, выпускник Оксенфуртской академии, частый гость на королевских дворах, несравненный любовник, ценимый, а порою и даже обожаемый дамами по всему миру, умелый дипломат и пылкий оратор — вот образ Лютика, известный по рассказам знавших его людей.
Образ это, пожалуй, несколько перенасыщен красками: сам ваш покорный слуга предпочитает думать о себе как о непритязательном художнике и скромном служителе муз — моя летопись обязана своим появлением на свет тому факту, что я был, есть и навеки останусь близким другом и верным товарищем ведьмака Геральта, коему я, усердный летописец, и посвящаю настоящий труд.', 2, 10, 8)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (8, N'Гюнтер о''Дим', N'Гюнтер о’Дим — истинный торговец, манипулятор, льстец и отличный переговорщик. Обладая притягательным обаянием, Гюнтер может найти путь к любому сердцу и очаровать любого человека. Он представляется благородным, терпеливым, отзывчивым и всегда готовым помочь.

Однако это всего лишь ширма, скрывающая его истинное лицо — Господин Зеркало крайне жесток, черств и мстителен, не обладает и каплей сочувствия, а тем более милосердия, и готов на что угодно, лишь бы заполучить то, что ему причитается по договорам, или то, что ему хочется. Он охотно заключает сделки с любыми людьми, однако некоторые (к примеру, Геральт[2]) являются для него приоритетными целями. Господин Зеркало всегда соблюдает условия заключенного договора и держит своё слово, даже если это идет вразрез с его собственными интересами (это своеобразное «благородство» о''Дима и позволяет Геральту одержать над ним верх). Тем не менее это вызвано «профессиональной» этикой и практической пользой — люди перестанут заключать с ним договоры, если Господин Зеркало не будет исполнять их условия.', 8, 7, 3)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (9, N'Княжна', N'«Мудрый Княжна зверь, только к тем приходит, кто страдает».', 10, 13, 2)
INSERT [dbo].[Character] ([ID], [Name], [Description], [IDRace], [IDActivity], [IDImage]) VALUES (10, N'Филип Стенгер', N'По мнению большинства жителей Велена, барон — жестокий правитель и садист, обирающий их, однако это не совсем так. Он простой, добросердечный и сердобольный человек, которому не повезло в жизни. Несмотря на определенную недалекость, Филип сообразителен, умеет извлекать выгоду из своего положения, вести переговоры и заключать союзы.

Приобретя свое прозвище по недоразумению, барон умело использовал свою дурную славу для того, чтобы более эффективно управлять своими владениями и контролировать подчинённых, состоящих, в основном, из дезертиров и разбойников, ранее служивших в темерской армии. В то же время ему удалось договориться с Нильфгаардом и получить в обмен на снабжение и рабочую силу привилегии и право править Веленом. Тем не менее Филип предателем себя не считает — просто после падения Темерии он не видит смысла в том, чтобы бороться за призраков. Будучи ветераном множества войн, как междоусобных, так и Северных, в частности, Содденской битвы, а также очевидцем начала охоты на ведьм в Мариборе, барон злоупотребляет алкоголем.', 2, 14, 5)
SET IDENTITY_INSERT [dbo].[Character] OFF
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([ID], [Name]) VALUES (7, N'Вампиры')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (10, N'Гибриды')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (9, N'Дракониды')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (12, N'Духи стихий')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (8, N'Животные')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (3, N'Инсектоиды')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (1, N'Неизвестно')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (11, N'Огры')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (4, N'Призраки')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (5, N'Проклятые')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (6, N'Реликты')
INSERT [dbo].[Class] ([ID], [Name]) VALUES (2, N'Трупоеды')
SET IDENTITY_INSERT [dbo].[Class] OFF
SET IDENTITY_INSERT [dbo].[Components] ON 

INSERT [dbo].[Components] ([ID], [Name]) VALUES (12, N'Гвозди')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (16, N'Глаз чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (4, N'Драконья чешуя')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (21, N'Дратва')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (33, N'Железный слиток')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (1, N'Железо')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (17, N'Зуб чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (2, N'Кожанные обрывки')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (15, N'Кожаные ремешки')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (25, N'Кость чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (22, N'Кровь чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (20, N'Метеоритная руда')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (14, N'Мозг чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (13, N'Обрезки кожи')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (29, N'Обрывок шкуры')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (26, N'Печень чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (19, N'Пластина из метеоритного серебра')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (9, N'Пластина из темной стали')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (32, N'Пятая эссенция')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (6, N'Рубашка')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (34, N'Рубиновая пыль')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (28, N'Руда метеоритного железа')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (11, N'Руда темного железа')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (3, N'Серебро')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (31, N'Слиток серебра')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (36, N'Слиток стали')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (35, N'Слюна чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (7, N'Толченая плоть чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (8, N'Укрепленная кожа')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (5, N'Укрепленное дерево')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (24, N'Холст')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (18, N'Шелк')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (10, N'Шкура')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (30, N'Шнурок')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (23, N'Эссенция чудовища')
INSERT [dbo].[Components] ([ID], [Name]) VALUES (37, N'Язык чудовища')
SET IDENTITY_INSERT [dbo].[Components] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([ID], [Name]) VALUES (4, N'Аэдирн')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (11, N'Бругге')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (12, N'Вердэн')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (16, N'Дол Блатанна')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (17, N'Зеррикания')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (3, N'Каэдвен')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (8, N'Ковир')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (15, N'Лирия')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (10, N'Махакам')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (9, N'Назаир')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (1, N'Нильфгаард')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (23, N'Новиград')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (13, N'Офир')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (19, N'Повисс')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (7, N'Редания')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (14, N'Ривия')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (6, N'Скеллиге')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (18, N'Содден')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (2, N'Темерия')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (22, N'Туссент')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (20, N'Цидарис')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (5, N'Цинтра')
INSERT [dbo].[Country] ([ID], [Name]) VALUES (21, N'Эббинг')
SET IDENTITY_INSERT [dbo].[Country] OFF
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (3, 32, N'Доспехи школы кота', N'Этот доспех нельзя купить, найти или получить. Его можно только изготовить у кузнеца-бронника рангом не ниже подмастерья по найденному чертежу, если имеются все необходимые компоненты. Чертежи можно отыскать в ходе квеста «Ведьмачьи древности: снаряжение Школы Кота». Является легким доспехом.', N'Велен', 1)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (4, 34, N'Доспехи школы грифона', N'Данный вид брони относится к доспехам среднего типа, которые станут отличным помощником для игроков, предпочитающих использовать в бою знаки силы.', N'Велен, Оксенфурт', 1)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (5, 33, N'Доспехи школы медведя', N'Данный вид брони относится к доспехам тяжёлого типа, для игроков, предпочитающих в бою использовать мощные атаки. ', N'Острова Скеллиге', 1)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (6, 31, N'Доспехи школы волка', N'Данный вид брони относится к доспехам среднего типа, для игроков, предпочитающих комбинировать быстрые и мощные атаки с использованием знаков.', N'Каэр Морхен', 1)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (7, 35, N'Арондит', N'Каждый удар генерирует заряды, увеличивающие урон мечом на 10[2]. Заряды тратятся со временем или при получении урона. Полностью заряженный меч всегда наносит критический урон. Убийство врага заряженным мечом разряжает его, одновременно навсегда увеличивая урон этим оружием.', N'Туссент', 2)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (8, 36, N'Серебряный меч Школы Волка', N'Этот меч нельзя купить, найти или получить. Его можно только изготовить у кузнеца-оружейника рангом не ниже подмастерья по найденному в ходе квеста «Ведьмачьи древности: снаряжение Школы Волка» чертежу, если имеются все необходимые компоненты и установлено бесплатное дополнение «Wolf School Gear».', N'Каэр Морхен', 2)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (9, 37, N'Стальной меч Школы Кота', N'Этот меч нельзя купить, найти или получить. Его можно только изготовить у кузнеца-оружейника рангом не ниже подмастерья по найденному чертежу, если имеются все необходимые компоненты. Чертеж можно найти, выполняя квест «Ведьмачьи древности: снаряжение Школы Кота».', N'Велен', 2)
INSERT [dbo].[Equipment] ([ID], [IDImage], [Name], [Description], [Location], [IDEquipmentType]) VALUES (10, 38, N'Стальной меч Школы Медведя', N'Этот меч нельзя купить, найти или получить. Его можно только изготовить у кузнеца-оружейника рангом не ниже подмастерья по найденному чертежу, если имеются все необходимые компоненты. Чертеж можно найти, выполняя квест «Ведьмачьи древности: снаряжение Школы Медведя».', N'Острова Скеллиге', 2)
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[EquipmentStructure] ON 

INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (2, N'6', 3, 5)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (3, N'1', 3, 6)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (4, N'1', 3, 7)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (5, N'4', 3, 8)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (6, N'1', 3, 9)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (7, N'3', 3, 10)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (8, N'2', 3, 11)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (9, N'2', 3, 12)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (10, N'2', 3, 17)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (11, N'2', 3, 18)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (12, N'4', 3, 13)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (13, N'1', 3, 14)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (15, N'2', 3, 15)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (16, N'2', 3, 16)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (18, N'1', 4, 6)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (19, N'2', 4, 8)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (20, N'1', 4, 19)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (21, N'7', 4, 15)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (22, N'2', 4, 16)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (23, N'12', 4, 13)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (24, N'3', 4, 20)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (25, N'5', 4, 21)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (26, N'4', 4, 7)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (27, N'2', 4, 18)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (28, N'1', 4, 10)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (29, N'1', 4, 22)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (30, N'1', 4, 23)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (31, N'1', 5, 6)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (32, N'4', 5, 8)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (33, N'1', 5, 9)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (35, N'4', 5, 24)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (36, N'1', 5, 25)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (37, N'3', 5, 10)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (38, N'5', 5, 3)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (39, N'2', 5, 13)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (40, N'1', 5, 26)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (41, N'1', 5, 11)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (42, N'1', 5, 28)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (43, N'1', 5, 29)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (44, N'2', 5, 30)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (45, N'1', 5, 22)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (46, N'1', 6, 6)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (47, N'3', 6, 8)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (48, N'1', 6, 19)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (49, N'7', 6, 15)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (50, N'2', 6, 16)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (51, N'12', 6, 13)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (52, N'3', 6, 20)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (53, N'5', 6, 21)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (54, N'4', 6, 7)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (55, N'2', 6, 18)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (56, N'4', 6, 10)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (57, N'1', 6, 22)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (58, N'1', 6, 23)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (59, N'1', 8, 13)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (60, N'3', 8, 31)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (61, N'1', 8, 32)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (62, N'1', 8, 14)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (63, N'1', 9, 15)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (64, N'4', 9, 33)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (65, N'1', 9, 34)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (66, N'1', 9, 35)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (67, N'2', 10, 15)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (68, N'2', 10, 36)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (69, N'1', 10, 23)
INSERT [dbo].[EquipmentStructure] ([ID], [Value], [IDEquipment], [IDComponent]) VALUES (70, N'1', 10, 37)
SET IDENTITY_INSERT [dbo].[EquipmentStructure] OFF
SET IDENTITY_INSERT [dbo].[EquipmentType] ON 

INSERT [dbo].[EquipmentType] ([ID], [Name]) VALUES (1, N'Броня')
INSERT [dbo].[EquipmentType] ([ID], [Name]) VALUES (2, N'Меч')
SET IDENTITY_INSERT [dbo].[EquipmentType] OFF
SET IDENTITY_INSERT [dbo].[Feature] ON 

INSERT [dbo].[Feature] ([ID], [Name]) VALUES (1, N'Вид(ы)')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (7, N'Добыча')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (4, N'Иммунитет')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (3, N'Местонахождение')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (8, N'Пол')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (6, N'Такика')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (2, N'Тип')
INSERT [dbo].[Feature] ([ID], [Name]) VALUES (5, N'Уязвимость')
SET IDENTITY_INSERT [dbo].[Feature] OFF
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ID], [Link]) VALUES (1, N'https://avatars.mds.yandex.net/get-pdb/4943718/cc90830a-341f-4d06-a8b9-74b371c6f137/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (2, N'https://avatars.mds.yandex.net/get-pdb/4454906/a3a1c164-bd3e-4caa-b976-cc16517ff6a1/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (3, N'https://avatars.mds.yandex.net/get-pdb/4724602/1fd8d968-9d06-4cd8-b6c1-7caf56ce7a28/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (4, N'https://avatars.mds.yandex.net/get-pdb/4444461/b9218fb0-502a-4cf1-aa99-eb8d1c2cad2b/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (5, N'https://avatars.mds.yandex.net/get-pdb/4752975/56bb8515-bd8f-45c4-b095-51b5304f9fce/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (6, N'https://avatars.mds.yandex.net/get-pdb/4119989/7de84102-8d35-4dd9-b47c-04c7d6279cae/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (7, N'https://avatars.mds.yandex.net/get-pdb/4546662/d8770762-6858-4df9-b6e2-68037042e591/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (8, N'https://avatars.mds.yandex.net/get-pdb/4855041/0bdcbc97-22dc-443b-8705-39920951578d/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (9, N'https://avatars.mds.yandex.net/get-pdb/3029455/7a66fdfc-750d-4dbe-ae93-f526c22b9808/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (10, N'https://avatars.mds.yandex.net/get-pdb/4571085/f57a672c-e8d3-4181-bddd-2e65c7834a4b/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (11, N'https://avatars.mds.yandex.net/get-pdb/4303508/1d28223c-cd7d-4bcd-8c0b-4ec4f30d5003/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (12, N'https://avatars.mds.yandex.net/get-pdb/4700496/f75924ca-a2e0-4dc9-8bab-d712bb1f375b/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (13, N'https://avatars.mds.yandex.net/get-pdb/4470777/dcb22d5e-12bc-47b6-a801-fada291b6235/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (14, N'https://avatars.mds.yandex.net/get-pdb/4012555/9d7f722a-f434-4f19-95bb-3322276d4475/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (15, N'https://avatars.mds.yandex.net/get-pdb/4494646/ea3d19df-9433-4ec2-ac49-848e3737fd7a/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (16, N'https://avatars.mds.yandex.net/get-pdb/4765022/63bd6a8a-457c-4769-85b1-9d45a1c4a422/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (17, N'https://avatars.mds.yandex.net/get-pdb/4419708/c1fc883c-2126-4797-aa64-729be9d6b0f1/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (18, N'https://avatars.mds.yandex.net/get-pdb/3924606/9dd755a8-bdb1-4d06-ad55-23d6a2b59021/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (19, N'https://avatars.mds.yandex.net/get-pdb/4335005/196bf2a3-86e2-4ba2-8c76-fbc3b59ce10d/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (20, N'https://avatars.mds.yandex.net/get-pdb/4303144/fa79a68f-708a-40d5-8537-79d03e3852dc/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (21, N'https://avatars.mds.yandex.net/get-pdb/4572211/d0052605-18c9-4f7b-be87-0bce2c636185/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (22, N'https://avatars.mds.yandex.net/get-pdb/4586685/7c1fcce7-e969-4789-b95c-3ac5c3fe3a63/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (23, N'https://avatars.mds.yandex.net/get-pdb/4254997/6f449ff8-c73a-490b-94bf-cc48dab6737f/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (24, N'https://avatars.mds.yandex.net/get-pdb/4724602/3b0548c6-901a-4a03-a12b-5f01eaba2465/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (25, N'https://avatars.mds.yandex.net/get-pdb/4396969/2ca5f57d-1d26-4dbb-a4c6-af764eb72673/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (26, N'https://avatars.mds.yandex.net/get-pdb/4829575/710d76a8-f7c4-4695-9c41-6c444d93eadf/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (27, N'https://avatars.mds.yandex.net/get-pdb/4745748/f9affa03-8b53-437e-80b7-2ecab5e11a15/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (28, N'https://avatars.mds.yandex.net/get-pdb/4400510/5b373951-b347-4fc9-aa8f-9dccba53a2c3/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (29, N'https://avatars.mds.yandex.net/get-pdb/4027291/1fa61e75-2c1f-4ecc-9131-337ef1c31025/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (30, N'https://avatars.mds.yandex.net/get-pdb/3693182/e4a71a9b-07be-4369-be0c-f0c7e296e9aa/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (31, N'https://avatars.mds.yandex.net/get-pdb/4396727/dc859d95-fd98-4fba-ac2b-83418960ea6a/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (32, N'https://avatars.mds.yandex.net/get-pdb/4943718/85bef7cc-cd9a-4704-9c00-0aea18243025/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (33, N'https://avatars.mds.yandex.net/get-pdb/4012555/b552533c-6e3b-4459-852a-2459f7bbbe76/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (34, N'https://avatars.mds.yandex.net/get-pdb/4548364/2255d54b-782a-4e08-8c5e-2d33970230b6/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (35, N'https://avatars.mds.yandex.net/get-pdb/4821593/3257bd5b-3a35-49eb-afca-8800867c5a6d/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (36, N'https://avatars.mds.yandex.net/get-pdb/4744282/1de0e0e5-b9a5-4855-9cf4-a0f95729df00/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (37, N'https://avatars.mds.yandex.net/get-pdb/5068951/39f70bb0-5efc-4fa3-9eef-86be10424049/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (38, N'https://avatars.mds.yandex.net/get-pdb/4686118/98b0a30a-a18f-4569-bb46-6843723e5a64/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (39, N'https://avatars.mds.yandex.net/get-pdb/4766653/4537376d-e13b-47c1-8188-69c879a8215e/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (40, N'https://avatars.mds.yandex.net/get-pdb/4495517/a700eaf5-247d-4681-9556-be8aa06669d5/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (41, N'https://avatars.mds.yandex.net/get-pdb/4470777/593adc3a-df1a-408b-a6d3-2d2f6add3153/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (42, N'https://avatars.mds.yandex.net/get-pdb/3743486/dfa8de45-9e81-403f-a87b-6d54c5923e18/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (43, N'https://avatars.mds.yandex.net/get-pdb/1566774/ec02ee64-3a89-4195-9e22-f0e9f6e05715/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (44, N'https://avatars.mds.yandex.net/get-pdb/4333749/bf06257d-8c69-499f-b02c-b8f7c396eed8/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (45, N'https://avatars.mds.yandex.net/get-pdb/4417657/faf8a57c-0165-44e7-bf27-fd6868d5faf9/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (46, N'https://avatars.mds.yandex.net/get-pdb/4559718/c81687c9-6a9b-41ee-abbc-e37f3e4f40cf/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (47, N'https://avatars.mds.yandex.net/get-pdb/4254698/f086d22e-7c4e-4e5d-bac1-98f5f9df68d8/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (48, N'https://avatars.mds.yandex.net/get-pdb/4334580/dfcd0ae5-d451-432d-b6b1-fac7017c39d1/s1200')
INSERT [dbo].[Image] ([ID], [Link]) VALUES (49, N'https://avatars.mds.yandex.net/get-pdb/3720886/a8e9cf72-c507-4bf1-999e-952d3d2c0236/s1200')
SET IDENTITY_INSERT [dbo].[Image] OFF
SET IDENTITY_INSERT [dbo].[Ingredient] ON 

INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (13, N'Аренария')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (11, N'Вербена')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (7, N'Водная эссенция')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (1, N'Краснолюдский спирт')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (9, N'Крушина')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (2, N'Ласточкина трава')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (14, N'Лепестки чемерицы')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (15, N'Листья собачьей петрушки')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (3, N'Мозг утопца')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (16, N'Мутаген беса')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (20, N'Мутаген из архигрифона')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (23, N'Мутаген из водной бабы')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (17, N'Мутаген из волколака')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (24, N'Мутаген из катакана')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (22, N'Одуванчик')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (4, N'Паутинник')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (8, N'Плод баллисы')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (6, N'Плод берберки')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (21, N'Скороцель')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (19, N'Цветок двоегрота')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (18, N'Шишки хмеля')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (5, N'Эмбрион эндриаги')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (12, N'Яд главоглаза')
INSERT [dbo].[Ingredient] ([ID], [Name]) VALUES (10, N'Язык утопца')
SET IDENTITY_INSERT [dbo].[Ingredient] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (1, N'Каэр Морхен', N'Каэр Морхен (ориг. Kaer Morhen, искажённая Старшая Речь Caer a''Muirehen — Крепость Старого Моря) — горная крепость, в которой на протяжении нескольких веков располагалась одна из шести известных ведьмачьих школ — Школа Волка.Неизвестно, когда и кем была построена Крепость Старого Моря. Свое название она получила из-за того, что камни, использовавшиеся для возведения стен, содержат отпечатки древних морских ископаемых и раковин. После раскола первого ордена и оставления Моргрейга в долину, которая позже станет известна как Долина Каэр Морхена, пришли те из ведьмаков, кто был верен традиционным и первоначальным путям цеха.', 8, 3, 29)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (2, N'Белый сад', N'Эта состоятельная деревня славится фруктовыми деревьями, кроны которых по весне покрываются белыми цветами.
До 1272 года принадлежавшая Темерии, а ныне оккупированная Нильфгаардом деревенька на берегу речки и ее окрестности к северо-востоку от Вызимы. Население состоит из кметов, в деревне также живёт кузнец-бронник и купец. Единственная в округе корчма с доской объявлений находится на востоке поселения у Моста плакальщицы.', 1, 2, 28)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (3, N'«Фазанерия»', N'Известная и престижная таверна, расположенная в Верхнем городе Боклера у берегов озера Сид Ллигад. Вторым этажом имеет террасу, с которой открывается роскошный вид на озеро и западные окрестности Боклера.', 9, 22, 26)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (4, N'Банк Вивальди', N'Главный банк семейства Вивальди находится в Новиграде, на Площади Иерарха, где охотники за колдуньями сжигают непригодных им допплеров и чародеек. Геральт может обменять недействительные в Редании темерские орены и нильфгаардские флорены на действующие новиградские кроны у владельца банка — Вима Вивальди, который все свое время проводит у входа. А также, взять денежный кредит.', 10, 23, 27)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (5, N'Башка тролля', N'Гора на севере долины Каэр Морхена, которая с давних времён была облюбована скальными троллями, отчего и получила свое название. На уступах Башки есть пещера, окружённая частоколом, куда тролли относят свою добычу, а также Круг Стихий. Дорога к окруженному магической энергией алтарю через опасности горы долгое время служила частью Испытания медальона – «выпускного экзамена» для юных ведьмаков Школы Волка, ведь именно здесь они насыщали собственный знак цеха энергией, придавая медальонам их свойства.', 11, 3, 25)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (6, N'Страна тысячи сказок', N'Мир-иллюзия, созданный магом Артуриусом Виго для Анариетты и Сианны. В этот мир чародей поселил множество сказочных героев и существ, доброжелательно настроенных по отношению к маленьким герцогиням. Но со временем, если не следить за сказочным миром, его жители деградируют и начинают жить собственной жизнью, иногда меняясь в худшую сторону. Это и произошло с большинством жителей сказочной страны, и к 1275 году стабильность заклинаний просрочилась на 20 лет.

Страна Сказок представляет собой небольшую долину с сочными зелёными лугами, голубыми озёрами, окруженные густыми лесами и высокими горами. На всегда иссиня голубом небе «висит» радуга. Попадающий в Страну путник поначалу оказывается в густом лесу с огромными, выше человеческого роста, грибами и должен идти по дороге из жёлтого кирпича, чтобы добраться до долины. На входе в долину расположен домик Злобной ведьмы и несколько ее печей. В центре страны расположено большое, но неглубокое озерцо, а на глубоко вдающемся в воду мысе стоит неимоверно высокая башня Долговласки. На севере долины расположен небольшой занесённый снегом необитаемый городок, в котором ведёт свои дела Девочка со спичками. К западу от города находится маленькая деревушка Дюймовочки и домик Трёх поросят. К югу и юго-западу от башни Долговласки есть сеть пещер, служащих домом трём медведям, а также лагерь Румцайса и домик бабушки Красной шапочки. Высоко-высоко над долиной в достаточно плотных, чтобы по ним ходить, тучах расположен замок Облачного великана.', 3, 22, 24)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (7, N'Tor Gvalch''ca', N'Древняя эльфская башня, вздымающаяся над северной оконечностью острова Ундвик. Находится на скале высоко над уровнем моря, к башне ведет всего одна узкая тропа.

Состоит из нескольких больших помещений, одно из которых (собственно, сама башня) заперто, другое когда-то было чем-то вроде крытой оранжереи, третье же вырезано внутри скалы. Судя по всему, в Tor Gvalch''ca (подобно Tor Lara и Tor Zirael) находится портал.', 12, 6, 21)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (8, N'Коломница ', N'Коломница — остров на озере Моречко на западе Велена, где до Третьей Северной войны стояла небольшая деревенька и высокая башня чародея Александэра, окружённая частоколом. После начала войны сюда также бежал Всерад, местный помещик, в надежде укрыться от имперских войск, а также от крестьян, которые были одержимы идеей того, что наместник увез с собой все свои богатства и провизию, чтобы не делиться с мужиками.

В западной части острова расположено святилище, где местные жители проводят традиционный обряд Дяды. Сейчас Коломница — мрачное место, населённое всевозможными трупоедами и призраками.', 4, 2, 30)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (9, N'Замок Вроницы', N'Резиденция нильфгаардского наместника Велена Филипа Стенгера, который также известен под прозвищем Кровавый Барон. До Филипа замок занимал прежний властитель, который сбежал от войны на остров Коломница.

Представляет собой холм, на вершине которого построено деревянное имение, чуть ниже находится небольшая деревня. Холм окружен частоколом и рвом, наполненным водой. Фактически самый богатый регион области, хотя, даже несмотря на это, жители ощущают все тяготы войны. Во Вроницах есть квартирмейстер, два бронника — Фергус и Иоанна, торговец и доска объявлений.

В деревне жителям угрожают люди Стенгера, в её окрестностях опасность представляют волки, утопцы, гули и монстры покрупнее: грифон, василиск и куролиск.', 7, 2, 22)
INSERT [dbo].[Location] ([ID], [Name], [Description], [IDTypeLocation], [IDCountry], [IDImage]) VALUES (10, N'Лысая гора', N'По поверьям жителей Велена, Лысая гора — место ежегодных шабашей Ведьм, когда милостивые Хозяйки Леса отбирают самое большее трёх ладных юношей и трёх красивых девушек, которые поднимаются на вершину горы, проводят какое-то время вместе с Хозяйками, а затем счастливые и просветлённые спускаются обратно к людям, но уже ничего не помнят о своей прошлой жизни и быстро покидают Велен. Они приносят жителям Велена три магических жёлудя, которые обеспечивают относительное плодородие в этой отнюдь не процветающей земле. Также Стрегомир рассказывает, что несколько поколений назад Хозяйки сами спускались к людским кострам и выслушивали просьбы и жалобы.', 11, 2, 23)
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[LocationType] ON 

INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (10, N'Банк')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (12, N'Башня')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (11, N'Гора')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (2, N'Город')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (6, N'Грот')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (1, N'Деревня')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (5, N'Дом')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (7, N'Замок')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (3, N'Иной мир')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (8, N'Крепость')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (4, N'Остров')
INSERT [dbo].[LocationType] ([ID], [Name]) VALUES (9, N'Таверна')
SET IDENTITY_INSERT [dbo].[LocationType] OFF
SET IDENTITY_INSERT [dbo].[Potion] ON 

INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (1, N'Гром', N'Гром увеличивает силу атаки на 30 секунд. Максимальное количество доз Грома — 3.', 1, 40)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (2, N'Кошка', N'Этот эликсир позволяет видеть в темноте. Максимальное количество доз – 3.', 1, 42)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (3, N'Ласточка', N'Ласточка ускоряет восстановление здоровья, однако полученный урон приостанавливает эффект на 2 сек. Максимальное количество доз Ласточки — 3.', 1, 39)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (4, N'Косатка', N'Косатка увеличивает запас воздуха под водой в два раза и улучшает подводное зрение. Ведьмак может носить 3 дозы этого эликсира.', 1, 41)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (5, N'Неясыть', N'Неясыть ускоряет восстановление энергии на 30 секунд. Максимальное количество доз Неясыти — 3.', 1, 43)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (6, N'Отвар из беса', N'Увеличивает вес поклажи, которую ведьмак может нести без перегрузки', 2, 44)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (7, N'Отвар из волколака', N'Бег, ускорения и прыжки вне боя не снижают энергию', 2, 46)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (8, N'Отвар из архигрифона', N'Если у вас есть энергия, мощная атака израсходует ее полностью и снизит здоровье пораженного противника еще на 5% после расчета нормального урона', 2, 45)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (9, N'Отвар из водной бабы', N'При максимальном уровне здоровья наносимый урон увеличивается', 2, 48)
INSERT [dbo].[Potion] ([ID], [Name], [Description], [IDPotionType], [IDImage]) VALUES (10, N'Отвар из катакана', N'Увеличивает шанс критического удара', 2, 47)
SET IDENTITY_INSERT [dbo].[Potion] OFF
SET IDENTITY_INSERT [dbo].[PotionStructure] ON 

INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (1, N'1', 1, 3)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (2, N'5', 2, 3)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (3, N'1', 3, 3)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (4, N'1', 1, 1)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (5, N'2', 4, 1)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (6, N'1', 5, 1)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (7, N'1', 1, 2)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (8, N'4', 6, 2)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (9, N'2', 7, 2)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (10, N'2', 1, 4)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (11, N'5', 8, 4)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (12, N'6', 9, 4)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (13, N'5', 10, 4)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (14, N'1', 1, 5)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (15, N'2', 11, 5)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (16, N'1', 12, 5)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (17, N'1', 1, 6)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (18, N'1', 13, 6)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (19, N'1', 14, 6)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (20, N'1', 15, 6)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (21, N'1', 16, 6)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (23, N'1', 1, 7)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (24, N'1', 17, 7)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (25, N'1', 18, 7)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (26, N'1', 19, 7)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (27, N'1', 1, 8)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (28, N'1', 20, 8)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (29, N'1', 21, 8)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (30, N'1', 22, 8)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (31, N'1', 1, 9)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (32, N'1', 23, 9)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (33, N'1', 6, 9)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (34, N'1', 1, 10)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (35, N'1', 24, 10)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (36, N'1', 13, 10)
INSERT [dbo].[PotionStructure] ([ID], [Value], [IDIngredient], [IDPotion]) VALUES (37, N'1', 11, 10)
SET IDENTITY_INSERT [dbo].[PotionStructure] OFF
SET IDENTITY_INSERT [dbo].[PotionType] ON 

INSERT [dbo].[PotionType] ([ID], [Name]) VALUES (2, N'Отвар')
INSERT [dbo].[PotionType] ([ID], [Name]) VALUES (1, N'Эликсир')
SET IDENTITY_INSERT [dbo].[PotionType] OFF
SET IDENTITY_INSERT [dbo].[Race] ON 

INSERT [dbo].[Race] ([ID], [Name]) VALUES (9, N'Вампир')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (6, N'Гном')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (8, N'Демон')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (7, N'Дриада')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (10, N'Коза')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (5, N'Краснолюд')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (1, N'Неизвестно')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (4, N'Низушек')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (2, N'Человек')
INSERT [dbo].[Race] ([ID], [Name]) VALUES (3, N'Эльф')
SET IDENTITY_INSERT [dbo].[Race] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Activity__737584F6035D7AE1]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Activity] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Beast__737584F6F2E09AB5]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Beast] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Characte__737584F6DF386752]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Character] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Class__737584F6815123EC]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Class] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Componen__737584F63E1EB3AD]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Components] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Country__737584F6954C6531]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Country] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Equipmen__737584F6C3147FC9]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Equipment] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Equipmen__737584F65AFAEABE]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[EquipmentType] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Feature__737584F627CFAD2F]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Feature] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Ingredie__737584F6DE6A5F4C]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Ingredient] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Location__737584F659014CA4]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Location] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Location__737584F60AB5E34A]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[LocationType] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Potion__737584F6DE0ACF4E]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Potion] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PotionTy__737584F64992DA3A]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[PotionType] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Race__737584F630A903EB]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[Race] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 27.05.2021 18:49:24 ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Beast]  WITH CHECK ADD FOREIGN KEY([IDClass])
REFERENCES [dbo].[Class] ([ID])
GO
ALTER TABLE [dbo].[Beast]  WITH CHECK ADD FOREIGN KEY([IDImage])
REFERENCES [dbo].[Image] ([ID])
GO
ALTER TABLE [dbo].[Bestiary]  WITH CHECK ADD FOREIGN KEY([IDBeast])
REFERENCES [dbo].[Beast] ([ID])
GO
ALTER TABLE [dbo].[Bestiary]  WITH CHECK ADD FOREIGN KEY([IDFeature])
REFERENCES [dbo].[Feature] ([ID])
GO
ALTER TABLE [dbo].[Character]  WITH CHECK ADD FOREIGN KEY([IDActivity])
REFERENCES [dbo].[Activity] ([ID])
GO
ALTER TABLE [dbo].[Character]  WITH CHECK ADD FOREIGN KEY([IDImage])
REFERENCES [dbo].[Image] ([ID])
GO
ALTER TABLE [dbo].[Character]  WITH CHECK ADD FOREIGN KEY([IDRace])
REFERENCES [dbo].[Race] ([ID])
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD FOREIGN KEY([IDEquipmentType])
REFERENCES [dbo].[EquipmentType] ([ID])
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD FOREIGN KEY([IDImage])
REFERENCES [dbo].[Image] ([ID])
GO
ALTER TABLE [dbo].[EquipmentStructure]  WITH CHECK ADD FOREIGN KEY([IDComponent])
REFERENCES [dbo].[Components] ([ID])
GO
ALTER TABLE [dbo].[EquipmentStructure]  WITH CHECK ADD FOREIGN KEY([IDEquipment])
REFERENCES [dbo].[Equipment] ([ID])
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([IDCountry])
REFERENCES [dbo].[Country] ([ID])
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([IDImage])
REFERENCES [dbo].[Image] ([ID])
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([IDTypeLocation])
REFERENCES [dbo].[LocationType] ([ID])
GO
ALTER TABLE [dbo].[Potion]  WITH CHECK ADD FOREIGN KEY([IDImage])
REFERENCES [dbo].[Image] ([ID])
GO
ALTER TABLE [dbo].[Potion]  WITH CHECK ADD FOREIGN KEY([IDPotionType])
REFERENCES [dbo].[Potion] ([ID])
GO
ALTER TABLE [dbo].[Potion]  WITH CHECK ADD FOREIGN KEY([IDPotionType])
REFERENCES [dbo].[PotionType] ([ID])
GO
ALTER TABLE [dbo].[PotionStructure]  WITH CHECK ADD FOREIGN KEY([IDIngredient])
REFERENCES [dbo].[Ingredient] ([ID])
GO
ALTER TABLE [dbo].[PotionStructure]  WITH CHECK ADD FOREIGN KEY([IDPotion])
REFERENCES [dbo].[Potion] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 27.05.2021 18:49:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
USE [master]
GO
ALTER DATABASE [WitcherDB] SET  READ_WRITE 
GO
