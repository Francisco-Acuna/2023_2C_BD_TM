show databases;
use cursomysql;

----------------
-- 	EJERCICIOS
--  ----------------

-- +++++++++++++++++++++
--   PRIMERA PARTE   --
-- +++++++++++++++++++++

-- Basándose en la tabla articulos, realizar los siguientes puntos:
-- 1) Agregar a la tabla articulos, los campos stockMinimo y stockMaximo.
describe articulos;
alter table articulos add stockMinimo smallint not null,
 add stockMaximo smallint not null;

-- 2) Completar en los registros los valores de los campos stockMinimo y 
-- stockMaximo teniendo en cuenta que el stock mínimo debe ser menor que 
-- el stock máximo.
select * from articulos;
update articulos set stockMinimo=10, stockMaximo=100;

-- 3) Listar los articulos que se deben reponer y qué cantidad se debe 
-- reponer de cada artículo.
-- Tener en cuenta que se debe reponer cuando el stock es menor al 
-- stockMinimo y la cantidad de articulos a reponer es stockMaximo - stock.
select nombre, (stockMaximo-stock) as "cantidad a reponer" 
from articulos where stock < stockMinimo;
select * from articulos;
update articulos set stock=2 where nombre='alfajorcito';

-- 4) Calcular el valor de venta de toda la mercaderia que hay en stock.
select sum(stock * precio) valor_venta_total from articulos;

-- 5) Calcular el valor de venta + IVA de toda la mercaderia que hay en stock.
select * from articulos;
select sum(stock * precio * 1.21) suma_IVA from articulos;

-- +++++++++++++++++++++
--   SEGUNDA PARTE   --
-- +++++++++++++++++++++

-- 1. Crear la tabla 'autos' dentro de la base de datos 'intro' con el siguiente detalle:

-- 	codigo	INTEGER y PK
-- 	marca	VARCHAR(255)
-- 	modelo	VARCHAR(255)
-- 	color	VARCHAR(255)
-- 	anio	INTEGER
-- 	precio	DOUBLE

drop database if exists intro;
create database intro;
use intro;
create table autos(
	codigo int primary key,
    marca varchar(255),
    modelo varchar(255),
    color varchar(255),
    anio int,
    precio double
);

-- 2. Cargar la tabla con 15 autos
insert into autos values
(1, 'Alfa Romeo', 'Stelvio', 'Rojo', 2022, 200000000),
(2, 'Audi', 'A3', 'Gris', 2003, 30000000),
(3, 'VMW', 'Serie3', 'Negro', 2013, 4000000),
(4, 'Citrôen', 'C4', 'Blanco', 2020, 17000000),
(5, 'Fiat', '500X', 'Rojo', 2014, 60000000),
(6, 'Honda', 'CRD', 'Blanco', 2012, 7000000),
(7, 'Ford', 'Ecosport', 'Gris', 2023, 11000000),
(8, 'Mercedes Benz', 'ClaseA', 'Blanco', 2012, 21000000),
(9, 'Opel Corsa', 'Corsa', 'Negro', 2019, 60000000),
(10, 'Renault', 'Captur', 'Gris Oscuro', 2023, 2000000000),
(11, 'Toyota', 'Grand4', 'Rosa', 2004, 200000000),
(12, 'Volkswagen', 'Gol', 'Violeta', 2023, 12000000),
(13, 'Volvo', 'S90', 'Naranja', 2022, 200000000),
(14, 'Peugeot', '2008', 'Blanco', 1990, 200000),
(15, 'Ford', 'Focus', 'Azul', 1981, 20000);

-- 3. Realizar las siguientes consultas:
-- 	a. obtener el precio máximo.
select max(precio) precio_maximo from autos;

-- 	b. obtener el precio mínimo.
select min(precio) precio_minimo from autos;

-- 	c. obtener el precio mínimo entre los años 2010 y 2020.
select min(precio) precio_minimo from autos where anio between 2010 and 2020;

-- 	d. obtener el precio promedio.
select avg(precio) precio_promedio from autos;

-- 	e. obtener el precio promedio del año 2023.
select round(avg(precio),2) precio_promedio from autos where anio=2023;

-- 	f. obtener la cantidad de autos.
select count(*) from autos;

-- 	g. obtener la cantidad de autos que tienen un precio entre $3.500.000 y $4.000.000
select count(*) cantidad from autos where precio between 3500000 and 4000000;

-- 	h. obtener la cantidad de autos que hay en cada año.
select anio, count(*) from autos group by anio;

-- 	i. obtener la cantidad de autos y el precio promedio en cada año.
select anio, count(*) cantidad_autos, avg(precio) precio_promedio from autos group by anio;

-- 	j. obtener la suma de precios y el promedio de precios según marca.
select marca, sum(precio), avg(precio) from autos group by marca;

--  	k. informar los autos con el menor precio.
select min(precio) from autos; -- este es el precio mínimo
select * from autos where precio=(select min(precio) from autos);

-- l. informar los autos con el menor precio entre los años 2014 y 2023
select * from autos where precio=(select min(precio) from autos) and anio between 2014 and 2023;

--  m. listar los autos ordenados ascendentemente por marca, modelo, y el año en forma descendente.
select * from autos order by marca, modelo, anio desc;

-- n. contar cuantos autos hay de cada marca.
select marca, count(*) from autos group by marca;

-- o. borrar los autos del siglo pasado.
delete from autos where anio < 2000;

-- Ejemplo de un total facturado por mes
use cursomysql;
select * from facturas;
-- la siguiente query lista las cantidades y montos totales de las facturas,
-- agrupadas por fecha
select fecha, sum(monto) total, count(*) cantidad from facturas group by fecha;

-- la siguente query hace lo mismo pero agrupado por mes
select 	concat(year(fecha),'/',month(fecha)) mes, 
		sum(monto) total, 
        count(*) cantidad
from 	facturas 
group by mes;

-- -------------------------------------------------------------
-- COMBINACIÓN DE CONSULTAS
-- -------------------------------------------------------------
/*
Para comparar los resultados de varias consultas y combinarlas en un único 
resultado, existe el operador UNION.
Para que funcione correctamente, tenemos que tener en cuenta:
- en cada resultado, tiene que haber la misma cantidad de campos
- los campos tienen que tener el mismo tipo de dato
- las primeras consultas se escriben sin el punto y coma final
- los registros duplicados se eliminan
- si queremos conservar los registros duplicados, se utiliza el operador UNION ALL
*/

-- supongamos que tenemos 2 tablas que representan a hombres y mujeres
-- una tabla para hombres y otra para mujeres
-- en cada tabla guardamos el nombre, la provincia y la edad.

create table hombres(
	nombre varchar(50) not null,
    provincia varchar(50) not null,
    edad int not null
);

create table mujeres(
	nombre varchar(50) not null,
    provincia varchar(50) not null,
    edad int not null
);

insert into hombres values
('Juan', 'Buenos Aires', 32),
('Mariano', 'Córdoba', 24),
('Luis', 'Mendoza', 40),
('Cris', 'Mendoza', 20),
('Raul', 'San Juan', 35);

insert into mujeres values
('Malena', 'Catamarca', 22),
('Luisa', 'Formosa', 30),
('Cris', 'Buenos Aires', 61),
('Alejandra', 'Córdoba', 19),
('Mariela', 'Misiones', 50);

-- obtener el listado de todos (hombres y mujeres)
select * from hombres
union
select * from mujeres;

-- obtener el listado de nombres
select nombre from hombres
union
select nombre from mujeres;

-- obtener el listado de nombres con duplicados
select nombre from hombres
union all
select nombre from mujeres;

-- obtener todos los nombres de quienes sean de la provincia Córdoba
select nombre from hombres where provincia='Córdoba'
union
select nombre from mujeres where provincia='Córdoba';

-- obtener los nombres de los hombres que sean de Córdoba y mujeres de Misiones
select nombre from hombres where provincia='Córdoba'
union
select nombre from mujeres where provincia='Misiones';

/*
Workbench permite armar gráficas sobre las bases de datos.
Trae incorporado un graficador. Que nos permite realizar la gráfica de la base.
Mediante un proceso que se conoce como Ingenieria Reversa, se analiza una base
de datos existente y se arma una representación visual de la estructura.
Esto es muy útil al momento de tener una documentación de base de datos, un 
análisis de funcionamiento, para ver posibles fallas o errores, para generar
una optimización de rendimiento, incluso para realizar mejoras, modificaciones
o una nueva base que suplante la actual.

A este diagrama se lo conoce como DER (Diagrama de Entidad Relacional o 
Entidad-Relación), en inglés sería ERD (Entity Relationship Diagram).
Es la representación gráfica de la estructura de la base de datos que muestra
las entidades, atributos y relaciones.

Hay 3 conceptos claves que figuran en un DER:
1- entidades -> son las representaciones de los objetos o conceptos del mundo real.
			Ej. clientes, facturas, articulos. Es decir, las tablas.
2- atributos -> son las características o propiedades de las entidades.
			Ej. nombre, apellido, monto, stock, etc. Es decir, los campos de la tabla
3- relaciones -> son las relaciones entre las tablas, es decir, cómo se relacionan
			entre sí.
            Ej. una factura pertenece a un cliente.
*/

