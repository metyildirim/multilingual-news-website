using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace HaberSitesi
{
    public partial class NewsByCat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Lang"] == null)
                Session.Add("Lang", "English");
            if (Session["Category"] == null)
                Session.Add("Category", "World");
            if (Session["UserLogin"] == null || (bool)Session["UserLogin"] == false)
                GetNewsByCat();
            else
                GetNewsByCatUsr();    //kullanıcı girişi yapıldıysa
        }

        /// <summary>
        /// Kullanıcı giriş yapmadığında çalışır, Seçilen dile ve kategoriye göre haberleri repeater'a atar. (maks 20 adet)
        /// </summary>
        protected void GetNewsByCat()
        {
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsCatLangBeginAmount '" + Session["Category"] + "', '"+Session["Lang"]+"',0,20");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                Repeater1.DataSource = r;
                Repeater1.DataBind();
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
        /// Kullanıcı giriş yaptığında çalışır, kullanıcının seçtiği dillere ve seçilen kategoriye göre haberleri repeater'a atar. (maks 20 adet)
        /// </summary>
        protected void GetNewsByCatUsr()
        {
            //kullanıcının dil ayarlarına göre değişecek
            bool en = false;
            bool tr = false;
            bool fr = false;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

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
            }
            catch (SqlException ex)
            {
                Response.Write("Eror getting language settings of the user" + ex.Message);
            }
            finally
            {
                sc.Close();
            }

            string Langs = "";
            if (en == true)
                Langs += "English ";
            if (tr == true)
                Langs += "Turkish ";
            if (fr == true)
                Langs += "French";

            //kullanıcının dil ayarlarına göre repeater'a haber yollama
            SqlCommand c = new SqlCommand("EXECUTE spViewNewsCatLangBeginAmount '" + Session["Category"] + "', '" + Langs + "',0,20");
            SqlDataReader r;
            c.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                Repeater1.DataSource = r;
                Repeater1.DataBind();
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