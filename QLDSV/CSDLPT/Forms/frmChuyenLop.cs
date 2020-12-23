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
    public partial class frmChuyenLop : DevExpress.XtraEditors.XtraForm
    {
        private int STATE = 0;
        private List<string> myListMASV = new List<string>();
        public frmChuyenLop()
        {
            InitializeComponent();
        }

        private void frmChuyenLop_Load(object sender, EventArgs e)
        {
            this.sINHVIENTableAdapter.Connection.ConnectionString = Program.URL_Connect;
            this.sINHVIENTableAdapter.Fill(this.qLDSVDataSet.SINHVIEN);
            this.buttonOK.Visible = false;
            this.labelMaSVMoi.Visible = false;
            this.txtMaSVMoi.Visible = false;
            this.labelSupport.Visible = false;

            this.labelKhoa.Text = ((DataRowView)Program.Bds_Dspm[Program.MKhoa])["TENKHOA"].ToString();

        }

        private void buttonOK_Click(object sender, EventArgs e)
        {
            string maSVTextBox = this.txtMaSV.Text.Trim().ToString();
            string maLopChuyenDenTextBox = this.txtMaLopChuyenDen.Text.Trim().ToString();

            string QUERY = "";
            string MASV = "";

            SqlCommand command;
            SqlDataAdapter adapter = new SqlDataAdapter();

            using (SqlConnection connection = new SqlConnection(Program.URL_Connect))
            {
                connection.Open();


                Console.WriteLine("Ma Sinh Vien : " + MASV);


                if (STATE == 1)// CHUYỂN LỚP CÙNG KHOA
                {
                    QUERY = "Update SINHVIEN SET MALOP='" + maLopChuyenDenTextBox + "' WHERE MASV='" + maSVTextBox + "'";
                    command = new SqlCommand(QUERY, connection);
                    adapter.UpdateCommand = new SqlCommand(QUERY, connection);
                    adapter.UpdateCommand.ExecuteNonQuery();
                    XtraMessageBox.Show("Chuyển Sinh Viên Cùng Khoa, Vào Lớp " + maLopChuyenDenTextBox + " Thành Công", "Info", MessageBoxButtons.OK);
                    return;
                }

                if (STATE == 2) //  CHUYỂN LỚP KHÁC KHOA -LỚP ĐÓ ĐANG TRỐNG
                {
                    string nienkhoa = maLopChuyenDenTextBox.Substring(1, 2);
                    string major = maLopChuyenDenTextBox.Substring(5, 2);
                    string newID = "N" + nienkhoa + "DC" + major + "001";

                    QUERY = "SP_CHUYENLOP";
                    command = new SqlCommand(QUERY, connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("MASV", maSVTextBox);
                    command.Parameters.AddWithValue("MASVMOI", newID);
                    command.Parameters.AddWithValue("MALOPCHUYENDEN", maLopChuyenDenTextBox);

                    try
                    {
                        command.ExecuteNonQuery();
                        XtraMessageBox.Show("Chuyển Sinh Viên Qua Lớp " + maLopChuyenDenTextBox + " Thành Công", "INFO", MessageBoxButtons.OK);
                        return;
                    }
                    catch (Exception ex)
                    {
                        XtraMessageBox.Show(ex.Message, "INFO", MessageBoxButtons.OK);
                    }
                    command.Dispose();
                }

                if (STATE == 3)
                {
                    if (checkValidatedMASV(this.txtMaSVMoi.Text.Trim().ToString()) == false)
                    {
                        this.buttonOK.Visible = false;
                        this.txtMaSVMoi.Text = "";
                        this.labelSupport.Text = "Mã Sinh Viên Đã Tồn Tại, vui lòng kiểm tra lại!";
                        return;
                    }
                    else
                    {
                        string newID = this.txtMaSVMoi.Text.Trim().ToString();

                        QUERY = "SP_CHUYENLOP";
                        command = new SqlCommand(QUERY, connection);
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("MASV", maSVTextBox);
                        command.Parameters.AddWithValue("MASVMOI", newID);
                        command.Parameters.AddWithValue("MALOPCHUYENDEN", maLopChuyenDenTextBox);

                        try
                        {
                            command.ExecuteNonQuery();
                            XtraMessageBox.Show("Chuyển sinh viên qua lớp: " + maLopChuyenDenTextBox + " thành công!", "Thông báo!", MessageBoxButtons.OK);
                            return;
                        }
                        catch (Exception ex)
                        {
                            XtraMessageBox.Show(ex.Message, "Thông báo!", MessageBoxButtons.OK);
                        }
                    }
                    command.Dispose();
                }

                connection.Close();

            }
        }

        private void button_Check_Click(object sender, EventArgs e)
        {
            if (this.txtMaSV.Text.Trim().ToString().Equals("") || this.txtMaLopChuyenDen.Text.Trim().ToString().Equals(""))
            {
                XtraMessageBox.Show("Bạn phải điền thông tin Mã Sinh Viên Và Mã Lớp chuyển Đến !", "Thông báo", MessageBoxButtons.OK);
                return;
            }

            string QUERY;
            string MASV = "";
            string MALOP = "";
            SqlCommand command;
            SqlDataReader dataReader;
            SqlDataAdapter adapter = new SqlDataAdapter();
            using (SqlConnection connection = new SqlConnection(Program.URL_Connect))
            {

                connection.Open();

                QUERY = string.Format("SELECT MASV FROM dbo.SINHVIEN WHERE MASV = '" + this.txtMaSV.Text.Trim().ToString() + "'");
                command = new SqlCommand(QUERY, connection);
                command.CommandType = CommandType.Text;
                try
                {
                    MASV = (String)command.ExecuteScalar();
                }
                catch { }

                if (MASV == null)
                {
                    MessageBox.Show("Mã Sinh Viên Không Tồn Tại Ở Khoa Này, Vui lòng kiểm tra ở khoa khác!");
                    this.txtMaSV.Focus();
                    return;
                }
                else 
                {
                    QUERY = string.Format("SELECT NGHIHOC FROM dbo.SINHVIEN WHERE MASV = '" + this.txtMaSV.Text.Trim().ToString() + "'");
                    command = new SqlCommand(QUERY, connection);
                    command.CommandType = CommandType.Text;
                    bool nghihoc = false;
                    try
                    {
                        nghihoc = (Boolean)command.ExecuteScalar();
                    }
                    catch { }
                    if (nghihoc == true)
                    {
                        Console.WriteLine("Status Nghi Hoc : " + nghihoc);
                        this.labelSupport.Visible = true;
                        this.labelSupport.Text = "Không thể chuyển sinh viên này vì đã nghỉ học";
                        this.txtMaSV.Focus();
                        return;
                    }
                    QUERY = string.Format("SELECT MALOP FROM dbo.LOP WHERE MALOP = '" + this.txtMaLopChuyenDen.Text.Trim().ToString() + "'");
                    command = new SqlCommand(QUERY, connection);
                    command.CommandType = CommandType.Text;
                    try
                    {
                        MALOP = (String)command.ExecuteScalar();
                    }
                    catch { }

                    if (MALOP != null) 
                    {
                        labelSupport.Visible = true;
                        labelSupport.Text = "Chấp Nhận Chuyển Lớp Cùng Khoa!";
                        this.buttonOK.Visible = true;
                        STATE = 1;
                        return;
                    }
                    else 
                    {
                        QUERY = "SELECT MALOP FROM LINK0.QLDSV.dbo.LOP WHERE MALOP = '" + this.txtMaLopChuyenDen.Text.Trim().ToString() + "'";
                        command = new SqlCommand(QUERY, connection);
                        command.CommandType = CommandType.Text;
                        try
                        {
                            MALOP = (String)command.ExecuteScalar();
                        }
                        catch { }

                        if (MALOP == null) 
                        {
                            XtraMessageBox.Show("Mã Lớp Không Tồn Tại Trong Cơ Sở Dữ Liệu!");
                            this.txtMaLopChuyenDen.Focus();
                            return;
                        }
                        if (MALOP != null) 
                        {
                            QUERY = "SELECT TOP 1 MASV FROM LINK0.QLDSV.dbo.SINHVIEN WHERE MALOP = '" + this.txtMaLopChuyenDen.Text.Trim().ToString() + "' ORDER BY MASV DESC";
                            command = new SqlCommand(QUERY, connection);
                            command.CommandType = CommandType.Text;
                            try
                            {
                                MASV = (String)command.ExecuteScalar();
                            }
                            catch { }

                            if (MASV == null)
                            {
                                labelSupport.Visible = true;
                                this.labelSupport.Text = "Lớp hiện đang trống! Mã Sinh Viên sẽ được hệ thống tạo tự động";
                                this.buttonOK.Visible = true;
                                STATE = 2;
                                return;
                            }
                            else 
                            {
                                QUERY = string.Format("SELECT MASV FROM LINK0.QLDSV.dbo.SINHVIEN");
                                command = new SqlCommand(QUERY, connection);
                                dataReader = command.ExecuteReader();
                                while (dataReader.Read())
                                {
                                    myListMASV.Add(dataReader.GetValue(0).ToString());
                                }
                             
                                dataReader.Close();

                                labelSupport.Visible = true;
                                this.labelSupport.Text = "Mã sinh viên cuối danh sách của lớp là : " + MASV;

                                this.labelMaSVMoi.Visible = true;
                                this.txtMaSVMoi.Visible = true;

                                this.buttonOK.Visible = true;
                                STATE = 3; 
                            }
                            command.Dispose();
                            connection.Close();
                        }
                    }
                }
            }
        }

        private void buttonCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        public bool checkValidatedMASV(string maSVMoi)
        {
            bool x = false;
            foreach (string masv in myListMASV)
            {
                Console.WriteLine(masv);
                x = string.Equals(masv.Trim(), maSVMoi);
                if (x == true)
                {
                    return false;
                }
            }
            return true;
        }

        class SinhVien
        {
            private string MASV;
            private string HO;
            private string TEN;
            private string MALOP;
            private string PHAI;
            private string NGAYSINH;
            private string NOISINH;
            private string DIACHI;
            private string GHICHU;
            private string NGHIHOC;

            public SinhVien()
            {

            }

            public void setMASV(string MASV)
            {
                this.MASV = MASV;
            }
            public void setHO(string HO)
            {
                this.HO = HO;
            }
            public void setTEN(string TEN)
            {
                this.TEN = TEN;
            }
            public void setMALOP(string MALOP)
            {
                this.MALOP = MALOP;
            }
            public void setPHAI(string PHAI)
            {
                this.PHAI = PHAI;
            }
            public void setNGAYSINH(string NGAYSINH)
            {
                this.NGAYSINH = NGAYSINH;
            }
            public void setNOISINH(string NOISINH)
            {
                this.NOISINH = NOISINH;
            }
            public void setDIACHI(string DIACHI)
            {
                this.DIACHI = DIACHI;
            }
            public void setGHICHU(string GHICHU)
            {
                this.GHICHU = GHICHU;
            }
            public void setNGHIHOC(string NGHIHOC)
            {
                this.NGHIHOC = NGHIHOC;
            }

            public string getMASV()
            {
                return MASV;
            }
            public string getHO()
            {
                return HO;
            }
            public string getTEN()
            {
                return TEN;
            }
            public string getMALOP()
            {
                return MALOP;
            }
            public string getPHAI()
            {
                return PHAI;
            }
            public string getNGAYSINH()
            {
                return NGAYSINH;
            }
            public string getNOISINH()
            {
                return NOISINH;
            }
            public string getDIACHI()
            {
                return DIACHI;
            }
            public string getGHICHU()
            {
                return GHICHU;
            }
            public string getNGHIHOC()
            {
                return NGHIHOC;
            }


            public string ToStringSinhVien()
            {
                return MASV + "-" + HO + "-" + TEN + "-" + MALOP + "-" + PHAI + "-" + NGAYSINH + "-" + NOISINH + "-" + DIACHI + "-" + GHICHU + "-" + NGHIHOC;
            }

        }

        private void lookUpEditChuyenLop_EditValueChanged(object sender, EventArgs e)
        {
            var selectedSV = lookUpEditChuyenLop.GetSelectedDataRow() as DataRowView;

            txtTenSV.Text = selectedSV.Row["HO"] + " " + selectedSV.Row["TEN"];
            txtMaLop.Text = selectedSV.Row["MALOP"].ToString();
            txtMaSV.Text = selectedSV.Row["MASV"].ToString().Trim();
        }
    }
}