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

$sqlQuery = 'SELECT DISTINCT potion.nom_potion 
FROM potion
JOIN boire ON potion.id_potion = boire.id_potion
JOIN personnage ON boire.id_personnage = personnage.id_personnage
WHERE personnage.id_personnage = :id_personnage';

$get_id_perso = $_GET['id'];
$potionStatement = $mysqlClient->prepare($sqlQuery);
$potionStatement -> execute(["id_personnage" => $get_id_perso]);
$potions = $potionStatement->fetchAll();

$sqlQuery = 'SELECT nom_personnage
FROM personnage
WHERE personnage.id_personnage = :id_personnage';

$persoStatement = $mysqlClient->prepare($sqlQuery);
$persoStatement -> execute(["id_personnage" => $get_id_perso]);
$personnages = $persoStatement->fetch();


echo "<table>
        <tr>
        <th>Personnage</th>
            <th>Potions bues </th>
        </tr>";

        foreach ($personnages as $personnage) {
            echo "<tr>
            <td>".$personnage."</td>";
        }

foreach ($potions as $potion) {
    echo "<td>".$potion['nom_potion']."</td>";
}


echo "</table>"

?>