----------------------------------------------------CARGA MASICA

create table tempdatos(
	nombre_cliente varchar(50) not null,
	correo_cliente varchar(50) not null,
	cliente_activo varchar(50) not null,
	fecha_creacion varchar(50) not null,
	tienda_preferida varchar(50) not null,
	direccion_cliente varchar(50) not null,
	codigo_postal_cliente varchar(50) not null,
	ciudad_cliente varchar(50) not null,
	pais_cliente varchar(50) not null,
	fecha_renta varchar(50) not null,
	fecha_retorno varchar(50) not null,
	monto_a_pagar varchar(50) not null,
	fecha_pago varchar(50) not null,
	nombre_empleado varchar(50) not null,
	correo_empleado varchar(50) not null,
	empleado_activo varchar(50) not null,
	tienda_empleado varchar(50) not null,
	usuario_empleado varchar(50) not null,
	contrasenia_empleado varchar(100) not null,
	direccion_empleado varchar(50) not null,
	codigo_postal_empleado varchar(50) not null,
	ciudad_empleado varchar(50) not null,
	pais_empleado varchar(50) not null,
	nombre_tienda varchar(50) not null,
	encargado_tienda varchar(50) not null,
	direccion_tienda varchar(50) not null,
	codigo_postal_tienda varchar(50) not null,
	ciudad_tienda varchar(50) not null,
	pais_tienda varchar(50) not null,
	tienda_pelicula varchar(50) not null,
	nombre_pelicula varchar(50) not null,
	descripcion_pelicula varchar(500) not null,
	anio_lanzamiento varchar(50) not null,
	dias_renta varchar(50) not null,
	costo_renta varchar(50) not null,
	duracion varchar(50) not null,
	costo_por_danio varchar(50) not null,
	clasificacion varchar(50) not null,
	lenguaje_pelicula varchar(50) not null,
	categoria_pelicula varchar(50) not null,
	actor_pelicula varchar(50) not null
);

copy tempdatos from '/home/diamg/Escritorio/BlockbusterData.csv' USING delimiters ';' csv header encoding 'windows-1251';

--SELECCIONES

select * from direcciones

--------------------------------------------------CONSULTAS

--Ingresando paises
insert into pais(pais)
select distinct pais_cliente from tempdatos where pais_cliente <> '-'
union distinct
select distinct pais_empleado from tempdatos where pais_empleado <> '-'
union distinct 
select distinct pais_tienda from tempdatos where pais_tienda <> '-';

select * from pais order by id_pais asc;

--Ingresando ciudades
insert into ciudad(ciudad,id_pais)
select distinct ciudad_cliente,
(select id_pais from pais where pais.pais=tempdatos.pais_cliente)
from tempdatos where ciudad_cliente <> '-'
union distinct
select distinct ciudad_empleado,
(select id_pais from pais where pais.pais=tempdatos.pais_empleado)
from tempdatos where ciudad_empleado <> '-'
union distinct 
select distinct ciudad_tienda,
(select id_pais from pais where pais.pais=tempdatos.pais_tienda)
from tempdatos where ciudad_tienda <> '-' order by id_pais asc;

select * from ciudad order by id_ciudad asc;


--Ingresando lenguajes
insert into lenguajes(idioma)
select distinct lenguaje_pelicula from tempdatos where lenguaje_pelicula <> '-'

select * from lenguajes order by id_lenguajes asc;

--ingresando clasificaciones
insert into clasificaciones(clasificacion)
select distinct clasificacion from tempdatos where clasificacion <> '-'

select * from clasificaciones order by id_clasificacion asc;

--ingresando actores
insert into actores(actor)
select distinct actor_pelicula from tempdatos where actor_pelicula <> '-'

select * from actores order by id_actor asc;

--ingresando categorias
insert into categorias(tpo_categoria)
select distinct categoria_pelicula from tempdatos where categoria_pelicula <> '-'

select * from categorias order by id_categoria asc;

--ingresando direcciones
insert into direcciones(direccion,codigo_postal,id_ciudad)
select distinct direccion_cliente, codigo_postal_cliente,
(select id_ciudad from ciudad where ciudad.ciudad=tempdatos.ciudad_cliente LIMIT 1)
from tempdatos where ciudad_cliente <> '-' and direccion_cliente <> '-' and codigo_postal_cliente <> '-'
union distinct
select distinct direccion_empleado, codigo_postal_empleado,
(select id_ciudad from ciudad where ciudad.ciudad=tempdatos.ciudad_empleado LIMIT 1)
from tempdatos where ciudad_cliente <> '-' and direccion_cliente <> '-' and codigo_postal_cliente <> '-'
union distinct
select distinct direccion_tienda, codigo_postal_tienda,
(select id_ciudad from ciudad where ciudad.ciudad=tempdatos.ciudad_tienda LIMIT 1)
from tempdatos where ciudad_cliente <> '-' and direccion_cliente <> '-' and codigo_postal_cliente <> '-'

select * from DIRECCIONES order by id_direccion asc;

delete from direcciones
--ingresando empleados
insert into empleados(nombre, apellido, correo_electronico, estado, nombre_usuario, contraseña, tienda_actual,id_direccion)
SELECT distinct split_part(nombre_empleado, ' ', 1),split_part(nombre_empleado, ' ', 2),
correo_empleado,empleado_activo,usuario_empleado,contrasenia_empleado, tienda_empleado,
(select id_direccion from direcciones where direcciones.direccion = tempdatos.direccion_empleado)
from tempdatos where nombre_empleado <> '-';

select * from empleados order by id_empleado asc;

delete from empleados
--ingresando tiendas
insert into tiendas(nombre_tienda,encargado, id_direccion, id_empleado)
select distinct nombre_tienda,encargado_tienda,
(select id_direccion from direcciones where direcciones.direccion = tempdatos.direccion_tienda),
(select id_empleado from empleados where empleados.nombre_usuario = tempdatos.usuario_empleado)
from tempdatos where encargado_tienda <> '-'

select * from tiendas order by id_direccion asc;

--ingresando clientes
insert into clientes(nombre, apellido, correo_electronico, fecha_registro, estado,tienda_favorita,id_direccion)
select distinct split_part(nombre_cliente, ' ', 1),split_part(nombre_cliente, ' ', 2),
correo_cliente,fecha_creacion,cliente_activo,tienda_preferida,
(select id_direccion from direcciones where direcciones.direccion = tempdatos.direccion_cliente)
from tempdatos where encargado_tienda <> '-' and fecha_creacion <> '-' and cliente_activo <> '-'
and tienda_preferida <> '-'

select * from clientes order by id_cliente asc;

--INGRESNADO PELICULAS
insert into pelicula(titulo,descripcion,lanzamiento,duracion,renta_dias,costo_renta,costo_danio,id_clasificacion, id_lenguajes)

select distinct nombre_pelicula,descripcion_pelicula,anio_lanzamiento,duracion,dias_renta,costo_renta,costo_por_danio,
(select id_clasificacion from clasificaciones where clasificaciones.clasificacion = tempdatos.clasificacion),
(select id_lenguajes from lenguajes where lenguajes.idioma = tempdatos.lenguaje_pelicula)
from tempdatos where nombre_pelicula <> '-' and costo_renta <> '-' and costo_por_danio <> '-'
and dias_renta <> '-'

select * from pelicula order by id_pelicula asc;


--INGRESANDO EL INVENTARIADO

insert into inventario(pelicula_tienda,id_pelicula,id_tienda)

select distinct tienda_pelicula,
(select id_pelicula from pelicula where pelicula.titulo = tempdatos.nombre_pelicula),
(select id_tienda from tiendas where tempdatos.nombre_pelicula = tempdatos.nombre_pelicula limit 1)
from tempdatos where tienda_pelicula <> '-'

select * from inventario order by id_inventario asc


--ingresando rentas

insert into renta (precio,fecha_pago,fecha_renta,fecha_limit_entrega,id_cliente,id_empleado)

select distinct monto_a_pagar,fecha_pago,fecha_renta,fecha_retorno,
(select id_cliente from clientes where clientes.correo_electronico = tempdatos.correo_cliente),
(select id_empleado from empleados where empleados.correo_electronico = tempdatos.correo_empleado)

from tempdatos where monto_a_pagar <> '-' and fecha_retorno <> '-'

select * from renta order by id_renta asc

--insertando categoria-pelicula

insert into categoriapelicula(id_pelicula,id_categoria)

select distinct
(select id_pelicula from pelicula where pelicula.titulo = tempdatos.nombre_pelicula),
(select id_categoria from categorias where categorias.tpo_categoria = tempdatos.categoria_pelicula)
from tempdatos where nombre_pelicula <> '-' and categoria_pelicula <> '-'

select * from categoriapelicula order by id_categoriapelicula asc

--insertando peliculaactor

insert into peliculaactor(id_pelicula,id_actor)

select distinct
(select id_pelicula from pelicula where pelicula.titulo = tempdatos.nombre_pelicula),
(select id_actor from actores where actores.actor = tempdatos.actor_pelicula)
from tempdatos where nombre_pelicula <> '-' and actor_pelicula <> '-'

select * from categoriapelicula order by id_categoriapelicula asc

delete from peliculaactor
