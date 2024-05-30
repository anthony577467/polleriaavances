CREATE TABLE cliente_M (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombres NVARCHAR(100) ,
    apellidos NVARCHAR(100) ,
    tipoDocumento NVARCHAR(30) ,  -- Aumentamos la longitud a 30
    dniocarnet NVARCHAR(20) ,
    telefono NVARCHAR(9) ,
    correo NVARCHAR(100) ,
    direccion NVARCHAR(255),
    ubigeo NVARCHAR(6) ,
    fechaNacimiento DATE ,
    activo BIT  DEFAULT 1
);
GO