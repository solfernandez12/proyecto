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
