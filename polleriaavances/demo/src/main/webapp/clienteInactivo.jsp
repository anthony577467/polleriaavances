<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25/05/2024
  Time: 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Lista de Clientes Inactivos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1f1c2c, #928DAB);
            font-family: 'Orbitron', sans-serif;
            color: #ffffff;
        }
        .container {
            margin-top: 50px;
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
            background-color: rgba(232, 84, 84, 0.8);
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
        .alert-success {
            background-color: rgba(90, 232, 84, 0.8);
            border: none;
        }
    </style>
</head>
<body>
<div class="container p-4">
    <div class="card">
        <div class="card-header">
            <h1 class="card-title">Lista de Clientes Inactivos</h1>
        </div>
        <div class="card-body">
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success">${mensaje}</div>
            </c:if>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead class="table-danger">
                    <tr class="text-center">
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Tipo de Documento</th>
                        <th>Número de Documento</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th>Dirección</th>
                        <th>Ubigeo</th>
                        <th>Fecha de Cumpleaños</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${lista}" var="cliente">
                        <tr>
                            <td>${cliente.id}</td>
                            <td>${cliente.nombres}</td>
                            <td>${cliente.apellidos}</td>
                            <td>${cliente.tipoDocumento}</td>
                            <td>${cliente.dniocarnet}</td>
                            <td>${cliente.telefono}</td>
                            <td>${cliente.correo}</td>
                            <td>${cliente.direccion}</td>
                            <td>${cliente.ubigeo}</td>
                            <td>${cliente.fechaNacimiento}</td>
                            <td class="text-center">
                                <form action="cliUpdatei" method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="${cliente.id}">
                                    <button type="submit" class="btn btn-success">Restablecer</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="text-center mt-3">
        <a href="index.jsp" class="btn btn-primary">Regresar al Inicio</a>
        <a href="crearCliente.jsp" class="btn btn-success">Crear Nuevo Cliente</a>
        <a href="CliGetAll" class="btn btn-primary">Ir a Lista de Clientes</a>
    </div>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function mostrarAlerta() {
        alert("¡Cliente eliminado!");
    }
</script>
</body>
</html>
