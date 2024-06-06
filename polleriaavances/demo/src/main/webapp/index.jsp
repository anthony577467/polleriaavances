<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Pollería El Buen Sabor</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #FFD700, #FF4500);
      font-family: 'Orbitron', sans-serif;
      color: #ffffff;
    }
    .navbar {
      background-color: #FF4500;
    }
    .navbar-brand, .nav-link {
      color: #fff !important;
    }
    .header {
      text-align: center;
      padding: 50px 0;
    }
    .header h1 {
      font-size: 4rem;
      margin-bottom: 20px;
    }
    .header p {
      font-size: 1.5rem;
    }
    .menu {
      padding: 50px 0;
    }
    .menu-item {
      background: rgba(255, 255, 255, 0.1);
      border: none;
      border-radius: 15px;
      box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      padding: 20px;
      margin-bottom: 30px;
    }
    .menu-item h3 {
      font-size: 1.5rem;
      margin-bottom: 15px;
    }
    .menu-item p {
      font-size: 1rem;
    }
    .contact {
      padding: 50px 0;
      text-align: center;
    }
    .contact h2 {
      font-size: 2.5rem;
      margin-bottom: 30px;
    }
    .contact form .form-control {
      background: transparent;
      border: 1px solid #ffffff;
      color: #ffffff;
      transition: all 0.3s ease;
    }
    .contact form .form-control:focus {
      box-shadow: 0 0 10px rgba(255, 255, 255, 0.6);
      border-color: #ffffff;
    }
    .btn-primary {
      background-color: #000000;
      border: none;
      transition: background-color 0.3s ease;
    }
    .btn-primary:hover {
      background-color: #0c0c0c;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
  <a class="navbar-brand" href="#">Pollería Celinda</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav ml-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Inicio</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="menu">Menú</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="galeria.jsp">Galería</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#contacto">Contacto</a>
      </li>
    </ul>
  </div>
</nav>

<div class="header">
  <h1>Bienvenidos a Pollería Celinda</h1>
  <p>¡El mejor pollo a la brasa de la ciudad!</p>
</div>

<div id="menu" class="container menu">
  <div class="row">
    <div class="col-md-4">
      <div class="menu-item">
        <h3>Pollo a la Brasa</h3>
        <p>Delicioso pollo a la brasa acompañado de papas fritas y ensalada.</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="menu-item">
        <h3>Anticuchos</h3>
        <p>Tradicionales anticuchos peruanos, servidos con choclo y papas doradas.</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="menu-item">
        <h3>Salchipapas</h3>
        <p>Salchipapas clásicas con salchicha de primera y papas crujientes.</p>
      </div>
    </div>
  </div>
</div>

<a href="CliGetAll" class="btn btn-primary">Ir a Lista de cliente</a>
<a href="usuarioGetAll" class="btn btn-primary">Ir a Lista de los productos</a>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>