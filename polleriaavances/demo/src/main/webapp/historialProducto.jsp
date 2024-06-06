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
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1f1c2c, #928DAB);
            font-family: 'Orbitron', sans-serif;
            color: #ffffff;
        }
        .container {
            margin-top: 5%;
            margin-bottom: 3%;
        }
        .card {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            padding: 30px;
        }
        .card-header {
            background: none;
            border-bottom: none;
        }
        .card-title {
            font-size: 2rem;
            text-align: center;
            margin-bottom: 20px;
        }
        .table {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
            border-radius: 15px;
            overflow: hidden;
        }
        .table thead th {
            background-color: rgba(90, 84, 232, 0.8);
            border: none;
        }
        .table tbody tr {
            transition: background-color 0.3s ease;
        }
        .table tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .btn-primary {
            background-color: #5A54E8;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #837DFF;
        }
        .btn-success {
            background-color: #5AE854;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-success:hover {
            background-color: #83FF7D;
        }
        .btn-danger {
            background-color: #E85454;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #FF837D;
        }
        .alert-success {
            background-color: rgba(90, 232, 84, 0.8);
            border: none;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3 w-100 mt-3">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Mi Aplicacion</a>
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
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5 centered-form">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title">Historial de Productos</h2>
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
                        <td>S/ <%= bean.getPrecio() %></td>
                        <td><%= bean.getCategoria() %></td>
                        <td><img src="<%= bean.getImagen() %>" alt="Imagen del producto" class="img-thumbnail" style="max-width: 100px;"></td>
                        <td><%= bean.getEstado() %></td>
                        <td>
                            <a href="contRestaurar?id=<%=bean.getId()%>" class="btn btn-sm btn-success" onclick="return confirm('¿Está seguro de que desea restaurar este producto?');">
                                <i class="fas fa-undo"></i> Restaurar
                            </a>
                            <a href="contEliminarFis?id=<%=bean.getId()%>" class="btn btn-sm btn-danger" onclick="return confirm('¿Está seguro de que desea eliminar este producto permanentemente?');">
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
    </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
