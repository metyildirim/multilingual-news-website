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
    public partial class Settings : System.Web.UI.Page
    {
        protected ResourceManager resourceManager = Lang.English.ResourceManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //!IsPostBack ve bu kodları kullanmadığımızda ayarları değiştiririp kaydet'e basınca, kayıt olmuyor.
                CheckBoxListCat.AutoPostBack = true;
                CheckBoxListLang.AutoPostBack = true;

                //kullanıcı ayarlarını çekmek için
                if (Session["UserLogin"] != null)
                    if ((bool)Session["UserLogin"] == false)
                        Response.Redirect("Home.aspx");
                    else
                    {
                        if ((int)Session["Userid"] == 0 || Session["Userid"] == null)
                        {
                            Response.Write("Error Loading Settings");
                        }
                        else
                        {
                            bool en = false;
                            bool tr = false;
                            bool fr = false;

                            bool catWorld = false;
                            bool catBus = false;
                            bool catTech = false;
                            bool catSci = false;
                            bool catHeal = false;
                            bool catVid = false;
                            bool catSport = false;

                            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                            SqlConnection sc = new SqlConnection(connection.ConnectionString);
                            try
                            {
                                sc.Open();
                                SqlCommand c = new SqlCommand("SELECT caid FROM tblCatCfg WHERE cfid =" + Convert.ToInt32(Session["Userid"]));
                                c.Connection = sc;
                                SqlDataReader r = c.ExecuteReader();
                                if (r.HasRows)
                                {
                                    while (r.Read())
                                    {
                                        if (r.GetInt32(0) == 1)
                                            catWorld = true;
                                        else if (r.GetInt32(0) == 2)
                                            catBus = true;
                                        else if (r.GetInt32(0) == 3)
                                            catTech = true;
                                        else if (r.GetInt32(0) == 4)
                                            catSci = true;
                                        else if (r.GetInt32(0) == 5)
                                            catHeal = true;
                                        else if (r.GetInt32(0) == 6)
                                            catVid = true;
                                        else
                                            catSport = true;
                                    }
                                }
                                else
                                {
                                    Response.Write("Error! category record not found!");
                                }
                                sc.Close();

                                SqlCommand c2 = new SqlCommand("SELECT lid FROM tblLangCfg WHERE cfid =" + Convert.ToInt32(Session["Userid"]));
                                c2.Connection = sc;

                                sc.Open();
                                SqlDataReader r2 = c2.ExecuteReader();
                            
                                if(r2.HasRows)
                                {
                                    while(r2.Read())
                                    {
                                        if (r2.GetInt32(0) == 1)
                                            en = true;
                                        else if (r2.GetInt32(0) == 2)
                                            tr = true;
                                        else
                                            fr = true;
                                    }
                                }

                                //kullanıcı ayarlarına göre hangi seçeneğin seçili olup olmadığını gösterme.
                                //yani world kategorisi kullanıcı-ayar tablosunda varsa buradaki checkbox seçili olur.
                                if (catWorld)
                                    CheckBoxListCat.Items[0].Selected = true;
                                if(catBus)
                                    CheckBoxListCat.Items[1].Selected = true;
                                if(catTech)
                                    CheckBoxListCat.Items[2].Selected = true;
                                if (catSci)
                                    CheckBoxListCat.Items[3].Selected = true;
                                if (catHeal)
                                    CheckBoxListCat.Items[4].Selected = true;
                                if (catVid)
                                    CheckBoxListCat.Items[5].Selected = true;
                                if (catSport)
                                    CheckBoxListCat.Items[6].Selected = true;
                                if (en)
                                    CheckBoxListLang.Items[0].Selected = true;
                                if (tr)
                                    CheckBoxListLang.Items[1].Selected = true;
                                if (fr)
                                    CheckBoxListLang.Items[2].Selected = true;
                            }
                            catch (SqlException ex)
                            {
                                Response.Write("Error! " + ex.Message);
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
                    Session.Add("UserLogin", false);
                    Response.Redirect("Home.aspx");
                }
            }

            //dil seçeneklerine göre labelların ve kaydet butonunun yazısını güncelleme
            if ((string)Session["Lang"] == "Turkish")
                resourceManager = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                resourceManager = Lang.French.ResourceManager;

            LblHeading.Text = resourceManager.GetString("LblSettings");
            LblLangs.Text = resourceManager.GetString("LblLangs");
            LblCats.Text = resourceManager.GetString("LblCats");
            LblCngPass.Text = resourceManager.GetString("LblCngPass");
            LblPass.Text = resourceManager.GetString("LblPassSettings");
            LblNpass.Text = resourceManager.GetString("LblNpass");
            LblNPass2.Text = resourceManager.GetString("LblNPass2");
            BtnSave.Text = resourceManager.GetString("BtnSave");
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {

            if (Session["Userid"] == null)
                Response.Redirect("Home.aspx");
            if (Convert.ToInt32(Session["Userid"]) == 0)
                Response.Redirect("Home.aspx");

            string crPass;
            string pass1;
            string pass2;

            crPass = TxtCrPass.Text;
            pass1 = TxtNPass.Text;
            pass2 = TxtNPass2.Text;

            if (TxtCrPass.Text.Length != 0 && TxtNPass.Text.Length != 0 && TxtNPass2.Text.Length != 0)
            {
                if(TxtCrPass.Text.Length <= 30 && TxtNPass.Text.Length <= 30 && TxtNPass.Text == TxtNPass2.Text)
                {
                    bool change = false; // girilen şifre güncel şifreye eşitse true olacak
                    var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                    SqlConnection sc = new SqlConnection(connection.ConnectionString);

                    try
                    {
                        sc.Open();
                        SqlCommand chkPass = new SqlCommand("SELECT pwd FROM tblUser");
                        chkPass.Connection = sc;
                        SqlDataReader r = chkPass.ExecuteReader();
                        if (r.HasRows)
                            while (r.Read())
                                if (r.GetString(0) == crPass)
                                    change = true;
                    }
                    catch (SqlException ex)
                    {
                        Response.Write("Error!" + ex.Message);
                    }
                    finally
                    {
                        sc.Close();
                    }

                    if (change)
                    {
                        if (Session["UserLogin"] != null && (bool) Session["UserLogin"] == true)
                            try
                            {
                                sc.Open();
                                SqlCommand c = new SqlCommand("UPDATE tblUser SET pwd='" + pass1 + "' WHERE usrid=" + Convert.ToInt32(Session["Userid"]));
                                c.Connection = sc;
                                c.ExecuteNonQuery();
                                Response.Write("Password has changed. ");
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
                        Response.Write("Error! You entered your current password wrong!");
                    }
                }
                else
                {
                    Response.Write("Passwords are not the same or character limit error!");
                }
            }

            int selectedLangs = 0;
            List<int> langids = new List<int>();

            if (CheckBoxListLang.Items[0].Selected == true)
            {
                selectedLangs += 1;
                langids.Add(1);
            }
            if (CheckBoxListLang.Items[1].Selected == true)
            {
                selectedLangs += 1;
                langids.Add(2);
            }
            if (CheckBoxListLang.Items[2].Selected == true)
            {
                selectedLangs += 1;
                langids.Add(3);
            }
 
            
            if(selectedLangs != 0)
            {
                var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                SqlConnection sc = new SqlConnection(connection.ConnectionString);

                try
                {
                    sc.Open();
                    SqlCommand c = new SqlCommand("DELETE FROM tblLangCfg WHERE cfid =" + Convert.ToInt32(Session["Userid"]));
                    c.Connection = sc;
                    c.ExecuteNonQuery();

                    SqlCommand c2 = new SqlCommand();
                    c2.Connection = sc;

                    for (int i = 0; i < langids.Count; i++)
                    {
                        c2.CommandText = "INSERT INTO tblLangCfg VALUES (" + langids[i] + "," + Convert.ToInt32(Session["Userid"]) + ")";
                        c2.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex)
                {
                    Response.Write("Failed: " + ex.Message);
                }
                finally
                {
                    Response.Write("Language settings saved. ");
                    sc.Close();
                    sc.Dispose();
                }
            }
            else
            {
                Response.Write("You have to select at least one language! ");
            }

            int selectedCats = 0;
            List<int> catids = new List<int>();

            if (CheckBoxListCat.Items[0].Selected == true)
            {
                selectedCats += 1;
                catids.Add(1);
            }
            if (CheckBoxListCat.Items[1].Selected == true)
            {
                selectedCats += 1;
                catids.Add(2);
            }
            if (CheckBoxListCat.Items[2].Selected == true)
            {
                selectedCats += 1;
                catids.Add(3);
            }
            if (CheckBoxListCat.Items[3].Selected == true)
            {
                selectedCats += 1;
                catids.Add(4);
            }
            if (CheckBoxListCat.Items[4].Selected == true)
            {
                selectedCats += 1;
                catids.Add(5);
            }
            if (CheckBoxListCat.Items[5].Selected == true)
            {
                selectedCats += 1;
                catids.Add(6);
            }
            if (CheckBoxListCat.Items[6].Selected == true)
            {
                selectedCats += 1;
                catids.Add(7);
            }

            if (selectedCats >= 3)
            {
                var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                SqlConnection sc = new SqlConnection(connection.ConnectionString);

                try
                {
                    sc.Open();
                    SqlCommand c = new SqlCommand("DELETE FROM tblCatCfg WHERE cfid =" + Convert.ToInt32(Session["Userid"]));
                    c.Connection = sc;
                    c.ExecuteNonQuery();

                    SqlCommand c2 = new SqlCommand();
                    c2.Connection = sc;

                    for (int i = 0; i < catids.Count; i++)
                    {
                        c2.CommandText = "INSERT INTO tblCatCfg VALUES (" + catids[i] + "," + Convert.ToInt32(Session["Userid"]) + ")";
                        c2.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex)
                {
                    Response.Write("Failed: " + ex.Message);
                }
                finally
                {
                    Response.Write("Category settings saved.");
                    sc.Close();
                    sc.Dispose();
                }
            }
            else
            {
                Response.Write("You have to select at least 3 categories! ");
            }
        }
    }
}