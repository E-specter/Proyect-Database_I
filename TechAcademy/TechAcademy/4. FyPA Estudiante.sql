/*
PROCEDIMIENTOS Y FUNCIONES PARA ESTUDIANTES
*/

/*
1. Ver Datos Personales del Estudiante
Procedimiento Almacenado: Permite a un estudiante consultar sus datos personales usando su id_nacional.
*/
CREATE PROCEDURE VerDatosPersonalesEstudiante 
  @IdNacional CHAR(9)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      estudiante_id,
      id_nacional,
      nombre,
      apellidos,
      correo,
      telefono,
      direccion
    FROM Estudiante
    WHERE id_nacional = @IdNacional;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar los datos personales del estudiante.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;
/*
--Ejemplo
EXEC VerDatosPersonalesEstudiante @IdNacional = '123456789';
*/

/*
2. Ver Cursos Disponibles
Procedimiento Almacenado: Permite listar todos los cursos disponibles.
*/
CREATE PROCEDURE VerCursosDisponibles
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      curso_id,
      nombre AS Curso,
      creditos
    FROM Curso;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar los cursos disponibles.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;
/*
--Ejemplo
EXEC VerCursosDisponibles;
*/

/*
3. Inscribirse en un Curso
Procedimiento Almacenado: Permite registrar una inscripción.
*/
CREATE PROCEDURE InscribirCurso 
  @EstudianteId INT,
  @CursoId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    -- Verificar si la inscripción ya existe
    IF EXISTS (
      SELECT 1
      FROM Inscripcion
      WHERE estudiante_id = @EstudianteId AND curso_profesor_id = @CursoId
    )
    BEGIN
      PRINT 'Error: El estudiante ya está inscrito en el curso especificado.';
      RETURN;
    END

    INSERT INTO Inscripcion (estudiante_id, curso_profesor_id, fecha_inscripcion)
    VALUES (@EstudianteId, @CursoId, GETDATE());

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al inscribir al estudiante en el curso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;
/*
--Ejemplo
EXEC InscribirCurso @EstudianteId = 1, @CursoId = 3;
*/

/*
4. Ver Inscripciones Actuales
Procedimiento Almacenado: Devuelve los cursos en los que está inscrito un estudiante.
*/
CREATE PROCEDURE VerInscripcionesEstudiante 
  @EstudianteId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      I.inscripcion_id,
      C.nombre AS Curso,
      C.creditos,
      I.fecha_inscripcion
    FROM Inscripcion I
    INNER JOIN Curso C ON I.curso_profesor_id = C.curso_id
    WHERE I.estudiante_id = @EstudianteId;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar las inscripciones del estudiante.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;
/*
--Ejemplo
EXEC VerInscripcionesEstudiante @EstudianteId = 1;
*/

/*
5. Consultar Notas por Curso
Procedimiento Almacenado: Permite consultar las notas de un estudiante en un curso.
*/
CREATE PROCEDURE VerNotasPorCurso 
  @EstudianteId INT,
  @CursoId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      E.evaluacion_id,
      E.nota,
      E.fecha_evaluacion
    FROM Evaluacion E
    WHERE E.estudiante_id = @EstudianteId AND E.curso_profesor_id = @CursoId;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar las notas del estudiante en el curso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;
/*
--Ejemplo
EXEC VerNotasPorCurso @EstudianteId = 1, @CursoId = 3;
*/

/*
6. Contar el Número de Inscripciones del Estudiante
Función Escalar: Devuelve el número de inscripciones activas del estudiante.
*/
CREATE FUNCTION ContarInscripciones (@EstudianteId INT)
RETURNS INT
AS
BEGIN
  DECLARE @Cantidad INT;

  -- Intentar contar las inscripciones
  SELECT @Cantidad = COUNT(*)
  FROM Inscripcion
  WHERE estudiante_id = @EstudianteId;

  -- Devolver la cantidad
  RETURN @Cantidad;
END;


/*
--Ejemplo
SELECT dbo.ContarInscripciones(1);
*/

/*
7. Obtener el Promedio de Notas
Función Escalar: Calcula el promedio de notas de un estudiante.
*/
CREATE FUNCTION PromedioNotas (@EstudianteId INT)
RETURNS DECIMAL(5, 2)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @Promedio DECIMAL(5, 2);

    SELECT @Promedio = AVG(nota)
    FROM Evaluacion
    WHERE estudiante_id = @EstudianteId;

    COMMIT TRANSACTION;
    RETURN @Promedio;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al calcular el promedio de notas del estudiante.';
    PRINT ERROR_MESSAGE();
    RETURN NULL; -- Retorno en caso de error
  END CATCH
END;

/*
--Ejemplo
SELECT dbo.PromedioNotas(1);
*/
