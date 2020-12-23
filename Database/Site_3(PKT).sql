USE [QLDSV]
GO
/****** Object:  User [GV02]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [GV02] FOR LOGIN [pkt1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [GV03      ]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [GV03      ] FOR LOGIN [pkt6] WITH DEFAULT_SCHEMA=[GV03      ]
GO
/****** Object:  User [GV04]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [GV04] FOR LOGIN [pkt3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [GV05      ]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [GV05      ] FOR LOGIN [pkt5] WITH DEFAULT_SCHEMA=[GV05      ]
GO
/****** Object:  User [GV07]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [GV07] FOR LOGIN [pkt2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [GV08]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [GV08] FOR LOGIN [pkt4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [HTKN]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE USER [HTKN] FOR LOGIN [HTKN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [KHOA]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE ROLE [KHOA]
GO
/****** Object:  DatabaseRole [PGV]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE ROLE [PGV]
GO
/****** Object:  DatabaseRole [PKETOAN]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE ROLE [PKETOAN]
GO
/****** Object:  DatabaseRole [USER]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE ROLE [USER]
GO
ALTER ROLE [PKETOAN] ADD MEMBER [GV02]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV02]
GO
ALTER ROLE [KHOA] ADD MEMBER [GV03      ]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV03      ]
GO
ALTER ROLE [PKETOAN] ADD MEMBER [GV04]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV04]
GO
ALTER ROLE [PKETOAN] ADD MEMBER [GV05      ]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV05      ]
GO
ALTER ROLE [PKETOAN] ADD MEMBER [GV07]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV07]
GO
ALTER ROLE [PKETOAN] ADD MEMBER [GV08]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV08]
GO
ALTER ROLE [db_owner] ADD MEMBER [HTKN]
GO
ALTER ROLE [db_owner] ADD MEMBER [KHOA]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [PGV]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [PGV]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PGV]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PGV]
GO
ALTER ROLE [db_owner] ADD MEMBER [PKETOAN]
GO
ALTER ROLE [db_owner] ADD MEMBER [USER]
GO
/****** Object:  Schema [GV03      ]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE SCHEMA [GV03      ]
GO
/****** Object:  Schema [GV05      ]    Script Date: 12/23/2020 7:09:51 PM ******/
CREATE SCHEMA [GV05      ]
GO
/****** Object:  Table [dbo].[CT_DONGHOCPHI]    Script Date: 12/23/2020 7:09:51 PM ******/
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
/****** Object:  Table [dbo].[GIANGVIEN]    Script Date: 12/23/2020 7:09:51 PM ******/
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
/****** Object:  Table [dbo].[HOCPHI]    Script Date: 12/23/2020 7:09:51 PM ******/
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
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 12/23/2020 7:09:51 PM ******/
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
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 1, CAST(N'2008-03-26' AS Date), 6000000, N'fb1d9d74-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 1, CAST(N'2008-03-27' AS Date), 1000000, N'253a3531-1041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'08VTA101    ', N'2008-2009', 2, CAST(N'2009-04-23' AS Date), 9000000, N'b810eebe-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 1, CAST(N'2008-03-26' AS Date), 6000000, N'500ba7d8-0041-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, CAST(N'2008-04-23' AS Date), 5000000, N'83b75c43-0141-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, CAST(N'2020-12-22' AS Date), 1000000, N'87023aa3-6344-eb11-a42f-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'09THA101    ', N'2008-2009', 2, CAST(N'2020-12-23' AS Date), 1000000, N'48ced7a6-e244-eb11-a430-80000bc8ea9c')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'N17DCCN059  ', N'2008-2009', 1, CAST(N'2008-03-26' AS Date), 5000000, N'c15a5204-1141-eb11-a42d-f01faf5aed44')
INSERT [dbo].[CT_DONGHOCPHI] ([MASV], [NIENKHOA], [HOCKY], [NGAYDONG], [SOTIENDONG], [rowguid]) VALUES (N'N17DCCN059  ', N'2008-2009', 1, CAST(N'2008-03-27' AS Date), 4000000, N'96da362c-1141-eb11-a42d-f01faf5aed44')
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
ALTER TABLE [dbo].[CT_DONGHOCPHI]  WITH CHECK ADD  CONSTRAINT [FK_CT_DONGHOCPHI_HOCPHI] FOREIGN KEY([MASV], [NIENKHOA], [HOCKY])
REFERENCES [dbo].[HOCPHI] ([MASV], [NIENKHOA], [HOCKY])
GO
ALTER TABLE [dbo].[CT_DONGHOCPHI] CHECK CONSTRAINT [FK_CT_DONGHOCPHI_HOCPHI]
GO
ALTER TABLE [dbo].[HOCPHI]  WITH NOCHECK ADD  CONSTRAINT [FK_HOCPHI_SINHVIEN] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[HOCPHI] CHECK CONSTRAINT [FK_HOCPHI_SINHVIEN]
GO
/****** Object:  StoredProcedure [dbo].[SP_BangHP]    Script Date: 12/23/2020 7:09:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BangHP] @MASV CHAR(12)
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
/****** Object:  StoredProcedure [dbo].[SP_CHECKID]    Script Date: 12/23/2020 7:09:51 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CHECKIDHOCPHI]    Script Date: 12/23/2020 7:09:51 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CHECKMALOPTHEOSINHVIEN]    Script Date: 12/23/2020 7:09:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHECKMALOPTHEOSINHVIEN] @MALOP CHAR(8)
AS
BEGIN
IF EXISTS(SELECT * FROM dbo.SINHVIEN WHERE dbo.SINHVIEN.MALOP = @MALOP)
			RETURN
			ELSE RAISERROR('MÃ LỚP KHÔNG TỒN TẠI HOẶC KHÔNG CÓ SINH VIÊN!!',16,1)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DANGNHAP]    Script Date: 12/23/2020 7:09:51 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DongHocPHi]    Script Date: 12/23/2020 7:09:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DongHocPHi] @MASV NCHAR(12),
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
/****** Object:  StoredProcedure [dbo].[SP_INDANHSACHHOCPHI]    Script Date: 12/23/2020 7:09:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INDANHSACHHOCPHI] @MALOP NVARCHAR(9),@NIENKHOA NVARCHAR(50),@HOCKY INT
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
/****** Object:  StoredProcedure [dbo].[SP_TAOLOGIN]    Script Date: 12/23/2020 7:09:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TAOLOGIN] @LGNAME VARCHAR(50),
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
