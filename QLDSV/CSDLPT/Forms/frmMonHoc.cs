using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraBars;
using System.Data.SqlClient;

namespace QLDSV.Forms
{
    public partial class frmMonHoc : DevExpress.XtraEditors.XtraForm
    {
        int vitri = 0;
        public frmMonHoc()
        {
            InitializeComponent();
           
        }
        private void mONHOCBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.mONHOCBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.qLDSVDataSet);

        }

        private void frmMonHoc_Load(object sender, EventArgs e)
        {
            qLDSVDataSet.EnforceConstraints = false;

            this.monhocTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
            this.monhocTableAdapter1.Fill(this.qLDSVDataSet.MONHOC);

            this.dIEMTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.dIEMTableAdapter.Fill(this.qLDSVDataSet.DIEM);
            groupControl2.Enabled = false;

        }

        private void btnThoat_ItemClick(object sender, ItemClickEventArgs e)
        {
            Close();
        }

        private void btnThem_ItemClick(object sender, ItemClickEventArgs e)
        {
            vitri = mONHOCBindingSource.Position;
            groupControl2.Enabled = true;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = btnPhucHoi.Enabled = btnThoat.Enabled = false;
            btnGhi.Enabled = btnPhucHoi.Enabled = true;
            gcMonHoc.Enabled = false;
            mONHOCBindingSource.AddNew();
            txtMaMon.Focus();
        }

        private void btnSua_ItemClick(object sender, ItemClickEventArgs e)
        {
            vitri = mONHOCBindingSource.Position;
            groupControl2.Enabled = true;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = btnLamMoi.Enabled = btnThoat.Enabled = false;
            btnGhi.Enabled = btnPhucHoi.Enabled = true;
            gcMonHoc.Enabled = false;
        }

        private void btnXoa_ItemClick(object sender, ItemClickEventArgs e)
        {
            String mamh = "";
            if (dIEMBindingSource.Count > 0)
            {
                MessageBox.Show("Không thể xóa môn học này vì đã có bảng điểm", "",
                       MessageBoxButtons.OK);
                return;
            }
            if (MessageBox.Show("Bạn có thật sự muốn xóa môn học này ?? ", "Xác nhận",
                       MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {
                    mamh = (((DataRowView)mONHOCBindingSource[mONHOCBindingSource.Position])["MAMH"].ToString()); // giữ lại để khi xóa bij lỗi thì ta sẽ quay về lại
                    mONHOCBindingSource.RemoveCurrent();
                    this.monhocTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
                    this.monhocTableAdapter1.Update(this.qLDSVDataSet.MONHOC);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Lỗi xóa môn học. Bạn hãy xóa lại\n" + ex.Message, "",
                        MessageBoxButtons.OK);
                    this.monhocTableAdapter1.Fill(this.qLDSVDataSet.MONHOC);
                    mONHOCBindingSource.Position = mONHOCBindingSource.Find("MAMH", mamh);
                    return;
                }

            }
            if (mONHOCBindingSource.Count == 0) btnXoa.Enabled = false;
        }

        private void btnPhucHoi_ItemClick(object sender, ItemClickEventArgs e)
        {
            mONHOCBindingSource.CancelEdit();
            if (btnThem.Enabled == false) mONHOCBindingSource.Position = vitri;
            gcMonHoc.Enabled = true;
            groupControl2.Enabled = false;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = btnLamMoi.Enabled = btnThoat.Enabled = true;
            btnGhi.Enabled = btnPhucHoi.Enabled = false;
        }

        private void btnLamMoi_ItemClick(object sender, ItemClickEventArgs e)
        {
            try
            {
                this.monhocTableAdapter1.Fill(this.qLDSVDataSet.MONHOC);

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi làm mới :" + ex.Message, "", MessageBoxButtons.OK);
                return;
            }
        }

        private void btnGhi_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (txtMaMon.Text.Trim() == "")
            {
                MessageBox.Show("Mã môn học không được thiếu!", "", MessageBoxButtons.OK);
                txtMaMon.Focus();
                return;
            }
            if (txtTenMon.Text.Trim() == "")
            {
                MessageBox.Show("Tên môn học không được thiếu!", "", MessageBoxButtons.OK);
                txtTenMon.Focus();
                return;
            }


            try
            {
                mONHOCBindingSource.EndEdit();
                mONHOCBindingSource.ResetCurrentItem();
                this.monhocTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
                this.monhocTableAdapter1.Update(this.qLDSVDataSet.MONHOC);

            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi ghi môn học.\nMã môn học không được trùng", "", MessageBoxButtons.OK);
                return;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                MessageBox.Show("Lỗi ghi môn học.\n" + ex.Message, "", MessageBoxButtons.OK);
                return;
            }
            gcMonHoc.Enabled = true;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = btnLamMoi.Enabled = btnThoat.Enabled = true;
            btnGhi.Enabled = btnPhucHoi.Enabled = false;

            groupControl2.Enabled = false;
        }

        private void btnHuy_ItemClick(object sender, ItemClickEventArgs e)
        {
            mONHOCBindingSource.CancelEdit();

            // load lại cả form...
            frmMonHoc_Load(sender, e);

            if (vitri > 0)
            {
                mONHOCBindingSource.Position = vitri;
            }
            btnThoat.Enabled = true;
            gcMonHoc.Enabled = true;
        }

        private void mAMHLabel_Click(object sender, EventArgs e)
        {

        }
    }
}