using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppWeb_EP_GamarraDoroteoSebastianNicolas.Models
{
    public class Persona
    {
        public int CodPersona { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public int CodTipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public string Contrasena { get; set; }
        public string Direccion { get; set; }
        public HttpPostedFile Foto { get; set; }
        //public bool Inhabilitado { get; set; }
    }
}