document.addEventListener("DOMContentLoaded", function(event) {
    var producto = document.getElementById('id_detallepresupuesto_set-0-producto')
    var producto2 = document.getElementById('id_detallepresupuesto_set-1-producto')
    var producto3 = document.getElementById('id_detallepresupuesto_set-2-producto')
    var inputCantidad = document.getElementById('id_detallepresupuesto_set-0-cantidad')
    var inputCantidad2 = document.getElementById('id_detallepresupuesto_set-1-cantidad')
    var inputCantidad3 = document.getElementById('id_detallepresupuesto_set-2-cantidad')
    var inputPrecioUnitario = document.getElementById('id_detallepresupuesto_set-0-precio_unitario')
    var inputPrecioUnitario2 = document.getElementById('id_detallepresupuesto_set-1-precio_unitario')
    var inputPrecioUnitario3 = document.getElementById('id_detallepresupuesto_set-2-precio_unitario')
    var costoTotal = document.getElementById('id_costo_total')
    var inputPrecioTotal = document.getElementById('id_detallepresupuesto_set-0-precio_total')
    var inputPrecioTotal2 = document.getElementById('id_detallepresupuesto_set-1-precio_total')
    var inputPrecioTotal3 = document.getElementById('id_detallepresupuesto_set-2-precio_total')
    var precio = null
    var precio2 = null
    var precio3 = null
    var cantidad = null
    var cantidad2 = null
    var cantidad3 = null

    producto.addEventListener('change',(e)=>{
        try {
            precio = producto.options[producto.selectedIndex].text
            precio = precio.split('/')
            precio = precio[2]
            precio = precio.split(':')
            precio = precio[1]
            inputPrecioUnitario.value = precio
        } catch (error) {
            precio = null
            inputPrecioUnitario2.value = precio2
        }
        
    })

    producto2.addEventListener('change',(e)=>{
        try {
            precio2 = producto2.options[producto2.selectedIndex].text
            precio2 = precio2.split('/')
            precio2 = precio2[2]
            precio2 = precio2.split(':')
            precio2 = precio2[1]
            inputPrecioUnitario2.value = precio2
        } catch (error) {
            precio2 = null
            inputPrecioUnitario2.value = precio2
        }
        
    })
    producto3.addEventListener('change',(e)=>{
        try {
            precio3 = producto3.options[producto3.selectedIndex].text
            precio3 = precio3.split('/')
            precio3 = precio3[2]
            precio3 = precio3.split(':')
            precio3 = precio3[1]
            inputPrecioUnitario3.value = precio3
        } catch (error) {
            precio3 = null
            inputPrecioUnitario3.value = precio3
        }
        
    })
    inputCantidad.addEventListener('change', (e)=>{
        cantidad = producto.options[producto.selectedIndex].text
        cantidad = cantidad.split('/')
        cantidad = cantidad[1]
        cantidad = cantidad.split(':')
        cantidad = cantidad[1]
        inputPrecioUnitario.value = precio
        inputPrecioTotal.value = inputCantidad.value * inputPrecioUnitario.value
        if (inputPrecioTotal2.value == ""){
            inputPrecioTotal2.value = '0'
        }
        if(inputPrecioTotal3.value === ""){
            inputPrecioTotal3.value = '0'
        }
        Total = parseInt(inputPrecioTotal.value)  + parseInt(inputPrecioTotal2.value) + parseInt(inputPrecioTotal3.value)
        costoTotal.value = Total
    });
    inputCantidad2.addEventListener('change', (e)=>{
        cantidad2 = producto.options[producto2.selectedIndex].text
        cantidad2 = cantidad2.split('/')
        cantidad2 = cantidad2[1]
        cantidad2 = cantidad2.split(':')
        cantidad2 = cantidad2[1]
        inputPrecioUnitario2.value = precio2
        inputPrecioTotal2.value = inputCantidad2.value * inputPrecioUnitario2.value
        if (inputPrecioTotal.value == ""){
            inputPrecioTotal.value = '0'
        }
        if(inputPrecioTotal3.value === ""){
            inputPrecioTotal3.value = '0'
        }
        Total = parseInt(inputPrecioTotal.value)  + parseInt(inputPrecioTotal2.value) + parseInt(inputPrecioTotal3.value)
        costoTotal.value = Total
    });
    inputCantidad3.addEventListener('change', (e)=>{
        cantidad3 = producto.options[producto3.selectedIndex].text
        cantidad3 = cantidad3.split('/')
        cantidad3 = cantidad3[1]
        cantidad3 = cantidad3.split(':')
        cantidad3 = cantidad3[1]
        inputPrecioUnitario3.value = precio3
        inputPrecioTotal3.value = inputCantidad3.value * inputPrecioUnitario3.value
        if (inputPrecioTotal.value == ""){
            inputPrecioTotal.value = '0'
        }
        if(inputPrecioTotal2.value === ""){
            inputPrecioTotal2.value = '0'
        }
        Total = parseInt(inputPrecioTotal.value)  + parseInt(inputPrecioTotal2.value) + parseInt(inputPrecioTotal3.value)
        costoTotal.value = Total
    });
});

