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
Tipos de dato de texto más utilizados

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
|maximiliano---------| -> 11 + 1 bytes de aviso de longitud
|carlos--------------| -> 6 + 1 bytes de aviso de longitud
|ana-----------------| -> 3 + 1 bytes de aviso de longitud
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

INT
|--------|--------|
-2.147.483.648	  2.147.483.647

INT (unsigned)
|--------|--------|
0				  4.294.967.295

BIGINT es el valor más grande (64 bits)

FLOAT (son decimales de 32 bits)
almacenan hasta 8 dígitos
por ejemplo si hiciéramos 10/3
3.333333 (el . cuenta como un dígito más)
si hiciéramos 100/3
33.33333 (se desplazó el punto, por eso decimos que es punto flotante, pero se achica la precisión decimal)

DOUBLE (son decimales de 64 bits)
almacena hasta 17 dígitos
si hiciera 10/3
3.333333333333333
ó 100/3
33.33333333333333

DECIMAL
representa números decimales de precisión fija, es una precisión exacta.
La estructura es:
DECIMAL(m,n)
donde m es la cantidad de dígitos que tendrá el número en total
y n es la cantidad de dígitos que se utilizarán para representar los decimales
Ejemplo:
DECIMAL(10,2)
xxxxxxxx,xx (el punto no se considera un dígito en este caso)
el mayor número que puedo representar es:
99999999,99

Ocupa en MySQL la precisión + 2 como cantidad de bytes
En el ejemplo anterior:
10 + 2 = 12 bytes
*/


/*
Tipos de datos de fecha y hora

DATE
ocupa 3 bytes y almacena una fecha (por defecto es YYYY,MM,DD)
por ejemplo '2023-08-29'

DATETIME
ocupa 8 bytes y guarda la fecha y la hora
el formato es: YYYY-MM-DD HH:MM:SS

TIME
ocupa 3 bytes y guarda la hora
el formato es: HH:MM:SS

YEAR (no es un standard, es sólo de MySQL)
ocupa 1 byte y almacena valores de años. Puede ser con 2 o 4 dígitos.
*/

-- el comando select nos sirve para traer registros de una tabla
-- pero también lo podemos utilizar para imprimir mensajes en la consola
select 'Hola Mundo!';

-- también puedo pedirle cálculos matemáticos
select 2 + 2;

-- se puede agregar un alias a las consultas de select
select 2 + 2 as 'Suma';

-- el uso del "as" ya no es obligatorio
select 2 + 2 'Suma';

-- el uso de las comillas tampoco es obligatorio
select 2 + 2 Suma;

-- si tenemos espacio entre palabras debemos poner las comillas
select 2 + 2 'resultado suma';

-- otra forma de representar lo anterior es utilizar la escritura snake case
select 2 + 2 resultado_suma;

-- devuelve la fecha actual
select curdate();

-- devuelve la hora actual
select curtime();

-- devuelve la fecha y la hora
select sysdate();

-- 1- Crear la tabla facturas dentro de la base de datos, con el siguiente detalle:

-- campos		tipo
-- letra		char y PK
-- numero 		int y PK
-- fecha		date
-- monto		double

-- PK siginifica Primary Key
-- en este caso se declara una clave primaria compuesta
-- es decir, (letra,codigo)





