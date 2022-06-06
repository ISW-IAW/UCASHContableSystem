package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.Dt_representanteLegal;
import entidades.Tbl_representanteLegal;

/**
 * Servlet implementation class Sl_representanteLegal
 */
@WebServlet("/Sl_representanteLegal")
public class Sl_representanteLegal extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Sl_representanteLegal() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int opc = 0;
		opc = Integer.parseInt(request.getParameter("opcion"));

		Tbl_representanteLegal representante = new Tbl_representanteLegal();
		Dt_representanteLegal dtRepresentante = new Dt_representanteLegal();

		representante.setNombre(request.getParameter("nombre"));
		representante.setApellido(request.getParameter("apellido"));
		representante.setTelefono(request.getParameter("telefono"));
		representante.setCorreo(request.getParameter("correo"));

		
		
		representante.setEstado(1);

		switch (opc) {
		case 1:
			int identificacion = Integer.parseInt(request.getParameter("idTipoIdentifiacion"));
			representante.setIdTipoIdentifiacion(identificacion); 
			try {
				if (dtRepresentante.addRepresentanteLegal(representante)) {
					
					int idR = dtRepresentante.idRepresentanteLegal(); 
					response.setHeader("Refresh", "0; production/addEmpresa.jsp?msj="+ idR);
					

				} else {
					response.sendRedirect("production/tbl_representanteLegal.jsp?msj=2");
				}
			} catch (Exception e) {
				System.out.println("Error al guardar representante legal: " + e.getMessage());
				e.printStackTrace();
			}
			break;
		case 2:
			int Identificacion = Integer.parseInt(request.getParameter("idTipoIdentifiacion"));
			representante.setIdTipoIdentifiacion(Identificacion); 
			try {
				if (dtRepresentante.addRepresentanteLegal(representante)) {
					response.sendRedirect("production/tbl_representanteLegal.jsp?msj=3");
					
				} else {
					response.sendRedirect("production/tbl_representanteLegal.jsp?msj=4");
				}
			} catch (Exception e) {
				System.out.println("Error al guardar representante legal: " + e.getMessage());
				e.printStackTrace();
			}
			break;
		case 3:
			int identificacion2 = Integer.parseInt(request.getParameter("idTipoIdentifiacion"));
			representante.setIdTipoIdentifiacion(identificacion2); 
			try {
				representante.setIdRepresentante(Integer.parseInt(request.getParameter("idRepresentanteLegal")));
				
				if(dtRepresentante.modificarRepresentanteLegal(representante)) {
					response.sendRedirect("production/tbl_representanteLegal.jsp?msj=5");
				}else {
					response.sendRedirect("production/tbl_representanteLegal.jsp?msj=6");
				}
			}catch (Exception e) {
				// TODO: handle exception
				System.out.println("ERROR al editar representante legal : "+ e.getMessage());
				e.printStackTrace();
			}
			break;
		case 4:
			
				representante.setIdRepresentante(Integer.parseInt(request.getParameter("idRepresentanteLegal")));
			
			try {
				if (dtRepresentante.eliminarRepresentanteLegal(representante)) {
						response.sendRedirect("production/tbl_representanteLegal.jsp?msj=7");
				} else {
						response.sendRedirect("production/tbl_representanteLegal.jsp?msj=8");
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("ERROR Sl_tipoIdentificacion opc3: "+ e.getMessage());
				e.printStackTrace();
			}
		
			break;
			
		default:
			break;

		}
	}
}
