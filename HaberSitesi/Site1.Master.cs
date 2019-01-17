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
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected ResourceManager resourceManager = Lang.English.ResourceManager;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserLogin"] == null)
                Session.Add("UserLogin", false);
            if(Session["isEditor"] == null)
                Session.Add("isEditor", false);

            //eğer kullanıcı editör ise view ona göre değişir
            if ((bool)Session["isEditor"] == true)
            {
                MultiView1.ActiveViewIndex = 2;
                LblHelloEdt.Text = resourceManager.GetString("LblHelloEdt") + ' ' + Session["Username"];
            }
            else if ((bool)Session["UserLogin"] == true) //normal kullanıcı view'ı
            {
                MultiView1.ActiveViewIndex = 1;
                LblHelloUsr.Text = resourceManager.GetString("LblHelloUsr")+ ' ' + Session["Username"];
            }
            else
            {
                MultiView1.ActiveViewIndex = 0; //kullanıcı girişi yapılmadığı durumlar
            }

            if (Session["Userid"] == null)
                Session.Add("Userid", 0);
            if (Session["Cfgid"] == null)
                Session.Add("Cfgid", 0);
            if (Session["Lang"] == null)
                Session.Add("Lang", "English");

            //dil seçeneklerine göre labelları ve butonları güncelleme
            if ((string)Session["Lang"] == "Turkish")
                resourceManager = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                resourceManager = Lang.French.ResourceManager;

            LblUsr.Text = resourceManager.GetString("LblUsr");
            LblPass.Text = resourceManager.GetString("LblPass");
            BtnLogin.Text = resourceManager.GetString("BtnLogin");
            BtnSignUp.Text = resourceManager.GetString("BtnSignUp");
            BtnSettings.Text = resourceManager.GetString("BtnSettings");
            BtnSettingsE.Text = resourceManager.GetString("BtnSettings");
            BtnAddNews.Text = resourceManager.GetString("BtnAddNews");
            BtnLogout.Text = resourceManager.GetString("BtnLogout");
            BtnLogoutE.Text = resourceManager.GetString("BtnLogout");
            BtnWorld.Text = resourceManager.GetString("BtnWorld");
            BtnBusiness.Text = resourceManager.GetString("BtnBusiness");
            BtnTech.Text = resourceManager.GetString("BtnTech");
            BtnScience.Text = resourceManager.GetString("BtnScience");
            BtnHealth.Text = resourceManager.GetString("BtnHealth");
            BtnVideo.Text = resourceManager.GetString("BtnVideo");
            BtnSport.Text = resourceManager.GetString("BtnSport");
            LblHome.Text = resourceManager.GetString("LblHome");
            LblAbout.Text = resourceManager.GetString("LblAbout");
            LblContact.Text = resourceManager.GetString("LblContact");
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            bool login = false;
            bool editor = false;
            string usrname = TxtUsr.Text;
            string pass = TxtPass.Text;

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
                            if(r.GetInt32(3) == 1) //isBlocked değeri 1 olduğu durumda kullanıcı engellenmiştir.
                            {
                                Response.Write("You are blocked or ");
                                break;
                            }
                            int usrid = r.GetInt32(0);
                            Session["Userid"] = usrid;
                            Session["Username"] = username;
                            r.Close();
                            SqlCommand c2 = new SqlCommand("SELECT usrid FROM tblEditor"); //editör tablosunda aramak için
                            c2.Connection = sc;
                            SqlDataReader r2 = c2.ExecuteReader();
                            if(r2.HasRows)
                                while(r2.Read()) //editör tablosundaki her satır veri için kontrol edilir
                                {
                                    int usridcheck = r2.GetInt32(0); //editörün kullanıcı idsi
                                    if (usrid == usridcheck) //true ise kullanıcı editördür
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
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                Response.Write("invalid username or password!");
            }
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUp.aspx");
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            //Session.Clear() da yapılabilir
            Session["UserLogin"] = false;
            Session["isEditor"] = false;
            Session["Userid"] = 0;
            MultiView1.ActiveViewIndex = 0;
            Response.Redirect(Request.RawUrl); //hangi sayfadaysak o sayfaya yönlendiriliriz
        }

        protected void BtnSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("Settings.aspx");
        }

        protected void BtnAddNews_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditorPage.aspx");
        }

        protected void BtnWorld_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category","World");
            else
                Session["Category"] = "World";
            Response.Redirect("NewsByCat.aspx");  
        }

        protected void BtnBusiness_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category", "Business");
            else
                Session["Category"] = "Business";
            Response.Redirect("NewsByCat.aspx");
        }

        protected void BtnTech_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category", "Technology");
            else
                Session["Category"] = "Technology";
            Response.Redirect("NewsByCat.aspx");
        }

        protected void BtnScience_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category", "Science");
            else
                Session["Category"] = "Science";
            Response.Redirect("NewsByCat.aspx");
        }

        protected void BtnHealth_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category", "Health");
            else
                Session["Category"] = "Health";
            Response.Redirect("NewsByCat.aspx");
        }

        protected void BtnVideo_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category", "Video");
            else
                Session["Category"] = "Video";
            Response.Redirect("NewsByCat.aspx");
        }

        protected void BtnSport_Click(object sender, EventArgs e)
        {
            if (Session["Category"] == null)
                Session.Add("Category", "Sport");
            else
                Session["Category"] = "Sport";
            Response.Redirect("NewsByCat.aspx");
        }

        protected void ImageButtonEn_Click(object sender, ImageClickEventArgs e)
        {
            if(Session["Lang"] == null)
                Session.Add("Lang", "English");
            else
                Session["Lang"] = "English";
            Response.Redirect(Request.RawUrl);
        }

        protected void ImageButtonTr_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["Lang"] == null)
                Session.Add("Lang", "Turkish");
            else
                Session["Lang"] = "Turkish";
            Response.Redirect(Request.RawUrl);
        }

        protected void ImageButtonFr_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["Lang"] == null)
                Session.Add("Lang", "French");
            else
                Session["Lang"] = "French";
            Response.Redirect(Request.RawUrl);
        }
    }
}