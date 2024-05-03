using AppWeb_EP_GamarraDoroteoSebastianNicolas.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;

namespace AppWeb_EP_GamarraDoroteoSebastianNicolas.Controllers
{
    public class DashboardController : Controller
    {
        // GET: Dashboard
        public ActionResult Index()
        {
            #region Obtener y Mantener datos
            // Obtener datos
            List<Persona> objListaPers = ObtenerPersonas();
            // Mantener datos
            HttpContext.Items["Personas"] = objListaPers;
            #endregion

            #region Generar vista
            // Obtener ruta relativa del WF
            var relativePath = "~/Views/Dashboard/WF_Dashboard.aspx";
            // Limpieza del contenido del Buffer
            Response.Clear();
            // Ejecución del contenido del WF
            Server.Execute(relativePath);
            // Detener ejecución y enviar WF
            Response.End();
            #endregion

            return null;
        }

        private List<Persona> ObtenerPersonas()
        {
            // Declaración de la lista
            var objListPersonas = new List<Persona>();
            // Obtener cadena de conexión
            string cn = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using ( SqlConnection conn = new SqlConnection(cn))
            {
                conn.Open();

                string sqlQuery = "SELECT * FROM [dbo].[TB_Persona] WHERE [Inhabilitado]=0";

                SqlCommand cmd = new SqlCommand(sqlQuery, conn);

                // Registro de datos en la Lista
                using ( SqlDataReader reader = cmd.ExecuteReader() )
                {
                    while (reader.Read())
                    {
                        objListPersonas.Add( new Persona()
                        {
                            CodPersona = (int)reader["IDPersona"],
                            Nombre = reader["Nombre"].ToString(),
                            Apellido = reader["Apellido"].ToString(),
                            CodTipoDocumento = (int)reader["IDTypeDoc"],
                            NumeroDocumento = reader["NumDoc"].ToString(),
                            Telefono = reader["Telefono"].ToString(),
                            Correo = reader["Correo"].ToString(),
                            Contrasena = reader["Contrasena"].ToString(),
                            Direccion = reader["Direccion"].ToString()
                        });
                    }
                }

            }

            return objListPersonas;
        }

        [HttpPost]
        public JsonResult GuardarRegistro(Persona pers, HttpPostedFileBase Foto)
        {
            // Obtener cadena de conexion
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (  SqlConnection conn = new SqlConnection(cnx) )
            {
                conn.Open();

                string sqlQueryInsert = "INSERT INTO [dbo].[TB_Persona]([Nombre],[Apellido],[IDTypeDoc],[NumDoc],[Telefono],[Correo],[Contrasena],[Direccion],[rutaImagen]) " +
                    "VALUES (@nombre,@apellido,@idDocumento,@numDocumento,@telefono,@correo,@contrasena,@direccion,@rutaFoto)";
            
                using ( SqlCommand cmd = new SqlCommand(sqlQueryInsert,conn) )
                {
                    // Pasar valores a variables
                    cmd.Parameters.AddWithValue("@nombre", pers.Nombre);
                    cmd.Parameters.AddWithValue("@apellido", pers.Apellido);
                    cmd.Parameters.AddWithValue("@idDocumento", pers.CodTipoDocumento);
                    cmd.Parameters.AddWithValue("@numDocumento", pers.NumeroDocumento);
                    cmd.Parameters.AddWithValue("@telefono", pers.Telefono);
                    cmd.Parameters.AddWithValue("@correo", pers.Correo);
                    cmd.Parameters.AddWithValue("@contrasena", pers.Contrasena);
                    cmd.Parameters.AddWithValue("@direccion", pers.Direccion);

                    // Ruta de la foto
                    cmd.Parameters.AddWithValue("@rutaFoto", GuardarFoto(Foto));

                    cmd.ExecuteNonQuery();
                }
            }

            // Verificar si el modelo es valido 
            if (ModelState.IsValid)
            {
                string rutaFoto = GuardarFoto(Foto);
            }

            return Json(new { success=false, message="Okey" });
        }


        [HttpPost]
        public JsonResult EditarRegistro(Persona pers)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cnx))
            {
                conn.Open();

                string sqlQueryUpdate = "UPDATE [dbo].[TB_Persona] SET [Nombre]=@nombre, [Apellido]=@apellido, " +
                    "[NumDoc]=@numDocumento, [Telefono]=@telefono, [Correo]=@correo, [Direccion]=@direccion WHERE [IDPersona]=@id";

                using (SqlCommand cmd = new SqlCommand(sqlQueryUpdate, conn))
                {
                    cmd.Parameters.AddWithValue("@id", pers.CodPersona);
                    cmd.Parameters.AddWithValue("@nombre", pers.Nombre);
                    cmd.Parameters.AddWithValue("@apellido", pers.Apellido);
                    cmd.Parameters.AddWithValue("@numDocumento", pers.NumeroDocumento);
                    cmd.Parameters.AddWithValue("@telefono", pers.Telefono);
                    cmd.Parameters.AddWithValue("@correo", pers.Correo);
                    cmd.Parameters.AddWithValue("@direccion", pers.Direccion);

                    cmd.ExecuteNonQuery();
                }
            }

            return Json(new { success = true, message = "Registro actualizado exitosamente" });
        }


        [HttpPost]
        public JsonResult EliminarRegistro(int id)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cnx))
            {
                conn.Open();

                string sqlQueryDelete = "UPDATE [dbo].[TB_Persona] SET [Inhabilitado]=1 WHERE [IDPersona]=@id";

                using (SqlCommand cmd = new SqlCommand(sqlQueryDelete, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id); 

                    cmd.ExecuteNonQuery();
                }
            }

            return Json(new { success = true, message = "Registro inhabilitado exitosamente" });
        }


        private string GuardarFoto(HttpPostedFileBase Foto)
        {
            // Verificar si la foto es válida
            if (Foto == null || Foto.ContentLength <= 0)
            {
                return null;
            }

            // Obtener nombre de la foto
            string nombreArchivo = Path.GetFileName(Foto.FileName);

            // Crear nombre unico para la ofoto
            string nombreUnicoArchivo = $"{Guid.NewGuid()}_{nombreArchivo}";

            // Obtenemos ruta en un ambito local
            string rutaGuardarFoto = Path.Combine(HostingEnvironment.MapPath("~/UploadedFiles/"), nombreUnicoArchivo);

            // Guardar foto
            Foto.SaveAs(rutaGuardarFoto);

            return $"~/UploadedFiles/{nombreUnicoArchivo}";
        }

    }
}