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
    public partial class EditorPage : System.Web.UI.Page
    {
        protected ResourceManager resourceManager = Lang.English.ResourceManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["Lang"] == "Turkish")
                resourceManager = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                resourceManager = Lang.French.ResourceManager;

            //seçili dile göre labellar ve butonlar güncellerinir
            LblEditorHeading.Text = resourceManager.GetString("LblAddNews");
            LblHeading.Text = resourceManager.GetString("LblHeading");
            LblDesc.Text = resourceManager.GetString("LblDesc");
            LblContent.Text = resourceManager.GetString("LblContent");
            LblUrl.Text = resourceManager.GetString("LblUrl");
            LblCat.Text = resourceManager.GetString("LblCat");
            LblSource.Text = resourceManager.GetString("LblSource");
            LblLang.Text = resourceManager.GetString("LblLang");
            BtnAdd.Text = resourceManager.GetString("BtnAdd");
        }
 
        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (TxtHeading.Text.Length > 70 || TxtDesc.Text.Length > 500 
                    || TxtContent.Text.Length > 8000 || TxtUrl.Text.Length > 250)
                Response.Write("Character Limit Error! ");
            else if(Session["isEditor"] != null)
            {
                if ((bool)Session["isEditor"] == false)
                    Response.Redirect("Home.aspx"); // editör session'ı false ise haber ekleyemesin.
                else
                {
                    string headln;
                    headln = TxtHeading.Text;
                    string descr;
                    descr = TxtDesc.Text;
                    string url;
                    url = TxtUrl.Text;
                    string content;
                    content = TxtContent.Text;

                    //olası sql komutu hatasını önlemek için ' karakterini ve " karakterini ` karakterine çevirme.
                    headln = removeSpecialChar(headln);
                    descr = removeSpecialChar(descr);
                    content = removeSpecialChar(content);


                    int srcid;  //haber kaynağının idsi
                    int catid; //kategori idsi
                    int langid;

                    if (DropDownSource.SelectedValue == "BBC")
                        srcid = 1;
                    else if (DropDownSource.SelectedValue == "CNN")
                        srcid = 2;
                    else if (DropDownSource.SelectedValue == "France24")
                        srcid = 3;
                    else if (DropDownSource.SelectedValue == "The Paris News")
                        srcid = 4;
                    else if (DropDownSource.SelectedValue == "AA")
                        srcid = 5;
                    else if (DropDownSource.SelectedValue == "DHA")
                        srcid = 6;
                    else
                        srcid = 7;

                    if (DropDownCat.SelectedValue == "World")
                        catid = 1;
                    else if (DropDownCat.SelectedValue == "Business")
                        catid = 2;
                    else if (DropDownCat.SelectedValue == "Technology")
                        catid = 3;
                    else if (DropDownCat.SelectedValue == "Science")
                        catid = 4;
                    else if (DropDownCat.SelectedValue == "Health")
                        catid = 5;
                    else if (DropDownCat.SelectedValue == "Video")
                        catid = 6;
                    else
                        catid = 7;

                    if (DropDownLang.SelectedValue == "English")
                        langid = 1;
                    else if (DropDownLang.SelectedValue == "Turkish")
                        langid = 2;
                    else
                        langid = 3;

                    var connection = WebConfigurationManager.ConnectionStrings["DBConnection"];
                    SqlConnection sc = new SqlConnection(connection.ConnectionString);

                    try
                    {
                        sc.Open();
                        SqlCommand c = new SqlCommand("EXECUTE spInsertNews '"+headln+"', '"+descr+"', '"+content+"', '"+url+"', "+srcid.ToString()+", "+langid.ToString()+", "+catid.ToString());
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
            }
            else
            {
                Session.Add("isEditor", false);
                Response.Redirect("Home.aspx");
            }   
        }

        protected string removeSpecialChar(string str)
        {
            var replacements = new[]
                               { new { Old = "'", New = "`" }
                            , new { Old = Convert.ToString('"'), New = "`" }};

            foreach (var r in replacements)
                        {
                            str = str.Replace(r.Old, r.New);
                        }
            return str;
        }
    }
}