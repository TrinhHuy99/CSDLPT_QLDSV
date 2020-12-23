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
using System.Data.SqlClient;

namespace QLDSV.Forms
{
    public partial class frmDiem : DevExpress.XtraEditors.XtraForm
    {
        int checkLuu = 0;
        public frmDiem()
        {
            InitializeComponent();
        }

        private void lOPBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.lOPBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.qLDSVDataSet);

        }

        private void frmDiem_Load(object sender, EventArgs e)
        {
            this.mONHOCTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.mONHOCTableAdapter.Fill(this.qLDSVDataSet.MONHOC);
            // TODO: This line of code loads data into the 'dS.LOP' table. You can move, or remove it, as needed.
            this.lOPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.lOPTableAdapter.Fill(this.qLDSVDataSet.LOP);
            btnLuu.Enabled = false;
            Program.Bds_Dspm.Filter = "TENKHOA LIKE 'KHOA%'";
            Utils.BindingDataToComBo(cmbKhoa, Program.Bds_Dspm.DataSource);
            //cmbKhoa.DataSource = Program.bds_dspm;  // sao chép bds_dspm đã load ở form đăng nhập  qua
            cmbKhoa.DisplayMember = "TENKHOA";
            cmbKhoa.ValueMember = "TENSERVER";
            cmbKhoa.SelectedIndex = Program.MKhoa;
            if (Program.MGroup == "PGV") cmbKhoa.Enabled = true;  // bật tắt theo phân quyền
            else cmbKhoa.Enabled = false;

        }

        private void gridControl1_Click(object sender, EventArgs e)
        {

        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            if (checkLuu==1)
            {
                String notifi = " Dữ liệu chưa lưu vào Database.  Bạn có chắc muốn thoát !";

                DialogResult dr = XtraMessageBox.Show(notifi, "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);

                if (dr == DialogResult.No)
                {
                    return;
                }
                else if (dr == DialogResult.Yes)
                {
                    this.Close();
                }
            }
            this.Close();
        }
        private void sP_BangNhapDiemBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.sPBangNhapDiemBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.qLDSVDataSet);

        }

        private void btnBatDau_Click(object sender, EventArgs e)
        {
            if (cmbLop.Text.Trim() == "")
            {
                MessageBox.Show("Lớp không được để trống.", "Lỗi đăng nhập", MessageBoxButtons.OK);
                cmbLop.Focus();
                return;
            }
            else if (cmbMH.Text.Trim() == "")
            {
                MessageBox.Show("Môn học không được để trống.", "Lỗi đăng nhập", MessageBoxButtons.OK);
                cmbMH.Focus();
                return;
            }
            try
            {
                this.sP_BangNhapDiemTableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.sP_BangNhapDiemTableAdapter.Fill(this.qLDSVDataSet.SP_BangNhapDiem,
                cmbLop.EditValue.ToString(),
                cmbMH.EditValue.ToString(),
                new System.Nullable<short>(((short)(System.Convert.ChangeType(cmbLan.Value, typeof(short))))));
                btnLuu.Enabled = true;
                checkLuu = 1;


            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "", MessageBoxButtons.OK);
            }
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
                // TODO: This line of code loads data into the 'dS.LOP' table. You can move, or remove it, as needed.
                this.lOPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.lOPTableAdapter.Fill(this.qLDSVDataSet.LOP);
            }
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            int check = 0;
            for (int i = 0; i < sPBangNhapDiemBindingSource.Count; i++)
            {
                float diem = float.Parse(((DataRowView)sPBangNhapDiemBindingSource[i])["DIEM"].ToString());
                if (diem < 0 || diem > 10)
                {
                    diem = 0;
                    check++;
                }
                if (Program.KetNoi() == 0) return;
                String sql = "EXEC SP_ThemDiem '" + ((DataRowView)sPBangNhapDiemBindingSource[i])["MASV"].ToString() + "','" + cmbMH.EditValue.ToString() + "'," + cmbLan.Value + "," + diem;
                Program.ExecSqlNonQuery(sql);
                if (check == 0 & i == sPBangNhapDiemBindingSource.Count - 1) MessageBox.Show("Lưu thành công", "", MessageBoxButtons.OK);
            }
            for (int i = 0; i < sPBangNhapDiemBindingSource.Count; i++)
            {
                float diemCheck = float.Parse(((DataRowView)sPBangNhapDiemBindingSource[i])["DIEM"].ToString());
                if (diemCheck < 0 || diemCheck > 10)
                {
                    MessageBox.Show("Nhập sai điểm.\n" + "Lưu lại sinh viên này với điểm mặc định bằng 0", "", MessageBoxButtons.OK);
                    sPBangNhapDiemBindingSource.Position = i;
                    break;
                }
            }
            checkLuu = 0;
            btnLuu.Enabled = true;
            btnBatDau.Enabled = true;
        }
    }
}