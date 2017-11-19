<?php 
	$bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
	$id = $_POST["idConsulta"];
	$cpfP = $_POST["cpfPacienteConsulta"];
	$cpfN = $_POST["cpfNutricionistaConsulta"];
	$date = $_POST["dataConsulta"];
	$query = 'INSERT INTO "Nutri".consulta(	id, cpfp, cpfn, data) VALUES ('.$id.', '.$cpfP.', '.$cpfN.','."'".$date."'".');';
	$result=pg_query($bdcon, $query);
?>