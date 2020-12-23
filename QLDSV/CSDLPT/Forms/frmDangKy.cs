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

namespace QLDSV.Forms
{
    public partial class frmDangKy : DevExpress.XtraEditors.XtraForm
    {
        public frmDangKy()
        {
            InitializeComponent();
        }

        private void frmDangKy_Load(object sender, EventArgs e)
        {
            this.gETDSGVTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.gETDSGVTableAdapter.Fill(this.qLDSVDataSet.GETDSGV);


            if (Program.MGroup == Program.NhomQuyen[0])
            {
                rdoKhoa.Checked = rdoPGV.Checked = rdoUser.Checked = true;
                rdoPKeToan.Enabled = false;
            } // học phí chỉ được quyền đăng ký cho học phí
            else if (Program.MGroup == Program.NhomQuyen[2])
            {
                rdoKhoa.Enabled = rdoPGV.Enabled = rdoUser.Enabled = false;
                rdoPKeToan.Checked = true;
            }//khoa đăng kí cho khoa và user
            else if (Program.MGroup == Program.NhomQuyen[1])
            {
                rdoKhoa.Checked = rdoUser.Checked = true;
                rdoPKeToan.Enabled = rdoPGV.Enabled = false;
            }

        }

        private void chkShowPass_CheckedChanged(object sender, EventArgs e)
        {
            txtPass.Properties.UseSystemPasswordChar = (chkShowPass.Checked) ? false : true;
            txtConfirm.Properties.UseSystemPasswordChar = (chkShowPass.Checked) ? false : true;
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            bool check = this.ValidateInfo();
            if (check)
            {
                createTaiKhoan();

            }
            else
            {
                return;
            }

        }

        private void createTaiKhoan()
        {

            String login = txtLogin.Text;
            String pass = txtPass.Text;
            String user = (String)lookUpUser.EditValue;
            String role = (rdoKhoa.Checked || rdoUser.Checked) ? Program.NhomQuyen[1] : (rdoPGV.Checked ? Program.NhomQuyen[0] : Program.NhomQuyen[2]);

            String subLenh = " EXEC    @return_value = [dbo].[SP_TAOLOGIN] " +

                            " @LGNAME = N'" + login + "', " +
                            " @PASS = N'" + pass + "', " +
                            " @USERNAME = N'" + user + "', " +
                            " @ROLE = N'" + role + "' ";


            //tạo tài khoản cho chỉ khoa và pgv

            String strLenh = " DECLARE @return_value int " + subLenh +
                         " SELECT  'Return Value' = @return_value ";

            int resultCheckLogin = Utils.CheckDataHelper(strLenh);

            if (resultCheckLogin == -1)
            {
                XtraMessageBox.Show("Lỗi kết nối với database. Mời ban xem lại !", "", MessageBoxButtons.OK);
                this.Close();
            }
            if (resultCheckLogin == 1)
            {
                errorProvider1.SetError(this.txtLogin, "Login bị trùng . Mời bạn nhập login khác !");
            }
            else if (resultCheckLogin == 2)
            {
                errorProvider1.SetError(this.lookUpUser, "Giảng viên đã có tài khoản rồi !");

            }
            else if (resultCheckLogin == 3)
            {
                XtraMessageBox.Show("Lỗi thực thi trong cơ sơ dữ liệu !", "", MessageBoxButtons.OK);
            }
            else if (resultCheckLogin == 0)
            {
                XtraMessageBox.Show("Tạo tài khoản thành công !", "", MessageBoxButtons.OK);

            }

            return;
        }

        // true: ko empty, false : empty
        private Boolean isEmptyorNullTextEdits()
        {
            Boolean check = true;


            //check từng textedit

            if (string.IsNullOrEmpty(this.txtLogin.Text))
            {
                errorProvider1.SetError(this.txtLogin, "Trường dữ liệu không được để trống !");
                check = false;
            }
            if (string.IsNullOrEmpty(this.txtPass.Text))
            {
                errorProvider1.SetError(this.txtPass, "Trường dữ liệu không được để trống !");
                check = false;
            }

            if (string.IsNullOrEmpty(this.txtConfirm.Text))
            {
                errorProvider1.SetError(this.txtConfirm, "Trường dữ liệu không được để trống !");
                check = false;
            }


            return check;
        }


        private Boolean isEmptyorNullRadioButtons()
        { 


            if (this.rdoKhoa.Checked || this.rdoPGV.Checked || this.rdoPKeToan.Checked || rdoUser.Checked)
            {
                return true;
            }

            errorProvider1.SetError(this.pnRole, "Bạn chưa chọn nhóm quyền !");

            return false;

        }


        private bool ValidateInfo()
        {
            bool isValid = true;

            errorProvider1.Clear();


       
            if (!isEmptyorNullTextEdits())
            {
                isValid = false;
            }


            if (txtConfirm.Text != txtPass.Text)
            {
                this.errorProvider1.SetError(txtConfirm, "Mật khẩu không khớp");
                isValid = false;
            }

      
            if (!isEmptyorNullRadioButtons())
            {
                isValid = false;
            }

    
            if (txtLogin.Text.Contains(" "))
            {
                this.errorProvider1.SetError(txtLogin, "Tên login không được chứa khoảng trăng !");
                isValid = false;
            }


            return isValid;
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            DialogResult dr = XtraMessageBox.Show("Bạn thật sự muốn hủy thao tác đăng ký tài khoản?",
                     "Xác thực", MessageBoxButtons.YesNo);

            if (dr == DialogResult.No)
            {
                return;
            }
            else if (dr == DialogResult.Yes)
            {
                this.Close();

            }
        }
    }
}