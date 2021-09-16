from django.templatetags.static import static


class Boton:
    contador_id = 0

    def __init__(self, texto, url, modal=False, color=None, id=None):
        self.texto = texto
        self.modal = modal
        self.url = url
        self.color = color

        self.id = texto.lower().replace(' ','')+ str(Boton.contador_id)
        Boton.contador_id+=1


class Tarjeta:
    def __init__(self, titulo, botones):
        self.titulo = titulo
        self.ruta_img = static(f'img/{titulo.lower()}.png')
        self.botones = botones


class Fila:
    def __init__(self, tarjetas):
        self.tarjetas = tarjetas


class Menu:

    tarjetas = (

        Fila((
            Tarjeta('Clientes', botones=(
                Boton('EXPORTAR EXCEL', 'exportarClientes/'),
               
            )),

            Tarjeta('Presupuestos', botones=(
                Boton('EXPORTAR EXCEL', 'exportarPresupuestos/'),
                
            )),
            Tarjeta('Productos', botones=(
                Boton('EXPORTAR EXCEL', 'exportarProductos/'),
            )),
            Tarjeta('Servicios', botones=(
                Boton('Filtrar por fecha','filtarPorFechaServicio/', True, 'is-info'),
            )),
        )),

        Fila((
            Tarjeta('Pagos', botones=(
                Boton('EXPORTAR EXCEL', 'exportarPagos/'),
                Boton('Filtrar por fecha','filtarPorFechaPago/', True, 'is-info'),
                
            )),
            Tarjeta('Visitas', botones=(
                Boton('EXPORTAR EXCEL', 'exportarVisitas/'),
                Boton('Filtrar por fecha','filtarPorFechaVisita/', True, 'is-info'),
            
                Boton('EXPORTAR PDF', 'export_visita/')
            )),
            Tarjeta('Pedidos', botones=(
                Boton('EXPORTAR EXCEL', 'exportarPedidos/'),
                Boton('Filtrar por fecha','filtarPorFechaPedido/', True, 'is-info'),
            )),
        ))
    )
