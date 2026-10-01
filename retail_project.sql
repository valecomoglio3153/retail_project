-- ============================================
-- PROYECTO RETAIL - PRE-ENTREGA SQL
-- Base de datos: retail_project
-- ============================================

-- Crear la base de datos
CREATE DATABASE retail_project;

-- IMPORTANTE:
-- Luego de crear la base de datos, conectarse a retail_project
-- antes de ejecutar las siguientes sentencias.

--DDL:Estructura de tablas
--Tabla Clientes
CREATE TABLE clientes (
id_cliente SERIAL PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
email VARCHAR (150) UNIQUE NOT NULL,
edad INT NOT NULL,
fecha_registro DATE NOT NULL,

CONSTRAINT check_edad_cliente CHECK (edad >=18)
);

--Tabla Productos 
CREATE TABLE productos (
id_producto SERIAL PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
categoria VARCHAR (100) NOT NULL,
precio DECIMAL (10,2) NOT NULL, 
stock INT NOT NULL, 

CONSTRAINT check_precio_positivo CHECK (precio > 0),

CONSTRAINT check_stock_no_negativo CHECK (stock >= 0)
);

--Tabla Ventas
CREATE TABLE ventas (
id_venta SERIAL PRIMARY KEY,
id_cliente INT NOT NULL, 
id_producto INT NOT NULL,
fecha_venta DATE NOT NULL,
cantidad INT NOT NULL,
precio_unitario DECIMAL (10,2) NOT NULL,

CONSTRAINT check_cantidad_positiva 
CHECK (cantidad >0),
CONSTRAINT check_precio_unitario_positivo 
CHECK (precio_unitario >0),

CONSTRAINT fk_venta_cliente 
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente),

CONSTRAINT fk_venta_productos
FOREIGN KEY (id_producto)
REFERENCES productos(id_producto)
);

--DML: Datos y mantenimiento
-- Carga inicial de datos
BEGIN ;

--Datos Clientes
INSERT INTO clientes (nombre, email, edad, fecha_registro)
VALUES
    ('Ana Lopez', 'ana.lopez@email.com', 28, '2026-09-01'),
    ('Carlos Gomez', 'carlos.gomez@email.com', 35, '2026-09-05'),
    ('Lucia Fernandez', 'lucia.fernandez@email.com', 24, '2026-09-10'),
    ('Martin Perez', 'martin.perez@email.com', 42, '2026-09-15'),
    ('Sofia Ramirez', 'sofia.ramirez@email.com', 31, '2026-09-20'),
	('Isolina Paz', 'isolina.paz@gmail.com', 23, '2026-09-20');

--Datos Productos
INSERT INTO productos (nombre, categoria, precio, stock)
VALUES
    ('Notebook Lenovo', 'Tecnologia', 850000.00, 10),
    ('Mouse Logitech', 'Tecnologia', 25000.00, 30),
    ('Escritorio', 'Muebles', 180000.00, 8),
    ('Silla de Oficina', 'Muebles', 120000.00, 15),
    ('Auriculares JBL', 'Tecnologia', 95000.00, 20),
	('Cable de alimentacion', 'Electricidad', 8000.00, 6);

--Datos Ventas
INSERT INTO ventas (id_cliente, id_producto, fecha_venta, cantidad, precio_unitario)
VALUES
    (1, 1, '2026-09-21', 1, 850000.00),
    (2, 2, '2026-09-22', 2, 25000.00),
    (3, 3, '2026-09-23', 1, 180000.00),
    (4, 4, '2026-09-24', 2, 120000.00),
    (5, 5, '2026-09-25', 1, 95000.00),
	(6, 2, '2026-09-25', 3, 25000.00);
	
COMMIT;

--DML: Datos y mantenimiento
-- Actualizar precios y eliminar venta
BEGIN ;

-- Verificación previa al UPDATE
SELECT *
FROM productos
WHERE categoria = 'Tecnologia';

-- Actualización masiva de precios
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Tecnologia';

-- Registro de prueba para DELETE
INSERT INTO ventas 
    (id_cliente, id_producto, fecha_venta, cantidad, precio_unitario)
VALUES
    (1, 2, '2026-09-30', 1, 25000.00);
-- Verificación previa al DELETE
SELECT *
FROM ventas
WHERE id_cliente = 1
  AND id_producto = 2
  AND fecha_venta = '2026-09-30';
-- Eliminación del registro de prueba
DELETE FROM ventas
WHERE id_cliente = 1
  AND id_producto = 2
  AND fecha_venta = '2026-09-30';

COMMIT;