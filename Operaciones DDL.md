USE Carrito_compra;

-- 20 INSERT

INSERT INTO persona (nombre, apellido, fecha_nacimiento, correo, direccion, telefono) VALUES
('Juan', 'Pérez', '1990-05-10', 'juanp@example.com', 'Calle 1 #10-20', '3001112233'),
('Laura', 'García', '1985-11-23', 'laurag@example.com', 'Carrera 15 #45-78', '3012223344'),
('Carlos', 'Rodríguez', '1978-02-17', 'carlosr@example.com', 'Av. Siempre Viva 123', '3023334455'),
('Ana', 'Martínez', '1995-07-05', 'anam@example.com', 'Calle 8 #56-21', '3034445566'),
('Sofía', 'López', '2000-03-30', 'sofial@example.com', 'Cra 30 #12-90', '3045556677');

INSERT INTO cliente (codigo, fecha_vinculacion, persona_id) VALUES
('CL001', '2023-01-15', 1),
('CL002', '2023-03-20', 2);

INSERT INTO empleado (codigo, fecha_vinculacion, salario, tipo_contrato, persona_id) VALUES
('EMP001', '2022-12-01', 2500000.00, 'Indefinido', 3),
('EMP002', '2023-04-10', 1800000.00, 'Término fijo', 4);

INSERT INTO categoria (nombre, descripcion) VALUES
('Bebidas', 'Líquidos embotellados o enlatados para consumo.'),
('Snacks', 'Productos ligeros como papas, galletas, etc.');

INSERT INTO metodo_pago (nombre, descripcion) VALUES
('Efectivo', 'Pago realizado con dinero físico.'),
('Tarjeta', 'Pago realizado con tarjeta débito o crédito.');

INSERT INTO producto (codigo, nombre, descripcion, categoria_id) VALUES
('P001', 'Coca-Cola 350ml', 'Refresco de cola', 1),
('P002', 'Papitas BBQ', 'Papas saborizadas BBQ', 2),
('P003', 'Agua Cristal 600ml', 'Agua sin gas', 1);

INSERT INTO inventario (nombre, fecha, precio, stock, fecha_lote, fecha_vencimiento, producto_id) VALUES
('Lote1-Coca', '2024-04-01', 2500.00, 100, '2024-03-01', '2025-03-01', 1),
('Lote1-Papitas', '2024-04-01', 1800.00, 150, '2024-03-15', '2024-09-15', 2);

INSERT INTO factura (codigo, fecha, valor_bruto, valor_descuento, valor_incremento, valor_neto, cliente_id, medio_pago_id) VALUES
('FAC001', '2024-04-05', 4300.00, 0.00, 0.00, 4300.00, 1, 1),
('FAC002', '2024-04-06', 1800.00, 100.00, 50.00, 1750.00, 2, 2);

INSERT INTO detalle_factura (cantidad, porcentaje_descuento, porcentaje_incremento, subtotal, producto_id, factura_id) VALUES
(1, 0.00, 0.00, 2500.00, 1, 1),
(1, 5.00, 2.00, 1800.00, 2, 2);

-- 15 UPDATE

UPDATE persona SET correo = 'nuevo_correo1@example.com' WHERE id = 1;
UPDATE persona SET direccion = 'Calle nueva #123' WHERE id = 2;
UPDATE persona SET telefono = '3000000000' WHERE id = 3;
UPDATE cliente SET codigo = 'CL001MOD' WHERE id = 1;
UPDATE empleado SET salario = 2600000.00 WHERE id = 1;
UPDATE empleado SET tipo_contrato = 'Temporal' WHERE id = 2;
UPDATE categoria SET descripcion = 'Bebidas frías y calientes' WHERE id = 1;
UPDATE metodo_pago SET nombre = 'Transferencia' WHERE id = 2;
UPDATE producto SET nombre = 'Coca-Cola 500ml' WHERE id = 1;
UPDATE producto SET descripcion = 'Papas con sabor BBQ intenso' WHERE id = 2;
UPDATE inventario SET stock = 80 WHERE id = 1;
UPDATE inventario SET precio = 1900.00 WHERE id = 2;
UPDATE factura SET valor_neto = 4400.00 WHERE id = 1;
UPDATE detalle_factura SET subtotal = 2600.00 WHERE id = 1;
UPDATE detalle_factura SET porcentaje_descuento = 10.00 WHERE id = 2;

-- 15 DELETE

DELETE FROM detalle_factura WHERE id = 2;
DELETE FROM detalle_factura WHERE id = 1;
DELETE FROM factura WHERE id = 2;
DELETE FROM factura WHERE id = 1;
DELETE FROM inventario WHERE id = 2;
DELETE FROM inventario WHERE id = 1;
DELETE FROM producto WHERE id = 3;
DELETE FROM producto WHERE id = 2;
DELETE FROM producto WHERE id = 1;
DELETE FROM metodo_pago WHERE id = 2;
DELETE FROM categoria WHERE id = 2;
DELETE FROM empleado WHERE id = 2;
DELETE FROM cliente WHERE id = 2;
DELETE FROM persona WHERE id = 5;
DELETE FROM persona WHERE id = 4;

-- 5 SELECT

SELECT * FROM persona;
SELECT nombre, descripcion FROM producto;
SELECT * FROM factura WHERE valor_neto > 1000;
SELECT p.nombre, i.stock FROM producto p JOIN inventario i ON p.id = i.producto_id;
SELECT f.codigo, d.subtotal FROM factura f JOIN detalle_factura d ON f.id = d.factura_id;
