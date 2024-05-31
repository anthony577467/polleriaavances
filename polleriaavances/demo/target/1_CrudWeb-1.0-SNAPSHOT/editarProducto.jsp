<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Open+Sans:wght@200;300;400;500;600;700&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Open Sans", sans-serif;
        }
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            width: 100%;
            padding: 0 10px;
            background: url("https://www.codingnepalweb.com/demos/create-glassmorphism-login-form-html-css/hero-bg.jpg"), #000;
            background-position: center;
            background-size: cover;
        }
        .wrapper {
            width: 600px;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            background-color: rgba(255, 255, 255, 0.1);
        }
        form {
            display: flex;
            flex-direction: column;
        }
        h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #fff;
        }
        .input-field {
            position: relative;
            border-bottom: 2px solid #ccc;
            margin: 15px 0;
        }
        .input-field label {
            position: absolute;
            top: -10px; /* Ajusta la posición para que el label permanezca arriba */
            left: 0;
            color: #fff;
            font-size: 16px;
            pointer-events: none;
            transition: none; /* Elimina la transición */
        }
        .input-field input {
            width: 100%;
            height: 40px;
            background: transparent;
            border: none;
            outline: none;
            font-size: 16px;
            color: #fff;
        }
        .input-field input:focus~label,
        .input-field input:valid~label {
            font-size: 0.8rem;
            top: -10px; /* Mantiene el label arriba sin transición */
            transform: translateY(0); /* Asegura que el label permanezca en la posición correcta */
        }
        .btn-primary {
            background: #fff;
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
        .btn-primary:hover {
            color: #fff;
            border-color: #fff;
            background: rgba(255, 255, 255, 0.15);
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Agregar event listeners para validación en tiempo real
            document.getElementById('nombre').addEventListener('input', validateNombre);
            document.getElementById('descripcion').addEventListener('input', validateDescripcion);
            document.getElementById('precio').addEventListener('input', validatePrecio);
            document.getElementById('categoria').addEventListener('change', validateCategoria);
            document.getElementById('imagen').addEventListener('input', validateImagen);
        });

        function validateNombre() {
            var nombre = document.getElementById('nombre').value;
            var nombrePattern = /^[a-zA-Z0-9\s]+$/;
            var nombreError = document.getElementById('nombre-error');

            if (!nombrePattern.test(nombre)) {
                nombreError.innerText = "El nombre solo debe contener letras y espacios.";
                nombreError.style.display = "block";
            } else {
                nombreError.style.display = "none";
            }
        }

        function validateDescripcion() {
            var descripcion = document.getElementById('descripcion').value;
            var descripcionPattern = /^[a-zA-Z0-9\s]+$/;
            var descripcionError = document.getElementById('descripcion-error');

            if (!descripcionPattern.test(descripcion)) {
                descripcionError.innerText = "La descripción solo debe contener letras, números y espacios.";
                descripcionError.style.display = "block";
            } else {
                descripcionError.style.display = "none";
            }
        }

        function validatePrecio() {
            var precio = document.getElementById('precio').value;
            var precioPattern = /^\d+(\.\d{1,2})?$/;
            var precioError = document.getElementById('precio-error');

            if (!precioPattern.test(precio)) {
                precioError.innerText = "El precio debe ser un número válido. Ejemplo: 123.45";
                precioError.style.display = "block";
            } else {
                precioError.style.display = "none";
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            // Agregar event listener al campo de categoría
            document.getElementById('categoria').addEventListener('input', validateCategoria);
        });

        function validateCategoria() {
            var categoria = document.getElementById('categoria').value;
            var categoriaError = document.getElementById('categoria-error');

            // Verificar si la categoría seleccionada es válida
            if (categoria !== "Bebidas" && categoria !== "Comida") {
                categoriaError.innerText = "La categoría debe ser 'Bebidas' o 'Comida'.";
                categoriaError.style.display = "block";
            } else {
                categoriaError.style.display = "none";
            }
        }

        function validateImagen() {
            var imagen = document.getElementById('imagen').value;
            var imagenPattern = /^(ftp|http|https):\/\/[^ "]+$/;
            var imagenError = document.getElementById('imagen-error');

            if (!imagenPattern.test(imagen)) {
                imagenError.innerText = "La URL de la imagen no es válida.";
                imagenError.style.display = "block";
            } else {
                imagenError.style.display = "none";
            }
        }

        function validateForm(event) {
            event.preventDefault();

            validateNombre();
            validateDescripcion();
            validatePrecio();
            validateCategoria();
            validateImagen();

            var errors = document.querySelectorAll('.invalid-feedback');
            var isValid = true;

            // Verificar si hay errores visibles
            errors.forEach(function(error) {
                if (error.style.display !== "none") {
                    isValid = false;
                }
            });

            var formError = document.getElementById('form-error');

            if (!isValid) {
                // Si hay errores de validación, mostrar el mensaje de error
                formError.style.display = "block";
                return false;
            } else {
                // Si no hay errores de validación, ocultar el mensaje de error y permitir el envío del formulario
                formError.style.display = "none";
                event.target.submit();
                return true;
            }
        }
    </script>
</head>
<body>
<div class="wrapper">
    <form id="formulario" action="contActualizar" method="post" onsubmit="return validateForm(event)">
        <h2>Editar Producto</h2>
        <input type="hidden" name="accion" value="actualizar">
        <input type="hidden" name="id" value="${usuario.id}">
        <div class="input-field">
            <input type="text" id="nombre" name="nombre" value="${usuario.nombre}" maxlength="30" required>
            <label for="nombre">Nombre</label>
        </div>
        <div id="nombre-error" class="invalid-feedback" style="display: none;"></div>

        <div class="input-field">
            <input type="text" id="descripcion" name="descripcion" value="${usuario.descripcion}" maxlength="60" required>
            <label for="descripcion">Descripción</label>
        </div>
        <div id="descripcion-error" class="invalid-feedback" style="display: none;"></div>

        <div class="input-field">
            <input type="text" id="precio" name="precio" value="${usuario.precio}" maxlength="30" required>
            <label for="precio">Precio</label>
        </div>
        <div id="precio-error" class="invalid-feedback" style="display: none;"></div>
        <div class="input-field">
            <input type="text" id="categoria" name="categoria" value="${usuario.categoria}" maxlength="60" required>
            <label for="categoria">Categoria</label>
        </div>
        <div id="categoria-error" class="invalid-feedback" style="display: none;"></div>
        <div class="input-field">
            <input type="text" id="imagen" name="imagen" value="${usuario.imagen}" required>
            <label for="imagen">imagen</label>
        </div>
        <div id="imagen-error" class="invalid-feedback" style="display: none;"></div>
        <div class="input-field">
            <input type="text" id="estado" name="estado" value="${usuario.estado}" readonly>
            <label for="estado">Estado</label>
        </div>
        <button type="submit" class="btn-primary">Actualizar</button>
        <div id="form-error" class="alert alert-danger" style="display: none; margin-top: 10px;">Por favor, corrija los errores en el formulario.</div>
    </form>
</div>
</body>
</html>