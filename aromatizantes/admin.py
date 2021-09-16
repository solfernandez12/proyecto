from aromatizantes.forms import DisableFieldPedidoFormSet
from django.contrib import admin
from aromatizantes.models import *
from aromatizantes.forms import *
from django.db.models import F
from django.contrib import admin
# from simple_history.admin import SimpleHistoryAdmin
from .models import Cliente 

from fpdf import FPDF
from django.apps import apps


@admin.register(CuentaCorriente)
class CuentaCorrienteAdmin(admin.ModelAdmin):
    list_display = ('cliente', 'monto', 'pagado', 'restante', 'pedido', )
    def has_add_permission(self, request, obj=None):
            return False
    def has_delete_permission(self, request, obj=None):
            return False



class ClienteAltaFilter(admin.SimpleListFilter):
    title= "Clientes"
    parameter_name= "Activo"

    def lookups(self, request, model_admin):

        return (
            ('todos','Todos/as'),
            ('si', 'Dado de alta'),
            ('no', 'Dado de baja'),
        ) 
    def choices(self,cl):
        from django.utils.encoding import force_text
        for lookup, title in self.lookup_choices:
            yield{
                'selected': self.value()== force_text(lookup),
                'query_string': cl.get_query_string({
                    self.parameter_name:lookup,
                }, []),
                'display': title,

            }
        

    def value(self):

        value = self.used_parameters.get(self.parameter_name)

        if value==None:
            value='si'

        return value

    def queryset(self, request, queryset):

        if self.value()=="si":
            return queryset.filter(dado_de_alta=True)
        elif self.value()=="no":
            return queryset.filter(dado_de_alta=False)
        elif self.value()=="todos":
            return queryset

@admin.register(Cliente)
class ClienteAdmin(admin.ModelAdmin,):
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('nombre_apellido', 'cuit_cuil_DNI', 'direccion','zona','telefono','email',
                'horario_disponible_desde', 'horario_disponible_hasta','fecha_ingreso' ,'dado_de_alta','observaciones',) 
    list_filter = ('zona',ClienteAltaFilter)
   
   
    def has_delete_permission(self, request, obj=None):
        return False

    search_fields= ('nombre_apellido','direccion','zona','email','fecha_ingreso')

class ProductoFilter(admin.SimpleListFilter):
    title = "Estado"
    parameter_name = "estado"
 
    def lookups(self, request, model_admin):
        return (("reponer", "Se necesita reponer stock"),)

    def queryset(self, request, queryset):
        if self.value() == "reponer":
            return queryset.filter(stock_actual__lt=F("stock_minimo"))

        return queryset

class DetallePresupuestoInline(admin.TabularInline):
    verbose_name = 'Detalle'
    model = DetallePresupuesto
    formset = DisableFieldPresupuestoFormSet

class DetalleServicioInline(admin.TabularInline):
    verbose_name = 'Detalle'
    model = DetalleServicio
    formset=DisableFieldServicioFormSet


class DetallePedidoInline(admin.TabularInline):
    verbose_name = 'Detalle'
    model = DetallePedido
    formset=DisableFieldPedidoFormSet

class ProductoFilter(admin.SimpleListFilter):
    title = "Estado"
    parameter_name = "estado"
 
    def lookups(self, request, model_admin):
        return (("reponer", "Se necesita reponer stock"),)

    def queryset(self, request, queryset):
        if self.value() == "reponer":
            return queryset.filter(stock_actual__lt=F("stock_minimo"))

        return queryset

@admin.register(Pedido)
class PedidoAdmin(admin.ModelAdmin):
    inlines = [
        DetallePedidoInline,
    ]
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('cliente', 'estado','costo_total','fecha','pagado')
    list_filter = ('cliente','pagado',)
    search_fields = ('estado','cliente','estado',)
    fields=('cliente',  'estado','costo_total','pagado')

    class Media:
        js = ("custom.js",)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj=None, **kwargs)

        form.base_fields["costo_total"].disabled = True
        form.base_fields["pagado"].disabled = True
        form.base_fields["estado"].disabled = True
        return form

@admin.register(Producto)
class ProductoAdmin(admin.ModelAdmin):
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('nombre_aroma', 'precio','categoria', 'stock_actual', 'stock_minimo','observaciones' )
    list_filter = (ProductoFilter,'categoria',)
    def has_delete_permission(self, request, obj=None):
        return False
    search_fields = ( 'nombre_aroma','precio','categoria','stock_actual')



@admin.register(Pago)
class PagoAdmin(admin.ModelAdmin):
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ( 'cliente','medio_pago', 'fecha', 'monto','estado','pedido','observaciones' )
    list_filter = ('cliente', 'medio_pago', 'fecha','estado','pedido',)
    search_fields = ('cliente', 'estado')
   
    def has_delete_permission(self, request, obj=None):
            return False

    class Media:
        js = ("custommmm.js",)

    
    
@admin.register(Presupuesto)
class PresupuestoAdmin(admin.ModelAdmin):
    exclude = ('clave',)
    inlines = [
        DetallePresupuestoInline,
    ]
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('cliente', 'costo_total', 'observaciones',)
    list_filter = ('cliente',) 
  
    class Media:
        js = ("customm.js",)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj=None, **kwargs)
        form.base_fields["costo_total"].disabled = True
        return form

    def save_model(self, request, obj, form, change):
        super().save_model(request, obj, form, change)
    


@admin.register(Visita) 
class VisitaAdmin(admin.ModelAdmin):  
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('cliente','pedido', 'estado','zona', 'fecha', 'hora','observaciones')
    list_filter = ( 'cliente', 'estado', 'fecha','hora', )
    search_fields= ('fecha','cliente')
    class Media:
        js = ("custom.js",)
    def has_add_permission(self, request, obj=None):
            return False
    def has_delete_permission(self, request, obj=None):
            return False

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj=None, **kwargs)

       
        return form
@admin.register(Envio) 
class EnvioAdmin(admin.ModelAdmin):  
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('cliente','pedido','estado','fecha', 'hora','observaciones')
    list_filter = ( 'cliente','hora','observaciones' )
    search_fields= ('fecha','cliente')

    class Media:
        js = ("custom.js",)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj=None, **kwargs)

        return form
    def has_add_permission(self, request, obj=None):
            return False
    def has_delete_permission(self, request, obj=None):
            return False
    
@admin.register(Servicio)
class ServicioAdmin(admin.ModelAdmin):
    inlines = [
        DetalleServicioInline,
    ]
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ('cliente','fecha','hora','fecha_programada', 'estado','costo_total','pagado')
    list_filter = ('cliente','fecha','pagado',)
    search_fields = ('estado','cliente')
    fields=('cliente', 'fecha', 'estado', 'costo_total', 'pagado', )
    class Media:
        js = ("custommm.js",)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj=None, **kwargs)

        form.base_fields["costo_total"].disabled = True
        form.base_fields["pagado"].disabled = True
        form.base_fields["estado"].disabled = True
        return form
@admin.register(PagoServicio)
class PagoServicioAdmin(admin.ModelAdmin):
    change_list_template = "admin/change_list_filter_sidebar.html"
    list_display = ( 'cliente','medio_pago', 'fecha', 'monto','estado','servicio','observaciones' )
    list_filter = ('cliente', 'medio_pago', 'fecha','estado','servicio',)
    search_fields = ('cliente', 'estado')
    
    class Media:
            js = ("custommmmm.js",)
   
    def has_delete_permission(self, request, obj=None):
            return False
HistoricalPresupuesto = apps.get_model("aromatizantes", "HistoricalPresupuesto")

@admin.register(HistoricalPresupuesto)
class HistorialPresupuestoAdmin(admin.ModelAdmin):
    title = 'Auditoría de Presupuestos'

    list_display = (
        'id',
        'cliente',
        'costo_total',
        'observaciones',
        'history_date',
        'history_type',
        'history_user_id',
    )
    list_filter = ('cliente','costo_total','id', 'history_date')
    def has_add_permission(self, request, obj=None):
            return False

    def has_change_permission(self, request, obj=None):
            return False

    def has_delete_permission(self, request, obj=None):
            return False

HistoricalDetallePresupuesto = apps.get_model("aromatizantes", "HistoricalDetallePresupuesto")

@admin.register(HistoricalDetallePresupuesto)
class HistoricalDetallePresupuestoAdmin(admin.ModelAdmin):
    title = 'Auditoría de Detalle de Presupuesto'

    list_display = (
        'id',
        'presupuesto',
        'producto',
        'cantidad',
        'precio_unitario',
        'precio_total',
        'history_date',
        'history_type',
        'history_user_id',
    )
    list_filter = ('precio_total','producto','presupuesto','history_date','id')

    def has_add_permission(self, request, obj=None):
            return False

    def has_change_permission(self, request, obj=None):
            return False

    def has_delete_permission(self, request, obj=None):
            return False

