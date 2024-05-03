<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_Dashboard.aspx.cs" Inherits="AppWeb_EP_GamarraDoroteoSebastianNicolas.Views.Dashboard.WF_Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!-- Existing Bootstrap and jQuery references -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
 
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
 
 
    <!-- jqGrid CSS and JS references -->
    <link href="http://trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" rel="stylesheet" />
    <link href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" rel="stylesheet" />
    <link href="http://trirand.com/blog/jqgrid/themes/ui.multiselect.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
 
    <!-- Additional existing references -->
    <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>
    <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"/>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    
    <style>
        .block-ui{ 
            position: fixed;
            top:0;
            left:0;
            height:100%;
            width:100%;
            background: rgba(0,0,0,0.5);
            color: white;
            padding-top:20%;
            font-size:2em;
            z-index:1050;
            display:none;
        }
    </style>

    <title> DASHBOARD - CRUD Persona </title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="w-auto bg-light bg-gradient">
            <!-- Presentación TEMA -->
            <h2 class ="text-center bg-success d-block text-white p-3">EXAMEN PARCIAL - CRUD ( SIMBELMYNE )</h2>
            <div class="p-3">
                <p>Proyecto desarrollado por: Sebastian Nicolas Gamarra Doroteo</p>
                <p>Curso: Aplicaciones Web 2654 - 4V</p>
                <p>El proyecto consiste en un sistema CRUD de la Tabla Persona del Proyecto "Sistema de adopcion de mascotas"</p>
            </div>

            <!-- Seccion Superior : Presentación de Tabla-->
            <div class="container mt-3 w-auto">
                <div class="card">

                    <!-- Cabecera de la carta -->
                    <div class="card-header bg-primary text-white p-2">
                        <h2 class="text-center">Registrar Personas</h2>
                    </div>

                    <!-- Cuerpo de la carta -->
                    <form id="formRegistro">
                        <div class="card-body p-3">
                            <table>
                                <tr>
                                    <td><label for="txtNombre">Nombre:</label></td>
                                    <td><asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" MaxLength="20"/></td>
                                </tr>
                                <tr>
                                    <td><label for="txtApellido">Apellido:</label></td>
                                    <td><asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" MaxLength="20"/></td>
                                </tr>
                                <tr>
                                    <td><label for="txtNumDocumento">Numero de Documento</label></td>
                                    <td><asp:TextBox ID="txtNumDocumento" CssClass="form-control" runat="server" MaxLength="12"/></td>
                                </tr>
                                <tr>
                                    <td><label for="txtTelefono">Telefono:</label></td>
                                    <td><asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" MaxLength="9"/></td>
                                </tr>
                                <tr>
                                    <td><label for="txtEmail">Correo:</label></td>
                                    <td><asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" MaxLength="40"/></td>
                                </tr>
                                <tr>
                                    <td><label for="txtPassword">Contraseña:</label></td>
                                    <td><asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" TextMode="Password" MaxLength="15"/></td>
                                </tr>
                                <tr>
                                    <td><label for="txtDireccion">Direccion:</label></td>
                                    <td><asp:TextBox ID="txtDireccion" CssClass="form-control" runat="server" MaxLength="50"/></td>
                                </tr>
                                <tr>
                                    <td><label for="FileUploadFoto">Foto de perfil:</label></td>
                                    <td><asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="form-control-file" /></td>
                                </tr>
                            </table>
                            
                            <asp:Button ID="ButtonRegistrar" CssClass="btn btn-success p-2 mt-4" runat="server" Text="Registrar" Width="160"/>
                        </div>          
                        
                        <div class="block-ui">Guardando.....</div>

                        <!-- Seccion Modal : Modales CRUD -->
                        <!-- Modal Eliminar -->
                        <div id="deleteModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Eliminar registro</></h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>¿Está seguro de eliminar la Persona con Codigo <span id="idVar"></span>?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                        <button type="button" class="btn btn-primary">Confirmar</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal Editar -->
                        <div id="editModal" class="modal fade" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                    <h5 class="modal-title">Editar registro</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" id="editCode" class="form-control"/>
                                        <div>
                                            <label>Nombre:</label>
                                            <input type="text" id="editNombre" class="form-control"/>
                                        </div>
                                        <div>
                                            <label>Apellido:</label>
                                            <input type="text" id="editApellido" class="form-control"/>
                                        </div>
                                        <div>
                                            <label>Documento:</label>
                                            <input type="text" id="editNumDocumento" class="form-control"/>
                                        </div>
                                        <div>
                                            <label>Telefono:</label>
                                            <input type="text" id="editTelefono" class="form-control"/>
                                        </div>
                                        <div>
                                            <label>Correo:</label>
                                            <input type="text" id="editEmail" class="form-control"/>
                                        </div>
                                        <div>
                                            <label>Direccion:</label>
                                            <input type="text" id="editDireccion" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="button" class="btn btn-primary" id="saveEdit">Guardar cambios</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div>

            <!-- Seccion Inferior : Presentación de Tabla-->
            <div class="container mt-3 w-auto">
                <div class="card">

                    <!-- Cabecera de la carta -->
                    <div class="card-header bg-primary text-white p-2">
                        <h2 class="text-center">Registro de Personas</h2>
                    </div>

                    <!-- Cuerpo de la carta -->
                    <div class="card-body">
                        <div style="padding:40px">
    			            <table id="jqGrid"></table>
			                <div id="jqGridPager"></div>
			            </div>
                    </div>                

                </div>
            </div>

            


            <asp:HiddenField ID="HiddenFieldPers" runat="server"/>

        </div>

        <script type="text/javascript">
            $(document).ready(function () { 

                // JQGRID : Personas
                var dataObject = $("#<%= HiddenFieldPers.ClientID %>").val();
                var myData = JSON.parse(dataObject);

                $("#jqGrid").jqGrid({
                    datatype: "local",
                    data: myData,
                    colModel: [
                        { label: "Codigo", name: "CodPersona", key: true, width: 30 },
                        { label: "Nombre", name: "Nombre", width: 100 },
                        { label: "Apellido", name: "Apellido", width: 100 },
                        { label: "Documento", name: "NumeroDocumento", width: 70 },
                        { label: "Telefono", name: "Telefono", width: 70 },
                        { label: "Email", name: "Correo", width: 140 },
                        { label: "Direccion", name: "Direccion", width: 140 },

                        { label: "Edit", name: "Edit", width: 70, formatter: editButtonFormatter },
                        { label: "Delete", name: "Delete", width: 70, formatter: deleteButtonFormatter }
                    ],
                    pager: "#jqGridPager",
                    rowNum: 5,
                    viewrecords: true
                });

                // FONT AWESOME: CRUD
                function editButtonFormatter(cellValue, options, rowObject) {
                    return "<i class='fas fa-edit btn-edit' data-id='" + rowObject.CodPersona + "'></i>";
                }

                function deleteButtonFormatter(cellValue, options, rowObject) {
                    return "<i class='fas fa-trash btn-delete' data-id='" + rowObject.CodPersona + "'></i>";
                }



                // METODOS CRUD

                // AGREGAR

                $("#<%= ButtonRegistrar.ClientID %>").click(function (e) {

                    e.preventDefault();
                    // alert($("#<%= txtNombre.ClientID %>").val());

                    var formData = new FormData();
                    formData.append("Nombre", $("#<%= txtNombre.ClientID %>").val());
                    formData.append("Apellido", $("#<%= txtApellido.ClientID %>").val());
                    formData.append("CodTipoDocumento", 1);
                    formData.append("NumeroDocumento", $("#<%= txtNumDocumento.ClientID %>").val());
                    formData.append("Telefono", $("#<%= txtTelefono.ClientID %>").val());
                    formData.append("Correo", $("#<%= txtEmail.ClientID %>").val());
                    formData.append("Contrasena", $("#<%= txtPassword.ClientID %>").val());
                    formData.append("Direccion", $("#<%= txtDireccion.ClientID %>").val());
                    formData.append("Foto", $("#<%= FileUploadFoto.ClientID %>")[0].files[0]);

                    $(".block-ui").show();
                    $.ajax({
                        type: "POST",
                        url: "/Dashboard/GuardarRegistro",
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function (response) {

                            setTimeout(function () {
                                $(".block-ui").hide();
                                // $("#formRegistro")[0].reset(); 
                                alert("Registro Exitoso");
                                location.reload();
                            }, 2000);


                            //location.reload();

                        },
                        error: function (error) {
                            $(".block-ui").hide();
                            alert("Error en registro: " + error.responseText);
                        }

                    });
                });



                // EDITAR

                $("#jqGrid").on("click", ".btn-edit", function (event) {
                    var selectId = $(this).data("id");
                    var rowData = $("#jqGrid").jqGrid('getRowData', selectId);

                    openEditModal(
                        selectId,
                        rowData.Nombre,
                        rowData.Apellido,
                        rowData.NumeroDocumento,
                        rowData.Telefono,
                        rowData.Correo,
                        rowData.Direccion
                    );
                });

                $("#editModal .btn-primary").click(function () {
                    // alert("Codigo de la Persona: " + $(this).data("id")); 

                    var formData = new FormData();
                    formData.append("CodPersona", $("#editCode").val());
                    formData.append("Nombre", $("#editNombre").val());
                    formData.append("Apellido", $("#editApellido").val());
                    formData.append("NumeroDocumento", $("#editNumDocumento").val());
                    formData.append("Telefono", $("#editTelefono").val());
                    formData.append("Correo", $("#editEmail").val());
                    formData.append("Direccion", $("#editDireccion").val());

                    $.ajax({
                        type: "POST",
                        url: "/Dashboard/EditarRegistro",
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function (response) {

                            setTimeout(function () {
                                $(".block-ui").hide();
                                alert("Actualización Exitosa");
                                location.reload();
                            }, 2000);

                        },
                        error: function (error) {
                            $(".block-ui").hide();
                            alert("Error en proceso: " + error.responseText);
                        }

                    });

                    $("#editModal").modal('hide');
                });

                function openEditModal(cod, nombre, apellido, documento, telefono, email, direccion) {

                    // Set
                    $("#editCode").val(cod);
                    $("#editNombre").val(nombre);
                    $("#editApellido").val(apellido);
                    $("#editNumDocumento").val(documento);
                    $("#editTelefono").val(telefono);
                    $("#editEmail").val(email);
                    $("#editDireccion").val(direccion);

                    // Mostrar el modal
                    $("#editModal").modal('show');
                }



                // ELIMINAR
                
                $("#jqGrid").on("click", ".btn-delete", function (event) {

                    var selectId = $(this).data("id");
                    // alert("Codigo:" + selectId);
                    openDeleteModal(selectId);

                });

                function openDeleteModal(codPers) {
                    $("#deleteModal").modal('show');
                    $("#idVar").text(codPers);

                    $("#deleteModal .btn-primary").click(function () {
                        // alert("Codigo de la Persona: " + codPers);

                        var formData = new FormData();
                        formData.append("id", codPers);

                        $.ajax({
                            type: "POST",
                            url: "/Dashboard/EliminarRegistro",
                            data: formData,
                            contentType: false,
                            processData: false,
                            success: function (response) {

                                setTimeout(function () {
                                    $(".block-ui").hide();
                                    alert("Eliminación Exitosa");
                                    location.reload();
                                }, 2000);

                            },
                            error: function (error) {
                                $(".block-ui").hide();
                                alert("Error en proceso: " + error.responseText);
                            }

                        });

                        $("#deleteModal").modal('hide');
                    });
                }

            });
        </script>
    </form>
</body>
</html>
