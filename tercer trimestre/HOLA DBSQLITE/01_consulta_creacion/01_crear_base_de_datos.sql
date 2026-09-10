-- Crea una base de datos llamada empresa

CREATE DATABASE empresa;

-- Esta solo crea la base de datos si todavía no existe COMMENT

CREATE DATABASE IF NOT EXISTS empresa
CHARACTER set utf8mb4
COLLATE utf8mb4_spanish_ci;

-- Mostramos todas las bases de datos del servidor

SHOW DATABASES;

-- Cambiamos la base de datos de mi base a la base de datos empresa

USE empresa;

-- Muestra la base de datos que estás usando

SELECT DATABASE() AS base_de_datos_actual;