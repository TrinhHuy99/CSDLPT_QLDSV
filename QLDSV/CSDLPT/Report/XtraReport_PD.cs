using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace QLDSV.Report
{
    public partial class XtraReport_PD : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReport_PD(String maSV, String tenSV)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = Program.URL_Connect;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maSV;
            this.sqlDataSource1.Fill();
            this.lbTenSinhVien.Text = tenSV;
        }

    }
}
