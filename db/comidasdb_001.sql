
CREATE TABLE IF NOT EXISTS controlversionbd(
	id INTEGER(11) NOT NULL AUTO_INCREMENT, 
	archivo_tecnico VARCHAR (100) NOT NULL, 
	fechaejecucion datetime NOT NULL, 
	PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isEncrypted`	VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `restaurant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) NOT NULL,
  `nombre_contacto` varchar(255) NOT NULL,
  `clabe` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` char(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `facebook` varchar(255) NOT NULL,
  `twitter` varchar(255) NOT NULL,
  `instagram` varchar(255) NOT NULL,
  `logotipo` varchar(255) NOT NULL,
  `status` enum('ABIERTO','CERRADO') NOT NULL DEFAULT 'CERRADO',
  `ubicacion_lat` varchar(255) NOT NULL,
  `ubicacion_long` varchar(255) NOT NULL,
  `verificado` enum('SOLICITUD','APROBADO','RECHAZADO') NOT NULL DEFAULT 'SOLICITUD',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) 
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `platillos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_restaurant` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(255) NULL,
  `categoria` varchar(255) NOT NULL,
  `status` enum('DISPONIBLE','NO DISPONIBLE') NOT NULL DEFAULT 'DISPONIBLE',
  PRIMARY KEY (`id`),
  KEY `id_restaurant` (`id_restaurant`),
  CONSTRAINT `platillos_ibfk_1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `horarios` (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_restaurant INT NOT NULL,
  dia enum('L','M','X','J','V','S','D') NOT NULL DEFAULT 'L',
  hora_e time not null,
  hora_s time not null,
  PRIMARY KEY (`id`),
  KEY `id_restaurant` (`id_restaurant`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `clientes`(
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  apellidos VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  telefono CHAR(10) NOT NULL,
  telefono2 CHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) 
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pedidos`(
  id INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  fecha DATETIME NOT NULL,
  ubicacion_lat VARCHAR(255) NOT NULL,
  ubicacion_long VARCHAR(255) NOT NULL,
  status ENUM('PEDIDO','ENTREGA PARCIAL','ENTREGADO','CANCELADO') NOT NULL DEFAULT 'PEDIDO',
  iva DECIMAL(10,2) NOT NULL,
  forma_pago ENUM('EFECTIVO','ELECTRONICO') NOT NULL DEFAULT 'EFECTIVO',
  total DECIMAL(10,2) NOT NULL,
  envios DECIMAL(10,2) NOT NULL,
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) 
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `repartidores`(
  id INT NOT NULL AUTO_INCREMENT,
  id_restaurant INT NULL,
  razon_social VARCHAR(255) NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  clabe VARCHAR(255) NOT NULL,
  telefono CHAR(10) NOT NULL,
  email VARCHAR(255) NOT NULL,
  horario text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_restaurant` (`id_restaurant`),
  CONSTRAINT `repartidores_ibfk_1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`)

)ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `envios`(
  id INT NOT NULL AUTO_INCREMENT,
  id_pedido INT NOT NULL,
  id_repartidor INT NULL,
  id_restaurant INT NOT NULL,
  `status` ENUM('PENDIENTE','PREPARACION','TRANSITO','ENTREGADO','PROBLEMA') NOT NULL DEFAULT 'PREPARACIÓN',
  observaciones TEXT NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  envio DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `envios_id_pedido_fk` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`),
  KEY `id_repartidor` (`id_repartidor`),
  CONSTRAINT `envios_id_repartidor_fk` FOREIGN KEY (`id_repartidor`) REFERENCES `repartidores` (`id`),
  KEY `id_restaurant` (`id_restaurant`),
  CONSTRAINT `envios_id_restaurant_fk` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pedido_platillos`(
  id_pedido INT NOT NULL,
  id_platillo INT NOT NULL,
  id_envio INT NULL,
  cantidad INT NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `pedido_platillos_id_pedido_fk` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`),
  KEY `id_platillo` (`id_platillo`),
  CONSTRAINT `pedido_platillos_id_platillo_fk` FOREIGN KEY (`id_platillo`) REFERENCES `platillos` (`id`),
  KEY `id_envio` (`id_envio`),
  CONSTRAINT `pedido_platillos_id_envio_fk` FOREIGN KEY (`id_envio`) REFERENCES `envios` (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;











