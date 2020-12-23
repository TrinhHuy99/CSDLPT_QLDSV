using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace QLDSV.Report
{
    public partial class XtraReportDSSV : DevExpress.XtraReports.UI.XtraReport
    {


        public XtraReportDSSV(String MALOP)
        {
            InitializeComponent();
            qldsvDataSet1.EnforceConstraints = false;
            this.sP_REPORT_DSSVTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
            this.sP_REPORT_DSSVTableAdapter1.Fill(qldsvDataSet1.SP_REPORT_DSSV,MALOP);

        }

      
    }
}
