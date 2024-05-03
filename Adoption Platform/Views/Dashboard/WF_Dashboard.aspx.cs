using AppWeb_EP_GamarraDoroteoSebastianNicolas.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppWeb_EP_GamarraDoroteoSebastianNicolas.Views.Dashboard
{
    public partial class WF_Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var personas = HttpContext.Current.Items["Personas"] as List<Persona>;

                if (personas != null)
                {
                    // Conversión de objeto a cadena JSON
                    var serializer = new JavaScriptSerializer();
                    HiddenFieldPers.Value = serializer.Serialize(personas);
                }
            }
        }
    }
}