<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo.dto.ProductoDTO" %>
<%@ page import="java.util.List" %>
<% List<ProductoDTO> lista = (List<ProductoDTO>) request.getAttribute("lista"); %>
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
        .wrapper {
            width: 100%;
            max-width: 1000px;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }
        .card {
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        }
        .card img {
            max-width: 100%; /* Ancho máximo de la imagen */
            max-height: 100%; /* Altura máxima de la imagen */
            border-radius: 15px 15px 0 0; /* Para mantener el borde redondeado */
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .card-text {
            font-size: 1rem;
            font-weight: 400;
            margin-bottom: 15px;
        }
        .btn-add-to-cart {
            background-color: #fff;
            color: #000;
            font-weight: 600;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 3px;
            font-size: 16px;
            border: 2px solid transparent;
            transition: 0.3s ease;
        }
        .btn-add-to-cart:hover {
            color: #fff;
            border-color: #fff;
            background: rgba(255, 255, 255, 0.15);
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
            <li class="nav-item">
                <a class="nav-link" href="cart.jsp">Carrito</a>
            </li>
        </ul>
    </div>
</nav>

<div class="wrapper mt-5">
    <h1>Bienvenidos a Pollería Celinda</h1>
    <p>¡Eliga los productos que mas prefiera!</p>
</div>

<div class="container menu">
    <div class="row">
        <% if (lista != null) {
            for (ProductoDTO producto : lista) { %>
        <div class="col-md-4">
            <div class="card">
                <img src="<%= producto.getImagen() %>" class="card-img-top" alt="<%= producto.getNombre() %>">
                <div class="card-body">
                    <h3 class="card-title"><%= producto.getNombre() %></h3>
                    <p class="card-text"><%= producto.getDescripcion() %></p>
                    <p class="card-text">Precio: S/ <%= producto.getPrecio() %></p>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="id" value="<%= producto.getId() %>">
                        <input type="hidden" name="nombre" value="<%= producto.getNombre() %>">
                        <input type="hidden" name="precio" value="<%= producto.getPrecio() %>">
                        <input type="hidden" name="cantidad" value="1"> <!-- Puedes permitir al usuario seleccionar la cantidad -->
                        <button type="submit" class="btn btn-add-to-cart">Agregar al carrito</button>
                    </form>
                </div>
            </div>
        </div>
        <% }
        } %>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>