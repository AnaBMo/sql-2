drop database sprint13;

create database sprint13;
use sprint13;

/* ************************
    Relación tipo 1:1 
************************* */
-- PASO 1- Crea una tabla `usuarios`
CREATE TABLE USUARIOS(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	edad INT
);

INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);

-- PASO 2 - Crea una tabla de `roles`
CREATE TABLE ROLES(
	id_rol INT PRIMARY KEY AUTO_INCREMENT,
	nombre_rol VARCHAR(50) NOT NULL
);

-- Insertar datos de roles
INSERT INTO roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');

-- PASO 3 - Crea la columna `id_rol` u la clave foránea
ALTER TABLE USUARIOS ADD COLUMN id_rol INT;
ALTER TABLE USUARIOS ADD CONSTRAINT fk_usuarios_roles FOREIGN KEY (id_rol) REFERENCES ROLES(id_rol);

UPDATE `sprint13`.`USUARIOS` SET `id_rol` = 1 WHERE `id_usuario` IN (1, 3, 5, 7, 9, 11);
UPDATE `sprint13`.`USUARIOS` SET `id_rol` = 2 WHERE `id_usuario` IN (2, 4, 6, 8, 10, 12);
UPDATE `sprint13`.`USUARIOS` SET `id_rol` = 3 WHERE `id_usuario` IN (13, 15, 17, 19);
UPDATE `sprint13`.`USUARIOS` SET `id_rol` = 4 WHERE `id_usuario` IN (14, 16, 18, 20);

-- PASO 4 - Haz un `JOIN` que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, 
-- usuarios.email, usuarios.edad, roles.nombre_rol de las dos tablas
SELECT U.id_usuario, U.nombre, U.apellido, U.email, U.edad, R.nombre_rol
FROM USUARIOS U
JOIN ROLES R ON U.id_rol = R.id_rol;

-- ---------------------------------------------------------------------------------------------
SELECT * FROM USUARIOS;
SELECT * FROM ROLES;
-- ---------------------------------------------------------------------------------------------

/* ************************
    Relación tipo 1:N 
************************* */
-- PASO 1- Crea una tabla `categorias`
CREATE TABLE CATEGORIAS(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electrónicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');

-- PASO 2- Añade a la tabla `usuarios` la columna `id_categoria`
ALTER TABLE USUARIOS ADD COLUMN id_categoria INT;
ALTER TABLE USUARIOS ADD CONSTRAINT fk_usuarios_categorias FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id_categoria);

-- PASO 3- Añade categorías a varios usuarios
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 3);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (7, 9);
UPDATE usuarios SET id_categoria = 5 WHERE id_usuario IN (11, 13);
UPDATE usuarios SET id_categoria = 7 WHERE id_usuario IN (15, 17);
UPDATE usuarios SET id_categoria = 9 WHERE id_usuario IN (19, 5);

-- PASO - 4 Realiza cuna consulta para ver la unión de usuarios, roles y categorías
SELECT U.id_usuario, U.nombre, U.apellido, U.email, U.edad, R.nombre_rol, C.nombre_categoria
FROM USUARIOS U
JOIN ROLES R ON U.id_rol = R.id_rol
JOIN CATEGORIAS C ON U.id_categoria = C.id_categoria;
			/* sólo aparecerán los usuarios cuya categoría no sea null */

-- ---------------------------------------------------------------------------------------------
SELECT * FROM USUARIOS;
SELECT * FROM ROLES;
SELECT * FROM CATEGORIAS;
-- ---------------------------------------------------------------------------------------------

/* ************************
    Relación tipo N:M 
************************* */
-- PASO 1 - Crea una tabla intermedia llamada `usuarios_categorias`
CREATE TABLE USUARIOS_CATEGORIAS(
    id_usuario_categoria INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_categoria INT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id_categoria)
);
SET SQL_SAFE_UPDATES = 0;

-- PASO 2 - Asocia usuarios a categorías
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);

-- ---------------------------------------------------------------------------------------------
SELECT * FROM USUARIOS_CATEGORIAS;
-- ---------------------------------------------------------------------------------------------

-- PASO 3 - Consulta para ver la unión de usuarios, roles, categorías
SELECT U.id_usuario, U.nombre, U.apellido, U.email, U.edad, R.nombre_rol, C.nombre_categoria
FROM USUARIOS U
JOIN ROLES R ON U.id_rol = R.id_rol
JOIN USUARIOS_CATEGORIAS UC ON U.id_usuario = UC.id_usuario
JOIN CATEGORIAS C ON UC.id_categoria = C.id_categoria;