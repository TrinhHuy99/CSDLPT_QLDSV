using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDSV
{
    public partial class frmDangNhap : Form
    {
        public frmDangNhap()
        {
            InitializeComponent();
        }

        private void frmDangNhap_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'qLDSVDataSet1.V_DSPM' table. You can move, or remove it, as needed.
          /*  this.v_DSPMTableAdapter.Fill(this.qLDSVDataSet1.V_DSPM);
            cmbKhoa.SelectedIndex = 1;
            cmbKhoa.SelectedIndex = 0;*/
            string chuoiketnoi = "Data Source=DESKTOP-G17H44E;Initial Catalog=" + Program.Database + ";Integrated Security=True";

             Program.Conn.ConnectionString = chuoiketnoi;

            DataTable dt = new DataTable();
            dt = Program.ExecSqlDataTable("SELECT * FROM V_DSPM");
            Program.Bds_Dspm.DataSource = dt;
            Program.Bds_Dspm.Sort = "TENKHOA ASC";

            Utils.BindingDataToComBo(cmbKhoa, dt);
            
        }


        private void cmbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
          

            try
            {
                // gán server đã chọn vào biến toàn cục.
                Program.ServerName = cmbKhoa.SelectedValue.ToString();
            }
            catch (Exception) { };
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {

            if (txtLogin.Text.Trim() == "")
            {
                XtraMessageBox.Show("Tài khoản đăng nhập không được trống", "Lỗi đăng nhập", MessageBoxButtons.OK);
               txtLogin.Focus();
                return;
            }
            if ( txtPass.Text.Trim() == "")
            {
                XtraMessageBox.Show("Mật khẩu đăng nhập không được trống", "Lỗi đăng nhập", MessageBoxButtons.OK);
                txtPass.Focus();
                return;
            }
            
            Program.MLogin = txtLogin.Text;
            Program.MPassword = txtPass.Text;
            if (Program.KetNoi() == 0)
            {
                return;
            }
            Program.MKhoa = cmbKhoa.SelectedIndex;
            
          

            Program.MLoginDN = Program.MLogin;
            Program.PasswordDN = Program.MPassword;

          
            String strLenh = "exec SP_DANGNHAP '" + Program.MLogin + "'";
            Program.MyReader = Program.ExecSqlDataReader(strLenh);
            if (Program.MyReader == null)
            {
                return;
            }
  
            Program.MyReader.Read();


            Program.UserName = Program.MyReader.GetString(0);     // Lay user name
            if (Convert.IsDBNull(Program.UserName))
            {
                XtraMessageBox.Show("Login bạn nhập không có quyền truy cập dữ liệu\nBạn xem lại username, password", "", MessageBoxButtons.OK);
                return;
            }

            try
            {
                Program.MHoten = Program.MyReader.GetString(1);
                Program.MGroup = Program.MyReader.GetString(2);
            }
            catch(Exception ex)
            {
                Debug.WriteLine("---> Lỗi: " + ex.ToString());
                XtraMessageBox.Show("Login bạn nhập không có quyền truy cập vào chương trình", "", MessageBoxButtons.OK);
                return;
            }

            Program.MyReader.Close();
            Program.Conn.Close();
            Program.frmMain = new frmMain();
            Program.frmMain.lblMAGV.Text = "MÃ GIẢNG VIÊN : " + Program.UserName.Trim();
            Program.frmMain.lblHOTEN.Text = "HỌ VÀ TÊN : " + Program.MHoten.Trim();
            Program.frmMain.lblNHOM.Text = "NHÓM : " + Program.MGroup;

            Program.frmMain.Show();
            Program.FrmDangNhap.Visible = false;
        }

        private void chkShowPass_CheckedChanged(object sender, EventArgs e)
        {
            txtPass.UseSystemPasswordChar = (chkShowPass.Checked) ? false : true;
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            Close();
        }
            
        private void frmDangNhap_VisibleChanged(object sender, EventArgs e)
        {
            Program.Bds_Dspm.RemoveFilter();
            cmbKhoa_SelectedIndexChanged(sender, e);
        }
    }
}
