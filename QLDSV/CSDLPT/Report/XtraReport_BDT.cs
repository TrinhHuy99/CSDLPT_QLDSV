using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace QLDSV.Report
{
    public partial class XtraReport_BDT : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReport_BDT(String maLop, String tenLop, String tenMon, String ngayThi, int lanThi)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = Program.URL_Connect;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maLop;
            this.sqlDataSource1.Fill();
            this.lblLop.Text = tenLop;
            this.lblMonHoc.Text = tenMon;
            this.lblNgayThi.Text = ngayThi;
            this.lblLanThi.Text = lanThi.ToString();
        }

    }
}
