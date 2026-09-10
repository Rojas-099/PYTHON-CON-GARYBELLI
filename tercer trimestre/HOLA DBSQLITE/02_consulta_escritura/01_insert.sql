USE empresa;

CREATE TABLE usuarios(
    usuario_id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100), 
    edad INT, 
    correo VARCHAR(50), 
    fecha_registro DATE,
    PRIMARY KEY(usuario_id));

INSERT INTO
    usuarios (
    nombre,
    apellido,
    edad,
    correo,
    fecha_registro)
    VALUES('Ana', 'Perez', 25, 'ana@gmail.com', '2026/07/31');

DROP DATABASE IF EXISTS empresa;

INSERT INTO
    usuarios (
    nombre,
    apellido,
    edad,
    correo,
    fecha_registro)
    VALUES
    ('jonathan', 'Garibello', 35, 'jonathan@gmail.com', '2010-05-12');