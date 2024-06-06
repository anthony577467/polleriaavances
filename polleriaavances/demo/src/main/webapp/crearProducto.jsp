<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
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
            padding: 50px 0;
        }
        .card {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            padding: 30px;
            width: 100%;
            max-width: 600px;
        }
        .card-title {
            font-size: 2rem;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-control {
            background: transparent;
            border: 1px solid #ffffff;
            color: #ffffff;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.6);
            border-color: #ffffff;
        }
        .form-check-label {
            cursor: pointer;
        }
        .btn-primary {
            background-color: #5A54E8;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #837DFF;
        }
        .error-message {
            font-size: 0.9rem;
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
            var nombrePattern = /^[a-zA-Z\s]+$/;
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
            var descripcionPattern = /^[a-zA-Z\s]+$/;
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

        function validateCategoria() {
            var categoria = document.getElementById('categoria').value;
            var categoriaError = document.getElementById('categoria-error');

            if (categoria === "") {
                categoriaError.innerText = "Debe seleccionar una categoría.";
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
                // Detener el envío del formulario
                event.preventDefault();
                return false;
            } else {
                // Si no hay errores de validación, ocultar el mensaje de error y permitir el envío del formulario
                formError.style.display = "none";
                return true;
            }
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3 w-100 mt-3">
    <div class="container-fluid">
        <a class="navbar-brand" href="crearProducto.jsp">Mi Aplicacion</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
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

<div class="container centered-form">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title">Registro de Producto</h2>
            <form id="formulario" onsubmit="return validateForm(event)" action="contProcesar" method="post">
                <div class="form-group">
                    <label for="nombre"><i class="fas fa-user"></i> Nombre:</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" maxlength="30" required>
                    <div id="nombre-error" class="invalid-feedback error-message text-danger" style="display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="descripcion"><i class="fas fa-info-circle"></i> Descripcion:</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="4" maxlength="60" required></textarea>
                    <div id="descripcion-error" class="invalid-feedback error-message text-danger" style="display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="precio"><i class="fas fa-dollar-sign"></i> Precio:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">S/</span>
                        </div>
                        <input type="number" class="form-control" id="precio" name="precio" min="0" step="0.01" required>
                    </div>
                    <div id="precio-error" class="invalid-feedback error-message text-danger" style="display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="categoria"><i class="fas fa-list"></i> Categoria:</label>
                    <select class="form-control" id="categoria" name="categoria" required>
                        <option value="">Seleccione una categoria</option>
                        <option value="moda">comida</option>
                        <option value="hogar">bebida</option>
                    </select>
                    <div id="categoria-error" class="invalid-feedback error-message text-danger" style="display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="imagen"><i class="fas fa-image"></i> URL de la Imagen:</label>
                    <input type="url" class="form-control" id="imagen" name="imagen" required>
                    <div id="imagen-error" class="invalid-feedback error-message text-danger" style="display: none;"></div>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Registrar</button>
                <div id="form-error" class="alert alert-danger mt-3" style="display: none;">Por favor, corrija los errores en el formulario.</div>
            </form>
        </div>
    </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
