-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	SCRIPT PARA CREAR LA ESTRUCTURA DE LA BASE NEGOCIO_ROPA
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++


drop database if exists negocio_ropa;

create database negocio_ropa;

use negocio_ropa;

drop table if exists clientes;
create table clientes(
	id_cliente int auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    dni char(8) not null,
    tel_celular varchar(10),
    email varchar(50),
    primary key(id_cliente)
);

drop table if exists vendedores;
create table vendedores(
	legajo int auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    dni char(8) not null,
    tel_celular varchar(10),
    email varchar(50),
    primary key(legajo)
);

drop table if exists articulos;
create table articulos(
	codigo int,
    producto varchar(100) not null,
    color varchar(50) not null,
    stock int not null,
    stock_minimo int not null,
    stock_maximo int not null,
    primary key(codigo)
);

drop table if exists facturas;
create table facturas(
	letra char(1),
    numero int,
    fecha date not null,
    monto double not null,
    id_cliente int not null, 
    legajo_vendedor int not null,
    check(letra in('A','B','C')),
    primary key(letra, numero)
);

alter table facturas add constraint FK_facturas_clientes
foreign key(id_cliente) references clientes(id_cliente);

alter table facturas add constraint FK_facturas_vendedores
foreign key(legajo_vendedor) references vendedores(legajo);


drop table if exists ventas;
create table ventas(
	letra char(1) not null,
    numero int not null,
    codigo int not null,
    cantidad int not null,
    primary key(letra, numero, codigo)
);

alter table ventas add constraint FK_ventas_facturas
foreign key(letra,numero) references facturas(letra,numero);

alter table ventas add constraint FK_ventas_articulos
foreign key(codigo) references articulos(codigo)

