<?php
try
{
    $mysqlClient = new PDO('mysql:host=localhost;dbname=gaulois_hajar;charset=utf8', 'root', '');
}
catch (Exception $e)
{
    die('Erreur : ' . $e->getMessage());
}

$sqlQuery = 'SELECT nom_personnage FROM personnage';
$persoStatement = $mysqlClient->prepare($sqlQuery);
$persoStatement -> execute();
$perso = $persoStatement->fetchAll();

foreach ($personnages as $personnage) {
    ?>
<p><?php echo $personnage['lieu']; ?></p>

<?php
}
?>

