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
    public partial class SignUp : System.Web.UI.Page
    {
        protected ResourceManager resourceManager = Lang.English.ResourceManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            //zaten giriş yapılıysa ana sayfaya yönlendir
            if (Session["UserLogin"] != null)
                if ((bool)Session["UserLogin"] == true)
                    Response.Redirect("Home.aspx");

            //dil seçeneklerine göre labelları ve butonu güncelleme
            if ((string)Session["Lang"] == "Turkish")
                resourceManager = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                resourceManager = Lang.French.ResourceManager;

            LblSignUp.Text = resourceManager.GetString("LblSignUp");
            LblSemail.Text = resourceManager.GetString("Lblemail");
            LblSusrname.Text = resourceManager.GetString("LblusrS");
            LblSpass.Text = resourceManager.GetString("LblpassS");
            BtnSignUp.Text = resourceManager.GetString("BtnSignUp");
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

            bool chkData = false; //eğer aynı isim ve mailde hesap varsa true olacak ve hata verecek

            if (usrname.Length == 0 || password.Length == 0 || mail.Length == 0
                    || usrname.Length >= 30 || password.Length >= 30 || mail.Length >= 30)
            {
                Response.Write("Please, enter maximum 30 characters!");
            }
            else if ((bool)Session["UserLogin"] == false)
            {

                if(usrname != null || password != null || mail != null)
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
                            SqlCommand c2 = new SqlCommand("EXECUTE spInsertUser '"+usrname+"', '"+password+"', '"+mail+ "'");
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
    }
}