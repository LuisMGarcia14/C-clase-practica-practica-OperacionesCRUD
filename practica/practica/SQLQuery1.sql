USE [master]
GO

--> 1. CREAR BASE DE DATOS

CREATE DATABASE DbGestionTareas
GO

USE DbGestionTareas
GO

--> 2. CREAR TABLAS

CREATE TABLE TblUsuario(
	IdUsuario INT IDENTITY PRIMARY KEY,
	Usuario VARCHAR(25) NOT NULL,
	Clave VARCHAR(6) NOT NULL,
	Estado VARCHAR(7) NOT NULL CHECK (Estado IN ('Activo', 'Invactivo'))
);
GO

CREATE TABLE TblPersona(
	Cedula VARCHAR(16) PRIMARY KEY,
	Sexo CHAR(1) NOT NULL CHECK(Sexo IN('M','F')),
	Nombre VARCHAR(70) NOT NULL,
	Telefono VARCHAR(15) NOT NULL,
	Direccion VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE TblTareas(
	IdTarea INT IDENTITY PRIMARY KEY,
	Fecha DATETIME NOT NULL,
	IdUsuario INT NOT NULL FOREIGN KEY REFERENCES TblUsuario(IdUsuario),
	Cedula VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES TblPersona(Cedula)
);
GO

CREATE TABLE TblDetalleTarea(
	IdDetalle INT IDENTITY PRIMARY KEY,
	IdTarea INT NOT NULL FOREIGN KEY REFERENCES TblTareas(IdTarea),
	Tarea VARCHAR(70) NOT NULL,
	Descripcion VARCHAR(MAX) NOT NULL,
	Estado VARCHAR(10) CHECK (Estado IN('Pendiente', 'Completado'))
);
GO


CREATE OR ALTER PROC sp_Usuario_Seleccionar
@Valor VARCHAR(25)
AS
BEGIN
	IF @Valor = ''
		SELECT IdUsuario AS ID, Usuario AS USUARIO, Clave AS CLAVE, Estado AS ESTADO
		FROM TblUsuario
		ORDER BY IdUsuario DESC
	ELSE
		SELECT IdUsuario AS ID, Usuario AS USUARIO, Clave AS CLAVE, Estado AS ESTADO
		FROM TblUsuario
		WHERE Usuario LIKE '%' + @Valor + '%'
END
GO

--> 3. CREAR PROCEDIMIENTOS ALMACENADOS
CREATE OR ALTER PROC Usuario_Guardar
@Usuario VARCHAR(25),
@Clave VARCHAR(6),
@Estado VARCHAR(7)
AS
BEGIN
	INSERT INTO TblUsuario(Usuario, Clave, Estado)
	VALUES(@Usuario, @Clave, @Estado)
END
GO


CREATE OR ALTER PROC Usuario_Actualizar
@IdUsuario INT,
@Usuario VARCHAR(25),
@Clave VARCHAR(6),
@Estado VARCHAR(7)
AS
BEGIN
	INSERT INTO TblUsuario(IdUsuario, Usuario, Clave, Estado)
	VALUES(@IdUsuario, @Usuario, @Clave, @Estado)
END
GO


CREATE OR ALTER PROC Eliminar_Usuario
@IdUsuario INT
AS
BEGIN
	DELETE FROM TblUsuario 
	WHERE IdUsuario = @IdUsuario 
END
GO