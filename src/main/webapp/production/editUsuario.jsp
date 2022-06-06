<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
    
<%
	//INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	//DECLARACIONES
	Vw_usuariorol vwur = new Vw_usuariorol();
	Dt_rolOpciones dtro = new Dt_rolOpciones();
	ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
	boolean permiso = false; //VARIABLE DE CONTROL
	
	//OBTENEMOS LA SESION
	vwur = (Vw_usuariorol) session.getAttribute("acceso");
	if(vwur!=null){
		//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
		
		listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());
		
		for(int x = 0; x < listOpc.size(); x++){
			System.out.print(listOpc.get(x).getOpciones());
		};
		
		
		//RECUPERAMOS LA URL = MI OPCION ACTUAL
		int index = request.getRequestURL().lastIndexOf("/");
		String miPagina = request.getRequestURL().substring(index+1);
		
		//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
		for(Vw_rolopciones vrop : listOpc){
			if(vrop.getOpciones().trim().equals(miPagina.trim())){
				permiso = true; //ACCESO CONCEDIDO
				System.out.print("ESTA ES LA PAGINA RECUPERADA: " + " " + vrop.getOpciones().trim() +  " " + "ESTA ES LA PAGINA EN LA QUE NOS ENCONTRAMOS: " + miPagina.trim());
				break;
			}
		}
	}
	else{
		response.sendRedirect("../login.jsp?msj=401");
		return;
	}
		
	if(!permiso){
		response.sendRedirect("../login.jsp?msj=403");
		return;
	}
	
%>
    
<!DOCTYPE html>
<html>
<%
Tbl_usuario user = new Tbl_usuario();
Dt_usuario datosUsuario = new Dt_usuario();

int idUser = (request.getParameter("idUsuario") != null) ? Integer.parseInt(request.getParameter("idUsuario")) : 0;

user = datosUsuario.ObtenerUsuarioPorId(idUser);
%>
<head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Gestion | Editar Usuarios</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- bootstrap-wysiwyg -->
<link href="../vendors/google-code-prettify/bin/prettify.min.css"
	rel="stylesheet">
<!-- Select2 -->
<link href="../vendors/select2/dist/css/select2.min.css"
	rel="stylesheet">
<!-- Switchery -->
<link href="../vendors/switchery/dist/switchery.min.css"
	rel="stylesheet">
<!-- starrr -->
<link href="../vendors/starrr/dist/starrr.css" rel="stylesheet">
<!-- bootstrap-daterangepicker -->
<link href="../vendors/bootstrap-daterangepicker/daterangepicker.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Editar Usuario</h3>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
								<h2>
									Formulario de usuarios  
								</h2>
								
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<form class="" action="../Sl_usuario" method="post" novalidate>
								<input type="hidden" value="2" name="opcion" id="opcion"/>
								<input type="hidden" value="<%=vwur.getId_user()%>" name="usuarioModificacion" id="usuarioModificacion" />
									<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Id Usuario<span class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="txtid" value="<%=user.getIdUsuario()%>"  type="text" required="required" placeholder="Id de Usuario" readonly/>
											</div>
										</div>

									<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Usuario<span class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="txtusuario" value="<%=user.getUsuario()%>"  type="text" required="required" placeholder="Nombre de Usuario"/>
											</div>
										</div>
									
									<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre<span class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="txtnombres" value="<%=user.getNombre()%>"  type="text" required="required" placeholder="Nombres"/>
											</div>
										</div>
									
									<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Apellidos<span class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="txtapellidos" value="<%=user.getApellidos()%>"  type="text" required="required" placeholder="Apellidos"/>
											</div>
										</div>
									
									<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Correo Electronico<span class="required">:</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="txtemail"  type="text" value="<%=user.getEmail()%>" required="required" placeholder="Correo Electronico"/>
											</div>
										</div>

									<div class="ln_solid"></div>
									<div class="form-group">
										<div class="col-md-9 col-sm-9  offset-md-3">
											<button type="button" onClick="window.location.href='tbl_usuario.jsp'" class="btn btn-danger">Cancelar</button>
											<button type='submit' class="btn btn-primary">Editar</button>
										</div>
									</div>

								</form>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- bootstrap-progressbar -->
	<script
		src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
	<!-- iCheck -->
	<script src="../vendors/iCheck/icheck.min.js"></script>
	<!-- bootstrap-daterangepicker -->
	<script src="../vendors/moment/min/moment.min.js"></script>
	<script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- bootstrap-wysiwyg -->
	<script src="../vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
	<script src="../vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
	<script src="../vendors/google-code-prettify/src/prettify.js"></script>
	<!-- jQuery Tags Input -->
	<script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
	<!-- Switchery -->
	<script src="../vendors/switchery/dist/switchery.min.js"></script>
	<!-- Select2 -->
	<script src="../vendors/select2/dist/js/select2.full.min.js"></script>
	<!-- Parsley -->
	<script src="../vendors/parsleyjs/dist/parsley.min.js"></script>
	<!-- Autosize -->
	<script src="../vendors/autosize/dist/autosize.min.js"></script>
	<!-- jQuery autocomplete -->
	<script
		src="../vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
	<!-- starrr -->
	<script src="../vendors/starrr/dist/starrr.js"></script>
	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>

</body>
</html>