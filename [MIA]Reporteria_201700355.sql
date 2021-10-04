
--CONSULTA 1
select count(*) from inventario,pelicula
where pelicula.titulo = 'SUGAR WONKA' and
pelicula.id_pelicula = inventario.id_pelicula


--CONSULTA 2