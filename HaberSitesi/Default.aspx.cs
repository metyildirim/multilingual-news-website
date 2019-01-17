using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Resources;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace HaberSitesi
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //kullanıcı girişi hakkında session yoksa false değeri ile UserLogin session oluşturulur.
            if (Session["UserLogin"] == null)
                Session.Add("UserLogin", false);

            //kullanıcı giriş yapılı haldeyse anasayfaya yönlendir
            if ((bool)Session["UserLogin"] == true)
                Response.Redirect("Home.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string lang;
            lang = DropDownList1.SelectedValue;

            if (Session["Lang"] == null)
                Session.Add("Lang", lang);
            else {
                Session["Lang"] = lang;
            }

            Response.Redirect("Home.aspx");
        }

        protected void ImageBtnLogo_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            if (Session["UserLogin"] == null)
                Session.Add("UserLogin", false);

            string usrname;
            usrname = txtSUsername.Text;
            string password;
            password = txtSPassword.Text;
            string mail;
            mail = txtSEmail.Text;

            bool chkData = false; //eğer aynı isim ve mailde hesap varsa true olacak

            if (usrname.Length == 0 || password.Length == 0 || mail.Length == 0
                    || usrname.Length >= 30 || password.Length >= 30 || mail.Length >= 30)
            {
                Response.Write("Please, enter maximum 30 characters!");
            }
            else if ((bool)Session["UserLogin"] == false)
            {

                if (usrname != null || password != null || mail != null)
                {
                    var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                    SqlConnection sc = new SqlConnection(connection.ConnectionString);
                    try
                    {
                        sc.Open();
                        SqlCommand c = new SqlCommand("SELECT usrname, email FROM tblUser");
                        c.Connection = sc;
                        SqlDataReader r = c.ExecuteReader();
                        if (r.HasRows)
                        {
                            while (r.Read())
                            {
                                string username = r.GetString(0);
                                string email = r.GetString(1);

                                if (usrname == username || mail == email)
                                {
                                    chkData = true;
                                }
                            }
                            r.Close();
                        }
                        if (chkData)
                        {
                            Response.Write("You can't use this username or email");
                        }
                        else
                        {
                            r.Close();
                            SqlCommand c2 = new SqlCommand("EXECUTE spInsertUser '" + usrname + "', '" + password + "', '" + mail + "'");
                            c2.Connection = sc;
                            c2.ExecuteNonQuery();
                            Response.Write("Success!");
                        }

                    }
                    catch (SqlException ex)
                    {
                        Response.Write("Error!" + ex.Message);
                    }
                    finally
                    {
                        sc.Close();
                        sc.Dispose();
                    }
                }
                else
                {
                    Response.Write("Error! Please, fill all the blanks");
                }
            }
            else
            {
                Response.Write("Error! You already has an account");
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            bool login = false;
            bool editor = false;
            string usrname = txtLusername.Text;
            string pass = txtLPassword.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

            try
            {
                sc.Open();
                SqlCommand c = new SqlCommand("SELECT usrid,usrname,pwd,isBlocked FROM tblUser");
                c.Connection = sc;
                SqlDataReader r = c.ExecuteReader();

                if (r.HasRows)
                {
                    while (r.Read())
                    {
                        string username = r.GetString(1);
                        string password = r.GetString(2);

                        if (usrname == username && pass == password)
                        {
                            if (r.GetInt32(3) == 1)
                            {
                                Response.Write("You are blocked or ");
                                break;
                            }
                            int usrid = r.GetInt32(0);
                            Session["Username"] = username;
                            Session["Userid"] = usrid;
                            r.Close();
                            SqlCommand c2 = new SqlCommand("SELECT usrid FROM tblEditor");
                            c2.Connection = sc;
                            SqlDataReader r2 = c2.ExecuteReader();
                            if (r2.HasRows)
                                while (r2.Read())
                                {
                                    int usridcheck = r2.GetInt32(0);
                                    if (usrid == usridcheck)
                                        editor = true;
                                    break;
                                }
                            login = true;
                            break;
                        }
                        else
                        {
                            login = false;
                        }
                    }
                }
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

            if (editor == true)
            {
                Session["isEditor"] = true;
            }

            if (login == true)
            {
                Response.Write("Success!");
                Session["UserLogin"] = true;
                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Write("invalid username or password!");
            }
        }
    }
}