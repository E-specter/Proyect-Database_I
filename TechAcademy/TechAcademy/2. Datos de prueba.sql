-- Insertar m�s datos en la tabla Departamento
INSERT INTO Departamento (nombre, descripcion) VALUES
('Ingenier�a de Sistemas', 'Departamento encargado de la formaci�n en tecnolog�a de la informaci�n'),
('Ciencias de la Computaci�n', 'Departamento enfocado en algoritmos y estructuras de datos'),
('Administraci�n de Empresas', 'Departamento que gestiona la formaci�n en t�cnicas administrativas'),
('Matem�ticas y Estad�stica', 'Departamento especializado en m�todos cuantitativos y an�lisis de datos'),
('Ciencias Sociales', 'Departamento dedicado al estudio de la sociedad y comportamiento humano'),
('Dise�o Gr�fico', 'Departamento que ense�a t�cnicas de dise�o y creatividad visual');

-- Insertar m�s datos en la tabla Estudiante
INSERT INTO Estudiante (id_nacional, nombre, apellidos, correo, telefono, direccion) VALUES
('123456789', 'Ana', 'Gonz�lez', 'ana.gonzalez@techacademy.edu', '987654321', 'Calle de la Tecnolog�a, Lima'),
('987654321', 'Carlos', 'Morales', 'carlos.morales@techacademy.edu', '123456789', 'Avenida de la Innovaci�n, Lima'),
('456789123', 'Luc�a', 'P�rez', 'lucia.perez@techacademy.edu', '321654987', 'Calle del Conocimiento, Lima'),
('159753852', 'Jorge', 'L�pez', 'jorge.lopez@techacademy.edu', '753159456', 'Avenida del Progreso, Lima'),
('852456789', 'Marta', 'Torres', 'marta.torres@techacademy.edu', '654987321', 'Calle de la Sabidur�a, Lima'),
('456123789', 'Diego', 'Hern�ndez', 'diego.hernandez@techacademy.edu', '987321654', 'Calle de la Innovaci�n, Lima'),
('789456123', 'Isabela', 'Soto', 'isabela.soto@techacademy.edu', '321987654', 'Calle de la Cultura, Lima'),
('321654987', 'Fernando', 'Ram�rez', 'fernando.ramirez@techacademy.edu', '654123987', 'Calle de la Ciencia, Lima'),
('654987123', 'Claudia', 'Vega', 'claudia.vega@techacademy.edu', '987123654', 'Calle de la Educaci�n, Lima'),
('963852741', 'Manuel', '�lvarez', 'manuel.alvarez@techacademy.edu', '852741963', 'Calle de la Cultura, Lima');

-- Insertar m�s datos en la tabla Profesor
INSERT INTO Profesor (id_nacional, nombre, apellidos, departamento_id, correo, telefono, direccion) VALUES
('111223333', 'Javier', 'Rodr�guez', 1, 'javier.rodriguez@techacademy.edu', '456789123', 'Edificio A, Lima'),
('444556666', 'Sof�a', 'Mart�nez', 2, 'sofia.martinez@techacademy.edu', '789123456', 'Edificio B, Lima'),
('777889000', 'Miguel', 'G�mez', 3, 'miguel.gomez@techacademy.edu', '123789456', 'Edificio C, Lima'),
('333111222', 'Laura', 'V�squez', 4, 'laura.vasquez@techacademy.edu', '321654987', 'Edificio D, Lima'),
('555888999', 'H�ctor', 'Jim�nez', 1, 'hector.jimenez@techacademy.edu', '987654321', 'Edificio E, Lima'),
('222333444', 'Martina', 'Lopez', 5, 'martina.lopez@techacademy.edu', '654321987', 'Edificio F, Lima'),
('666777888', 'Jos�', 'Garc�a', 6, 'jose.garcia@techacademy.edu', '321789654', 'Edificio G, Lima');

-- Insertar m�s datos en la tabla Curso
INSERT INTO Curso (nombre, creditos) VALUES
('Programaci�n en Python', 3),
('Estructuras de Datos', 4),
('Gesti�n Empresarial', 3),
('Algoritmos Avanzados', 3),
('Fundamentos de Matem�ticas', 2),
('Estad�stica Aplicada', 3),
('An�lisis de Sistemas', 4),
('Administraci�n de Proyectos', 3),
('Bases de Datos Avanzadas', 4),
('Teor�a de Grafos', 3),
('C�lculo Diferencial', 2),
('Introducci�n a la Psicolog�a', 3),
('Principios de Dise�o Gr�fico', 3);

-- Insertar m�s datos en la tabla Prerequisito
INSERT INTO Prerequisito (curso_id, prerequisito_id) VALUES
(2, 1),  -- Estructuras de Datos depende de Programaci�n en Python
(4, 2),  -- Algoritmos Avanzados depende de Estructuras de Datos
(7, 6),  -- An�lisis de Sistemas depende de Estad�stica Aplicada
(8, 3),  -- Administraci�n de Proyectos depende de Gesti�n Empresarial
(9, 2),  -- Bases de Datos Avanzadas depende de Estructuras de Datos
(10, 5), -- Teor�a de Grafos depende de Fundamentos de Matem�ticas
(11, 5), -- C�lculo Diferencial depende de Fundamentos de Matem�ticas
(12, 13); -- Introducci�n a la Psicolog�a es un prerequisito para Principios de Dise�o Gr�fico

-- Insertar m�s datos en la tabla Curso_Profesor
INSERT INTO Curso_Profesor (curso_id, profesor_id) VALUES
(1, 1),  -- Programaci�n en Python asignada a Javier Rodr�guez
(2, 2),  -- Estructuras de Datos asignada a Sof�a Mart�nez
(3, 3),  -- Gesti�n Empresarial asignada a Miguel G�mez
(4, 1),  -- Algoritmos Avanzados asignada a Javier Rodr�guez
(5, 5),  -- Fundamentos de Matem�ticas asignada a H�ctor Jim�nez
(6, 4),  -- Estad�stica Aplicada asignada a Laura V�squez
(7, 2),  -- An�lisis de Sistemas asignada a Sof�a Mart�nez
(8, 3),  -- Administraci�n de Proyectos asignada a Miguel G�mez
(9, 5),  -- Bases de Datos Avanzadas asignada a H�ctor Jim�nez
(10, 6), -- Teor�a de Grafos asignada a Jos� Garc�a
(11, 5), -- C�lculo Diferencial asignada a H�ctor Jim�nez
(12, 7); -- Principios de Dise�o Gr�fico asignada a Jos� Garc�a

-- Insertar m�s datos en la tabla Inscripcion
INSERT INTO Inscripcion (estudiante_id, curso_profesor_id) VALUES
(1, 1),  -- Ana Gonz�lez inscrita en Programaci�n en Python
(1, 2),  -- Ana Gonz�lez inscrita en Estructuras de Datos
(2, 2),  -- Carlos Morales inscrito en Estructuras de Datos
(3, 3),  -- Luc�a P�rez inscrita en Gesti�n Empresarial
(4, 4),  -- Jorge L�pez inscrito en Algoritmos Avanzados
(5, 5),  -- Marta Torres inscrita en Fundamentos de Matem�ticas
(6, 6),  -- Diego Hern�ndez inscrito en Estad�stica Aplicada
(7, 7),  -- Isabela Soto inscrita en An�lisis de Sistemas
(8, 8),  -- Fernando Ram�rez inscrito en Administraci�n de Proyectos
(9, 9),  -- Claudia Vega inscrita en Bases de Datos Avanzadas
(10, 10), -- Manuel �lvarez inscrito en Teor�a de Grafos
(11, 11), -- Claudia Vega inscrita en C�lculo Diferencial
(12, 12); -- Manuel �lvarez inscrito en Principios de Dise�o Gr�fico

-- Insertar m�s datos en la tabla Evaluacion
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
