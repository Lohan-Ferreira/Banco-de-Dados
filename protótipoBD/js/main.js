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
    closeOnSelect: false // Close upon selecting a date,
  });

    $('select').material_select();
            
})

