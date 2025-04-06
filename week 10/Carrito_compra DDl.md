DROP DATABASE IF EXISTS Carrito_compra;

CREATE DATABASE Carrito_compra;

USE Carrito_compra;

CREATE TABLE persona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    correo VARCHAR(150),
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    fecha_vinculacion DATE,
    persona_id INT,
    FOREIGN KEY (persona_id) REFERENCES persona(id)
);

CREATE TABLE empleado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    fecha_vinculacion DATE,
    salario DECIMAL(10,2),
    tipo_contrato VARCHAR(100),
    persona_id INT,
    FOREIGN KEY (persona_id) REFERENCES persona(id)
);

CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE metodo_pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

CREATE TABLE inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha DATE,
    precio DECIMAL(10,2),
    stock INT,
    fecha_lote DATE,
    fecha_vencimiento DATE,
    producto_id INT,
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    fecha DATE,
    valor_bruto DECIMAL(10,2),
    valor_descuento DECIMAL(10,2),
    valor_incremento DECIMAL(10,2),
    valor_neto DECIMAL(10,2),
    cliente_id INT,
    medio_pago_id INT,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    FOREIGN KEY (medio_pago_id) REFERENCES metodo_pago(id)
);

CREATE TABLE detalle_factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT,
    porcentaje_descuento DECIMAL(5,2),
    porcentaje_incremento DECIMAL(5,2),
    subtotal DECIMAL(10,2),
    producto_id INT,
    factura_id INT,
    FOREIGN KEY (producto_id) REFERENCES producto(id),
    FOREIGN KEY (factura_id) REFERENCES factura(id)
);
