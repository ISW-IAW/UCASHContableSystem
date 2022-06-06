package datos;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class Dt_recoverPassword {
	//ATRIBUTOS

		/*---------------------- Configuración Localhost------------------------------*/
		private static final String SMTP_HOST_NAME = "smtp.gmail.com";
		private static final String SMTP_AUTH_USER = "jaol260549@gmail.com";
		private static final String SMTP_AUTH_PWD = "hrtomvrniwskgtsv";

		//Enlace de verificación de correo
	    String linkHR = "http://localhost:8080/SistemaContable/";

	    //DECLARAMOS UNA CLASE PRIVADA COMO ATRIBUTO QUE HEREDA JAVAX.MAIL.AUTHENTICATOR
	    private class SMTPAuthenticator extends javax.mail.Authenticator 
		{
			public PasswordAuthentication getPasswordAuthentication() 
			{
				String username = SMTP_AUTH_USER;
				String password = SMTP_AUTH_PWD;
				return new PasswordAuthentication(username, password);
			}
		}

	    /*----------------------------------------------------------------------------*/

	    //METODO QUE ENVIA EL EMAIL DE VERIFICACION
		public boolean recoverPassword(String contrase�aDesencriptada, String correo, String usuario) throws MessagingException{

			boolean debug=false;

		   // Correo del solicitante
			String email_solicitante = correo;

		   // Correo del remitente
			String email_remitente = SMTP_HOST_NAME;

		   // Obtener propiedades del sistema
		   Properties properties = new Properties();


		   /*---------------------- Configuración del servidor de correo---------------------------*/ 
		   properties.setProperty("mail.smtp.host", SMTP_HOST_NAME);
		   properties.put("mail.smtp.auth", "true");
		   properties.setProperty("mail.smtp.port", "587");
		   properties.put("mail.smtp.starttls.enable", "true");
		   /*--------------------------------------------------------------------------------------*/

		   Authenticator auth = new SMTPAuthenticator();

		     Session session = Session.getInstance(properties,auth);
			 session.setDebug(debug);

		      // Create a default MimeMessage object.
		      	MimeMessage message = new MimeMessage(session);

		      // Establecer De (remitente)
		      	message.setFrom(new InternetAddress(email_remitente));

		      // Establecer Para (solicitante)
		      	message.addRecipient(Message.RecipientType.TO, new InternetAddress(email_solicitante));

		      // Asunto: encabezado del archivo
		        message.setSubject("PROCESO DE RECUPERACI�N DE CONTRASE�A");


		      //Cuerpo del correo  
		        String myMsg = "<strong>PROCESO DE RECUPERACI�N DE CONTRASE�A </strong><br><br>";
		      	myMsg += "Estimado "+usuario+", esta es su contrase�a: ";
		      	myMsg += contrase�aDesencriptada+" <br><br>";
		      	myMsg += "<br>----------------------------------------------------------<br>";
		      	myMsg += "Administrador del Sistema<br>";
		      	myMsg += "Celular: +505 8888-8888 <br>";
		      	myMsg += "CARGO<br>";
		      	myMsg += "INSTITUCION";

		      message.setContent(myMsg, "text/html");

		      // Enviar Correo
		      Transport transport = session.getTransport("smtp");
		      transport.connect(SMTP_HOST_NAME, SMTP_AUTH_USER, SMTP_AUTH_PWD);
		      Transport.send(message);
		      debug = true;
		      System.out.println("El mensaje fue enviado con éxito");
		      return debug;
		}

}