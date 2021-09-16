import uuid
from datetime import date
from django.core.mail import EmailMultiAlternatives

from django.forms.models import BaseInlineFormSet
from fpdf import FPDF

from aromatizantes.models import Producto, Presupuesto
from django.core.exceptions import ValidationError
from django.core.mail import send_mail, EmailMessage
from django.conf import settings


class DisableFieldPedidoFormSet(BaseInlineFormSet):
    
    def email(self):
        email_from = settings.EMAIL_HOST_USER
        producto = Producto.objects.all()
        for prod in range(len(producto)):
            if producto[prod].stock_actual < producto[prod].stock_minimo:
                    subject = "Reponer Producto "+ str(producto[prod])
                    message = "El producto "+ str(producto[prod]) + " tiene " + str(producto[prod].stock_actual) +" stock"
                    send_mail(subject,message,email_from,[email_from])

    def _construct_form(self,i,**kwargs):
        form = super (DisableFieldPedidoFormSet,self)._construct_form(i,**kwargs)
        form.fields["precio_unitario"].disabled=True
        form.fields["precio_total"].disabled=True
        
        return form
    def clean(self):
        for form in self.forms:
            cantidad = form.cleaned_data.get('cantidad')
            producto = form.cleaned_data.get('producto')
            if producto != None: 
                if producto.stock_actual < cantidad:
                    raise ValidationError("No tenemos suficientes items en stock.")
        self.validate_unique()
    
    def save_new(self, form, commit=True):
        self.email()
        producto = Producto.objects.get(id=form.instance.producto.id)
        if producto.stock_actual < form.instance.cantidad:
            raise ValidationError("No se cuenta con la cantidad solicitada")
        producto.stock_actual = producto.stock_actual - form.instance.cantidad
        producto.save(update_fields=['stock_actual'])
        setattr(form.instance, self.fk.name, self.instance)
        return super().save_new(form, commit=commit)

class DisableFieldPresupuestoFormSet(BaseInlineFormSet):
    def _construct_form(self,i,**kwargs):
        form = super (DisableFieldPresupuestoFormSet,self)._construct_form(i,**kwargs)
        form.fields["precio_unitario"].disabled=True
        form.fields["precio_total"].disabled=True
        return form

    def clean(self):
        for form in self.forms:
            cantidad = form.cleaned_data.get('cantidad')
            producto = form.cleaned_data.get('producto')
            if producto != None: 
                if producto.stock_actual < cantidad:
                    raise ValidationError("No tenemos suficientes items en stock.")
        self.validate_unique()

    def save(self, commit=True, ):

        detalle = super().save(commit=commit)

        clave = uuid.uuid4()

        pre = Presupuesto.objects.get(pk=detalle[0].presupuesto.pk)
        pre.clave = str(clave)
        pre.save()

        # PDF
        pdf = FPDF()
        pdf.add_page()
        pdf.set_font("Arial", size=12)

        pdf.image("aromatizantes/static/img/logo.jpg" , w =50, h=50)

        pdf.cell(200, 10, txt="MyD Aromatizantes",
                 ln=1, align='C')
        pdf.cell(200, 10, txt="PRESUPUESTO "+ str(detalle[0].presupuesto.pk),
                 ln=2, align='C')

        # pdf.cell(200, 10, txt="Producto                          Cantidad                       Precio", ln=5, align='L')

        linea = 6

        pdf.cell(200, 10, txt="Cliente: " + str(detalle[0].presupuesto.cliente.nombre_apellido), 
        ln= linea + 1 ,align='L')

        pdf.ln() 

        pdf.set_line_width(.3)
        header = ['Producto', 'Cantidad', 'p x u', 'Subtotal']
        # pdf.set_text_color(64)
        w = [100, 25, 25, 30]
        for i in range(0, len(header)):
            pdf.cell(w[i], 8, header[i], 1, 0, 'C', 0)
        pdf.ln()

        # pdf.set_text_color(32)
        total = 0
        for row in detalle:
            pdf.cell(w[0], 7, row.producto.nombre_aroma, 'LR', 0, 'L')
            pdf.cell(w[1], 7, str(row.cantidad), 'LR', 0, 'R')
            pdf.cell(w[2], 7, '$' + str(row.precio_unitario), 'LR', 0, 'R')
            pdf.cell(w[3], 7, '$' + str(row.precio_unitario * row.cantidad), 'LR', 0, 'R')
            pdf.ln()
            total = total + float(row.precio_unitario * row.cantidad)

        # pie de pagina de la tabla
        # self.set_font('', 'B')
        pdf.cell(150, 7, 'Total:', 'LR', 0, 'R')
        pdf.cell(30, 7, '$' + str(total), 'LR', 0, 'R')
        pdf.ln()
        pdf.cell(sum(w), 0, '', 'T')  # linea final


        # for item in detalle:
        #     pdf.cell(200, 10, txt="Producto: " + item.producto.nombre_aroma + " | Cantidad: " + str(
        #         item.cantidad) + " | Precio Unitario: " + str(item.precio_unitario), ln=linea, align='L')

        # linea += 5
        # pdf.cell(180, 20,
        #          txt="Total del presupuesto: $ " + str(detalle[0].presupuesto.costo_total),
        #          ln=linea, align='R')

        pdf.ln()
        pdf.cell(200, 10, txt="Observaciones: " + detalle[0].presupuesto.observaciones, ln=linea + 2, align='L')

        pdf.ln()
        hoy = date.today()
        pdf.cell(180, 20, txt="Fecha de presupuesto: " + hoy.strftime("%d/%m/%Y"), ln=linea ,align='R')

        # save the pdf with name .pdf
        pdf.output("presupuesto.pdf")
              # subject = "PRESUPUESTO - MyD AROMATIZANTES"

        enlace =enlace = "http://127.0.0.1:8000/generar_pedido/" + str(detalle[0].presupuesto.pk) + "/" + str(clave) + "/"

        message = "Hola, somos de MyD Aromatizantes\n"
        message += "Te hacemos llegar el presupuesto solicitado en el pdf adjunto\n"
        message += "\n"
        message += "Si estás de acuerdo con el presupuesto dirígete al siguiente enlace para generar el pedido:\n"
        message += enlace

        m_html = '<h2> Hola, SOMOS MyD Aromatizantes</h2>'
        m_html += '<p>Te hacemos llegar el presupuesto solicitado en el pdf adjunto</p>'
        m_html += '<p>Si estás de acuerdo con el presupuesto, dirígete al siguiente enlace para generar el pedido:</p>'
        m_html += '<p><a href="' + enlace + '" target="_blank">Generar Pedido </a> </p>'

        # envioMail(subject, message, [obj.cliente.email])
        # mail = EmailMessage(subject, message, settings.EMAIL_HOST_USER, [detalle[0].presupuesto.cliente.email])
        # mail.attach_file("presupuesto.pdf")
        # mail.send()

        subject, from_email, to = "PRESUPUESTO - MyD AROMATIZANTES", settings.EMAIL_HOST_USER, detalle[0].presupuesto.cliente.email
        text_content = message
        html_content = m_html
        mail = EmailMultiAlternatives (subject, text_content, from_email, [to])
        mail.attach_alternative(html_content, "text/html")
        mail.attach_file("presupuesto.pdf")
        mail.send()
       
        return True


class DisableFieldServicioFormSet(BaseInlineFormSet):
    def email(self):
        email_from = settings.EMAIL_HOST_USER
        producto = Producto.objects.all()
        for prod in range(len(producto)):
            if producto[prod].stock_actual < producto[prod].stock_minimo:
                    subject = "Reponer Producto "+ str(producto[prod])
                    message = "El producto "+ str(producto[prod]) + " tiene " + str(producto[prod].stock_actual) +" stock"
                    send_mail(subject,message,email_from,[email_from])

    def _construct_form(self,i,**kwargs):
        form = super (DisableFieldServicioFormSet,self)._construct_form(i,**kwargs)

        form.fields["precio_unitario"].disabled=True
        form.fields["precio_total"].disabled=True
        
        return form
    def clean(self):
        for form in self.forms:
            cantidad = form.cleaned_data.get('cantidad')
            producto = form.cleaned_data.get('producto')
            if producto != None: 
                if producto.stock_actual < cantidad:
                    raise ValidationError("No tenemos suficientes items en stock.")
        self.validate_unique()
    
    def save_new(self, form, commit=True):
        self.email()
        producto = Producto.objects.get(id=form.instance.producto.id)
        if producto.stock_actual < form.instance.cantidad:
            raise ValidationError("No se cuenta con la cantidad solicitada")
        producto.stock_actual = producto.stock_actual - form.instance.cantidad
        producto.save(update_fields=['stock_actual'])
        setattr(form.instance, self.fk.name, self.instance)
        return super().save_new(form, commit=commit)

