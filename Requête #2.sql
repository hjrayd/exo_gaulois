
/* 1-Nom des lieux qui finissent par 'um'*/

SELECT *
FROM Lieu
WHERE nom_lieu
LIKE "%um";

/* 2-Nombre de personnage par lieu(trié par nombre de personnage décroissant)*/

SELECT nom_lieu,
COUNT(id_personnage) AS nb_personnages
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
GROUP BY personnage.id_lieu
ORDER BY nb_personnages DESC;

/* 3- Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage*/
SELECT personnage.nom_personnage, specialite.nom_specialite, personnage.adresse_personnage, lieu.nom_lieu
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
ORDER BY lieu.nom_lieu, personnage.nom_personnage;
/* 4- Nom des spécialités avec nombres des personnages par spécialité (trié par nombre de personnage décroissant*/

SELECT nom_specialite,
COUNT(id_personnage) AS nb_personnages
FROM personnage
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
GROUP BY personnage.id_specialite
ORDER BY nb_personnages DESC;

/*5- Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates afficéhes au format jj/mm//aaaa)*/
 SELECT DATE_FORMAT(bataille.date_bataille, "%D %b %Y"), bataille.nom_bataille, lieu.nom_lieu
 FROM bataille
 INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
 ORDER BY bataille.date_bataille DESC;

 /*6-Nom des potions + couts de réalisation de la potion(trié par coût décroissant)*/

 SELECT 	potion.nom_potion,
SUM(ingredient.cout_ingredient * composer.qte) AS prix_potion
FROM potion
INNER JOIN composer ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
GROUP BY potion.id_potion
ORDER BY prix_potion DESC;
