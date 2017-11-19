  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8">
      <!--Import Google Icon Font-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link type="text/css" rel="stylesheet" href="css/main.css"/>
      <!--Import jQuery before materialize.js-->      
      <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript" src="js/main.js"></script>
      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>
       <div class="row">
        <div class="col s12">
          <div class="hodeScroll">
          <ul class="tabs">
            <li class="tab"><a href="#cadastrarPaciente">Cadastrar Paciente</a></li>
            <li class="tab"><a href="#cadastrarClinica">Cadastrar Clínica</a></li>
            <li class="tab"><a href="#cadastrarNutricionista">Cadastrar Nutricionista</a></li>
            <li class="tab"><a href="#cadastrarConsulta">Cadastrar Consulta</a></li>
            <li class="tab"><a href="#consultaPacientes">Consultar Pacientes</a></li>
            <li class="tab"><a href="#consultaNutricionistas">Consultar Nutricionistas</a></li>
            <li class="tab"><a href="#consultaClinicas">Consultar Clinicas</a></li>
            <li class="tab"><a href="#consultaConsultas">Consultar Consultas</a></li>
            <li class="tab"><a href="#consultarNutricionistasClinica">Consultar Nutricionistas por Clínica</a></li>
            <li class="tab"><a href="#consultarPacientesNutricionista">Consultar Pacientes por Nutricionista</a></li>
          </ul>
        </div>
      </div>
      <div id="cadastrarPaciente">
        <form id="cadastrarPacienteForm" class="col s12 telaCadastro" method = "post">
          <div class="row">
            <div class="input-field col s12 m6 l6">
              <input placeholder="Nome" id = "nomePaciente" name = "nomePaciente" action = "formHandler/cadastroPaciente.php" type="text">
              <label for = "nomePaciente">Nome</label>
            </div>
            <div class="input-field col s12 m6 l6">
              <input placeholder="CPF" id = "cpfPaciente" name = "cpfPaciente" type="text">
              <label for = "cpfPaciente">CPF</label>
            </div>
           <div class="input-field col s12 m8 l8">
              <input placeholder="Endereço" id = "enderecoPaciente" name = "enderecoPaciente" type="text">
              <label for = "enderecoPaciente">Endereço</label>
          </div>
          <div class="input-field col s6 m4 l4">
              <input placeholder="Data Nascimento" id = "nascimentoPaciente" name = "nascimentoPaciente" type="text" >
              <label for = "nascimentoPaciente">Data de Nascimento</label>
          </div>
           <div class="input-field col s6 m6 l6">
              <input placeholder="Plano de Saúde" id = "planoPaciente" name = "planoPaciente" type="text">
              <label for = "planoPaciente">Plano de Saúde</label>
          </div>
           <div class="input-field col s12 m6 l6">
              <input placeholder="Telefone" id = "telefonePaciente" name = "telefonePaciente" type="text">
              <label for = "telefonePaciente">Telefone</label>
          </div>
        </div>
        <input type="submit">          
      </form>
    </div>
    <div id="cadastrarClinica">
      <form id="cadastrarClinicaForm" class="col s12 telaCadastro" method = "post">
          <div class="row">
            <div class="input-field col s12 m6 l6">
              <input placeholder="Nome" id = "nomeClinica" name = "nomeClinica" type="text">
              <label for = "nomeClinica">Nome</label>
            </div>
            <div class="input-field col s12 m6 l6">
              <input placeholder="Endereço" id = "enderecoClinica" name = "enderecoClinica" type="text">
              <label for = "enderecoClinica">Endereço</label>
          </div>
          <div class="input-field col s12 m6 l6">
            <input placeholder="Código" id = "codigoClinica" name = "codigoClinica" type="text">
              <label for = "codigoClinica">Código</label>
          </div>
        </div>  
        <input type="submit">        
      </form>
    </div>
    <div id="cadastrarNutricionista">
      <form id = "cadastrarNutricionistaForm" class="col s12 telaCadastro" method = "post">
          <div class="row">
            <div class="input-field col s12 m12 l12">
              <input placeholder="Nome" id = "nomeNutricionista" name = "nomeNutricionista" type="text">
              <label for = "nomeNutricionista">Nome</label>
            </div>
            <div class="input-field col s12 m6 l6">
              <input placeholder="CPF" id = "cpfNutricionista"  name="cpfNutricionista" type="text">
              <label for = "cpfNutricionista">CPF</label>
          </div>
          <div class="input-field col s12 m6 l6">
            <input placeholder="Código da Clínica" id = "codigoClinicaNutricionista" name="codigoClinicaNutricionista" type="text">
              <label for = "codigoClinicaNutricionista">Código da Clínica</label>
          </div>
        </div>    
        <input type="submit">      
      </form>
    </div>
     <div id="cadastrarConsulta">
        <form id = "cadastrarConsultaForm" class="col s12 telaCadastro">
          <div class="row">
            <div class="input-field col s12 m6 l6">
            <input placeholder="Id da Consulta" id = "idConsulta" name="idConsulta" type="text">
              <label for = "idConsulta">ID da Consulta</label>
            </div>
            <div class="input-field col s12 m6 l6">
              <input placeholder="CPF do Paciente" id = "cpfPacienteConsulta" name = "cpfPacienteConsulta" type="text">
              <label for = "cpfPacienteConsulta">CPF do Paciente</label>
            </div>
            <div class="input-field col s12 m6 l6">
              <input placeholder="CPF do Nutricionista" id = "cpfNutricionistaConsulta" name = "cpfNutricionistaConsulta" type="text">
              <label for = "cpfNutricionistaConsulta">CPF do Nutricionista</label>
            </div>
          <div class="input-field col s6 m4 l4">
              <input placeholder="Data da Consulta" id = "dataConsulta" name = "dataConsulta" type="text">
              <label for = "dataConsulta">Data da Consulta</label>
          </div>
        </div>   
        <input type="submit">       
      </form>
    </div>
    <div id="consultaPacientes">
        <table style="width = 100%">
          <tr>
            <th>CPF</th>
            <th>Nome</th>
            <th>Endereço</th>
            <th>Nascimento</th>
          </tr>
          <?php 
            $bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
            $query = 'SELECT cpf, nome, endereco, datanascimento FROM "Nutri".paciente;';
            $result = pg_query($bdcon, $query);
            $i = 0;
            if (!$result) {
               echo "Um erro ocorreu.\n";
               exit;
            }
            while ($row=pg_fetch_row($result,$i)) {
              echo "<tr>";
              for($j=0; $j < count($row); $j++) {
                echo "<td>".$row[$j]."</td>";
              }
              echo "</tr>";
              $i++;
            }       
          ?>
    </div>
    <div id="consultaClinicas">
        <table style="width = 100%">
          <tr>
            <th>Codigo</th>
            <th>Nome</th>
            <th>Endereço</th>
          </tr>
          <?php 
            $bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
            $query = 'SELECT cod, nome, endereco  FROM "Nutri".clinica;';
            $result = pg_query($bdcon, $query);
            $i = 0;
            if (!$result) {
               echo "Um erro ocorreu.\n";
               exit;
            }
            while ($row=pg_fetch_row($result,$i)) {
              echo "<tr>";
              for($j=0; $j < count($row); $j++) {
                echo "<td>".$row[$j]."</td>";
              }
              echo "</tr>";
              $i++;
            }       
          ?>
    </div>
    <div id="consultaNutricionistas">
        <table style="width = 100%">
          <tr>
            <th>CPF</th>
            <th>Nome</th>
            <th>Codigo Clinica</th>
          </tr>
          <?php 
            $bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
            $query = 'SELECT cpf, nome, cod  FROM "Nutri".nutricionista;';
            $result = pg_query($bdcon, $query);
            $i = 0;
            if (!$result) {
               echo "Um erro ocorreu.\n";
               exit;
            }
            while ($row=pg_fetch_row($result,$i)) {
              echo "<tr>";
              for($j=0; $j < count($row); $j++) {
                echo "<td>".$row[$j]."</td>";
              }
              echo "</tr>";
              $i++;
            }       
          ?>
    </div>
    <div id="consultaConsultas">
        <table style="width = 100%">
          <tr>
            <th>ID</th>
            <th>CPF Paciente</th>
            <th>CPF Nutricionista</th>
            <th>Data</th>
          </tr>
          <?php 
            $bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
            $query = 'SELECT id, cpfp, cpfn, data  FROM "Nutri".consulta;';
            $result = pg_query($bdcon, $query);
            $i = 0;
            if (!$result) {
               echo "Um erro ocorreu.\n";
               exit;
            }
            while ($row=pg_fetch_row($result,$i)) {
              echo "<tr>";
              for($j=0; $j < count($row); $j++) {
                echo "<td>".$row[$j]."</td>";
              }
              echo "</tr>";
              $i++;
            }       
          ?>
    </div>
    <div id="consultarNutricionistasClinica">
        <form id = "consultarNutricionistasClinicaForm" class="col s12 telaCadastro" action="formHandler/consultaNutricionistasClinica.php" method="post">
          <div class="row">
            <div class="input-field col s12 m6 l6">
            <input placeholder="Nome da Clinica" id = "nomeClinica" name="nomeClinica" type="text">
              <label for = "nomeClinica">Nome da Clinica</label>
            </div>
        </div>   
        <input type="submit">       
      </form>
    </div>
    <div id="consultarPacientesNutricionista">
        <form id = "consultarPacientesNutricionistaForm" class="col s12 telaCadastro" action="formHandler/consultaPacientesNutricionista.php" method="post">
          <div class="row">
            <div class="input-field col s12 m6 l6">
            <input placeholder="Nome do Nutricionista" id = "nomeNutricionista" name="nomeNutricionista" type="text">
              <label for = "nomeNutricionista">Nome do Nutircionista</label>
            </div>
        </div>   
        <input type="submit">       
      </form>
    </div>
    </div>
    </body>
  </html>