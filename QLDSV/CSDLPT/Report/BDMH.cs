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
    public partial class BDMH : DevExpress.XtraEditors.XtraForm
    {
        public BDMH()
        {
            InitializeComponent();
        }

        private void BDMH_Load(object sender, EventArgs e)
        {

            Program.Bds_Dspm.Filter = "TENKHOA LIKE 'KHOA%'";
            Utils.BindingDataToComBo(cmbKhoa, Program.Bds_Dspm.DataSource);

            loadInitializeData();

            if (Program.MGroup == Program.NhomQuyen[0])
            {
                cmbKhoa.Visible = true;
                cmbKhoa.Enabled = true;
                labelKhoa.Visible = false;

            }
            if (Program.MGroup == Program.NhomQuyen[1]|| Program.MGroup == Program.NhomQuyen[3])
            {
                cmbKhoa.Visible = false;
                cmbKhoa.Enabled = false;
                label_Khoa.Visible = false;
                labelKhoa.Visible = true;
                labelKhoa.Text = ((DataRowView)Program.Bds_Dspm[Program.MKhoa])["TENKHOA"].ToString();
            }

            this.cmbLan.Items.Add(1);
            this.cmbLan.Items.Add(2);
            this.cmbLan.SelectedIndex = 0;
            this.txtMaLop.Text = this.cmbTenLop.SelectedValue.ToString();
            this.txtMaMonHoc.Text = this.cmbTenMonHoc.SelectedValue.ToString();

        }
        private void loadInitializeData()
        {
            this.qLDSVDataSet.EnforceConstraints = false;
            // TODO: This line of code loads data into the 'qLDSVDataSet.MONHOC' table. You can move, or remove it, as needed.
            this.mONHOCTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.mONHOCTableAdapter.Fill(this.qLDSVDataSet.MONHOC);
            // TODO: This line of code loads data into the 'qLDSVDataSet.LOP' table. You can move, or remove it, as needed.
            this.lOPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.lOPTableAdapter.Fill(this.qLDSVDataSet.LOP);
        }

        private void cmbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            Utils.ComboboxHelper(this.cmbKhoa);
            if (Program.KetNoi() == 0)
            {
                XtraMessageBox.Show("Lỗi kết nối về chi nhánh mới", "", MessageBoxButtons.OK);
            }
            loadInitializeData();
            this.txtMaLop.Text = this.cmbTenLop.SelectedValue.ToString();
            this.txtMaMonHoc.Text = this.cmbTenMonHoc.SelectedValue.ToString();
        }

        private void txtMaLop_TextChanged(object sender, EventArgs e)
        {
           
        }

        private void cmbTenLop_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                this.txtMaLop.Text = this.cmbTenLop.SelectedValue.ToString();
            }
            catch { }
        }

        private void cmbTenMonHoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                this.txtMaMonHoc.Text = this.cmbTenMonHoc.SelectedValue.ToString();
            }
            catch { }
        }

        private void button_Thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button_IN_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Value : " + this.cmbLan.SelectedItem.ToString());
            XtraReport_BDMH report = new XtraReport_BDMH(this.cmbTenLop.SelectedValue.ToString(), this.cmbTenMonHoc.SelectedValue.ToString(), Int32.Parse(this.cmbLan.SelectedItem.ToString()));
            report.lblTenLop.Text = this.cmbTenLop.Text;
            report.lblTenMonHoc.Text = this.cmbTenMonHoc.Text;
            report.lblLanThi.Text = this.cmbLan.SelectedItem.ToString();
            report.lblNguoiIn.Text = "Người In: " + Program.MHoten;

            ReportPrintTool print = new ReportPrintTool(report);
            print.ShowPreviewDialog();
        }

        private void fillToolStripButton_Click(object sender, EventArgs e)
        {
          
        }
    } 
}