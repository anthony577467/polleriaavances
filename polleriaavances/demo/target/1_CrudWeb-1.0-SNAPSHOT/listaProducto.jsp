<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.demo.dto.ProductoDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<ProductoDTO> lista = (List<ProductoDTO>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CRUD DE PRODUCTOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3 w-100 mt-3">
    <div class="container-fluid">
        <a class="navbar-brand" href="crearProducto.jsp">Mi Aplicacion</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="usuarioGetAll">Lista de Productos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="historial">Historial</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="home">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="wrapper mt-5">
    <% if (lista != null) { %>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
            <tr class="text-center">
                <th>Nombre</th>
                <th>Descripcion</th>
                <th>Precio</th>
                <th>Categoria</th>
                <th>Imagen</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (ProductoDTO bean : lista) { %>
            <tr class="text-center">
                <td><%= bean.getNombre() %></td>
                <td><%= bean.getDescripcion() %></td>
                <td>S/ <%= String.format("%.2f", bean.getPrecio()) %></td>
                <td><%= bean.getCategoria() %></td>
                <td><img src="<%= bean.getImagen() %>" alt="Imagen del producto" class="img-thumbnail" style="max-width: 100px;"></td>
                <td><%= bean.getEstado() %></td>
                <td>
                    <a href="contEditar?id=<%=bean.getId()%>" class="btn btn-sm btn-primary">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                    <a href="contEliminar?id=<%=bean.getId()%>" class="btn btn-sm btn-danger" onclick="return confirm('¿Está seguro de que desea eliminar este producto?');">
                        <i class="fas fa-trash"></i> Eliminar
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
