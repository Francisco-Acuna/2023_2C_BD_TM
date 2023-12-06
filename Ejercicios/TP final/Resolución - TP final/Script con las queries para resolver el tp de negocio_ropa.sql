-- +++++++++++++++++++++++++++++++++++++++++++++++++++++
--	QUERIES PARA RESOLVER EJERCICIOS DE NEGOCIO_ROPA
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++


-- 1) Cantidad de clientes que tiene el negocio
select count(*) cantidad_de_clientes from clientes;


-- 2) Cuántos clientes tienen un email registrado, ordenado por apellido, nombre.
select id_cliente, nombre, apellido from clientes where email is not null order by apellido,nombre;


-- 3) Listar los clientes cuyo apellido termine con ‘z’
select id_cliente, nombre, apellido from clientes where apellido like '%z';


-- 4) Cantidad de vendedores que tiene el negocio.
select count(*) cantidad_de_vendedores from vendedores;


-- 5) Listar los vendedores cuya segunda letra del nombre sea una ‘a’.
select legajo, nombre, apellido from vendedores where nombre like '_a%';


-- 6) Listar los clientes a los que no se les haya hecho alguna factura.
select 		c.id_cliente, c.nombre, c.apellido 
from 		clientes c 
left join  	facturas f on c.id_cliente = f.id_cliente 
where 		f.id_cliente is null;


-- 7) Listar la cantidad de facturas que hubo por fecha de facturación.
select fecha, count(*) cantidad_de_facturas from facturas group by fecha;


-- 8) Listar qué clientes (id_cliente, nombre, apellido) compraron remeras.
select 	c.id_cliente, c.nombre, c.apellido
from 	clientes c
join 	facturas f on c.id_cliente = f.id_cliente
join 	ventas v on f.letra = v.letra and f.numero = v.numero
join 	articulos a on v.codigo = a.codigo
where 	a.producto like 'Remera%'; 


-- 9) Listar los artículos que aún no fueron vendidos.
select		 a.*
from 		articulos a 	
left join 	ventas v on a.codigo = v.codigo
where 		v.codigo is null;


-- 10) Informar la suma total de las ventas del negocio por mes, ordenadas de mayor a menor
select 		concat(year(fecha),' / ',month(fecha)) mes, sum(monto) as suma_total
from 		facturas
group by 	mes
order by 	suma_total desc;


-- 11) Informar cuántas unidades se vendieron de cada artículo.
select 		a.codigo, a.producto, sum(v.cantidad) unidades_vendidas
from  		articulos a
left join 	ventas v on a.codigo = v.codigo		
group by	a.codigo, a.producto;


-- 12) Informar quiénes compraron el primer día de ventas.
select 	c.id_cliente, c.nombre, c.apellido
from 	clientes c
join 	facturas f on c.id_cliente = f.id_cliente
where 	f.fecha = (select min(fecha) from facturas); 


-- 13) Informar la cantidad de facturas de cada cliente
select 		c.id_cliente, c.nombre, c.apellido, count(f.id_cliente) cantidad_de_facturas
from 		clientes c
left join 	facturas f on c.id_cliente = f.id_cliente
group by 	c.id_cliente;  


-- 14) Agregar los campos precio_costo y precio_venta del tipo double a la tabla artículos.
alter table articulos add precio_costo double, add precio_venta double;


-- 15) Actualizar todos los stock_minimo y stock_maximo a 100 y 500 respectivamente.
update articulos set stock_minimo = 100, stock_maximo = 500;  


-- 16) Eliminar los productos que no se hayan vendido nunca.
delete from articulos where codigo not in (select distinct codigo from ventas);


-- 17) Listar nombre y apellido, tanto de clientes como de vendedores, cuya dirección de email sea de Gmail.
select nombre, apellido, email from clientes where email like '%@gmail.com'
union
select nombre, apellido, email from vendedores where email like '%@gmail.com';


-- 18) Listar el o los artículos que tengan la mayor cantidad de stock.
select * from articulos where stock = (select max(stock) from articulos);  

