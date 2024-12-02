/*
Formato de identificadores:				snacke_case
	Base de datos						:				MAY�SCULAS
	Tablas									:				Tabla_Tipo
	columna									:				columna_tipo

Nombres descriptivos:

Los nombres de tablas y columnas son intuitivos y representan claramente el prop�sito de cada entidad o atributo. Ejemplo: curso_id, fecha_evaluacion.
Consistencia en el formato:

Todo usa snake_case, sin mezclar estilos (como camelCase o PascalCase), lo que facilita la lectura y|mantenimiento del esquema.
Uso de claves primarias claras y �nicas:

Todas las tablas tienen una columna *_id como clave primaria, que utiliza un tipo de datos entero (INT) con auto-incremento (IDENTITY).
Definici�n expl�cita de claves for�neas:

Las relaciones entre tablas est�n respaldadas por claves for�neas, que aseguran la integridad referencial.
Ejemplo: En Inscripcion, las columnas estudiante_id y curso_id est�n relacionadas con las tablas Estudiante y Curso, respectivamente.
Restricciones para datos v�lidos:

Restricciones como CHECK aseguran que los datos sean v�lidos, por ejemplo:
Los cr�ditos de un curso deben ser mayores que 0.
La nota en Evaluacion est� limitada a un rango de 0 a 100.
Estandarizaci�n en nombres:

Las columnas que representan claves primarias o for�neas usan la convenci�n nombreTabla_id, indicando claramente su funci�n y relaci�n.
Integridad referencial:

Las relaciones entre tablas usan ON DELETE CASCADE para garantizar que los datos dependientes se eliminen autom�ticamente cuando su padre es eliminado, evitando registros hu�rfanos.
Uso de tipos de datos apropiados:

INT: Para identificadores y relaciones clave.
NVARCHAR: Para textos como nombres y correos electr�nicos, permitiendo soporte para m�ltiples idiomas.
DECIMAL: Para notas, con precisi�n y rango controlado.

Columnas obligatorias y valores predeterminados:
Las columnas cr�ticas tienen restricciones NOT NULL y valores predeterminados cuando aplica, por ejemplo, fecha_inscripcion y fecha_evaluacion.
*/


CREATE DATABASE TECHACADEMY;
GO
USE TECHACADEMY;

-- Tabla para Estudiantes
CREATE TABLE Estudiante (
    estudiante_id INT IDENTITY PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) UNIQUE NOT NULL,
    telefono NVARCHAR(20)
);

-- Tabla para Profesores
CREATE TABLE Profesor (
    profesor_id INT IDENTITY PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    departamento NVARCHAR(100),
    email NVARCHAR(150) UNIQUE NOT NULL
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
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisito_id) REFERENCES Curso(curso_id) ON DELETE CASCADE
);

-- Tabla para Inscripciones
CREATE TABLE Inscripcion (
    inscripcion_id INT IDENTITY PRIMARY KEY,
    fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    FOREIGN KEY (estudiante_id) REFERENCES Estudiante(estudiante_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id) ON DELETE CASCADE
);

-- Tabla para Evaluaciones
CREATE TABLE Evaluacion (
    evaluacion_id INT IDENTITY PRIMARY KEY,
    nota DECIMAL(5, 2) CHECK (nota BETWEEN 0 AND 100),
    fecha_evaluacion DATE NOT NULL DEFAULT GETDATE(),
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    FOREIGN KEY (estudiante_id) REFERENCES Estudiante(estudiante_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id) ON DELETE CASCADE
);

-- Tabla para asignaci�n de Profesores a Cursos
CREATE TABLE Curso_Profesor (
    curso_profesor_id INT IDENTITY PRIMARY KEY,
    curso_id INT NOT NULL,
    profesor_id INT NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id) ON DELETE CASCADE,
    FOREIGN KEY (profesor_id) REFERENCES Profesor(profesor_id) ON DELETE CASCADE
);