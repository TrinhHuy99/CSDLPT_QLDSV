using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using DevExpress.XtraReports.UI;

namespace QLDSV.Report
{
    public partial class DSDHP : DevExpress.XtraEditors.XtraForm
    {
        public DSDHP()
        {
            InitializeComponent();
        }

        private void button_THOAT_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button_IN_Click(object sender, EventArgs e)
        {
            String sql = "EXEC SP_CHECKMALOPTHEOSINHVIEN '" + txtMaLop.Text + "'";
            Program.ExecSqlNonQuery(sql);

            errorProvider1.Clear();
            if (txtMaLop.Text.Trim()=="")
            {
                this.errorProvider1.SetError(txtMaLop,"Mã lớp không được trống!");
                return;
            }
            else if (txtNienKhoa.Text.Trim()=="")
            {
                errorProvider1.SetError(txtNienKhoa, "Niên khóa không được trống!");
                return;
            }else if (txtHocKi.Text.Trim()=="")
            {
                errorProvider1.SetError(txtHocKi, "Học kì không được trống!");
                return;
            }else
            try
            {
                XtraReport_DSDHP report = new XtraReport_DSDHP(this.txtMaLop.Text.Trim().ToString(), this.txtNienKhoa.Text.Trim().ToString(), Int32.Parse(this.txtHocKi.Text.Trim().ToString()));
                report.lblTenLop.Text = this.txtMaLop.Text.Trim().ToString();
                report.lblNienKhoa.Text = this.txtNienKhoa.Text.Trim().ToString();
                report.lblHocKi.Text = this.txtHocKi.Text.Trim().ToString();
                report.lblNguoiIn.Text = "Người In : " + Program.MHoten;
                ReportPrintTool print = new ReportPrintTool(report);
                print.ShowPreviewDialog();

            }
            catch (Exception)
            {
                XtraMessageBox.Show("Dữ liệu bạn điền chưa hợp lệ !", "", MessageBoxButtons.OK);
                return;
            }
          
        }

        private void DSDHP_Load(object sender, EventArgs e)
        {
          

        }

        private void lOPBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
          
        }
    }
}