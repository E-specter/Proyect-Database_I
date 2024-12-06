/*
PROCEDIMIENTOS Y FUNCIONES PARA ADMINISTRADOR
*/
USE TECHACADEMY;
GO

/*
1. Ver Todos los Estudiantes
Procedimiento Almacenado: Permite al administrador consultar la lista de todos los estudiantes.
*/
CREATE PROCEDURE VerTodosLosEstudiantes
AS
BEGIN
  SELECT 
    estudiante_id,
    id_nacional,
    nombre,
    apellidos,
    correo,
    telefono,
    direccion
  FROM Estudiante;
END;

--Ejemplo: EXEC VerTodosLosEstudiantes;

/*
2. Ver Todos los Profesores
Procedimiento Almacenado: Permite al administrador consultar la lista de todos los profesores.
*/
CREATE PROCEDURE VerTodosLosProfesores
AS
BEGIN
  SELECT 
    profesor_id,
    id_nacional,
    nombre,
    apellidos,
    departamento_id,
    correo,
    telefono,
    direccion
  FROM Profesor;
END;

--Ejemplo: EXEC VerTodosLosProfesores;

/*
3. Ver Todos los Cursos
Procedimiento Almacenado: Permite al administrador consultar la lista de todos los cursos registrados.
*/
CREATE PROCEDURE VerTodosLosCursos
AS
BEGIN
  SELECT 
    curso_id,
    nombre,
    creditos
  FROM Curso;
END;

--Ejemplo: EXEC VerTodosLosCursos;

/*
4. Agregar un Nuevo Estudiante
Procedimiento Almacenado: Permite al administrador agregar un nuevo estudiante.
*/
CREATE PROCEDURE AgregarEstudiante 
  @IdNacional CHAR(9),
  @Nombre NVARCHAR(100),
  @Apellidos NVARCHAR(100),
  @Correo NVARCHAR(150),
  @Telefono NVARCHAR(20),
  @Direccion NVARCHAR(MAX)
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    -- Verificar si ya existe un estudiante con los mismos datos
    IF NOT EXISTS (
      SELECT 1 
      FROM Estudiante
      WHERE id_nacional = @IdNacional OR correo = @Correo
    )
    BEGIN
      INSERT INTO Estudiante (id_nacional, nombre, apellidos, correo, telefono, direccion)
      VALUES (@IdNacional, @Nombre, @Apellidos, @Correo, @Telefono, @Direccion);

      COMMIT TRANSACTION;
      PRINT 'Estudiante agregado correctamente.';
    END
    ELSE
    BEGIN
      ROLLBACK TRANSACTION;
      PRINT 'Error: Ya existe un estudiante con los mismos datos (ID Nacional o Correo).';
    END
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al agregar el estudiante.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;


--Ejemplo: EXEC AgregarEstudiante '123456789', 'Juan', 'Perez', 'juan.perez@ejemplo.com', '987654321', 'Calle Falsa 123', 'Ingeniería';

/*
5. Modificar Datos de un Estudiante
Procedimiento Almacenado: Permite al administrador modificar los datos de un estudiante.
*/
CREATE PROCEDURE ModificarEstudiante 
  @EstudianteId INT,
  @Nombre NVARCHAR(100),
  @Apellidos NVARCHAR(100),
  @Correo NVARCHAR(150),
  @Telefono NVARCHAR(20),
  @Direccion NVARCHAR(MAX)
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    -- Verificar que el correo no esté en uso por otro estudiante
    IF NOT EXISTS (
      SELECT 1 
      FROM Estudiante
      WHERE correo = @Correo AND estudiante_id != @EstudianteId
    )
    BEGIN
      UPDATE Estudiante
      SET 
        nombre = @Nombre,
        apellidos = @Apellidos,
        correo = @Correo,
        telefono = @Telefono,
        direccion = @Direccion
      WHERE estudiante_id = @EstudianteId;

      COMMIT TRANSACTION;
      PRINT 'Estudiante actualizado correctamente.';
    END
    ELSE
    BEGIN
      ROLLBACK TRANSACTION;
      PRINT 'Error: El correo ya está en uso por otro estudiante.';
    END
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al modificar el estudiante.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;



--Ejemplo: EXEC ModificarEstudiante 1, 'Carlos', 'Gomez', 'carlos.gomez@ejemplo.com', '123456789', 'Avenida Siempre Viva 456', 'Arquitectura';

/*
6. Eliminar un Estudiante
Procedimiento Almacenado: Permite al administrador eliminar un estudiante de la base de datos.
*/
CREATE PROCEDURE EliminarEstudiante 
  @EstudianteId INT
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    -- Verificar si el estudiante existe
    IF EXISTS (
      SELECT 1 
      FROM Estudiante
      WHERE estudiante_id = @EstudianteId
    )
    BEGIN
      -- Verificar si hay registros relacionados en otras tablas (ejemplo: Inscripciones)
      IF NOT EXISTS (
        SELECT 1 
        FROM Inscripcion
        WHERE estudiante_id = @EstudianteId
      )
      BEGIN
        DELETE FROM Estudiante
        WHERE estudiante_id = @EstudianteId;

        COMMIT TRANSACTION;
        PRINT 'Estudiante eliminado correctamente.';
      END
      ELSE
      BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Error: No se puede eliminar el estudiante porque tiene inscripciones asociadas.';
      END
    END
    ELSE
    BEGIN
      ROLLBACK TRANSACTION;
      PRINT 'Error: El estudiante con el ID especificado no existe.';
    END
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al eliminar el estudiante.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;

--Ejemplo: EXEC EliminarEstudiante 1;




--------------------------------------------------------------------------------------------------------

/*
7. Agregar un Nuevo Curso
Procedimiento Almacenado: Permite al administrador agregar un nuevo curso.
*/
CREATE PROCEDURE AgregarCurso 
  @Nombre NVARCHAR(150),
  @Creditos INT
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    -- Verificar si ya existe un curso con el mismo nombre
    IF EXISTS (
      SELECT 1
      FROM Curso
      WHERE nombre = @Nombre
    )
    BEGIN
      PRINT 'Error: Ya existe un curso con el nombre especificado.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Validación de los créditos (ejemplo: debe ser un valor positivo)
    IF @Creditos <= 0
    BEGIN
      PRINT 'Error: Los créditos deben ser un valor positivo.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Insertar el nuevo curso
    INSERT INTO Curso (nombre, creditos)
    VALUES (@Nombre, @Creditos);

    COMMIT TRANSACTION;
    PRINT 'Curso agregado correctamente.';
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al agregar el curso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;


--Ejemplo: EXEC AgregarCurso 'Matemáticas Avanzadas', 4;

/*
8. Modificar Datos de un Curso
Procedimiento Almacenado: Permite al administrador modificar los datos de un curso.
*/
CREATE PROCEDURE ModificarCurso 
  @CursoId INT,
  @Nombre NVARCHAR(150),
  @Creditos INT
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    -- Verificar si el curso con el ID especificado existe
    IF NOT EXISTS (
      SELECT 1
      FROM Curso
      WHERE curso_id = @CursoId
    )
    BEGIN
      PRINT 'Error: El curso con el ID especificado no existe.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Verificar si ya existe un curso con el mismo nombre (excluyendo el curso actual)
    IF EXISTS (
      SELECT 1
      FROM Curso
      WHERE nombre = @Nombre AND curso_id != @CursoId
    )
    BEGIN
      PRINT 'Error: Ya existe un curso con el mismo nombre.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Validación de los créditos (ejemplo: debe ser un valor positivo)
    IF @Creditos <= 0
    BEGIN
      PRINT 'Error: Los créditos deben ser un valor positivo.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Actualizar el curso
    UPDATE Curso
    SET 
      nombre = @Nombre,
      creditos = @Creditos
    WHERE curso_id = @CursoId;

    COMMIT TRANSACTION;
    PRINT 'Curso modificado correctamente.';
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al modificar el curso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;


--Ejemplo: EXEC ModificarCurso 1, 'Matemáticas Básicas', 3;

/*
9. Eliminar un Curso
Procedimiento Almacenado: Permite al administrador eliminar un curso.
*/
CREATE PROCEDURE EliminarCurso 
  @CursoId INT
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    -- Verificar si el curso con el ID especificado existe
    IF NOT EXISTS (
      SELECT 1
      FROM Curso
      WHERE curso_id = @CursoId
    )
    BEGIN
      PRINT 'Error: El curso con el ID especificado no existe.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Verificar si el curso está asociado con algún estudiante o profesor
    IF EXISTS (
      SELECT 1
      FROM Curso_Estudiante
      WHERE curso_id = @CursoId
    )
    BEGIN
      PRINT 'Error: No se puede eliminar el curso porque está asociado a uno o más estudiantes.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    IF EXISTS (
      SELECT 1
      FROM Curso_Profesor
      WHERE curso_id = @CursoId
    )
    BEGIN
      PRINT 'Error: No se puede eliminar el curso porque está asociado a uno o más profesores.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Proceder con la eliminación del curso
    DELETE FROM Curso
    WHERE curso_id = @CursoId;

    COMMIT TRANSACTION;
    PRINT 'Curso eliminado correctamente.';
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al eliminar el curso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;



--Ejemplo: EXEC EliminarCurso 1;

/*
10. Asignar o Modificar Permisos a Usuarios
Procedimiento Almacenado: Permite al administrador asignar permisos a roles específicos.
*/
CREATE PROCEDURE AsignarPermisoUsuario 
  @Usuario NVARCHAR(100),
  @Permiso NVARCHAR(100)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @SQL NVARCHAR(1000);
    SET @SQL = 'GRANT ' + QUOTENAME(@Permiso) + ' TO ' + QUOTENAME(@Usuario);
    EXEC sp_executesql @SQL;

    COMMIT TRANSACTION;
    PRINT 'Permiso asignado correctamente.';
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al asignar el permiso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;


--Ejemplo: EXEC AsignarPermisoUsuario 'usuario1', 'SELECT';
















-------------------------------------------------------------------------------------------------------------

/*
11. Crear un Backup de la Base de Datos
Procedimiento Almacenado: Permite al administrador realizar un respaldo de la base de datos.
*/
CREATE PROCEDURE CrearBackupBaseDatos 
  @RutaBackup NVARCHAR(255)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    -- Verificar si la ruta de respaldo es válida y tiene permisos adecuados
    IF @RutaBackup IS NULL OR @RutaBackup = '' 
    BEGIN
      PRINT 'Error: La ruta de respaldo no puede estar vacía.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Ejecutar el comando de respaldo
    DECLARE @SQL NVARCHAR(1000);
    SET @SQL = 'BACKUP DATABASE TECHACADEMY TO DISK = @RutaBackup WITH FORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, STATS = 10';

    EXEC sp_executesql @SQL, N'@RutaBackup NVARCHAR(255)', @RutaBackup;

    COMMIT TRANSACTION;
    PRINT 'Respaldo de la base de datos realizado con éxito.';
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al realizar el respaldo de la base de datos.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;



--Ejemplo: EXEC CrearBackupBaseDatos 'C:\Backups\TechAcademy.bak';

/*
12. Restaurar la Base de Datos
Procedimiento Almacenado: Permite al administrador restaurar la base de datos desde un archivo de respaldo.
*/
CREATE PROCEDURE RestaurarBaseDatos 
  @RutaBackup NVARCHAR(255)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    -- Verificar si la ruta de respaldo es válida
    IF @RutaBackup IS NULL OR @RutaBackup = ''
    BEGIN
      PRINT 'Error: La ruta de respaldo no puede estar vacía.';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Verificar si la base de datos ya existe y manejar la restauración
    DECLARE @DBExists INT;
    SELECT @DBExists = COUNT(*)
    FROM sys.databases
    WHERE name = 'TECHACADEMY';

    IF @DBExists = 1
    BEGIN
      PRINT 'Error: La base de datos TECHACADEMY ya existe. Se requiere un proceso de restauración con reemplazo (REPLACE).';
      ROLLBACK TRANSACTION;
      RETURN;
    END

    -- Comando de restauración
    DECLARE @SQL NVARCHAR(1000);
    SET @SQL = 'RESTORE DATABASE TECHACADEMY FROM DISK = @RutaBackup WITH REPLACE, STATS = 10';

    EXEC sp_executesql @SQL, N'@RutaBackup NVARCHAR(255)', @RutaBackup;

    COMMIT TRANSACTION;
    PRINT 'Restauración de la base de datos realizada con éxito.';
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al realizar la restauración de la base de datos.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;



--Ejemplo: EXEC RestaurarBaseDatos 'C:\Backups\TechAcademy.bak';




