using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace QLDSV.Report
{
    public partial class XtraReport_DSDHP : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReport_DSDHP(String MALOP, String NIENKHOA, int HOCKI)
        {
            InitializeComponent();
            qldsvDataSet21.EnforceConstraints = false;

           sP_INDANHSACHHOCPHITableAdapter.Connection.ConnectionString = Program.URL_Connect;
           sP_INDANHSACHHOCPHITableAdapter.Fill(qldsvDataSet21.SP_INDANHSACHHOCPHI, MALOP, NIENKHOA, HOCKI);
        }

    }
}
