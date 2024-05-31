package pe.edu.vallegrande.demo.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.edu.vallegrande.demo.dto.ProductoDTO;
import pe.edu.vallegrande.demo.service.ProductoService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet({"/usuarioGetAll", "/contProcesar", "/contEditar", "/contActualizar", "/contEliminar", "/home", "/historial", "/contRestaurar"})

public class ProductoControler extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/usuarioGetAll":
                usuarioGetAll(request, response);
                break;
            case "/contProcesar":
                contProcesar(request, response);
                break;
            case "/contEditar":
                contEditar(request, response);
                break;
            case "/contActualizar":
                contActualizar(request, response);
                break;
            case "/contEliminar":
                contEliminar(request, response);
                break;
            case "/home":
                showHomePage(request, response);
                break;
            case "/historial":
                getAllInactivo(request, response);
                break;
            case "/contRestaurar":
                contRestaurar(request, response);
                break;
        }
    }

    private void usuarioGetAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductoService service = new ProductoService();
        // List<PolloDato> lista = service.getAll(); Recoge todos los datos por ID
        List<ProductoDTO> lista = service.getAllProd(); // Recoge solo datos por el estado "activo"

        request.setAttribute("lista", lista);
        RequestDispatcher rd = request.getRequestDispatcher("listaProducto.jsp");
        rd.forward(request, response);
    }

    private void contProcesar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        BigDecimal precio = new BigDecimal(request.getParameter("precio"));
        String categoria = request.getParameter("categoria");
        String imagen = request.getParameter("imagen");
        String estado = "activo"; // Estado fijo como activo

        ProductoDTO bean = new ProductoDTO(0, nombre, descripcion, precio, categoria, imagen, estado);
        ProductoService service = new ProductoService();
        bean = service.createProd(bean);

        request.setAttribute("bean", bean);
        response.sendRedirect("crearProducto.jsp");
    }

    private void contEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id"));
        ProductoService service = new ProductoService();
        ProductoDTO usuario = service.getByIdProd(idUsuario);
        request.setAttribute("usuario", usuario);
        RequestDispatcher rd = request.getRequestDispatcher("editarProducto.jsp");
        rd.forward(request, response);
    }

    private void contActualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        BigDecimal precio = null;
        try {
            precio = new BigDecimal(request.getParameter("precio"));
        } catch (NumberFormatException e) {
            // Manejar la excepción en caso de que el valor de precio no sea un número válido
            // Puedes tomar alguna acción, como asignar un valor por defecto o mostrar un mensaje de error al usuario
            e.printStackTrace();
        }
        String categoria = request.getParameter("categoria");
        String imagen = request.getParameter("imagen");
        String estado = request.getParameter("estado");

        if (!estado.equals("activo")) {
            // Manejar error de validación
            // Puedes redirigir a una página de error o mostrar un mensaje al usuario
            response.sendRedirect("error.jsp");
            return;
        }

        ProductoDTO usuario = new ProductoDTO();
        usuario.setId(idUsuario);
        usuario.setNombre(nombre);
        usuario.setDescripcion(descripcion);
        usuario.setPrecio(precio);
        usuario.setCategoria(categoria);
        usuario.setImagen(imagen);
        usuario.setEstado(estado);

        ProductoService service = new ProductoService();
        service.updateProd(usuario);

        response.sendRedirect("usuarioGetAll");
    }

    private void getAllInactivo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductoService service = new ProductoService();
        List<ProductoDTO> lista = service.getAllInactivoProd(); // Obtener la lista de productos inactivos

        request.setAttribute("lista", lista); // Establecer la lista como atributo en el request
        RequestDispatcher rd = request.getRequestDispatcher("historialProducto.jsp"); // Redirigir a historial.jsp
        rd.forward(request, response);
    }

    private void contEliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        // Aquí deberías tener un método en tu servicio que actualice el estado del producto
        ProductoService service = new ProductoService();
        service.deleteProd(id); // Método que actualiza el estado del producto a "inactivo"

        response.sendRedirect("usuarioGetAll");
    }

    private void contRestaurar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        // Aquí deberías tener un método en tu servicio que restaure el producto a "activo"
        ProductoService service = new ProductoService();
        service.restaurarProd(id); // Método que restaura el estado del producto a "activo"

        response.sendRedirect("usuarioGetAll");
    }


    private void showHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductoService service = new ProductoService();
        List<ProductoDTO> lista = service.getAllProd();
        request.setAttribute("lista", lista);
        RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
        rd.forward(request, response);
    }

    public void destroy() {
    }
}
