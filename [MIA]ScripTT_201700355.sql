------------------------------------------CARGA MASIVA

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

select * from tempdatos;

delete from tempdatos;