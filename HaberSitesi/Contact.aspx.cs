using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Resources;

namespace HaberSitesi
{
    public partial class Contact : System.Web.UI.Page
    {
        protected ResourceManager rm = Lang.English.ResourceManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Lang"] == null)
                Session.Add("Lang", "English");

            if ((string)Session["Lang"] == "Turkish")
                rm = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                rm = Lang.French.ResourceManager;

            //seçilen dile göre labellar ve butonların textleri değiştirilir.
            LblWrite.Text = rm.GetString("WriteMessage");
            LblName.Text = rm.GetString("Name");
            LblSname.Text = rm.GetString("Surname");
            LblMail.Text = rm.GetString("Email");
            LblMsg.Text = rm.GetString("Message");
            LblMsg2.Text = rm.GetString("Message");
            BtnSend.Text = rm.GetString("Send");
            BtnSend2.Text = rm.GetString("Send");

            if (Session["UserLogin"] == null)
                Session.Add("UserLogin", false);

            /* kullanıcı giriş yaptıysa, sadece mesaj göndereceği kutudan oluşan view gözükür, aksi halde kullanıcı
            isim soyisim email gibi bilgilerini girebileceği view gözükür */
            if ((bool)Session["UserLogin"] == false)
                MultiView1.ActiveViewIndex = 0;
            else
                MultiView1.ActiveViewIndex = 1;
        }

        protected void BtnSend_Click(object sender, EventArgs e)
        {
            if (TxtMsg.Text.Length > 500 || TxtMsg2.Text.Length > 500)
                Response.Write("Message should be 500 characters or less!");
            else if (Session["UserLogin"] != null)
            {
                if (Convert.ToInt32(Session["UserLogin"]) == 0)
                {
                    string msg;
                    msg = TxtMsg.Text;
                    string name;
                    name = TxtName.Text;
                    string sname;
                    sname = TxtSname.Text;
                    string mail;
                    mail = TxtMail.Text;

                    var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                    SqlConnection sc = new SqlConnection(connection.ConnectionString);

                    try
                    {
                        sc.Open();
                        SqlCommand c = new SqlCommand("EXECUTE spInsertOtherMessage '"+msg+"', '"+name+"', '"+sname+"', '"+mail+"'");
                        c.Connection = sc;
                        c.ExecuteNonQuery();
                            
                        Response.Write("Message sent!");
                    }
                    catch (SqlException ex)
                    {
                        Response.Write("Failed: " + ex.Message);
                    }
                    finally
                    {
                        sc.Close();
                        sc.Dispose();
                    }
                }
                else
                {
                    string msg;
                    msg = TxtMsg2.Text;
                    int usrid = (int)Session["Userid"];

                    var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                    SqlConnection sc = new SqlConnection(connection.ConnectionString);

                    try
                    {
                        sc.Open();
                        SqlCommand c = new SqlCommand("EXECUTE spInsertMessage '" + msg + "', " + usrid);
                        c.Connection = sc;
                        c.ExecuteNonQuery();

                        Response.Write("Message sent!");
                    }
                    catch (SqlException ex)
                    {
                        Response.Write("Failed: " + ex.Message);
                    }
                    finally
                    {
                        sc.Close();
                        sc.Dispose();
                    }
                }
            }
            else
            {
                Response.Write("Error!");
            }
        }
    }
}