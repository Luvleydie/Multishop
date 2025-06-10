-- Tabla: usuarios (compradores y vendedores)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Tabla: publico
CREATE TABLE publico (
    id_publico INT AUTO_INCREMENT PRIMARY KEY,
    nombre_publico VARCHAR(50) NOT NULL
);

-- Tabla: productos (cada uno tiene un vendedor)
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_usuario INT NOT NULL, -- vendedor
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_publico INT,
    descuento INT,
    id_categoria INT,
    publicidad BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_publico) REFERENCES publico(id_publico) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabla intermedia: producto_categoria (relación muchos a muchos si se desea)
CREATE TABLE producto_categoria (
    id_producto INT,
    id_categoria INT,
    PRIMARY KEY (id_producto, id_categoria),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla: carrito (productos que el usuario está por comprar)
CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL, -- comprador
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla: ordenes (una orden de compra generada)
CREATE TABLE ordenes (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL, -- comprador
    fecha_orden TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('pendiente', 'pagado', 'cancelado', 'enviado', 'entregado') DEFAULT 'pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla: detalle de orden (productos dentro de una orden)
CREATE TABLE detalle_orden (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Inserts iniciales
INSERT INTO usuarios (nombre, correo, contrasena, telefono, direccion) VALUES
('Juan Pérez', 'juan@example.com', '123456', '5551234567', 'Av. Siempre Viva 123'),
('Ana López', 'ana@example.com', 'abcdef', '5559876543', 'Calle Luna 456');

INSERT INTO categorias (nombre_categoria) VALUES 
('Electrónica'), ('Ropa'), ('Hogar'), ('Juguetes'), ('Libros'), ('Accesorios');

INSERT INTO publico (nombre_publico) VALUES 
('Niño'), 
('Joven'), 
('Adulto');

INSERT INTO productos (nombre_producto, descripcion, precio, stock, id_usuario, id_publico, descuento, id_categoria, publicidad) VALUES
('Audífonos Bluetooth', 'Audífonos con cancelación de ruido.', 599.99, 20, 1, 2, 10, 1, TRUE),
('Camiseta Blanca', 'Camiseta básica de algodón.', 149.50, 100, 2, 3, 0, 2, FALSE);

INSERT INTO producto_categoria (id_producto, id_categoria) VALUES
(1, 1), (2, 2);

INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES
(2, 1, 1), (2, 2, 2);

INSERT INTO ordenes (id_usuario, total, estado) VALUES (2, 898.99, 'pagado');

INSERT INTO detalle_orden (id_orden, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 599.99),
(1, 2, 2, 149.50);



-- =========================================
-- Cambio 4/6/25
-- Se agrega tabla categoria y publico
-- Se edita la tabla de productos para agregar los FK de los catalogos
-- =========================================



-- =========================================
-- ALTER A LA TABLA PRODUCTOS
-- =========================================
ALTER TABLE productos 
ADD id_publico INT,
ADD descuento INT,
ADD id_categoria INT,
ADD publicidad BOOLEAN DEFAULT FALSE;

-- =========================================
-- CREACIÓN DE CATÁLOGO DE PUBLICOS
-- =========================================
CREATE TABLE publico (
    id_publico INT AUTO_INCREMENT PRIMARY KEY,
    nombre_publico VARCHAR(50) NOT NULL
);

INSERT INTO publico (nombre_publico) VALUES 
('Niño'), 
('Joven'), 
('Adulto');

-- =========================================
-- INSERCIÓN DE NUEVAS CATEGORÍAS 
-- =========================================
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);
INSERT INTO categorias (nombre_categoria) VALUES 
('Juguetes'), 
('Libros'), 
('Accesorios');

-- =========================================
-- CLAVES FORÁNEAS
-- =========================================
ALTER TABLE productos 
ADD FOREIGN KEY (id_publico) REFERENCES publicos(id_publico) ON DELETE SET NULL,
ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE SET NULL;

-- Path to the Usuario.php file
-- c:\xampp\htdocs\practica1\modelos\Usuario.php