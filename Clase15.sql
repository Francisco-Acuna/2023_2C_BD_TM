-- -------------    -------------------     -------------     
-- - libros    -    - prestamos       -     - socios    -    
-- -------------    -------------------     -------------     
-- - codigo PK -    - documento   PK FK -     - documento  PK -
-- - titulo    -    - codigo_libro PK FK -     - nombre    -
-- - autor     -    - fecha_prestamo   -       - domicilio -
-- -------------    - fecha_devolucion -     -------------
--                  -------------------                

drop database if exists libros_centro8;
create database libros_centro8;
use libros_centro8;

drop table if exists libros;
create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(20),
  primary key (codigo)
);

drop table if exists socios;
create table socios(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  primary key (documento)
);

drop table if exists prestamos;
create table prestamos(
  documento char(8) not null,
  codigo_libro int unsigned,
  fecha_prestamo date not null,
  fecha_devolucion date,
  primary key (codigo_libro,documento)
);

alter table prestamos add constraint FK_prestamos_libros
foreign key(codigo_libro) references libros(codigo);

alter table prestamos add constraint FK_prestamos_socios
foreign key(documento) references socios(documento);

insert into socios values('22333444','Juan Perez','Colon 345');
insert into socios values('23333444','Luis Lopez','Caseros 940');
insert into socios values('25333444','Ana Herrero','Sucre 120');
insert into socios values('23252568','Juan Garcia','Colon 125');
insert into socios values('30333444','Cosme Fulanito','Medrano 162');
insert into socios values('25335444','Esteban Quito','Rivadavia 1566');

insert into libros values(1,'Manual de 2º grado','Molina Manuel');
insert into libros values(2,'El enigmático número 27', 'Acuña Franciso');
insert into libros values(25,'Aprenda PHP','Oscar Mendez');
insert into libros values(42,'Martin Fierro','Jose Hernandez');
insert into libros values(44,'Aprenda java','Mario Dominguez');

insert into prestamos values('22333444',1,'2006-08-10','2006-08-12');
insert into prestamos values('22333444',44,'2006-08-15',null);
insert into prestamos values('25333444',25,'2006-08-10','2006-08-13');
insert into prestamos values('25333444',42,'2006-08-10',null);
insert into prestamos values('25335444',25,'2006-08-15',null);
insert into prestamos values('30333444',42,'2006-08-02','2006-08-05');
insert into prestamos values('25333444',2,'2006-08-02','2006-08-05');
insert into prestamos values('23252568',44,curdate(),null);

-- 1- qué libros (codigo, titulo, autor) se le prestaron a cada socio?
select distinct l.codigo, l.titulo, l.autor, s.nombre nombre_socio
from libros l 
join prestamos p on l.codigo=p.codigo_libro
join socios s on p.documento=s.documento;

-- 2- Listar los socios (documento, nombre, domicilio) a los que se les prestó
-- libros de Java
select distinct s.documento, s.nombre, s.domicilio
from socios s
join prestamos p on p.documento=s.documento
join libros l on l.codigo=p.codigo_libro
where l.titulo like '%java%';

-- 3- Listar de libros (codigo,titulo,autor) que no fueron devueltos 
select distinct l.codigo, l.titulo, l.autor
from libros l
join prestamos p on l.codigo=p.codigo_libro
where fecha_devolucion is null;

-- 4- Lista de socios (documento, nombre, domicilio) que tienen libros sin devolver
select distinct s.documento, s.nombre, s.domicilio
from socios s
join prestamos p on s.documento=p.documento
where fecha_devolucion is null;

-- 5- Lista de socios (documento, nombre, domicilio) que tienen libros sin devolver
-- y cuáles son esos libros
select distinct s.documento, s.nombre, s.domicilio, l.*
from socios s
join prestamos p on s.documento=p.documento
join libros l on p.codigo_libro=l.codigo
where fecha_devolucion is null;

-- 6- cantidad de libros sin devolver
select count(*) cantidad_de_libros 
from prestamos
where fecha_devolucion is null;

-- 7. Lista de libros que fueron prestados el día de hoy.
select l.*
from libros l
join prestamos p on l.codigo=p.codigo_libro
where p.fecha_prestamo = curdate();

-- 8- Cantidad de libros que se prestaron este mes
select count(*) cantidad_de_libros
from prestamos
where month(fecha_prestamo) = month(curdate())
and year(fecha_prestamo) = year(curdate());

-- 9- Cantidad de socios que tomaron libros prestados este mes
select s.nombre, count(*) cantidad_de_socios
from socios s
join prestamos p on s.documento=p.documento
where month(fecha_prestamo) = month(curdate())
and year (fecha_prestamo) = year(curdate())
group by s.nombre;

