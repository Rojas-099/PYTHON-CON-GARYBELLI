-- ahora vamos a eliminar un usuario en especifico

-- DELETE elimina filas de una tabla, no elimina la estructura de la tabla 


USE empresa

SELECT * FROM usuarios

DELETE FROM usuarios WHERE usuario_id = 2

SELECT * FROM usuarios WHERE usuario_id = 1

-- Eliminar usuarios cuyos id esten en la lista 

DELETE FROM usuarios WHERE usuario_id IN (8,12,13)