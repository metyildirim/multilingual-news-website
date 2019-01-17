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
    public partial class Home : System.Web.UI.Page
    {
        protected ResourceManager resourceManager = Lang.English.ResourceManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            //dil ile ilgili session yoksa ingilizce olsun
            if (Session["Lang"] == null)
                Session.Add("Lang", "English");

            //dil seçimine göre resource dosyası değişsin
            if ((string)Session["Lang"] == "Turkish")
                resourceManager = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                resourceManager = Lang.French.ResourceManager;

            //resource dosyasına göre labelların text'leri atanıyor.
            LblWorld.Text = resourceManager.GetString("BtnWorld");
            LblBusiness.Text = resourceManager.GetString("BtnBusiness");
            LblTech.Text = resourceManager.GetString("BtnTech");
            LblScience.Text = resourceManager.GetString("BtnScience");
            LblHealth.Text = resourceManager.GetString("BtnHealth");
            LblVideo.Text = resourceManager.GetString("BtnVideo");
            LblSport.Text = resourceManager.GetString("BtnSport");

            //ANASAYFA SLIDER için veri çekme -- sadece seçilen dile göre belirli sayıda en son haberler çekilir
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsSlider '" + Session["Lang"] + "'");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                RepeaterSlider.DataSource = r;
                RepeaterSlider.DataBind();
                r.Close();
            }
            catch (SqlException ex)
            {
                Response.Write("Error!" + ex.Message);
            }
            finally
            {
                sc.Close();
            }

            //kullanıcı girişi yapılmadığı koşullarda anasayfadaki kategorilere ayrı ayrı sadece seçili dilde haber gönderilir
            //leftbox: kategorinin en son haberi olan soldaki diğerlerinden daha büyük olan haber kutusudur. 
            if (Session["UserLogin"] == null || (bool)Session["UserLogin"] == false)
            {
                //bu metodlar içerisine gönderilen kategoride haberleri anasayfadaki ilgili kategori bölümüne atar.
                //kullanıcı girişi olmadığı durumlarda çalışır.
                LeftBoxSet("World");
                NewsBoxSet("World");
                
                LeftBoxSet("Business");
                NewsBoxSet("Business");

                LeftBoxSet("Technology");
                NewsBoxSet("Technology");

                NewsBoxSet("Science");
                LeftBoxSet("Science");

                LeftBoxSet("Health");
                NewsBoxSet("Health");

                LeftBoxSet("Video");
                NewsBoxSet("Video");

                LeftBoxSet("Sport");
                NewsBoxSet("Sport");
            }
            else //kullanıcı girişi yapıldığı zaman ana sayfadaki kategori bölümünü güncelleme
            {
                //kullanıcı ayarları çekildiğinde kullanıcı-ayar tablosunda ekli olan kategoriler true olacak.
                bool catWorld = false;
                bool catBus = false;
                bool catTech = false;
                bool catSci = false;
                bool catHeal = false;
                bool catVid = false;
                bool catSport = false;

                try
                {
                    sc.Open();
                    c.CommandText = "SELECT caid FROM tblCatCfg WHERE cfid =" + Convert.ToInt32(Session["Userid"]);
                    c.Connection = sc;
                    r = c.ExecuteReader();
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
                }
                catch (SqlException ex)
                {
                    Response.Write("Error loading config records of user " + ex.Message);
                }
                finally
                {
                    sc.Close();
                }

                //yukarıda true olan kategoriler visible olur, diğerleri gözükmez.
                PnlWorld.Visible = catWorld;
                PnlBusiness.Visible = catBus;
                PnlTechnology.Visible = catTech;
                PnlScience.Visible = catSci;
                PnlHealth.Visible = catHeal;
                PnlVideo.Visible = catVid;
                PnlSport.Visible = catSport;

                //kullanıcı ayarları çekildiğinde kullanıcı-dil tablosunda ekli diller true olur.
                bool en = false;
                bool tr = false;
                bool fr = false;

                try
                {
                    SqlCommand c2 = new SqlCommand("SELECT lid FROM tblLangCfg WHERE cfid =" + Convert.ToInt32(Session["Userid"]));
                    c2.Connection = sc;

                    sc.Open();
                    SqlDataReader r2 = c2.ExecuteReader();

                    if (r2.HasRows)
                    {
                        while (r2.Read())
                        {
                            if (r2.GetInt32(0) == 1)
                                en = true;
                            else if (r2.GetInt32(0) == 2)
                                tr = true;
                            else
                                fr = true;
                        }
                    }
                }catch(SqlException ex)
                {
                    Response.Write("Eror getting language settings of the user" + ex.Message);
                }
                finally
                {
                    sc.Close();
                    sc.Dispose();
                }

                //burada tek bir string değerine "English Turkish French" gibi üçlü dil seçeneği de gönderilebilir,
                //sql prosedürü bunu algılayıp gerekli haber sonucunu gönderiyor.
                string LanguageSelections = "";
                if (en == true)
                    LanguageSelections += "English ";
                if (tr == true)
                    LanguageSelections += "Turkish ";
                if (fr == true)
                    LanguageSelections += "French";

                //bu iki metod ile (kullanıcı giriş yaptığı durumda çalışır) kullanıcı dil seçeneğine göre haberler atanır,
                //kategori ayarlarıyla zaten yukarıda bazı kategori bölümleri unvisible olduğu için seçilmeyen kategori,
                //haberleri atansa bile gözükmez.
                LeftBoxSetUsr("World", LanguageSelections);
                NewsBoxSetUsr("World", LanguageSelections);
                LeftBoxSetUsr("Business", LanguageSelections);
                NewsBoxSetUsr("Business", LanguageSelections);
                LeftBoxSetUsr("Technology", LanguageSelections);
                NewsBoxSetUsr("Technology", LanguageSelections);
                LeftBoxSetUsr("Science", LanguageSelections);
                NewsBoxSetUsr("Science", LanguageSelections);
                LeftBoxSetUsr("Health", LanguageSelections);
                NewsBoxSetUsr("Health", LanguageSelections);
                LeftBoxSetUsr("Video", LanguageSelections);
                NewsBoxSetUsr("Video", LanguageSelections);
                LeftBoxSetUsr("Sport", LanguageSelections);
                NewsBoxSetUsr("Sport", LanguageSelections);
            }
        }

        /// <summary>
        /// Kullanıcı giriş yapmadığında çalışır, ana sayfadaki haber kategorilerinin her biri için çağrılması gerekir.
        /// </summary>
        /// <param name="cat">string olarak gönderilen kategori ismi örneğin: "World"</param>
        protected void LeftBoxSet(string cat)
        {
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsCatLangBeginAmount '" + cat + "', '" + Session["Lang"] + "',0,1");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                if(r.HasRows)
                {
                    while(r.Read())
                    {
                        int id = r.GetInt32(0);
                        string headln = r.GetString(1);
                        string desc = r.GetString(2);
                        string url = r.GetString(4);
                        string dt = r.GetDateTime(5).ToString();

                        if(cat == "World")
                        {
                            LinkWorld.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftWorld.ImageUrl = url;
                            LblWorldHl.Text = headln;
                            LblWorldDesc.Text = desc;
                            LblWorldDt.Text = dt;
                        }
                        else if(cat == "Business")
                        {
                            LinkBus.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftBus.ImageUrl = url;
                            LblBusHl.Text = headln;
                            LblBusDesc.Text = desc;
                            LblBusDt.Text = dt;
                        }
                        else if(cat == "Technology")
                        {
                            LinkTech.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftTech.ImageUrl = url;
                            LblTechHl.Text = headln;
                            LblTechDesc.Text = desc;
                            LblTechDt.Text = dt;
                        }
                        else if(cat == "Science")
                        {
                            LinkSci.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftSci.ImageUrl = url;
                            LblSciHl.Text = headln;
                            LblSciDesc.Text = desc;
                            LblSciDt.Text = dt;
                        }
                        else if(cat == "Health")
                        {
                            LinkHealth.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftHealth.ImageUrl = url;
                            LblHealthHl.Text = headln;
                            LblHealthDesc.Text = desc;
                            LblHealthDt.Text = dt;
                        }
                        else if(cat == "Video")
                        {
                            LinkVideo.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftVideo.ImageUrl = url;
                            LblVideoHl.Text = headln;
                            LblVideoDesc.Text = desc;
                            LblVideoDt.Text = dt;
                        }
                        else if(cat == "Sport")
                        {
                            LinkSport.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftSport.ImageUrl = url;
                            LblSportHl.Text = headln;
                            LblSportDesc.Text = desc;
                            LblSportDt.Text = dt;
                        }
                    }
                }
                r.Close();
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

        /// <summary>
        /// Kullanıcı giriş yaptığında çalışır, ana sayfadaki haber kategorilerinin her biri için çağrılması gerekir.
        /// </summary>
        /// <param name="cat">string olarak gönderilen kategori ismi örneğin: "World"</param>
        protected void LeftBoxSetUsr(string cat, string Langs)
        {
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsCatLangBeginAmount '" + cat + "', '" + Langs + "',0,1");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                if (r.HasRows)
                {
                    while (r.Read())
                    {
                        int id = r.GetInt32(0);
                        string headln = r.GetString(1);
                        string desc = r.GetString(2);
                        string url = r.GetString(4);
                        string dt = r.GetDateTime(5).ToString();

                        if (cat == "World")
                        {
                            LinkWorld.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftWorld.ImageUrl = url;
                            LblWorldHl.Text = headln;
                            LblWorldDesc.Text = desc;
                            LblWorldDt.Text = dt;
                        }
                        else if (cat == "Business")
                        {
                            LinkBus.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftBus.ImageUrl = url;
                            LblBusHl.Text = headln;
                            LblBusDesc.Text = desc;
                            LblBusDt.Text = dt;
                        }
                        else if (cat == "Technology")
                        {
                            LinkTech.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftTech.ImageUrl = url;
                            LblTechHl.Text = headln;
                            LblTechDesc.Text = desc;
                            LblTechDt.Text = dt;
                        }
                        else if (cat == "Science")
                        {
                            LinkSci.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftSci.ImageUrl = url;
                            LblSciHl.Text = headln;
                            LblSciDesc.Text = desc;
                            LblSciDt.Text = dt;
                        }
                        else if (cat == "Health")
                        {
                            LinkHealth.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftHealth.ImageUrl = url;
                            LblHealthHl.Text = headln;
                            LblHealthDesc.Text = desc;
                            LblHealthDt.Text = dt;
                        }
                        else if (cat == "Video")
                        {
                            LinkVideo.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftVideo.ImageUrl = url;
                            LblVideoHl.Text = headln;
                            LblVideoDesc.Text = desc;
                            LblVideoDt.Text = dt;
                        }
                        else if (cat == "Sport")
                        {
                            LinkSport.NavigateUrl = "~/Read.aspx?nid=" + id.ToString();
                            ImgLeftSport.ImageUrl = url;
                            LblSportHl.Text = headln;
                            LblSportDesc.Text = desc;
                            LblSportDt.Text = dt;
                        }
                    }
                }
                r.Close();
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

        /// <summary>
        /// Kullanıcı giriş yapmadığında çalışır, ana sayfadaki haber kategorilerinin her biri için çağrılması gerekir.
        /// </summary>
        /// <param name="cat">string olarak gönderilen kategori ismi örneğin: "World"</param>
        protected void NewsBoxSet(string cat)
        {
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsCatLangBeginAmount '" + cat + "', '" + Session["Lang"] + "',1,6");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();

                if (cat == "World")
                {
                    RepeaterWorld.DataSource = r;
                    RepeaterWorld.DataBind();
                }
                else if (cat == "Business")
                {
                    RepeaterBusiness.DataSource = r;
                    RepeaterBusiness.DataBind();
                }
                else if (cat == "Technology")
                {
                    RepeaterTech.DataSource = r;
                    RepeaterTech.DataBind();
                }
                else if (cat == "Science")
                {
                    RepeaterScience.DataSource = r;
                    RepeaterScience.DataBind();
                }
                else if (cat == "Health")
                {
                    RepeaterHealth.DataSource = r;
                    RepeaterHealth.DataBind();
                }
                else if (cat == "Video")
                {
                    RepeaterVideo.DataSource = r;
                    RepeaterVideo.DataBind();
                }
                else if (cat == "Sport")
                {
                    RepeaterSport.DataSource = r;
                    RepeaterSport.DataBind();
                }
                r.Close();
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

        /// <summary>
        /// Kullanıcı giriş yaptığında çalışır, ana sayfadaki haber kategorilerinin her biri için çağrılması gerekir.
        /// </summary>
        /// <param name="cat">string olarak gönderilen kategori ismi örneğin: "World"</param>
        protected void NewsBoxSetUsr(string cat, string Langs)
        {
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsCatLangBeginAmount '" + cat + "', '" + Langs + "',1,6");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();

                if (cat == "World")
                {
                    RepeaterWorld.DataSource = r;
                    RepeaterWorld.DataBind();
                }
                else if (cat == "Business")
                {
                    RepeaterBusiness.DataSource = r;
                    RepeaterBusiness.DataBind();
                }
                else if (cat == "Technology")
                {
                    RepeaterTech.DataSource = r;
                    RepeaterTech.DataBind();
                }
                else if (cat == "Science")
                {
                    RepeaterScience.DataSource = r;
                    RepeaterScience.DataBind();
                }
                else if (cat == "Health")
                {
                    RepeaterHealth.DataSource = r;
                    RepeaterHealth.DataBind();
                }
                else if (cat == "Video")
                {
                    RepeaterVideo.DataSource = r;
                    RepeaterVideo.DataBind();
                }
                else if (cat == "Sport")
                {
                    RepeaterSport.DataSource = r;
                    RepeaterSport.DataBind();
                }
                r.Close();
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
    }
}