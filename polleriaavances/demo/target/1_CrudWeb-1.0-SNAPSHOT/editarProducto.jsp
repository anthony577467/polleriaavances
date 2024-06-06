<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #1f1c2c, #928DAB);
            font-family: 'Orbitron', sans-serif;
            color: #ffffff;
        }
        .centered-form {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .wrapper {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }
        h2 {
            font-size: 2rem;
            text-align: center;
            margin-bottom: 20px;
        }
        .input-field {
            position: relative;
            margin-bottom: 15px;
        }
        .input-field label {
            position: absolute;
            top: -10px;
            left: 0;
            color: #fff;
            font-size: 16px;
            pointer-events: none;
            transition: none;
        }
        .input-field input,
        .input-field select {
            width: 100%;
            height: 40px;
            background: transparent;
            border: none;
            border-bottom: 2px solid #ccc;
            outline: none;
            font-size: 16px;
            color: #fff;
        }
        .input-field input:focus,
        .input-field select:focus {
            border-bottom: 2px solid #fff;
        }
        .input-field input:focus~label,
        .input-field select:focus~label,
        .input-field input:valid~label,
        .input-field select:valid~label {
            font-size: 0.8rem;
            top: -10px;
            transform: translateY(0);
        }
        .btn-primary {
            background-color: #5A54E8;
            border: none;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #837DFF;
        }
        .invalid-feedback {
            font-size: 0.9rem;
            color: #ffcccc;
            display: none;
        }
        .alert {
            font-size: 0.9rem;
            color: #ffcccc;
            display: none;
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
<div class="centered-form">
    <div class="wrapper">
        <form id="formulario" action="contActualizar" method="post" onsubmit="return validateForm(event)">
            <h2>Editar Producto</h2>
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="id" value="${usuario.id}">
            <div class="input-field">
                <input type="text" id="nombre" name="nombre" value="${usuario.nombre}" maxlength="30" required>
                <label for="nombre">Nombre</label>
                <div id="nombre-error" class="invalid-feedback"></div>
            </div>

            <div class="input-field">
                <input type="text" id="descripcion" name="descripcion" value="${usuario.descripcion}" maxlength="60" required>
                <label for="descripcion">Descripción</label>
                <div id="descripcion-error" class="invalid-feedback"></div>
            </div>

            <div class="input-field">
                <input type="text" id="precio" name="precio" value="${usuario.precio}" maxlength="30" required>
                <label for="precio">Precio</label>
                <div id="precio-error" class="invalid-feedback"></div>
            </div>

            <div class="input-field">
                <select id="categoria" name="categoria" required>
                    <option value="" disabled selected>Selecciona una categoría</option>
                    <option value="Bebidas" ${usuario.categoria == 'Bebidas' ? 'selected' : ''}>Bebidas</option>
                    <option value="Comida" ${usuario.categoria == 'Comida' ? 'selected' : ''}>Comida</option>
                </select>
                <label for="categoria">Categoría</label>
                <div id="categoria-error" class="invalid-feedback"></div>
            </div>

            <div class="input-field">
                <input type="text" id="imagen" name="imagen" value="${usuario.imagen}" required>
                <label for="imagen">Imagen</label>
                <div id="imagen-error" class="invalid-feedback"></div>
            </div>

            <div class="input-field">
                <input type="text" id="estado" name="estado" value="${usuario.estado}" readonly>
                <label for="estado">Estado</label>
            </div>

            <button type="submit" class="btn-primary">Actualizar</button>
            <div id="form-error" class="alert alert-danger" style="display: none;">Por favor, corrige los errores en el formulario.</div>
        </form>
    </div>
</div>
</body>
</html>