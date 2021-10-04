
------------------------------------------MODELO RELACIONAL

create table pais(
	id_pais serial not null,
	pais varchar(50) not null,
	primary key (id_pais)
);

create table ciudad(
	id_ciudad serial not null,
	ciudad varchar(50) not null,
	id_pais int not null,
	primary key (id_ciudad),
	foreign key (id_pais) references pais(id_pais)
);

create table direcciones(
	id_direccion serial not null,
	direccion varchar(50) not null,
	distrito varchar(50) not null,
	codigo_postal varchar(50) not null,
	id_ciudad int not null,
	primary key (id_direccion),
	foreign key (id_ciudad) references ciudad(id_ciudad)
	
);

create table clientes(
	id_cliente serial not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	correo_electronico varchar(50) not null,
	fecha_registro varchar(50) not null,
	estado varchar(50) not null,
	tienda_favorita varchar(50) not null,
	id_direccion int not null,
	primary key (id_cliente),
	foreign key (id_direccion) references direcciones(id_direccion)
);


create table empleados(
	id_empleado serial not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	correo_electronico varchar(50) not null,
	estado varchar(50) not null,
	nombre_usuario varchar(50) not null,
	contraseña varchar(50) not null,
	tienda_actual varchar(50) not null,
	id_direccion int not null,
	primary key (id_empleado),
	foreign key (id_direccion) references direcciones(id_direccion)
	
);

create table encargados(
	id_encargado serial not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	direccion varchar(50) not null,
	correo_electronico varchar(50) not null,
	estado varchar(50) not null,
	nombre_usuario varchar(50) not null,
	contraseña varchar(50) not null,
	tienda_actual varchar(50) not null,
	primary key (id_encargado)
);

create table tiendas(
	id_tienda serial not null,
	nombre_tienda varchar(50) not null,
	encargado varchar(50) not null,
	id_direccion int not null,
	id_empleado int not null,
	primary key (id_tienda),
	foreign key (id_direccion) references direcciones(id_direccion),
	foreign key (id_empleado) references empleados(id_empleado)
);

create table renta(
	id_renta serial not null,
	precio varchar(50) not null,
	fecha_pago varchar(50) not null,
	fecha_renta varchar(50) not null,
	fecha_limit_entrega varchar(50) not null,
	id_cliente int not null,
	id_empleado int not null,
	primary key (id_renta),
	foreign key (id_cliente) references clientes(id_cliente),
	foreign key (id_empleado) references empleados(id_empleado)
);

--------

create table inventario(
	id_inventario serial not null,
	pelicula_tienda varchar(50) not null,
	id_pelicula int not null,
	id_tienda int not null,
	primary key (id_inventario),
	foreign key (id_pelicula) references pelicula(id_pelicula),
	foreign key (id_tienda) references tiendas(id_tienda)
);

create table pelicula(
	id_pelicula serial not null,
	titulo varchar(50)	not null,
	descripcion varchar(50) not null,
	lanzamiento varchar(50) not null,
	duracion varchar(50) not null,
	renta_dias varchar(50) not null,
	costo_renta varchar(50) not null,
	costo_año varchar(50) not null,
	id_clasificacion int not null,
	id_lenguajes int not null,
	primary key (id_pelicula),
	foreign key (id_clasificacion) references clasificaciones(id_clasificacion),
	foreign key (id_lenguajes) references lenguajes(id_lenguajes)
);

create table clasificaciones(
	id_clasificacion serial not null,
	clasificacion varchar(50) not null,
	primary key (id_clasificacion)
);

create table lenguajes(
	id_lenguajes serial not null,
	idioma varchar(50) 	not null,
	primary key (id_lenguajes)
);

create table categorias(
	id_categoria serial not null,
	tpo_categoria varchar(50) not null,
	primary key (id_categoria)
);

create table categoriapelicula(
	id_categoriapelicula serial not null,
	id_pelicula int not null,
	id_categoria int not null,
	primary key (id_categoriapelicula),
	foreign key (id_pelicula) references pelicula(id_pelicula),
	foreign key (id_categoria) references categorias(id_categoria)
);

create table actores(
	id_actor serial not null,
	actor varchar(50) not null,
	primary key (id_actor)
);

create table peliculaactor(
	id_peliculaactor serial not null,
	id_pelicula int not null,
	id_actor int not null,
	primary key (id_peliculaactor),
	foreign key (id_pelicula) references pelicula(id_pelicula),
	foreign key (id_actor) references actores(id_actor)
);