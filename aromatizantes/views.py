from django.views.generic import TemplateView
from django.template.loader import get_template

from xhtml2pdf import pisa

from aromatizantes.menu_consultas.menu import *
from django.shortcuts import render, redirect, get_object_or_404
from django.templatetags.static import static
from aromatizantes.models import *
from djqscsv import render_to_csv_response
from django.db.models import F
from django.shortcuts import render
from django.http import HttpResponse, Http404, HttpResponseRedirect
#
from .models import Producto
#
from django_xhtml2pdf.utils import generate_pdf
import json
from django.http import JsonResponse
def testpdf(response):
    res = HttpResponse(content_type='application/pdf')
    result = generate_pdf('visitas_tabla.html', file_object=res)
    return result


def consultas(request):

    if not request.user.is_authenticated:
        return render(request, '404.html')
    context = {
         "tarjetas": Menu.tarjetas
    }

    return render(request, 'consultas.html', context=context)

def export_visita(request, *args, **kwargs):
    query = Visita.objects.all()

    template_path = 'test.html'
    context = {
        'visitas': query
    }
    response = HttpResponse(content_type='application/pdf')

    # to view on browser we can remove attachment
    response['Content-Disposition'] = 'filename="report.pdf"'

    # find the template and render it.
    template = get_template(template_path)
    html = template.render(context)

    # create a pdf
    pisa_status = pisa.CreatePDF(
        html, dest=response)
    # if error then show some funy view
    if pisa_status.err:
        return HttpResponse('We had some errors <pre>' + html + '</pre>')
    return response

def exportarClientes(request):
    queryset = Cliente.objects.all()
    mapa_de_campos = {
        "nombre_cliente": "Clientes",
        "direccion": "Dirección",
    }
    return render_to_csv_response(queryset, field_header_map=mapa_de_campos, filename="Mis clientes", append_datestamp=True)


def exportarPresupuestos(request):
    queryset = Presupuesto.objects.all().annotate(
        nombre_cliente=F('cliente__nombre_apellido'),
    )
    mapa_de_campos = {
        "nombre_cliente": "Clientes",
        "costo_total": "Costo total",
    }
    return render_to_csv_response(queryset, field_header_map=mapa_de_campos, filename="Presupuestos", append_datestamp=True)


def exportarPagos(request):
    queryset = Pago.objects.all().annotate(
        nombre_cliente=F('cliente__nombre_apellido'),
    )
    mapa_de_campos = {
        "nombre_cliente": "Clientes",
        "monto": "Monto",
        "medio_pago": "medio de pago",
    }
    return render_to_csv_response(queryset, field_header_map=mapa_de_campos, filename="Pagos", append_datestamp=True)


def exportarPedidos(request):
    queryset = Pedido.objects.all().annotate(
        nombre_cliente=F('cliente__nombre_apellido'),
    )

    mapa_de_campos = {
        "nombre_cliente": "Clientes",
        "nombre_producto": "Producto",
        "fecha_actual": "Fecha_actual",
    }
    return render_to_csv_response(queryset, field_header_map=mapa_de_campos, filename="Pedidos", append_datestamp=True)


def exportarVisitas(request):
    queryset = Visita.objects.all().annotate(
        nombre_cliente=F('cliente__nombre_apellido')
    ).annotate(
        nombre_aroma=F('producto__nombre_aroma')
    )
    mapa_de_campos = {
        "nombre_cliente": "Clientes",
        "nombre_aroma": "Producto",
        "fecha": "Fecha",
        "hora": "Hora",
    }
    
    return render_to_csv_response(queryset, field_header_map=mapa_de_campos, filename="Visitas", append_datestamp=True)



def exportarProductos(request):
    queryset = Producto.objects.all()
    mapa_de_campos = {
        "nombre_aroma": "Nombre Producto",
        "stock_minimo": "stock_minimo",
        "stock_actual": "stock_actual",
    }
    return render_to_csv_response(queryset, field_header_map=mapa_de_campos, filename="Productos", append_datestamp=True)



def filtarPorFechaPedido(request):
    if not request.user.is_authenticated:
        return render(request, '404.html')

    desde = request.GET['desde']
    hasta = request.GET['hasta']

    queryset = Pedido.objects.filter(
        fecha__gte=desde, fecha__lte=hasta)

    return render(request, 'pedidos_tabla.html', context={"pedidos": queryset})


def filtarPorFechaPago(request):
    if not request.user.is_authenticated:
        return render(request, '404.html')

    desde = request.GET.get('desde')
    hasta = request.GET.get('hasta')
    
    queryset = Pago.objects.filter(fecha__gte=desde, fecha__lte=hasta)
    
    return render(request, 'pagos_tabla.html', context={"pagos": queryset})


def filtarPorFechaVisita(request):
    if not request.user.is_authenticated:
        return render(request, '404.html')

    desde = request.GET['desde']
    hasta = request.GET['hasta']

    queryset = Pago.objects.filter(fecha__gte=desde, fecha__lte=hasta)
    return render(request, 'visitas_tabla.html', context={"visitas": queryset})


def filtarPorFechaServicio(request):
    if not request.user.is_authenticated:
        return render(request, '404.html')

    desde = request.GET['desde']
    hasta = request.GET['hasta']

    queryset = Servicio.objects.filter(fecha__gte=desde, fecha__lte=hasta)
    return render(request, 'servicio_tabla.html', context={"servicios": queryset})


class GenerarPedido(TemplateView):
    template_name = 'generar_pedido.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['presupuesto_ok'] = False

        pk = self.kwargs.get('pk')
        clave = self.kwargs.get('clave')

        try:
            presupuesto = Presupuesto.objects.get(pk=pk, clave=clave)

            if presupuesto:
                context['presupuesto_ok'] = True
                context['presupuesto'] = presupuesto

                pedido = Pedido.objects.create(cliente=presupuesto.cliente, pagado=False)

                detallepresupuesto = DetallePresupuesto.objects.filter(presupuesto=presupuesto)

                for detalle in detallepresupuesto:
                    detallepedido = DetallePedido.objects.create(
                        pedido=pedido,
                        producto=detalle.producto,
                        cantidad=detalle.cantidad,
                        precio_unitario=detalle.precio_unitario,
                        precio_total=detalle.precio_total
                    )

                context['pedido'] = pedido

                presupuesto.clave = ''
                presupuesto.save()
        except:
            context['presupuesto_ok'] = False

        return context
def datos_pedidos_ajax(request):
    if request.method=="POST":
        txt= request.body
        post=json.loads(txt)
        pedido= Pedido.objects.get(pk=post['myData'])
        data={
            "cliente_id":pedido.cliente.pk,
            "cliente":pedido.cliente.nombre_apellido,
            "monto":pedido.costo_total,
        }
        return JsonResponse(data)
def datos_servicios_ajax(request):
    if request.method=="POST":
        txt= request.body
        post=json.loads(txt)
        servicio= Servicio.objects.get(pk=post['myData'])
        data={
            "cliente_id":servicio.cliente.pk,
            "cliente":servicio.cliente.nombre_apellido,
            "monto":servicio.costo_total,
        }
        return JsonResponse(data)