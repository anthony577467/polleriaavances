<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 18/05/2024
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <title>Detalles del Cliente</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="container">
  <h1>Detalles del Cliente</h1>
  <c:choose>
    <c:when test="${not empty cliente}">
      <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
          <th>ID</th>
          <th>NOMBRES</th>
          <th>APELLIDOS</th>
          <th>TIPO DE DOCUMENTO</th>
          <th>DNI o Carnet</th>
          <th>TELEFONO</th>
          <th>CORREO</th>
          <th>DIRECCION</th>
          <th>UBIGEO</th>
          <th>FECHA DE CUMPLEAÑOS</th>
        </tr>
        </thead>
        <tbody>
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
        </tr>
        </tbody>
      </table>
      <a href="index.jsp" class="btn btn-primary">Regresar al Inicio</a>
    </c:when>
    <c:otherwise>
      <p class="alert alert-warning">El cliente no fue encontrado.</p>
    </c:otherwise>
  </c:choose>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
