<?php 
	$bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
	$name = $_POST["nomePaciente"];
	$cpf = $_POST["cpfPaciente"];
	$address = $_POST["enderecoPaciente"];
	$birth = $_POST["nascimentoPaciente"];
	$tel = $_POST["telefonePaciente"];
	$query = 'INSERT INTO "Nutri".paciente(cpf, nome, endereco, datanascimento) VALUES ('.$cpf.','."'".$name."'".', '."'".$address."'".', '."'".$birth."'".');';
	$result=pg_query($bdcon, $query);
	$query = 'INSERT INTO "Nutri".telefone(
		cpf, numero)
		VALUES ('.$cpf.', '.$tel.');';
	$result=pg_query($bdcon, $query);
?>