<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo.dto.CartDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%
    List<CartDTO> cart = (List<CartDTO>) session.getAttribute("cart");
    BigDecimal igv = new BigDecimal("0.18"); // IGV del 18%
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
        <%
            if (cart != null) {
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
        <%
            }
            // Calcular el IGV y sumarlo al total
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
        <%
        } else {
        %>
        <tr>
            <td colspan="4" class="text-center">El carrito está vacío</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <button id="descargar-pdf" class="btn btn-primary">Descargar PDF</button>
</div>

<script>
    document.getElementById('descargar-pdf').addEventListener('click', function() {
        const { jsPDF } = window.jspdf;

        const doc = new jsPDF();
        doc.text("Boleta de Compra", 10, 10);

        // Definir las columnas de la tabla
        const columns = ["Producto", "Precio", "Cantidad", "Total"];

        // Obtener los datos de la tabla HTML
        const data = [];
        document.querySelectorAll('table tbody tr').forEach(row => {
            const rowData = [];
            row.querySelectorAll('td').forEach((cell, index) => {
                // Solo agregar el contenido de las celdas que no son el total
                if (index < 4) {
                    rowData.push(cell.innerText);
                }
            });
            if (rowData.length > 0) {
                data.push(rowData);
            }
        });

        // Generar la tabla en el PDF
        doc.autoTable({
            head: [columns],
            body: data,
            startY: 20
        });

        // Guardar el PDF con un nombre específico
        doc.save('boleta_compra.pdf');

        // Mostrar un mensaje de éxito al usuario
        Swal.fire({
            icon: 'success',
            title: 'Descarga completa',
            text: 'El PDF se ha descargado correctamente.'
        });
    });
</script>
</body>
</html>
