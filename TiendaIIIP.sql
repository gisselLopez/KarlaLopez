create database TiendaIIIP;

use TiendaIIIP;


create table usuario(
idUsuario int not null primary key,
Nombre varchar(20),
apellido varchar(25),
NombreUsuario varchar(20),
Pws varchar(15),
rol char (15),
estado char (15),
correo varchar(50)
)
select * from usuario

	/*------Procedimientos almacenados, store procedure crud------*/

	create procedure insertarUsuario
	@idUsuario as int ,
	@Nombre varchar(20),
	@apellido varchar(25),
	@UserName varchar(20),
	@Pws varchar(15),
	@rol char (15),
	@estado char (15),
	@correo varchar(50)


	as begin

		if exists (select NombreUsuario from usuario where NombreUsuario=@userName and estado ='activo')
		raiserror ('Ya existe un registro con ese Usuario, por favor ingrese uno Nuevo',16,1)
		else
		insert into usuario values (@idUsuario ,@Nombre,@apellido, @UserName ,@Pws,@rol ,@estado, @correo)
	end
	execute insertarUsuario 1, 'karla','lopez','klopez','123','admin','activo', 'KLopez@unicah.edu'
	execute insertarUsuario 2, 'Gissel','lopez','Glopez','321','admin','activo', 'GLopez@unicah.edu'
	execute insertarUsuario 12, 'moscu','lopez','Mlopez','212','cajero','Eliminado', 'MLopez@gmail.com'

	select * from usuario

/*------------UPDATE------------------*/
----------Modificar usuario------
	create procedure modificarUsuario(
		@idUsuario int ,
		@Nombre varchar(20),
		@apellido varchar(25),
		@userName varchar(20),
		@Pws varchar(15),
		@rol char (15),
		@estado char (15),
		@correo  varchar(50)

	)
	as begin
	if exists (select NombreUsuario,idUsuario from usuario where (NombreUsuario=@userName and idUsuario<> @idUsuario and estado ='activo')or
				(Nombre = @Nombre and idUsuario <> @idUsuario and estado = 'activo'))
		raiserror (' Usuario en uso , por favor utiliza otro',16,1)
		else
		update usuario set nombre= @Nombre,apellido = @apellido, pws= @Pws,rol= @rol ,correo=@correo
		where idUsuario= @idUsuario
	end

	select * from usuario

	------EliminarUsuario---------
	
	create procedure eliminarUsuario
	@idUsuario int,
	@rol varchar(15)
	
	as begin
		if exists(select nombreUsuario from usuario where @rol= 'admin')
		raiserror (' Usuario *admin* no se puede eliminar , accion denegada',16,1)
		else
		update usuario set estado= 'eliminado'
		where idusuario =@idUsuario and rol <> 'admin'
		end

		execute eliminarUsuario 12, 'cajero'
		execute eliminarUsuario 2, 'admin'

		select * from usuario

		-----------Buscar Usuario por nombre de usuario-------

		create procedure BuscarUsuario(
		@userName varchar(50)
		
		)

		as begin
			select CONCAT (nombre,' ' ,apellido) as 'Nombre completo', NombreUsuario as 'Usuario', estado as 'Estado',
			rol as 'rol', correo as 'correo'
			from usuario
			where NombreUsuario like '%' +@userName+ '%'
		end

		execute BuscarUsuario 'm'
		execute BuscarUsuario 'G'
		execute BuscarUsuario 'k'

		select * from usuario