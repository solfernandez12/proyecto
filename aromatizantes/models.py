
from django.core.checks import messages
from django.db import models
from django.core.exceptions import ValidationError
from datetime import date, timedelta
from simple_history.models import HistoricalRecords
from django.core.mail import send_mail, EmailMessage
from django.conf import settings
import re
import random
from django.db.models import expressions
from django.db.models.fields import BooleanField, DateField
from datetime import datetime , timedelta
from djqscsv import render_to_csv_response
import os
# Create your models here.


def envioMail(subject,message,recipient_list):
    email_from = settings.EMAIL_HOST_USER
    send_mail(subject, message, email_from, recipient_list)


def only_letters(value):
    """ Solo letras y espacios.
    :param value: str
    """
    regex = re.compile(r"[A-Za-z\sñÑáéíóúÁÉÍÓÚ]+")

    if not regex.fullmatch(value):
        raise ValidationError("reingresar nombre, solo letras y espacios ")


def only_numbers(value):
    """ Solo números.
    :param value: str
    """
    if not value.isnumeric():
        raise ValidationError("Solo se permiten números.")

class Cliente(models.Model):
    nombre_apellido = models.CharField(
        max_length=100, verbose_name='Apellido Nombre', validators=[only_letters])
    cuit_cuil_DNI = models.IntegerField()
    telefono = models.CharField(max_length=100, validators=[only_numbers])
    direccion = models.CharField(max_length=120, verbose_name='dirección')
    horario_disponible_desde = models.TimeField(
        help_text='Horario disponible', verbose_name='desde')
    horario_disponible_hasta = models.TimeField(
        help_text='Horario disponible', verbose_name='hasta')
    email = models.CharField(max_length=150, verbose_name='email')
    zona_choices = (
        ('SUR', 'SUR'),
        ('NORTE', 'NORTE'),
        ('CENTRO', 'CENTRO'),
    )
    zona = models.CharField('Zona', max_length=20,
                            choices=zona_choices, default='SUR')
    fecha_ingreso = models.DateField(auto_now=True, auto_now_add = False )
    # history = HistoricalRecords()
    dado_de_alta = models.BooleanField(default =True)
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')

    def __str__(self):
        txt="{0}  {2}"
        if self.dado_de_alta: 
            estadoCliente="(disponible)"
        else:
            estadoCliente= "(no disponible)"

        return txt.format(self.nombre_apellido , self.dado_de_alta, estadoCliente) 

     
    class Meta:
        verbose_name_plural = "1. Clientes"
        ordering = ['nombre_apellido']


class Producto(models.Model):

    nombre_aroma = models.CharField('Nombre',max_length=100)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    categoria_choices = (
        ('AROMA', 'AROMA'),
        ('DISPENSER', 'DISPENSER'),
        ('P.LIMPIEZA','P.LIMPIEZA'),
    )
    categoria = models.CharField('Categoria', max_length=20,
                            choices= categoria_choices, default='AROMA')
    stock_actual = models.IntegerField()
    stock_minimo = models.IntegerField(default=5)
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')

    def __str__(self):
        return str(self.nombre_aroma)+' ' +'/ Stock '+'  :'+ str(self.stock_actual) + '/Precio: ' + str(self.precio)

    class Meta:
        verbose_name_plural = "2. Productos"
        ordering = ['nombre_aroma']
        ordering = ['categoria']
    

class Pedido (models.Model):

    class Meta:
        verbose_name_plural = "3. Pedidos"
        ordering = ['id']
    fecha = models.DateField(auto_now=True, auto_now_add = False)   
    estadopedido = (('EN ESPERA', 'EN ESPERA'), ('DISPONIBLE', 'DISPONIBLE'))
    estado = models.CharField(
        max_length=30, choices=estadopedido, default='EN ESPERA')
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    costo_total = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True, null=True, default=0)
    
    pagado = models.BooleanField()

    def __str__(self):
        return "Pedido Nro " + str(self.pk)+' - ' + str(self.cliente)+ " $ " + str(self.costo_total)

    def save(self, *args, **kwargs):
        self.estado = "DISPONIBLE"
        super(Pedido, self).save(*args, **kwargs)
        
        cuentas_corriente = CuentaCorriente.objects.filter(pedido=self)
        if not cuentas_corriente:
            CuentaCorriente.objects.create(
                cliente=self.cliente,
                monto=self.costo_total,
                pagado=0.0,
                restante=0.0,
                pedido=self,
            )
        else:
            cuentas_corriente[0].monto = self.costo_total
            cuentas_corriente[0].save()
  
class DetallePedido(models.Model):
    pedido = models.ForeignKey(
        Pedido, on_delete=models.SET_NULL, null=True)
    producto = models.ForeignKey(
        Producto, on_delete=models.SET_NULL, null=True)
    cantidad = models.IntegerField()
    precio_unitario = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True)
    precio_total = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True)

    def __str__(self):
        return str(self.pk)

    def save(self, *args, **kwargs):
        

        self.precio_unitario = self.producto.precio
        self.precio_total = self.producto.precio * self.cantidad

        super(DetallePedido, self).save(*args, **kwargs)

        detalles = DetallePedido.objects.filter(pedido=self.pedido)
        costo_total = 0

        for detalle in detalles:
            costo_total += detalle.precio_unitario * detalle.cantidad

        self.pedido.costo_total = costo_total
        self.pedido.save()
    


class CuentaCorriente(models.Model):
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    pagado = models.DecimalField(max_digits=10, decimal_places=2)
    restante = models.DecimalField(max_digits=10, decimal_places=2)
    pedido = models.ForeignKey(Pedido, on_delete=models.SET_NULL, null=True)


class Presupuesto(models.Model):
    cliente = models.ForeignKey(Cliente,  on_delete=models.SET_NULL, null=True)
    costo_total = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True, null=True, default=0)
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')
    clave = models.CharField(max_length=36, default='')
    history = HistoricalRecords('Auditoria Presupuesto')

    def __str__(self):
        return self.cliente.__str__()

    def save(self, *args, **kwargs):
        super(Presupuesto, self).save(*args, **kwargs)


class DetallePresupuesto(models.Model):
    presupuesto = models.ForeignKey(
        Presupuesto, on_delete=models.SET_NULL, null=True)
    producto = models.ForeignKey(
        Producto, on_delete=models.SET_NULL, null=True)
    cantidad = models.IntegerField()
    precio_unitario = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True, default=0)
    precio_total = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True, default=0)
    history = HistoricalRecords('Auditoria Detalle Presupuesto')

    def __str__(self):
        return str(self.pk)

    def save(self, *args, **kwargs):
        self.precio_unitario = self.producto.precio
        self.precio_total = self.producto.precio * self.cantidad

        super(DetallePresupuesto, self).save(*args, **kwargs)

        detalles = DetallePresupuesto.objects.filter(
            presupuesto=self.presupuesto)
        costo_total = 0

        for detalle in detalles:
              costo_total += detalle.precio_unitario * detalle.cantidad

        self.presupuesto.costo_total = costo_total
        self.presupuesto.save()


class Visita(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.SET_NULL, null=True)
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    estado_choices = (
        ('ESPERA', 'EN ESPERA'),
        ('SUSPENDIDA','SUSPENDIDA'),
        ('DISPONIBLE', 'DISPONIBLE'),
    )
    estado = models.CharField(max_length=20, choices=estado_choices)
    fecha = models.DateField(null=True)
    hora = models.TimeField(null=True)
    zona_choices = (
        ('SUR', 'SUR'),
        ('NORTE', 'NORTE'),
        ('CENTRO', 'CENTRO'),

    )
    zona = models.CharField(max_length=20, choices=zona_choices, default='CENTRO')
    
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')
 
    def __str__(self):
        return self.cliente.__str__()

    class Meta:
        verbose_name_plural = "5. Visitas"
        ordering = ['fecha']

    def save(self, *args, **kwargs):
        self.estado="DISPONIBLE"
        super(Visita, self).save(*args, **kwargs)
        if self.fecha:
            Envio.objects.create(
                cliente = self.cliente,
                pedido = self.pedido,
                fecha = self.fecha,
                hora = self.hora,
                estado =self.estado,
                observaciones = self.observaciones,
               
            )
            subject = "DIA DE ENTREGA - M Y D AROMATIZANTES"
            message = "M Y D AROMATIZANTES TE INFORMA!"+' ' + " LA VISITA PARA LA ENTREGA DE SU PEDIDO, FUE AGENDADA PARA EL DIA: " + str(self.fecha)+ " A LAS: " + str(self.hora)+ " " + " GRACIAS !" 
            envioMail(subject,message,[self.cliente.email])

class Pago (models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.SET_NULL, null=True)
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    monto = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    PAGOS = (("EFECTIVO", "EFECTIVO"),
             ("TRANSFERENCIA", "TRANSFERENCIA"),
             ("CREDITO", "CRÉDITO"),
             ("DEBITO", "DÉBITO"))
    medio_pago = models.CharField(
        max_length=15, choices=PAGOS, default='efectivo')
    estadosPago = (('PAGO PARCIAL', 'PAGO PARCIAL'),
                   ('PAGO TOTAL', 'PAGO TOTAL'), )
    fecha = models.DateField(auto_now=True, auto_now_add = False )
    estado = models.CharField(
        max_length=15, choices=estadosPago, default='PAGO PARCIAL')
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')


    def __str__(self):
        return "Nro de pago: " + "" + str(self.pk)

    class Meta:
        verbose_name_plural = "4. Pagos"

    def save(self, *args, **kwargs):
        super(Pago, self).save(*args, **kwargs)  # se guarda el obj

        if self.estado == 'PAGO TOTAL':
            Visita.objects.create(
                cliente = self.cliente,
                pedido = self.pedido,
                estado = self.estado,
                hora=self.cliente.horario_disponible_desde,
                observaciones = self.observaciones,
            )
      
        pagos = Pago.objects.filter(pedido=self.pedido)
        sumatoria_total_pagos = 0

        for pago in pagos:
            sumatoria_total_pagos += pago.monto

        resta = self.pedido.costo_total - sumatoria_total_pagos
        if resta <= 0:
            self.pedido.pagado = True
            self.pedido.save()
        else:
            self.pedido.pagado = False
            self.pedido.save()

        cuenta_corriente = CuentaCorriente.objects.get(pedido=self.pedido)
        cuenta_corriente.pagado = sumatoria_total_pagos
        cuenta_corriente.restante = cuenta_corriente.monto - cuenta_corriente.pagado   #
        cuenta_corriente.save()


class Envio(models.Model):
    
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    pedido = models.ForeignKey(
        Pedido, on_delete=models.SET_NULL, null=True)
    estadoenvio = (
        ('ESPERA', 'ESPERA'),
        ('ENTREGADO', 'ENTREGADO'),
    )
    
    estado = models.CharField(max_length=20, choices=estadoenvio,default='ESPERA')
    fecha = models.DateField()
    hora = models.TimeField()
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')
    
    def __str__(self):
        return self.cliente.__str__()
    def save(self, *args, **kwargs):
        self.estado= "ESPERA"

        super(Envio, self).save(*args, **kwargs) 
    

    class Meta:
        verbose_name_plural = "6. Envios"   
class Servicio (models.Model):
    
    class Meta:
        verbose_name_plural = "7. Servicios"
        ordering = ['id']
    fecha = models.DateField()  
    cantidad_dias= models.SmallIntegerField('Plazo para proxima Visita', default=38 ) 
    fecha_programada =models.DateField('Fecha programada para proxima visita',auto_now=False,auto_now_add=False,null=True,blank=True)
    hora= models.TimeField(
        help_text='Horario disponible', verbose_name='hora',null=True, blank=True)
    
    estadoservicio = (('EN ESPERA', 'EN ESPERA'), ('DISPONIBLE', 'DISPONIBLE'))
    estado = models.CharField(
        max_length=30, choices=estadoservicio, default='EN ESPERA')
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    costo_total = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True, null=True, default=0)
    
    pagado = models.BooleanField()
    
    def __str__(self):
        return "Servicio Nro " + str(self.pk)+' - ' + str(self.cliente)+ " $ " + str(self.costo_total)
   
    def save(self, *args, **kwargs):
        self.estado = "DISPONIBLE"
        self.fecha_programada= self.fecha+ timedelta(days=self.cantidad_dias)
        self.hora=self.cliente.horario_disponible_desde
        super(Servicio, self).save(*args, **kwargs)
        
class DetalleServicio(models.Model):
    servicio = models.ForeignKey(
        Servicio, on_delete=models.SET_NULL, null=True)
    producto = models.ForeignKey(
        Producto, on_delete=models.SET_NULL, null=True)
    cantidad = models.IntegerField()
    precio_unitario = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True)
    precio_total = models.DecimalField(
        max_digits=10, decimal_places=2, blank=True)

    def __str__(self):
        return str(self.pk)
    
    def save(self, *args, **kwargs):
        self.precio_unitario = self.producto.precio
        self.precio_total = self.producto.precio * self.cantidad

        super(DetalleServicio, self).save(*args, **kwargs)

        detalles = DetalleServicio.objects.filter(servicio=self.servicio)
        costo_total = 0

        for detalle in detalles:
            costo_total += detalle.precio_unitario*detalle.cantidad

        self.servicio.costo_total = costo_total
        self.servicio.save()
        
class PagoServicio (models.Model):
    servicio = models.ForeignKey(Servicio, on_delete=models.SET_NULL, null=True)
    cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True)
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    PAGOS = (("EFECTIVO", "EFECTIVO"),
             ("TRANSFERENCIA", "TRANSFERENCIA"),
             ("CREDITO", "CRÉDITO"),
             ("DEBITO", "DÉBITO"))
    estadosPago = (('PAGO PARCIAL', 'PAGO PARCIAL'),
                   ('PAGO TOTAL', 'PAGO TOTAL'), )
    fecha = models.DateField(auto_now=True, auto_now_add = False )
    medio_pago = models.CharField(
        max_length=15, choices=PAGOS, default='efectivo')
   
    estado = models.CharField(
        max_length=15, choices=estadosPago, default='PAGO PARCIAL')
    observaciones = models.CharField(
        max_length=100, default='sin observaciones')


    def __str__(self):
        return "Nro de pago: " + "" + str(self.pk)

    class Meta:
        verbose_name_plural = "8. Pagos Servicios"

    def save(self, *args, **kwargs):
        super(PagoServicio, self).save(*args, **kwargs)  # se guarda el obj        
        pagos = PagoServicio.objects.filter(servicio=self.servicio)
        sumatoria_total_pagos = 0

        for pago in pagos:
            sumatoria_total_pagos += pago.monto

        resta = self.servicio.costo_total - sumatoria_total_pagos
        if resta <= 0:
            self.servicio.pagado = True
            self.servicio.save()
        else:
            self.servicio.pagado = False
            self.servicio.save()

