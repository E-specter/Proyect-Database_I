/*
Formato de identificadores:				snacke_case
	Base de datos						:				MAYÚSCULAS
	Tablas									:				Tabla_Tipo
	columna									:				columna_tipo

Nombres descriptivos:

Los nombres de tablas y columnas son intuitivos y representan claramente el propósito de cada entidad o atributo. Ejemplo: curso_id, fecha_evaluacion.
Consistencia en el formato:

Todo usa snake_case, sin mezclar estilos (como camelCase o PascalCase), lo que facilita la lectura y|mantenimiento del esquema.
Uso de claves primarias claras y únicas:

Todas las tablas tienen una columna *_id como clave primaria, que utiliza un tipo de datos entero (INT) con auto-incremento (IDENTITY).
Definición explícita de claves foráneas:

Las relaciones entre tablas están respaldadas por claves foráneas, que aseguran la integridad referencial.
Ejemplo: En Inscripcion, las columnas estudiante_id y curso_id están relacionadas con las tablas Estudiante y Curso, respectivamente.
Restricciones para datos válidos:

Restricciones como CHECK aseguran que los datos sean válidos, por ejemplo:
Los créditos de un curso deben ser mayores que 0.
La nota en Evaluacion está limitada a un rango de 0 a 100.
Estandarización en nombres:

Las columnas que representan claves primarias o foráneas usan la convención nombreTabla_id, indicando claramente su función y relación.
Integridad referencial:

Las relaciones entre tablas usan ON DELETE CASCADE para garantizar que los datos dependientes se eliminen automáticamente cuando su padre es eliminado, evitando registros huérfanos.
Uso de tipos de datos apropiados:

INT: Para identificadores y relaciones clave.
NVARCHAR: Para textos como nombres y correos electrónicos, permitiendo soporte para múltiples idiomas.
DECIMAL: Para notas, con precisión y rango controlado.

Columnas obligatorias y valores predeterminados:
Las columnas críticas tienen restricciones NOT NULL y valores predeterminados cuando aplica, por ejemplo, fecha_inscripcion y fecha_evaluacion.
*/

-- Crear la base de datos TECHACADEMY
CREATE DATABASE TECHACADEMY;
GO

-- Cambiar al contexto de la base de datos TECHACADEMY
USE TECHACADEMY;
GO

-- Tabla para Estudiantes
CREATE TABLE Estudiante (
  estudiante_id INT IDENTITY PRIMARY KEY,
  id_nacional CHAR(9) NOT NULL UNIQUE, -- DNI
  nombre NVARCHAR(100) NOT NULL,
  apellidos NVARCHAR(100) NOT NULL,
  correo NVARCHAR(150) UNIQUE NOT NULL,
  telefono NVARCHAR(20),
  direccion NVARCHAR(MAX)
);

-- Tabla de Departamentos
CREATE TABLE Departamento (
  departamento_id INT IDENTITY PRIMARY KEY,
  nombre NVARCHAR(100) NOT NULL UNIQUE,
  descripcion NVARCHAR(255)
);

-- Tabla para Profesores
CREATE TABLE Profesor (
  profesor_id INT IDENTITY PRIMARY KEY,
  id_nacional VARCHAR(12) NOT NULL UNIQUE, -- DNI
  nombre NVARCHAR(100) NOT NULL,
  apellidos NVARCHAR(100) NOT NULL,
  departamento_id INT NULL, -- Permite NULL para cumplir con ON DELETE SET NULL
  correo NVARCHAR(150) UNIQUE NOT NULL,
  telefono VARCHAR(9) UNIQUE NOT NULL,
  direccion NVARCHAR(MAX),
  FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id) ON DELETE SET NULL
);

-- Tabla para Cursos
CREATE TABLE Curso (
  curso_id INT IDENTITY PRIMARY KEY,
  nombre NVARCHAR(150) NOT NULL,
  creditos INT NOT NULL CHECK (creditos > 0)
);

-- Tabla para Prerequisitos de Cursos
CREATE TABLE Prerequisito (
  curso_id INT NOT NULL,
  prerequisito_id INT NOT NULL,
  PRIMARY KEY (curso_id, prerequisito_id),
  FOREIGN KEY (curso_id) REFERENCES Curso(curso_id) ON DELETE NO ACTION,
  FOREIGN KEY (prerequisito_id) REFERENCES Curso(curso_id) ON DELETE NO ACTION
);

-- Tabla para asignación de Profesores a Cursos (1:1 ajustado con restricción única)
CREATE TABLE Curso_Profesor (
  curso_profesor_id INT IDENTITY PRIMARY KEY,
  curso_id INT NOT NULL UNIQUE, -- Garantiza que un curso solo puede estar asociado con un profesor
  profesor_id INT NOT NULL,
  FOREIGN KEY (curso_id) REFERENCES Curso(curso_id) ON DELETE CASCADE,
  FOREIGN KEY (profesor_id) REFERENCES Profesor(profesor_id) ON DELETE CASCADE
);

-- Tabla para Inscripciones
CREATE TABLE Inscripcion (
  inscripcion_id INT IDENTITY PRIMARY KEY,
  fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
  estudiante_id INT NOT NULL,
  curso_profesor_id INT NOT NULL,
  FOREIGN KEY (estudiante_id) REFERENCES Estudiante(estudiante_id) ON DELETE CASCADE,
  FOREIGN KEY (curso_profesor_id) REFERENCES Curso_Profesor(curso_profesor_id) ON DELETE CASCADE
);

-- Tabla para Evaluaciones
CREATE TABLE Evaluacion (
  evaluacion_id INT IDENTITY PRIMARY KEY,
  nota DECIMAL(5, 2) CHECK (nota BETWEEN 0 AND 20),
  fecha_evaluacion DATE NOT NULL DEFAULT GETDATE(),
  estudiante_id INT NOT NULL,
  curso_profesor_id INT NOT NULL,
  FOREIGN KEY (estudiante_id) REFERENCES Estudiante(estudiante_id) ON DELETE CASCADE,
  FOREIGN KEY (curso_profesor_id) REFERENCES Curso_Profesor(curso_profesor_id) ON DELETE CASCADE
);



















USE master;
GO
DROP DATABASE TECHACADEMY;
GO


