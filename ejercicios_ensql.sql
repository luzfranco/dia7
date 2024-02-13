-- Top clientes con más facturas
select c.nombre,apellido,count(f.id)
from cliente as c
left join factura as f on c.id=f.cliente_id
group by c.nombre
order by count(f.id) desc 

--Top clientes que más gastaron
select c.nombre,c.apellido
from cliente c
left join factura f on c.id=f.cliente_id
left join factura_detalle fd on f.id=fd.factura_id
left join producto p on fd.producto_id=p.id
group by c.nombre,c.apellido
having  sum(fd.cantidad*p.precio) is not null
order by sum(fd.cantidad*p.precio) desc

--Top monedas más utilizadas
select m.id,nombre, count(m.id)
from moneda as m 
join factura  as f on m.id=f.moneda_id
group by m.id
order by count(m.id) desc

--Top proveedor de productos
select p.nombre, count(p.id)
from proveedor as p  
join producto  as pd on p.id=pd.proveedor_id
group by p.id
order by count(p.id) desc

--Productos más vendidos
select p.nombre, count(p.id)
from producto as p  
join factura_detalle  as fd on p.id=fd.producto_id
group by p.id
order by count(p.id) desc

--Productos menos vendidos
select p.nombre, count(p.id)
from producto as p  
join factura_detalle  as fd on p.id=fd.producto_id
group by p.id
order by count(p.id) asc

--Consulta que muestre fecha de emisión de factura, nombre y apellido del cliente, 
--nombres de productos de esa factura, cantidades compradas,
--nombre de tipo de factura de una factura específica

select f.fecha_emision, c.nombre, c.apellido, p.nombre, fd.cantidad, ft.nombre
from cliente as c  
join factura  as f on c.id=f.cliente_id 
join factura_detalle as fd on f.id=fd.factura_id
join producto as p on p.id=fd.producto_id
join factura_tipo as ft on ft.id=f.factura_tipo_id

--Montos de facturas ordenadas según totales
select f.id, sum(p.precio*fd.cantidad) as total
from factura as f
join factura_detalle as fd on f.id=fd.factura_id
join producto as p on p.id=fd.producto_id
group by f.id
order by f.id


--Mostrar el iva 10% de los montos totales de facturas 
--(suponer que todos los productos tienen IVA 10%)
select f.id, sum(p.precio*fd.cantidad*0.10) as total
from factura as f
join factura_detalle as fd on f.id=fd.factura_id
join producto as p on p.id=fd.producto_id
group by f.id
order by f.id

