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

--  	l. informar los autos con el menor precio entre los años 2014 y 2023
--  	m. listar los autos ordenados ascendentemente por marca,modelo, y el año en forma descendente.
--  	n. contar cuantos autos hay de cada marca.
--  	o. borrar los autos del siglo pasado.