<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
<!DOCTYPE html>

<%
Tbl_cuentaContable ccd = new Tbl_cuentaContable();
Dt_cuentaContable dtCcd = new Dt_cuentaContable();

int idd = dtCcd.idCuentaContable();
%>

<%
//JAlert flag
String signal = "";
if (request.getParameter("msj") != null) {
	signal = request.getParameter("msj");
}
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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Gesti�n | Cuentas Contables</title>
<link rel="stylesheet" href="../vendors/jAlert/dist/jAlert.css" />
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
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Cuenta Contable</h3>
						</div>

						<!-- <div class="title_right">
							<div
								class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Buscar por..."> <span
										class="input-group-btn">
										<button class="btn btn-secondary" type="button">Ir</button>
									</span>
								</div>
							</div>
						</div> -->
					</div>

					<div class="clearfix"></div>

					<div class="row">

						<div class="x_content">
							<div class="row">
								<div class="col-md-12 col-md-12">
									<div class="x_panel">
										<div class="x_title">
											<h2>Cuentas Contables Registradas</h2>

											<div class="clearfix"></div>
										</div>

										<div class="x_content">
											<div class="row">
												<div class="col-md-12">
													<div class="card-box table-responsive">
														<div class="text-muted font-13 col-md-12"
															style="text-align: right;">
															<a
																href="addCuentaContable.jsp?idCuenta=<%=dtCcd.idCuentaContable() + 1%>">
																<i class="fa fa-plus-square"></i> Nueva Cuenta Contable
															</a> &nbsp;&nbsp;
															
															<a href ="../Sl_rptCuentaContable?idPeriodoContable=Del: <%=Tbl_periodoContable.fechaInicioActual%> Al: <%=Tbl_periodoContable.fechaFinalActual%>&idE=<%=Vw_empresa.empresaActual%>" target='_blank'>
																<i class="fa fa-print" title="Imprimir Lista de Cuentas Contables">Imprimir Lista de Cuentas Contables</i>
															</a>&nbsp;&nbsp;
															
															<a href ="../Sl_LibroMayorAuxiliar?idE=<%=Vw_empresa.empresaActual%>" target='_blank'>
																<i class="fa fa-print" title="Imprimir Libro Mayor Auxiliar"> Imprimir Libro Mayor Auxiliar</i>
															</a>&nbsp;&nbsp;<br></br> 
															
															<input type="hidden" value="<%=signal%>" id="JAlertInput" />
														</div>
														<table id="datatable-buttons"
															class="table table-striped table-bordered"
															style="width: 100%">
															<%
															ArrayList<Vw_catalogo_tipo_cuentacontable> listaCuentasContables = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
															Dt_cuentaContable dtCc = new Dt_cuentaContable();
															listaCuentasContables = dtCc.getCuentaContableByIdEmpresa(Vw_empresa.empresaActual);
															%>
															<thead>
																<tr>
																	<th>ID</th>
																	<th>Numero de Cuenta</th>
																	<th>Nombre Cuenta</th>
																	<th>Nivel</th>
																	<th>Rubro</th>
																	<th>Tipo de Cuenta</th>
																	<th>Catalogo de Cuenta</th>
																	<th>Estado</th>
																	<th>Acciones</th>
																</tr>
															</thead>
															<tbody>
																<%
																for (Vw_catalogo_tipo_cuentacontable cc : listaCuentasContables) {
																	String estado = "";
																	if (cc.getEstado() == 1) {
																		estado = "ACTIVO";
																	} else {
																		if (cc.getEstado() == 2) {
																	estado = "MODIFICADO";
																		} else {
																	estado = "INACTIVO";
																		}
																	}
																%>
																<tr>

																	<td><%=cc.getIdCuenta()%></td>
																	<td><%=cc.getNumeroCuenta()%>-<%=cc.getsC()%>-<%=cc.getSsC()%>-<%=cc.getSssC()%></td>
																	<td><%=cc.getNombreCuenta()%></td>
																	<th><%=cc.getNivel()%></th>
																	<td><%=cc.getRubro()%></td>
																	<td><%=cc.getTipoCuenta()%></td>
																	<td><%=cc.getCatalogoCuenta()%></td>
																	<td><%=estado%></td>

																	<td><a
																		href="editCuentaContable.jsp?idCuenta=<%=cc.getIdCuenta()%>">
																			<i class="fa fa-edit" title="Editar"></i>
																	</a> &nbsp;&nbsp; <a
																		href="viewCuentaContable.jsp?idCuenta=<%=cc.getIdCuenta()%>">
																			<i class="fa fa-eye" title="Mostrar"></i>
																	</a> &nbsp;&nbsp; <a
																		href="deleteCuentaContable.jsp?idCuenta=<%=cc.getIdCuenta()%>">
																			<i class="fa fa-trash" title="Eliminar"></i>
																	</a> 
																	</td>
																</tr>
																<%
																}
																%>
															</tbody>

														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>


							</div>
							<%-- <div class="row">
						<div class="col-md-12 col-md-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Detalles de Cuenta Contable Registrados</h2>
									
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="col-md-12">
											<div class="card-box table-responsive">
												
												<table id="datatable-buttons"
													class="table table-striped table-bordered"
													style="width: 100%">
													<%
													ArrayList<Vw_cuentacontable_cuentacontable_det> listaCuentasContablesDet = new ArrayList<Vw_cuentacontable_cuentacontable_det>();
													Dt_cuentaContable_Det dtCcD = new Dt_cuentaContable_Det();
													listaCuentasContablesDet = dtCcD.listaCuentasContablesDet();
													%>
													<thead>
														<tr>
															<th>ID</th>
															<th>Debe</th>
															<th>Haber</th>
															<th>Saldo Final</th>
															<th>Saldo</th>
															<th>Cuenta contable</th>
															<th>Acciones</th>
														</tr>
													</thead>
													<tbody>
														<%
														for (Vw_cuentacontable_cuentacontable_det ccD : listaCuentasContablesDet) {
														%>
														<tr>
															<td><%=ccD.getIdCuentaContableDet()%></td>
															<td><%=ccD.getDebe()%></td>
															<td><%=ccD.getHaber()%></td>
															<td><%=ccD.getSaldoInicial()%></td>
															<td><%=ccD.getSaldoFinal()%></td>
															<td><%=ccD.getNombreCuenta()%></td>
															<td><a href="editCuentaContableDet.jsp?idCD=<%=ccD.getIdCuentaContableDet()%>">
																	<i class="fa fa-edit" title="Editar"></i>
															</a> &nbsp;&nbsp; <a href="viewCuentaContableDet.jsp?idCD=<%=ccD.getIdCuentaContableDet()%>" > 
																	<i class="fa fa-eye" title="Mostrar"></i>
															</a> &nbsp;&nbsp; <a href="deleteCuentaContableDet.jsp?idCD=<%=ccD.getIdCuentaContableDet()%>"> 
																	<i class="fa fa-trash" title="Eliminar"></i>
															</a></td>
														</tr>
														<%
														}
														%>
													</tbody>

												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div> --%>
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

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- iCheck -->
	<script src="../vendors/iCheck/icheck.min.js"></script>
	<!-- Datatables -->
	<script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script
		src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script
		src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script
		src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="../vendors/jszip/dist/jszip.min.js"></script>
	<script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	
	<!-- jAlert -->
	<script src="../vendors/jAlert/dist/jAlert.min.js"></script>
	<script src="../vendors/jAlert/dist/jAlert-functions.min.js"></script>
	<script>
		var mensaje = "";
		mensaje = document.getElementById("JAlertInput").value;
		console.log(mensaje);

		$(document)
				.ready(
						function() {
							if (mensaje == "1") {
								successAlert('Exito',
										'La cuenta contable ha sido registrado correctamente.')
								console.log(mensaje);

							}

							if (mensaje == "2") {
								errorAlert('Error',
										'La cuenta contable no se ha podido guardar. Por favor verifique los datos')
							}

							if (mensaje == "3") {
								successAlert('Exito',
										'Los datos de la Cuenta Contable se han editado correctamente.')
							}

							if (mensaje == "4") {
								errorAlert('Error',
										'Los datos de la Cuenta Contable no se han editado correctamente.')
							}

							$("#example1").DataTable({
								"responsive" : true,
								"lengthChange" : false,
								"autoWidth" : false,
								"buttons" : [ "excel", "pdf" ]
							}).buttons().container().appendTo(
									'#example1_wrapper .col-md-6:eq(0)');
							/*$('#example2').DataTable({
							    "paging": true,
							    "lengthChange": false,
							    "searching": false,
							    "ordering": true,
							    "info": true,
							    "autoWidth": false,
							    "responsive": true,
							});*/
						});
	</script>

</body>
</html>