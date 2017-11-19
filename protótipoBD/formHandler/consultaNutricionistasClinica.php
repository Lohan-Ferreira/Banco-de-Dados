<?php 
  $bdcon = pg_connect("host=localhost port=5432 dbname=trabbd user=postgres password=195100");
  $name = $_POST['nomeClinica'];
    $query = 'select n.nome from "Nutri".nutricionista n , "Nutri".clinica c  where n.cod = c.cod and c.nome = '."'".$name."'".'';
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