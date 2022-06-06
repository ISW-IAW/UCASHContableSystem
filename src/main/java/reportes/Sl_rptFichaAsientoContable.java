package reportes;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.poolConexion;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

import datos.Dt_empresa;
import entidades.Vw_empresa;

/**
 * Servlet implementation class Sl_rptFichaAsientoContable
 */
@WebServlet("/Sl_rptFichaAsientoContable")
public class Sl_rptFichaAsientoContable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sl_rptFichaAsientoContable() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		Dt_empresa datosEmpresa = new Dt_empresa();
		Vw_empresa emp = new Vw_empresa();
		
		
		try {
			
			String idAsientoContable = request.getParameter("idAC") == null ? "0" : (request.getParameter("idAC"));
			String idEmpresa = request.getParameter("empresaActual");

			emp = datosEmpresa.getEmpresaByID(Integer.parseInt(idEmpresa));
			
			String nombreEmpresa = emp.getNombreComercial();
			
			poolConexion pc = poolConexion.getInstance();
			Connection c = poolConexion.getConnection();
			
			HashMap<String, Object> hashMap = new HashMap<>();
			hashMap.put("asientoContableID", Integer.parseInt(idAsientoContable));
			
			OutputStream outputSt = response.getOutputStream();
			ServletContext slContext = getServletContext();
			
			String path = slContext.getRealPath("/");
			System.out.println("PATH: " + path);
			
			String template = "reportes\\rptFichaAsientoContable.jasper";
			Exporter exporter = new JRPdfExporter();
			JasperPrint jasperPrint = JasperFillManager.fillReport(path + template, hashMap, c);
			
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=\"" + nombreEmpresa + "_ReporteAsientoContable_" + idAsientoContable + "_.pdf");
			
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputSt));
			exporter.exportReport();
			
		} catch (Exception e) {
			System.err.println("ERROR AL GENERAR REPORTE: " + e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
