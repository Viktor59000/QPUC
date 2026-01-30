-- ============================================
-- QPUC - Script d'installation complète
-- Importer ce fichier dans phpMyAdmin pour tout configurer
-- ============================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS `quiz_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `quiz_db`;

-- ============================================
-- TABLE: users (Authentification)
-- ============================================
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL UNIQUE,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- TABLE: questions
-- ============================================
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(50) NOT NULL,
  `difficulte` varchar(20) NOT NULL,
  `question` text NOT NULL,
  `indice` text DEFAULT NULL,
  `reponse_A` varchar(255) NOT NULL,
  `reponse_B` varchar(255) NOT NULL,
  `reponse_C` varchar(255) NOT NULL,
  `reponse_D` varchar(255) NOT NULL,
  `bonne_reponse` char(1) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- INSERTION: 100 Questions
-- ============================================

-- === FACILE (25 questions) ===
INSERT INTO `questions` (`theme`, `difficulte`, `question`, `reponse_A`, `reponse_B`, `reponse_C`, `reponse_D`, `bonne_reponse`) VALUES
('Sport', 'Facile', 'Combien de joueurs composent une équipe de football sur le terrain ?', '9', '10', '11', '12', 'C'),
('Sport', 'Facile', 'Quel sport se pratique avec une raquette et un volant ?', 'Tennis', 'Badminton', 'Squash', 'Ping-pong', 'B'),
('Géographie', 'Facile', 'Quelle est la capitale de la France ?', 'Lyon', 'Marseille', 'Paris', 'Bordeaux', 'C'),
('Géographie', 'Facile', 'Quel est le plus grand océan du monde ?', 'Atlantique', 'Indien', 'Arctique', 'Pacifique', 'D'),
('Histoire', 'Facile', 'En quelle année la Révolution française a-t-elle commencé ?', '1789', '1799', '1776', '1815', 'A'),
('Histoire', 'Facile', 'Qui a découvert l''Amérique en 1492 ?', 'Vasco de Gama', 'Christophe Colomb', 'Magellan', 'Marco Polo', 'B'),
('Sciences', 'Facile', 'Quelle planète est surnommée la planète rouge ?', 'Vénus', 'Jupiter', 'Mars', 'Saturne', 'C'),
('Sciences', 'Facile', 'Combien d''os possède le corps humain adulte ?', '186', '206', '226', '246', 'B'),
('Culture générale', 'Facile', 'Quelle est la couleur du ciel par beau temps ?', 'Vert', 'Bleu', 'Rouge', 'Jaune', 'B'),
('Culture générale', 'Facile', 'Combien de jours y a-t-il dans une semaine ?', '5', '6', '7', '8', 'C'),
('Animaux et plantes', 'Facile', 'Quel animal est le roi de la jungle ?', 'Tigre', 'Lion', 'Éléphant', 'Gorille', 'B'),
('Animaux et plantes', 'Facile', 'Combien de pattes a une araignée ?', '6', '8', '10', '12', 'B'),
('Musiques', 'Facile', 'Combien de cordes possède une guitare classique ?', '4', '5', '6', '7', 'C'),
('Musiques', 'Facile', 'Quel instrument a des touches noires et blanches ?', 'Flûte', 'Guitare', 'Piano', 'Violon', 'C'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quel est le personnage principal de Super Mario Bros ?', 'Luigi', 'Mario', 'Wario', 'Toad', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quelle entreprise a créé la PlayStation ?', 'Microsoft', 'Nintendo', 'Sony', 'Sega', 'C'),
('Sport', 'Facile', 'Dans quel sport utilise-t-on un ballon orange ?', 'Football', 'Volleyball', 'Basketball', 'Handball', 'C'),
('Géographie', 'Facile', 'Quel pays a pour capitale Rome ?', 'Espagne', 'Italie', 'Grèce', 'Portugal', 'B'),
('Histoire', 'Facile', 'Quel monument parisien a 324 mètres de haut ?', 'Arc de Triomphe', 'Tour Eiffel', 'Notre-Dame', 'Sacré-Cœur', 'B'),
('Sciences', 'Facile', 'Quel gaz respirons-nous principalement ?', 'Azote', 'Oxygène', 'CO2', 'Hélium', 'B'),
('Culture générale', 'Facile', 'Combien de mois y a-t-il dans une année ?', '10', '11', '12', '13', 'C'),
('Animaux et plantes', 'Facile', 'Quel animal fait miaou ?', 'Chien', 'Vache', 'Chat', 'Cochon', 'C'),
('Musiques', 'Facile', 'Quelle note vient après do, ré, mi ?', 'Sol', 'Fa', 'La', 'Si', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quel est le réseau social avec un oiseau bleu comme logo ?', 'Facebook', 'Instagram', 'Twitter', 'TikTok', 'C'),
('Sport', 'Facile', 'Combien de sets faut-il gagner pour remporter un match de tennis (Grand Chelem hommes) ?', '2', '3', '4', '5', 'B');

-- === MOYEN (25 questions) ===
INSERT INTO `questions` (`theme`, `difficulte`, `question`, `reponse_A`, `reponse_B`, `reponse_C`, `reponse_D`, `bonne_reponse`) VALUES
('Sport', 'Moyen', 'Quel pays a remporté la Coupe du Monde de football 2018 ?', 'Brésil', 'Allemagne', 'France', 'Argentine', 'C'),
('Sport', 'Moyen', 'Combien de points vaut un touchdown au football américain ?', '3', '5', '6', '7', 'C'),
('Géographie', 'Moyen', 'Quel est le plus long fleuve d''Europe ?', 'Danube', 'Rhin', 'Volga', 'Loire', 'C'),
('Géographie', 'Moyen', 'Quelle mer borde la côte sud de la France ?', 'Mer du Nord', 'Manche', 'Méditerranée', 'Adriatique', 'C'),
('Histoire', 'Moyen', 'Qui était le premier président des États-Unis ?', 'Lincoln', 'Jefferson', 'Washington', 'Adams', 'C'),
('Histoire', 'Moyen', 'En quelle année le mur de Berlin est-il tombé ?', '1987', '1989', '1991', '1993', 'B'),
('Sciences', 'Moyen', 'Quel est le symbole chimique de l''or ?', 'Ag', 'Au', 'Or', 'Go', 'B'),
('Sciences', 'Moyen', 'Quelle est la vitesse de la lumière approximativement ?', '150 000 km/s', '300 000 km/s', '450 000 km/s', '600 000 km/s', 'B'),
('Culture générale', 'Moyen', 'Qui a peint la Joconde ?', 'Michel-Ange', 'Léonard de Vinci', 'Raphaël', 'Botticelli', 'B'),
('Culture générale', 'Moyen', 'Quelle est la langue la plus parlée au monde ?', 'Anglais', 'Espagnol', 'Mandarin', 'Hindi', 'C'),
('Animaux et plantes', 'Moyen', 'Quel est le mammifère terrestre le plus rapide ?', 'Lion', 'Guépard', 'Gazelle', 'Léopard', 'B'),
('Animaux et plantes', 'Moyen', 'Combien de cœurs possède une pieuvre ?', '1', '2', '3', '4', 'C'),
('Musiques', 'Moyen', 'Qui a composé la 9ème symphonie ?', 'Mozart', 'Bach', 'Beethoven', 'Vivaldi', 'C'),
('Musiques', 'Moyen', 'De quel pays vient le groupe ABBA ?', 'Norvège', 'Suède', 'Finlande', 'Danemark', 'B'),
('Jeux Vidéos / Culture Web', 'Moyen', 'En quelle année est sorti le premier iPhone ?', '2005', '2007', '2009', '2010', 'B'),
('Jeux Vidéos / Culture Web', 'Moyen', 'Quel jeu vidéo a popularisé le Battle Royale ?', 'Fortnite', 'PUBG', 'Apex Legends', 'Call of Duty', 'B'),
('Sport', 'Moyen', 'Quel nageur détient le record de médailles olympiques ?', 'Ian Thorpe', 'Ryan Lochte', 'Michael Phelps', 'Mark Spitz', 'C'),
('Géographie', 'Moyen', 'Quel pays a le plus grand nombre d''habitants ?', 'Inde', 'États-Unis', 'Chine', 'Indonésie', 'C'),
('Histoire', 'Moyen', 'Qui était surnommé le Roi Soleil ?', 'Louis XIII', 'Louis XIV', 'Louis XV', 'Louis XVI', 'B'),
('Sciences', 'Moyen', 'Combien de planètes compte notre système solaire ?', '7', '8', '9', '10', 'B'),
('Culture générale', 'Moyen', 'Quel est le plus haut sommet du monde ?', 'K2', 'Mont Blanc', 'Everest', 'Kilimandjaro', 'C'),
('Animaux et plantes', 'Moyen', 'Quel est le plus grand animal ayant jamais existé ?', 'Éléphant', 'Dinosaure T-Rex', 'Baleine bleue', 'Requin mégalodon', 'C'),
('Musiques', 'Moyen', 'Quel chanteur est surnommé le King of Pop ?', 'Prince', 'Michael Jackson', 'Elvis Presley', 'Freddie Mercury', 'B'),
('Jeux Vidéos / Culture Web', 'Moyen', 'Quel est le jeu le plus vendu de tous les temps ?', 'GTA V', 'Tetris', 'Minecraft', 'Wii Sports', 'C'),
('Sport', 'Moyen', 'Combien de joueurs composent une équipe de rugby à XV ?', '13', '14', '15', '16', 'C');

-- === DIFFICILE (50 questions) ===
INSERT INTO `questions` (`theme`, `difficulte`, `question`, `reponse_A`, `reponse_B`, `reponse_C`, `reponse_D`, `bonne_reponse`) VALUES
('Sport', 'Difficile', 'Quel cycliste a remporté 5 Tours de France consécutifs (1999-2005) avant d''être déchu ?', 'Jan Ullrich', 'Lance Armstrong', 'Miguel Indurain', 'Chris Froome', 'B'),
('Sport', 'Difficile', 'En quelle année les premiers Jeux Olympiques modernes ont-ils eu lieu ?', '1892', '1896', '1900', '1904', 'B'),
('Sport', 'Difficile', 'Quel pays a inventé le judo ?', 'Chine', 'Corée', 'Japon', 'Vietnam', 'C'),
('Sport', 'Difficile', 'Combien de temps dure un match de water-polo (4 périodes) ?', '24 min', '28 min', '32 min', '36 min', 'C'),
('Géographie', 'Difficile', 'Quel est le plus petit pays du monde ?', 'Monaco', 'Vatican', 'Saint-Marin', 'Liechtenstein', 'B'),
('Géographie', 'Difficile', 'Quelle est la capitale de l''Australie ?', 'Sydney', 'Melbourne', 'Canberra', 'Perth', 'C'),
('Géographie', 'Difficile', 'Quel pays possède le plus de fuseaux horaires ?', 'Russie', 'États-Unis', 'France', 'Chine', 'C'),
('Géographie', 'Difficile', 'Quel détroit sépare l''Europe de l''Asie ?', 'Gibraltar', 'Bosphore', 'Magellan', 'Ormuz', 'B'),
('Histoire', 'Difficile', 'En quelle année Napoléon a-t-il été couronné empereur ?', '1799', '1802', '1804', '1806', 'C'),
('Histoire', 'Difficile', 'Qui a assassiné Jules César ?', 'Marc Antoine', 'Brutus', 'Pompée', 'Crassus', 'B'),
('Histoire', 'Difficile', 'Quelle bataille a marqué la fin de Napoléon en 1815 ?', 'Austerlitz', 'Trafalgar', 'Waterloo', 'Iéna', 'C'),
('Histoire', 'Difficile', 'Quel traité a mis fin à la Première Guerre mondiale ?', 'Versailles', 'Westphalie', 'Paris', 'Vienne', 'A'),
('Sciences', 'Difficile', 'Quel scientifique a découvert la pénicilline ?', 'Pasteur', 'Fleming', 'Koch', 'Jenner', 'B'),
('Sciences', 'Difficile', 'Quelle est la formule chimique de l''eau lourde ?', 'H2O', 'D2O', 'H3O', 'HDO', 'B'),
('Sciences', 'Difficile', 'Quel élément chimique a le numéro atomique 79 ?', 'Argent', 'Or', 'Platine', 'Cuivre', 'B'),
('Sciences', 'Difficile', 'Qui a formulé la théorie de la relativité ?', 'Newton', 'Bohr', 'Einstein', 'Planck', 'C'),
('Culture générale', 'Difficile', 'Quel est le vrai nom de Molière ?', 'Jean Racine', 'Jean-Baptiste Poquelin', 'Pierre Corneille', 'Denis Diderot', 'B'),
('Culture générale', 'Difficile', 'Combien de livres composent la Bible catholique ?', '66', '73', '75', '80', 'B'),
('Culture générale', 'Difficile', 'Quel philosophe grec a fondé l''Académie ?', 'Socrate', 'Platon', 'Aristote', 'Épicure', 'B'),
('Culture générale', 'Difficile', 'Quelle est l''unité de mesure de l''intensité électrique ?', 'Volt', 'Watt', 'Ampère', 'Ohm', 'C'),
('Animaux et plantes', 'Difficile', 'Quel est le seul mammifère capable de voler ?', 'Écureuil volant', 'Chauve-souris', 'Colugo', 'Phalanger', 'B'),
('Animaux et plantes', 'Difficile', 'Combien de pattes a un mille-pattes en moyenne ?', '100', '200-300', '30-90', '500', 'C'),
('Animaux et plantes', 'Difficile', 'Quel arbre peut vivre plus de 5000 ans ?', 'Chêne', 'Séquoia', 'Pin Bristlecone', 'Olivier', 'C'),
('Animaux et plantes', 'Difficile', 'Quel animal a le cerveau le plus gros par rapport à sa taille ?', 'Éléphant', 'Dauphin', 'Fourmi', 'Humain', 'C'),
('Musiques', 'Difficile', 'Qui a composé Les Quatre Saisons ?', 'Bach', 'Mozart', 'Vivaldi', 'Haendel', 'C'),
('Musiques', 'Difficile', 'En quelle année Elvis Presley est-il décédé ?', '1975', '1977', '1979', '1981', 'B'),
('Musiques', 'Difficile', 'Quel instrument joue Yo-Yo Ma ?', 'Violon', 'Piano', 'Violoncelle', 'Contrebasse', 'C'),
('Musiques', 'Difficile', 'Combien de symphonies Beethoven a-t-il composées ?', '7', '8', '9', '10', 'C'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quel est le vrai nom du créateur de Minecraft ?', 'Markus Persson', 'Gabe Newell', 'Shigeru Miyamoto', 'John Carmack', 'A'),
('Jeux Vidéos / Culture Web', 'Difficile', 'En quelle année YouTube a-t-il été fondé ?', '2003', '2005', '2007', '2009', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quel est le personnage principal de la série The Witcher ?', 'Geralt de Riv', 'Ciri', 'Yennefer', 'Vesemir', 'A'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Combien de générations de Pokémon existe-t-il (en 2024) ?', '7', '8', '9', '10', 'C'),
('Sport', 'Difficile', 'Quel est le record du monde du 100m ?', '9.58s', '9.63s', '9.69s', '9.72s', 'A'),
('Sport', 'Difficile', 'Quel joueur de tennis a remporté le plus de Grand Chelem ?', 'Federer', 'Nadal', 'Djokovic', 'Sampras', 'C'),
('Géographie', 'Difficile', 'Quel fleuve traverse Le Caire ?', 'Tigre', 'Euphrate', 'Nil', 'Jourdain', 'C'),
('Géographie', 'Difficile', 'Quelle est la plus haute montagne d''Afrique ?', 'Mont Kenya', 'Kilimandjaro', 'Drakensberg', 'Atlas', 'B'),
('Histoire', 'Difficile', 'Quel empire a construit Machu Picchu ?', 'Aztèque', 'Maya', 'Inca', 'Olmèque', 'C'),
('Histoire', 'Difficile', 'Qui a été la dernière reine de France ?', 'Marie de Médicis', 'Marie-Antoinette', 'Marie-Louise', 'Eugénie de Montijo', 'B'),
('Sciences', 'Difficile', 'Quel physicien a découvert les rayons X ?', 'Curie', 'Röntgen', 'Becquerel', 'Planck', 'B'),
('Sciences', 'Difficile', 'Quelle molécule porte l''information génétique ?', 'ARN', 'ADN', 'Protéine', 'Lipide', 'B'),
('Culture générale', 'Difficile', 'Quel est le plus ancien musée du monde ?', 'Louvre', 'British Museum', 'Musées du Vatican', 'Galerie des Offices', 'C'),
('Culture générale', 'Difficile', 'Qui a écrit Don Quichotte ?', 'Cervantès', 'Lope de Vega', 'Calderón', 'Tirso de Molina', 'A'),
('Animaux et plantes', 'Difficile', 'Quel est le venin le plus mortel au monde ?', 'Mamba noir', 'Taipan du désert', 'Cuboméduse', 'Cône géographe', 'C'),
('Animaux et plantes', 'Difficile', 'Combien de temps un éléphant est-il en gestation ?', '12 mois', '18 mois', '22 mois', '24 mois', 'C'),
('Musiques', 'Difficile', 'Quel opéra de Mozart raconte l''histoire de Don Juan ?', 'Les Noces de Figaro', 'La Flûte enchantée', 'Don Giovanni', 'Così fan tutte', 'C'),
('Musiques', 'Difficile', 'Quel groupe a sorti l''album "The Dark Side of the Moon" ?', 'Led Zeppelin', 'Pink Floyd', 'The Who', 'Deep Purple', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quelle console a introduit le motion gaming grand public ?', 'PlayStation 3', 'Xbox 360', 'Nintendo Wii', 'Nintendo Switch', 'C'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quel est le premier jeu à avoir utilisé le ray tracing en temps réel ?', 'Cyberpunk 2077', 'Battlefield V', 'Metro Exodus', 'Control', 'B'),
('Sport', 'Difficile', 'Quel boxeur est surnommé The Greatest ?', 'Mike Tyson', 'Muhammad Ali', 'Floyd Mayweather', 'Sugar Ray Leonard', 'B'),
('Géographie', 'Difficile', 'Quelle est la capitale du Kazakhstan ?', 'Almaty', 'Astana', 'Bichkek', 'Tachkent', 'B');

-- ============================================
-- FIN DU SCRIPT
-- ============================================
SELECT 'Installation terminée ! 100 questions insérées.' AS Message;
