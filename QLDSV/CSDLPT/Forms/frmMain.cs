﻿using DevExpress.XtraEditors;
using QLDSV.Forms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace QLDSV
{
    public partial class frmMain : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        // TODO: flag dangxuat giúp giải việc sự nhọc nhằng giữa sự kiện form closing với dòng lệnh Program.frmMain.Close();

        Boolean dangxuat = false;

        public frmMain()
        {
            InitializeComponent();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            if (Program.MGroup == Program.NhomQuyen[2])// PKT
            {
               
                this.barButtonItem_MonHoc.Enabled = false;
                this.barButtonItem_SinhVien.Enabled = false;
                this.barButtonItem_Diem.Enabled = false;
                this.barBtnHocPhi.Enabled = true;
                this.barBtnChuyenLop.Enabled = false;
                this.barButton_DSDHP.Enabled = true;
                this.barButton_DSSV.Enabled = false;
                this.barButton_DSTHM.Enabled = false;
                this.barButton_BDMH.Enabled = false;
                this.barButton_PD.Enabled = false;
                this.barButton_BDTK.Enabled = false;
                this.barButton_Register.Enabled = true;
            }
            else if (Program.MGroup == Program.NhomQuyen[0]|| Program.MGroup == Program.NhomQuyen[1])
            {

                this.barButtonItem_MonHoc.Enabled = true;
                this.barButtonItem_SinhVien.Enabled = true;
                this.barButtonItem_Diem.Enabled = true;
                this.barBtnHocPhi.Enabled = false;
                this.barBtnChuyenLop.Enabled = true;
                this.barButton_DSDHP.Enabled = false;
                this.barButton_DSSV.Enabled = true;
                this.barButton_DSTHM.Enabled = true;
                this.barButton_BDMH.Enabled = true;
                this.barButton_PD.Enabled = true;
                this.barButton_BDTK.Enabled = true;
                this.barButton_Register.Enabled = true;
            }
            else
            {
                this.barButtonItem_MonHoc.Enabled = true;
                this.barButtonItem_SinhVien.Enabled = true;
                this.barButtonItem_Diem.Enabled = true;
                this.barBtnHocPhi.Enabled = false;
                this.barBtnChuyenLop.Enabled = true;
                this.barButton_DSDHP.Enabled = false;
                this.barButton_DSSV.Enabled = true;
                this.barButton_DSTHM.Enabled = true;
                this.barButton_BDMH.Enabled = true;
                this.barButton_PD.Enabled = true;
                this.barButton_BDTK.Enabled = true;
                this.barButton_Register.Enabled = false;
            }

        }
        // TODO : HANDLE CONTROL CHILDREN
        private void ShowMdiChildren(Type fType)
        {
            foreach (Form f in this.MdiChildren)
            {
                if (f.GetType() == fType)
                {
                    f.Activate();
                    return;
                }
            }
            Form form = (Form)Activator.CreateInstance(fType);
            form.MdiParent = this;
            form.Show();
        }




        // ============================ BUTTON EVENT ============================ //
        private void barButtonItem_Lop_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            
        }
        private void barButtonItem_MonHoc_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (!(Program.MGroup == Program.NhomQuyen[2]))
            {
                ShowMdiChildren(typeof(frmMonHoc));
            }
        }
        private void barButtonItem_SinhVien_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (!(Program.MGroup == Program.NhomQuyen[2]))
            {
                ShowMdiChildren(typeof(frmSinhVien));
            }
        }
   
        private void barButton_Diem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
        }
        private void barButtonItem_ChuyenLop_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            
        }




        // TODO : Close Event
        private void frmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (!dangxuat)
            {
                if (XtraMessageBox.Show("Bạn có thực sự muốn thoát?", "Xác nhận", MessageBoxButtons.YesNo) == DialogResult.No)
                {
                    e.Cancel = true;
                    return;
                }
                else
                {
                    this.Dispose();
                    Program.FrmDangNhap.Close();
                }

            }
        }

        private void barButton_Register_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(frmDangKy));
        }

        private void barButton_Logout_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            dangxuat = true;
            Program.frmMain.Close();
            Program.FrmDangNhap.Visible = true;
        }



        // ==================== REPORT ZONE ==================== //
        private void barButton_DSSV_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(Report.DSSV));
        }

        private void barButton_DSTHM_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(Report.BDT));
        }

        private void barButton_BDMH_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(Report.BDMH));
        }

        private void barButton_PD_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(Report.PD));
        }

        private void barButton_DSDHP_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(Report.DSDHP));
        }

        private void barButton_BDTK_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(Report.BDTK));
        }

        private void barButton_SinhVien_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
           
                

        }

        private void barButtonItem_Diem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

            ShowMdiChildren(typeof(frmDiem));

        }

        private void barBtnHocPhi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if ((Program.MGroup == Program.NhomQuyen[2]))
            {
                ShowMdiChildren(typeof(frmHocPhi));
            }
        }

        private void barBtnChuyenLop_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowMdiChildren(typeof(frmChuyenLop));
        }
    }
}

