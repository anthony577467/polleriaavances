function validarDniOCarnet() {
    const dniInput = document.getElementById('dniocarnetInput');
    const dniValue = dniInput.value;
    if (dniValue.length > 8) {
        dniInput.value = dniValue.slice(0, 8);
    }
}

function validarTelefono() {
    const telefonoInput = document.getElementById('telefonoInput');
    const telefonoValue = telefonoInput.value;
    if (telefonoValue.length > 9) {
        telefonoInput.value = telefonoValue.slice(0, 9);
    }
}

function validarCorreo() {
    const correoInput = document.getElementById('correoInput');
    const correoValue = correoInput.value;
    const regex = /^[a-zA-Z0-9._%+-]+@(gmail|hotmail)\.com$/;

    if (!regex.test(correoValue)) {
        alert('Por favor, ingrese un correo electrónico válido de Gmail o Hotmail.');
        return false;
    }

    return true;
}



function validarUbigeo() {
    const ubigeoInput = document.getElementById('ubigeoInput');
    const ubigeoValue = ubigeoInput.value;
    if (ubigeoValue.length > 6) {
        ubigeoInput.value = ubigeoValue.slice(0, 6);
    }
}

document.getElementById('crearClienteForm').addEventListener('submit', function(event) {
    const dniInput = document.getElementById('dniocarnetInput');
    const telefonoInput = document.getElementById('telefonoInput');
    const correoInput = document.getElementById('correoInput');
    const ubigeoInput = document.getElementById('ubigeoInput');

    if (dniInput.value.length !== 8) {
        alert('El DNI o Carnet debe tener exactamente 8 dígitos.');
        event.preventDefault();
    }

    if (telefonoInput.value.length !== 9) {
        alert('El Teléfono debe tener exactamente 9 dígitos.');
        event.preventDefault();
    }

    if (!validarCorreo()) {
        event.preventDefault();
    }

    if (ubigeoInput.value.length !== 6) {
        alert('El Ubigeo debe tener exactamente 6 dígitos.');
        event.preventDefault();
    }
});

document.getElementById('dniocarnetInput').addEventListener('input', validarDniOCarnet);
document.getElementById('telefonoInput').addEventListener('input', validarTelefono);
document.getElementById('ubigeoInput').addEventListener('input', validarUbigeo);
