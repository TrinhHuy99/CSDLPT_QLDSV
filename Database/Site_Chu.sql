USE [QLDSV]
GO
/****** Object:  User [HTKN]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE USER [HTKN] FOR LOGIN [HTKN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [SON]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE USER [SON] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [MSmerge_3228A83326154FA59D7EBDAD0718083B]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE ROLE [MSmerge_3228A83326154FA59D7EBDAD0718083B]
GO
/****** Object:  DatabaseRole [MSmerge_39D2E74B02E04E948B92B0E6A526F12D]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE ROLE [MSmerge_39D2E74B02E04E948B92B0E6A526F12D]
GO
/****** Object:  DatabaseRole [MSmerge_AAAFAD94430E4A8A955C9175CDB2B76D]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE ROLE [MSmerge_AAAFAD94430E4A8A955C9175CDB2B76D]
GO
/****** Object:  DatabaseRole [MSmerge_PAL_role]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE ROLE [MSmerge_PAL_role]
GO
ALTER ROLE [db_owner] ADD MEMBER [HTKN]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_3228A83326154FA59D7EBDAD0718083B]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_39D2E74B02E04E948B92B0E6A526F12D]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_AAAFAD94430E4A8A955C9175CDB2B76D]
GO
/****** Object:  Schema [MSmerge_PAL_role]    Script Date: 12/23/2020 7:08:11 PM ******/
CREATE SCHEMA [MSmerge_PAL_role]
GO
/****** Object:  Table [dbo].[CT_DONGHOCPHI]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CT_DONGHOCPHI](
	[MASV] [char](12) NOT NULL,
	[NIENKHOA] [nvarchar](50) NOT NULL,
	[HOCKY] [int] NOT NULL,
	[NGAYDONG] [date] NOT NULL,
	[SOTIENDONG] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_9D53F3A77BEC4A47A3B3DAA3135D0C4A]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_CT_DONGHOCPHI] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[NIENKHOA] ASC,
	[HOCKY] ASC,
	[NGAYDONG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DIEM]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DIEM](
	[MASV] [char](12) NOT NULL,
	[MAMH] [char](6) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[DIEM] [float] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_B8CC71A114E148EEB52AB56F4E3FCAD3]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_DIEM] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[MAMH] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GIANGVIEN]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GIANGVIEN](
	[MAGV] [nchar](10) NOT NULL,
	[HO] [nvarchar](50) NOT NULL,
	[TEN] [nvarchar](10) NOT NULL,
	[MAKH] [char](4) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_D8DB2DBF1A4C4ACF8C3B71896FEA192D]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIANGVIEN] PRIMARY KEY CLUSTERED 
(
	[MAGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HOCPHI]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HOCPHI](
	[MASV] [char](12) NOT NULL,
	[NIENKHOA] [nvarchar](50) NOT NULL,
	[HOCKY] [int] NOT NULL CONSTRAINT [DF_HOCPHI_HOCKY]  DEFAULT ((1)),
	[HOCPHI] [int] NOT NULL CONSTRAINT [DF_HOCPHI_HOCPHI]  DEFAULT ((6000000)),
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_1BF37DD49C8A482FA2B949BB93D00DF6]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_HOCPHI] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[NIENKHOA] ASC,
	[HOCKY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KHOA]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KHOA](
	[MAKH] [char](4) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_F294EF4641BE4D6A88717C7521923F8C]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_KHOA] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LOP]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOP](
	[MALOP] [char](8) NOT NULL,
	[TENLOP] [nvarchar](200) NULL,
	[MAKH] [char](4) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_64BB20C6FBDE4525993B85B4E15D1221]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MAMH] [char](6) NOT NULL,
	[TENMH] [nvarchar](40) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_CA02D4450AC3474F83672F15E7E9D54F]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_MONHOC] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MASV] [char](12) NOT NULL,
	[HO] [nvarchar](40) NULL,
	[TEN] [nvarchar](10) NULL,
	[MALOP] [char](8) NOT NULL,
	[PHAI] [bit] NULL,
	[NGAYSINH] [datetime] NULL,
	[NOISINH] [nvarchar](40) NULL,
	[DIACHI] [nvarchar](80) NULL,
	[GHICHU] [ntext] NULL,
	[NGHIHOC] [bit] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_41A3BB89542F45B08F973E444FD344C2]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[V_DSPM]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DSPM]
AS
SELECT        PUBS.description AS TENKHOA, SUBS.subscriber_server AS TENSERVER
FROM            dbo.sysmergepublications AS PUBS INNER JOIN
                         dbo.sysmergesubscriptions AS SUBS ON PUBS.pubid = SUBS.pubid AND PUBS.publisher <> SUBS.subscriber_server

GO
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 1, CAST(N'2008-03-26' AS Date), 6000000, N'fb1d9d74-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 1, CAST(N'2008-03-27' AS Date), 1000000, N'253a3531-1041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 2, CAST(N'2009-04-23' AS Date), 9000000, N'b810eebe-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 1, CAST(N'2008-03-26' AS Date), 6000000, N'500ba7d8-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, CAST(N'2008-04-23' AS Date), 5000000, N'83b75c43-0141-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, CAST(N'2020-12-22' AS Date), 1000000, N'87023aa3-6344-eb11-a42f-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, CAST(N'2020-12-23' AS Date), 1000000, N'48ced7a6-e244-eb11-a430-80000bc8ea9c')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'N17DCCN059  ', N'2008-2009', 1, CAST(N'2008-03-26' AS Date), 5000000, N'c15a5204-1141-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'N17DCCN059  ', N'2008-2009', 1, CAST(N'2008-03-27' AS Date), 4000000, N'96da362c-1141-eb11-a42d-f01faf5aed44')
INSERT [dbo].[DIEM] ([MASV], [MAMH], [LAN], [DIEM], [rowguid]) VALUES (N'09THA101    ', N'CTDL  ', 1, 10, N'890eb3f0-e044-eb11-a430-80000bc8ea9c')
INSERT [dbo].[DIEM] ([MASV], [MAMH], [LAN], [DIEM], [rowguid]) VALUES (N'09THA101    ', N'CTDL  ', 2, 7, N'837d73fb-e044-eb11-a430-80000bc8ea9c')
INSERT [dbo].[DIEM] ([MASV], [MAMH], [LAN], [DIEM], [rowguid]) VALUES (N'17DCCN059   ', N'CTDL  ', 1, 4, N'8a0eb3f0-e044-eb11-a430-80000bc8ea9c')
INSERT [dbo].[DIEM] ([MASV], [MAMH], [LAN], [DIEM], [rowguid]) VALUES (N'17DCCN059   ', N'CTDL  ', 2, 7, N'847d73fb-e044-eb11-a430-80000bc8ea9c')
INSERT [dbo].[DIEM] ([MASV], [MAMH], [LAN], [DIEM], [rowguid]) VALUES (N'N15DCCN001  ', N'CTDL  ', 1, 5, N'8b0eb3f0-e044-eb11-a430-80000bc8ea9c')
INSERT [dbo].[DIEM] ([MASV], [MAMH], [LAN], [DIEM], [rowguid]) VALUES (N'N15DCCN002  ', N'CTDL  ', 1, 6, N'8c0eb3f0-e044-eb11-a430-80000bc8ea9c')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV01      ', N'NGUYEN HONG', N'SON       ', N'CNTT', N'f741b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV02      ', N'TRUONG DINH', N'HUY       ', N'CNTT', N'f841b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV03      ', N'NGUYEN XUAN', N'KHANH     ', N'VT  ', N'f941b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV04      ', N'TRAN DINH', N'THUAN     ', N'VT  ', N'fa41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV05      ', N'TRAN DINH', N'TRONG', N'CNTT', N'06f52b16-bb33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV06      ', N'TRUONG TAM', N'PHONG', N'VT  ', N'2b558021-bb33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV07      ', N'LE THANH', N'TAM', N'CNTT', N'fba8c094-bd33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV08      ', N'TRINH HOAI', N'BAO', N'VT  ', N'aec2139c-bd33-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV09      ', N'TRUONG VAN', N'HUY', N'CNTT', N'f47dab1d-f533-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV10      ', N'TRINH HUY', N'HUNG', N'VT  ', N'a481bd8c-9f34-eb11-a423-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV11      ', N'nguyễn văn', N'a', N'CNTT', N'98f405ac-7a44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV12      ', N'TRỊNH THÀNH', N'NAM', N'VT  ', N'ae5536b5-7a44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV13      ', N'TRƯƠNG ', N'KHẢI', N'CNTT', N'3198cdbd-7a44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[GIANGVIEN] ([MAGV], [HO], [TEN], [MAKH], [rowguid]) VALUES (N'GV14      ', N'HÀ ', N'HÙNG', N'VT  ', N'302453c4-7a44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY], [HOCPHI], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 1, 7000000, N'74b8fa2a-c336-eb11-a425-f01faf5aed44')
INSERT [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY], [HOCPHI], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 2, 9000000, N'343cc796-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY], [HOCPHI], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 1, 6000000, N'99f980b7-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY], [HOCPHI], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, 10000000, N'b710eebe-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY], [HOCPHI], [rowguid]) VALUES (N'N17DCCN059  ', N'2008-2009', 1, 10000000, N'878923e8-1041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [rowguid]) VALUES (N'CNTT', N'Công nghệ thông tin', N'ed41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [rowguid]) VALUES (N'VT  ', N'Viễn thông', N'ee41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'CQCN01  ', N'Lớp công nghệ 1', N'CNTT', N'fc41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D09VTA1 ', N'ĐẠI HỌC CHÍNH QUY KHÓA 2009', N'VT  ', N'ff41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D15VT   ', N'ĐẠI HỌC CHÍNH QUY KHÓA 2015', N'VT  ', N'655753c7-ba36-eb11-a425-f01faf5aed44')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D19VT   ', N'ĐẠI HỌC CHÍNH QUY KHÓA 2019', N'VT  ', N'fe41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'DHCQ2018', N'ĐẠI HỌC CHÍNH QUY KHÓA 2018', N'CNTT', N'fd41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'DHCQ2020', N'ĐẠI HỌC CHÍNH QUY KHÓA 2020', N'CNTT', N'0a0f4fc3-403a-eb11-a426-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CSDL  ', N'Co so du lieu', N'f041b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CSDLPT', N'Co so du lieu phan tan', N'f141b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CTDL  ', N'Cấu trúc dữ liệu', N'ef41b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'LTCB  ', N'Lap trinh can ban', N'f341b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'THCS1 ', N'Tin hoc co so 1', N'f441b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'THDC  ', N'Tin học đại cương', N'f541b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'TRR1  ', N'TOÁN RỜI RẠC', N'bb0bced6-6944-eb11-a42f-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'TRR2  ', N'TOÁN RỜI RẠC 2', N'3bded00b-6a44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'VB    ', N'Lập trình Visual Basic nang cao', N'f241b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'08VTA101    ', N'Nguyễn Thanh', N'Hằng', N'D19VT   ', 1, CAST(N'1975-12-07 00:00:00.000' AS DateTime), N'Hà nội', N'11 Lê Văn Sỹ', N'', 0, N'0042b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'09THA101    ', N'Le Thi', N'Van', N'DHCQ2018', 1, CAST(N'1976-06-06 00:00:00.000' AS DateTime), N'Hà nội', N'Ngô Quyền', N' ', 0, N'0242b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'09THA102    ', N'Trần Thi', N'Hoa', N'DHCQ2020', 0, CAST(N'1976-07-07 00:00:00.000' AS DateTime), N'Sài gòn', N'222 Lý Thái Tổ', N' ', 0, N'0342b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'09THA103    ', N'Nguyễn Thị Yến', N'Lan', N'CQCN01  ', 0, CAST(N'1976-08-08 00:00:00.000' AS DateTime), N'Khánh Hòa', N'333 HHT, BT', NULL, 0, N'0442b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'09THA104    ', N'Trần thị', N'Hồng', N'CQCN01  ', 0, CAST(N'1999-02-03 00:00:00.000' AS DateTime), N'hcm', N'hcm', NULL, 0, N'1f78f73f-7b44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'09THA105    ', N'NGUYỄN ', N'HẢI', N'CQCN01  ', 1, CAST(N'1999-12-02 00:00:00.000' AS DateTime), N'BÌNH ĐÌNH', N'QUY NHƠN', NULL, 0, N'59c51d6c-7b44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'09VT05      ', N'TRƯƠNG', N'THỦY', N'D09VTA1 ', 0, CAST(N'1998-03-04 00:00:00.000' AS DateTime), N'ĐÀ NẴNG', N'112/22', NULL, 0, N'c3e24ab2-7b44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'17DCCN059   ', N'TRINH', N'HUY', N'DHCQ2018', 1, CAST(N'2020-12-27 00:00:00.000' AS DateTime), N'KHANH HOA', N'NINH HOA', NULL, 0, N'c1ae74db-403a-eb11-a426-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'20CN01      ', N'TRỊNH', N'KHẢI', N'DHCQ2020', 1, CAST(N'1999-01-01 00:00:00.000' AS DateTime), N'KHÁNH HÒA', N'NHA TRANG', NULL, 0, N'5569a68c-7b44-eb11-a42f-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'N15DCCN001  ', N'Tran Nguyen', N'Minh', N'DHCQ2018', 1, CAST(N'1995-06-19 00:00:00.000' AS DateTime), N'PHU TAN', N'22 Cà Mau', N' ', 0, N'0542b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'N15DCCN002  ', N'Nguyen Hoang', N'An', N'DHCQ2018', 1, CAST(N'1995-06-06 00:00:00.000' AS DateTime), N'PHU YEN', N'HA NOI', NULL, 0, N'0642b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'N15VT013    ', N'Lê Thị', N'Hào', N'D15VT   ', 0, CAST(N'1995-02-19 00:00:00.000' AS DateTime), N'Phú yên', N'CAN THO', N' ', 0, N'0742b5de-2c33-eb11-a423-f01faf5aed44')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [MALOP], [PHAI], [NGAYSINH], [NOISINH], [DIACHI], [GHICHU], [NGHIHOC], [rowguid]) VALUES (N'N17DCCN059  ', N'trịnh đức', N'huy', N'D15VT   ', 1, CAST(N'1999-03-26 00:00:00.000' AS DateTime), N'KHÁNH HÒA', N'NINH HÒA', NULL, 0, N'ea1eedc3-1041-eb11-a42d-f01faf5aed44')
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_TENLOP]    Script Date: 12/23/2020 7:08:11 PM ******/
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [UK_TENLOP] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_MONHOC]    Script Date: 12/23/2020 7:08:11 PM ******/
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [IX_MONHOC] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CT_DONGHOCPHI]  WITH CHECK ADD  CONSTRAINT [FK_CT_DONGHOCPHI_HOCPHI] FOREIGN KEY([MASV], [NIENKHOA], [HOCKY])
REFERENCES [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY])
GO
ALTER TABLE [dbo].[CT_DONGHOCPHI] CHECK CONSTRAINT [FK_CT_DONGHOCPHI_HOCPHI]
GO
ALTER TABLE [dbo].[DIEM]  WITH CHECK ADD  CONSTRAINT [FK_DIEM_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[DIEM] CHECK CONSTRAINT [FK_DIEM_MONHOC]
GO
ALTER TABLE [dbo].[DIEM]  WITH CHECK ADD  CONSTRAINT [FK_DIEM_SINHVIEN] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
GO
ALTER TABLE [dbo].[DIEM] CHECK CONSTRAINT [FK_DIEM_SINHVIEN]
GO
ALTER TABLE [dbo].[GIANGVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIANGVIEN_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIANGVIEN] CHECK CONSTRAINT [FK_GIANGVIEN_KHOA]
GO
ALTER TABLE [dbo].[HOCPHI]  WITH CHECK ADD  CONSTRAINT [FK_HOCPHI_SINHVIEN] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
GO
ALTER TABLE [dbo].[HOCPHI] CHECK CONSTRAINT [FK_HOCPHI_SINHVIEN]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOA1] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOA1]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_LOP]
GO
ALTER TABLE [dbo].[DIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM_DIEM] CHECK  (([DIEM]>=(0) AND [DIEM]<=(10)))
GO
ALTER TABLE [dbo].[DIEM] CHECK CONSTRAINT [CK_DIEM_DIEM]
GO
ALTER TABLE [dbo].[DIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM_LAN] CHECK  (([LAN]=(1) OR [LAN]=(2)))
GO
ALTER TABLE [dbo].[DIEM] CHECK CONSTRAINT [CK_DIEM_LAN]
GO
/****** Object:  StoredProcedure [dbo].[SP_BangHP]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_BangHP]
@MASV CHAR(12)
AS
BEGIN
	IF EXISTS(SELECT MASV FROM dbo.HOCPHI WHERE MASV = @MASV)
		BEGIN
			SELECT HP.NIENKHOA,HP.HOCKY,HOCPHI,ISNULL(TIENDADONG,0) AS TIENDADONG,SOTIENDONG=0	
			FROM (SELECT SUM(SOTIENDONG) AS TIENDADONG,NIENKHOA,HOCKY,MASV FROM dbo.CT_DONGHOCPHI CT WHERE MASV = @MASV GROUP																					BY CT.MASV,CT.NIENKHOA,CT.HOCKY) AS CTHP
			RIGHT OUTER JOIN  (SELECT * FROM dbo.HOCPHI WHERE MASV = @MASV) HP 
			ON HP.NIENKHOA = CTHP.NIENKHOA AND HP.HOCKY = CTHP.HOCKY AND HP.MASV = CTHP.MASV
		END
	ELSE
		BEGIN
			RAISERROR('Sinh viên chưa có thông tin đóng học phí',16,1)
			RETURN 0
		END
			    
END

GO
/****** Object:  StoredProcedure [dbo].[SP_BangNhapDiem]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_BangNhapDiem]
@MALOP NCHAR(8),@MAMH NCHAR(5),@LANTHI SMALLINT
AS
BEGIN
	IF EXISTS (SELECT MASV FROM dbo.SINHVIEN WHERE MALOP = @MALOP)
		BEGIN
			IF (@LANTHI = 1)
				BEGIN
					IF EXISTS (SELECT MASV FROM dbo.DIEM WHERE MASV IN (SELECT MASV FROM dbo.SINHVIEN WHERE MALOP=@MALOP) AND LAN = 1 AND MAMH=@MAMH)
						BEGIN	
							
							SELECT d.MASV,sv.HO + ' ' +sv.TEN AS HOTEN,d.DIEM FROM DIEM d,SINHVIEN sv
							WHERE d.MASV=sv.MASV AND d.LAN=@LANTHI AND d.MAMH=@MAMH AND sv.NGHIHOC='false' AND sv.MALOP=@MALOP
							ORDER BY d.MASV		
						END
					ELSE
						BEGIN
							SELECT MASV,HO + ' ' +TEN AS HOTEN, DIEM = 0 FROM SINHVIEN WHERE MALOP=@MALOP AND NGHIHOC='false'
						END
				END
			IF (@LANTHI = 2)
				BEGIN
					IF NOT EXISTS(SELECT MASV FROM DIEM WHERE MASV IN (SELECT MASV FROM SINHVIEN WHERE MALOP=@MALOP) AND LAN=1 AND DIEM.MAMH=@MAMH)
						 BEGIN
								RAISERROR('Hãy nhập điểm thi lần 1 trước.',16,1)
								RETURN;
						 END
					ELSE IF EXISTS(SELECT MASV FROM DIEM WHERE MASV IN (SELECT MASV FROM SINHVIEN WHERE MALOP=@MALOP) AND LAN=2 AND DIEM.MAMH=@MAMH)
						 BEGIN
								
								SELECT d.MASV,HO + ' ' +TEN AS HOTEN,DIEM FROM DIEM d,SINHVIEN sv
								WHERE d.MASV=sv.MASV AND d.LAN=@LANTHI AND d.MAMH=@MAMH AND sv.NGHIHOC='false' AND sv.MALOP=@MALOP
								ORDER BY d.MASV
						 END
					ELSE
						 BEGIN
								SELECT MASV,HO + ' ' +TEN AS HOTEN, DIEM = 0 FROM  SINHVIEN WHERE MALOP=@MALOP AND NGHIHOC='false' AND MASV IN(SELECT MASV FROM DIEM WHERE MAMH = @MAMH AND LAN = 1 AND DIEM < 5) 
						 END
				END 
		END
	ELSE 
		BEGIN
			RAISERROR('Lớp hiện tại chưa có sinh viên theo học.',16,1)
			RETURN;
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKID]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHECKID] @Code NVARCHAR(15),
@Type NVARCHAR(15)
AS
BEGIN
	-- LOP
	IF(@Type = 'MALOP')
	BEGIN
		
		IF EXISTS(SELECT * FROM dbo.LOP WHERE dbo.LOP.MALOP = @Code)
			RETURN 1; -- Mã tồn tại ở phân mãnh hiện tại
	
		ELSE IF EXISTS(SELECT * FROM LINK0.QLDSV.dbo.LOP AS LOP WHERE LOP.MALOP = @Code)
			RETURN 2;	--Mã NV tồn tại ở phân mãnh  khác
	END

	--MON Hoc
	IF(@Type = 'MAMONHOC')
	BEGIN
		IF EXISTS(SELECT * FROM dbo.MONHOC WHERE MAMH = @Code)
		RETURN 1;
	END
	
	


		IF(@Type = 'MASV')
	BEGIN
		
		IF EXISTS(SELECT * FROM dbo.SINHVIEN WHERE dbo.SINHVIEN.MASV = @Code)
			RETURN 1; -- Mã tồn tại ở phân mãnh hiện tại
	
		ELSE IF EXISTS(SELECT * FROM LINK0.QLDSV.dbo.SINHVIEN AS SV WHERE SV.MASV = @Code)
			RETURN 2;	--Mã NV tồn tại ở phân mãnh  khác
	END

	RETURN 0	--Không bị trùng được thêm
END




GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKIDHOCPHI]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHECKIDHOCPHI] @masv NVARCHAR(10), @nienkhoa NVARCHAR(14), @hoky SMALLINT

AS
BEGIN
	
	IF EXISTS (SELECT * FROM dbo.HOCPHI WHERE MASV = @masv AND NIENKHOA = @nienkhoa AND HOCKY = @hoky)
		RETURN 1 -- mã tồn tại
	RETURN 0	-- mã không tồn tại.
END





GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKIDHOCPHIBYMASV]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHECKIDHOCPHIBYMASV] @masv NVARCHAR(10)
AS
BEGIN
  
  IF EXISTS (SELECT * FROM LINK1.QLDSV.dbo.HOCPHI WHERE MASV = @masv )
    RETURN 1 -- mã tồn tại
  RETURN 0  -- mã không tồn tại.
END



GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKMALOPTHEOSINHVIEN]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHECKMALOPTHEOSINHVIEN] 
@MALOP CHAR(8)
AS
BEGIN
IF EXISTS(SELECT * FROM dbo.SINHVIEN WHERE dbo.SINHVIEN.MALOP = @MALOP)
			RETURN
			ELSE RAISERROR('MÃ LỚP KHÔNG TỒN TẠI HOẶC KHÔNG CÓ SINH VIÊN!!',16,1)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKNAME]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHECKNAME]
@Name NVARCHAR(50),
@Type NVARCHAR(15)
AS
BEGIN
	--Kiểm tra Table lop của server hiện tại
	IF(@Type = 'TENLOP')
	BEGIN
		IF EXISTS(SELECT * FROM dbo.LOP WHERE dbo.LOP.TENLOP = @Name)
			RETURN 1; -- @name bị trùng  ở phân mãnh hiện tại
	
		ELSE IF EXISTS(SELECT * FROM LINK0.QLDSV.dbo.LOP AS LOP WHERE LOP.TENLOP = @Name)
			RETURN 2;	--@name bị trùng ở phân mãnh  khác
	END

	IF(@Type = 'TENMONHOC')
	BEGIN
		IF EXISTS(SELECT * FROM dbo.MONHOC WHERE TENMH = @Name)
		RETURN 1;
	END
	
	RETURN 0	--Không bị trùng ,được thêm
END



GO
/****** Object:  StoredProcedure [dbo].[SP_CHUYENLOP]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHUYENLOP]
@MASV NVARCHAR(12),-- de update status thanh nghi hoc
@MASVMOI NVARCHAR(12), -- de insert vao khoa moi
@MALOPCHUYENDEN NVARCHAR(12) -- ma lop moi se chuyen den
AS
BEGIN

	SET XACT_ABORT ON
	BEGIN TRY
		BEGIN DISTRIBUTED TRANSACTION
		
		INSERT INTO LINK0.QLDSV.dbo.SINHVIEN (MASV,HO,TEN,MALOP,PHAI,NGAYSINH,NOISINH,DIACHI,GHICHU,NGHIHOC)
		SELECT @MASVMOI AS MASV,HO,TEN,@MALOPCHUYENDEN AS MALOP,PHAI,NGAYSINH,NOISINH,DIACHI,GHICHU,0 FROM dbo.SINHVIEN WHERE MASV = @MASV

		UPDATE dbo.SINHVIEN SET NGHIHOC=1 WHERE MASV = @MASV;-- Cap nhap trang thai nghi hoc cua sinh vien o site hien tai

		IF(@@TRANCOUNT > 0)
		BEGIN
			PRINT 'Commit Success'
			COMMIT TRANSACTION
			RETURN 0	--Thành công
		END
	END TRY

	BEGIN CATCH
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Commit Fail'
			RETURN -1;
		END
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DANGNHAP]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DANGNHAP]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT USERNAME = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM GIANGVIEN  WHERE MAGV = @TENUSER ),
   ROLENAME=NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))
GO
/****** Object:  StoredProcedure [dbo].[SP_DongHocPHi]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DongHocPHi]
@MASV NCHAR(12),
@NIENKHOA NVARCHAR(12),
@HOCKY INT,

@SOTIENDADONG INT
AS
BEGIN		
	IF EXISTS(SELECT 1 FROM dbo.CT_DONGHOCPHI WHERE MASV = @MASV AND HOCKY = @HOCKY AND NGAYDONG = GETDATE())
		BEGIN
			RAISERROR('Hôm nay đã đóng học phí !!!!',16,1)
			RETURN
		END
	ELSE
		BEGIN
			INSERT INTO CT_DONGHOCPHI(MASV, NIENKHOA,HOCKY,NGAYDONG,SOTIENDONG)
			VALUES (@MASV,@NIENKHOA,@HOCKY,GETDATE(),@SOTIENDADONG)
		 END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INDANHSACHHOCPHI]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\Huy\AppData\Local\Temp\~vs3ADC.sql
CREATE PROC [dbo].[SP_INDANHSACHHOCPHI]
@MALOP NVARCHAR(9),@NIENKHOA NVARCHAR(50),@HOCKY INT
AS
BEGIN
	SELECT HS.MASV,(HS.HO+' '+HS.TEN) AS TEN,HS.HOCPHI,ISNULL(CT.SOTIENDADONG,0) AS SOTIENDADONG
	FROM( 
	
		( SELECT HC.MASV,SV.HO,SV.TEN,HC.NIENKHOA,HC.HOCKY,HC.HOCPHI
		 FROM (SELECT * FROM HOCPHI WHERE NIENKHOA =@NIENKHOA AND HOCKY =@HOCKY )AS HC,(SELECT MASV, HO,TEN FROM SINHVIEN WHERE MALOP =@MALOP) AS SV
		 WHERE HC.MASV = SV.MASV ) AS HS
		 left join (
			SELECT MASV,HOCKY,NIENKHOA,SUM(SOTIENDONG) AS SOTIENDADONG
			FROM CT_DONGHOCPHI 
			WHERE HOCKY =@HOCKY AND NIENKHOA = @NIENKHOA
			GROUP BY MASV,HOCKY,NIENKHOA
			) AS CT
		 ON CT.MASV = HS.MASV AND CT.NIENKHOA = HS.NIENKHOA AND CT.HOCKY = HS.HOCKY
	)

END

GO
/****** Object:  StoredProcedure [dbo].[SP_R_BDMH]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_R_BDMH]
@MALOP NCHAR(8),
@MAMH NCHAR(6),
@LAN  INT
AS
BEGIN
	SELECT d.MASV,HO+' '+TEN AS HOTEN, d.DIEM
	FROM (SELECT MASV,DIEM FROM DIEM WHERE MASV IN (SELECT MASV FROM SINHVIEN WHERE MALOP=@MALOP) AND LAN=@LAN AND DIEM.MAMH=@MAMH) d,			SINHVIEN sv
	WHERE d.MASV=sv.MASV AND sv.NGHIHOC='false'
	ORDER BY MASV ASC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_REPORT_BDMH]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_REPORT_BDMH](@MALOP NVARCHAR(15), @MAMONHOC NVARCHAR(15),@LAN INT)
AS
BEGIN
  IF EXISTS (SELECT 1 FROM dbo.SINHVIEN AS SV WHERE SV.MALOP = @MALOP)
    BEGIN
      SELECT SV.MASV ,SV.HO +' '+ SV.TEN AS HOTEN INTO #A FROM dbo.SINHVIEN AS SV WHERE SV.MALOP = @MALOP AND SV.NGHIHOC = 'false';
      SELECT D.MASV, D.MAMH, D.LAN, D.DIEM  INTO #B FROM dbo.DIEM AS D WHERE D.MAMH = @MAMONHOC AND D.LAN = @LAN;
      SELECT * FROM #A INNER JOIN #B ON #B.MASV = #A.MASV ORDER BY HOTEN
    END
  ELSE RETURN 1;
END


GO
/****** Object:  StoredProcedure [dbo].[SP_REPORT_DSSV]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_REPORT_DSSV](@MALOP CHAR(15))
AS
BEGIN
	SELECT SV.HO AS HO, SV.TEN AS TEN,
	CASE
		WHEN SV.PHAI = 1 THEN 'Nam'
		WHEN SV.PHAI = 0 THEN 'Nu'
	END AS PHAI,
	 CONVERT(VARCHAR(12),SV.NGAYSINH,106) AS NGAYSINH, SV.NOISINH, SV.DIACHI FROM dbo.SINHVIEN AS SV WHERE SV.MALOP = @MALOP AND SV.NGHIHOC='false';
END

--CONVERT CHUYỂN SANG MỘT KIỂU DỮ LIỆU MONG MUỐN NHƯNG THEO MỘT ĐỊNH DẠNG
--CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
GO
/****** Object:  StoredProcedure [dbo].[SP_TAOLOGIN]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TAOLOGIN]
  @LGNAME VARCHAR(50),
  @PASS VARCHAR(50),
  @USERNAME VARCHAR(50),
  @ROLE VARCHAR(50)
AS

	-- check login , user bị trùng 
	IF EXISTS(SELECT name FROM sys.server_principals --name:duy nhất trong server
				WHERE TYPE IN ('U', 'S', 'G')	--U: Windows Login Accounts
				AND name NOT LIKE '%##%'		--S: SQL Login Accounts
				AND name = @LGNAME)				--G: Windows Group Login Accounts
		RETURN 1	--Trùng Login
	ELSE IF EXISTS(SELECT name FROM sys.database_principals --name:duy nhất trong cơ sở dữ liệu
					WHERE type_desc = 'SQL_USER'
					AND name = @USERNAME)
		RETURN 2	--Trùng User

	-- băt đầu tạo tài khoản
  DECLARE @RET INT
  EXEC @RET= SP_ADDLOGIN @LGNAME, @PASS,'QLDSV' --tạo thông tin đăng nhập
  IF (@RET =1) 
     RETURN 3 -- tạo tài khoản không thành công
 
  EXEC @RET= SP_GRANTDBACCESS @LGNAME, @USERNAME --tạo thông tin username
  IF (@RET =1) 
  BEGIN
       EXEC SP_DROPLOGIN @LGNAME --xóa thông tin đăng nhập
       RETURN 3 -- tạo  tài khoảng không thành công
  END
  EXEC sp_addrolemember @ROLE, @USERNAME

  --THEM ROLE SECURITYADMIN DE CO QUYEN TAO TAI KHOAN
  EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'

  RETURN 0  -- THANH CONG


  --Xóa login SP_DROPLOGIN @USERNAME
  --Xóa user SP_DROPUSER @LOGIN

GO
/****** Object:  StoredProcedure [dbo].[SP_ThemDiem]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ThemDiem]
@MASV CHAR(12),@MAMH CHAR(6),@LAN SMALLINT,@DIEM FLOAT
AS
BEGIN
	IF EXISTS(SELECT MASV FROM dbo.DIEM WHERE MAMH = @MAMH AND LAN =@LAN AND MASV = @MASV)
		BEGIN
			UPDATE DIEM SET DIEM = @DIEM WHERE MAMH = @MAMH AND LAN =@LAN AND MASV = @MASV
			--RAISERROR('SỬA THÀNH CÔNG'
			RETURN 0
		END
	ELSE 
		BEGIN
			INSERT INTO dbo.DIEM(MASV,MAMH,LAN,DIEM)			       
			VALUES (@MASV,@MAMH,@LAN,@DIEM)
			RETURN 1
		END
	RETURN -1;
END

GO
/****** Object:  StoredProcedure [dbo].[SPRP_BangDiemThi]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SPRP_BangDiemThi]
@MALOP CHAR(8)
AS
BEGIN
	--IF EXISTS(SELECT 1 FROM dbo.SINHVIEN WHERE MALOP = @MALOP)
		SELECT MASV,HO + ' ' + TEN AS HOTEN,DIEM = '' FROM dbo.SINHVIEN SV WHERE SV.MALOP = @MALOP AND SV.NGHIHOC = 'false' ORDER BY SV.MASV
	--ELSE RAISERROR('Lớp chưa có sinh viên theo học',16,1) 
END

GO
/****** Object:  StoredProcedure [dbo].[SPRP_BDTK]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SPRP_BDTK]
@MALOP CHAR(8)
AS
BEGIN
	SELECT D.MASV + '_' + SV.HO + ' ' + SV.TEN AS MAHOTEN,MH.TENMH,D.DIEM FROM dbo.SINHVIEN SV,(SELECT MASV,MAMH,MAX(DIEM) AS DIEM FROM DIEM GROUP BY MASV,MAMH) D,dbo.MONHOC MH
	WHERE SV.MALOP = @MALOP AND D.MASV = SV.MASV AND SV.NGHIHOC = 'false' AND D.MAMH = MH.MAMH 
END

GO
/****** Object:  StoredProcedure [dbo].[SPRP_PhieuDiem]    Script Date: 12/23/2020 7:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SPRP_PhieuDiem]
@MASV CHAR(12)
AS
BEGIN
	SELECT  TENMH,D.DIEM AS DIEM 
	FROM dbo.MONHOC MH,(SELECT MASV,MAMH,MAX(DIEM) AS DIEM FROM DIEM WHERE MASV = @MASV GROUP BY MASV,MAMH) AS D
	WHERE D.MAMH = MH.MAMH ORDER BY MH.TENMH ASC
END

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
         Begin Table = "PUBS"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SUBS"
            Begin Extent = 
               Top = 6
               Left = 360
               Bottom = 136
               Right = 610
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DSPM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DSPM'
GO
