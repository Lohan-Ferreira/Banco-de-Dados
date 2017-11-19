<?php 
	$bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
	$name = $_POST["nomeNutricionista"];
	$cod = $_POST["codigoClinicaNutricionista"];
	$cpf = $_POST["cpfNutricionista"];
	$query = 'INSERT INTO "Nutri".nutricionista(cpf, cod, nome)
	VALUES ('.$cpf.','.$cod.','."'".$name."'".');';
	$result=pg_query($bdcon, $query);
?>