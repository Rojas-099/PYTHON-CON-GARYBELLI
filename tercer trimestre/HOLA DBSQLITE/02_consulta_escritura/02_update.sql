-- Para modificar un registro
USE empresa

DESCRIBE usuarios;


SELECT * FROM usuarios

-- vamos a modificar la edad de ana con usuarios_id
-- el WHERE evita modificar a los demas usuarios si existieran

UPDATE usuarios SET edad = 30 WHERE usuario_id  = 1

-- verificamos unicamente el usuario modificado

SELECT * FROM usuarios WHERE usuario_id = 1

-- modificamos varias columnas
-- SER permite cambiar varias columnas de una misma consulta

UPDATE usuarios SET edad = 27, correo = 'ana.nuevo@gmail.com' WHERE usuario_id = 1

-- vamos a modificar utilizando otra colunma lo podemos hacer con el correo

UPDATE usuarios SET apellido = 'Garcia' WHERE correo = 'ana.nuevo@gmail.com'