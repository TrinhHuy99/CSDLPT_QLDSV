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
    public partial class PD : DevExpress.XtraEditors.XtraForm
    {
        public PD()
        {
            InitializeComponent();
        }

        private void PD_Load(object sender, EventArgs e)
        {
            Program.Bds_Dspm.Filter = "TENKHOA LIKE 'KHOA%'";
            Utils.BindingDataToComBo(cmbKhoa, Program.Bds_Dspm.DataSource);
            this.sINHVIEN1TableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.sINHVIEN1TableAdapter.Fill(this.qLDSVDataSet.SINHVIEN1);
           // cmbKhoa.DataSource = Program.bds_dspm;  // sao chép bds_dspm đã load ở form đăng nhập  qua
            cmbKhoa.DisplayMember = "TENKHOA";
            cmbKhoa.ValueMember = "TENSERVER";
            cmbKhoa.SelectedIndex = Program.MKhoa;
            if (Program.MGroup == "PGV") cmbKhoa.Enabled = true;  // bật tắt theo phân quyền
            else cmbKhoa.Enabled = false;

        }

        private void cmbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbKhoa.SelectedValue.ToString() == "System.Data.DataRowView")
                return;
            Program.ServerName = cmbKhoa.SelectedValue.ToString();

            if (cmbKhoa.SelectedIndex != Program.MKhoa)
            {
                Program.MLogin = Program.RemoteLogin;
                Program.MPassword = Program.RemotePassword;
            }
            else
            {
                Program.MLogin = Program.MLoginDN;
                Program.MPassword = Program.PasswordDN;
            }
            if (Program.KetNoi() == 0)
                MessageBox.Show("Lỗi kết nối về chi nhánh mới", "", MessageBoxButtons.OK);
            else
            {
                this.sINHVIEN1TableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.sINHVIEN1TableAdapter.Fill(this.qLDSVDataSet.SINHVIEN1);
            }
        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            if (cmbMASV.Text.Trim() == "")
            {
                MessageBox.Show("Thông tin sinh viên không được để trống.", "", MessageBoxButtons.OK);
                cmbMASV.Focus();
                return;
            }
            XtraReport_PD bdmh = new XtraReport_PD(cmbMASV.EditValue.ToString(), cmbMASV.Text);
            bdmh.lblNguoiIn.Text = "Người In: " + Program.MHoten;
            ReportPrintTool print = new ReportPrintTool(bdmh);
            print.ShowPreviewDialog();
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}