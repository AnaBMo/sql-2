/* Relación tipo 1:1 */
/* ************************
    Relación tipo 1:1 
************************* */
-- PASO 1- Crea una tabla `usuarios`
-- Tu código aquí
CREATE TABLE USUARIOS(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	edad INT
);

-- PASO 2 - Crea una tabla de `roles`
-- Tu código aquí
CREATE TABLE ROLES(
	id_rol INT PRIMARY KEY AUTO_INCREMENT,
	nombre_rol VARCHAR(50) NOT NULL
);

-- PASO 3 - Crea la columna `id_rol` u la clave foránea
-- Tu código aquí
ALTER TABLE USUARIOS ADD COLUMN id_rol INT;
ALTER TABLE USUARIOS ADD CONSTRAINT fk_usuarios_roles FOREIGN KEY (id_rol) REFERENCES ROLES(id_rol);

UPDATE `bootcamp_fs`.`USUARIOS` SET `id_rol` = 1 WHERE `id_usuario` IN (1, 3, 5, 7, 9, 11);
UPDATE `bootcamp_fs`.`USUARIOS` SET `id_rol` = 2 WHERE `id_usuario` IN (2, 4, 6, 8, 10, 12);
UPDATE `bootcamp_fs`.`USUARIOS` SET `id_rol` = 3 WHERE `id_usuario` IN (13, 15, 17, 19);
UPDATE `bootcamp_fs`.`USUARIOS` SET `id_rol` = 4 WHERE `id_usuario` IN (14, 16, 18, 20);

-- PASO 4 - Haz un `JOIN` que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, 
-- usuarios.email, usuarios.edad, roles.nombre_rol de las dos tablas
-- Tu código aquí
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
-- Tu código aquí
CREATE TABLE CATEGORIAS(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	nombre_categoria VARCHAR(100) NOT NULL
);

-- PASO 2- Añade a la tabla `usuarios` la columna `id_categoria`
-- Tu código aquí
ALTER TABLE USUARIOS ADD COLUMN id_categoria INT;
ALTER TABLE USUARIOS ADD CONSTRAINT fk_usuarios_categorias FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id_categoria);

-- PASO 3- Añade categorías a varios usuarios
-- Tu código aquí
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 3);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (7, 9);
UPDATE usuarios SET id_categoria = 5 WHERE id_usuario IN (11, 13);
UPDATE usuarios SET id_categoria = 7 WHERE id_usuario IN (15, 17);
UPDATE usuarios SET id_categoria = 9 WHERE id_usuario IN (19, 5);

-- PASO - 4 Realiza cuna consulta para ver la unión de usuarios, roles y categorías
-- Tu código aquí
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
-- Tu código aquí
CREATE TABLE USUARIOS_CATEGORIAS(
    id_usuario_categoria INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_categoria INT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id_categoria)
);

-- PASO 2 - Asocia usuarios a categorías
-- Tu código aquí
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);

-- PASO 3 - Consulta para ver la unión de usuarios, roles, categorías
-- Tu código aquí
SELECT U.id_usuario, U.nombre, U.apellido, U.email, U.edad, R.nombre_rol, C.nombre_categoria
FROM USUARIOS U
JOIN ROLES R ON U.id_rol = R.id_rol
JOIN USUARIOS_CATEGORIAS UC ON U.id_usuario = UC.id_usuario
JOIN CATEGORIAS C ON U.id_categoria = C.id_categoria;