/* 1-Nom des lieux qui finissent par 'um'*/

SELECT *
FROM Lieu
WHERE nom_lieu
LIKE "%um";

/* 2-Nombre de personnage par lieu(trié par nombre de personnage décroissant)*/

SELECT nom_lieu,
COUNT(id_personnage) 
AS nb_personnages
FROM personnage
INNER JOIN lieu 
ON personnage.id_lieu = lieu.id_lieu
GROUP BY personnage.id_lieu
ORDER BY nb_personnages DESC;

/* 3- Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage*/
SELECT personnage.nom_personnage, specialite.nom_specialite, personnage.adresse_personnage, lieu.nom_lieu
FROM personnage
INNER JOIN lieu 
ON personnage.id_lieu = lieu.id_lieu
INNER JOIN specialite 
ON personnage.id_specialite = specialite.id_specialite
ORDER BY lieu.nom_lieu, personnage.nom_personnage;

/* 4- Nom des spécialités avec nombres des personnages par spécialité (trié par nombre de personnage décroissant*/

SELECT nom_specialite,
COUNT(id_personnage) 
AS nb_personnages
FROM personnage
INNER JOIN specialite 
ON personnage.id_specialite = specialite.id_specialite
GROUP BY personnage.id_specialite
ORDER BY nb_personnages DESC;

/*5- Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates afficéhes au format jj/mm//aaaa)*/
 SELECT DATE_FORMAT(bataille.date_bataille, "%D %b %Y"), bataille.nom_bataille, lieu.nom_lieu
 FROM bataille
 INNER JOIN lieu 
 ON bataille.id_lieu = lieu.id_lieu
 ORDER BY bataille.date_bataille DESC;

 /*6-Nom des potions + couts de réalisation de la potion(trié par coût décroissant)*/

 SELECT 	potion.nom_potion,
SUM(ingredient.cout_ingredient * composer.qte) AS prix_potion
FROM potion
INNER JOIN composer 
ON potion.id_potion = composer.id_potion
INNER JOIN ingredient 
ON composer.id_ingredient = ingredient.id_ingredient
GROUP BY potion.id_potion
ORDER BY prix_potion DESC;

/*7- Nom des ingrédients+coût+quantité de chaque ingrédients qui composent la potion 'santé'*/

SELECT ingredient.nom_ingredient, ingredient.cout_ingredient, composer.qte
FROM ingredient
INNER JOIN composer 
ON ingredient.id_ingredient = composer.id_ingredient
INNER JOIN potion 
ON composer.id_potion = potion.id_potion
WHERE potion.nom_potion = 'Santé';

/*8-Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'*/
SELECT personnage.nom_personnage
FROM personnage
INNER JOIN prendre_casque
ON personnage.id_personnage = prendre_casque.id_personnage
WHERE prendre_casque.id_bataille = 1
GROUP BY personnage.id_personnage
HAVING SUM(prendre_casque.qte) >= ALL
 ( SELECT SUM(prendre_casque.qte)
 	FROM prendre_casque
 	WHERE prendre_casque.id_bataille = 1
 	GROUP BY prendre_casque.id_personnage);


/*9-Nom des personnages et leur quantité de potion bue (en les lcassant du plus grand buveur au plus petit)*/
SELECT personnage.nom_personnage,
SUM(boire.dose_boire) 
AS 'quantite_potion_bue'
FROM personnage
INNER JOIN boire 
ON personnage.id_personnage = boire.id_personnage
GROUP BY personnage.id_personnage
ORDER BY quantite_potion_bue DESC;

/*10-Nom de la bataille oèu le nombre de casques pris a été le plus important*/
SELECT bataille.nom_bataille
FROM bataille
INNER JOIN prendre_casque 
ON bataille.id_bataille = prendre_casque.id_bataille
GROUP BY bataille.id_bataille
HAVING SUM(prendre_casque.qte) >= ALL (
SELECT SUM(prendre_casque.qte) AS nombre_casque_pris
FROM bataille
INNER JOIN prendre_casque ON bataille.id_bataille = prendre_casque.id_bataille
GROUP BY prendre_casque.id_bataille);

/*11-Combien existe-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)*/
SELECT type_casque.nom_type_casque,
COUNT(type_casque.id_type_casque),
SUM(casque.cout_casque)
AS cout_total_casque
FROM type_casque
INNER JOIN casque 
ON type_casque.id_type_casque = casque.id_type_casque
GROUP BY type_casque.id_type_casque
ORDER BY cout_total_casque DESC;

/*12-Nom des potions dont un ingrédients est le poisson frais*/

SELECT potion.nom_potion
FROM potion
INNER JOIN composer 
ON composer.id_potion = potion.id_potion
INNER JOIN ingredient 
ON composer.id_ingredient = ingredient.id_ingredient
WHERE ingredient.nom_ingredient = 'Poisson frais';

/*13-Nom du/des lieux possédant le plus d'habitants, en dehors du village gaulois.*/
SELECT lieu.nom_lieu
FROM lieu
INNER JOIN personnage 
ON lieu.id_lieu = personnage.id_lieu
WHERE lieu.nom_lieu != 'Village gaulois';


/*14-Nom des personnage qui n'ont jamais bu de potions*/

SELECT personnage.nom_personnage
FROM personnage
WHERE personnage.id_personnage 
NOT IN (
	SELECT personnage.id_personnage 
	FROM personnage
INNER JOIN boire 
ON personnage.id_personnage = boire.id_personnage);

/*15-Nom du/des personnages qui n'ont pas le droit de boire de la potion 'Magique'*/

SELECT personnage.nom_personnage
FROM personnage
WHERE personnage.nom_personnage 
NOT IN (
    SELECT personnage.id_personnage
	FROM personnage
	INNER JOIN autoriser_boire 
    ON personnage.id_personnage = autoriser_boire.id_personnage
	WHERE id_potion=1);

 /*A- Ajoutez le personnage suivant: Champdeblix, agriculteur résidant à la ferme Hantassion de Rotomagus*/

INSERT INTO personnage (nom_personnage, id_specialite, adresse_personnage, id_lieu)
VALUES ('Champdeblix', 12, 'Ferme Hantassion', '6');

/*B- AUTORISEZ Bonemine à boire de la potion magique,*/

INSERT INTO autoriser_boire (id_potion, id_personnage)
VALUES (1, 12);

/*C- Supprimez les casques grecs qui n'ont jamais été pris lors d'une bataille */

DELETE */

/*D-Modifiez l'adresse de Zérozérosix : il a été mis en prison à Condate*/

UPDATE personnage
SET adresse_personnage = 'Prison', id_lieu = 9
WHERE id_personnage = 23;

/*E-La 'Soupe' ne doit plus contenir de  persil. */

DELETE FROM composer
WHERE (id_potion = 9 
AND id_ingredient = 19);

/*F-Obelix s'est trompé: ce sont 42 casques Weisenau, et non Ostrogoths qu'il a pris lors de la bataille 'Attaque de la banque postale'. Corrigez son erreur.*/

UPDATE prendre_casque 
SET id_casque= 10 , qte = 42
WHERE id_bataille = 9;











