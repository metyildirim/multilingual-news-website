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
    public partial class Read : System.Web.UI.Page
    {
        protected ResourceManager resource = Lang.English.ResourceManager;
        protected string nid = null; //haber idsi

        protected void Page_Load(object sender, EventArgs e)
        {
            //DİL SEÇENEKLERİNE GÖRE LABEL, BUTON vs YAZILARI GÜNCELLEME
            if (Session["Lang"] == null)
                Session.Add("Lang", "English");

            if ((string)Session["Lang"] == "Turkish")
                resource = Lang.Turkish.ResourceManager;
            else if ((string)Session["Lang"] == "French")
                resource = Lang.French.ResourceManager;

            LblSource.Text = resource.GetString("Source");
            LblComments.Text = resource.GetString("Comments");
            LblComment.Text = resource.GetString("Comment");
            LblLogin.Text = resource.GetString("LoginToComment");
            BtnComment.Text = resource.GetString("Comment");
            RequiredFieldValidator1.ErrorMessage = resource.GetString("Error");

            //adres çubuğundan gelen haber idsi için
            if (Request.QueryString["nid"] != null)
                nid = Request.QueryString["nid"];
            else
            {
                Response.Redirect("~/Home.aspx"); //adres çubuğunda haber idsi yoksa anasayfaya yönlendir.
            }

            //kullanıcı girişi durumuna göre haber yorumu yapmak için kullanılan multiview'i değiştirme
            if (Session["UserLogin"] == null)
                Session.Add("UserLogin", false);
            if ((bool)Session["UserLogin"] == false)
                MultiViewComments.ActiveViewIndex = 0;
            else
                MultiViewComments.ActiveViewIndex = 1;

            //haberi çekme
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            try
            {
                string headline;
                string desc;
                string content;
                DateTime time;
                string source;
                string imgUrl;

                sc.Open();
                SqlCommand c = new SqlCommand("EXECUTE spReadNews " + nid);
                c.Connection = sc;
                SqlDataReader r = c.ExecuteReader();
                if(r.HasRows)
                {
                    while(r.Read())
                    {
                        headline = r.GetString(0);
                        desc = r.GetString(1);
                        content = r.GetString(2);
                        imgUrl = r.GetString(3);
                        time = r.GetDateTime(4);
                        source = r.GetString(5);

                        LblHeadLn.Text = headline;
                        lblDesc.Text = desc;
                        LiteralContent.Text = content;
                        img.ImageUrl = imgUrl;
                        LblDt.Text = time.ToString();
                        LblSourceName.Text = source;
                    }
                }
                r.Close();

                SqlCommand c2 = new SqlCommand("EXECUTE spSelectComments " + nid);
                c2.Connection = sc;
                SqlDataReader r2 = c2.ExecuteReader();
                Repeater1.DataSource = r2;
                Repeater1.DataBind();
            }
            catch(SqlException ex)
            {
                Response.Write("Error! " + ex.Message);
            }
            finally
            {
                sc.Close();
                sc.Dispose();
            }
        }

        protected void BtnComment_Click(object sender, EventArgs e)
        {
            string txt = TxtComment.Text;
            if (txt.Length > 400)
                Response.Write("Please comment less than 400 characters");
            else
            {
                var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                SqlConnection sc = new SqlConnection(connection.ConnectionString);
                SqlCommand c = new SqlCommand("EXECUTE spMakeComment " + Session["Userid"] + ", " + nid + " ,'" + txt + "'");
                c.Connection = sc;
                try
                {
                    sc.Open();
                    c.ExecuteNonQuery();
                    Response.Write("Success!");
                }
                catch (SqlException ex)
                {
                    Response.Write("Error! " + ex.Message);
                }
                finally
                {
                    sc.Close();
                    sc.Dispose();
                    Response.Redirect(Request.RawUrl);
                }
            }
        }
    }
}