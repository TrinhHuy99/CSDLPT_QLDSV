﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraBars;
using DevExpress.XtraEditors;
using System.Data.SqlClient;

namespace QLDSV.Forms
{
    public partial class frmHocPhi : DevExpress.XtraEditors.XtraForm
    {
        private int _position;
        private Boolean _flagEdit = false;
        public frmHocPhi()
        {
            InitializeComponent();
            // This line of code is generated by Data Source Configuration Wizard

        }
        private void EnableEditMode()
        {
            btnThem.Enabled = false;
            btnGhi.Enabled = true;
            cmbMASV.ReadOnly = true;
        }

        private void DisableEditMode()
        {
            btnThoat.Enabled = true;
            cmbMASV.ReadOnly = false;
        }
        private void loadInitializeData()
        {

            this.sINHVIENTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.sINHVIENTableAdapter.Fill(this.qLDSVDataSet.SINHVIEN);



        }

        private void frmHocPhi_Load(object sender, EventArgs e)
        {
            btnThem.Enabled = false;
            btnGhi.Enabled = false;
            this.sINHVIENTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.sINHVIENTableAdapter.Fill(this.qLDSVDataSet.SINHVIEN);
            DisableEditMode();

        }
        private void lkeSinhVien_EditValueChanged(object sender, EventArgs e)
        {
            var selectedSV = cmbMASV.GetSelectedDataRow() as DataRowView;

            txtTenSV.Text = selectedSV.Row["HO"] + " " + selectedSV.Row["TEN"];
            txtMaLop.Text = selectedSV.Row["MALOP"].ToString();

            _position = this.sINHVIENBindingSource.Find("MASV", selectedSV.Row["MASV"].ToString());
            this.btnThem.Enabled = true;
            this.btnGhi.Enabled = false;
            loadInitializeData();
            this.sINHVIENBindingSource.Position = _position;
        }

        private void btnThoat_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (btnGhi.Enabled)
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

        private void btnThem_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (cmbMASV.Text.Trim() == "")
            {
                MessageBox.Show("Mã sinh viên không được để trống.", "Lỗi đăng nhập", MessageBoxButtons.OK);
                cmbMASV.Focus();
                return;
            }
            try
            {
                this.sP_BangHPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.sP_BangHPTableAdapter.Fill(this.qLDSVDataSet2.SP_BangHP, cmbMASV.EditValue.ToString());
                btnGhi.Enabled = true;
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "", MessageBoxButtons.OK);
            }
        }

        private void btnGhi_ItemClick(object sender, ItemClickEventArgs e)
        {
            cmbMASV.Focus();
            for (int i = 0; i < bds_BangHP.Count; i++)
            {              
                int tienDong = int.Parse(((DataRowView)bds_BangHP[i])["SOTIENDONG"].ToString());
                int hocPhi = int.Parse(((DataRowView)bds_BangHP[i])["HOCPHI"].ToString());
                int tienDaDong = int.Parse(((DataRowView)bds_BangHP[i])["TIENDADONG"].ToString());
               Console.WriteLine(tienDong);
               Console.WriteLine(hocPhi);
               Console.WriteLine(tienDaDong);
                if ((tienDaDong == hocPhi) || tienDong == 0)
                {
                    continue;
                }
                else if ((tienDong + tienDaDong) > hocPhi)
                {
                    MessageBox.Show("Kiểm tra lại số tiền đóng.", "", MessageBoxButtons.OK);
                    bds_BangHP.Position = i;
                    break;
                }
                else
                {
                    String sql = "EXEC SP_DongHocPHi '" + cmbMASV.Text + "','" + ((DataRowView)bds_BangHP[i])["NIENKHOA"].ToString() + "'," + int.Parse(((DataRowView)bds_BangHP[i])["HOCKY"].ToString()) + "," + tienDong;
                    Program.ExecSqlNonQuery(sql);
                }
            }

            try
            {
                this.sP_BangHPTableAdapter.Connection.ConnectionString = Program.URL_Connect;
                this.sP_BangHPTableAdapter.Fill(this.qLDSVDataSet2.SP_BangHP, cmbMASV.Text);

            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "", MessageBoxButtons.OK);
            }

        }
    }
}