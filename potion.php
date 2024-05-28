<?php
session_start();

try
{
    $mysqlClient = new PDO('mysql:host=localhost;dbname=gaulois_hajar;charset=utf8', 'root', '');
}
catch (Exception $e)
{
    die('Erreur : ' . $e->getMessage());
}

$sqlQuery = 'SELECT *
FROM personnage
WHERE personnage.id_personnage = :id';

$id = $_GET['id'];
$persoStatement = $mysqlClient->  prepare($sqlQuery);
$persoStatement -> execute(["id" => $id]);
$personnage = $persoStatement->fetch();

echo $personnage['nom_personnage'];


$sqlQuery2 = 'SELECT DISTINCT potion.nom_potion 
FROM potion
JOIN boire ON potion.id_potion = boire.id_potion
JOIN personnage ON boire.id_personnage = personnage.id_personnage
WHERE personnage.id_personnage = :id';


$potionStatement = $mysqlClient ->prepare($sqlQuery2);
$potionStatement -> execute(["id" => $id]);
$potions = $potionStatement->fetchAll();

echo "<table>
        <tr>
            <th>Potions bues </th>
        </tr>";
        
foreach ($potions as $potion) {
    echo "<td>".$potion['nom_potion']."</td>";
}


echo "</table>"

?>