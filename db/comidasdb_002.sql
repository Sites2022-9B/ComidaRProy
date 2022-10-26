
--Datos de prueba del sistema

-- usuarios de restaurants
INSERT INTO `users` (`id`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `isEncrypted`) VALUES
	(1, 'pablo@gmail.com', '1234', NULL, '2022-09-12 04:16:06', '2022-09-12 04:16:06','false'),
	(2, 'fabian@gmail.com', '1234', NULL, '2022-09-12 04:16:11', '2022-09-12 04:16:12','false'),
	(3, 'henry@gmail.com', '1234', NULL, '2022-09-12 04:16:17', '2022-09-12 04:16:17','false'),
	(4, 'quique@gmail.com', '1234', NULL, '2022-09-12 04:16:20', '2022-09-12 04:16:20','false'),
	(5, 'mario@gmail.com', '1234', NULL, '2022-09-12 04:16:11', '2022-09-12 04:16:12','false'),
	(6, 'dueño@gmail.com', '1234', NULL, '2022-09-12 04:17:56', '2022-09-12 04:17:56','false');

-- usuarios de clientes
INSERT INTO `users` (`id`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `isEncrypted`) VALUES
	(7, 'pablofabian@gmail.com', '1234', NULL, '2022-09-12 04:16:06', '2022-09-12 04:16:06','false'),
	(8, 'constantino@gmail.com', '1234', NULL, '2022-09-12 04:16:11', '2022-09-12 04:16:12','false'),
	(9, 'lopezv@gmail.com', '1234', NULL, '2022-09-12 04:16:17', '2022-09-12 04:16:17','false');


-- restaurantes
INSERT INTO `restaurant` (`id`, `razon_social`, `nombre_contacto`, `clabe`, `direccion`, `telefono`, `email`, `facebook`, `twitter`, `instagram`, `logotipo`, `status`, `ubicacion_lat`, `ubicacion_long`, `verificado`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Comidas Toñitas', 'Mario', '9876543', 'Sexta Poniente Norte', '9897651432', 'pablo@gmail.com', 'Toñita', 'Ninguno', 'Ninguno', 'no', 'CERRADO', '17.171047038617488', '92.33461453753803', 'APROBADO', '2022-09-11 22:59:02', '2022-09-11 22:59:06', '2022-09-11 22:59:08'),
	(2, 'Comidas Mack', 'Carlos', '12384759', 'Septima Poniente Norte', '9568474589', 'henry@gmail.com', 'Mack', 'Ninguno', 'Ninguno', 'no', 'CERRADO', '17.171047038617489', '92.33461453753804', 'APROBADO', '2022-09-11 23:08:02', '2022-09-11 23:04:26', '2022-09-11 23:04:27'),
	(3, 'Fonda Marinos', 'Henry ', '1487524', 'Cuarta Poniente Sur', '5847589412', 'quique@gmail.com', 'Marinos', 'Ninguno', 'Ninguno', 'no', 'CERRADO', '17.171047038617488', '92.33461453753803', 'APROBADO', '2022-09-11 23:12:02', '2022-09-11 23:10:43', '2022-09-11 23:10:44'),
	(4, 'Fonda Florinda', 'Florinda', '1457256', 'Sexta Oriente Sur', '5784674516', 'mario@gmail.com', 'Flori', 'Ninguno', 'Ninguno', 'No', 'CERRADO', '17.171047038617488', '92.33461453753801', 'RECHAZADO', '2022-09-11 23:26:00', '2022-09-11 23:25:17', '2022-09-11 23:25:19'),
	(5, 'El Buen Gusto', 'Cornelio', '1452687', 'Sexta Oriente Norte', '4757157594', 'dueño@gmail.com', 'Buen Gusto', 'Ninguno', 'Ninguno', 'no', 'CERRADO', '17.171047038617488', '92.33461453753801', 'SOLICITUD', '2022-09-11 23:29:14', '2022-09-11 23:29:15', '2022-09-11 23:29:16'),
	(6, 'Palapa del Gato ', 'Pablo ', '7547854', 'Quinta Oriente Sur', '4813297548', 'fabian@gmail.com', 'Palapa', 'Ninguno', 'Ninguno', 'no', 'CERRADO', '17.171047038617488', '92.33461453753801', 'RECHAZADO', '2022-09-11 23:30:56', '2022-09-11 23:30:57', '2022-09-11 23:30:57');


-- Clientes
INSERT INTO `clientes` (`id`, `nombre`,`apellidos`,`email`,`telefono`,`telefono2`) VALUES 
  (1, 'Pablo','Ruiz Constantino','pablofabian@gmail.com', '9191337074','9191042957'),
  (2, 'Henry','Lopez Vazquez','lopezv@gmail.com', '9191337074','9191042957'),
  (3, 'Quique','Gutierrez cruz','constantino@gmail.com', '9191337074','9191042957');

  -- pedidos
INSERT INTO `pedidos`(`id`,`id_cliente`,`fecha`,`ubicacion_lat`,`ubicacion_long`, `status`,`iva`,`forma_pago`,`total`, `envios`) VALUES 
  (1,1,'2022-09-11 23:30:56','17.171047038617488', '92.33461453753801','PEDIDO',0.12,'EFECTIVO',300.0,25.0),
  (1,2,'2022-09-11 23:30:56','17.171047038617488', '92.33461453753801','PEDIDO',0.12,'EFECTIVO',300.0,25.0),
  (1,3,'2022-09-11 23:30:56','17.171047038617488', '92.33461453753801','PEDIDO',0.12,'EFECTIVO',300.0,25.0),

--repartidores
INSERT INTO `repartidor`(`id`,`id_restaurant`,`razon_social`,`nombre`,`clabe`,`telefono`,`email`,`horario`) VALUES
  (1,1,'Fast and Furious','pedro','123456789123456789','9191002212','fastandfurious@gmail.com','todo el dia'),
  (2,2,'Repartiplus','Juan','123456789123456789','9191002212','repartiplus@gmail.com','todo el dia');

--envios
INSERT INTO `envios`(`id`,`id_pedido`,`id_repartidor`,`id_restaurant`,`status`,`observaciones`,`total`,`envio`) VALUES
  (1,1,1,1,'PREPARACION','EL PEDIDO SALDRA PRONTO',300,25.0);


--platillos

INSERT INTO `platillos`(`id`,`id_restaurant`,`nombre`,`descripcion`,`precio`,`imagen`,`categoria`,`status`) VALUES
  (1,1,'mole','poblano',45,'','comida','DISPONIBLE'),  
  (2,1,'coca-cola','600 ml',18,'','bebida','DISPONIBLE'),  
  (3,2,'pozole','con lechuga',40,'','comida','DISPONIBLE'),  
  (4,2,'pizza','peperoni',120,'','comida','DISPONIBLE'),  
  (5,1,'limonada','jarra',20,'','bebida','DISPONIBLE');


--platilos en un pedido
INSERT INTO `pedido_platillos`(`id_pedido`,`id_platillo`,`id_envio`,`cantidad`,`precio`) VALUES
  (1,1,1,2,45),
  (1,2,1,3,18),
  (1,5,1,1,120);