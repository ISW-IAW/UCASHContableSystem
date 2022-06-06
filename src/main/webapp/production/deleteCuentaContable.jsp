<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
<!DOCTYPE html>
<html>

<%
String cc = "";
cc = request.getParameter("idCuenta") == null ? "0" : request.getParameter("idCuenta");

Vw_catalogo_tipo_cuentacontable vwCc = new Vw_catalogo_tipo_cuentacontable();
Dt_cuentaContable dtCc = new Dt_cuentaContable();
vwCc = dtCc.getCuentaContableById(Integer.parseInt(cc));

%>

<%
String CCD = "";
Vw_cuentacontable_cuentacontable_det vwCCD = new Vw_cuentacontable_cuentacontable_det();
Dt_cuentaContable_Det dtCCD = new Dt_cuentaContable_Det();

int idCCD = request.getParameter("idCuenta") != null ? Integer.parseInt(request.getParameter("idCuenta")): 0;
vwCCD = dtCCD.getCCDbyID(idCCD);
%>


<%
//INVALIDA LA CACHE DEL NAVEGADOR //
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
response.setDateHeader("Expires", -1);

//DECLARACIONES
Vw_usuariorol vwur = new Vw_usuariorol();
Dt_rolOpciones dtro = new Dt_rolOpciones();
ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
boolean permiso = false; //VARIABLE DE CONTROL

//OBTENEMOS LA SESION
vwur = (Vw_usuariorol) session.getAttribute("acceso");
if (vwur != null) {
	//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL

	listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

	//RECUPERAMOS LA URL = MI OPCION ACTUAL
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index + 1);

	//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
	for (Vw_rolopciones vrop : listOpc) {
		if (vrop.getOpciones().trim().equals(miPagina.trim())) {
	permiso = true; //ACCESO CONCEDIDO
	break;
		}
	}
} else {
	response.sendRedirect("../login.jsp?msj=401");
	return;
}

if (!permiso) {
	response.sendRedirect("../login.jsp?msj=403");
	//response.sendRedirect("page_403.jsp");
	return;
}
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Eliminar | Cuenta Contable</title>

<!-- Bootstrap -->
<link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- Datatables -->

<link
	href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
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
							<h3>Eliminar Cuenta Contable</h3>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="../Sl_cuentaContable" method="post"
										novalidate>
										<input type="hidden" value="3" name="opcion" id="opcion" /> 
										<input type="hidden" value="<%=vwCc.getIdCuenta() %>" name="idCuenta" id="idCuenta" />
										<input type="hidden" value="<%=vwCCD.getIdCuentaContableDet()%>" name="idCuentaContableDet" id="idCuentaContableDet" />
										<span class="section">Datos de Cuenta Contable</span>


										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Numero de Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="number" class="optional" name="numeroCuenta" id="numeroCuenta" 
												value="<%= vwCc.getNumeroCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="SC" id="SC"
												value="<%= vwCc.getsC() %>" />
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Sub-Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="SsC" id="SsC" 
												value="<%= vwCc.getSsC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Sub-Sub-Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="SssC" id="SssC" 
												value="<%= vwCc.getSssC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="nombreCuenta" id="nombreCuenta" 
												value="<%= vwCc.getNombreCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nivel</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="number" class="optional" name="nivel" id="nivel" 
												value="<%= vwCc.getNivel() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Rubro</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="number" class="optional" name="rubro" id="rubro" 
												value="<%= vwCc.getRubro() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Tipo Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="tipoCuenta" id="tipoCuenta" 
												value="<%= vwCc.getTipoCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Catalogo Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="catalogoCuenta" id="catalogoCuenta" 
												value="<%= vwCc.getCatalogoCuenta()%>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Inicial</label>
											<div class="col-md-6 col-sm-6">

												<input class="form-control" value="<%=vwCCD.getSaldoInicial()%>" name="saldoInicial" id="saldoInicial" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Debe</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" value="<%=vwCCD.getDebe()%>" name="debe" id="debe" readonly/>
											</div>
										</div>	
																		
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Haber</label>
											<div class="col-md-6 col-sm-6">

												<input type="text" class="form-control" value="<%=vwCCD.getHaber()%>" name="haber" id="haber" readonly/>
											
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Final</label>
											<div class="col-md-6 col-sm-6">

												<input class="form-control" value="<%=vwCCD.getSaldoFinal()%>" name="saldoFinal" id="saldoFinal" readonly/>

											</div>
										</div>

										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button type='submit' class="btn btn-danger">Eliminar</button>
													<a type="button" href="tbl_cuentacontable.jsp" class="btn btn-primary">Cancelar</a>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">Sistema contable</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>

	<!-- Javascript functions	-->
	<script>
		function hideshow() {
			var password = document.getElementById("password1");
			var slash = document.getElementById("slash");
			var eye = document.getElementById("eye");
			if (password.type === 'password') {
				password.type = "text";
				slash.style.display = "block";
				eye.style.display = "none";
			} else {
				password.type = "password";
				slash.style.display = "none";
				eye.style.display = "block";
			}
		}
	</script>

	<script>
		// initialize a validator instance from the "FormValidator" constructor.
		// A "<form>" element is optionally passed as an argument, but is not a must
		var validator = new FormValidator({
			"events" : [ 'blur', 'input', 'change' ]
		}, document.forms[0]);
		// on form "submit" event
		document.forms[0].onsubmit = function(e) {
			var submit = true, validatorResult = validator.checkAll(this);
			console.log(validatorResult);
			return !!validatorResult.valid;
		};
		// on form "reset" event
		document.forms[0].onreset = function(e) {
			validator.reset();
		};
		// stuff related ONLY for this demo page:
		$('.toggleValidationTooltips').change(function() {
			validator.settings.alerts = !this.checked;
			if (this.checked)
				$('form .alert').remove();
		}).prop('checked', false);
	</script>

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- validator -->
	<!-- <script src="../vendors/validator/validator.js"></script> -->

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>

</body>

</html>