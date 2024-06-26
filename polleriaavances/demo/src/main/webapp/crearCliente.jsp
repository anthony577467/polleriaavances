<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Crear Cliente</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
            height: calc(200vh - 200px);
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
        function updateDocumentLength() {
            const dniOption = document.getElementById('dniOption');
            const carnetOption = document.getElementById('carnetOption');
            const dniocarnetInput = document.getElementById('dniocarnetInput');

            if (dniOption.checked) {
                dniocarnetInput.maxLength = 8;
                dniocarnetInput.value = dniocarnetInput.value.slice(0, 8);
            } else if (carnetOption.checked) {
                dniocarnetInput.maxLength = 20;
                dniocarnetInput.value = dniocarnetInput.value.slice(0, 20);
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const dniOption = document.getElementById('dniOption');
            const carnetOption = document.getElementById('carnetOption');
            const inputs = document.querySelectorAll('input[required], input[type=email], input[type=tel], input[type=number], input[type=date]');

            dniOption.addEventListener('change', updateDocumentLength);
            carnetOption.addEventListener('change', updateDocumentLength);

            updateDocumentLength();

            inputs.forEach(input => {
                input.addEventListener('input', validateField);
                input.addEventListener('blur', validateField);
            });

            function validateField(event) {
                const field = event.target;
                const validity = field.validity;
                const errorSpan = field.nextElementSibling;

                if (!errorSpan || !errorSpan.classList.contains('error-message')) {
                    return;
                }

                if (validity.valid) {
                    field.classList.remove('is-invalid');
                    errorSpan.textContent = '';
                } else {
                    field.classList.add('is-invalid');
                    if (validity.valueMissing) {
                        errorSpan.textContent = 'Este campo es obligatorio.';
                    } else if (validity.typeMismatch) {
                        errorSpan.textContent = 'Formato incorrecto.';
                    } else if (validity.patternMismatch) {
                        errorSpan.textContent = 'Formato no válido.';
                    } else if (validity.tooShort || validity.tooLong) {
                        errorSpan.textContent = `La longitud debe ser entre ${field.minLength} y ${field.maxLength} caracteres.`;
                    } else if (validity.rangeOverflow || validity.rangeUnderflow) {
                        errorSpan.textContent = `El valor debe estar entre ${field.min} y ${field.max}.`;
                    }
                }
            }
        });
    </script>
</head>
<body>
<div class="container centered-form">
    <div class="card">
        <div class="card-body">
            <h1 class="card-title">Registrarse</h1>
            <form id="crearClienteForm" action="CliCrear" method="post" novalidate>
                <div class="form-group">
                    <label for="nombresInput">Nombres:</label>
                    <input type="text" id="nombresInput" name="nombres" class="form-control" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="apellidosInput">Apellidos:</label>
                    <input type="text" id="apellidosInput" name="apellidos" class="form-control" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label>Tipo de Documento:</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipoDocumento" id="dniOption" value="DNI" required>
                        <label class="form-check-label" for="dniOption">
                            DNI
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipoDocumento" id="carnetOption" value="Carnet de Extranjería" required>
                        <label class="form-check-label" for="carnetOption">
                            Carnet de Extranjería
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="dniocarnetInput">Número de Documento:</label>
                    <input type="text" id="dniocarnetInput" name="dniocarnet" class="form-control" pattern="\d+" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="telefonoInput">Teléfono:</label>
                    <input type="tel" id="telefonoInput" name="telefono" class="form-control" pattern="9\d{8}" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="correoInput">Correo:</label>
                    <input type="email" id="correoInput" name="correo" class="form-control" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="direccionInput">Dirección:</label>
                    <input type="text" id="direccionInput" name="direccion" class="form-control">
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="ubigeoInput">Ubigeo:</label>
                    <input type="number" id="ubigeoInput" name="ubigeo" class="form-control" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="clave">Contraseña</label>
                    <input type="password" id="clave" name="clave" class="form-control" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="rol">Rol:</label>
                    <input type="text" id="rol" name="rol" class="form-control" required>
                    <span class="error-message text-danger"></span>
                </div>
                <div class="form-group">
                    <label for="fechaNacimientoInput">Fecha de Cumpleaños:</label>
                    <input type="date" id="fechaNacimientoInput" name="fechaNacimiento" class="form-control" required>
                    <span class="error-message text-danger"></span>
                </div>
                <button id="crearClienteButton" type="submit" class="btn btn-primary">Crear</button>
            </form>
            <script>
                var today = new Date();
                var eighteenYearsAgo = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
                var maxDate = eighteenYearsAgo.toISOString().split('T')[0];
                document.getElementById('fechaNacimientoInput').setAttribute('max', maxDate);
            </script>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
