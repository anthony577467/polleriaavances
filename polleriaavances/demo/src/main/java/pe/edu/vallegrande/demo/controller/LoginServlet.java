    package pe.edu.vallegrande.demo.controller;

    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import java.io.IOException;
    import java.util.logging.Level;
    import java.util.logging.Logger;
    import pe.edu.vallegrande.demo.dto.ClienteDTO;
    import pe.edu.vallegrande.demo.service.ClienteService;

    @WebServlet("/LoginServlet")
    public class LoginServlet extends HttpServlet {

        private static final Logger logger = Logger.getLogger(LoginServlet.class.getName());

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Obtener los datos del formulario
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Verificar las credenciales
            boolean isAuthenticated = authenticate(email, password);

            if (isAuthenticated) {
                // Si las credenciales son válidas, guardar el correo electrónico en la sesión
                request.getSession().setAttribute("userEmail", email);
                // Redirigir a la página de inicio
                response.sendRedirect("cart.jsp");
                logger.log(Level.INFO, "Inicio de sesión exitoso para el usuario: {0}", email);
            } else {
                // Si las credenciales son incorrectas, mostrar un mensaje de error y volver al formulario de inicio de sesión
                request.setAttribute("errorMessage", "Credenciales incorrectas. Por favor, inténtelo de nuevo.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                logger.log(Level.WARNING, "Inicio de sesión fallido para el usuario: {0}", email);
            }
        }

        private boolean authenticate(String email, String password) {
            ClienteService clienteService = new ClienteService();
            ClienteDTO cliente = clienteService.getByEmail(email);

            if (cliente != null) {
                logger.log(Level.INFO, "Inicio de sesión exitoso para el usuario: {0}", email);
                return true;
            } else {
                logger.log(Level.WARNING, "Credenciales incorrectas para el usuario: {0}", email);
                return false;
            }
        }
    }
