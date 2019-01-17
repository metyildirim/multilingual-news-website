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
    public partial class APanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            MultiView1.ActiveViewIndex = 0;
            MultiView2.Visible = false;
     
            if (Session["Login"] == null)
                Session.Add("Login", false);

            if ((bool)Session["Login"])
            {
                MultiView1.ActiveViewIndex = 1;
                MultiView2.Visible = true;
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            bool login = false;
            string usrname = txtusername.Text;
            string pass = txtPassword.Text;
        
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

            try
            {
                sc.Open();
                SqlCommand c = new SqlCommand("SELECT usrname,pwd FROM tblAdmin");
                c.Connection = sc;
                SqlDataReader r = c.ExecuteReader();

                if (r.HasRows)
                {
                    while (r.Read())
                    {
                        string username = r.GetString(0);
                        string password = r.GetString(1);

                        if (usrname == username && pass == password)
                        {
                            login = true;
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

            if(login == true)
            {
                Response.Write("Login Successful");
                Session.Add("Login", true);
                MultiView1.ActiveViewIndex = 1;
                MultiView2.Visible = true;
                MultiView2.ActiveViewIndex = 0;
            }
            else
            {
                Response.Write("invalid username or password!");
            }          
        }

        protected void BtnMain_Click(object sender, EventArgs e)
        {
            MultiView2.ActiveViewIndex = 0;
        }

        protected void BtnMessages_Click(object sender, EventArgs e)
        {
            MultiView2.ActiveViewIndex = 1;
            
            // mesajları çekme
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("SELECT * FROM VUsrMessages");
            SqlCommand c2 = new SqlCommand("SELECT * FROM tblOtherMessages");
            SqlDataReader r;
            c.Connection = sc;
            c2.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                RepeaterMessages.DataSource = r;
                RepeaterMessages.DataBind();
                r.Close();
                r = c2.ExecuteReader();
                RepeaterOtherMsg.DataSource = r;
                RepeaterOtherMsg.DataBind();
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

        protected void BtnEditors_Click(object sender, EventArgs e)
        {
            MultiView2.ActiveViewIndex = 2;

            // editörlük hakkında verileri çekme
            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("SELECT * FROM VEditors");
            SqlCommand c2 = new SqlCommand("SELECT * FROM VEditorRequests");
            SqlDataReader r;
            c.Connection = sc;
            c2.Connection = sc;
            try
            {
                sc.Open();
                r = c.ExecuteReader();
                RepeaterEditors.DataSource = r;
                RepeaterEditors.DataBind();
                r.Close();
                r = c2.ExecuteReader();
                RepeaterRequests.DataSource = r;
                RepeaterRequests.DataBind();
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

        protected void BtnUsers_Click(object sender, EventArgs e)
        {
            MultiView2.ActiveViewIndex = 3;
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            MultiView1.ActiveViewIndex = 0;
            MultiView2.Visible = false;
        }

        protected void BtnSaveAdmin_Click(object sender, EventArgs e)
        {
            string newusr;
            string crPass;
            string pass1;
            string pass2;
            bool change = false; // güncel şifre ile girilen şifre eşitse true olacak ve bilgiler değiştirilecek.

            newusr = TxtNewusr.Text;
            crPass = TxtCurrentPass.Text;
            pass1 = TxtNewPass.Text;
            pass2 = TxtNewPass2.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
         
            try
            {
                sc.Open();
                SqlCommand chkPass = new SqlCommand("SELECT pwd FROM tblAdmin");
                chkPass.Connection = sc;
                SqlDataReader r = chkPass.ExecuteReader();
                if(r.HasRows)
                    while(r.Read())
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

            if(Session["Login"] != null)
            if (newusr.Length >= 5 && pass1==pass2 && change == true && (bool)Session["Login"] == true)
            {
                try
                {
                    sc.Open();
                    SqlCommand c = new SqlCommand("UPDATE tblAdmin SET usrname ='"+newusr+"', pwd='"+pass1+"' WHERE id=1");
                    c.Connection = sc;
                    c.ExecuteNonQuery();
                    Response.Write("Success!");
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
            else{
                Response.Write("Username is not valid or there is a password mistake!");
                sc.Close();
                sc.Dispose();
            }
        }

        protected void BtnAddEdt_Click(object sender, EventArgs e)
        {
            string usrname;
            usrname = TxtAddEdt.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

            try
            {
                sc.Open();
                SqlCommand c = new SqlCommand("EXECUTE spAddEditor '" + usrname+"'");
                c.Connection = sc;
                if (Session["Login"] != null)
                    if ((bool)Session["Login"] == true)
                    {
                        c.ExecuteNonQuery();
                    }
                Response.Write("Check the Results!");
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

        protected void BtnRemoveEdt_Click(object sender, EventArgs e)
        {
            string usrname;
            usrname = TxtRemoveEdt.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

            try
            {
                sc.Open();
                SqlCommand c = new SqlCommand("EXECUTE spRemoveEditor '" + usrname + "'");
                c.Connection = sc;
                if (Session["Login"] != null)
                    if ((bool)Session["Login"] == true)
                    {
                        c.ExecuteNonQuery();
                    }
                Response.Write("Check the Results!");
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

        protected void BtnSrcUsr_Click(object sender, EventArgs e)
        {
            string searchedText;
            searchedText = TxtSrcUsr.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);
            SqlCommand c = new SqlCommand("EXECUTE spSelectUser '" +searchedText +"'");
            SqlDataReader r;
            c.Connection = sc;

            try
            {
                sc.Open();
                r = c.ExecuteReader();
                RepeaterSrcUsr.Dispose();
                RepeaterSrcUsr.DataSource = r;
                RepeaterSrcUsr.DataBind();
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

        protected void BtnBlock_Click(object sender, EventArgs e)
        {
            string username;
            username = TxtBlock.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

            try
            {
                sc.Open();
                SqlCommand c = new SqlCommand("UPDATE tblUser SET isBlocked = 1 WHERE usrname = '" + username + "'");
                c.Connection = sc;
                if (Session["Login"] != null)
                    if ((bool)Session["Login"] == true)
                    {
                        c.ExecuteNonQuery();
                    }
                Response.Write("Check the Results!");
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

        protected void BtnRBlock_Click(object sender, EventArgs e)
        {
            string username;
            username = TxtRBlock.Text;

            var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
            SqlConnection sc = new SqlConnection(connection.ConnectionString);

            try
            {
                sc.Open();
                SqlCommand c = new SqlCommand("UPDATE tblUser SET isBlocked = 0 WHERE usrname = '" + username + "'");
                c.Connection = sc;
                if (Session["Login"] != null)
                    if ((bool)Session["Login"] == true)
                    {
                        c.ExecuteNonQuery();
                    }
                Response.Write("Check the Results!");
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
}