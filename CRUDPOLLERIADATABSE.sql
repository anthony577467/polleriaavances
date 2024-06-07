CREATE DATABASE POLLERIACELINDA;

USE POLLERIACELINDA;

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
    clave NVARCHAR(90),
    rol CHAR(10) DEFAULT 'CLIENTE',
    activo BIT  DEFAULT 1
);
GO

SELECT * from cliente_M;


CREATE TABLE producto (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50),
    fecha_creacion DATETIME DEFAULT GETDATE(),
    fecha_actualizacion DATETIME DEFAULT GETDATE(),
    imagen VARCHAR(255),
    estado VARCHAR(20) DEFAULT 'activo'
);
GO 

-- Trigger para actualizar automáticamente la fecha_actualizacion
CREATE TRIGGER trgActualizarFechaProducto
ON producto
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE producto
    SET fecha_actualizacion = GETDATE()
    FROM inserted
    WHERE producto.id = inserted.id;
END;
GO


INSERT INTO cliente_M (nombres, apellidos, tipoDocumento, dniocarnet, telefono, correo, direccion, ubigeo, fechaNacimiento, activo)
VALUES 
('Juan', 'Perez', 'DNI', '12345678', '987654321', 'juan.perez@example.com', 'Calle Falsa 123', '150101', '1980-05-15', 1),
('Maria', 'Gomez', 'DNI', '87654321', '987654322', 'maria.gomez@example.com', 'Avenida Siempre Viva 742', '150102', '1990-07-22', 1),
('Carlos', 'Lopez', 'Carnet de Extranjería', 'CE123456', '987654323', 'carlos.lopez@example.com', 'Calle Los Pinos 456', '150103', '1985-09-30', 1),
('Ana', 'Torres', 'DNI', '23456789', '987654324', 'ana.torres@example.com', 'Jiron Las Flores 789', '150104', '1995-12-10', 1),
('Luis', 'Ramirez', 'Carnet de Extranjería', 'CE654321', '987654325', 'luis.ramirez@example.com', 'Pasaje Los Olivos 321', '150105', '1988-03-05', 1);
GO

SELECT * FROM cliente_M;

-- Insertar datos en la tabla producto
INSERT INTO producto (nombre, descripcion, precio, categoria, imagen, estado)
VALUES 
('Pollo a la Brasa', 'Delicioso pollo asado con una mezcla de especias y hierbas aromáticas.', 25.99, 'Platos Principales', 'imagen_pollo_brasa.jpg', 'activo'),
('Papas Fritas', 'Papas cortadas en tiras y fritas hasta que estén doradas y crujientes.', 5.99, 'Acompañamientos', 'imagen_papas_fritas.jpg', 'activo'),
('Ensalada Mixta', 'Ensalada fresca con una variedad de vegetales y aderezo de su elección.', 8.99, 'Ensaladas', 'imagen_ensalada_mixta.jpg', 'activo'),
('Chicha Morada', 'Bebida refrescante preparada con maíz morado, piña, canela y otros ingredientes.', 3.99, 'Bebidas', 'imagen_chicha_morada.jpg', 'activo'),
('Arroz con Pollo', 'Plato tradicional peruano hecho con arroz, pollo, verduras y especias.', 12.99, 'Platos Principales', 'imagen_arroz_con_pollo.jpg', 'activo'),
('Papa a la Huancaína', 'Papas cocidas cubiertas con una cremosa salsa de ají amarillo y queso fresco.', 7.99, 'Acompañamientos', 'imagen_papa_huancaina.jpg', 'activo'),
('Ceviche de Pollo', 'Deliciosa mezcla de pollo marinado en limón con cebolla roja, ají y cilantro.', 15.99, 'Platos Principales', 'imagen_ceviche_pollo.jpg', 'activo');
