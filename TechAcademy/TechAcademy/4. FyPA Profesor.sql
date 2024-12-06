/*
PROCEDIMIENTOS Y FUNCIONES PARA Profesor
*/

/*
1. Ver Datos Personales del Profesor
Procedimiento Almacenado: Permite a un profesor consultar sus propios datos personales usando su id_nacional.
*/
CREATE PROCEDURE VerDatosPersonalesProfesor 
  @IdNacional VARCHAR(12)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      profesor_id,
      id_nacional,
      nombre,
      apellidos,
      departamento_id,
      correo,
      telefono,
      direccion
    FROM Profesor
    WHERE id_nacional = @IdNacional;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar los datos personales del profesor.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;

/*
--Ejemplo
EXEC VerDatosPersonalesProfesor @IdNacional = '123456789';
*/

/*
2. Ver Cursos Asignados al Profesor
Procedimiento Almacenado: Permite a un profesor consultar los cursos que imparte.
*/
CREATE PROCEDURE VerCursosAsignados 
  @ProfesorId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      C.curso_id,
      C.nombre AS Curso,
      C.creditos
    FROM Curso C
    INNER JOIN Curso_Profesor CP ON C.curso_id = CP.curso_id
    WHERE CP.profesor_id = @ProfesorId;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar los cursos asignados al profesor.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;

/*
--Ejemplo
EXEC VerCursosAsignados @ProfesorId = 1;
*/

/*
3. Asignar Calificación a un Estudiante
Procedimiento Almacenado: Permite a un profesor asignar o actualizar la calificación de un estudiante en un curso específico.
*/
CREATE PROCEDURE AsignarCalificacion 
  @EstudianteId INT,
  @CursoId INT,
  @Nota DECIMAL(5, 2)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    IF EXISTS (
      SELECT 1
      FROM Evaluacion
      WHERE estudiante_id = @EstudianteId AND curso_profesor_id = @CursoId
    )
    BEGIN
      UPDATE Evaluacion
      SET nota = @Nota, fecha_evaluacion = GETDATE()
      WHERE estudiante_id = @EstudianteId AND curso_profesor_id = @CursoId;
    END
    ELSE
    BEGIN
      INSERT INTO Evaluacion (nota, fecha_evaluacion, estudiante_id, curso_profesor_id)
      VALUES (@Nota, GETDATE(), @EstudianteId, @CursoId);
    END

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al asignar la calificación al estudiante.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;

/*
--Ejemplo
EXEC AsignarCalificacion @EstudianteId = 2, @CursoId = 3, @Nota = 90.50;
*/

/*
4. Ver Evaluaciones de un Curso
Procedimiento Almacenado: Permite a un profesor consultar todas las evaluaciones de un curso en particular.
*/
CREATE PROCEDURE VerEvaluacionesCurso 
  @CursoId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      E.evaluacion_id,
      E.estudiante_id,
      E.nota,
      E.fecha_evaluacion
    FROM Evaluacion E
    WHERE E.curso_profesor_id = @CursoId;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar las evaluaciones del curso.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;

/*
--Ejemplo
EXEC VerEvaluacionesCurso @CursoId = 3;
*/

/*
5. Ver Informe de Rendimiento de Estudiantes
Procedimiento Almacenado: Permite al profesor obtener un informe de rendimiento de los estudiantes en un curso específico.
*/
CREATE PROCEDURE VerInformeRendimientoEstudiantes 
  @CursoId INT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION;

    SELECT 
      E.estudiante_id,
      S.nombre + ' ' + S.apellidos AS Estudiante,
      AVG(E.nota) AS PromedioNotas
    FROM Evaluacion E
    INNER JOIN Estudiante S ON E.estudiante_id = S.estudiante_id
    WHERE E.curso_profesor_id = @CursoId
    GROUP BY E.estudiante_id, S.nombre, S.apellidos
    ORDER BY PromedioNotas DESC;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al consultar el informe de rendimiento de los estudiantes.';
    PRINT ERROR_MESSAGE();
  END CATCH
END;

/*
--Ejemplo
EXEC VerInformeRendimientoEstudiantes @CursoId = 3;
*/

/*
6. Contar Estudiantes Inscritos en un Curso
Función Escalar: Devuelve el número de estudiantes inscritos en un curso específico.
*/
CREATE FUNCTION ContarEstudiantesCurso (@CursoId INT)
RETURNS INT
AS
BEGIN
  DECLARE @Cantidad INT;

  -- Contar el número de estudiantes inscritos en el curso
  SELECT @Cantidad = COUNT(*)
  FROM Inscripcion
  WHERE curso_profesor_id = @CursoId;

  -- Devolver la cantidad
  RETURN @Cantidad;
END;

/*
--Ejemplo
SELECT dbo.ContarEstudiantesCurso(3);
*/

/*
7. Calcular Promedio de Notas por Curso
Función Escalar: Calcula el promedio de notas de todos los estudiantes en un curso específico.
*/
CREATE FUNCTION PromedioNotasCurso (@CursoId INT)
RETURNS DECIMAL(5, 2)
AS
BEGIN
  DECLARE @Promedio DECIMAL(5, 2);

  -- Calcular el promedio de notas del curso
  SELECT @Promedio = AVG(nota)
  FROM Evaluacion
  WHERE curso_profesor_id = @CursoId;

  -- Devolver el promedio
  RETURN @Promedio;
END;


/*
--Ejemplo
SELECT dbo.PromedioNotasCurso(3);
*/
