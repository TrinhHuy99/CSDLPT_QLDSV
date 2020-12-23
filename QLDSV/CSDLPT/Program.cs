using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using DevExpress.UserSkins;
using DevExpress.Skins;
using System.Data.SqlClient;
using System.Data;
using DevExpress.XtraEditors;

namespace QLDSV
{
    static class Program
    {
        
        public static SqlCommand Sqlcmd = new SqlCommand();
        public static SqlConnection Conn = new SqlConnection();
        public static String URL_Connect;
        public static SqlDataReader MyReader;
        public static String ServerName = string.Empty;
        public static String UserName = string.Empty;
        public static String MLogin = string.Empty;
        public static String MPassword = string.Empty;

        // RemoteLogin này là remote dùng để hỗ trợ kết nối ra ngoài ví dụ trong quá trình đăng nhập nó sẽ rẽ qua server 
        public static String RemoteLogin = "HTKN";
        public static String RemotePassword = "123";
        public static String Database = "QLDSV";
        public static String MLoginDN = string.Empty;
        public static String PasswordDN = string.Empty;
        public static String MGroup = string.Empty;
        public static String MHoten = string.Empty;
        public static int MKhoa = 0;

        //biến dùng để chứa danh sách các phân mãnh từ viewDSPM (bằng code, ko kéo thả)
        public static BindingSource Bds_Dspm = new BindingSource(); //giu DSPM khi dang nhap
        public static frmMain frmMain;
        public static frmDangNhap FrmDangNhap;

        // lưu danh sách các nhóm quyền
        public static string[] NhomQuyen = new string[4] {"PGV", "KHOA", "PKETOAN","USER"};
       

        // hàm thực hiện kết nối tới Database
        public static int KetNoi()
        {
            if (Program.Conn != null && Program.Conn.State == ConnectionState.Open)
                // đóng đối tượng kết nối
                Program.Conn.Close();
            try
            {
                Program.URL_Connect = "Data Source=" + Program.ServerName + ";Initial Catalog=" +
                      Program.Database + ";User ID=" +
                      Program.MLogin + ";Password=" + Program.MPassword;
                Program.Conn.ConnectionString = Program.URL_Connect;

                // mở đối tượng kết nối
                Program.Conn.Open();
                return 1;
            }

            catch (Exception e)
            {
                XtraMessageBox.Show("---> Lỗi kết nối cơ sở dữ liệu.\n---> Bạn xem lại Username và Password.\n " + e.Message, string.Empty, MessageBoxButtons.OK);
                return 0;
            }
        }


        public static SqlDataReader ExecSqlDataReader(String strLenh)
        {
            SqlDataReader myReader;
            SqlCommand sqlcmd = new SqlCommand(strLenh, Program.Conn);

            //xác định kiểu lệnh cho sqlcmd là kiểu text.
            sqlcmd.CommandType = CommandType.Text;
            sqlcmd.CommandTimeout = 600;
            if (Program.Conn.State == ConnectionState.Closed) Program.Conn.Open();
            try
            {
                myReader = sqlcmd.ExecuteReader();
                return myReader;
            }
            catch (SqlException ex)
            {
                Program.Conn.Close();
                XtraMessageBox.Show(ex.Message);
                return null;
            }
        }

        public static DataTable ExecSqlDataTable(String cmd)
        {
            DataTable dt = new DataTable();
            if (Program.Conn.State == ConnectionState.Closed) Program.Conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd, Conn);
            da.Fill(dt);
            Conn.Close();
            return dt;
        }
        public static int ExecSqlNonQuery(String strlenh)
        {
            SqlCommand Sqlcmd = new SqlCommand(strlenh, Conn);
            Sqlcmd.CommandType = CommandType.Text;
            Sqlcmd.CommandTimeout = 600;// 10 phut 
            if (Conn.State == ConnectionState.Closed) Conn.Open();
            try
            {
                Sqlcmd.ExecuteNonQuery(); Conn.Close();
                return 0;
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("Error converting data type varchar to int"))
                    MessageBox.Show("Bạn format Cell lại cột \"Ngày Thi\" qua kiểu Number hoặc mở File Excel.");
                else if(ex.Message.Contains("Violation of PRIMARY KEY constraint 'PK_CT_DONGHOCPHI'. Cannot insert duplicate key in object 'dbo.CT_DONGHOCPHI'"))
                    MessageBox.Show("Hôm nay đã đóng học phí !!!");

                else MessageBox.Show(ex.Message);
                Conn.Close();
                return ex.State; // trang thai lỗi gởi từ RAISERROR trong SQL Server qua
            }
        }

        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            BonusSkins.Register();
            SkinManager.EnableFormSkins();
           
            Program.FrmDangNhap = new frmDangNhap();
            Application.Run(Program.FrmDangNhap);

        }
    }
}
