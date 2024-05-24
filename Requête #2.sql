
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

/* 4- Nom des spécialités avec nombres des personnages par spécialité (trié par nombre de personnage décroissant*/

SELECT nom_specialite,
COUNT(id_personnage) AS nb_personnages
FROM personnage
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
GROUP BY personnage.id_specialite
ORDER BY nb_personnages DESC;

