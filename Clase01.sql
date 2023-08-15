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

