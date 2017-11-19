<?php 
  $bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
  $name = $_POST['nomeNutricionista'];
    $query = 'select p.nome from "Nutri".paciente p , "Nutri".consulta c, "Nutri".nutricionista n where c.cpfp = p.cpf and c.cpfn = n.cpf and n.nome = '."'".$name."'".';';
    $result = pg_query($bdcon, $query);
      $i = 0;
        if (!$result) {
          echo "Um erro ocorreu.\n";
          exit;
        }
        echo "<table style='width = 100%'><tr><th>Nome</th></tr>";
        while ($row=pg_fetch_row($result,$i)) {
          echo "<tr>";
          for($j=0; $j < count($row); $j++) {
            echo "<td>".$row[$j]."</td>";
          }
          echo "</tr>";
          $i++;
        }       
        echo "</table>"
?>