-- Insertar más datos en la tabla Departamento
INSERT INTO Departamento (nombre, descripcion) VALUES
('Ingeniería de Sistemas', 'Departamento encargado de la formación en tecnología de la información'),
('Ciencias de la Computación', 'Departamento enfocado en algoritmos y estructuras de datos'),
('Administración de Empresas', 'Departamento que gestiona la formación en técnicas administrativas'),
('Matemáticas y Estadística', 'Departamento especializado en métodos cuantitativos y análisis de datos'),
('Ciencias Sociales', 'Departamento dedicado al estudio de la sociedad y comportamiento humano'),
('Diseño Gráfico', 'Departamento que enseña técnicas de diseño y creatividad visual');

-- Insertar más datos en la tabla Estudiante
INSERT INTO Estudiante (id_nacional, nombre, apellidos, correo, telefono, direccion) VALUES
('123456789', 'Ana', 'González', 'ana.gonzalez@techacademy.edu', '987654321', 'Calle de la Tecnología, Lima'),
('987654321', 'Carlos', 'Morales', 'carlos.morales@techacademy.edu', '123456789', 'Avenida de la Innovación, Lima'),
('456789123', 'Lucía', 'Pérez', 'lucia.perez@techacademy.edu', '321654987', 'Calle del Conocimiento, Lima'),
('159753852', 'Jorge', 'López', 'jorge.lopez@techacademy.edu', '753159456', 'Avenida del Progreso, Lima'),
('852456789', 'Marta', 'Torres', 'marta.torres@techacademy.edu', '654987321', 'Calle de la Sabiduría, Lima'),
('456123789', 'Diego', 'Hernández', 'diego.hernandez@techacademy.edu', '987321654', 'Calle de la Innovación, Lima'),
('789456123', 'Isabela', 'Soto', 'isabela.soto@techacademy.edu', '321987654', 'Calle de la Cultura, Lima'),
('321654987', 'Fernando', 'Ramírez', 'fernando.ramirez@techacademy.edu', '654123987', 'Calle de la Ciencia, Lima'),
('654987123', 'Claudia', 'Vega', 'claudia.vega@techacademy.edu', '987123654', 'Calle de la Educación, Lima'),
('963852741', 'Manuel', 'Álvarez', 'manuel.alvarez@techacademy.edu', '852741963', 'Calle de la Cultura, Lima');

-- Insertar más datos en la tabla Profesor
INSERT INTO Profesor (id_nacional, nombre, apellidos, departamento_id, correo, telefono, direccion) VALUES
('111223333', 'Javier', 'Rodríguez', 1, 'javier.rodriguez@techacademy.edu', '456789123', 'Edificio A, Lima'),
('444556666', 'Sofía', 'Martínez', 2, 'sofia.martinez@techacademy.edu', '789123456', 'Edificio B, Lima'),
('777889000', 'Miguel', 'Gómez', 3, 'miguel.gomez@techacademy.edu', '123789456', 'Edificio C, Lima'),
('333111222', 'Laura', 'Vásquez', 4, 'laura.vasquez@techacademy.edu', '321654987', 'Edificio D, Lima'),
('555888999', 'Héctor', 'Jiménez', 1, 'hector.jimenez@techacademy.edu', '987654321', 'Edificio E, Lima'),
('222333444', 'Martina', 'Lopez', 5, 'martina.lopez@techacademy.edu', '654321987', 'Edificio F, Lima'),
('666777888', 'José', 'García', 6, 'jose.garcia@techacademy.edu', '321789654', 'Edificio G, Lima');

-- Insertar más datos en la tabla Curso
INSERT INTO Curso (nombre, creditos) VALUES
('Programación en Python', 3),
('Estructuras de Datos', 4),
('Gestión Empresarial', 3),
('Algoritmos Avanzados', 3),
('Fundamentos de Matemáticas', 2),
('Estadística Aplicada', 3),
('Análisis de Sistemas', 4),
('Administración de Proyectos', 3),
('Bases de Datos Avanzadas', 4),
('Teoría de Grafos', 3),
('Cálculo Diferencial', 2),
('Introducción a la Psicología', 3),
('Principios de Diseño Gráfico', 3);

-- Insertar más datos en la tabla Prerequisito
INSERT INTO Prerequisito (curso_id, prerequisito_id) VALUES
(2, 1),  -- Estructuras de Datos depende de Programación en Python
(4, 2),  -- Algoritmos Avanzados depende de Estructuras de Datos
(7, 6),  -- Análisis de Sistemas depende de Estadística Aplicada
(8, 3),  -- Administración de Proyectos depende de Gestión Empresarial
(9, 2),  -- Bases de Datos Avanzadas depende de Estructuras de Datos
(10, 5), -- Teoría de Grafos depende de Fundamentos de Matemáticas
(11, 5), -- Cálculo Diferencial depende de Fundamentos de Matemáticas
(12, 13); -- Introducción a la Psicología es un prerequisito para Principios de Diseño Gráfico

-- Insertar más datos en la tabla Curso_Profesor
INSERT INTO Curso_Profesor (curso_id, profesor_id) VALUES
(1, 1),  -- Programación en Python asignada a Javier Rodríguez
(2, 2),  -- Estructuras de Datos asignada a Sofía Martínez
(3, 3),  -- Gestión Empresarial asignada a Miguel Gómez
(4, 1),  -- Algoritmos Avanzados asignada a Javier Rodríguez
(5, 5),  -- Fundamentos de Matemáticas asignada a Héctor Jiménez
(6, 4),  -- Estadística Aplicada asignada a Laura Vásquez
(7, 2),  -- Análisis de Sistemas asignada a Sofía Martínez
(8, 3),  -- Administración de Proyectos asignada a Miguel Gómez
(9, 5),  -- Bases de Datos Avanzadas asignada a Héctor Jiménez
(10, 6), -- Teoría de Grafos asignada a José García
(11, 5), -- Cálculo Diferencial asignada a Héctor Jiménez
(12, 7); -- Principios de Diseño Gráfico asignada a José García

-- Insertar más datos en la tabla Inscripcion
INSERT INTO Inscripcion (estudiante_id, curso_profesor_id) VALUES
(1, 1),  -- Ana González inscrita en Programación en Python
(1, 2),  -- Ana González inscrita en Estructuras de Datos
(2, 2),  -- Carlos Morales inscrito en Estructuras de Datos
(3, 3),  -- Lucía Pérez inscrita en Gestión Empresarial
(4, 4),  -- Jorge López inscrito en Algoritmos Avanzados
(5, 5),  -- Marta Torres inscrita en Fundamentos de Matemáticas
(6, 6),  -- Diego Hernández inscrito en Estadística Aplicada
(7, 7),  -- Isabela Soto inscrita en Análisis de Sistemas
(8, 8),  -- Fernando Ramírez inscrito en Administración de Proyectos
(9, 9),  -- Claudia Vega inscrita en Bases de Datos Avanzadas
(10, 10), -- Manuel Álvarez inscrito en Teoría de Grafos
(11, 11), -- Claudia Vega inscrita en Cálculo Diferencial
(12, 12); -- Manuel Álvarez inscrito en Principios de Diseño Gráfico

-- Insertar más datos en la tabla Evaluacion
INSERT INTO Evaluacion (nota, fecha_evaluacion, estudiante_id, curso_profesor_id) VALUES
(15.5, '2023-11-01', 1, 1),
(19.0, '2023-11-02', 2, 2),
(17.3, '2023-11-03', 3, 3),
(18.0, '2023-11-04', 4, 4),
(15.5, '2023-11-05', 5, 5),
(16.5, '2023-11-06', 6, 6),
(13.0, '2023-11-07', 7, 7),
(14.5, '2023-11-08', 8, 8),
(11.0, '2023-11-09', 9, 9),
(12.5, '2023-11-10', 10, 10),
(10.0, '2023-11-11', 11, 11),
(20.5, '2023-11-12', 12, 12);
