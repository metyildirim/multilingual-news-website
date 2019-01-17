using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Resources;

namespace HaberSitesi
{
    public partial class About : System.Web.UI.Page
    {
        protected ResourceManager rm = Lang.English.ResourceManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            //dil hakkında session yoksa ingilizce olarak dil sessionu eklenir
            if (Session["Lang"] == null)
                Session.Add("Lang", "English");

            //eğer dil session'u diğer diller olarak kayıtlı ise, rm'yi o dille ilgili resource'a eşitlemek
            if ((string)Session["Lang"] == "Turkish")
                rm = Lang.Turkish.ResourceManager;
            if ((string)Session["Lang"] == "French")
                rm = Lang.French.ResourceManager;

            //seçilen dile göre labellar ve literallerin text'leri atanır.
            LblAbout.Text = rm.GetString("About");
            Literal1.Text = rm.GetString("AboutText");
        }
    }
}