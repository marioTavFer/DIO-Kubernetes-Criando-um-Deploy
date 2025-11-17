$("#button-blue").on("click", function() {
    
    var txt_nome = $("#name").val();
    var txt_email = $("#email").val();
    var txt_comentario = $("#comment").val();

    $.ajax({
        url: "http://192.168.0.31:30080",
        
        type: "post",
        data: {nome: txt_nome, email: txt_email, comentario: txt_comentario},
        beforeSend: function() {
        
            console.log("Tentando enviar os dados....");

        }
    }).done(function(e) {
        console.log("Dados Salvos");
    })

});