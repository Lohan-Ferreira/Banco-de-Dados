# Banco-de-Dados
Para rodar a aplicação:
1 - Crie um banco, usando o postgresql, usando o script do arquivo bank.sql;
2 - Coloque os arquivos da pasta protótipobd em um servidor php que comunique com o postgresql. Para nossos testes usamos
o wamp.
3 - Mude os parâmetros de pg_connect para os do seu banco no postgresql. Serão necessárias alterações nas linhas 136, 162,
188 e 215 do main.php, e na linha 2 dos arquivos cadastroClinica.php, cadastroPaciente.php, cadastroNutricionista.php, 
cadastroConsulta.php, consultaNutricionistasClinica.php e consultaPacientesNutricionista.php.
4 - Abrir o arquivo main.php pelo servidor php

