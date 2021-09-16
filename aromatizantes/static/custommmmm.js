function getCookie (name){
    let cookieValue =null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i=0; i<cookies.length;i++) {
            const cookie =cookies[i].trim();
            if (cookie.substring(0, name.length + 1)===(name+'=')) {
                cookieValue=decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
document.addEventListener("DOMContentLoaded", function (event){
    const servicio = document.getElementById('id_servicio');
    const cliente= document.getElementById('id_cliente');
    const monto= document.getElementById('id_monto')

    servicio.addEventListener('change', (e) => {
        let txt= servicio.options[servicio.selectedIndex].text;
        let vec_txt = txt.split('-');
        let vec2_txt=vec_txt[0].split('Nro');


        const csrftoken =getCookie('csrftoken');
        fetch('/get_datos_servicios_ajax/', {
            method:"POST",
            headers:{
                "X-CSRFToken":csrftoken,
            },
            body: JSON.stringify({
                myData: vec2_txt[1].trim()
            })
           
        }).then(function(response){
            return response.json();
        })
            .then(function(data){
                console.log(data);
                monto.value=data['monto'];
                cliente.value=data['cliente_id'];

            })
            .catch(function(err){
                console.log(err);
            })
    });
});
