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

$sqlQuery = 'SELECT nom_personnage, lieu.nom_lieu FROM personnage
JOIN lieu ON personnage.id_lieu = lieu.id_lieu';

$persoStatement = $mysqlClient->prepare($sqlQuery);
$persoStatement -> execute();
$personnages = $persoStatement->fetchAll();

echo "<table>
        <tr>
            <th>Nom</th>
            <th>Lieu d'habitation</th>
        </tr>";

foreach ($personnages as $personnage) {
    echo "<tr>
    <td>".$personnage['nom_personnage']."</td>
    <td>".$personnage['nom_lieu']."</td>";
}

echo "</table>"

?>

