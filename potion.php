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

$sqlQuery = 'SELECT potion.nom_potion FROM potion
JOIN potion ON boire.id_potion = potion.id_potion
JOIN personnage ON boire.id_personnage = personnage.id_personnage';

$potionStatement = $mysqlClient->prepare($sqlQuery);
$potionStatement -> execute();
$potions = $potionStatement->fetchAll();

echo "<table>
        <tr>
            <th>Potions bues </th>
        </tr>";

foreach ($potions as $potion) {
    echo "<tr>
    <td>".$potion['nom_potion']."</td>";
    
}

echo "</table>"

?>