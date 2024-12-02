# Proyecto de Curso de Base de Datos - 2024 II - Cuarto Ciclo
Este es el repositorio de proyecto del curso de Base de Datos de la Universidad Tecnológica del Perú. Este proyecto fue desarrollado en base a un caso propuesto por el docente asignado

# Caso 2:Elaborar un Sistema de Gestión de Inscripción y Evaluaciones en una Universidad

La Universidad **"TechAcademy"** enfrenta múltiples desafíos en la gestión del proceso de inscripción de estudiantes, la administración de cursos y la evaluación académica. Actualmente, estas actividades se llevan a cabo de manera descentralizada y manual, lo que ocasiona demoras, errores en la inscripción, y una mala experiencia tanto para estudiantes como para el personal académico. Se propone desarrollar un Sistema de Gestión Académica que centralice y automatice el proceso de inscripción y evaluación de los estudiantes.

## Requerimientos del Sistema

1. Gestión de Inscripciones:
  - Permitir a los estudiantes inscribirse en cursos de acuerdo a su plan de estudios.
  - Verificar automáticamente los prerrequisitos de los cursos durante la inscripción.
  - Registrar y modificar la inscripción de los estudiantes en cursos.

2. Gestión de Cursos:
  - Registrar los cursos con información como código, nombre, créditos, profesor a cargo y prerrequisitos.
  - Asociaralos cursos lasfechas de inicio yfin, asícomo los horarios de clase.

3. Gestión de Profesores:
  - Registrar los datos de los profesores (nombre, departamento, email, teléfono).
  - Asociar profesores a los cursos que imparten.

4. Gestión de Evaluaciones:
  - Permitir alos profesores asignar calificaciones a los estudiantes por curso.
  - Generarinformes de rendimiento académico por estudiante y por curso.

## Modelo Entidad-Relación (E-R)
  ### Entidades y Atributos
1. Estudiante
  - ID_Estudiante (PK)
  - Nombre
  - Apellido
  - Email
  - Teléfono
  - Carrera

2. Curso
  - 1D_Curso (PK)
  - Nombre_Curso
  - Créditos
  - Prerrequisitos
  - ID_Profesor (FK)

3. Profesor
  - ID_Profesor (PK)
  - Nombre
  - Departamento
  - Email
 
4. Inscripción
  - ID_Inscripción (PK)
  - Fecha_Inscripción
  - ID_Estudiante (FK)
  - ID_Curso (FK)

5. Evaluación
  - ID_Evaluación (PK)
  - Nota
  - Fecha_Evaluación
  - ID_Estudiante (FK)
  - ID_Curso (FK)
 
### Relaciones
  + Unestudiante puede inscribirse en varios cursos (1 a N).
  + Uncursotiene un profesor que lo imparte (N a 1).
  + Unprofesorimparte varios cursos (1 a N).
  + Unestudiante puede tener varias evaluaciones (1 a N) en diferentes cursos.

## Transformación del Modelo E-R al Modelo Lógico Relacional
### Claves
  + Clave principal (PK) en cada entidad.
  + Claves foráneas (FK) en las tablas Inscripción y Evaluación que hacen referencia a Estudiante, Curso, y Profesor.

### Dependencias Funcionales
  + 1D_Estudiante > Nombre, Apellido, Email, Teléfono, Carrera
  + 1D_Curso > Nombre_Curso, Créditos, Prerrequisitos, ID_Profesor
  + 1D_Profesor > Nombre, Departamento, Email

## Normalización
 1. Primera Forma Normal (1NF): Asegurar que todos los atributos sean atómicos.
 2. Segunda Forma Normal (2NF): Eliminar dependencias parciales. Todos los atributos que no son clave deben depender de toda la clave primaria.
 3. Tercera Forma Normal (3NF): Eliminar dependencias transitivas entre atributos que no son clave.
 4. Forma Normal de Boyce-Codd (BCNF): Garantizar que cada determinante sea una clave candidata.
 5. Cuarta y Quinta Forma Normal: Eliminar dependencias multivaluadas y cualquier redundancia o anomalía en la estructura de las tablas.

## Comandos y Gestión de Base de Datos
###  + Comandos DML:
  - INSERT: Agregar nuevos estudiantes, cursos, inscripciones y evaluaciones.
  - UPDATE: Modificar la información de los estudiantes y las notas de las evaluaciones.
  - DELETE: Eliminar inscripciones de cursos.
  - SELECT: Consultar el rendimiento académico de los estudiantes y los cursos en los que están inscritos.

###  + Comandos DCL:
  - GRANT: Asignar permisos a los administradores, profesores y estudiantes para acceder al sistema.
  - REVOKE: Revocar permisos en caso de ser necesario.

## Consultas Avanzadas
+ Uso de JOIN para combinar información de estudiantes, cursos, y profesores en reportes.
+ Aplicar funciones agregadas como AVG, COUNT, MAX para generar informes de calificaciones promedio, cantidad de estudiantes inscritos y máxima nota por curso.
+ Subconsultas para filtrar los estudiantes con mejor rendimiento en cada curso.

## Funciones y Procedimientos Almacenados
+ Crear procedimientos almacenados para inscribir automáticamente a un estudiante en los cursos permitidos y validar los prerrequisitos.
+ Desarrollar funciones que calculen el promedio general de notas de un estudiante o curso específico.

## Manejo de Transacciones y Seguridad
+ Implementar **COMMIT** y **ROLLBACK** para asegurar que las transacciones tas sean consistentes y seguras.
+ Configurar TRIGGERS para notificar a los estudiantes sobre cambios en sus notas o enla inscripción de los cursos.

## Administración de Backups
+ Planificar y ejecutar cópias de seguridad de la base de datos para proteger la información académica.
+ Establecer un plan de restauración en caso de pérdida de datos.

## Administración de Usuarios
+ Gestionar los usuarios con roles como administrador, profesor y estudiante.
+ Asignar diferentes niveles de acceso y control según el rol para evitar accesos no autorizados.

## Documentación y Diccionario de Datos
+ Crear un diccionario de datos para documentar las tablas, relaciones, atributos y tipos de datos utilizados en el sistema.
+ Proporcionar una descripción clara de las funcionalidades del sistema para facilitar su USO Y mantenimiento.

## SQL vs NoSQL
### SQL:
  La base de datos relacional es adecuada para este sistema ya que requiere consistencia y relaciones estructuras entre entidades como estudiantes, cursos y evaluaciones.

### NoSQL:
  No sería el mejor enfoque para este tipo de sistema, pero podría evaluarse para gestionar grandes volúmenes de datos no estructurados en otras áreas de la universidad, como análisis de big data en investigaciones.

### Conclusión
El sistema de gestión de inscripciones y evaluaciones para la universidad "TechAcademy" ayudará a mejorar la eficiencia y la precisión en el manejo de la información académica. Con una base de datos bien normalizada, consultas avanzadas, funciones y procedimientos almacenados, y una robusta gestión de transacciones, el sistema será confiable, seguro y fácil de mantener.
Finalmente, se elaborara un proyecto de sistema en base al diseño seguro de la base de datos , permitiendo dar mantenimiento.
