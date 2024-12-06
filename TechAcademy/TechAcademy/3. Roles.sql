USE TECHACADEMY;
GO


-- Crear roles de base de datos
CREATE ROLE Rol_Estudiante;
CREATE ROLE Rol_Profesor;
CREATE ROLE Rol_Administrador;

-- Asignar permisos al Rol_Estudiante
GRANT SELECT ON Estudiante TO Rol_Estudiante; -- Permitir ver sus propios datos
GRANT SELECT ON Curso TO Rol_Estudiante; -- Permitir ver cursos disponibles
GRANT SELECT ON Inscripcion TO Rol_Estudiante; -- Ver sus inscripciones
GRANT SELECT ON Evaluacion TO Rol_Estudiante; -- Ver sus evaluaciones
GRANT INSERT ON Inscripcion TO Rol_Estudiante; -- Inscribirse en cursos

-- Asignar permisos al Rol_Profesor
GRANT SELECT ON Profesor TO Rol_Profesor; -- Ver datos personales del profesor
GRANT SELECT ON Curso TO Rol_Profesor; -- Ver cursos que imparte
GRANT SELECT ON Evaluacion TO Rol_Profesor; -- Ver evaluaciones asignadas
GRANT INSERT, UPDATE ON Evaluacion TO Rol_Profesor; -- Calificar estudiantes
GRANT SELECT ON Inscripcion TO Rol_Profesor; -- Ver estudiantes inscritos en sus cursos

-- Asignar permisos al Rol_Administrador
GRANT SELECT, INSERT, UPDATE, DELETE ON Estudiante TO Rol_Administrador; -- Gestión completa de estudiantes
GRANT SELECT, INSERT, UPDATE, DELETE ON Profesor TO Rol_Administrador; -- Gestión completa de profesores
GRANT SELECT, INSERT, UPDATE, DELETE ON Curso TO Rol_Administrador; -- Gestión completa de cursos
GRANT SELECT, INSERT, UPDATE, DELETE ON Inscripcion TO Rol_Administrador; -- Gestión completa de inscripciones
GRANT SELECT, INSERT, UPDATE, DELETE ON Evaluacion TO Rol_Administrador; -- Gestión completa de evaluaciones
GRANT SELECT, INSERT, UPDATE, DELETE ON Curso_Profesor TO Rol_Administrador; -- Gestión de asignación de profesores a cursos

-- Crear usuarios y asignar roles
-- Nota: Es necesario reemplazar los valores <nombre_usuario> y <contraseña> según los requisitos
CREATE LOGIN UsuarioEstudiante WITH PASSWORD = 'Estudiante123!';
CREATE USER UsuarioEstudiante FOR LOGIN UsuarioEstudiante;
ALTER ROLE Rol_Estudiante ADD MEMBER UsuarioEstudiante;

CREATE LOGIN UsuarioProfesor WITH PASSWORD = 'Profesor123!';
CREATE USER UsuarioProfesor FOR LOGIN UsuarioProfesor;
ALTER ROLE Rol_Profesor ADD MEMBER UsuarioProfesor;

CREATE LOGIN UsuarioAdministrador WITH PASSWORD = 'Admin123!';
CREATE USER UsuarioAdministrador FOR LOGIN UsuarioAdministrador;
ALTER ROLE Rol_Administrador ADD MEMBER UsuarioAdministrador;

-- Revisión de los roles asignados
SELECT r.name AS Rol, m.name AS Miembro
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id;





----------------------------------------------------------------------
--1. Procedimiento para Crear un Usuario y Asignarle el Rol de Estudiante
-- Procedimiento para Crear un Usuario y Asignarle el Rol de Estudiante
CREATE PROCEDURE CrearUsuarioEstudiante
  @NombreUsuario NVARCHAR(50),
  @Contrasena NVARCHAR(100),
  @Email NVARCHAR(150),
  @Telefono NVARCHAR(20),
  @Direccion NVARCHAR(MAX)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    -- Validar que el usuario no exista como login
    IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = @NombreUsuario)
    BEGIN
      THROW 50001, 'El nombre de usuario ya existe como LOGIN.', 1;
    END;

    -- Validar que el correo no esté duplicado
    IF EXISTS (SELECT 1 FROM Estudiante WHERE correo = @Email)
    BEGIN
      THROW 50002, 'El correo electrónico ya está registrado en la tabla Estudiante.', 1;
    END;

    -- Validar que el teléfono no esté duplicado
    IF EXISTS (SELECT 1 FROM Estudiante WHERE telefono = @Telefono)
    BEGIN
      THROW 50003, 'El número de teléfono ya está registrado en la tabla Estudiante.', 1;
    END;

    -- Crear el login y el usuario
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'CREATE LOGIN [' + @NombreUsuario + '] WITH PASSWORD = ''' + @Contrasena + ''', CHECK_POLICY = ON;';
    EXEC(@SQL);

    SET @SQL = 'CREATE USER [' + @NombreUsuario + '] FOR LOGIN [' + @NombreUsuario + ']; ALTER ROLE Estudiante ADD MEMBER [' + @NombreUsuario + '];';
    EXEC(@SQL);

    -- Insertar datos en la tabla Estudiante
    INSERT INTO Estudiante (nombre, correo, telefono, direccion)
    VALUES (@NombreUsuario, @Email, @Telefono, @Direccion);

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END;
/*
--Ejemplo
EXEC CrearUsuarioEstudiante
  @NombreUsuario = 'estudiante01',
  @Contrasena = 'Segura123!',
  @Email = 'estudiante01@techacademy.com',
  @Telefono = '987654321',
  @Direccion = 'Av. Siempre Viva 123';
*/


--2. Procedimiento para Crear un Usuario y Asignarle el Rol de Profesor
CREATE PROCEDURE CrearUsuarioProfesor
  @NombreUsuario NVARCHAR(50),
  @Contrasena NVARCHAR(100),
  @Email NVARCHAR(150),
  @Telefono NVARCHAR(20),
  @Direccion NVARCHAR(MAX),
  @DepartamentoId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    -- Validar que el usuario no exista como login
    IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = @NombreUsuario)
    BEGIN
      THROW 50001, 'El nombre de usuario ya existe como LOGIN.', 1;
    END;

    -- Validar que el correo no esté duplicado
    IF EXISTS (SELECT 1 FROM Profesor WHERE correo = @Email)
    BEGIN
      THROW 50002, 'El correo electrónico ya está registrado en la tabla Profesor.', 1;
    END;

    -- Validar que el teléfono no esté duplicado
    IF EXISTS (SELECT 1 FROM Profesor WHERE telefono = @Telefono)
    BEGIN
      THROW 50003, 'El número de teléfono ya está registrado en la tabla Profesor.', 1;
    END;

    -- Validar que el Departamento exista
    IF NOT EXISTS (SELECT 1 FROM Departamento WHERE departamento_id = @DepartamentoId)
    BEGIN
      THROW 50004, 'El Departamento especificado no existe.', 1;
    END;

    -- Crear el login y el usuario
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'CREATE LOGIN [' + @NombreUsuario + '] WITH PASSWORD = ''' + @Contrasena + ''', CHECK_POLICY = ON;';
    EXEC(@SQL);

    SET @SQL = 'CREATE USER [' + @NombreUsuario + '] FOR LOGIN [' + @NombreUsuario + ']; ALTER ROLE Profesor ADD MEMBER [' + @NombreUsuario + '];';
    EXEC(@SQL);

    -- Insertar datos en la tabla Profesor
    INSERT INTO Profesor (nombre, correo, telefono, direccion, departamento_id)
    VALUES (@NombreUsuario, @Email, @Telefono, @Direccion, @DepartamentoId);

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END;
/*
--Ejecución
EXEC CrearUsuarioProfesor
  @NombreUsuario = 'profesor01',
  @Contrasena = 'DocenteSeguro!',
  @Email = 'profesor01@techacademy.com',
  @Telefono = '987654322',
  @Direccion = 'Calle Principal 456',
  @DepartamentoId = 1;
*/


--3. Procedimiento para Crear un Usuario y Asignarle el Rol de Administrador
CREATE PROCEDURE CrearUsuarioAdministrador
  @NombreUsuario NVARCHAR(50),
  @Contrasena NVARCHAR(100),
  @Email NVARCHAR(150),
  @Telefono NVARCHAR(20),
  @Direccion NVARCHAR(MAX)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    -- Validar que el usuario no exista como login
    IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = @NombreUsuario)
    BEGIN
      THROW 50001, 'El nombre de usuario ya existe como LOGIN.', 1;
    END;

    -- Validar que el correo no esté duplicado
    IF EXISTS (
        SELECT 1 FROM Estudiante WHERE correo = @Email 
        UNION ALL
        SELECT 1 FROM Profesor WHERE correo = @Email
    )
    BEGIN
      THROW 50002, 'El correo electrónico ya está registrado.', 1;
    END;

    -- Validar que el teléfono no esté duplicado
    IF EXISTS (
        SELECT 1 FROM Estudiante WHERE telefono = @Telefono 
        UNION ALL
        SELECT 1 FROM Profesor WHERE telefono = @Telefono
    )
    BEGIN
      THROW 50003, 'El número de teléfono ya está registrado.', 1;
    END;

    -- Crear el login y el usuario
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'CREATE LOGIN [' + @NombreUsuario + '] WITH PASSWORD = ''' + @Contrasena + ''', CHECK_POLICY = ON;';
    EXEC(@SQL);

    SET @SQL = 'CREATE USER [' + @NombreUsuario + '] FOR LOGIN [' + @NombreUsuario + ']; ALTER ROLE Administrador ADD MEMBER [' + @NombreUsuario + '];';
    EXEC(@SQL);

    -- Opcional: Insertar datos en tabla de Administradores
    -- INSERT INTO Administrador (nombre, correo, telefono, direccion)
    -- VALUES (@NombreUsuario, @Email, @Telefono, @Direccion);

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END;
/*
--Ejecución
EXEC CrearUsuarioAdministrador
  @NombreUsuario = 'admin01',
  @Contrasena = 'AdminSeguro!',
  @Email = 'admin01@techacademy.com',
  @Telefono = '987654323',
  @Direccion = 'Av. Administración 789';
*/
