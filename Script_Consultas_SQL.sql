CREATE DATABASE TiendaCamisetasDW;
GO
USE TiendaCamisetasDW;

CREATE TABLE dim_cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo_cliente VARCHAR(50),
    zona VARCHAR(50)
);

CREATE TABLE dim_producto (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    tipo VARCHAR(50),
    categoria VARCHAR(50)
);

CREATE TABLE dim_vendedor (
    id_vendedor INT PRIMARY KEY,
    nombre VARCHAR(100),
    zona VARCHAR(50)
);

CREATE TABLE dim_tiempo (
    id_tiempo INT PRIMARY KEY,
    fecha DATE,
    dia INT,
    mes INT,
    trimestre INT,
    anio INT
);

CREATE TABLE dim_gasto (
    id_tipo_gasto INT PRIMARY KEY,
    tipo_gasto VARCHAR(100),
    categoria VARCHAR(50)
);

CREATE TABLE hecho_ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    id_tiempo INT,
    id_vendedor INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    total_venta DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES dim_producto(id_producto),
    FOREIGN KEY (id_tiempo) REFERENCES dim_tiempo(id_tiempo),
    FOREIGN KEY (id_vendedor) REFERENCES dim_vendedor(id_vendedor)
);

CREATE TABLE hecho_gastos (
    id_gasto INT PRIMARY KEY,
    id_tiempo INT,
    id_tipo_gasto INT,
    monto DECIMAL(10,2),
    observaciones VARCHAR(200),
    FOREIGN KEY (id_tiempo) REFERENCES dim_tiempo(id_tiempo),
    FOREIGN KEY (id_tipo_gasto) REFERENCES dim_gasto(id_tipo_gasto)
);

-- INSERCIÓN DE DATOS DE EJEMPLO

-- dim_cliente
INSERT INTO dim_cliente VALUES
(1, 'Carlos Pérez', 'Mayorista', 'Occidente'),
(2, 'Ana Gómez', 'Minorista', 'Centro'),
(3, 'Sofía Cruz', 'Mayorista', 'Oriente'),
(4, 'Luis Martínez', 'Minorista', 'Occidente');

-- dim_producto
INSERT INTO dim_producto VALUES
(1, 'Camiseta Básica M', 'Algodón', 'Hombre'),
(2, 'Camiseta Estampada', 'Poliéster', 'Mujer'),
(3, 'Polo Casual', 'Algodón', 'Hombre'),
(4, 'Crop Top', 'Lycra', 'Mujer');

-- dim_vendedor
INSERT INTO dim_vendedor VALUES
(1, 'Julio Hernández', 'Centro'),
(2, 'Marta Figueroa', 'Oriente'),
(3, 'Diego López', 'Occidente');

-- dim_tiempo
INSERT INTO dim_tiempo VALUES
(1, '2024-01-05', 5, 1, 1, 2024),
(2, '2024-02-10', 10, 2, 1, 2024),
(3, '2024-03-15', 15, 3, 1, 2024),
(4, '2024-04-20', 20, 4, 2, 2024);

-- dim_gasto
INSERT INTO dim_gasto VALUES
(1, 'Publicidad', 'Marketing'),
(2, 'Sueldos', 'Recursos Humanos'),
(3, 'Renta de local', 'Operativo'),
(4, 'Servicios básicos', 'Operativo');

-- hecho_ventas
INSERT INTO hecho_ventas VALUES
(1, 1, 1, 1, 1, 10, 5.00, 50.00),
(2, 2, 2, 2, 2, 5, 7.00, 35.00),
(3, 3, 3, 3, 3, 8, 6.50, 52.00),
(4, 4, 4, 4, 1, 4, 8.00, 32.00);

-- hecho_gastos
INSERT INTO hecho_gastos VALUES
(1, 1, 1, 150.00, 'Campaña en redes'),
(2, 2, 2, 400.00, 'Pago de sueldos enero'),
(3, 3, 3, 300.00, 'Alquiler mensual'),
(4, 4, 4, 100.00, 'Agua y electricidad');

ALTER TABLE hecho_ventas
ADD CONSTRAINT FK_ventas_tiempo FOREIGN KEY (id_tiempo)
REFERENCES dim_tiempo(id_tiempo);

ALTER TABLE hecho_gastos
ADD CONSTRAINT FK_gastos_tiempo FOREIGN KEY (id_tiempo)
REFERENCES dim_tiempo(id_tiempo);