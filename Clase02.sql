-- comentarios
-- es necesario dejar un espacio luego de los --

/*
esto es un bloque
de comentarios
se puede escribir en línea
*/

# es otro tipo de comentario, pero no es ANSI
# es decir, que sólo funciona en MySQL

show databases; -- lista las bases de datos del servidor
-- atajo de teclado para ejecutar una sentencia
-- CTRL + ENTER
SHOW DATABASES; -- es no case sensitive
-- el ; es el terminador de sentencias

drop database if exists cursomysql;
-- elimino la base si existe

create database cursomysql;
-- creo una base de datos

create database if not exists cursomysql;
-- crea la base de datos si no existe

show databases;

create database CURSOMYSQL;
-- en windows lo toma como la misma base
-- en linux sería distinta

use cursomysql;
-- me posiciono en la base de datos

show tables;
-- muestra las tablas de la base de datos

-- creación de una tabla
create table clientes(
codigo int auto_increment,
nombre varchar(20) not null,
apellido varchar(20) not null,
dni char(8) not null,
direccion varchar(50),
primary key (codigo)
);
-- las comas separan los campos
-- auto_increment va a cargar automáticamente
-- el valor numérico autoincrementado
-- not null indica que el campo es de caracter obligatorio
-- primary key indica que es el campo que va a 
-- identificar al registro.

show tables;

describe clientes;
-- muestra la descripción de los campos de la tabla cliente

select * from clientes;
-- muestra todos los registros de la tabla clientes

drop table clientes;
-- elimina la tabla clientes

drop table if exists clientes;
-- eliminamos la tabla si es que existe

show tables;

create table if not exists clientes(
	codigo int auto_increment,
    nombre varchar(20) not null,
    apellido varchar(20) not null,
    dni char(8) not null,
    direccion varchar(50),
    primary key(codigo)
);
-- crea la tabla si no existe. Si ya existe, no hace nada.

show tables;

-- Ingresar registros en una tabla
insert into clientes (nombre,apellido,dni,direccion) values ('Juan','Gardoni','12555777','Paso 1523');
insert into clientes (nombre,apellido,dni,direccion) values ('Diego','Novoa','22333444','Libertad 555');
insert into clientes (nombre,apellido,dni,direccion) values ('Laura','Lopez','15888999','España 222');
insert into clientes (nombre,apellido,dni,direccion) values ('Mario','Mendez','99888777','Peña 345');
insert into clientes (nombre,apellido,dni,direccion) values ('Marcela','Gonzalez','56568568','Lima 2042');

select * from clientes;

/*
Tipos de dato de texto más utilizado

CHAR -> este tipo de dato lo utilizamos cuando sabemos de antemano cuántos caracteres se guardarán
Por ejemplo, si declaramos un tipo CHAR de 20 posiciones, siempre va a guardar 20 bytes
nombre CHAR(20)
|--------------------| -> 20 bytes
|maximiliano---------| -> 20 bytes
|carlos--------------| -> 20 bytes
|ana-----------------| -> 20 bytes

VARCHAR -> este tipo de dato lo utilizamos cuando no sabemos la longitud del dato que se ingresará
nombre VARCHAR(20)
|--------------------| -> 20 bytes
|maximiliano---------| -> 11 + 1 bytes 
|carlos--------------| -> 6 + 1 bytes
|ana-----------------| -> 3 + 1 bytes
*/

/*
Tipos de datos numéricos

BIT o BOOL 
es un entero que representa un valor de verdad,
sirve para guardar valores lógicos. El 0 representa el valor falso,
y cualquier otro número distinto de 0 representa el valor de verdad. 

TINYINT
almacena un entero de 1 byte
|--------|--------|
-128	 0		 127	

TINYINT unsigned (no utiliza los números negativos)
|--------|--------|
0				  255

SMALLINT
|--------|--------|
-32.768  0		  32.767

SMALLINT unsigned
|--------|--------|
0				  65.535
*/


