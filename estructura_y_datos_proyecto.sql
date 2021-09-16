BEGIN TRANSACTION;
DROP TABLE IF EXISTS "django_migrations";
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_group_permissions";
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user_groups";
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user_user_permissions";
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "django_admin_log";
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_detallepresupuesto";
CREATE TABLE IF NOT EXISTS "aromatizantes_detallepresupuesto" (
	"id"	integer NOT NULL,
	"cantidad"	integer NOT NULL,
	"precio_unitario"	decimal NOT NULL,
	"precio_total"	decimal NOT NULL,
	"presupuesto_id"	integer,
	"producto_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("presupuesto_id") REFERENCES "aromatizantes_presupuesto"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("producto_id") REFERENCES "aromatizantes_producto"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_detallepedido";
CREATE TABLE IF NOT EXISTS "aromatizantes_detallepedido" (
	"id"	integer NOT NULL,
	"cantidad"	integer NOT NULL,
	"precio_unitario"	decimal NOT NULL,
	"precio_total"	decimal NOT NULL,
	"pedido_id"	integer,
	"producto_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("pedido_id") REFERENCES "aromatizantes_pedido"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("producto_id") REFERENCES "aromatizantes_producto"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_cuentacorriente";
CREATE TABLE IF NOT EXISTS "aromatizantes_cuentacorriente" (
	"id"	integer NOT NULL,
	"monto"	decimal NOT NULL,
	"pagado"	decimal NOT NULL,
	"restante"	decimal NOT NULL,
	"cliente_id"	integer,
	"pedido_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("pedido_id") REFERENCES "aromatizantes_pedido"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "django_content_type";
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_permission";
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_group";
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_user";
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "django_session";
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
DROP TABLE IF EXISTS "aromatizantes_detalleservicio";
CREATE TABLE IF NOT EXISTS "aromatizantes_detalleservicio" (
	"id"	integer NOT NULL,
	"cantidad"	integer NOT NULL,
	"precio_unitario"	decimal NOT NULL,
	"precio_total"	decimal NOT NULL,
	"producto_id"	integer,
	"servicio_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("servicio_id") REFERENCES "aromatizantes_servicio"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("producto_id") REFERENCES "aromatizantes_producto"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_pedido";
CREATE TABLE IF NOT EXISTS "aromatizantes_pedido" (
	"id"	integer NOT NULL,
	"estado"	varchar(30) NOT NULL,
	"costo_total"	decimal,
	"pagado"	bool NOT NULL,
	"cliente_id"	integer,
	"fecha"	date NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_servicio";
CREATE TABLE IF NOT EXISTS "aromatizantes_servicio" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"estado"	varchar(30) NOT NULL,
	"costo_total"	decimal,
	"pagado"	bool NOT NULL,
	"cliente_id"	integer,
	"fecha_programada"	date,
	"hora"	time,
	"cantidad_dias"	smallint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_cliente";
CREATE TABLE IF NOT EXISTS "aromatizantes_cliente" (
	"id"	integer NOT NULL,
	"nombre_apellido"	varchar(100) NOT NULL,
	"telefono"	varchar(100) NOT NULL,
	"direccion"	varchar(120) NOT NULL,
	"horario_disponible_desde"	time NOT NULL,
	"horario_disponible_hasta"	time NOT NULL,
	"email"	varchar(150) NOT NULL,
	"zona"	varchar(20) NOT NULL,
	"fecha_ingreso"	date NOT NULL,
	"dado_de_alta"	bool NOT NULL,
	"cuit_cuil_DNI"	integer NOT NULL,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "aromatizantes_envio";
CREATE TABLE IF NOT EXISTS "aromatizantes_envio" (
	"id"	integer NOT NULL,
	"estado"	varchar(20) NOT NULL,
	"fecha"	date NOT NULL,
	"hora"	time NOT NULL,
	"cliente_id"	integer,
	"pedido_id"	integer,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("pedido_id") REFERENCES "aromatizantes_pedido"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_pago";
CREATE TABLE IF NOT EXISTS "aromatizantes_pago" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"medio_pago"	varchar(15) NOT NULL,
	"monto"	decimal NOT NULL,
	"estado"	varchar(15) NOT NULL,
	"cliente_id"	integer,
	"pedido_id"	integer,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("pedido_id") REFERENCES "aromatizantes_pedido"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_pagoservicio";
CREATE TABLE IF NOT EXISTS "aromatizantes_pagoservicio" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"medio_pago"	varchar(15) NOT NULL,
	"monto"	decimal NOT NULL,
	"estado"	varchar(15) NOT NULL,
	"cliente_id"	integer,
	"servicio_id"	integer,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("servicio_id") REFERENCES "aromatizantes_servicio"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_presupuesto";
CREATE TABLE IF NOT EXISTS "aromatizantes_presupuesto" (
	"id"	integer NOT NULL,
	"costo_total"	decimal,
	"cliente_id"	integer,
	"clave"	varchar(36) NOT NULL,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_producto";
CREATE TABLE IF NOT EXISTS "aromatizantes_producto" (
	"id"	integer NOT NULL,
	"nombre_aroma"	varchar(100) NOT NULL,
	"precio"	decimal NOT NULL,
	"categoria"	varchar(20) NOT NULL,
	"stock_actual"	integer NOT NULL,
	"stock_minimo"	integer NOT NULL,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "aromatizantes_visita";
CREATE TABLE IF NOT EXISTS "aromatizantes_visita" (
	"id"	integer NOT NULL,
	"estado"	varchar(20) NOT NULL,
	"fecha"	date,
	"hora"	time,
	"zona"	varchar(20) NOT NULL,
	"cliente_id"	integer,
	"pedido_id"	integer,
	"observaciones"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("pedido_id") REFERENCES "aromatizantes_pedido"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("cliente_id") REFERENCES "aromatizantes_cliente"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_historicaldetallepresupuesto";
CREATE TABLE IF NOT EXISTS "aromatizantes_historicaldetallepresupuesto" (
	"id"	integer NOT NULL,
	"cantidad"	integer NOT NULL,
	"precio_unitario"	decimal NOT NULL,
	"precio_total"	decimal NOT NULL,
	"history_id"	integer NOT NULL,
	"history_date"	datetime NOT NULL,
	"history_change_reason"	varchar(100),
	"history_type"	varchar(1) NOT NULL,
	"history_user_id"	integer,
	"presupuesto_id"	integer,
	"producto_id"	integer,
	PRIMARY KEY("history_id" AUTOINCREMENT),
	FOREIGN KEY("history_user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "aromatizantes_historicalpresupuesto";
CREATE TABLE IF NOT EXISTS "aromatizantes_historicalpresupuesto" (
	"id"	integer NOT NULL,
	"costo_total"	decimal,
	"observaciones"	varchar(100) NOT NULL,
	"clave"	varchar(36) NOT NULL,
	"history_id"	integer NOT NULL,
	"history_date"	datetime NOT NULL,
	"history_change_reason"	varchar(100),
	"history_type"	varchar(1) NOT NULL,
	"cliente_id"	integer,
	"history_user_id"	integer,
	PRIMARY KEY("history_id" AUTOINCREMENT),
	FOREIGN KEY("history_user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2021-07-26 14:36:56.075158');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (2,'auth','0001_initial','2021-07-26 14:36:56.318315');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (3,'admin','0001_initial','2021-07-26 14:36:56.526452');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (4,'admin','0002_logentry_remove_auto_add','2021-07-26 14:36:56.841661');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (5,'admin','0003_logentry_add_action_flag_choices','2021-07-26 14:36:57.055802');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (6,'aromatizantes','0001_initial','2021-07-26 14:36:57.533130');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (7,'contenttypes','0002_remove_content_type_name','2021-07-26 14:36:58.109501');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (8,'auth','0002_alter_permission_name_max_length','2021-07-26 14:36:58.449728');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (9,'auth','0003_alter_user_email_max_length','2021-07-26 14:36:58.765937');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (10,'auth','0004_alter_user_username_opts','2021-07-26 14:36:59.006098');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (11,'auth','0005_alter_user_last_login_null','2021-07-26 14:36:59.377344');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (12,'auth','0006_require_contenttypes_0002','2021-07-26 14:36:59.612499');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (13,'auth','0007_alter_validators_add_error_messages','2021-07-26 14:36:59.923705');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (14,'auth','0008_alter_user_username_max_length','2021-07-26 14:37:00.413029');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (15,'auth','0009_alter_user_last_name_max_length','2021-07-26 14:37:00.745250');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (16,'auth','0010_alter_group_name_max_length','2021-07-26 14:37:01.027438');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (17,'auth','0011_update_proxy_permissions','2021-07-26 14:37:02.515424');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (18,'auth','0012_alter_user_first_name_max_length','2021-07-26 14:37:02.915689');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (19,'sessions','0001_initial','2021-07-26 14:37:03.207884');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (20,'aromatizantes','0002_auto_20210726_1355','2021-07-26 17:00:41.579579');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (21,'aromatizantes','0003_detalleservicio_servicio','2021-07-26 17:00:42.254027');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (22,'aromatizantes','0004_auto_20210726_1609','2021-07-26 19:09:37.409703');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (23,'aromatizantes','0005_servicio_hora','2021-07-26 19:59:32.199553');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (24,'aromatizantes','0006_auto_20210726_1715','2021-07-26 20:15:22.887985');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (25,'aromatizantes','0007_auto_20210726_1801','2021-07-26 21:01:53.369736');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (26,'aromatizantes','0008_pagoservicio','2021-07-27 02:18:29.806579');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (27,'aromatizantes','0009_auto_20210727_1239','2021-07-27 15:40:00.898600');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (28,'aromatizantes','0010_auto_20210728_0446','2021-07-28 07:46:15.576211');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (29,'aromatizantes','0011_remove_visita_pagado','2021-07-28 13:53:14.185585');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (30,'aromatizantes','0012_envio_cantidad_dias','2021-07-28 14:06:30.814786');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (31,'aromatizantes','0013_remove_envio_cantidad_dias','2021-07-28 14:37:23.900767');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (32,'aromatizantes','0014_auto_20210801_1932','2021-08-01 22:32:41.912478');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (33,'aromatizantes','0015_auto_20210801_2041','2021-08-01 23:42:08.083933');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (34,'aromatizantes','0016_auto_20210809_0042','2021-08-09 03:42:54.771645');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (35,'aromatizantes','0017_remove_pago_costo_total','2021-08-09 03:47:10.345026');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (36,'aromatizantes','0018_auto_20210811_0955','2021-08-11 12:55:21.643806');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (37,'aromatizantes','0019_auto_20210817_1419','2021-08-17 17:20:54.971023');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (38,'aromatizantes','0020_auto_20210817_1543','2021-08-17 18:44:09.991802');
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (1,2,1);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (2,2,4);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (3,2,5);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (4,2,8);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (6,2,12);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (7,2,16);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (8,2,17);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (9,2,20);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (10,2,24);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (11,2,28);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (12,2,29);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (13,2,32);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (14,2,33);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (15,2,36);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (16,2,40);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (17,2,56);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (18,2,65);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (19,2,68);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (20,2,72);
INSERT INTO "auth_user_user_permissions" ("id","user_id","permission_id") VALUES (21,2,76);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (1,'2021-07-26 14:38:51.373642','1','Fernandez Maria  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (2,'2021-07-26 14:39:15.140409','1','AMOUR / stock actual  :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (3,'2021-07-26 14:39:52.583249','1','Pedido Nro 1 - Fernandez Maria  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "1"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (4,'2021-07-26 14:40:26.148525','1','Nro de pago: 1','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (5,'2021-07-26 14:40:46.038720','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (6,'2021-07-26 14:43:40.634538','1','Fernandez Maria  (disponible)','[]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (7,'2021-07-26 15:01:36.143044','1','Fernandez Maria  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "1"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (8,'2021-07-26 17:05:40.939372','2','D.ANALOGICO / Stock   :20/Precio: 500','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (9,'2021-07-26 17:06:07.689126','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "1"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (10,'2021-07-26 19:11:16.955744','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (11,'2021-07-26 19:11:59.497566','2','Servicio Nro 2 - Fernandez Maria  (disponible) $ 500.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "2"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (12,'2021-07-26 19:34:01.036774','2','Fernandez Mar  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (13,'2021-07-26 19:34:43.677061','2','Pedido Nro 2 - Fernandez Mar  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "2"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (14,'2021-07-26 19:35:55.522735','2','Nro de pago: 2','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (15,'2021-07-26 19:36:50.522225','2','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (16,'2021-07-26 19:59:54.052060','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (17,'2021-07-26 20:00:12.232109','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (18,'2021-07-26 20:00:31.987217','3','Servicio Nro 3 - Fernandez Maria  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "3"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (19,'2021-07-26 20:03:55.080948','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (20,'2021-07-26 20:04:16.680278','4','Servicio Nro 4 - Fernandez Maria  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "4"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (21,'2021-07-26 20:06:07.920074','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (22,'2021-07-26 20:15:34.855919','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (23,'2021-07-26 20:49:21.867270','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (24,'2021-07-26 21:02:02.369706','3','Candela Ricci  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (25,'2021-07-26 21:02:15.135175','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (26,'2021-07-26 21:06:32.616991','5','Servicio Nro 5 - Candela Ricci  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "5"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (27,'2021-07-26 21:07:26.400671','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (28,'2021-07-26 21:07:32.354620','2','Servicio Nro 2 - Fernandez Maria  (disponible) $ 500.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (29,'2021-07-26 21:07:38.574747','3','Servicio Nro 3 - Fernandez Maria  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (30,'2021-07-26 21:07:46.048705','4','Servicio Nro 4 - Fernandez Maria  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (31,'2021-07-26 21:07:51.916599','5','Servicio Nro 5 - Candela Ricci  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (32,'2021-07-26 21:08:10.200729','3','Candela Ricci  (disponible)','[{"changed": {"fields": ["Desde"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (33,'2021-07-26 21:08:18.810439','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Desde"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (34,'2021-07-26 21:08:28.386793','4','Servicio Nro 4 - Fernandez Maria  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (35,'2021-07-26 21:08:35.506517','5','Servicio Nro 5 - Candela Ricci  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (36,'2021-07-26 21:09:00.519109','1','Servicio Nro 1 - Fernandez Maria  (disponible) $ 500.00','',17,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (37,'2021-07-26 21:09:00.703232','2','Servicio Nro 2 - Fernandez Maria  (disponible) $ 500.00','',17,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (38,'2021-07-26 21:09:00.828315','3','Servicio Nro 3 - Fernandez Maria  (disponible) $ 200.00','',17,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (39,'2021-07-26 23:10:25.338893','4','Servicio Nro 4 - Fernandez Maria  (disponible) $ 200.00','[{"changed": {"fields": ["Pagado"]}}]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (40,'2021-07-27 03:31:44.775386','1','Nro de pago: 1','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (41,'2021-07-27 03:32:27.893172','6','Servicio Nro 6 - Fernandez Mar  (disponible) $ 1000.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "6"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (42,'2021-07-27 03:32:55.668725','2','Nro de pago: 2','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (43,'2021-07-27 04:01:18.164300','4','Almada Silvia  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (44,'2021-07-27 04:01:46.762392','3','Candela Ricci  (disponible)','[{"changed": {"fields": ["Email", "Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (45,'2021-07-27 04:02:08.001570','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (46,'2021-07-27 04:04:00.122421','5','Solis Gabriela  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (47,'2021-07-27 04:06:11.861371','6','Martorelli Liliana  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (48,'2021-07-27 04:07:58.699697','7','Claudia Diaz  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (49,'2021-07-27 04:09:53.803540','8','Duran Andres  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (50,'2021-07-27 04:11:58.444750','9','Payero Maria Laura  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (51,'2021-07-27 04:13:35.705681','10','Rodriguez Elena  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (52,'2021-07-27 04:14:11.137335','2','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Email", "Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (53,'2021-07-27 04:15:08.197429','11','Salas Pedro  (no disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (54,'2021-07-27 04:18:59.863087','2','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Email"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (55,'2021-07-27 04:19:20.488858','3','Pedido Nro 3 - Fernandez Mar  (disponible) $ 400.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "3"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (56,'2021-07-27 04:19:48.294422','3','Nro de pago: 3','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (57,'2021-07-27 04:20:12.178367','3','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (58,'2021-07-27 04:24:31.385412','4','Pedido Nro 4 - Fernandez Mar  (disponible) $ 500.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "4"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (59,'2021-07-27 04:24:59.742344','4','Nro de pago: 4','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (60,'2021-07-27 04:25:19.485533','4','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (61,'2021-07-27 04:44:32.435972','3','FRUTILLA / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (62,'2021-07-27 04:44:49.180151','4','DETERGENTE / Stock   :20/Precio: 250','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (63,'2021-07-27 04:45:43.743577','4','DETERGENTE 5LT / Stock   :20/Precio: 250.00','[{"changed": {"fields": ["Nombre aroma"]}}]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (64,'2021-07-27 04:46:01.220245','5','LAVANDA / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (65,'2021-07-27 04:46:18.978099','6','ETIQUETA NEGRA / Stock   :1/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (66,'2021-07-27 04:46:48.401742','7','D.DIGITAL / Stock   :20/Precio: 700','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (67,'2021-07-28 06:56:12.185809','12','Paez Graciela  (no disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (68,'2021-07-28 06:59:43.483576','2','empleado','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (69,'2021-07-28 07:07:25.976466','2','empleado','[{"changed": {"fields": ["User permissions"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (70,'2021-07-28 07:08:15.704587','2','empleado','[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (71,'2021-07-28 07:17:30.489965','4','Almada Silvia  (disponible)','[]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (72,'2021-07-28 07:31:11.499922','5','Pedido Nro 5 - Almada Silvia  (disponible) $ 400.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "5"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (73,'2021-07-28 07:32:13.327114','5','Nro de pago: 5','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (74,'2021-07-28 07:36:37.187887','5','Almada Silvia  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (75,'2021-07-28 07:47:53.770640','6','Nro de pago: 6','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (76,'2021-07-28 13:50:13.801086','6','Pedido Nro 6 - Fernandez Mar  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "6"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (77,'2021-07-28 13:51:46.377923','7','Nro de pago: 7','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (78,'2021-07-28 14:26:15.683365','4','Fernandez Mar  (disponible)','[]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (79,'2021-07-28 14:27:17.335553','4','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Estado"]}}]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (80,'2021-07-28 14:37:29.511517','3','Fernandez Mar  (disponible)','[]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (81,'2021-07-28 14:38:03.237049','7','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Estado", "Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (82,'2021-07-28 15:21:18.127516','7','Servicio Nro 7 - Almada Silvia  (disponible) $ 600.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "7"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (83,'2021-07-28 15:44:03.125413','4','Servicio Nro 4 - Fernandez Maria  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (84,'2021-07-28 19:15:29.334640','7','Pedido Nro 7 - Rodriguez Elena  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "7"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (85,'2021-07-28 19:16:00.123200','8','Nro de pago: 8','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (86,'2021-07-28 19:16:31.889430','9','Nro de pago: 9','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (87,'2021-07-28 19:21:34.146357','9','Nro de pago: 9','[]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (88,'2021-07-28 19:22:01.419577','9','Nro de pago: 9','[{"changed": {"fields": ["Estado"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (89,'2021-07-28 20:54:17.369172','2','Pedido Nro 2 - Fernandez Mar  (disponible) $ 200.00','',2,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (90,'2021-07-28 20:54:17.509257','3','Pedido Nro 3 - Fernandez Mar  (disponible) $ 400.00','',2,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (91,'2021-07-28 20:54:17.629337','4','Pedido Nro 4 - Fernandez Mar  (disponible) $ 500.00','',2,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (92,'2021-07-28 20:54:17.779438','6','Pedido Nro 6 - Fernandez Mar  (disponible) $ 200.00','',2,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (93,'2021-07-28 20:55:06.602055','7','Nro de pago: 7','',6,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (94,'2021-07-28 20:55:06.732144','4','Nro de pago: 4','',6,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (95,'2021-07-28 20:55:06.857224','3','Nro de pago: 3','',6,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (96,'2021-07-28 20:55:07.096385','2','Nro de pago: 2','',6,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (97,'2021-07-28 20:55:33.516045','7','Fernandez Mar  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (98,'2021-07-28 20:55:33.757195','3','Fernandez Mar  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (99,'2021-07-28 20:55:33.958330','2','Fernandez Mar  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (100,'2021-07-28 20:55:34.213502','4','Fernandez Mar  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (101,'2021-07-28 20:55:53.378304','8','Rodriguez Elena  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (102,'2021-07-28 21:00:52.746303','8','Pedido Nro 8 - Fernandez Mar  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "8"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (103,'2021-07-28 21:01:44.381797','10','Nro de pago: 10','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (104,'2021-07-28 21:02:02.172683','9','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (105,'2021-07-28 21:02:45.093356','7','Fernandez Mar  (disponible)','',7,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (106,'2021-07-28 21:02:45.418575','6','Fernandez Mar  (disponible)','',7,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (107,'2021-07-28 21:02:45.810836','5','Almada Silvia  (disponible)','',7,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (108,'2021-07-28 21:02:46.487287','4','Fernandez Mar  (disponible)','',7,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (109,'2021-07-28 21:02:46.872544','3','Fernandez Mar  (disponible)','',7,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (110,'2021-07-28 21:02:47.207781','2','Fernandez Mar  (disponible)','',7,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (111,'2021-07-28 21:21:50.145733','13','Solis Gabriel  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (112,'2021-07-28 21:22:31.665470','14','Paz Sol  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (113,'2021-07-28 21:23:37.639546','8','LIMON / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (114,'2021-07-28 21:23:57.433769','9','SUIT / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (115,'2021-07-28 21:24:13.489496','10','CREAM / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (116,'2021-07-28 21:24:41.226025','11','FRESH / Stock   :1/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (117,'2021-07-28 21:25:04.858814','12','KEN / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (118,'2021-07-28 21:25:27.225757','13','LAVANDINA 5LT / Stock   :20/Precio: 250','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (119,'2021-07-28 21:25:51.663083','14','JABON LIQUIDO ARIEL 5LT / Stock   :20/Precio: 250','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (120,'2021-07-28 21:26:24.335909','15','BAMBU / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (121,'2021-07-28 21:33:25.673128','9','Pedido Nro 9 - Fernandez Mar  (disponible) $ 3400.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "9"}}, {"added": {"name": "detalle pedido", "object": "10"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (122,'2021-07-28 21:35:17.317105','11','Nro de pago: 11','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (123,'2021-07-28 21:36:30.224514','10','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (124,'2021-07-28 21:38:13.158706','10','Fernandez Mar  (disponible)','[]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (125,'2021-07-28 21:41:28.426522','8','Servicio Nro 8 - Fernandez Mar  (disponible) $ 400.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "8"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (126,'2021-07-28 21:42:14.507328','3','Nro de pago: 3','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (127,'2021-07-28 21:42:53.532469','2','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "2"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (128,'2021-07-28 21:44:13.756240','10','Pedido Nro 10 - Fernandez Mar  (disponible) $ 3000.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "11"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (129,'2021-07-28 21:47:44.722963','8','LIMON / Stock   :18/Precio: 300','[{"changed": {"fields": ["Precio"]}}]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (130,'2021-07-28 21:49:56.381751','2','empleado','[{"changed": {"fields": ["Superuser status", "User permissions"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (131,'2021-08-01 22:33:04.572596','4','Almada Silvia  (disponible)','[{"changed": {"fields": ["Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (132,'2021-08-01 22:33:48.630020','15','BAMBU / Stock   :20/Precio: 200.00','[]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (133,'2021-08-02 00:32:07.149107','1','Pedido Nro 1 - Fernandez Maria  (disponible) $ 200.00','[]',2,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (134,'2021-08-02 01:26:01.294710','11','Nro de pago: 11','[]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (135,'2021-08-02 02:35:38.289799','11','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (136,'2021-08-04 02:23:26.362348','15','Priscila Fernandez  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (137,'2021-08-04 02:26:41.003791','16','durazno / Stock   :35/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (138,'2021-08-04 02:32:36.392853','11','Pedido Nro 11 - Priscila Fernandez  (disponible) $ 1600.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "12"}}, {"added": {"name": "detalle pedido", "object": "13"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (139,'2021-08-04 02:35:11.526830','12','Nro de pago: 12','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (140,'2021-08-04 02:35:30.451198','13','Nro de pago: 13','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (141,'2021-08-04 02:36:22.028501','13','Nro de pago: 13','[{"changed": {"fields": ["Estado"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (142,'2021-08-04 02:37:44.028137','12','Priscila Fernandez  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (143,'2021-08-04 02:43:53.492149','12','Priscila Fernandez  (disponible)','[]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (144,'2021-08-04 02:46:05.904048','9','Servicio Nro 9 - Priscila Fernandez  (disponible) $ 700.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "9"}}, {"added": {"name": "detalle servicio", "object": "10"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (145,'2021-08-04 02:47:46.449850','4','Nro de pago: 4','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (146,'2021-08-04 02:50:09.836190','3','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "3"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (147,'2021-08-04 03:15:18.732767','12','Pedido Nro 12 - Candela Ricci  (disponible) $ 1000.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "14"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (148,'2021-08-04 06:06:13.074456','13','Pedido Nro 13 - Claudia Diaz  (disponible) $ 500.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "15"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (149,'2021-08-04 06:08:06.837247','14','Pedido Nro 14 - Candela Ricci  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "16"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (150,'2021-08-04 06:18:37.061101','15','Pedido Nro 15 - Duran Andres  (disponible) $ 300.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "17"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (151,'2021-08-04 06:31:56.653791','16','Pedido Nro 16 - Fernandez Maria  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "18"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (152,'2021-08-04 06:34:35.050314','11','FRESH / Stock   :15/Precio: 200.00','[{"changed": {"fields": ["Stock actual"]}}]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (153,'2021-08-04 06:35:56.165355','17','Pedido Nro 17 - Fernandez Mar  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "19"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (154,'2021-08-04 06:49:47.984513','18','Pedido Nro 18 - Martorelli Liliana  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "20"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (155,'2021-08-04 06:54:11.787257','19','Pedido Nro 19 - Duran Andres  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "21"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (156,'2021-08-04 06:56:57.830874','20','Pedido Nro 20 - Almada Silvia  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "22"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (157,'2021-08-04 07:18:46.911985','21','Pedido Nro 21 - Fernandez Maria  (disponible) $ 250.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "23"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (158,'2021-08-04 07:27:07.486468','22','Pedido Nro 22 - Paz Sol  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "24"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (159,'2021-08-04 07:31:36.139445','23','Pedido Nro 23 - Payero Maria Laura  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "25"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (160,'2021-08-04 07:53:08.578468','24','Pedido Nro 24 - Priscila Fernandez  (disponible) $ 250.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "26"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (161,'2021-08-04 08:09:56.097678','25','Pedido Nro 25 - Payero Maria Laura  (disponible) $ 250.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "27"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (162,'2021-08-04 08:15:39.223269','26','Pedido Nro 26 - Duran Andres  (disponible) $ 300.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "28"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (163,'2021-08-04 08:26:20.569536','27','Pedido Nro 27 - Paz Sol  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "29"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (164,'2021-08-04 08:28:00.113851','28','Pedido Nro 28 - Duran Andres  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "30"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (165,'2021-08-04 08:30:02.573432','29','Pedido Nro 29 - Duran Andres  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "31"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (166,'2021-08-04 08:35:12.061615','30','Pedido Nro 30 - Priscila Fernandez  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "32"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (167,'2021-08-04 16:47:15.266822','31','Pedido Nro 31 - Claudia Diaz  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "33"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (168,'2021-08-04 16:47:59.216441','10','CREAM / Stock   :10/Precio: 200.00','[{"changed": {"fields": ["Stock actual"]}}]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (169,'2021-08-04 16:48:09.670525','6','ETIQUETA NEGRA / Stock   :2/Precio: 200.00','[{"changed": {"fields": ["Stock actual"]}}]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (170,'2021-08-04 16:48:19.941283','3','FRUTILLA / Stock   :12/Precio: 200.00','[{"changed": {"fields": ["Stock actual"]}}]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (171,'2021-08-04 16:49:50.704442','5','Servicio Nro 5 - Candela Ricci  (disponible) $ 200.00','[]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (172,'2021-08-04 20:44:16.954269','1','dueño','[{"changed": {"fields": ["Username"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (173,'2021-08-04 21:38:40.750015','16','Jorge Perussi  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (174,'2021-08-04 21:42:23.972992','17','GUESS / Stock   :20/Precio: 250','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (175,'2021-08-04 21:42:42.672300','17','GUESS / Stock   :20/Precio: 250.00','[]',3,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (176,'2021-08-04 21:45:29.596004','32','Pedido Nro 32 - Jorge Perussi  (disponible) $ 4100.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "34"}}, {"added": {"name": "detalle pedido", "object": "35"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (177,'2021-08-04 21:47:57.767727','14','Nro de pago: 14','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (178,'2021-08-04 21:49:46.162325','14','Nro de pago: 14','[]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (179,'2021-08-04 21:50:24.345988','13','Jorge Perussi  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (180,'2021-08-04 21:53:06.623375','10','Servicio Nro 10 - Jorge Perussi  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "11"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (181,'2021-08-04 21:55:10.058907','5','Nro de pago: 5','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (182,'2021-08-09 03:03:31.423080','14','Jorge Perussi  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (183,'2021-08-09 03:03:31.567187','6','Almada Silvia  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (184,'2021-08-09 03:33:36.583530','33','Pedido Nro 33 - Almada Silvia  (disponible) $ 600.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "36"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (185,'2021-08-09 03:47:19.792337','34','Pedido Nro 34 - Almada Silvia  (disponible) $ 600.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "37"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (186,'2021-08-09 03:47:42.814674','35','Pedido Nro 35 - Almada Silvia  (disponible) $ 600.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "38"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (187,'2021-08-09 14:01:00.370065','11','Servicio Nro 11 - Fernandez Maria  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "12"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (188,'2021-08-10 21:48:14.197379','4','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "4"}}, {"added": {"name": "detalle presupuesto", "object": "5"}}, {"added": {"name": "detalle presupuesto", "object": "6"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (189,'2021-08-10 22:12:53.677804','4','Almada Silvia  (disponible)','[{"changed": {"fields": ["Email"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (190,'2021-08-10 22:13:10.037939','4','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (191,'2021-08-10 22:13:27.865231','5','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "7"}}, {"added": {"name": "detalle presupuesto", "object": "8"}}, {"added": {"name": "detalle presupuesto", "object": "9"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (192,'2021-08-10 22:15:20.316758','5','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (193,'2021-08-10 22:15:34.357467','6','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "10"}}, {"added": {"name": "detalle presupuesto", "object": "11"}}, {"added": {"name": "detalle presupuesto", "object": "12"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (194,'2021-08-10 22:25:39.778168','6','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (195,'2021-08-10 22:26:04.347532','7','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "13"}}, {"added": {"name": "detalle presupuesto", "object": "14"}}, {"added": {"name": "detalle presupuesto", "object": "15"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (196,'2021-08-10 22:26:44.859577','7','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (197,'2021-08-10 22:30:34.535303','8','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "16"}}, {"added": {"name": "detalle presupuesto", "object": "17"}}, {"added": {"name": "detalle presupuesto", "object": "18"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (198,'2021-08-10 22:31:41.413090','8','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (199,'2021-08-10 22:41:58.539256','9','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "19"}}, {"added": {"name": "detalle presupuesto", "object": "20"}}, {"added": {"name": "detalle presupuesto", "object": "21"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (200,'2021-08-10 22:44:04.127802','9','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (201,'2021-08-10 23:01:54.650169','10','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "22"}}, {"added": {"name": "detalle presupuesto", "object": "23"}}, {"added": {"name": "detalle presupuesto", "object": "24"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (202,'2021-08-10 23:04:28.457460','10','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (203,'2021-08-10 23:10:26.318469','11','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "25"}}, {"added": {"name": "detalle presupuesto", "object": "26"}}, {"added": {"name": "detalle presupuesto", "object": "27"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (204,'2021-08-10 23:14:26.222630','11','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (205,'2021-08-10 23:14:44.141921','12','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "28"}}, {"added": {"name": "detalle presupuesto", "object": "29"}}, {"added": {"name": "detalle presupuesto", "object": "30"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (206,'2021-08-10 23:14:49.874890','12','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (207,'2021-08-10 23:16:26.144956','13','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "31"}}, {"added": {"name": "detalle presupuesto", "object": "32"}}, {"added": {"name": "detalle presupuesto", "object": "33"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (208,'2021-08-10 23:16:34.770493','13','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (209,'2021-08-10 23:18:40.047006','14','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "34"}}, {"added": {"name": "detalle presupuesto", "object": "35"}}, {"added": {"name": "detalle presupuesto", "object": "36"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (210,'2021-08-10 23:19:24.250263','14','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (211,'2021-08-10 23:20:19.615454','15','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "37"}}, {"added": {"name": "detalle presupuesto", "object": "38"}}, {"added": {"name": "detalle presupuesto", "object": "39"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (212,'2021-08-10 23:20:27.150386','15','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (213,'2021-08-10 23:33:13.045898','16','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "40"}}, {"added": {"name": "detalle presupuesto", "object": "41"}}, {"added": {"name": "detalle presupuesto", "object": "42"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (214,'2021-08-10 23:37:48.557567','16','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (215,'2021-08-10 23:38:02.581917','17','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "43"}}, {"added": {"name": "detalle presupuesto", "object": "44"}}, {"added": {"name": "detalle presupuesto", "object": "45"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (216,'2021-08-10 23:41:41.116760','17','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (217,'2021-08-10 23:43:11.394469','18','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "46"}}, {"added": {"name": "detalle presupuesto", "object": "47"}}, {"added": {"name": "detalle presupuesto", "object": "48"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (218,'2021-08-10 23:45:38.050156','18','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (219,'2021-08-10 23:48:19.570568','19','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "49"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (220,'2021-08-10 23:48:57.771506','19','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (221,'2021-08-11 00:17:07.854785','20','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "50"}}, {"added": {"name": "detalle presupuesto", "object": "51"}}, {"added": {"name": "detalle presupuesto", "object": "52"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (222,'2021-08-11 00:17:42.287669','20','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (223,'2021-08-11 00:18:33.999690','21','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "53"}}, {"added": {"name": "detalle presupuesto", "object": "54"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (224,'2021-08-11 00:19:05.426283','21','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (225,'2021-08-11 00:20:18.619129','22','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "55"}}, {"added": {"name": "detalle presupuesto", "object": "56"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (226,'2021-08-11 00:20:57.114611','22','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (227,'2021-08-11 00:22:09.673639','23','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "57"}}, {"added": {"name": "detalle presupuesto", "object": "58"}}, {"added": {"name": "detalle presupuesto", "object": "59"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (228,'2021-08-11 00:22:58.638652','23','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (229,'2021-08-11 00:26:15.198684','24','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "60"}}, {"added": {"name": "detalle presupuesto", "object": "61"}}, {"added": {"name": "detalle presupuesto", "object": "62"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (230,'2021-08-11 12:39:44.802086','24','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (231,'2021-08-11 12:40:01.102839','25','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "63"}}, {"added": {"name": "detalle presupuesto", "object": "64"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (232,'2021-08-11 12:44:57.550575','25','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (233,'2021-08-11 12:53:03.429666','26','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "65"}}, {"added": {"name": "detalle presupuesto", "object": "66"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (234,'2021-08-11 12:53:12.193641','26','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (235,'2021-08-11 13:07:42.697517','4','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "67"}}, {"added": {"name": "detalle presupuesto", "object": "68"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (236,'2021-08-11 14:18:42.445824','4','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (237,'2021-08-11 14:18:57.872550','5','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "69"}}, {"added": {"name": "detalle presupuesto", "object": "70"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (238,'2021-08-11 14:21:26.309843','6','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "71"}}, {"added": {"name": "detalle presupuesto", "object": "72"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (239,'2021-08-11 15:36:34.648459','7','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "73"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (240,'2021-08-12 01:13:13.453856','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (241,'2021-08-12 01:13:26.793730','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (242,'2021-08-12 01:13:52.132588','8','Rodriguez Elena  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (243,'2021-08-12 01:14:07.948109','5','Almada Silvia  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (244,'2021-08-12 01:14:18.826345','8','Rodriguez Elena  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (245,'2021-08-12 01:14:30.197910','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (246,'2021-08-12 01:18:42.846989','11','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (247,'2021-08-12 01:19:10.224205','13','Jorge Perussi  (disponible)','',4,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (248,'2021-08-12 01:19:39.547712','12','Priscila Fernandez  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (249,'2021-08-12 01:19:52.494323','9','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (250,'2021-08-12 01:20:05.936268','10','Fernandez Mar  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (251,'2021-08-12 01:26:58.186525','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Zona"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (252,'2021-08-12 01:27:09.717195','5','Almada Silvia  (disponible)','[{"changed": {"fields": ["Zona"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (253,'2021-08-12 01:42:32.253930','4','Almada Silvia  (disponible)','[{"changed": {"fields": ["Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (254,'2021-08-12 01:42:43.763586','1','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (255,'2021-08-12 01:43:17.405967','10','Rodriguez Elena  (disponible)','[{"changed": {"fields": ["Zona"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (256,'2021-08-12 03:12:29.052248','8','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "74"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (257,'2021-08-12 03:30:53.530020','40','Pedido Nro 40 - Fernandez Mar  (disponible) $ 2100.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "44"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (258,'2021-08-12 03:38:23.655474','9','Candela Ricci  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "75"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (259,'2021-08-12 03:39:25.026303','10','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "76"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (260,'2021-08-12 03:40:16.976865','11','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "77"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (261,'2021-08-12 03:41:13.252301','12','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "78"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (262,'2021-08-12 03:43:06.499640','13','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "79"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (263,'2021-08-12 19:39:50.845108','17','Sirley Frank  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (264,'2021-08-12 19:40:51.210353','14','Sirley Frank  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "80"}}, {"added": {"name": "detalle presupuesto", "object": "81"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (265,'2021-08-12 19:44:14.345776','41','Pedido Nro 41 - Almada Silvia  (disponible) $ 1400.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "45"}}, {"added": {"name": "detalle pedido", "object": "46"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (266,'2021-08-12 19:48:22.446176','17','Sirley Frank  (disponible)','[{"changed": {"fields": ["Email"]}}]',1,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (267,'2021-08-12 19:49:30.842774','15','Sirley Frank  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "82"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (268,'2021-08-12 19:53:39.801746','42','Pedido Nro 42 - Sirley Frank  (disponible) $ 200.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "47"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (269,'2021-08-12 19:58:07.356116','15','Nro de pago: 15','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (270,'2021-08-12 20:00:22.971536','15','Sirley Frank  (disponible)','[{"changed": {"fields": ["Fecha"]}}]',4,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (271,'2021-08-12 20:03:38.104615','16','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "83"}}, {"added": {"name": "detalle presupuesto", "object": "84"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (272,'2021-08-12 20:04:00.046243','15','Sirley Frank  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (273,'2021-08-12 20:32:57.201346','6','Nro de pago: 6','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (274,'2021-08-12 21:48:04.003879','17','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "85"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (275,'2021-08-12 22:27:47.718307','18','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "86"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (276,'2021-08-12 22:42:25.579633','19','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "87"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (277,'2021-08-13 14:08:04.998381','20','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "88"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (278,'2021-08-16 15:34:45.971243','21','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "89"}}, {"added": {"name": "detalle presupuesto", "object": "90"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (279,'2021-08-17 01:49:10.469265','22','Almada Silvia  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "91"}}, {"added": {"name": "detalle presupuesto", "object": "92"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (280,'2021-08-17 02:04:01.967533','23','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "93"}}, {"added": {"name": "detalle presupuesto", "object": "94"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (281,'2021-08-17 02:23:07.973140','46','Pedido Nro 46 - Fernandez Mar  (disponible) $ 600.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "53"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (282,'2021-08-17 02:41:15.280067','47','Pedido Nro 47 - Fernandez Mar  (disponible) $ 700.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "54"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (283,'2021-08-17 02:52:00.346959','16','Nro de pago: 16','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (284,'2021-08-17 02:53:27.228748','17','Nro de pago: 17','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (285,'2021-08-17 14:53:50.182398','24','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "95"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (286,'2021-08-17 14:55:45.846201','25','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "96"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (287,'2021-08-17 15:22:41.731201','26','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "97"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (288,'2021-08-18 13:00:03.798601','16','Rodriguez Elena  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (289,'2021-08-18 13:00:23.549596','15','Fernandez Maria  (disponible)','[{"changed": {"fields": ["Observaciones"]}}]',7,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (290,'2021-08-18 13:12:58.254607','6','Servicio Nro 6 - Martorelli Liliana  (disponible) $ 1000.00','[{"changed": {"fields": ["Cliente"]}}]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (291,'2021-08-18 13:13:18.253162','11','Servicio Nro 11 - Solis Gabriel  (disponible) $ 200.00','[{"changed": {"fields": ["Cliente"]}}]',17,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (292,'2021-08-18 13:31:27.963457','45','CuentaCorriente object (45)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (293,'2021-08-18 13:31:28.179749','43','CuentaCorriente object (43)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (294,'2021-08-18 13:31:28.353865','42','CuentaCorriente object (42)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (295,'2021-08-18 13:31:28.594836','41','CuentaCorriente object (41)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (296,'2021-08-18 13:31:28.860712','38','CuentaCorriente object (38)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (297,'2021-08-18 13:31:29.227539','37','CuentaCorriente object (37)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (298,'2021-08-18 13:31:29.540644','36','CuentaCorriente object (36)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (299,'2021-08-18 13:31:29.864328','35','CuentaCorriente object (35)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (300,'2021-08-18 13:31:30.123465','34','CuentaCorriente object (34)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (301,'2021-08-18 13:31:30.497501','33','CuentaCorriente object (33)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (302,'2021-08-18 13:31:30.846573','32','CuentaCorriente object (32)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (303,'2021-08-18 13:31:31.084182','31','CuentaCorriente object (31)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (304,'2021-08-18 13:31:44.515664','22','CuentaCorriente object (22)','',10,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (305,'2021-08-18 13:43:53.649878','25','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (306,'2021-08-18 13:43:53.845580','24','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (307,'2021-08-18 13:43:54.005865','23','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (308,'2021-08-18 13:43:54.190750','21','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (309,'2021-08-18 13:43:54.348706','20','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (310,'2021-08-18 13:43:54.471284','19','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (311,'2021-08-18 13:43:54.655408','18','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (312,'2021-08-18 13:43:54.876350','17','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (313,'2021-08-18 13:43:55.112029','16','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (314,'2021-08-18 13:43:55.300295','13','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (315,'2021-08-18 13:43:55.482628','12','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (316,'2021-08-18 13:43:55.627120','11','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (317,'2021-08-18 13:43:55.818306','10','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (318,'2021-08-18 13:43:56.112504','8','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (319,'2021-08-18 13:43:56.347776','7','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (320,'2021-08-18 13:43:56.604934','6','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (321,'2021-08-18 13:43:56.827296','5','Almada Silvia  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (322,'2021-08-18 13:43:57.066162','3','Fernandez Mar  (disponible)','',5,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (323,'2021-08-18 17:00:13.535613','27','Solis Gabriela  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "98"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (324,'2021-08-18 17:00:43.380537','18','COCO / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (325,'2021-08-18 17:01:15.773162','19','JABON POLVO / Stock   :22/Precio: 300','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (326,'2021-08-18 17:01:43.702818','49','Pedido Nro 49 - Candela Ricci  (disponible) $ 600.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "56"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (327,'2021-08-18 17:02:17.435328','50','Pedido Nro 50 - Solis Gabriel  (disponible) $ 900.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "57"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (328,'2021-08-18 17:03:04.582813','12','Servicio Nro 12 - Paz Sol  (disponible) $ 250.00','[{"added": {}}, {"added": {"name": "detalle servicio", "object": "13"}}]',17,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (329,'2021-08-18 17:04:12.579196','18','Fernandez Sol  (disponible)','[{"added": {}}]',1,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (330,'2021-08-18 17:04:52.301718','51','Pedido Nro 51 - Fernandez Sol  (disponible) $ 750.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "58"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (331,'2021-08-18 17:05:22.758049','28','Payero Maria Laura  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "99"}}]',5,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (332,'2021-08-18 17:05:59.816791','20','SALMON / Stock   :20/Precio: 200','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (333,'2021-08-18 21:06:40.805696','51','Pedido Nro 51 - Fernandez Sol  (disponible) $ 750.00','[]',2,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (334,'2021-08-18 21:07:20.404094','52','Pedido Nro 52 - Candela Ricci  (disponible) $ 300.00','[{"added": {}}, {"added": {"name": "detalle pedido", "object": "59"}}]',2,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (335,'2021-08-18 21:35:01.950017','29','Fernandez Mar  (disponible)','[{"added": {}}, {"added": {"name": "detalle presupuesto", "object": "100"}}, {"added": {"name": "detalle presupuesto", "object": "101"}}]',5,1,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (1,1,200,200,1,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (2,2,200,400,2,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (3,2,200,400,NULL,6);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (4,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (5,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (6,1,200,200,NULL,12);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (7,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (8,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (9,1,300,300,NULL,8);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (10,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (11,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (12,1,300,300,NULL,8);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (13,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (14,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (15,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (16,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (17,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (18,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (19,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (20,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (21,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (22,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (23,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (24,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (25,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (26,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (27,3,200,600,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (28,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (29,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (30,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (31,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (32,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (33,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (34,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (35,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (36,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (37,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (38,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (39,3,200,600,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (40,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (41,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (42,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (43,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (44,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (45,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (46,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (47,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (48,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (49,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (50,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (51,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (52,3,200,600,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (53,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (54,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (55,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (56,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (57,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (58,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (59,1,200,200,NULL,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (60,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (61,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (62,1,200,200,NULL,6);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (63,2,200,400,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (64,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (65,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (66,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (67,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (68,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (69,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (70,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (71,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (72,2,200,400,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (73,1,300,300,NULL,8);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (74,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (75,1,200,200,9,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (76,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (77,1,200,200,NULL,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (78,1,200,200,NULL,6);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (79,1,200,200,NULL,9);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (80,2,250,500,14,17);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (81,2,200,400,14,5);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (82,2,300,600,NULL,8);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (83,2,250,500,NULL,17);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (84,2,200,400,NULL,15);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (85,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (86,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (87,1,500,500,NULL,2);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (88,1,700,700,NULL,7);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (89,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (90,2,300,600,NULL,8);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (91,13,200,2600,22,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (92,21,250,5250,22,4);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (93,2,200,400,NULL,9);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (94,1,250,250,NULL,13);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (95,4,200,800,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (96,2,200,400,NULL,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (97,1,200,200,26,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (98,1,200,200,27,3);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (99,1,200,200,28,9);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (100,1,200,200,29,1);
INSERT INTO "aromatizantes_detallepresupuesto" ("id","cantidad","precio_unitario","precio_total","presupuesto_id","producto_id") VALUES (101,1,200,200,29,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (1,1,200,200,1,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (2,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (3,2,200,400,NULL,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (4,1,500,500,NULL,2);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (5,2,200,400,5,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (6,1,200,200,NULL,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (7,1,200,200,7,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (8,1,200,200,8,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (9,2,200,400,9,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (10,15,200,3000,9,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (11,15,200,3000,10,10);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (12,5,200,1000,11,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (13,3,200,600,11,15);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (14,5,200,1000,12,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (15,1,500,500,13,2);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (16,1,200,200,14,9);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (17,1,300,300,15,8);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (18,1,200,200,16,9);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (19,1,200,200,17,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (20,1,200,200,18,6);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (21,1,200,200,19,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (22,1,200,200,20,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (23,1,250,250,21,13);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (24,1,200,200,22,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (25,1,200,200,23,9);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (26,1,250,250,24,13);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (27,1,250,250,25,14);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (28,1,300,300,26,8);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (29,1,200,200,27,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (30,1,200,200,28,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (31,1,200,200,29,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (32,1,200,200,30,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (33,1,200,200,31,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (34,3,200,600,32,5);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (35,5,700,3500,32,7);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (36,3,200,600,33,16);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (37,3,200,600,34,12);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (38,3,200,600,35,12);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (39,1,200,200,37,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (40,2,200,400,37,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (41,1,200,200,38,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (42,2,200,400,38,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (43,1,300,300,39,8);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (44,3,700,2100,40,7);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (45,2,500,1000,41,2);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (46,2,200,400,41,16);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (47,1,200,200,42,15);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (48,1,700,700,43,7);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (49,1,200,200,44,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (50,2,300,600,44,8);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (51,2,200,400,45,9);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (52,1,250,250,45,13);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (53,3,200,600,46,15);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (54,1,700,700,47,7);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (55,1,200,200,48,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (56,3,200,600,49,3);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (57,3,300,900,50,8);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (58,3,250,750,51,17);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (59,1,300,300,52,8);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (60,1,200,200,53,1);
INSERT INTO "aromatizantes_detallepedido" ("id","cantidad","precio_unitario","precio_total","pedido_id","producto_id") VALUES (61,1,200,200,53,3);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (1,200,200,0,1,1);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (2,200,200,0,2,NULL);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (3,400,400,0,2,NULL);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (4,500,500,0,2,NULL);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (5,400,400,0,4,5);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (6,200,200,0,2,NULL);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (7,200,200,0,10,7);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (8,200,200,0,2,8);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (9,3400,3400,0,2,9);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (10,3000,0,0,2,10);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (11,1600,1600,0,15,11);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (12,1000,0,0,3,12);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (13,500,0,0,7,13);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (14,200,0,0,3,14);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (15,300,0,0,8,15);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (16,200,0,0,1,16);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (17,200,0,0,2,17);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (18,200,0,0,6,18);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (19,200,0,0,8,19);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (20,200,0,0,4,20);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (21,250,0,0,1,21);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (23,200,0,0,9,23);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (24,250,0,0,15,24);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (25,250,0,0,9,25);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (26,300,0,0,8,26);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (27,200,0,0,14,27);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (28,200,0,0,8,28);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (29,200,0,0,7,31);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (30,4100,4100,0,16,32);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (39,1400,0,0,4,41);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (40,200,200,0,17,42);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (44,600,300,300,2,46);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (46,200,0,0,2,48);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (47,600,0,0,3,49);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (48,900,0,0,13,50);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (49,750,0,0,18,51);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (50,300,0,0,3,52);
INSERT INTO "aromatizantes_cuentacorriente" ("id","monto","pagado","restante","cliente_id","pedido_id") VALUES (51,400,0,0,2,53);
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'aromatizantes','cliente');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (2,'aromatizantes','pedido');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (3,'aromatizantes','producto');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (4,'aromatizantes','visita');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (5,'aromatizantes','presupuesto');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (6,'aromatizantes','pago');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (7,'aromatizantes','envio');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (8,'aromatizantes','detallepresupuesto');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (9,'aromatizantes','detallepedido');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (10,'aromatizantes','cuentacorriente');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (11,'admin','logentry');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (12,'auth','permission');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (13,'auth','group');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (14,'auth','user');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (15,'contenttypes','contenttype');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (16,'sessions','session');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (17,'aromatizantes','servicio');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (18,'aromatizantes','detalleservicio');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (19,'aromatizantes','pagoservicio');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (20,'aromatizantes','historicalcliente');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (21,'aromatizantes','historicalpresupuesto');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (22,'aromatizantes','historicaldetallepresupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_cliente','Can add cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (2,1,'change_cliente','Can change cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (3,1,'delete_cliente','Can delete cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (4,1,'view_cliente','Can view cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (5,2,'add_pedido','Can add pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (6,2,'change_pedido','Can change pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (7,2,'delete_pedido','Can delete pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (8,2,'view_pedido','Can view pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (9,3,'add_producto','Can add producto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (10,3,'change_producto','Can change producto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (11,3,'delete_producto','Can delete producto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (12,3,'view_producto','Can view producto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (13,4,'add_visita','Can add visita');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (14,4,'change_visita','Can change visita');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (15,4,'delete_visita','Can delete visita');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (16,4,'view_visita','Can view visita');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (17,5,'add_presupuesto','Can add presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (18,5,'change_presupuesto','Can change presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (19,5,'delete_presupuesto','Can delete presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (20,5,'view_presupuesto','Can view presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (21,6,'add_pago','Can add pago');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (22,6,'change_pago','Can change pago');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (23,6,'delete_pago','Can delete pago');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (24,6,'view_pago','Can view pago');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (25,7,'add_envio','Can add envio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (26,7,'change_envio','Can change envio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (27,7,'delete_envio','Can delete envio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (28,7,'view_envio','Can view envio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (29,8,'add_detallepresupuesto','Can add detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (30,8,'change_detallepresupuesto','Can change detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (31,8,'delete_detallepresupuesto','Can delete detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (32,8,'view_detallepresupuesto','Can view detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (33,9,'add_detallepedido','Can add detalle pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (34,9,'change_detallepedido','Can change detalle pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (35,9,'delete_detallepedido','Can delete detalle pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (36,9,'view_detallepedido','Can view detalle pedido');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (37,10,'add_cuentacorriente','Can add cuenta corriente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (38,10,'change_cuentacorriente','Can change cuenta corriente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (39,10,'delete_cuentacorriente','Can delete cuenta corriente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (40,10,'view_cuentacorriente','Can view cuenta corriente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (41,11,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (42,11,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (43,11,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (44,11,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (45,12,'add_permission','Can add permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (46,12,'change_permission','Can change permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (47,12,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (48,12,'view_permission','Can view permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (49,13,'add_group','Can add group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (50,13,'change_group','Can change group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (51,13,'delete_group','Can delete group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (52,13,'view_group','Can view group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (53,14,'add_user','Can add user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (54,14,'change_user','Can change user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (55,14,'delete_user','Can delete user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (56,14,'view_user','Can view user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (57,15,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (58,15,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (59,15,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (60,15,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (61,16,'add_session','Can add session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (62,16,'change_session','Can change session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (63,16,'delete_session','Can delete session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (64,16,'view_session','Can view session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (65,17,'add_servicio','Can add servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (66,17,'change_servicio','Can change servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (67,17,'delete_servicio','Can delete servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (68,17,'view_servicio','Can view servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (69,18,'add_detalleservicio','Can add detalle servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (70,18,'change_detalleservicio','Can change detalle servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (71,18,'delete_detalleservicio','Can delete detalle servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (72,18,'view_detalleservicio','Can view detalle servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (73,19,'add_pagoservicio','Can add pago servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (74,19,'change_pagoservicio','Can change pago servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (75,19,'delete_pagoservicio','Can delete pago servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (76,19,'view_pagoservicio','Can view pago servicio');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (77,20,'add_historicalcliente','Can add historical cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (78,20,'change_historicalcliente','Can change historical cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (79,20,'delete_historicalcliente','Can delete historical cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (80,20,'view_historicalcliente','Can view historical cliente');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (81,21,'add_historicalpresupuesto','Can add historical presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (82,21,'change_historicalpresupuesto','Can change historical presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (83,21,'delete_historicalpresupuesto','Can delete historical presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (84,21,'view_historicalpresupuesto','Can view historical presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (85,22,'add_historicaldetallepresupuesto','Can add historical detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (86,22,'change_historicaldetallepresupuesto','Can change historical detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (87,22,'delete_historicaldetallepresupuesto','Can delete historical detalle presupuesto');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (88,22,'view_historicaldetallepresupuesto','Can view historical detalle presupuesto');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (1,'pbkdf2_sha256$216000$NOgsUrvh9nCR$qxyxuy90OB0izSBoiS4Z7WnSNHxwjuI/vx/bnDGwVXo=','2021-08-26 01:29:43.625552',1,'dueño','','fernandezsol111@gmail.com',1,1,'2021-07-26 14:37:38','');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (2,'pbkdf2_sha256$216000$SI5dXBDMN0Bd$uVQ6ABCUrGV8DL6WVAfiMPFFFheGTV2PpU5REVPom6Y=','2021-08-18 14:39:56.363232',0,'empleado','','',1,1,'2021-07-28 06:59:42','');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('jp1cy9n90769hfg7s4or0a83s7ujzqcr','.eJxVjDsOwyAQBe9CHSGD-aZM7zMgdheCkwgkY1dR7h5bcpG0b2bem4W4rSVsPS1hJnZlkl1-N4j4TPUA9Ij13ji2ui4z8EPhJ-18apRet9P9Oyixl722ZEdDIHHwVknIIqbsnEYFoDV6bQWNzisj0ojCe8pulyJqC3kATIZ9vun3OHc:1m8s2K:b2AsXbSAg7E1WX1Q1lFZ0rzYMqj0Yk0WLkHPL8oAeZQ','2021-08-11 22:28:24.693409');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('1gwhqdmigzst2yomicsbzj0hvxz2xz3a','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mBK7E:8ZJJjUURVyYd4XK3j7YrS5kk_OyiRM9unQGfJEpJ_7g','2021-08-18 16:51:36.625383');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('vj4rmhqxdsg29jdhf8wfu4a1gsclcipd','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mBOYE:nkW_BSwiVs0Qr46PpfAWYwdVsgdF0VQysy0sOjrtap8','2021-08-18 21:35:46.260241');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('ccc74v98rh37hxpkytfdcn2cj2ducb0i','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mDbyV:Yjyydm8FcDHSOmO4fMiaT9_OxA6ZaMgqmW_iIUc9luo','2021-08-25 00:20:03.605139');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('7if7o2jz76qv0wxyvomj2paxj0vmrjeh','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mEJOV:CeBISfZhqG11keeHyoQL3v68Dp96xy8GokF1twNZ-mM','2021-08-26 22:41:47.163022');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('fcvmwrs6znyywcffkccf6rkq9pwub3df','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mGNSf:zNR0iLdFwdoNTsu5A8HTmvxFxgInyMFaplLeABSiles','2021-09-01 15:26:37.811230');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('rj8wcq7z0kjulcihc8ovtv81305hqbvq','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mGSkb:MFSRvLNmil3IBbR1Ndk2jo6iAc1v0iS3Mpx0fRfwA8A','2021-09-01 21:05:29.477142');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('a9vd14uak2s8zs2voerrgs6lrktpra62','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mIfYt:BB1ytwHtz7Fc5Yrj3SOsmhHcX4jGWpptIcUi4-yABVE','2021-09-07 23:10:31.858563');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('az74tu5ufj0gs4xm4qx0oaybu8ynypz2','.eJxVjDsOwjAQBe_iGln4t3Yo6XMGa727wQGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVFGXX63QrSQ6Yd8B2n26xpntZlLHpX9EGb7meW5_Vw_w4qtvqtBRgAMDlhjEQmeOjYIZwliLEYrfOGAtAQrU1Eg42YGBOg884X6dT7A-rYOAY:1mJ4D9:5qUzG1HTAGd48_fgiYpxuqRN3Jihi9cVemB23iTYzQg','2021-09-09 01:29:43.804671');
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (1,1,500,500,2,NULL);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (2,1,500,500,2,NULL);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (3,1,200,200,1,NULL);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (4,1,200,200,1,4);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (5,1,200,200,1,5);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (6,2,500,1000,2,6);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (7,3,200,600,1,7);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (8,2,200,400,8,8);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (9,1,200,200,10,9);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (10,1,500,500,2,9);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (11,1,200,200,12,10);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (12,1,200,200,16,11);
INSERT INTO "aromatizantes_detalleservicio" ("id","cantidad","precio_unitario","precio_total","producto_id","servicio_id") VALUES (13,1,250,250,4,12);
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (1,'DISPONIBLE',200,1,1,'2021-08-01');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (5,'DISPONIBLE',400,1,4,'2021-07-28');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (7,'DISPONIBLE',200,1,10,'2021-07-28');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (8,'DISPONIBLE',200,1,2,'2021-07-28');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (9,'DISPONIBLE',3400,1,2,'2021-08-01');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (10,'DISPONIBLE',3000,0,2,'2021-07-28');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (11,'DISPONIBLE',1600,1,15,'2021-08-03');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (12,'DISPONIBLE',1000,0,3,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (13,'DISPONIBLE',500,0,7,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (14,'DISPONIBLE',200,0,3,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (15,'DISPONIBLE',300,0,8,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (16,'DISPONIBLE',200,0,1,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (17,'DISPONIBLE',200,0,2,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (18,'DISPONIBLE',200,0,6,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (19,'DISPONIBLE',200,0,8,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (20,'DISPONIBLE',200,0,4,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (21,'DISPONIBLE',250,0,1,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (22,'DISPONIBLE',200,0,14,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (23,'DISPONIBLE',200,0,9,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (24,'DISPONIBLE',250,0,15,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (25,'DISPONIBLE',250,0,9,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (26,'DISPONIBLE',300,0,8,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (27,'DISPONIBLE',200,0,14,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (28,'DISPONIBLE',200,0,8,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (29,'EN ESPERA',200,0,8,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (30,'EN ESPERA',200,0,15,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (31,'DISPONIBLE',200,0,7,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (32,'DISPONIBLE',4100,1,16,'2021-08-04');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (33,'DISPONIBLE',600,0,4,'2021-08-09');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (34,'DISPONIBLE',600,0,4,'2021-08-09');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (35,'DISPONIBLE',600,0,4,'2021-08-09');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (36,'DISPONIBLE',0,0,4,'2021-08-11');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (37,'DISPONIBLE',600,0,4,'2021-08-11');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (38,'DISPONIBLE',600,0,4,'2021-08-11');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (39,'DISPONIBLE',300,0,2,'2021-08-11');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (40,'DISPONIBLE',2100,0,2,'2021-08-12');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (41,'DISPONIBLE',1400,0,4,'2021-08-12');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (42,'DISPONIBLE',200,1,17,'2021-08-12');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (43,'DISPONIBLE',700,0,2,'2021-08-13');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (44,'DISPONIBLE',800,0,2,'2021-08-16');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (45,'DISPONIBLE',650,0,2,'2021-08-16');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (46,'DISPONIBLE',600,0,2,'2021-08-16');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (47,'DISPONIBLE',700,1,2,'2021-08-16');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (48,'DISPONIBLE',200,0,2,'2021-08-18');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (49,'DISPONIBLE',600,0,3,'2021-08-18');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (50,'DISPONIBLE',900,0,13,'2021-08-18');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (51,'DISPONIBLE',750,0,18,'2021-08-18');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (52,'DISPONIBLE',300,0,3,'2021-08-18');
INSERT INTO "aromatizantes_pedido" ("id","estado","costo_total","pagado","cliente_id","fecha") VALUES (53,'DISPONIBLE',400,0,2,'2021-08-18');
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (4,'2021-06-23','DISPONIBLE',200,1,1,'2021-07-23','17:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (5,'2021-07-27','DISPONIBLE',200,1,3,'2021-08-26','08:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (6,'2021-07-27','DISPONIBLE',1000,1,6,'2021-08-26','08:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (7,'2021-07-28','DISPONIBLE',600,0,4,'2021-08-27','10:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (8,'2021-07-28','DISPONIBLE',400,1,2,'2021-08-27','09:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (9,'2021-08-03','DISPONIBLE',700,1,15,'2021-09-02','08:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (10,'2021-08-04','DISPONIBLE',200,1,16,'2021-09-03','09:00:00',30);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (11,'2021-08-09','DISPONIBLE',200,0,13,'2021-09-16','12:00:00',38);
INSERT INTO "aromatizantes_servicio" ("id","fecha","estado","costo_total","pagado","cliente_id","fecha_programada","hora","cantidad_dias") VALUES (12,'2021-08-19','DISPONIBLE',250,0,14,'2021-09-26','09:00:00',38);
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (1,'Fernandez Maria','3424624709','Alberdi 2532','17:00:00','20:00:00','fernandez11@icloud.com','SUR','2021-08-11',1,25409562335,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (2,'Fernandez Mar','4609069','Mitre 2345','09:00:00','16:00:00','fernandezsol111@gmail.com','CENTRO','2021-07-27',1,27409563446,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (3,'Candela Ricci','3424624709','Alberdi 2537','08:00:00','16:00:00','cricci@gmail.com','CENTRO','2021-07-27',1,25409562335,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (4,'Almada Silvia','154423633','La pampa 5153','10:00:00','21:00:00','franjo.cortes@gmail.com','NORTE','2021-08-11',1,60658880,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (5,'Solis Gabriela','3425231234','12 de octubre 1254','07:00:00','12:00:00','solis32gab@gmail.com','NORTE','2021-07-27',1,503435665,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (6,'Martorelli Liliana','155437646','San Martin 3090','08:00:00','16:00:00','lilianamarto@hotmail.com','CENTRO','2021-07-27',1,73543433,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (7,'Claudia Diaz','3422323454','Mitre 1423','15:00:00','19:00:00','diazclau@hotmail.com','NORTE','2021-07-27',1,60457654,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (8,'Duran Andres','4895922','Regis Martinez 4432','11:00:00','17:00:00','durAndrez33@gmail.com','NORTE','2021-07-27',1,5469383,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (9,'Payero Maria Laura','154061841','Lavaisse 2374','13:00:00','20:00:00','paye_lau@gmail.com','NORTE','2021-07-27',1,33496387,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (10,'Rodriguez Elena','342445563','Lavaisse 2333','14:00:00','18:00:00','rodriguez@gmail.com','CENTRO','2021-08-11',1,33496334,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (11,'Salas Pedro','4609065','Derqui 2345','20:00:00','21:00:00','salas@gmail.com','CENTRO','2021-07-27',0,27323333457,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (12,'Paez Graciela','4609065','Misiones 1234','16:00:00','21:00:00','paezgraciela11@gmail.com','SUR','2021-07-28',0,27323333457,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (13,'Solis Gabriel','3424624704','Alberdi 2532','12:00:00','16:00:00','solis32gabi@gmail.com','SUR','2021-07-28',1,25409562335,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (14,'Paz Sol','3425432324','Misiones 1234','09:00:00','19:00:00','pazsod@gmail.com','NORTE','2021-07-28',1,27323333454,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (15,'Priscila Fernandez','3424624709','salvador del carril 1820','08:00:00','16:00:00','prisciladfernandez@gmail.com','SUR','2021-08-03',1,4535456342,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (16,'Jorge Perussi','3424534565','Mitre 1234','09:00:00','16:00:00','jperusini@icop.edu.ar','SUR','2021-08-04',1,45334543,'no hay observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (17,'Sirley Frank','3424534565','Mitre 1234','11:00:00','16:00:00','sirleyvivianafrank@hotmail.com','SUR','2021-08-12',1,342435313,'sin observaciones');
INSERT INTO "aromatizantes_cliente" ("id","nombre_apellido","telefono","direccion","horario_disponible_desde","horario_disponible_hasta","email","zona","fecha_ingreso","dado_de_alta","cuit_cuil_DNI","observaciones") VALUES (18,'Fernandez Sol','3432445436','Salvador del carril 1818','11:00:00','16:00:00','fernandezsol111@gmail.com','NORTE','2021-08-18',1,3424323452,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (1,'ENTREGADO','2021-07-26','12:00:00',1,1,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (8,'ESPERA','2021-07-28','14:00:00',10,7,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (9,'ESPERA','2021-07-29','09:00:00',2,8,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (10,'ESPERA','2021-07-29','09:00:00',2,9,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (11,'ESPERA','2021-08-24','09:00:00',2,9,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (12,'ESPERA','2021-08-17','08:00:00',15,11,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (13,'ESPERA','2021-08-12','09:00:00',16,32,'no hay observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (14,'ESPERA','2021-07-26','12:00:00',1,1,'no hay');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (15,'ESPERA','2021-07-26','12:00:00',1,1,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (16,'ESPERA','2021-07-28','14:00:00',10,7,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (17,'ESPERA','2021-07-28','10:00:00',4,5,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (18,'ESPERA','2021-07-28','14:00:00',10,7,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (19,'ESPERA','2021-07-26','12:00:00',1,1,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (20,'ESPERA','2021-08-24','09:00:00',2,9,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (21,'ESPERA','2021-08-17','08:00:00',15,11,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (22,'ESPERA','2021-07-29','09:00:00',2,8,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (23,'ESPERA','2021-07-29','09:00:00',2,9,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (24,'ESPERA','2021-07-26','12:00:00',1,1,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (25,'ESPERA','2021-07-28','10:00:00',4,5,'sin observaciones');
INSERT INTO "aromatizantes_envio" ("id","estado","fecha","hora","cliente_id","pedido_id","observaciones") VALUES (26,'ESPERA','2021-08-16','11:00:00',17,42,'sin observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (1,'2021-07-26','EFECTIVO',200,'PAGO TOTAL',1,1,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (5,'2021-07-28','EFECTIVO',200,'PAGO PARCIAL',4,5,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (6,'2021-07-28','EFECTIVO',200,'PAGO PARCIAL',4,5,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (8,'2021-07-28','EFECTIVO',100,'PAGO PARCIAL',10,7,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (9,'2021-07-28','EFECTIVO',100,'PAGO TOTAL',10,7,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (10,'2021-07-28','EFECTIVO',200,'PAGO TOTAL',2,8,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (11,'2021-08-01','EFECTIVO',3400,'PAGO TOTAL',2,9,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (12,'2021-08-03','EFECTIVO',600,'PAGO PARCIAL',15,11,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (13,'2021-08-03','EFECTIVO',1000,'PAGO TOTAL',15,11,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (14,'2021-08-04','EFECTIVO',4100,'PAGO TOTAL',16,32,'no hay observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (15,'2021-08-12','EFECTIVO',200,'PAGO TOTAL',17,42,'sin observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (16,'2021-08-16','EFECTIVO',700,'PAGO TOTAL',2,47,'sin observaciones');
INSERT INTO "aromatizantes_pago" ("id","fecha","medio_pago","monto","estado","cliente_id","pedido_id","observaciones") VALUES (17,'2021-08-16','EFECTIVO',300,'PAGO PARCIAL',2,46,'sin observaciones');
INSERT INTO "aromatizantes_pagoservicio" ("id","fecha","medio_pago","monto","estado","cliente_id","servicio_id","observaciones") VALUES (1,'2021-07-27','EFECTIVO',200,'PAGO TOTAL',1,4,'no hay observaciones');
INSERT INTO "aromatizantes_pagoservicio" ("id","fecha","medio_pago","monto","estado","cliente_id","servicio_id","observaciones") VALUES (2,'2021-07-27','EFECTIVO',1000,'PAGO TOTAL',2,6,'no hay observaciones');
INSERT INTO "aromatizantes_pagoservicio" ("id","fecha","medio_pago","monto","estado","cliente_id","servicio_id","observaciones") VALUES (3,'2021-07-28','EFECTIVO',400,'PAGO TOTAL',2,8,'no hay observaciones');
INSERT INTO "aromatizantes_pagoservicio" ("id","fecha","medio_pago","monto","estado","cliente_id","servicio_id","observaciones") VALUES (4,'2021-08-03','EFECTIVO',1600,'PAGO TOTAL',15,9,'no hay observaciones');
INSERT INTO "aromatizantes_pagoservicio" ("id","fecha","medio_pago","monto","estado","cliente_id","servicio_id","observaciones") VALUES (5,'2021-08-04','EFECTIVO',200,'PAGO TOTAL',16,10,'no hay observaciones');
INSERT INTO "aromatizantes_pagoservicio" ("id","fecha","medio_pago","monto","estado","cliente_id","servicio_id","observaciones") VALUES (6,'2021-08-12','EFECTIVO',200,'PAGO TOTAL',3,5,'sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (1,200,1,'0','no hay observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (2,400,4,'0','no hay observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (9,200,3,'a4aee0e0-82a7-4f47-9e08-c98f4aaa0aa1','sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (14,900,17,'f6011a0d-2d52-4c0a-b8a5-b187ebfe1505','sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (22,7850,4,'20f5c1a7-629e-42f4-af90-458c5933e2fb','sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (26,200,2,'','sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (27,200,5,'ce0a9ba5-1a30-46e2-b7aa-f31f7f69017c','sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (28,200,9,'fae4650c-d2d5-499f-9ae3-614414e6ae96','sin observaciones');
INSERT INTO "aromatizantes_presupuesto" ("id","costo_total","cliente_id","clave","observaciones") VALUES (29,400,2,'','sin observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (1,'AMOUR',200,'AROMA',1,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (2,'D.ANALOGICO',500,'DISPENSER',11,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (3,'FRUTILLA',200,'AROMA',9,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (4,'DETERGENTE 5LT',250,'P.LIMPIEZA',19,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (5,'LAVANDA',200,'AROMA',5,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (6,'ETIQUETA NEGRA',200,'AROMA',2,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (7,'D.DIGITAL',700,'DISPENSER',11,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (8,'LIMON',300,'AROMA',13,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (9,'SUIT',200,'AROMA',17,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (10,'CREAM',200,'AROMA',10,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (11,'FRESH',200,'AROMA',15,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (12,'KEN',200,'AROMA',13,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (13,'LAVANDINA 5LT',250,'P.LIMPIEZA',18,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (14,'JABON LIQUIDO ARIEL 5LT',250,'P.LIMPIEZA',19,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (15,'BAMBU',200,'AROMA',13,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (16,'durazno',200,'AROMA',29,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (17,'GUESS',250,'AROMA',17,5,'no hay observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (18,'COCO',200,'AROMA',20,5,'sin observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (19,'JABON POLVO',300,'P.LIMPIEZA',22,5,'sin observaciones');
INSERT INTO "aromatizantes_producto" ("id","nombre_aroma","precio","categoria","stock_actual","stock_minimo","observaciones") VALUES (20,'SALMON',200,'AROMA',20,5,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (1,'DISPONIBLE','2021-07-26','12:00:00','SUR',1,1,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (5,'DISPONIBLE','2021-07-28','10:00:00','NORTE',4,5,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (8,'DISPONIBLE','2021-07-28','14:00:00','CENTRO',10,7,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (9,'DISPONIBLE','2021-07-29','09:00:00','CENTRO',2,8,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (10,'DISPONIBLE','2021-07-29','09:00:00','CENTRO',2,9,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (11,'DISPONIBLE','2021-08-24','09:00:00','CENTRO',2,9,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (12,'DISPONIBLE','2021-08-17','08:00:00','CENTRO',15,11,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (15,'DISPONIBLE','2021-08-16','11:00:00','CENTRO',17,42,'sin observaciones');
INSERT INTO "aromatizantes_visita" ("id","estado","fecha","hora","zona","cliente_id","pedido_id","observaciones") VALUES (16,'DISPONIBLE',NULL,'09:00:00','CENTRO',2,47,'sin observaciones');
INSERT INTO "aromatizantes_historicaldetallepresupuesto" ("id","cantidad","precio_unitario","precio_total","history_id","history_date","history_change_reason","history_type","history_user_id","presupuesto_id","producto_id") VALUES (98,1,200,200,1,'2021-08-18 17:00:06.856163',NULL,'+',1,27,3);
INSERT INTO "aromatizantes_historicaldetallepresupuesto" ("id","cantidad","precio_unitario","precio_total","history_id","history_date","history_change_reason","history_type","history_user_id","presupuesto_id","producto_id") VALUES (99,1,200,200,2,'2021-08-18 17:05:18.923491',NULL,'+',1,28,9);
INSERT INTO "aromatizantes_historicaldetallepresupuesto" ("id","cantidad","precio_unitario","precio_total","history_id","history_date","history_change_reason","history_type","history_user_id","presupuesto_id","producto_id") VALUES (100,1,200,200,3,'2021-08-18 21:34:58.016392',NULL,'+',1,29,1);
INSERT INTO "aromatizantes_historicaldetallepresupuesto" ("id","cantidad","precio_unitario","precio_total","history_id","history_date","history_change_reason","history_type","history_user_id","presupuesto_id","producto_id") VALUES (101,1,200,200,4,'2021-08-18 21:34:58.043411',NULL,'+',1,29,3);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (25,400,'sin observaciones','c16d2429-66d0-4113-9c22-bb220a6b7232',1,'2021-08-18 13:43:57.279168',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (24,800,'sin observaciones','cb500f19-24ed-413c-b534-ecfb097bd55d',2,'2021-08-18 13:43:57.311188',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (23,650,'sin observaciones','',3,'2021-08-18 13:43:57.313190',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (21,800,'sin observaciones','',4,'2021-08-18 13:43:57.317194',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (20,700,'sin observaciones','',5,'2021-08-18 13:43:57.320194',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (19,500,'sin observaciones','77e63e4c-d32a-4363-a335-3802cd82c4dc',6,'2021-08-18 13:43:57.322195',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (18,200,'sin observaciones','73682989-89cc-46e5-aa7e-c0f1ac665cc3',7,'2021-08-18 13:43:57.324197',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (17,200,'sin observaciones','49878156-f808-4ab0-b895-58819337d185',8,'2021-08-18 13:43:57.326198',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (16,900,'sin observaciones','47baca95-4fbe-4809-a1cc-1c8e583c09c2',9,'2021-08-18 13:43:57.328201',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (13,200,'sin observaciones','1c216485-f92c-4f22-b11c-c45fad7a37a1',10,'2021-08-18 13:43:57.331202',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (12,200,'sin observaciones','3198feb1-1b3d-4ead-8795-9752e2078d5d',11,'2021-08-18 13:43:57.333203',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (11,200,'sin observaciones','4a72acb1-2d93-4600-8feb-b3d23363c0a7',12,'2021-08-18 13:43:57.336207',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (10,200,'sin observaciones','115aa0db-4dd6-476d-9fdd-35db4c541025',13,'2021-08-18 13:43:57.338208',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (8,200,'sin observaciones','8c8f08e5-d30b-47d4-95e7-8a3ab5e70bb3',14,'2021-08-18 13:43:57.342210',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (7,300,'no hay observaciones','',15,'2021-08-18 13:43:57.345212',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (6,600,'no hay observaciones','27a33d6c-eb84-4937-bc56-5c1419a5ec45',16,'2021-08-18 13:43:57.349215',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (5,600,'no hay observaciones','5c7644ea-3038-4fe6-a62a-d6cb2e1ded25',17,'2021-08-18 13:43:57.352217',NULL,'-',4,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (3,400,'no hay observaciones','0',18,'2021-08-18 13:43:57.354218',NULL,'-',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (26,200,'sin observaciones','',19,'2021-08-18 13:46:18.210950',NULL,'~',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (27,0,'sin observaciones','',20,'2021-08-18 17:00:06.805120',NULL,'+',5,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (27,200,'sin observaciones','',21,'2021-08-18 17:00:06.877169',NULL,'~',5,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (27,200,'sin observaciones','ce0a9ba5-1a30-46e2-b7aa-f31f7f69017c',22,'2021-08-18 17:00:06.885187',NULL,'~',5,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (28,0,'sin observaciones','',23,'2021-08-18 17:05:18.918486',NULL,'+',9,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (28,200,'sin observaciones','',24,'2021-08-18 17:05:18.938510',NULL,'~',9,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (28,200,'sin observaciones','fae4650c-d2d5-499f-9ae3-614414e6ae96',25,'2021-08-18 17:05:18.946515',NULL,'~',9,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (29,0,'sin observaciones','',26,'2021-08-18 21:34:57.953351',NULL,'+',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (29,200,'sin observaciones','',27,'2021-08-18 21:34:58.039408',NULL,'~',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (29,400,'sin observaciones','',28,'2021-08-18 21:34:58.058423',NULL,'~',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (29,400,'sin observaciones','7aad1632-99e5-4eaa-abb6-82237a3d941a',29,'2021-08-18 21:34:58.087441',NULL,'~',2,1);
INSERT INTO "aromatizantes_historicalpresupuesto" ("id","costo_total","observaciones","clave","history_id","history_date","history_change_reason","history_type","cliente_id","history_user_id") VALUES (29,400,'sin observaciones','',30,'2021-08-18 21:35:51.687171',NULL,'~',2,1);
DROP INDEX IF EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_group_id_b120cbf9";
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_permission_id_84c5c92e";
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
DROP INDEX IF EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
DROP INDEX IF EXISTS "auth_user_groups_user_id_6a12ed8b";
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
DROP INDEX IF EXISTS "auth_user_groups_group_id_97559544";
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_a95ead1b";
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c";
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
DROP INDEX IF EXISTS "django_admin_log_content_type_id_c4bce8eb";
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
DROP INDEX IF EXISTS "django_admin_log_user_id_c564eba6";
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
DROP INDEX IF EXISTS "aromatizantes_detallepresupuesto_presupuesto_id_29c2e1f1";
CREATE INDEX IF NOT EXISTS "aromatizantes_detallepresupuesto_presupuesto_id_29c2e1f1" ON "aromatizantes_detallepresupuesto" (
	"presupuesto_id"
);
DROP INDEX IF EXISTS "aromatizantes_detallepresupuesto_producto_id_fac31ce2";
CREATE INDEX IF NOT EXISTS "aromatizantes_detallepresupuesto_producto_id_fac31ce2" ON "aromatizantes_detallepresupuesto" (
	"producto_id"
);
DROP INDEX IF EXISTS "aromatizantes_detallepedido_pedido_id_4687b35d";
CREATE INDEX IF NOT EXISTS "aromatizantes_detallepedido_pedido_id_4687b35d" ON "aromatizantes_detallepedido" (
	"pedido_id"
);
DROP INDEX IF EXISTS "aromatizantes_detallepedido_producto_id_6b05c2ff";
CREATE INDEX IF NOT EXISTS "aromatizantes_detallepedido_producto_id_6b05c2ff" ON "aromatizantes_detallepedido" (
	"producto_id"
);
DROP INDEX IF EXISTS "aromatizantes_cuentacorriente_cliente_id_a778abeb";
CREATE INDEX IF NOT EXISTS "aromatizantes_cuentacorriente_cliente_id_a778abeb" ON "aromatizantes_cuentacorriente" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_cuentacorriente_pedido_id_77f8948a";
CREATE INDEX IF NOT EXISTS "aromatizantes_cuentacorriente_pedido_id_77f8948a" ON "aromatizantes_cuentacorriente" (
	"pedido_id"
);
DROP INDEX IF EXISTS "django_content_type_app_label_model_76bd3d3b_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
DROP INDEX IF EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
DROP INDEX IF EXISTS "auth_permission_content_type_id_2f476e4b";
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
DROP INDEX IF EXISTS "django_session_expire_date_a5c62663";
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
DROP INDEX IF EXISTS "aromatizantes_detalleservicio_producto_id_28c7833b";
CREATE INDEX IF NOT EXISTS "aromatizantes_detalleservicio_producto_id_28c7833b" ON "aromatizantes_detalleservicio" (
	"producto_id"
);
DROP INDEX IF EXISTS "aromatizantes_detalleservicio_servicio_id_b6737dbf";
CREATE INDEX IF NOT EXISTS "aromatizantes_detalleservicio_servicio_id_b6737dbf" ON "aromatizantes_detalleservicio" (
	"servicio_id"
);
DROP INDEX IF EXISTS "aromatizantes_pedido_cliente_id_99008e7b";
CREATE INDEX IF NOT EXISTS "aromatizantes_pedido_cliente_id_99008e7b" ON "aromatizantes_pedido" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_servicio_cliente_id_ec1c5c02";
CREATE INDEX IF NOT EXISTS "aromatizantes_servicio_cliente_id_ec1c5c02" ON "aromatizantes_servicio" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_envio_cliente_id_1df2a0a3";
CREATE INDEX IF NOT EXISTS "aromatizantes_envio_cliente_id_1df2a0a3" ON "aromatizantes_envio" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_envio_pedido_id_27d49f35";
CREATE INDEX IF NOT EXISTS "aromatizantes_envio_pedido_id_27d49f35" ON "aromatizantes_envio" (
	"pedido_id"
);
DROP INDEX IF EXISTS "aromatizantes_pago_cliente_id_606f3ae2";
CREATE INDEX IF NOT EXISTS "aromatizantes_pago_cliente_id_606f3ae2" ON "aromatizantes_pago" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_pago_pedido_id_78735552";
CREATE INDEX IF NOT EXISTS "aromatizantes_pago_pedido_id_78735552" ON "aromatizantes_pago" (
	"pedido_id"
);
DROP INDEX IF EXISTS "aromatizantes_pagoservicio_cliente_id_da566988";
CREATE INDEX IF NOT EXISTS "aromatizantes_pagoservicio_cliente_id_da566988" ON "aromatizantes_pagoservicio" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_pagoservicio_servicio_id_936390d0";
CREATE INDEX IF NOT EXISTS "aromatizantes_pagoservicio_servicio_id_936390d0" ON "aromatizantes_pagoservicio" (
	"servicio_id"
);
DROP INDEX IF EXISTS "aromatizantes_presupuesto_cliente_id_0c6bf9d0";
CREATE INDEX IF NOT EXISTS "aromatizantes_presupuesto_cliente_id_0c6bf9d0" ON "aromatizantes_presupuesto" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_visita_cliente_id_0dae0ddb";
CREATE INDEX IF NOT EXISTS "aromatizantes_visita_cliente_id_0dae0ddb" ON "aromatizantes_visita" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_visita_pedido_id_785c9a9a";
CREATE INDEX IF NOT EXISTS "aromatizantes_visita_pedido_id_785c9a9a" ON "aromatizantes_visita" (
	"pedido_id"
);
DROP INDEX IF EXISTS "aromatizantes_historicaldetallepresupuesto_id_9a72090c";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicaldetallepresupuesto_id_9a72090c" ON "aromatizantes_historicaldetallepresupuesto" (
	"id"
);
DROP INDEX IF EXISTS "aromatizantes_historicaldetallepresupuesto_history_user_id_64e9e1e2";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicaldetallepresupuesto_history_user_id_64e9e1e2" ON "aromatizantes_historicaldetallepresupuesto" (
	"history_user_id"
);
DROP INDEX IF EXISTS "aromatizantes_historicaldetallepresupuesto_presupuesto_id_4703e0be";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicaldetallepresupuesto_presupuesto_id_4703e0be" ON "aromatizantes_historicaldetallepresupuesto" (
	"presupuesto_id"
);
DROP INDEX IF EXISTS "aromatizantes_historicaldetallepresupuesto_producto_id_a6440b11";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicaldetallepresupuesto_producto_id_a6440b11" ON "aromatizantes_historicaldetallepresupuesto" (
	"producto_id"
);
DROP INDEX IF EXISTS "aromatizantes_historicalpresupuesto_id_8fc414c1";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicalpresupuesto_id_8fc414c1" ON "aromatizantes_historicalpresupuesto" (
	"id"
);
DROP INDEX IF EXISTS "aromatizantes_historicalpresupuesto_cliente_id_a257c5ee";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicalpresupuesto_cliente_id_a257c5ee" ON "aromatizantes_historicalpresupuesto" (
	"cliente_id"
);
DROP INDEX IF EXISTS "aromatizantes_historicalpresupuesto_history_user_id_91f35970";
CREATE INDEX IF NOT EXISTS "aromatizantes_historicalpresupuesto_history_user_id_91f35970" ON "aromatizantes_historicalpresupuesto" (
	"history_user_id"
);
COMMIT;
