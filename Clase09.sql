drop database if exists cursomysql;

create database cursomysql;

use cursomysql;

show databases;

create table clientes(
	codigo int auto_increment,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	dni char(8) not null,
	direccion varchar(50),
	primary key (codigo)
);

insert into clientes (nombre,apellido,dni,direccion) values ('Juan','Gardoni','12555777','Paso 1523');
insert into clientes (nombre,apellido,dni,direccion) values ('Diego','Novoa','22333444','Libertad 555');
insert into clientes (nombre,apellido,dni,direccion) values ('Laura','Lopez','15888999','España 222');
insert into clientes (nombre,apellido,dni,direccion) values ('Mario','Mendez','99888777','Peña 345');
insert into clientes (nombre,apellido,dni,direccion) values ('Marcela','Gonzalez','56568568','Lima 2042');

select * from clientes;

-- 1- Crear la tabla facturas dentro de la base de datos, con el siguiente detalle:

-- campos		tipo
-- letra		char y PK
-- numero 		int y PK
-- fecha		date
-- monto		double

-- PK siginifica Primary Key
-- en este caso se declara una clave primaria compuesta
-- es decir, (letra,codigo)

drop table if exists facturas;
create table facturas(
	letra enum('A','B','C'),
    numero int unsigned,
    fecha date not null,
    monto double not null,
    check (letra in ('A','B','C')),
    primary key(letra, numero)
);

describe facturas;

/*
Crear la tabla articulos dentro de la base de datos con el siguiente detalle:
	codigo		int y PK
    nombre		varchar(50)
    precio		double
    stock		int
*/

create table articulos(
	codigo int primary key,
    nombre varchar(50) not null,
    precio double not null,
    stock int not null
);

describe articulos;

-- insertar registros en la tabla facturas
insert into facturas (letra, numero, fecha, monto) values ('A',1,curdate(),12500);
insert into facturas (letra, numero, fecha, monto) values ('A',2,curdate(),12500);
insert into facturas (letra, numero, fecha, monto) values ('B',1,curdate(),12500);
insert into facturas (letra, numero, fecha, monto) values ('C',1,'2023-09-04',50000);
-- insert into facturas (letra, numero, fecha, monto) values ('J',1,'2023-08-09',90000);
insert into facturas (letra, numero, fecha, monto) values ('B',2,'2023-01-19',1500);
-- si se cargan todos los campos y en orden, no es necesario describirlos antes:
insert into facturas values ('B',3,'2023-01-19',1500);

-- insertar registros en la tabla articulos
insert into articulos values (1, 'alfajorcito',1000,7);
insert into articulos values (2, 'papitas', 1500, 20);
insert into articulos values (3, 'caramelos', 100, 2000);
insert into articulos values (4, 'agua', 500, 50);
insert into articulos values (5, 'gaseosa', 1200,200); 

-- insertamos más registros en la tabla clientes
insert into clientes (nombre, apellido, dni, direccion) values 
('Juan', 'Novoa', '12345678', 'Belgrano 2033'),
('Marcelo', 'Galván', '11235466', 'Freire 154'),
('María', 'Guerra', '69687563', 'Soler 41'),
('Marcela', 'Nuñez', '22333444', 'San Martín 455'),
('Analía', 'Ponce', '88777666', 'Salta 789');


-- --------------------------------------------------------
-- Comando de recuperación select 
-- --------------------------------------------------------
-- trae todos los registros con todos los campos de la tabla. El * es un comodín 
select * from clientes;

-- seleccionar sólo los nombres y apellidos
select nombre, apellido from clientes;

-- solo seleccionamos los nombres
select nombre from clientes;

-- omitimos los nombres repetidos
select distinct nombre from clientes;

-- filtrado con where 
select * from clientes where nombre = 'Juan';
select * from clientes where nombre = 'juan';
select * from clientes where nombre = 'JUAN';
select * from clientes where nombre = 'Maria'; -- lo trae igual aunque no lo pongamos con tilde

-- Operadores relacionales
-- = igual
-- != no igual
-- <> distinto
-- > mayor
-- < menor
-- >= mayor o igual
-- <= menor o igual

-- selecciona todos los campos de aquellos registros cuyo codigo sea igual a 3
select * from clientes where codigo = 3;

-- selecciona todos los campos de aquellos registros cuyo codigo sea mayor a 3
select * from clientes where codigo > 3;

-- selecciona todos los campos de aquellos registros cuyo codigo sea menor a 3
select * from clientes where codigo < 3;

-- selecciona todos los campos de aquellos registros cuyo codigo sea mayor o igual a 3
select * from clientes where codigo >= 3;

-- operadores AND y OR
-- nos trae todos los campos de todos los registros cuyo codigo sea menor a 3 o mayor a 5.
-- trae los registros que cumplan al menos con alguna de las dos condiciones
select * from clientes where codigo < 3 or codigo > 5;

-- trae todos los campos de todos los registros cuyo codigo sea mayor o igual a 3 y menor o igual a 5
-- trae todos los registros que cumplan con las dos condiciones
select * from clientes where codigo >= 3 and codigo <= 5;

-- valores NULL
-- insertamos registros 
insert into clientes (nombre, apellido, dni, direccion) values ('Mario','Fernández', '99666111','');
insert into clientes (nombre, apellido, dni, direccion) values ('Juana','Fernández', '98888111',null);

-- null significa desconocido, no es lo mismo que vacío o 0
-- los valores nulos no ocupan espacio y son distintos al 0 y al espacio en blanco
-- hay que tener cuidado con los valores nulos en las operaciones, ya que 1 * NULL es igual a NULL

select * from clientes where direccion = '';
select * from clientes where direccion is null;
select * from clientes where direccion is not null;
-- los valores nulos se consultan con is null o is not null
-- nunca ejecutamos con = null, ya que si bien se ejecuta, no da el resultado correcto
select * from clientes where direccion = null;

-- columnas calculadas y alias
select 2 + 2;
select letra, numero, monto from facturas;
select letra, numero, monto, monto * 0.21 from facturas;
select letra, numero, monto as 'valor', monto * 0.21 as 'IVA' from facturas;
-- es lo mismo hacer lo siguiente, sin el as y sin comillas
select letra, numero, monto valor, monto * 0.21 IVA from facturas;

-- parámetros between y not between
select * from facturas where monto between 10000 and 25000;
select * from facturas where monto not between 10000 and 25000;
-- la sentencia between incluye los extremos.
-- la sentencia not between no incluye los valores extremos.

-- parámetros IN, NOT IN
select * from clientes where codigo in (2,4,5);
-- es lo mismo que 
select * from clientes where codigo=2 or codigo=4 or codigo=5;

select * from clientes where codigo not in (2,4,5);
-- es lo mismo que
select * from clientes where codigo <> 2 and codigo <> 4 and codigo <> 5;

-- parámetros like, operadores % y _
-- % significa nada o cualuquier cosa
-- _ significa un caracter cualquiera

select * from clientes;

-- busca todos los registros cuyo nombre comience con m
select * from clientes where nombre like 'M%';

-- busca todos los registros cuyo nombre termine con 'a'
select * from clientes where nombre like '%a';

-- busca todos los registros cuyo apellido termina z
select * from clientes where apellido like '%z';

-- busca todos los registros cuyo nombre comience con cualquier letra, la 'a' sea la segunda 
-- y termine con cualquier secuencia de caracteres o nada
select * from clientes where nombre like '_a%';

-- busca todos los registros cuyo apellido cominece con cualquier letra, la segunda letra sea una 'o'
-- y finalice con z
select * from clientes where apellido like '_o%z';

insert into clientes (nombre, apellido, dni, direccion) values
('Sol','Toaz','89562314',''),
('Fernando','Voz','89562315',null),
('Fernando','Lopez','89562315',null);

-- parámetros ORDER BY  ASC y DESC
select * from clientes order by nombre;
-- ordena alfabéticamente por nombre
select * from clientes order by nombre asc;
-- no es obligatorio usar el 'asc' 
select * from clientes order by nombre desc;
-- el desc sí es obligatorio
-- ordena primero por nombre y luego por código
select * from clientes order by nombre,codigo;
-- ordena primero por nombre en forma ascendente y luego por código de forma descendente
select * from clientes order by nombre, codigo desc;

-- cláusula limit
select * from clientes; -- trae todos los clientes cargados en la tabla
select * from clientes limit 5; -- sólo trae a los 5 primeros
select * from clientes limit 3,6; -- trae 6 registros luego del registro 3

-- insertamos registros en la tabla articulos
insert into articulos values 
(6,'galletitas de agua',1000, 500),
(7,'galletitas dulces', 2500,1000),
(8,'tostadas',1500,600),
(9, 'dulce de leche', 4500,3),
(10,'yerba',25000,100),
(11,'cigarrillos', 70000, 3000),
(12,'panchos', 1200, 200),
(13,'chupetín',500,700),
(14, 'sube', 1000,10000);

-- --------------------------------------------------------
-- EJERCICIOS
-- --------------------------------------------------------

-- Basándose en la tabla artículos, obtener los siguientes listados.

-- 1- articulos con precio mayor a 1000 
select * from articulos where precio > 1000;

-- 2- articulos con precio entre 2000 y 4000 (usar < y >)
select * from articulos where precio > 1999 and precio < 4001;

-- 3- articulos con precio entre 400 y 6000 (usar between)
select * from articulos where precio between 400 and 6000;

-- 4- articulos con precio = 2000 y stock mayor a 300
select * from articulos where precio = 2000 and stock > 300;

-- 5- articulos con precio (1200,2000,3000) no usar in
select * from articulos where precio=1200 or precio=2000 or precio=3000;

-- 6- articulos con precio (1200,2000,3000) usar in
select * from articulos where precio in (1200,2000,3000);

-- 7- articulos que su precio no sea (1200,2000,3000)
select * from articulos where precio not in (1200,2000,3000);

-- 8- listar los articulos ordenados por precio de mayor a menor, y si hubiera
-- precios iguales deben quedar ordenados por nombre
select * from articulos order by precio desc, nombre;

-- 9- listar todos los articulos incluyendo una columna denominada "precio con IVA", 
-- la cual deberá tener el monto con el iva del producto
select nombre, precio, (precio + (precio*0.21)) 'precio con IVA' from articulos;
select nombre, precio, precio + precio*0.21 'precio con IVA' from articulos;
-- forma recomendada:
select nombre, precio, precio*1.21 'precio con IVA' from articulos;
select *, precio*1.21 'precio con IVA' from articulos;
select codigo, nombre, precio, precio*1.21 'precio con IVA', stock from articulos; 

-- 10- listar todos los articulos incluyendo una columna denominada "cantidad de 
-- cuotas" y otra "valor de cuota", la cantidad es fija y es 3, el valor de cuota
-- corresponde a 1/3 del monto con un 5% de interés
select codigo, nombre, stock, precio, 3 'cantidad de cuotas', (precio*1.05) /3 'valor de cuotas' from articulos; 

-- -------------------------------------------------------------------------------------
-- DDL (DATA DEFINITION LANGUAJE)
-- CREATE
-- ALTER
-- DROP

-- DML (DATA MANIPULATION LANGUAJE)
-- SELECT
-- INSERT
-- UPDATE
-- DELETE

create table amigos(
	nombre varchar(50),
    apellido varchar(50)
);

select * from amigos;

-- cargar registros con datos de otra tabla usando select
insert into amigos (nombre, apellido) select nombre, apellido from clientes;

-- crear una tabla a partir de la información de otra
create table nombres select distinct nombre from clientes;

select * from nombres;

-- clonar una tabla
create table clientes_2 select * from clientes;

select * from clientes_2;

insert into amigos values ('Marina','Fernández'),('Luján','Tucci'),('Gabriel','Strauss');

-- Tablas temporales
-- son tablas alojadas en memoria RAM y desaparecen al cortar la conexión con el servidor
-- se la usa para obtener consultas muy veloces para datos temporarios

create temporary table copia select * from clientes;
select * from copia;

-- comando delete
select * from clientes;
delete from clientes where codigo = 5;
-- elimina un único registro

insert into clientes (nombre, apellido, dni, direccion) values ('Juan Pablo','Guerra','77777799',null);
delete from clientes where nombre = 'juan';
-- elimina todos los registros cuyo nombre sea igual a Juan
delete from clientes where nombre like '%juan%';
-- elimina todos los registros cuyo nombre contenga la palabra juan.

-- NOTA: el editor de MySQL Workbench trae configurado por default una protección para evitar ejecuta
-- comandos de borrado o actualización masiva. Hay que desactivarla desde el menú Edición, preferencias,
-- editor de sql. Para mayor seguridad, reiniciar el MySQL Workbench.
-- otra manera de desactivarla es por medio de código:
set sql_safe_updates=0; -- desactiva la protección
set sql_safe_updates=1; -- activa la protección

delete from clientes;
-- elimino todos los registros de la tabla clientes

insert into clientes (nombre, apellido, dni, direccion) values ('Fiorella','Aranibar','65653214',null);
-- inserto un nuevo registro a la tabla clientes, el codigo será el último asignado + 1

-- el comando truncate también vacía la tabla, pero borrando tods los registros simultáneamente,
-- no uno por uno como hace el comando delete, por lo tanto es más veloz.
-- Este comando también reinicia la secuencia de los auto incrementables a cero.
truncate clientes;

-- actualizar valores de registros de una tabla
-- comando update
select * from clientes;
insert into clientes select * from clientes_2;

update clientes set nombre='Mariana' where codigo=2;
-- actualiza la tabla clientes cambiando el nombre por 'Mariana' 
-- a aquellos registros cuyo codigo sea  igual a 2

update clientes set apellido='Vilchez' where nombre='Fernando';
-- actualiza la tabla clientes, cambiando el apellido por 'Vilchez' 
-- cuando el nombre sea igual a 'Fernando'

-- update clientes set apellido='Aranibar';
-- OJO esta query actualiza todos los registros, es decir, que ahora todos los registros tienen
-- como apellido 'Aranibar'

update clientes set nombre= "marcelo"where codigo=1;
update clientes set nombre= "marìa"where codigo=2;
update clientes set nombre= "tomas"where codigo=3;
update clientes set nombre= "niclas"where codigo=4;
update clientes set nombre= "fernando"where codigo=5;
update clientes set nombre= "uriel"where codigo=6;

select * from clientes;

describe clientes;
-- 1- 	Insertar 5 clientes en la tabla clientes dejando que el motor de la BD 
-- complete su código
insert into clientes (nombre, apellido, dni, direccion) values
('Fernando', 'Vilchez', '46563222', 'Avda. Siempre Viva 123'),
('Nancy', 'Abriosio', '88776666', null),
('Laura', 'Ponce', '33336655', ''),
('Agustín', 'Rueda', '89898989','Freire 78'),
('Mariana', 'Aguirre', '77441122', 'Salta 304');

-- 2-	Insertar 5 clientes en la tabla clientes utilizando todos los campos como 
-- parte de la sentencias,
select * from clientes;
insert into clientes (codigo, nombre, apellido, dni, direccion) values
(21, 'Walter', 'White', '44759810', 'Las Vegas 789'),
(30, 'El Chavo', 'Del 8', '77441122', ''),
(33, 'Pablo', 'Picapiedra', '96580000', 'Soler 2356'),
(22, 'Peter', 'Soler', '85214466', 'Jujuy 202'),
(100, 'Soledad', 'Dolores', '', 'Solari 123');

insert into clientes (nombre, apellido, dni, direccion) values
('Juan', 'Perez', '88552222', null);

-- 3-	Actualizar el nombre del cliente 1 a Jose
update clientes set nombre='Jose' where codigo=1;

-- 4-	Actualizar el nombre, apellido y dni del cliente 3 a Pablo Fuentes 21053119
update clientes set nombre='Pablo', apellido='Fuentes', dni='21053119' where codigo=3;
select * from clientes where codigo=3;

-- 5-  Actualizar la dirección del cliente de código 2 a vacío
update clientes set direccion='' where codigo=2;
select * from clientes where codigo=2;

-- 6-	Actualizar las direcciones de los clientes de código 3, 5 y 7 a 'null'
update clientes set direccion = null where codigo in (3,5,7);
select * from clientes where codigo in (3,5,7);

-- 7-	Eliminar los clientes con apellido Perez.
delete from clientes where apellido='Perez';

-- 8-	Eliminar los clientes con dni que terminan en 0.
delete from clientes where dni like '%0';

-- 9-  Eliminar los clientes cuyo nombre contenga una r y su apellido termine en z
delete from clientes where nombre like '%r%' and apellido like '%z';
select * from clientes;

-- Basándose en la tabla artículos, realizar los siguientes puntos.
-- 	10- Aumentar un 20% los precios de los artículos con precio menor igual a 50.
update articulos set precio = precio * 1.2 where precio <= 50;
select * from articulos;

-- 	11- Aumentar un 15% los precios de los artículos con precio mayor a 50.
update articulos set precio = precio * 1.15 where precio > 50;

-- 	12- Bajar un 5% los precios de los artículos con precio mayor a 200.
update articulos set precio = precio * 0.95 where precio > 200;

-- 13- bajar el %50 del precio a los artículos que estén entre 20000 y 40000
update articulos set precio = precio/2 where precio between 20000 and 40000;

-- 14- aumentar el stock a 200 a todos aquellos productos que tengan el stock 
-- mayor a 0 y hasta 150
update articulos set stock = 200 where stock > 0 and stock <= 150;

-- 15- Eliminar los artículos con stock menor a 0.
delete from articulos where stock < 0;

-- 16- eliminar todos los artículos cuyo precio sea mayor a $50.000
delete from articulos where precio > 50000;

-- **********************************************

-- ALTER TABLE
-- modifica la estructura de una tabla


describe clientes;
-- agregar campos
alter table clientes add edad smallint unsigned not null;
describe clientes;
select * from clientes;

update clientes set edad = 25 where codigo = 1;
update clientes set edad = 35 where codigo = 2;
select * from clientes;

-- modificar campos
alter table clientes modify edad tinyint unsigned;
describe clientes;

-- cambiar nombre a un campo
alter table clientes change edad antiguedad tinyint unsigned;
describe clientes;

-- borrar campos
alter table clientes drop antiguedad;
describe clientes;

-- eliminar la PK
-- para poder eliminar la PK, el campo no puede ser auto_increment
-- alter table clientes drop primary key;
alter table clientes modify codigo int;
describe clientes;
-- al no ser más auto_incrementable, puedo eliminar la PK
alter table clientes drop primary key;
describe clientes;

-- agregar clave primaria
alter table clientes add primary key (codigo);
describe clientes;

alter table clientes modify codigo int auto_increment;
describe clientes;

-- renombrar tablas
rename table clientes to auxiliar, facturas to auxiliar2;
show tables;

rename table auxiliar to clientes, auxiliar2 to facturas;

describe clientes;
alter table clientes add column edad smallint not null after nombre ;
alter table clientes drop edad;




