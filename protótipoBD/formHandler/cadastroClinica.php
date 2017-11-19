<?php 
	$bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
	$name = $_POST["nomeClinica"];
	$address = $_POST["enderecoClinica"];
	$cod = $_POST["codigoClinica"];
	$query = 'INSERT INTO "Nutri".clinica(cod, nome, endereco)
	VALUES ('.$cod.','."'".$name."'".','."'".$adress."'".');';
	$result=pg_query($bdcon, $query);
?>