using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace AppWeb_EP_GamarraDoroteoSebastianNicolas
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            // Limpiamos motores de vista
            ViewEngines.Engines.Clear();
            // Definición de rutas 
            RegistrarRoutes(RouteTable.Routes);
        }

        public static void RegistrarRoutes(RouteCollection routes)
        {
            // Mapeo de rutas y Configuracion de Ruta por defecto
            routes.MapRoute(
                name: "default",
                url: "{Controller}/{action}/{id}",
                defaults: new { Controller = "Dashboard", action = "Index", id = UrlParameter.Optional }
            );
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}