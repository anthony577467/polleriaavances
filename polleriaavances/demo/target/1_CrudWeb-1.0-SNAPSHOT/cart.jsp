<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo.dto.ClienteDTO" %>
<%@ page import="pe.edu.vallegrande.demo.dto.CartDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%
    List<CartDTO> cart = (List<CartDTO>) session.getAttribute("cart");
    BigDecimal igv = new BigDecimal("0.18"); // IGV del 18%
    ClienteDTO cliente = (ClienteDTO) session.getAttribute("cliente");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
<div class="container mt-5" style="display:none;">
    <h2>Perfil de Usuario</h2>
    <p><strong>Correo Electrónico:</strong> <%= cliente != null ? cliente.getCorreo() : "" %></p>
    <p><strong>Nombre:</strong> <%= cliente != null ? cliente.getNombres() : "" %></p>
    <p><strong>Apellidos:</strong> <%= cliente != null ? cliente.getApellidos() : "" %></p>
    <p><strong>DNI o Carnet:</strong> <%= cliente != null ? cliente.getDniocarnet() : "" %></p>
    <p><strong>Teléfono:</strong> <%= cliente != null ? cliente.getTelefono() : "" %></p>
    <p><strong>Dirección:</strong> <%= cliente != null ? cliente.getDireccion() : "" %></p>
</div>
<div class="container mt-5">
    <h1>Carrito de Compras</h1>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Producto</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <% if (cart != null) {
            BigDecimal total = BigDecimal.ZERO;
            for (CartDTO item : cart) {
                BigDecimal itemTotal = item.getPrecio().multiply(new BigDecimal(item.getCantidad()));
                total = total.add(itemTotal);
        %>
        <tr>
            <td><%= item.getNombre() %></td>
            <td>S/ <%= item.getPrecio().setScale(2, BigDecimal.ROUND_HALF_UP) %></td>
            <td><%= item.getCantidad() %></td>
            <td>S/ <%= itemTotal.setScale(2, BigDecimal.ROUND_HALF_UP) %></td>
        </tr>
        <% }
            BigDecimal totalConIGV = total.add(total.multiply(igv)).setScale(2, BigDecimal.ROUND_HALF_UP);
        %>
        <tr>
            <td colspan="3" class="text-right">Subtotal</td>
            <td>S/ <%= total.setScale(2, BigDecimal.ROUND_HALF_UP) %></td>
        </tr>
        <tr>
            <td colspan="3" class="text-right">IGV (18%)</td>
            <td>S/ <%= total.multiply(igv).setScale(2, BigDecimal.ROUND_HALF_UP) %></td>
        </tr>
        <tr>
            <td colspan="3" class="text-right">Total</td>
            <td>S/ <%= totalConIGV %></td>
        </tr>
        <% } else { %>
        <tr>
            <td colspan="4" class="text-center">El carrito está vacío</td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <%
        if (cliente != null) {
    %>
    <button id="descargar-pdf" class="btn btn-primary">Descargar PDF</button>
    <%
    } else {
    %>
    <a href="login.jsp" class="btn btn-info">Iniciar Sesión</a>
    <%
        }
    %>
</div>

<%
    if (cliente != null) {
%>
<div id="hidden-client-data"
     data-correo="<%= cliente.getCorreo() %>"
     data-nombres="<%= cliente.getNombres() %>"
     data-apellidos="<%= cliente.getApellidos() %>"
     data-dniocarnet="<%= cliente.getDniocarnet() %>"
     data-telefono="<%= cliente.getTelefono() %>"
     data-direccion="<%= cliente.getDireccion() %>"
     style="display:none;"></div>
<%
    }
%>

<script>
    document.getElementById('descargar-pdf').addEventListener('click', function() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Título
        doc.setFontSize(18);
        doc.text("Boleta de Compra", 10, 10);

        // Datos del cliente
        doc.setFontSize(12);
        const clientData = document.getElementById('hidden-client-data');
        const cliente = {
            correo: clientData ? clientData.getAttribute('data-correo') : '',
            nombres: clientData ? clientData.getAttribute('data-nombres') : '',
            apellidos: clientData ? clientData.getAttribute('data-apellidos') : '',
            dniocarnet: clientData ? clientData.getAttribute('data-dniocarnet') : '',
            telefono: clientData ? clientData.getAttribute('data-telefono') : '',
            direccion: clientData ? clientData.getAttribute('data-direccion') : ''
        };

        doc.text(`Correo Electrónico: ${cliente.correo}`, 10, 30);
        doc.text(`Nombre: ${cliente.nombres}`, 10, 40);
        doc.text(`Apellidos: ${cliente.apellidos}`, 10, 50);
        doc.text(`DNI o Carnet: ${cliente.dniocarnet}`, 10, 60);
        doc.text(`Teléfono: ${cliente.telefono}`, 10, 70);
        doc.text(`Dirección: ${cliente.direccion}`, 10, 80);

        // Datos del carrito
        const columns = ["Producto", "Precio", "Cantidad", "Total"];
        const data = [];
        document.querySelectorAll('table tbody tr').forEach(row => {
            const rowData = [];
            row.querySelectorAll('td').forEach((cell, index) => {
                if (index < 4) {
                    rowData.push(cell.innerText);
                }
            });
            if (rowData.length > 0) {
                data.push(rowData);
            }
        });

        doc.autoTable({
            head: [columns],
            body: data,
            startY: 90, // Ajustar la posición de inicio de la tabla
            theme: 'striped',
            styles: {
                fontSize: 10,
                cellPadding: 2,
                overflow: 'linebreak'
            },
            headStyles: {
                fillColor: [22, 160, 133],
                textColor: 255,
                fontStyle: 'bold'
            },
            bodyStyles: {
                fillColor: [216, 216, 216]
            },
            alternateRowStyles: {
                fillColor: [240, 240, 240]
            },
            margin: { top: 90 }
        });

        // Guardar el PDF
        doc.save("boleta_compra.pdf");
    });
</script>

</body>
</html>
