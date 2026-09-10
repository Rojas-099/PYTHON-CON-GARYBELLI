

SELECT 
    VERSION() AS 'VersionMySQL',
    USER() AS 'Usuario',
    NOW() AS 'Fecha servidor';

------------------------------------


CREATE USER 'cafe_admin'@'localhost' IDENTIFIED BY '1314'

SELECT USER, HOST FROM mysql.user
WHERE USER = 'cafe_admin';  

--------------------------------------------------------


DROP DATABASE IF EXISTS cafe_tolima;


CREATE DATABASE cafe_tolima
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;


GRANT ALL PRIVILEGES ON cafe_tolima.* TO 'cafe_admin'@'localhost';
FLUSH PRIVILEGES;


SHOW GRANTS FOR 'cafe_admin'@'localhost';


-------------------------------------------------------------------------


-- Ejercicio 04. Crear las 5 tablas INDEPENDIENTES (sin llaves foráneas)[cite: 1]

CREATE TABLE sucursal (
    codigo_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    telefono VARCHAR(20) NULL,
    fecha_apertura DATE NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(150) NULL
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE cliente (
    cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NULL,
    correo VARCHAR(100) NULL,
    telefono VARCHAR(20) NULL,
    fecha_registro DATE NOT NULL,
    puntos INT NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE proveedor (
    nit VARCHAR(15) PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NULL,
    ciudad VARCHAR(60) NULL,
    telefono VARCHAR(20) NULL,
    correo VARCHAR(100) NULL,
    contacto_principal VARCHAR(100) NULL
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE insumo (
    codigo_insumo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    unidad_medida VARCHAR(10) NOT NULL,
    stock_actual DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_minimo DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_maximo DECIMAL(10,2) NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

-- Verificación de las 5 tablas creadas[cite: 1]
SHOW TABLES;