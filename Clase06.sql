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
select letra, numero, monto, monto * 0.21 IVA from facturas;

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


