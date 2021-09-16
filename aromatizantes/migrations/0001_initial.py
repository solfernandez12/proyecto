# Generated by Django 3.1 on 2021-09-01 20:19

import aromatizantes.models
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import simple_history.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Cliente',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre_apellido', models.CharField(max_length=100, validators=[aromatizantes.models.only_letters], verbose_name='Apellido Nombre')),
                ('cuit_cuil_DNI', models.IntegerField()),
                ('telefono', models.CharField(max_length=100, validators=[aromatizantes.models.only_numbers])),
                ('direccion', models.CharField(max_length=120, verbose_name='dirección')),
                ('horario_disponible_desde', models.TimeField(help_text='Horario disponible', verbose_name='desde')),
                ('horario_disponible_hasta', models.TimeField(help_text='Horario disponible', verbose_name='hasta')),
                ('email', models.CharField(max_length=150, verbose_name='email')),
                ('zona', models.CharField(choices=[('SUR', 'SUR'), ('NORTE', 'NORTE'), ('CENTRO', 'CENTRO')], default='SUR', max_length=20, verbose_name='Zona')),
                ('fecha_ingreso', models.DateField(auto_now=True)),
                ('dado_de_alta', models.BooleanField(default=True)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
            ],
            options={
                'verbose_name_plural': '1. Clientes',
                'ordering': ['nombre_apellido'],
            },
        ),
        migrations.CreateModel(
            name='Pedido',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fecha', models.DateField(auto_now=True)),
                ('estado', models.CharField(choices=[('EN ESPERA', 'EN ESPERA'), ('DISPONIBLE', 'DISPONIBLE')], default='EN ESPERA', max_length=30)),
                ('costo_total', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10, null=True)),
                ('pagado', models.BooleanField()),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
            ],
            options={
                'verbose_name_plural': '3. Pedidos',
                'ordering': ['id'],
            },
        ),
        migrations.CreateModel(
            name='Producto',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre_aroma', models.CharField(max_length=100, verbose_name='Nombre')),
                ('precio', models.DecimalField(decimal_places=2, max_digits=10)),
                ('categoria', models.CharField(choices=[('AROMA', 'AROMA'), ('DISPENSER', 'DISPENSER'), ('P.LIMPIEZA', 'P.LIMPIEZA')], default='AROMA', max_length=20, verbose_name='Categoria')),
                ('stock_actual', models.IntegerField()),
                ('stock_minimo', models.IntegerField(default=5)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
            ],
            options={
                'verbose_name_plural': '2. Productos',
                'ordering': ['categoria'],
            },
        ),
        migrations.CreateModel(
            name='Visita',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('estado', models.CharField(choices=[('ESPERA', 'EN ESPERA'), ('SUSPENDIDA', 'SUSPENDIDA'), ('DISPONIBLE', 'DISPONIBLE')], max_length=20)),
                ('fecha', models.DateField(null=True)),
                ('hora', models.TimeField(null=True)),
                ('zona', models.CharField(choices=[('SUR', 'SUR'), ('NORTE', 'NORTE'), ('CENTRO', 'CENTRO')], default='CENTRO', max_length=20)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
                ('pedido', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.pedido')),
            ],
            options={
                'verbose_name_plural': '5. Visitas',
                'ordering': ['fecha'],
            },
        ),
        migrations.CreateModel(
            name='Servicio',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fecha', models.DateField()),
                ('cantidad_dias', models.SmallIntegerField(default=38, verbose_name='Plazo para proxima Visita')),
                ('fecha_programada', models.DateField(blank=True, null=True, verbose_name='Fecha programada para proxima visita')),
                ('hora', models.TimeField(blank=True, help_text='Horario disponible', null=True, verbose_name='hora')),
                ('estado', models.CharField(choices=[('EN ESPERA', 'EN ESPERA'), ('DISPONIBLE', 'DISPONIBLE')], default='EN ESPERA', max_length=30)),
                ('costo_total', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10, null=True)),
                ('pagado', models.BooleanField()),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
            ],
            options={
                'verbose_name_plural': '7. Servicios',
                'ordering': ['id'],
            },
        ),
        migrations.CreateModel(
            name='Presupuesto',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('costo_total', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10, null=True)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
                ('clave', models.CharField(default='', max_length=36)),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
            ],
        ),
        migrations.CreateModel(
            name='PagoServicio',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('monto', models.DecimalField(decimal_places=2, max_digits=10)),
                ('fecha', models.DateField(auto_now=True)),
                ('medio_pago', models.CharField(choices=[('EFECTIVO', 'EFECTIVO'), ('TRANSFERENCIA', 'TRANSFERENCIA'), ('CREDITO', 'CRÉDITO'), ('DEBITO', 'DÉBITO')], default='efectivo', max_length=15)),
                ('estado', models.CharField(choices=[('PAGO PARCIAL', 'PAGO PARCIAL'), ('PAGO TOTAL', 'PAGO TOTAL')], default='PAGO PARCIAL', max_length=15)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
                ('servicio', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.servicio')),
            ],
            options={
                'verbose_name_plural': '8. Pagos Servicios',
            },
        ),
        migrations.CreateModel(
            name='Pago',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('monto', models.DecimalField(decimal_places=2, default=0, max_digits=10)),
                ('medio_pago', models.CharField(choices=[('EFECTIVO', 'EFECTIVO'), ('TRANSFERENCIA', 'TRANSFERENCIA'), ('CREDITO', 'CRÉDITO'), ('DEBITO', 'DÉBITO')], default='efectivo', max_length=15)),
                ('fecha', models.DateField(auto_now=True)),
                ('estado', models.CharField(choices=[('PAGO PARCIAL', 'PAGO PARCIAL'), ('PAGO TOTAL', 'PAGO TOTAL')], default='PAGO PARCIAL', max_length=15)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
                ('pedido', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.pedido')),
            ],
            options={
                'verbose_name_plural': '4. Pagos',
            },
        ),
        migrations.CreateModel(
            name='HistoricalPresupuesto',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('costo_total', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10, null=True)),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
                ('clave', models.CharField(default='', max_length=36)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('cliente', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='aromatizantes.cliente')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Historial Presupuesto',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='HistoricalDetallePresupuesto',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('cantidad', models.IntegerField()),
                ('precio_unitario', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10)),
                ('precio_total', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('presupuesto', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='aromatizantes.presupuesto')),
                ('producto', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='aromatizantes.producto')),
            ],
            options={
                'verbose_name': 'Historial Detalle Presupuesto',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Envio',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('estado', models.CharField(choices=[('ESPERA', 'ESPERA'), ('ENTREGADO', 'ENTREGADO')], default='ESPERA', max_length=20)),
                ('fecha', models.DateField()),
                ('hora', models.TimeField()),
                ('observaciones', models.CharField(default='sin observaciones', max_length=100)),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
                ('pedido', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.pedido')),
            ],
            options={
                'verbose_name_plural': '6. Envios',
            },
        ),
        migrations.CreateModel(
            name='DetalleServicio',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.IntegerField()),
                ('precio_unitario', models.DecimalField(blank=True, decimal_places=2, max_digits=10)),
                ('precio_total', models.DecimalField(blank=True, decimal_places=2, max_digits=10)),
                ('producto', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.producto')),
                ('servicio', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.servicio')),
            ],
        ),
        migrations.CreateModel(
            name='DetallePresupuesto',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.IntegerField()),
                ('precio_unitario', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10)),
                ('precio_total', models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10)),
                ('presupuesto', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.presupuesto')),
                ('producto', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.producto')),
            ],
        ),
        migrations.CreateModel(
            name='DetallePedido',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.IntegerField()),
                ('precio_unitario', models.DecimalField(blank=True, decimal_places=2, max_digits=10)),
                ('precio_total', models.DecimalField(blank=True, decimal_places=2, max_digits=10)),
                ('pedido', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.pedido')),
                ('producto', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.producto')),
            ],
        ),
        migrations.CreateModel(
            name='CuentaCorriente',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('monto', models.DecimalField(decimal_places=2, max_digits=10)),
                ('pagado', models.DecimalField(decimal_places=2, max_digits=10)),
                ('restante', models.DecimalField(decimal_places=2, max_digits=10)),
                ('cliente', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.cliente')),
                ('pedido', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='aromatizantes.pedido')),
            ],
        ),
    ]
