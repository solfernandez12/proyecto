"""tesis_proyecto URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from aromatizantes.views import *

urlpatterns = [
    path('', consultas),
    path('exportarClientes/', exportarClientes),
    path('exportarPresupuestos/', exportarPresupuestos),
    path('exportarPagos/', exportarPagos),
    path('exportarPedidos/', exportarPedidos),
    path('exportarVisitas/', exportarVisitas),
    path('exportarProductos/', exportarProductos),
    path('filtarPorFechaPedido/', filtarPorFechaPedido),
    path('filtarPorFechaPago/', filtarPorFechaPago),
    path('filtarPorFechaVisita/', filtarPorFechaVisita),
    path('filtarPorFechaServicio/', filtarPorFechaServicio),
    path('generar_pedido/<int:pk>/<uuid:clave>/', GenerarPedido.as_view()),
    # PDF
    path('export_visita/', export_visita),
    path('get_datos_pedidos_ajax/', datos_pedidos_ajax),
    path('get_datos_servicios_ajax/', datos_servicios_ajax),
]