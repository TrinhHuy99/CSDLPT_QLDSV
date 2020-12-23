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
    public partial class BDT : DevExpress.XtraEditors.XtraForm
    {
        public BDT()
        {
            InitializeComponent();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void BDT_Load(object sender, EventArgs e)
        {
            Program.Bds_Dspm.Filter = "TENKHOA LIKE 'KHOA%'";
            Utils.BindingDataToComBo(cmbKhoa, Program.Bds_Dspm.DataSource);
            this.mONHOCTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.mONHOCTableAdapter.Fill(this.qLDSVDataSet.MONHOC);
            this.lOPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.lOPTableAdapter.Fill(this.qLDSVDataSet.LOP);
            //cmbKhoa.DataSource = Program.bds_dspm;  // sao chép bds_dspm đã load ở form đăng nhập  qua
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
                this.mONHOCTableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.mONHOCTableAdapter.Fill(this.qLDSVDataSet.MONHOC);
                this.lOPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.lOPTableAdapter.Fill(this.qLDSVDataSet.LOP);
            }
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            if (cmbTenLop.Text.Trim() == "")
            {
                MessageBox.Show("Lớp không được để trống.", "Lỗi đăng nhập", MessageBoxButtons.OK);
                cmbTenLop.Focus();
                return;
            }
            else if (cmbTenMon.Text.Trim() == "")
            {
                MessageBox.Show("Môn học không được để trống.", "Lỗi đăng nhập", MessageBoxButtons.OK);
                cmbTenMon.Focus();
                return;
            }
            XtraReport_BDT bdt = new XtraReport_BDT(cmbTenLop.EditValue.ToString(), cmbTenLop.Text, cmbTenMon.Text, dateNgayThi.Text, int.Parse(cmbLan.Value.ToString()));
            bdt.lblNguoiIn.Text = "Người In: " + Program.MHoten;
            ReportPrintTool print = new ReportPrintTool(bdt);
            print.ShowPreviewDialog();
        }
    }
}