USE Carrito_compra;

-- 1. Clientes y su información personal
SELECT c.id AS cliente_id, c.codigo, p.nombre, p.apellido
FROM cliente c
INNER JOIN persona p ON c.persona_id = p.id;

-- 2. Empleados y su salario con información personal
SELECT e.codigo AS empleado_codigo, p.nombre, p.apellido, e.salario
FROM empleado e
INNER JOIN persona p ON e.persona_id = p.id;

-- 3. Productos y su categoría
SELECT pr.nombre AS producto, c.nombre AS categoria
FROM producto pr
INNER JOIN categoria c ON pr.categoria_id = c.id;

-- 4. Inventario y nombre del producto
SELECT i.nombre AS inventario, i.stock, p.nombre AS producto
FROM inventario i
INNER JOIN producto p ON i.producto_id = p.id;

-- 5. Detalles de la factura y los productos relacionados
SELECT df.id, df.cantidad, p.nombre AS producto
FROM detalle_factura df
INNER JOIN producto p ON df.producto_id = p.id;

-- 6. Facturas con nombre del cliente
SELECT f.codigo AS factura_codigo, p.nombre AS cliente
FROM factura f
INNER JOIN cliente c ON f.cliente_id = c.id
INNER JOIN persona p ON c.persona_id = p.id;

-- 7. Factura y método de pago
SELECT f.codigo, mp.nombre AS metodo_pago
FROM factura f
INNER JOIN metodo_pago mp ON f.medio_pago_id = mp.id;

-- 8. Factura con sus detalles
SELECT f.codigo AS factura, df.cantidad, df.subtotal
FROM factura f
INNER JOIN detalle_factura df ON f.id = df.factura_id;

-- 9. Productos vendidos por factura
SELECT f.codigo AS factura, p.nombre AS producto, df.cantidad
FROM factura f
INNER JOIN detalle_factura df ON f.id = df.factura_id
INNER JOIN producto p ON df.producto_id = p.id;

-- 10. Empleados con su tipo de contrato y datos personales
SELECT e.codigo, e.tipo_contrato, p.nombre, p.apellido
FROM empleado e
INNER JOIN persona p ON e.persona_id = p.id;
