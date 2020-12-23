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
using DevExpress.XtraGrid.Views.Grid;
using System.Data.SqlClient;
using DevExpress.Utils;
using DevExpress.XtraEditors.Controls;

namespace QLDSV.Forms
{
    public partial class frmSinhVien : DevExpress.XtraEditors.XtraForm
    {
       
        private int _positionLop = 0;
        private string _flagOptionLop; 
        private string _oldMaLop = "";
        private string _oldTenLop = "";
        private string _oldMaSV;

        private Boolean _flagUpdateSV = false;
        private Boolean _flagSua = false;
        private int _positionSV = 0;

        public frmSinhVien()
        {
            InitializeComponent();
        }

        private void lOPBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.lOPBindingSource.EndEdit();
            this.tableAdapterManager1.UpdateAll(this.qLDSVDataSet);
        }

        private void loadInitializeData()
        {
            this.lOPTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
            this.sINHVIENTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
            this.dIEMTableAdapter.Connection.ConnectionString = Program.URL_Connect;

            this.lOPTableAdapter1.Fill(this.qLDSVDataSet.LOP);
            this.sINHVIENTableAdapter1.Fill(this.qLDSVDataSet.SINHVIEN);
            this.dIEMTableAdapter.Fill(this.qLDSVDataSet.DIEM);

        }
        private void frmLop_Load(object sender, EventArgs e)
        {
            // TODO : Load Data
            loadInitializeData();
            errorProvider.Clear();

            lOPGridControl.Enabled = true;

            // đoạn code liên kết giữa bds với combo box
            // lọc phân mảnh trước
            Program.Bds_Dspm.Filter = "TENKHOA LIKE 'KHOA%'";
            Utils.BindingDataToComBo(cmbKhoa, Program.Bds_Dspm.DataSource);

            lOPGridControl.Enabled = true;
            // TODO : Role Action
            if (Program.MGroup == Program.NhomQuyen[0])
            {
                cmbKhoa.Visible = true;
                cmbKhoa.Enabled = true;

                barBtnThem.Enabled
                   = barBtnXoa.Enabled
                   = barBtnSua.Enabled
                   = barBtnUndo.Enabled
                   = barBtnGhi.Enabled
                   = barBtnLamMoi.Enabled = true;
                   barBtnHuy.Enabled = false;
            }
            else if (Program.MGroup == Program.NhomQuyen[1] || Program.MGroup == Program.NhomQuyen[3]) 
            {
                cmbKhoa.Visible = false;

                barBtnThem.Enabled
                   = barBtnXoa.Enabled
                   = barBtnSua.Enabled
                   = barBtnUndo.Enabled
                   = barBtnGhi.Enabled
                   = barBtnLamMoi.Enabled = true;
                   barBtnHuy.Enabled = false;

                lblTenKhoa.Text = ((DataRowView)Program.Bds_Dspm[Program.MKhoa])["TENKHOA"].ToString();

                //sub
               
            }

            barBtnHuy.Enabled = barBtnGhi.Enabled = false;

            // TODO : Turn off input
            pnControlLeft.Enabled = false;
            conGhi.Enabled = false;

        }
        

      

        private void cmbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {

            // TODO : Chuyển Bộ Phận
            Utils.ComboboxHelper(this.cmbKhoa);

            if (Program.KetNoi() == 0)
            {
                XtraMessageBox.Show("Lỗi kết nối về chi nhánh mới", "", MessageBoxButtons.OK);
            }
            else
            {
                loadInitializeData();
                this.txtMaKhoa.EditValue = Utils.GetMaKhoa();
            }
        }

        private void barBtnThem_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            this.txtMaLop.Focus();
            _flagOptionLop = "ADD";

            pnControlLeft.Enabled = true;

            barBtnGhi.Enabled = barBtnHuy.Enabled = true;
            barBtnXoa.Enabled = barBtnThem.Enabled
                = barBtnSua.Enabled
                = barBtnUndo.Enabled
                = barBtnLamMoi.Enabled = false;


            cmbKhoa.Enabled = false;

            lOPGridControl.Enabled = false;
            // thao tác chuẩn bị thêm
            lOPBindingSource.AddNew();
            this.txtMaKhoa.EditValue = Utils.GetMaKhoa();

        }

        private void barBtnXoa_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (sINHVIENBindingSource1.Count > 0)
            {
                XtraMessageBox.Show("Không thể xóa lớp này vì Lớp đã có sinh viên.", "", MessageBoxButtons.OK);
                return;
            }
            if (XtraMessageBox.Show("Bạn có thực sự muốn xóa Lớp này?", "Xác nhận.", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {

                    lOPBindingSource.RemoveCurrent();
                    this.lOPTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
                    this.lOPTableAdapter1.Update(this.qLDSVDataSet.LOP);
                }
                catch (Exception ex)
                {
                    XtraMessageBox.Show("Lỗi xóa Lớp.\nBạn hãy xóa lại\n" + ex.Message, "", MessageBoxButtons.OK);
                    this.lOPTableAdapter1.Fill(this.qLDSVDataSet.LOP);
                    return;

                }
            }
            if (lOPBindingSource.Count == 0) barBtnXoa.Enabled = false;


            barBtnLamMoi.Enabled = true;

            if (_positionLop > 0)
            {
                lOPBindingSource.Position = _positionLop;
            }
        }

        private void barBtnSua_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            this.txtMaLop.Focus();
        
            _flagOptionLop = "UPDATE";//  Update action
            _oldMaLop = this.txtMaLop.Text.Trim().ToString();
            _oldTenLop = this.txtTenLop.Text.Trim().ToString();

            // TODO: Display To handle
            lOPGridControl.Enabled = false;
            pnControlLeft.Enabled = true;

            barBtnGhi.Enabled = barBtnHuy.Enabled = true;

            barBtnThem.Enabled
                = barBtnXoa.Enabled
                = barBtnSua.Enabled
                = barBtnUndo.Enabled
                = barBtnLamMoi.Enabled = false;
            cmbKhoa.Enabled = false;

            
        }

        private void barBtnUndo_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barBtnGhi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
        
            bool check = this.ValidateInfoLOP();
            if (check)
            {
                DialogResult dr = XtraMessageBox.Show("Bạn có chắc muốn ghi dữ liệu vào Database?", "Thông báo",
                    MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                if (dr == DialogResult.OK)
                {
                    try
                    {
                        barBtnThem.Enabled
                        = barBtnXoa.Enabled
                        = barBtnSua.Enabled
                        = barBtnUndo.Enabled
                        = barBtnLamMoi.Enabled = true;

                        lOPGridControl.Enabled = true;
                        pnControlLeft.Enabled = false;

                        this.lOPBindingSource.EndEdit();
                        this.lOPBindingSource.ResetCurrentItem();// tự động render để hiển thị dữ liệu mới
                        this.lOPTableAdapter1.Update(this.qLDSVDataSet.LOP);
                    }
                    catch (Exception ex)
                    {
                        lOPBindingSource.RemoveCurrent();
                        XtraMessageBox.Show("Ghi dữ liệu thất lại. Vui lòng kiểm tra lại!\n" + ex.Message, "Error",
                            MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
  
            }
            else
            {
                // lỗi thì return thôi.
                return;
            }

            //chỉ riêng 1 lệnh  dành cho subform
            loadInitializeData();

            if (Program.MGroup == Program.NhomQuyen[0])// PGV
            {
                cmbKhoa.Visible = true;
                cmbKhoa.Enabled = true;
                barBtnThem.Enabled = barBtnXoa.Enabled = barBtnSua.Enabled = barBtnThoat.Enabled = barBtnUndo.Enabled = true;
                barBtnHuy.Enabled = barBtnGhi.Enabled = false;
                lOPGridControl.Enabled = true;
                pnControlLeft.Enabled = false;

            }
            else
            {
                cmbKhoa.Visible = false;
                barBtnThem.Enabled = barBtnXoa.Enabled = barBtnSua.Enabled = barBtnThoat.Enabled = barBtnUndo.Enabled = true;
                barBtnHuy.Enabled = barBtnGhi.Enabled = false;
                lOPGridControl.Enabled = true;
                pnControlLeft.Enabled = false;
            }
            if (_positionLop > 0)
            {
                lOPBindingSource.Position = _positionLop;
            }
            if (_positionLop > 0)
            {
                lOPBindingSource.Position = _positionLop;
            }
         
        }

        private void barBtnHuy_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            lOPBindingSource.CancelEdit();

            // load lại cả form...
            frmLop_Load(sender, e);

            if (_positionLop > 0)
            {
                lOPBindingSource.Position = _positionLop;
            }
        }

        private void barBtnLammoi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

            frmLop_Load(sender, e);
            XtraMessageBox.Show("Làm mới dữ liệu thành công", "", MessageBoxButtons.OK);


        }

        private void barBtnThoat_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (pnControlLeft.Enabled || _flagUpdateSV )
            {
                String notifi=" ";
                String notifiLop = " Dữ liệu lớp chưa lưu vào Database. \n Bạn có chắc muốn thoát !";
                String notifiSV = "Dữ liệu sinh viên chưa lưu vào Database. \n Bạn có chắc muốn thoát ! ";
                if (pnControlLeft.Enabled)
                {
                    notifi = notifiLop;
                }else if (_flagUpdateSV)
                {
                    notifi = notifiSV;
                }

            
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
            else
            {
                this.Close();
                return;
            }


        }
        private bool ValidateInfoLOP()
        {
            errorProvider.Clear();

            // TODO : Check khoảng trống ở textField
            if (txtMaLop.Text.Trim().Equals(""))
            {
                this.errorProvider.SetError(txtMaLop, "Mã lớp không được để trống !");
                return false;
            }
            if (txtTenLop.Text.Trim().Equals(""))
            {
                this.errorProvider.SetError(txtTenLop, "Tên lớp không được để trống !");
                return false;
            }

            if (_flagOptionLop == "ADD")
            {
                //TODO: Check mã lớp có tồn tại chưa
                string query1 = "DECLARE  @return_value int \n"
                            + "EXEC  @return_value = SP_CHECKID \n"
                            + "@Code = N'" + txtMaLop.Text + "',@Type = N'MALOP' \n"
                            + "SELECT  'Return Value' = @return_value ";

                int resultMa = Utils.CheckDataHelper(query1);
                if (resultMa == -1)
                {
                    XtraMessageBox.Show("Lỗi kết nối với database. Mời ban xem lại !", "", MessageBoxButtons.OK);
                    this.Close();
                }
                if (resultMa == 1)
                {
                    this.errorProvider.SetError(txtMaLop, "Mã lớp đã tồn tại ở Khoa hiên tại !");
                    return false;
                }
                if (resultMa == 2)
                {
                    this.errorProvider.SetError(txtMaLop, "Mã lớp đã tồn tại ở Khoa khác !");
                    return false;
                }

                // TODO : Check tên lớp có tồn tại chưa
                string query2 = "DECLARE @return_value int \n"
                               + "EXEC @return_value = SP_CHECKNAME \n"
                               + "@Name = N'" + txtTenLop.Text + "', @Type = N'TENLOP' \n"
                               + "SELECT 'Return Value' = @return_value ";
                int resultTen = Utils.CheckDataHelper(query2);
                if (resultTen == -1)
                {
                    XtraMessageBox.Show("Lỗi kết nối với Database. Mời bạn xem lại !", "", MessageBoxButtons.OK);
                    this.Close();
                }
                if (resultTen == 1)
                {
                    this.errorProvider.SetError(txtTenLop, "Tên lớp đã có rồi !");
                    return false;
                }
                if (resultTen == 2)
                {
                    this.errorProvider.SetError(txtTenLop, "Tên lớp đã tồn tại ở Khoa khác !");
                    return false;
                }
            }

            if (_flagOptionLop == "UPDATE")
            {
                if (!this.txtMaLop.Text.Trim().ToString().Equals(_oldMaLop))// Nếu mã lớp thay đổi so với ban đầu
                {
                    //TODO: Check mã lớp có tồn tại chưa
                    string query1 = "DECLARE  @return_value int \n"
                                + "EXEC  @return_value = SP_CHECKID \n"
                                + "@Code = N'" + txtMaLop.Text + "',@Type = N'MALOP' \n"
                                + "SELECT  'Return Value' = @return_value ";

                    int resultMa = Utils.CheckDataHelper(query1);
                    if (resultMa == -1)
                    {
                        XtraMessageBox.Show("Lỗi kết nối với database. Mời ban xem lại !", "", MessageBoxButtons.OK);
                        this.Close();
                    }
                    if (resultMa == 1)
                    {
                        this.errorProvider.SetError(txtMaLop, "Mã lớp đã tồn tại ở Khoa hiên tại !");
                        return false;
                    }
                    if (resultMa == 2)
                    {
                        this.errorProvider.SetError(txtMaLop, "Mã lớp đã tồn tại ở Khoa khác !");
                        return false;
                    }
                }
                if (!this.txtTenLop.Text.Trim().ToString().Equals(_oldTenLop))
                {
                    // TODO : Check tên lớp có tồn tại chưa
                    string query2 = "DECLARE @return_value int \n"
                                   + "EXEC @return_value = SP_CHECKNAME \n"
                                   + "@Name = N'" + txtTenLop.Text + "', @Type = N'TENLOP' \n"
                                   + "SELECT 'Return Value' = @return_value ";
                    int resultTen = Utils.CheckDataHelper(query2);
                    if (resultTen == -1)
                    {
                        XtraMessageBox.Show("Lỗi kết nối với Database. Mời bạn xem lại !", "", MessageBoxButtons.OK);
                        this.Close();
                    }
                    if (resultTen == 1)
                    {
                        this.errorProvider.SetError(txtTenLop, "Tên lớp đã có rồi !");
                        return false;
                    }
                    if (resultTen == 2)
                    {
                        this.errorProvider.SetError(txtTenLop, "Tên lớp đã tồn tại ở Khoa khác !");
                        return false;
                    }
                }
            }

            return true;

        }

        private void txtMaLop_EditValueChanged(object sender, EventArgs e)
        {
            txtMaLop.Properties.CharacterCasing = CharacterCasing.Upper;
        }
        private void gridView1_CustomDrawRowIndicator(object sender, RowIndicatorCustomDrawEventArgs e)
        {
           
        }

        private void gridView1_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            if (lOPBindingSource.Position > 0)
            {
                _positionLop = lOPBindingSource.Position;
            }
        }

        private void conThem_Click(object sender, EventArgs e)
        {
            this.conThem.Enabled =
           this.conSua.Enabled = this.conXoa.Enabled = false;
            this.conGhi.Enabled = true;
            this.lOPGridControl.Enabled = false;
            this.barBtnGhi.Enabled = this.barBtnHuy.Enabled = this.barBtnSua.Enabled = this.barBtnUndo.Enabled =
                this.barBtnThem.Enabled = this.barBtnXoa.Enabled = false;
            this.cmbKhoa.Enabled = false;
            _flagUpdateSV = true;
            //chuẩn bị thêm
            sINHVIENBindingSource1.AddNew();


        }

        private void conSua_Click(object sender, EventArgs e)
        {
            this.conThem.Enabled =
           this.conSua.Enabled = this.conXoa.Enabled = false;
            this.conGhi.Enabled = true;
            this.lOPGridControl.Enabled = false;
            this.barBtnGhi.Enabled = this.barBtnHuy.Enabled = this.barBtnSua.Enabled = this.barBtnUndo.Enabled =
                this.barBtnThem.Enabled = this.barBtnXoa.Enabled = false;
            _flagUpdateSV = true;
            _flagSua = true;
            this.cmbKhoa.Enabled = false;


        }
        private bool KiemTraDongHocPhi(string maSV)
        {



            string query1 = " DECLARE @return_value int " +

                            " EXEC    @return_value = [dbo].[SP_CHECKIDHOCPHIBYMASV] " +

                            " @masv = N'" + maSV  + "'" +

                            " SELECT  'Return Value' = @return_value ";
            int resultMa = Utils.CheckDataHelper(query1);
            if (resultMa == -1)
            {
                XtraMessageBox.Show("Lỗi kết nối với database. Mời bạn xem lại", "", MessageBoxButtons.OK);
                this.Close();
            }
            if (resultMa == 1)
            {
                // trùng
                return true;
            }

            // ko trùng
            return false;
        }
        private void conXoa_Click(object sender, EventArgs e)
        {
            if (dIEMBindingSource.Count > 0)
            {
                XtraMessageBox.Show("Sinh viên này có dữ liệu, Không được xóa !", "", MessageBoxButtons.OK);
                return;
            }

            String maSVCurrent = ((DataRowView)sINHVIENBindingSource1[this.gridViewSinhVien.FocusedRowHandle])["MASV"].ToString();
            if (KiemTraDongHocPhi(maSVCurrent))
            {
                XtraMessageBox.Show("Sinh viên này có dữ liệu, Không được xóa !", "", MessageBoxButtons.OK);
                return;
            }

            if (XtraMessageBox.Show("Bạn có thực sự muốn xóa Sinh Viên này??", "Xác nhận.", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {
                    sINHVIENBindingSource1.RemoveCurrent();
                    this.sINHVIENTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
                    this.sINHVIENTableAdapter1.Update(this.qLDSVDataSet.SINHVIEN);
                    this.sINHVIENBindingSource1.ResetCurrentItem();// tự động render để hiển thị dữ liệu mới
                }
                catch (Exception ex)
                {
                    XtraMessageBox.Show("Lỗi xóa Sinh Viên.\nBạn hãy xem lại\n" + ex.Message, "", MessageBoxButtons.OK);
                }


            }


            if (_positionSV > 0)
            {

                sINHVIENBindingSource1.Position = _positionSV;
            }
        }

        private void conGhi_Click(object sender, EventArgs e)
        {
            bool check = true;
            int indexLastRow = sINHVIENBindingSource1.Count - 1;
            if (!_flagSua)
            {
                check = ValidateInfoSinhVien(indexLastRow);

            }
            if (check)
            {
                try
                {
                    this.conThem.Enabled 
                    = this.conGhi.Enabled
                    = this.conXoa.Enabled
                    = this.conSua.Enabled
                    = true;

                    this.lOPGridControl.Enabled = true;

                    this.sINHVIENBindingSource1.EndEdit();
                    this.sINHVIENBindingSource1.ResetCurrentItem();// tự động render để hiển thị dữ liệu mới
                    this.sINHVIENTableAdapter1.Update(this.qLDSVDataSet.SINHVIEN);

                    this.cmbKhoa.Enabled = true;
                    XtraMessageBox.Show("Ghi dữ liệu thành công !","Thành Công", MessageBoxButtons.OK);


                    _flagUpdateSV = false;
                    _flagSua = false;

                    // set lại vị trí
                    sINHVIENBindingSource1.Position = sINHVIENBindingSource1.Count - 1;
                }
                catch (Exception ex)
                {
                    this.sINHVIENBindingSource1.RemoveCurrent();
                    XtraMessageBox.Show("Ghi dữ liệu thất lại. Vui lòng kiểm tra lại!\n" + ex.Message, "Error",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {

                // focuse lại vị trí bị trùng để sửa
                this.gridViewSinhVien.FocusedRowHandle = indexLastRow;
                this.gridViewSinhVien.FocusedColumn = this.colMASV;

                // phân quyền nút
                this.conSua.Enabled = this.conXoa.Enabled = true;
                return;
            }

            if (_positionSV > 0)
            {
                sINHVIENBindingSource1.Position = _positionSV;
            }
        }


        private void conLamMoi_Click(object sender, EventArgs e)
        {
            this.conThem.Enabled= this.conSua.Enabled = this.conXoa.Enabled = true;

            this.lOPGridControl.Enabled = true;

            this.barBtnGhi.Enabled = this.barBtnHuy.Enabled = this.barBtnSua.Enabled = this.barBtnXoa.Enabled =
                this.barBtnThem.Enabled = this.barBtnUndo.Enabled = this.barBtnLamMoi.Enabled = true;

            this.cmbKhoa.Enabled = true;

            _flagSua = _flagUpdateSV = false;


         
            this.sINHVIENTableAdapter1.Connection.ConnectionString = Program.URL_Connect;
            this.dIEMTableAdapter.Connection.ConnectionString = Program.URL_Connect;

       
            this.sINHVIENTableAdapter1.Fill(this.qLDSVDataSet.SINHVIEN);
            this.dIEMTableAdapter.Fill(this.qLDSVDataSet.DIEM);

            XtraMessageBox.Show("Làm mới dữ liệu thành công", "", MessageBoxButtons.OK);

            if (_positionSV > 0)
            {
                sINHVIENBindingSource1.Position = _positionSV;
            }
        }
     

        private bool ValidateInfoSinhVien(int position)
        {
            string maSV = this.gridViewSinhVien.GetRowCellValue(position, "MASV").ToString();
           
            if (maSV == _oldMaSV)
            {
                return true;
            }
            if(string.IsNullOrEmpty(maSV))
            {
                XtraMessageBox.Show("Mã Sinh Viên không được để trống", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
                //TODO: Check mã sinh viên có tồn tại chưa
            string query1 = " DECLARE @return_value INT " + 

                            " EXEC @return_value = [dbo].[SP_CHECKID] " + 

                            " @Code = N'" + maSV +  "',  " +

                            " @Type = N'MASV' " +

                            " SELECT  'Return Value' = @return_value ";

                int resultMa = Utils.CheckDataHelper(query1);
                if (resultMa == -1)
                {
                XtraMessageBox.Show("Lỗi kết nối với database. Mời bạn xem lại", "", MessageBoxButtons.OK);
                    this.Close();
                }
                if (resultMa == 1)
                {
                XtraMessageBox.Show("Mã Sinh Viên đã tồn tại. Mời bạn chon mã khác !", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
                }
            if (resultMa == 2)
            {
                XtraMessageBox.Show("Mã Sinh Viên đã tồn tại ở Khoa khác. Mời bạn nhập lại !", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }


            return true;
        }

        private void gridViewSinhVien_ShowingEditor(object sender, CancelEventArgs e)
        {
            // phân quyền cho phòng giáo vụ


            if (_flagSua)
            {
                _positionSV = this.gridViewSinhVien.FocusedRowHandle;
                _oldMaSV = ((DataRowView)sINHVIENBindingSource1[this.gridViewSinhVien.FocusedRowHandle])["MASV"].ToString();
                return;
            }


            if (!this.gridViewSinhVien.IsNewItemRow(this.gridViewSinhVien.FocusedRowHandle))
            {
                e.Cancel = true;

            }
            int indexLastRow = sINHVIENBindingSource1.Count - 1;

          

            if ( indexLastRow == this.gridViewSinhVien.FocusedRowHandle && _flagUpdateSV)
            {
                e.Cancel = false;
            }




        }

        private void gridViewSinhVien_ValidateRow(object sender, DevExpress.XtraGrid.Views.Base.ValidateRowEventArgs e)
        {
            if (_flagSua) {
                GridView view = sender as GridView;
                bool check = ValidateInfoSinhVien(view.FocusedRowHandle);
                if (!check)
                {
                    e.Valid = false;
                    view.SetColumnError(this.colMASV, "Mã sinh viên bị trùng !");
                }
              

            }
         
        }

        private void gridViewSinhVien_InvalidRowException(object sender, DevExpress.XtraGrid.Views.Base.InvalidRowExceptionEventArgs e)
        {
            e.ExceptionMode = ExceptionMode.NoAction;
        }

        private void gridViewSinhVien_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            if (sINHVIENBindingSource1.Position > 0)
            {
                //_positionSV = bdsSV.Count - 1;
                _positionSV = this.sINHVIENBindingSource1.Position;
            }
        }

        private void gridViewSinhVien_InitNewRow(object sender, InitNewRowEventArgs e)
        {

            GridView view = sender as GridView;
            view.SetRowCellValue(e.RowHandle, view.Columns["NGHIHOC"], 0);
            view.SetRowCellValue(e.RowHandle, view.Columns["PHAI"], 1);
        }

        private void gridView1_MasterRowGetRelationDisplayCaption(object sender, MasterRowGetRelationNameEventArgs e)
        {
            e.RelationName = "Danh sách sinh viên";
        }

        private void repositoryItemTextEditMaSV_EditValueChanged(object sender, EventArgs e)
        {
            // thường thành hoa
            repositoryItemTextEditMaSV.CharacterCasing = CharacterCasing.Upper;
        }

        private void gridView1_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
           
        }

        private void gridViewSinhVien_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            
        }

        private void gridViewSinhVien_CustomDrawRowIndicator(object sender, RowIndicatorCustomDrawEventArgs e)
        {
        }
    }
}