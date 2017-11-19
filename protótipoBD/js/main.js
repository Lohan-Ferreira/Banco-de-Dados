$(document).ready(function(){
	$('ul.tabs').tabs();
	$('ul.tabs').tabs({
		swipeable: false, 
		responsiveTreshold: Infinity
	});

	$('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 99, // Creates a dropdown of 15 years to control year,
        today: 'Today',
        clear: 'Clear',
        close: 'Ok',
        closeOnSelect: false, // Close upon selecting a date,
        format: 'yyyy-mm-dd'
    });

    $('select').material_select();
            
    var request;
    $('#cadastrarNutricionistaForm').submit(function(event){
        event.preventDefault();
        if(request){
            request.abort;
        }
        var $form = $(this);
        var $inputs = $form.find("input");
        var serializedData = $form.serialize();
        $inputs.prop("disabled", true);
        request = $.ajax({
            url: "http://localhost/prototipobd/formHandler/cadastroNutricionista.php", 
            type: "post", 
            data: serializedData
        });
        request.done(function(response, textStatus, jqXHR){
            console.log("OK");
        });
        request.fail(function (jqXHR, textStatus, errorThrown){
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });
        request.always(function(){
            $inputs.prop("disabled", false);
        });
    });

     $('#cadastrarPacienteForm').submit(function(event){
        event.preventDefault();
        if(request){
            request.abort;
        }
        var $form = $(this);
        var $inputs = $form.find("input");
        var serializedData = $form.serialize();
        $inputs.prop("disabled", true);
        request = $.ajax({
            url: "http://localhost/prototipobd/formHandler/cadastroPaciente.php", 
            type: "post", 
            data: serializedData
        });
        request.done(function(response, textStatus, jqXHR){
            console.log("OK");
        });
        request.fail(function (jqXHR, textStatus, errorThrown){
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });
        request.always(function(){
            $inputs.prop("disabled", false);
        });
    });

    $('#cadastrarClinicaForm').submit(function(event){
        event.preventDefault();
        if(request){
            request.abort;
        }
        var $form = $(this);
        var $inputs = $form.find("input");
        var serializedData = $form.serialize();
        $inputs.prop("disabled", true);
        request = $.ajax({
            url: "http://localhost/prototipobd/formHandler/cadastroClinica.php", 
            type: "post", 
            data: serializedData
        });
        request.done(function(response, textStatus, jqXHR){
            console.log("OK");
        });
        request.fail(function (jqXHR, textStatus, errorThrown){
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });
        request.always(function(){
            $inputs.prop("disabled", false);
        });
    });

    $('#cadastrarConsultaForm').submit(function(event){
        event.preventDefault();
        if(request){
            request.abort;
        }
        var $form = $(this);
        var $inputs = $form.find("input");
        var serializedData = $form.serialize();
        $inputs.prop("disabled", true);
        request = $.ajax({
            url: "http://localhost/prototipobd/formHandler/cadastroConsulta.php", 
            type: "post", 
            data: serializedData
        });
        request.done(function(response, textStatus, jqXHR){
            console.log("OK");
        });
        request.fail(function (jqXHR, textStatus, errorThrown){
            console.error(
                "The following error occurred: "+
                textStatus, errorThrown
            );
        });
        request.always(function(){
            $inputs.prop("disabled", false);
        });
    });

    
});



