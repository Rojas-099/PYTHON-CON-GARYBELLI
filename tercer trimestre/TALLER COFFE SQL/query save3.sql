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


SHOW TABLES;

-------------------------------------------------------------------------------


CREATE TABLE producto (
    codigo_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    calorias INT NULL,
    id_categoria INT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) 
        REFERENCES categoria (id_categoria)
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE empleado (
    cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(150) NULL,
    telefono VARCHAR(20) NULL,
    fecha_nacimiento DATE NULL,
    fecha_ingreso DATE NOT NULL,
    sueldo_base DECIMAL(10,2) NOT NULL,
    tipo_empleado VARCHAR(20) NOT NULL,
    codigo_sucursal INT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY (codigo_sucursal) 
        REFERENCES sucursal (codigo_sucursal),
    CONSTRAINT chk_empleado_tipo CHECK (tipo_empleado IN ('BARISTA', 'MESERO', 'ADMINISTRATIVO')),
    CONSTRAINT chk_empleado_sueldo CHECK (sueldo_base >= 1300000)
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;


SHOW TABLES;

---------------------------------------------------------------------------------------



CREATE TABLE pedido (
    numero_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    codigo_sucursal INT NOT NULL,
    cedula_mesero CHAR(10) NOT NULL,
    cedula_cliente CHAR(10) NULL,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    metodo_pago VARCHAR(20) NULL,
    CONSTRAINT fk_pedido_sucursal FOREIGN KEY (codigo_sucursal) 
        REFERENCES sucursal (codigo_sucursal),
    CONSTRAINT fk_pedido_mesero FOREIGN KEY (cedula_mesero) 
        REFERENCES empleado (cedula),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cedula_cliente) 
        REFERENCES cliente (cedula)
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE detalle_pedido (
    numero_pedido INT,
    numero_linea INT,
    codigo_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (numero_pedido, numero_linea),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (numero_pedido) 
        REFERENCES pedido (numero_pedido),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (codigo_producto) 
        REFERENCES producto (codigo_producto),
    CONSTRAINT chk_detalle_cantidad CHECK (cantidad > 0)
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;

CREATE TABLE compra (
    numero_compra INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    nit_proveedor VARCHAR(15) NOT NULL,
    cedula_autoriza CHAR(10) NOT NULL,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    observaciones VARCHAR(200) NULL,
    CONSTRAINT fk_compra_proveedor FOREIGN KEY (nit_proveedor) 
        REFERENCES proveedor (nit),
    CONSTRAINT fk_compra_empleado FOREIGN KEY (cedula_autoriza) 
        REFERENCES empleado (cedula)
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE = utf8mb4_spanish_ci;


SHOW TABLES;

--------------------------- PUNTO ACTUAL ES EL 6 VOY PARA EL 7 ------------------------------------
------------------------------------------- SUCURSAL ------------------------------------


INSERT INTO sucursal (
    nombre,
    direccion,
    ciudad,
    telefono,
    fecha_apertura,
    activa
)
    VALUES
    (
        'Cafe Tolima Ibague Centro','Carrera 3 # 12-45','Ibague', '6082611111','2015-03.15',TRUE
    ),
    (
        'Cafe Tolima Espinal','Calle 9 # 6-30','Espinal', '6082612222','2018-07.01',TRUE
    ),
    (
        'Cafe Tolima Melgar','Avenida Panamericana 7','Melgar', NULL,   '2011-11.20',TRUE
    )


-----------------------------------------   CATEGORIAS   ---------------------------------------------------


INSERT INTO categoria (
    nombre,
    descripcion
)
VALUES
    ('Cafe caliente', 'Bebidas a base de cafe servidas calientes'
    ),
    ('Cafe frio', 'Bebidas a base de cafe servidas frias o con hielo'
    ),
    ('Te', 'infusion de hierbas y te clasicos'
    ),
    ('Jugo natural', 'Jugos preparados con fruta fresca'
    ),
    ('Gaseosa', 'Bebidas gaseosas en botella o lata'
    ),
    ('Pasteleria', 'Productos de reposteria y panaderia'
    ),
    ('Sandwich', 'Sandwiches frios y calientes'
    )

-------------------------------------------------   PRODUCTOS      ------------------------------------------------------

INSERT INTO producto (
    nombre,
    descripcion,
    precio_venta,
    calorias,
    id_categoria,
    activo
)
VALUES
    ('Tinto', 'Cafe negro tradicional, 8 oz', 2500.00, 5, 1, TRUE),
    ('Cafe con leche', 'Cafe espresso con leche caliente', 4500.00, 120, 1, TRUE),
    ('Capuccino', 'Espresso con leche vaporizada y espuma', 6500.00, 150, 1, TRUE),
    ('Latte', 'Espresso con abundante leche vaporizada', 7000.00, 190, 1, TRUE),
    ('Mocca', 'Espresso con chocolate y leche', 8500.00, 280, 1, TRUE),
    ('Cafe tostado del Tolima', 'Seleccion premium de la region', 10000.00, 5, 1, TRUE),
    ('Frappuccino', 'Cafe frio licuado con hielo y crema', 9500.00, 320, 2, TRUE),
    ('Cold brew', 'Cafe extraido en frio durante 12 horas', 8000.00, 10, 2, TRUE),
    ('Cafe helado', 'Espresso doble con hielo', 6000.00, 20, 2, TRUE),
    ('Te verde', 'Infusion de hoja de te verde', 3500.00, 0, 3, TRUE),
    ('Te de manzanilla', 'Infusion de manzanilla', 3000.00, 0, 3, TRUE),
    ('Aromatica de frutos', 'Mezcla de frutos rojos', 3500.00, 5, 3, TRUE),
    ('Jugo de mora', 'Jugo natural en agua o leche', 5000.00, 110, 4, TRUE),
    ('Jugo de mango', 'Jugo natural en agua o leche', 5000.00, 130, 4, TRUE),
    ('Jugo de lulo', 'Jugo natural en agua', 5000.00, 90, 4, TRUE),
    ('Limonada de coco', 'Limonada mezclada con crema de coco', 6500.00, 220, 4, TRUE),
    ('Coca-Cola 400ml', 'Botella retornable', 3500.00, 180, 5, TRUE),
    ('Colombiana 400ml', 'Botella retornable', 3500.00, 170, 5, TRUE),
    ('Croissant', 'Hojaldre frances recien horneado', 4000.00, 260, 6, TRUE),
    ('Muffin de arandanos', 'Muffin casero de arandanos', 4000.00, 310, 6, TRUE),
    ('Torta de zanahoria', 'Porcion individual', 6500.00, 380, 6, TRUE),
    ('Almojabana', 'Amasijo tradicional', 2500.00, 210, 6, TRUE),
    ('Pandebono', 'Amasijo tipico', 2500.00, 220, 6, TRUE),
    ('Sandwich de pollo', 'Pan artesanal, pollo, lechuga, tomate', 9500.00, 420, 7, TRUE),
    ('Sandwich vegetariano', 'Pan integral, queso, aguacate, tomate', 8500.00, 350, 7, TRUE),
    ('Combo desayuno', 'Cafe con leche + almojabana + jugo pequeno', 9000.00, 450, 6, FALSE);




------------------------------------------- EMPLEADOS ------------------------------------------------------------------

INSERT INTO empleado (
    cedula, 
    nombre, 
    apellido, 
    direccion, 
    telefono, 
    fecha_nacimiento, 
    fecha_ingreso, 
    sueldo_base, 
    tipo_empleado, 
    codigo_sucursal, 
    activo
    ) 
VALUES
    (
        '1110450101', 'Diana', 'Serrano', 'Calle 10 # 5-20, Ibague', '3001111111', '1985-04-12', '2015-03-15', 3800000.00, 'ADMINISTRATIVO', 1, TRUE
        ),
    (
        '1110450102', 'Carlos', 'Ramirez', 'Cra 4 # 15-33, Ibague', '3002222222', '1992-08-25', '2016-02-10', 1500000.00, 'MESERO', 1, TRUE
        ),
    (
        '1110450103', 'Andres', 'Pena', 'Calle 20 # 3-14, Ibague', '3003333333', '1990-01-30', '2017-06-01', 1800000.00, 'BARISTA', 1, TRUE
        ),
    (
        '1110450104', 'Laura', 'Ortiz', NULL, '3004444444', '1995-11-05', '2019-09-15', 1500000.00, 'MESERO', 1, TRUE
        ),
    (
        '1110450105', 'Miguel', 'Rojas', 'Cra 5 # 22-10, Ibague', NULL, '1988-06-18', '2016-04-20', 1900000.00, 'BARISTA', 1, TRUE
        ),
    (
        '1110450106', 'Sofia', 'Castillo', 'Calle 8 # 4-55, Ibague', '3006666666', '1993-03-22', '2020-01-15', 1400000.00, 'MESERO', 1, TRUE
        ),
    (
        '1110620201', 'Jonathan', 'Garibello', 'Cra 9 # 6-50, Espinal', '3011111111', '1987-07-14', '2018-07-01', 3600000.00, 'ADMINISTRATIVO', 2, TRUE
        ),
    (
        '1110620202', 'Maria', 'Lopez', 'Calle 12 # 4-11, Espinal', NULL, '1991-02-28', '2018-09-10', 1450000.00, 'MESERO', 2, TRUE
        ),
    (
        '1110620203', 'Sebastian', 'Vargas', 'Calle 5 # 8-20, Espinal', '3013333333', '1994-10-10', '2019-03-05', 1750000.00, 'BARISTA', 2, TRUE
        ),
    (
        '1110620204', 'Paola', 'Herrera', 'Cra 7 # 10-40, Espinal', '3014444444', '1996-05-16', '2021-02-01', 1400000.00, 'MESERO', 2, TRUE
        ),
    (
        '1110620205', 'Diego', 'Munoz', NULL, '3015555555', '1989-12-01', '2019-08-15', 1800000.00, 'BARISTA', 2, TRUE
        ),
    (
        '1110620206', 'Camila', 'Suarez', 'Calle 14 # 5-05, Espinal', '3016666666', '1997-09-08', '2022-04-10', 1400000.00, 'MESERO', 2, TRUE
        ),
    (
        '1110780301', 'Luisa', 'Torres', 'Av Panamericana 5, Melgar', '3021111111', '1986-05-20', '2021-11-20', 3500000.00, 'ADMINISTRATIVO', 3, TRUE
        ),
    (
        '1110780302', 'Ricardo', 'Guzman', 'Calle 3 # 7-14, Melgar', '3022222222', '1993-04-04', '2022-01-15', 1500000.00, 'MESERO', 3, TRUE
        ),
    (
        '1110780303', 'Natalia', 'Pineda', 'Cra 8 # 9-30, Melgar', '3023333333', '1995-07-27', '2022-03-01', 1700000.00, 'BARISTA', 3, TRUE
        ),
    (
        '1110780304', 'Julian', 'Bermudez', NULL, '3024444444', '1990-11-11', '2022-06-10', 1400000.00, 'MESERO', 3, TRUE
        ),
    (
        '1110780305', 'Valentina', 'Cortes', 'Calle 6 # 2-18, Melgar', '3025555555', '1998-01-14', '2023-05-20', 1400000.00, 'MESERO', 3, TRUE
        ),
    (
        '1110780306', 'Ivan', 'Moreno', 'Cra 4 # 8-22, Melgar', NULL, '1987-10-30', '2022-02-05', 1900000.00, 'BARISTA', 3, TRUE
        );


--------------------------------------------- CLIENTES ------------------------------------------------------------------

INSERT INTO cliente (
    cedula, 
    nombre, 
    apellido, 
    correo, 
    telefono, 
    fecha_registro, 
    puntos
    ) 
VALUES
    (
        '1105123456', 'Luisa', 'Fernandez', 'luisa.f@gmail.com', '3101234567', '2022-05-10', 120
        ),
    (
        '1105223456', 'Andres', 'Gomez', 'andres.g@gmail.com', '3102345678', '2022-06-15', 45
        ),
    (
        '1105323456', 'Marcela', 'Rios', 'marcela.r@hotmail.com', '3103456789', '2022-07-20', 380
        ),
    (
        '1105423456', 'Felipe', 'Vargas', 'felipe.v@outlook.com', NULL, '2022-08-05', 80
        ),
    (
        '1105523456', 'Catalina', 'Mora', 'catalina.m@gmail.com', '3105678901', '2023-01-12', 210
        ),
    (
        '1105623456', 'Sergio', 'Duque', NULL, '3106789012', '2023-02-25', 15
        ),
    (
        '1105723456', 'Isabella', 'Ramos', 'isabella.r@gmail.com', '3107890123', '2023-03-30', 540
        ),
    (
        '1105823456', 'Mateo', 'Silva', 'mateo.s@yahoo.com', '3108901234', '2023-05-18', 65
        ),
    (
        '1105923456', 'Daniela', 'Correa', 'daniela.c@gmail.com', '3109012345', '2023-06-10', 90
        ),
    (
        '1106023456', 'Juan', 'Perez', 'juan.perez@gmail.com', '3120123456', '2023-07-22', 0
        ),
    (
        '1106123456', 'Alejandra', NULL, 'alejandra@gmail.com', '3121234567', '2023-08-15', 150
        ),
    (
        '1106223456', 'David', 'Ospina', 'david.o@hotmail.com', '3122345678', '2023-09-05', 30
        ),
    (
        '1106323456', 'Paula', 'Cardenas', 'paula.c@gmail.com', NULL, '2024-01-20', 270
        ),
    (
        '1106423456', 'Oscar', 'Restrepo', 'oscar.r@outlook.com', '3124567890', '2024-02-14', 480
        ),
    (
        '1106523456', 'Valeria', 'Jimenez', NULL, '3125678901', '2024-03-08', 25
        ),
    (
        '1106623456', 'Nicolas', 'Torres', 'nicolas.t@gmail.com', '3126789012', '2024-04-22', 100
        ),
    (
        '1106723456', 'Manuela', 'Bedoya', 'manuela.b@gmail.com', '3127890123', '2024-05-16', 55
        ),
    (
        '1106823456', 'Emilio', 'Ariza', 'emilio.a@yahoo.com', '3128901234', '2024-06-30', 700
        ),
    (
        '1106923456', 'Sara', 'Molano', 'sara.m@gmail.com', '3129012345', '2024-07-25', 40
        ),
    (
        '1107023456', 'Tomas', 'Guerrero', 'tomas.g@hotmail.com', '3130123456', '2024-08-12', 0
        );

------------------------------------------  PROVEEDORES  --------------------------------------------------------------


INSERT INTO proveedor (
    nit, 
    razon_social, 
    direccion, 
    ciudad, 
    telefono, 
    correo, 
    contacto_principal
    ) 
VALUES
    (
        '900111222-1', 'Cafe La Estrella S.A.S.', 'Via al Nevado km 5', 'Ibague', '6082700001', 'ventas@laestrella.co', 'Alberto Sanchez'
        ),
    (
        '900222333-2', 'Distribuidora Lactea del Sur', 'Cra 15 # 25-30', 'Ibague', '6082700002', 'pedidos@laccosur.co', 'Beatriz Molina'
        ),
    (
        '900333444-3', 'Dulces y Panaderia Tolima', 'Calle 30 # 8-14', 'Espinal', '6082700003', 'contacto@dulcestol.co', 'Carlos Bermudez'
        ),
    (
        '900444555-4', 'Frutas Frescas del Magdalena', NULL, 'Girardot', '6082700004', 'frutas@magdalena.co', 'Diana Cuellar'
        ),
    (
        '900555666-5', 'Insumos Gourmet Colombia', 'Autopista Sur km 12', 'Bogota', '6017700005', 'ventas@gourmetcol.co', 'Esteban Ruiz'
        ),
    (
        '900666777-6', 'Bebidas del Tolima Ltda.', 'Cra 5 # 12-08', 'Ibague', NULL, NULL, 'Fernanda Rios'
        );



SELECT * FROM proveedor;
--------------------------------------------------------------- INSUMOS -----------------------------------------------------------------------


INSERT INTO insumo (
    nombre, 
    unidad_medida, 
    stock_actual, 
    stock_minimo, 
    stock_maximo
    ) 
VALUES
    (
    'Cafe en grano premium', 'kg', 85.50, 20.00, 200.00
    ),
    (
    'Cafe en grano estandar', 'kg', 120.00, 30.00, 300.00
    ),
    (
    'Leche entera', 'L', 45.00, 15.00, 150.00
    ),
    (
    'Leche deslactosada', 'L', 12.00, 10.00, 60.00
    ),
    (
    'Azucar blanca', 'kg', 30.00, 10.00, 100.00
    ),
    (
    'Azucar morena', 'kg', 8.50, 5.00, 50.00
    ),
    (
    'Chocolate en polvo', 'kg', 6.00, 3.00, 25.00
    ),
    (
    'Harina de trigo', 'kg', 40.00, 15.00, 100.00
    ),
    (
    'Frutas rojas congeladas', 'kg', 9.00, 5.00, 30.00
    ),
    (
    'Vasos desechables 8oz', 'un', 850.00, 200.00, 3000.00
    ),
    (
    'Vasos desechables 12oz', 'un', 420.00, 200.00, 3000.00
    ),
    (
    'Servilletas', 'un', 1200.00, 500.00, 5000.00
    );


------------------------------------------------    PEDIDOS --------------------------------------------------------

SELECT * FROM empleado;

INSERT INTO pedido (
    fecha_hora, 
    codigo_sucursal, 
    cedula_mesero, 
    cedula_cliente, 
    total, 
    metodo_pago
    ) 
VALUES
    (
        '2024-08-01 08:15:00', 1, '1110450102', '1105123456', 13000.00, 'Efectivo'
        ),
    (
        '2024-08-01 09:30:00', 1, '1110450104', NULL, 6500.00, 'Tarjeta'
        ),
    (
        '2024-08-01 10:45:00', 2, '1110620202', '1105223456', 11000.00, 'Efectivo'
        ),
    (
        '2024-08-01 12:20:00', 3, '1110780302', '1105323456', 18000.00, 'Tarjeta'
        ),
    (
        '2024-08-02 07:45:00', 1, '1110450106', NULL, 4500.00, 'Efectivo'
        ),
    (
        '2024-08-02 08:10:00', 2, '1110620204', '1105423456', 9500.00, 'Nequi'
        ),
    (
        '2024-08-02 15:30:00', 3, '1110780304', NULL, 11000.00, 'Efectivo'
        ),
    (
        '2024-08-05 09:00:00', 1, '1110450102', '1105523456', 20500.00, 'Tarjeta'
        ),
    (
        '2024-08-05 11:15:00', 2, '1110620206', '1105623456', 8500.00, 'Efectivo'
        ),
    (
        '2024-08-05 16:40:00', 3, '1110780305', '1105723456', 15000.00, 'Nequi'
        ),
    (
        '2024-08-08 08:20:00', 1, '1110450104', '1105823456', 7000.00, 'Efectivo'
        ),
    (
        '2024-08-08 10:00:00', 1, '1110450106', '1105923456', 10500.00, 'Tarjeta'
        ),
    (
        '2024-08-08 14:10:00', 2, '1110620202', NULL, 6000.00, 'Efectivo'
        ),
    (
        '2024-08-10 09:50:00', 3, '1110780302', '1106023456', 9500.00, 'Nequi'
        ),
    (
        '2024-08-10 13:25:00', 1, '1110450102', '1106123456', 16500.00, 'Tarjeta'
        ),
    (
        '2024-08-12 08:35:00', 2, '1110620204', '1106223456', 8000.00, 'Efectivo'
        ),
    (
        '2024-08-12 15:15:00', 3, '1110780304', NULL, 5000.00, 'Efectivo'
        ),
    (
        '2024-08-15 07:55:00', 1, '1110450106', '1106323456', 13500.00, 'Tarjeta'
        ),
    (
        '2024-08-15 11:40:00', 2, '1110620206', '1106423456', 28000.00, 'Nequi'
        ),
    (
        '2024-08-15 17:00:00', 3, '1110780305', NULL, 3500.00, 'Efectivo'
        ),
    (
        '2024-08-18 09:10:00', 1, '1110450104', '1106523456', 11000.00, 'Efectivo'
        ),
    (
        '2024-08-18 12:30:00', 2, '1110620202', '1106623456', 15000.00, 'Tarjeta'
        ),
    (
        '2024-08-20 08:45:00', 3, '1110780302', '1106723456', 7000.00, 'Nequi'
        ),
    (
        '2024-08-20 14:20:00', 1, '1110450102', '1106823456', 24000.00, 'Tarjeta'
        ),
    (
        '2024-08-22 10:05:00', 2, '1110620204', NULL, 4000.00, 'Efectivo'
        ),
    (
        '2024-08-22 16:15:00', 3, '1110780304', '1106923456', 13000.00, 'Efectivo'
        ),
    (
        '2024-08-25 08:00:00', 1, '1110450106', '1107023456', 8500.00, 'Tarjeta'
        ),
    (
        '2024-08-25 13:50:00', 2, '1110620206', '1105123456', 16500.00, 'Nequi'
        ),
    (
        '2024-08-25 15:30:00', 3, '1110780305', NULL, 5000.00, 'Efectivo'
        ),
    (
        '2024-08-28 09:25:00', 1, '1110450102', '1105223456', 20500.00, 'Tarjeta'
        ),
    (
        '2024-08-28 12:00:00', 2, '1110620202', '1105323456', 6500.00, 'Efectivo'
        ),
    (
        '2024-08-30 10:30:00', 3, '1110780302', '1105423456', 13000.00, 'Nequi'
        ),
    (
        '2024-08-30 16:45:00', 1, '1110450104', NULL, 9000.00, 'Efectivo'
        ),
    (
        '2024-08-31 08:15:00', 2, '1110620204', '1105523456', 20000.00, 'Tarjeta'
        ),
    (
        '2024-08-31 14:40:00', 3, '1110780304', '1105623456', 9500.00, 'Efectivo'
        );

DELETE FROM pedido;
ALTER TABLE pedido AUTO_INCREMENT = 1;



SELECT * FROM sucursal;
------------------------------------------------- DETALLE PEDIDO  ------------------------------------------------------

-- Cada pedido tiene entre 1 y 3 lineas.
-- Los subtotales cuadran con: subtotal = cantidad * precio_unitario
-- y la suma de subtotales cuadra con pedido.total (ejercicio 29 lo verifica).
INSERT INTO detalle_pedido (
    numero_pedido, 
    numero_linea, 
    codigo_producto, 
    cantidad, 
    precio_unitario, 
    subtotal
    ) 
VALUES
    (
        1, 1, 3, 2, 6500.00, 13000.00
        ),
    (
        2, 1, 3, 1, 6500.00, 6500.00
        ),
    (
        3, 1, 2, 1, 4500.00, 4500.00
        ),
    (
        3, 2, 19, 1, 4000.00, 4000.00
        ),
    (
        3, 3, 1, 1, 2500.00, 2500.00
        ),
    (
        4, 1, 5, 1, 8500.00, 8500.00
        ),
    (
        4, 2, 24, 1, 9500.00, 9500.00
        ),
    (
        5, 1, 2, 1, 4500.00, 4500.00
        ),
    (
        6, 1, 7, 1, 9500.00, 9500.00
        ),
    (
        7, 1, 4, 1, 7000.00, 7000.00
        ),
    (
        7, 2, 20, 1, 4000.00, 4000.00
        ),
    (
        8, 1, 5, 1, 8500.00, 8500.00
        ),
    (
        8, 2, 24, 1, 9500.00, 9500.00
        ),
    (
        8, 3, 23, 1, 2500.00, 2500.00
        ),
    (
        9, 1, 25, 1, 8500.00, 8500.00
        ),
    (
        10, 1, 6, 1, 10000.00, 10000.00
        ),
    (
        10, 2, 23, 1, 2500.00, 2500.00
        ),
    (
        10, 3, 22, 1, 2500.00, 2500.00
        ),
    (
        11, 1, 4, 1, 7000.00, 7000.00
        ),
    (
        12, 1, 3, 1, 6500.00, 6500.00
        ),
    (
        12, 2, 19, 1, 4000.00, 4000.00
        ),
    (
        13, 1, 9, 1, 6000.00, 6000.00
        ),
    (
        14, 1, 24, 1, 9500.00, 9500.00
        ),
    (
        15, 1, 8, 1, 8000.00, 8000.00
        ),
    (
        15, 2, 25, 1, 8500.00, 8500.00
        ),
    (
        16, 1, 8, 1, 8000.00, 8000.00
        ),
    (
        17, 1, 13, 1, 5000.00, 5000.00
        ),
    (
        18, 1, 4, 1, 7000.00, 7000.00
        ),
    (
        18, 2, 20, 1, 4000.00, 4000.00
        ),
    (
        18, 3, 1, 1, 2500.00, 2500.00
        ),
    (
        19, 1, 7, 1, 9500.00, 9500.00
        ),
    (
        19, 2, 5, 1, 8500.00, 8500.00
        ),
    (
        19, 3, 6, 1, 10000.00, 10000.00
        ),
    (
        20, 1, 10, 1, 3500.00, 3500.00
        ),
    (
        21, 1, 25, 1, 8500.00, 8500.00
        ),
    (
        21, 2, 1, 1, 2500.00, 2500.00
        ),
    (
        22, 1, 5, 1, 8500.00, 8500.00
        ),
    (
        22, 2, 21, 1, 6500.00, 6500.00
        ),
    (
        23, 1, 4, 1, 7000.00, 7000.00
        ),
    (
        24, 1, 8, 1, 8000.00, 8000.00
        ),
    (
        24, 2, 7, 1, 9500.00, 9500.00
        ),
    (
        24, 3, 21, 1, 6500.00, 6500.00
        ),
    (
        25, 1, 19, 1, 4000.00, 4000.00
        ),
    (
        26, 1, 3, 1, 6500.00, 6500.00
        ),
    (
        26, 2, 20, 1, 4000.00, 4000.00
        ),
    (
        26, 3, 1, 1, 2500.00, 2500.00
        ),
    (
        27, 1, 25, 1, 8500.00, 8500.00
        ),
    (
        28, 1, 5, 1, 8500.00, 8500.00
        ),
    (
        28, 2, 8, 1, 8000.00, 8000.00
        ),
    (
        29, 1, 13, 1, 5000.00, 5000.00
        ),
    (
        30, 1, 5, 1, 8500.00, 8500.00
        ),
    (
        30, 2, 24, 1, 9500.00, 9500.00
        ),
    (
        30, 3, 1, 1, 2500.00, 2500.00
        ),
    (
        31, 1, 3, 1, 6500.00, 6500.00
        ),
    (
        32, 1, 3, 2, 6500.00, 13000.00
        ),
    (
        33, 1, 16, 1, 6500.00, 6500.00
        ),
    (
        33, 2, 1, 1, 2500.00, 2500.00
        ),
    (
        34, 1, 8, 1, 8000.00, 8000.00
        ),
    (
        34, 2, 7, 1, 9500.00, 9500.00
        ),
    (
        34, 3, 1, 1, 2500.00, 2500.00
        ),
    (
        35, 1, 7, 1, 9500.00, 9500.00
        );


------------------------------------------  COMPRAS --------------------------------------------------------


INSERT INTO compra (
    fecha, 
    nit_proveedor, 
    cedula_autoriza, 
    total, 
    observaciones
    ) 
VALUES
    (
        '2024-07-15', '900111222-1', '1110450101', 600000.00, 'Reposicion mensual de cafe en grano'
        ),
    (
        '2024-07-15', '900222333-2', '1110450101', 180000.00, 'Compra semanal de leche'
        ),
    (
        '2024-07-20', '900333444-3', '1110620201', 350000.00, 'Pasteleria fin de semana'
        ),
    (
        '2024-07-25', '900444555-4', '1110780301', 120000.00, 'Frutas frescas para jugos'
        ),
    (
        '2024-08-01', '900555666-5', '1110450101', 480000.00, 'Insumos gourmet trimestrales'
        ),
    (
        '2024-08-05', '900111222-1', '1110620201', 550000.00, 'Cafe en grano - Espinal'
        ),
    (
        '2024-08-10', '900222333-2', '1110780301', 90000.00, 'Leche deslactosada'
        ),
    (
        '2024-08-15', '900333444-3', '1110450101', 400000.00, NULL
        ),
    (
        '2024-08-20', '900666777-6', '1110620201', 200000.00, 'Bebidas gaseosas'
        ),
    (
        '2024-08-25', '900444555-4', '1110780301', 150000.00, 'Frutas semanales'
        );



------------------------------------------------------------------------------------------------------------------------------


SELECT 'sucursal'       AS tabla, COUNT(*) AS registros FROM sucursal
UNION ALL SELECT 'categoria',       COUNT(*) FROM categoria
UNION ALL SELECT 'producto',        COUNT(*) FROM producto
UNION ALL SELECT 'empleado',        COUNT(*) FROM empleado
UNION ALL SELECT 'cliente',         COUNT(*) FROM cliente
UNION ALL SELECT 'proveedor',       COUNT(*) FROM proveedor
UNION ALL SELECT 'insumo',          COUNT(*) FROM insumo
UNION ALL SELECT 'pedido',          COUNT(*) FROM pedido
UNION ALL SELECT 'detalle_pedido',  COUNT(*) FROM detalle_pedido
UNION ALL SELECT 'compra',          COUNT(*) FROM compra;

/* 
CONTEOS ESPERADOS:
sucursal: 3
categoria: 7
producto: 26
empleado: 18
cliente: 20
proveedor: 6
insumo: 12
pedido: 35
detalle_pedido: 61
compra: 10
*/

DELETE FROM insumo;
ALTER TABLE insumo AUTO_INCREMENT = 1;


---------------------------------------------------------------------------------------------



SELECT *
FROM sucursal


SELECT 
    nombre AS 'Producto',
    precio_venta AS 'Precio'
FROM producto


SELECT 
    cedula ,
    nombre AS 'Nombre',
    apellido AS 'Apellido'
FROM empleado



SELECT DISTINCT ciudad FROM sucursal;


SELECT DISTINCT tipo_empleado FROM empleado;



SELECT DISTINCT metodo_pago FROM pedido;

SELECT cedula, nombre, apellido, codigo_sucursal
FROM empleado
WHERE codigo_sucursal != '1'


SELECT cedula, nombre, apellido, puntos
FROM cliente
WHERE puntos >= '100'

SELECT *
FROM pedido
WHERE DATE(fecha_hora)= '2024-08-15'

-------------------------------------------------------------------


SELECT *
FROM producto
ORDER BY precio_venta DESC

SELECT *
FROM empleado
ORDER BY apellido ASC



SELECT *
FROM cliente
ORDER BY puntos DESC



SELECT * FROM producto ORDER BY id_categoria ASC, precio_venta DESC;




SELECT *
FROM producto
ORDER BY  precio_venta DESC
LIMIT 5 

SELECT *
FROM pedido
ORDER BY total DESC
LIMIT 3

SELECT *
FROM cliente
ORDER BY puntos ASC
LIMIT 5


SELECT * FROM cliente WHERE nombre LIKE 'M%';

SELECT * FROM producto WHERE nombre LIKE '%café%';

SELECT * FROM empleado WHERE apellido LIKE '%ez';

SELECT * FROM cliente WHERE correo LIKE '%gmail.com';




SELECT * FROM producto WHERE id_categoria = 1 AND precio_venta > 5000;

SELECT * FROM empleado WHERE tipo_empleado = 'BARISTA' OR codigo_sucursal = 3;

SELECT * FROM producto WHERE id_categoria != 5 AND activo = TRUE;


SELECT * FROM pedido WHERE codigo_sucursal = 1 AND (metodo_pago = 'Tarjeta' OR metodo_pago = 'Nequi');



SELECT * FROM empleado WHERE codigo_sucursal IN (1, 3);

SELECT * FROM producto WHERE id_categoria IN (1, 2, 3);

SELECT * FROM producto WHERE precio_venta BETWEEN 4000 AND 8000;


SELECT * FROM empleado WHERE sueldo_base BETWEEN 1500000 AND 2000000;

SELECT * FROM pedido WHERE fecha_hora BETWEEN '2024-08-05 00:00:00' AND '2024-08-15 23:59:59';


SELECT * FROM cliente WHERE correo IS NULL

SELECT * FROM cliente WHERE correo IS NOT NULL

SELECT * FROM pedido WHERE cedula_cliente IS NULL

SELECT 
    cedula, 
    nombre, 
    apellido, 
    IFNULL(correo, 'Sin correo registrado') AS correo, 
    telefono, 
    fecha_registro, 
    puntos 
FROM cliente;


SELECT 
    numero_pedido, 
    fecha_hora, 
    codigo_sucursal, 
    total, 
    metodo_pago
FROM 
    pedido
WHERE 
    codigo_sucursal IN (1, 2)
    AND total BETWEEN 10000 AND 25000
    AND metodo_pago IN ('Tarjeta', 'Nequi')
    AND cedula_cliente IS NOT NULL
ORDER BY 
    total DESC;




SELECT COUNT(*) AS 'Total Productos' FROM producto;


SELECT COUNT(*) AS 'Total Clientes' FROM cliente;



SELECT COUNT(correo) AS 'Clientes con correo' FROM cliente;



SELECT COUNT(*) AS 'Pedidos Anónimos' FROM pedido WHERE cedula_cliente IS NULL;


SELECT SUM(total) AS 'Total Ventas Agosto' 
FROM pedido 
WHERE fecha_hora BETWEEN '2024-08-01 00:00:00' AND '2024-08-31 23:59:59';

SELECT SUM(total) AS 'Total Compras' FROM compra;

SELECT SUM(puntos) AS 'Total Puntos' FROM cliente;


SELECT ROUND(AVG(precio_venta), 2) AS 'Precio Promedio' FROM producto;


SELECT ROUND(AVG(sueldo_base), 2) AS 'Sueldo Promedio Baristas' 
FROM empleado 
WHERE tipo_empleado = 'BARISTA';
------------------------------------------- SIGUIENTE PUNTO ES EL 20 -----------------------------------------------------------------------