package pe.edu.vallegrande.demo.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.edu.vallegrande.demo.dto.ClienteDTO;
import pe.edu.vallegrande.demo.service.ClienteService;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet({"/CliGetAll", "/getAllInactivos", "/CliGetId", "/CliCrear", "/CliActualizar", "/CliBorrar", "/CliEditar", "/cliUpdatei"})
public class ClienteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/CliGetAll":
                getAll(req, resp);
                break;
            case "/CliGetId":
                getById(req, resp);
                break;
            case "/CliEditar":
                cliEdit(req, resp);
                break;
            case "/getAllInactivos":
                getAllInactivos(req, resp);
                break;
        }
    }

    private void getAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ClienteDTO> lista;
        ClienteService service = new ClienteService();
        lista = service.getAll();
        req.setAttribute("lista", lista);
        RequestDispatcher rd = req.getRequestDispatcher("cliente.jsp");
        rd.forward(req, resp);
    }


    private void getAllInactivos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ClienteDTO> lista;
        ClienteService service = new ClienteService();
        lista = service.getAllInactivos();
        req.setAttribute("lista", lista);
        RequestDispatcher rd = req.getRequestDispatcher("clienteInactivo.jsp");
        rd.forward(req, resp);
    }

    private void getById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        ClienteService service = new ClienteService();
        ClienteDTO cliente = service.getById(id);

        if (cliente != null) {
            req.setAttribute("cliente", cliente);
            RequestDispatcher rd = req.getRequestDispatcher("detalleCliente.jsp");
            rd.forward(req, resp);
        } else {
            String mensaje = "El cliente con ID " + id + " no fue encontrado";
            req.setAttribute("mensaje", mensaje);
            resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/CliCrear":
                cliCreate(req, resp);
                break;
            case "/CliActualizar":
                cliUpdate(req, resp);
                break;
            case "/CliBorrar":
                cliDelete(req, resp);
                break;
            case "/cliUpdatei":
                updateStatusToActive(req, resp);
                break;
        }
    }

    private void cliCreate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String nombres = req.getParameter("nombres");
        String apellidos = req.getParameter("apellidos");
        String tipoDocumento = req.getParameter("tipoDocumento");
        String dniocarnet = req.getParameter("dniocarnet");
        String telefono = req.getParameter("telefono");
        String correo = req.getParameter("correo");
        String direccion = req.getParameter("direccion");
        String ubigeo = req.getParameter("ubigeo");
        String fechaNacimiento = req.getParameter("fechaNacimiento");

        if (nombres != null && !nombres.isEmpty() &&
                apellidos != null && !apellidos.isEmpty() &&
                tipoDocumento != null && !tipoDocumento.isEmpty() &&
                dniocarnet != null && !dniocarnet.isEmpty() &&
                telefono != null && !telefono.isEmpty() &&
                correo != null && !correo.isEmpty() &&
                ubigeo != null && !ubigeo.isEmpty() &&
                fechaNacimiento != null && !fechaNacimiento.isEmpty()) {

            ClienteDTO nuevoCliente = new ClienteDTO();
            nuevoCliente.setNombres(nombres);
            nuevoCliente.setApellidos(apellidos);
            nuevoCliente.setTipoDocumento(tipoDocumento);
            nuevoCliente.setDniocarnet(dniocarnet);
            nuevoCliente.setTelefono(telefono);
            nuevoCliente.setCorreo(correo);
            nuevoCliente.setDireccion(direccion);
            nuevoCliente.setUbigeo(ubigeo);
            nuevoCliente.setFechaNacimiento(fechaNacimiento);

            ClienteService service = new ClienteService();
            int nuevoClienteId = service.create(nuevoCliente);

            if (nuevoClienteId != 0) {
                String redirectURL = req.getContextPath() + "/CliGetId?id=" + nuevoClienteId;
                resp.sendRedirect(redirectURL);
            } else {
                String mensaje = "Error al crear el nuevo cliente";
                req.setAttribute("mensaje", mensaje);
                resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
            }
        } else {
            String mensaje = "Todos los campos son obligatorios";
            req.setAttribute("mensaje", mensaje);
            resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
        }
    }

    private void cliEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        ClienteService service = new ClienteService();
        ClienteDTO cliente = service.getById(id);

        if (cliente != null) {
            req.setAttribute("cliente", cliente);
            RequestDispatcher rd = req.getRequestDispatcher("editarCliente.jsp");
            rd.forward(req, resp);
        } else {
            String mensaje = "El cliente con ID " + id + " no fue encontrado";
            req.setAttribute("mensaje", mensaje);
            resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
        }
    }
    private void updateStatusToActive(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        ClienteService service = new ClienteService();
        ClienteDTO cliente = service.updateStatusToActive(id);

        if (cliente != null) {
            resp.sendRedirect(req.getContextPath() + "/CliGetAll");
        } else {
            String mensaje = "El cliente con ID " + id + " no fue encontrado o no se pudo actualizar";
            req.setAttribute("mensaje", mensaje);
            resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
        }
    }


    private void cliUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String nombres = req.getParameter("nombres");
        String apellidos = req.getParameter("apellidos");
        String tipoDocumento = req.getParameter("tipoDocumento");
        String dniocarnet = req.getParameter("dniocarnet");
        String telefono = req.getParameter("telefono");
        String correo = req.getParameter("correo");
        String direccion = req.getParameter("direccion");
        String ubigeo = req.getParameter("ubigeo");
        String fechaNacimiento = req.getParameter("fechaNacimiento");
        String activo = req.getParameter("activo");

        ClienteService service = new ClienteService();
        ClienteDTO cliente = service.getById(id);

        if (cliente != null) {
            cliente.setNombres(nombres);
            cliente.setApellidos(apellidos);
            cliente.setTipoDocumento(tipoDocumento);
            cliente.setDniocarnet(dniocarnet);
            cliente.setTelefono(telefono);
            cliente.setCorreo(correo);
            cliente.setDireccion(direccion);
            cliente.setUbigeo(ubigeo);
            cliente.setFechaNacimiento(fechaNacimiento);
            cliente.setActivo(activo);
            service.update(cliente);

            resp.sendRedirect(req.getContextPath() + "/CliGetAll");
        } else {
            String mensaje = "El cliente con ID " + id + " no fue encontrado";
            req.setAttribute("mensaje", mensaje);
            resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
        }
    }


    protected void cliDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        ClienteService service = new ClienteService();
        boolean eliminado = service.delete(id);

        if (eliminado) {
            String mensaje = "Cliente eliminado correctamente";
            req.setAttribute("mensaje", mensaje);
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            String mensaje = "El cliente con ID " + id + " no fue encontrado";
            req.setAttribute("mensaje", mensaje);
            resp.sendRedirect(req.getContextPath() + "/index.jsp?mensaje=" + URLEncoder.encode(mensaje, "UTF-8"));
        }
    }
}
