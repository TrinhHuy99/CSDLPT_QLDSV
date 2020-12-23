using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace QLDSV.Report
{
    public partial class XtraReport_BDTK : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReport_BDTK(String maLop, String tenLop)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = Program.URL_Connect;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maLop;
            this.sqlDataSource1.Fill();
            this.lbTenLop.Text = tenLop;
        }

    }
}
