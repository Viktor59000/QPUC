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
DROP TABLE IF EXISTS `questions`;
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
-- INSERTION: Questions QPUC
-- ============================================

-- =====================
-- FACILE (35 questions)
-- =====================
INSERT INTO `questions` (`theme`, `difficulte`, `question`, `reponse_A`, `reponse_B`, `reponse_C`, `reponse_D`, `bonne_reponse`) VALUES
('Littérature', 'Facile', 'Après la Bible, quel livre publié en avril 1943 par Antoine de Saint-Exupéry est l''ouvrage littéraire le plus traduit au monde ?', 'L''Étranger', 'Le Petit Prince', 'Les Misérables', 'Candide', 'B'),
('Sport', 'Facile', 'Combien de joueurs sont présents sur le terrain au début d''un match de football ?', '20', '22', '24', '18', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quelle anagramme de son prénom le youtubeur Maxime Chabroud a-t-il utilisé comme pseudonyme ?', 'Mixame', 'Amixem', 'Maximex', 'Xemami', 'B'),
('Cinéma', 'Facile', 'Quel troisième opus d''une série de films sorti en 2025 est sous-titré "De feu et de cendres" ?', 'Star Wars', 'Avatar', 'Jurassic World', 'Transformers', 'B'),
('Sciences', 'Facile', 'Quelle planète, la plus proche du Soleil, est visible depuis la Terre ?', 'Vénus', 'Mars', 'Mercure', 'Jupiter', 'C'),
('Animaux et plantes', 'Facile', 'Quel nom constitué d''une syllabe redoublée désigne aussi le dronte, oiseau disparu de l''île Maurice ?', 'Coco', 'Dodo', 'Bobo', 'Roro', 'B'),
('Sport', 'Facile', 'Quel nom utilise-t-on au bowling lorsque l''on fait tomber les dix quilles en deux coups ?', 'Strike', 'Spare', 'Split', 'Turkey', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quelle pâtisserie donne son nom à un petit fichier déposé sur le disque dur lors de la consultation de sites web ?', 'Madeleine', 'Croissant', 'Cookie', 'Brownie', 'C'),
('Culture générale', 'Facile', 'Dans l''acronyme EHPAD, quel mot est représenté par la lettre D ?', 'Durables', 'Dépendantes', 'Démunies', 'Déficientes', 'B'),
('Littérature', 'Facile', 'Quelle année constitue le titre d''un roman dystopique écrit par George Orwell ?', '1984', '2001', '1968', '1776', 'A'),
('Culture générale', 'Facile', 'Quel super-héros est le surnom d''Alain Robert, escaladeur français d''immeubles à mains nues ?', 'Batman', 'Superman', 'Spider-man', 'Iron Man', 'C'),
('Jeux Vidéos / Culture Web', 'Facile', 'Dans le jeu vidéo, que signifie le sigle FPS qualifiant des jeux comme Doom ou Call of Duty ?', 'Fast Player Shooter', 'First Person Shooter', 'Full Power System', 'Fight Per Second', 'B'),
('Cinéma', 'Facile', 'De son vrai nom Solaro, quel humoriste français a réalisé le film "Un p''tit truc en plus" en 2024 ?', 'Kev Adams', 'Artus', 'Gad Elmaleh', 'Jamel Debbouze', 'B'),
('Histoire', 'Facile', 'Qui est le seul président de la République française ayant également été maire de Paris ?', 'François Mitterrand', 'Nicolas Sarkozy', 'Jacques Chirac', 'Valéry Giscard d''Estaing', 'C'),
('Géographie', 'Facile', 'Quelle montagne est le deuxième plus haut sommet du monde avec ses 8611 mètres ?', 'Mont Blanc', 'Kangchenjunga', 'K2', 'Lhotse', 'C'),
('Animaux et plantes', 'Facile', 'Quel chien à la robe blanche tachetée de noir est la mascotte des pompiers aux États-Unis ?', 'Beagle', 'Dalmatien', 'Boxer', 'Labrador', 'B'),
('Culture générale', 'Facile', 'Quel nom anglais désigne la partie avant d''un avion où se situent les pilotes ?', 'Cabin', 'Cockpit', 'Deck', 'Bridge', 'B'),
('Sport', 'Facile', 'Quel golfeur étasunien né en 1975 a remporté les Masters en 1997 et 2019 ?', 'Phil Mickelson', 'Tiger Woods', 'Jack Nicklaus', 'Rory McIlroy', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quel nom porte la marque de kombucha créée par Squeezie ?', 'Fizzy', 'Bubbly', 'Ciao', 'Fresh', 'C'),
('Culture générale', 'Facile', 'Quel animateur dont le nom de famille est Fam présente "N''oubliez pas les paroles" depuis 2007 ?', 'Cyril', 'Nagui', 'Arthur', 'Laurent', 'B'),
('Sciences', 'Facile', 'Quel élément chimique de numéro atomique 11 est représenté par les lettres Na ?', 'Nickel', 'Sodium', 'Néon', 'Azote', 'B'),
('Musiques', 'Facile', 'Quel rappeur français de la Sexion d''Assaut a sorti l''album "Les Yeux plus gros que le monde" en 2014 ?', 'Gims', 'Black M', 'Lefa', 'Maska', 'B'),
('Animaux et plantes', 'Facile', 'Quel oiseau a laissé son nom à la politique consistant à ne pas voir la réalité en face ?', 'Paon', 'Autruche', 'Flamant', 'Pélican', 'B'),
('Culture générale', 'Facile', 'Quels petits personnages bleus créés par Peyo ont pour ennemi le chat Azraël et le sorcier Gargamel ?', 'Les Schtroumpfs', 'Les Trolls', 'Les Minions', 'Les Moomins', 'A'),
('Sport', 'Facile', 'Quel sport se pratique sur un cercle de bottes de paille de riz appelé dohyō ?', 'Judo', 'Sumo', 'Karaté', 'Aïkido', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quelle émission présentée sur Twitch par Domingo évoque par son nom une céréale soufflée ?', 'Chips', 'Popcorn', 'Céréales', 'Crackers', 'B'),
('Géographie', 'Facile', 'Quel état des États-Unis est le plus grand en superficie avec 1,723 million de km² ?', 'Texas', 'Californie', 'Montana', 'Alaska', 'D'),
('Musiques', 'Facile', 'Dans quelle ville de Californie se situe la maison bleue que Maxime Le Forestier décrit en 1972 ?', 'Los Angeles', 'San Francisco', 'San Diego', 'Sacramento', 'B'),
('Culture générale', 'Facile', 'Quelle variété de pêche dont le noyau n''adhère pas à la chair se distingue du brugnon ?', 'Abricot', 'Nectarine', 'Prune', 'Mangue', 'B'),
('Sport', 'Facile', 'Quelle discipline du sport est associée à Jérémy Florès et Kelly Slater ?', 'Skateboard', 'Surf', 'Snowboard', 'Wakeboard', 'B'),
('Jeux Vidéos / Culture Web', 'Facile', 'Quel vidéaste possède depuis mai 2024 le plus d''abonnés YouTube en France, dépassant Squeezie ?', 'Cyprien', 'Tibo InShape', 'Léna Situations', 'MrBeast', 'B'),
('Musiques', 'Facile', 'Quel groupe ayant interprété le générique de "Friends" fait référence à un peintre hollandais ?', 'The Vermeers', 'The Rembrandts', 'The Van Goghs', 'The Monets', 'B'),
('Sciences', 'Facile', 'Quel doigt de la main tire son nom de son utilisation à montrer ou désigner des choses ?', 'Pouce', 'Index', 'Majeur', 'Annulaire', 'B'),
('Géographie', 'Facile', 'Dans quel pays se situe le parc floral de Keukenhof, célèbre pour ses tulipes ?', 'Belgique', 'Pays-Bas', 'Danemark', 'Allemagne', 'B'),
('Culture générale', 'Facile', 'Par quel nom plus commun est aussi désigné le coquillage du genre solen ?', 'Cuillère', 'Couteau', 'Fourchette', 'Pince', 'B');

-- =====================
-- MOYEN (35 questions)
-- =====================
INSERT INTO `questions` (`theme`, `difficulte`, `question`, `reponse_A`, `reponse_B`, `reponse_C`, `reponse_D`, `bonne_reponse`) VALUES
('Histoire', 'Moyen', 'Quelle fleur a laissé son nom à la révolution du 25 avril 1974 au Portugal ?', 'Roses', 'Tulipes', 'Œillets', 'Lys', 'C'),
('Géographie', 'Moyen', 'Avec quel pays le Kazakhstan partage-t-il la souveraineté sur la Mer d''Aral ?', 'Turkménistan', 'Ouzbékistan', 'Kirghizistan', 'Tadjikistan', 'B'),
('Musiques', 'Moyen', 'Quelle chanteuse islandaise, ancienne meneuse du groupe The Sugarcubes, est surnommée "La Reine de la pop expérimentale" ?', 'Björk', 'Sia', 'Lorde', 'Grimes', 'A'),
('Culture générale', 'Moyen', 'Quel surnom donné aux représentants du G7/G8/G20 tire son nom d''un groupe ethnique népalais ?', 'Gurkha', 'Sherpa', 'Tamang', 'Newari', 'B'),
('Musiques', 'Moyen', 'Quel pianiste chinois né en 1982, surnommé "La rockstar du classique", porte un nom doublant une syllabe ?', 'Yuja Wang', 'Lang Lang', 'Li Yundi', 'Zou Zou', 'B'),
('Cinéma', 'Moyen', 'Quel réalisateur japonais, auteur de "Rashōmon" et "Les Sept Samouraïs", est décédé en 1998 ?', 'Hayao Miyazaki', 'Akira Kurosawa', 'Yasujirō Ozu', 'Kenji Mizoguchi', 'B'),
('Histoire', 'Moyen', 'Quel président américain a présenté en 1918 son programme des Quatorze Points pour reconstruire l''Europe ?', 'Theodore Roosevelt', 'Woodrow Wilson', 'William Taft', 'Warren Harding', 'B'),
('Sciences', 'Moyen', 'Quel adjectif qualifie la maladie auto-immune également appelée entéropathie au gluten ?', 'Cœliaque', 'Chronique', 'Crohnienne', 'Colique', 'A'),
('Géographie', 'Moyen', 'Quelle ville française abrite la Place de Jaude et une statue de Vercingétorix par Bartholdi ?', 'Lyon', 'Clermont-Ferrand', 'Saint-Étienne', 'Grenoble', 'B'),
('Musiques', 'Moyen', 'Quel groupe de musique italien a remporté l''Eurovision 2021 avec "Zitti e buoni" ?', 'Modà', 'Måneskin', 'Lacuna Coil', 'Negramaro', 'B'),
('Culture générale', 'Moyen', 'Avec quelle plante, aussi appelée Herbe du Saint-Esprit, des religieuses de Niort ont-elles créé une confiserie ?', 'Menthe', 'Angélique', 'Verveine', 'Mélisse', 'B'),
('Sciences', 'Moyen', 'Quel minéral à texture fibreuse, présent dans les toitures, est responsable de l''asbestose ?', 'Ite', 'Amiante', 'Silice', 'Plomb', 'B'),
('Musiques', 'Moyen', 'De quel genre musical portugais Amalia Rodrigues est-elle considérée comme la reine ?', 'Flamenco', 'Fado', 'Tango', 'Bossa Nova', 'B'),
('Histoire', 'Moyen', 'Dans quelle salle les apôtres et Jésus-Christ se sont-ils réunis pour la Cène ?', 'Sanctuaire', 'Cénacle', 'Temple', 'Synagogue', 'B'),
('Histoire', 'Moyen', 'En dehors de Grover Cleveland, quel président américain a été élu pour deux mandats non consécutifs ?', 'Richard Nixon', 'Donald Trump', 'George Bush', 'Jimmy Carter', 'B'),
('Géographie', 'Moyen', 'Quel nom français est aussi donné à la ville indienne de Varanasi sur les bords du Gange ?', 'Calcutta', 'Bénarès', 'Bombay', 'Madras', 'B'),
('Culture générale', 'Moyen', 'Quel journal fondé en 1826 tient son nom d''un personnage de Beaumarchais ?', 'L''Express', 'Le Figaro', 'Le Monde', 'Libération', 'B'),
('Cinéma', 'Moyen', 'À qui doit-on "Le Voyage dans la Lune" en 1902, premier film de science-fiction de l''Histoire ?', 'Louis Lumière', 'Georges Méliès', 'Charles Pathé', 'Léon Gaumont', 'B'),
('Histoire', 'Moyen', 'Dans quelle ville eut lieu l''assassinat de l''archiduc François-Ferdinand le 28 juin 1914 ?', 'Vienne', 'Belgrade', 'Sarajevo', 'Zagreb', 'C'),
('Culture générale', 'Moyen', 'De quelle pierre précieuse la nuance exacte de vert est-elle dite smaragdine ?', 'Jade', 'Émeraude', 'Malachite', 'Péridot', 'B'),
('Culture générale', 'Moyen', 'De quelle forme sont les beignets farcis indiens appelés samoussas ?', 'Carrée', 'Ronde', 'Triangulaire', 'Rectangle', 'C'),
('Littérature', 'Moyen', 'Quel dramaturge d''origine roumaine a écrit "Les Chaises" et "La Cantatrice chauve" ?', 'Samuel Beckett', 'Eugène Ionesco', 'Jean Genet', 'Arthur Adamov', 'B'),
('Histoire', 'Moyen', 'Quel roi de France a le deuxième règne le plus long après Louis XIV avec 59 ans ?', 'Louis XIII', 'Louis XV', 'Louis XVI', 'Louis XVIII', 'B'),
('Musiques', 'Moyen', 'Quel chanteur mort en mars 1978 était le propriétaire du moulin de Dannemois ?', 'Michel Berger', 'Claude François', 'Jacques Brel', 'Serge Gainsbourg', 'B'),
('Culture générale', 'Moyen', 'Quel nom argotique désignant les croûtes de pizza est aussi le côté de la route des piétons ?', 'Trottoir', 'Caniveau', 'Bordure', 'Accotement', 'A'),
('Culture générale', 'Moyen', 'Quelle ville imaginaire créée par Lovecraft a donné son nom à l''asile des ennemis de Batman ?', 'Innsmouth', 'Arkham', 'Dunwich', 'Miskatonic', 'B'),
('Sport', 'Moyen', 'Quel bijou est traditionnellement remis au vainqueur du Super Bowl ?', 'Médaille', 'Bague', 'Bracelet', 'Collier', 'B'),
('Jeux Vidéos / Culture Web', 'Moyen', 'Quel jeu vidéo d''infiltration met en scène 47, un tueur à gages créé à partir d''ADN de criminels ?', 'Splinter Cell', 'Hitman', 'Metal Gear', 'Dishonored', 'B'),
('Culture générale', 'Moyen', 'Quelle marque de bière fictive des Simpson, parodie de Budweiser, est la préférée d''Homer ?', 'Buzz', 'Duff', 'Flaming Moe', 'Pawtucket', 'B'),
('Histoire', 'Moyen', 'Qui a tenu le poste de Premier ministre du Royaume-Uni le plus longtemps sous Elizabeth II ?', 'Winston Churchill', 'Margaret Thatcher', 'Tony Blair', 'Harold Wilson', 'B'),
('Sciences', 'Moyen', 'Quel mot emprunté au latin désigne la zone rosée entourant le téton ?', 'Papille', 'Aréole', 'Auréole', 'Nodule', 'B'),
('Musiques', 'Moyen', 'Quelle chanson reprise par Los Lobos en 1987 fut d''abord chantée par Ritchie Valens ?', 'Tequila', 'La Bamba', 'Macarena', 'Despacito', 'B'),
('Animaux et plantes', 'Moyen', 'Quel canidé est aussi appelé warrigal, mot venant de la langue dharug ?', 'Coyote', 'Dingo', 'Chacal', 'Loup', 'B'),
('Histoire', 'Moyen', 'Quel PDG d''un groupe aéronautique a changé son nom Bloch en référence au pseudonyme de résistant de son frère ?', 'Dassault', 'Lagardère', 'Bouygues', 'Bolloré', 'A'),
('Jeux Vidéos / Culture Web', 'Moyen', 'Dans le manga "Haikyū!!", quel sport est au centre de l''intrigue ?', 'Basketball', 'Volley-ball', 'Badminton', 'Tennis', 'B');

-- =====================
-- DIFFICILE (50 questions)
-- =====================
INSERT INTO `questions` (`theme`, `difficulte`, `question`, `reponse_A`, `reponse_B`, `reponse_C`, `reponse_D`, `bonne_reponse`) VALUES
('Sport', 'Difficile', 'Quelle sportive française, championne du monde de cyclisme 2014 et olympique VTT 2024, a remporté le Tour de France féminin 2025 ?', 'Marion Rousse', 'Pauline Ferrand-Prévôt', 'Juliette Labous', 'Audrey Cordon-Ragot', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quelle société japonaise a laissé son nom au premier code de triche de l''Histoire, développé dans Gradius ?', 'Capcom', 'Konami', 'Sega', 'Namco', 'B'),
('Cinéma', 'Difficile', 'Quel acteur français s''est éteint dans le domaine de La Brûlerie, dans le Loiret ?', 'Jean-Paul Belmondo', 'Alain Delon', 'Jean Gabin', 'Lino Ventura', 'B'),
('Culture générale', 'Difficile', 'Sous quel nom de famille sont connus les frères hors-la-loi Bob, Grat, Bill et Emmett dans l''Ouest américain ?', 'James', 'Dalton', 'Younger', 'Barker', 'B'),
('Sciences', 'Difficile', 'De quelle espèce animale Jane Goodall, éthologue décédée en 2025, était-elle spécialiste ?', 'Gorilles', 'Chimpanzés', 'Orangs-outans', 'Bonobos', 'B'),
('Géographie', 'Difficile', 'Quel est le nom actuel de la plus grande place de Paris avec 7,56 hectares dans le 8e ?', 'Place de la République', 'Place de la Concorde', 'Place Vendôme', 'Place de la Bastille', 'B'),
('Musiques', 'Difficile', 'Quelle chanson de merengue, reprise par Soolking en 2022, est le plus grand succès d''Elvis Crespo en 1998 ?', 'Oye Como Va', 'Suavemente', 'Livin'' La Vida Loca', 'Bailando', 'B'),
('Culture générale', 'Difficile', 'Quelle couleur est associée au thon dans l''autre nom du poisson appelé albacore ?', 'Rouge', 'Jaune', 'Blanc', 'Bleu', 'B'),
('Culture générale', 'Difficile', 'Quelle marque mise en avant dans "Le Fondateur" fut rachetée par Ray Kroc en 1961 ?', 'Burger King', 'McDonald''s', 'Wendy''s', 'KFC', 'B'),
('Histoire', 'Difficile', 'Sur quelle île grecque Charles Champoiseau a-t-il découvert une célèbre statue en 1863 ?', 'Rhodes', 'Samothrace', 'Délos', 'Lesbos', 'B'),
('Sport', 'Difficile', 'Dans quelle ville William Webb Ellis aurait-il inventé un nouveau sport en 1823 ?', 'Cambridge', 'Rugby', 'Oxford', 'Eton', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quel jeu vidéo d''Innersloth oppose imposteurs et coéquipiers dans un vaisseau spatial ?', 'Fall Guys', 'Among Us', 'Phasmophobia', 'Lethal Company', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'De quelle série franco-belge "High Potential" avec Kaitlin Olson est-elle un remake ?', 'Engrenages', 'HPI', 'Dix pour cent', 'Le Bureau des Légendes', 'B'),
('Histoire', 'Difficile', 'Dans quel village des Vosges Jeanne d''Arc serait-elle née vers 1412 ?', 'Vaucouleurs', 'Domrémy', 'Épinal', 'Neufchâteau', 'B'),
('Sciences', 'Difficile', 'Sur quelle mer le module Apollo 11 a-t-il aluni le 20 juillet 1969 ?', 'Mer des Tempêtes', 'Mer de la Tranquillité', 'Océan des Tempêtes', 'Mer de la Sérénité', 'B'),
('Géographie', 'Difficile', 'Quelle ville d''Australie-Occidentale de plus de 2 millions d''habitants est traversée par la Swan River ?', 'Adélaïde', 'Perth', 'Brisbane', 'Darwin', 'B'),
('Musiques', 'Difficile', 'De quel compositeur Ludwig von Köchel a-t-il publié le catalogue des œuvres en 1862 ?', 'Bach', 'Mozart', 'Beethoven', 'Haydn', 'B'),
('Animaux et plantes', 'Difficile', 'Quelle race de chien au pelage blanc, originaire de Sibérie, semble arborer un sourire naturel ?', 'Husky', 'Samoyède', 'Malamute', 'Spitz', 'B'),
('Culture générale', 'Difficile', 'Quel artiste mosaïste français réalise depuis 1996 des œuvres inspirées d''un jeu Taito de 1978 ?', 'Banksy', 'Invader', 'JR', 'C215', 'B'),
('Culture générale', 'Difficile', 'Quel sculpteur français, de son vrai nom Baldaccini, célèbre pour ses compressions, a donné son nom à une récompense ?', 'César', 'Arman', 'Niki', 'Tinguely', 'A'),
('Sport', 'Difficile', 'Dans quelle variante du billard à 22 billes Zhao Xintong est-il devenu champion du monde 2025 ?', 'Pool', 'Snooker', 'Carambole', 'Blackball', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quelle déesse a donné son nom à la jument de Link dans The Legend of Zelda ?', 'Nayru', 'Epona', 'Din', 'Farore', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'De quelle série Netflix créée par Álex Pina "My Life Is Going On" est-elle le thème ?', 'Élite', 'La Casa de Papel', 'Les Demoiselles du téléphone', 'Sky Rojo', 'B'),
('Histoire', 'Difficile', 'Quelle révolutionnaire née Marie Gouze a rédigé la "Déclaration des droits de la femme et de la citoyenne" ?', 'Manon Roland', 'Olympe de Gouges', 'Charlotte Corday', 'Théroigne de Méricourt', 'B'),
('Sciences', 'Difficile', 'Par quelle locution est également désigné le nævus mélanocytaire ?', 'Tache de rousseur', 'Grain de beauté', 'Verrue', 'Lentigo', 'B'),
('Géographie', 'Difficile', 'Quel pays asiatique est composé de Mindanao au sud, des Visayas au centre et Luçon au nord ?', 'Indonésie', 'Philippines', 'Malaisie', 'Vietnam', 'B'),
('Musiques', 'Difficile', 'Quel compositeur français du XVIIe siècle a composé le "Te Deum" utilisé à l''Eurovision ?', 'Jean-Baptiste Lully', 'Marc-Antoine Charpentier', 'François Couperin', 'Jean-Philippe Rameau', 'B'),
('Animaux et plantes', 'Difficile', 'Quel nom porte la larve des lépidoptères, ordre regroupant papillons et mites ?', 'Asticot', 'Chenille', 'Larve', 'Ver', 'B'),
('Culture générale', 'Difficile', 'Quel nom porte une phrase contenant toutes les lettres de l''alphabet comme "Portez ce vieux whisky..." ?', 'Palindrome', 'Pangramme', 'Anagramme', 'Lipogramme', 'B'),
('Littérature', 'Difficile', 'Quel écrivain né à Prague est dit "sur le rivage" dans un roman d''Haruki Murakami de 2002 ?', 'Thomas Mann', 'Franz Kafka', 'Rainer Maria Rilke', 'Hermann Hesse', 'B'),
('Sport', 'Difficile', 'Surnommé "Big Bill", dans quel sport Bill Tilden détient-il le record de 138 titres avant 1968 ?', 'Golf', 'Tennis', 'Boxe', 'Cricket', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quelle série de jeux de course développée par Nadeo voit CarlJr. être plusieurs fois champion du monde ?', 'Gran Turismo', 'Trackmania', 'Forza', 'Need for Speed', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'De quel dessin animé Hanna-Barbera de 1969 est dérivée la série "Velma" (Véra en français) ?', 'Les Jetsons', 'Scooby-Doo', 'Yogi l''ours', 'Top Cat', 'B'),
('Histoire', 'Difficile', 'Dans quel lycée de Littleton eut lieu une tuerie le 20 avril 1999, ayant inspiré un groupe de rap ?', 'Sandy Hook', 'Columbine', 'Virginia Tech', 'Parkland', 'B'),
('Sciences', 'Difficile', 'Quel adjectif qualifie les deux paires de côtes les plus basses, non rattachées au sternum ?', 'Fausses', 'Flottantes', 'Libres', 'Surnuméraires', 'B'),
('Géographie', 'Difficile', 'Quel pays a adopté l''euro en 2026 sous la présidence d''Iliana Iotova, abandonnant le lev ?', 'Roumanie', 'Bulgarie', 'Pologne', 'Hongrie', 'B'),
('Musiques', 'Difficile', 'Quelle chanteuse écossaise s''est fait connaître à Britain''s Got Talent 2009 avec "I Dreamed a Dream" ?', 'Adele', 'Susan Boyle', 'Leona Lewis', 'Florence Welch', 'B'),
('Littérature', 'Difficile', 'Quel arbre de la famille des bignoniacées donne son titre au roman de Gaël Faye, prix Renaudot 2024 ?', 'Baobab', 'Jacaranda', 'Flamboyant', 'Acacia', 'B'),
('Culture générale', 'Difficile', 'Sous quel nom de 4 lettres est généralement désigné l''alcool de riz japonais ?', 'Soju', 'Saké', 'Miso', 'Koji', 'B'),
('Culture générale', 'Difficile', 'Quel sculpteur animalier français né en 1855 est célèbre pour son "Ours blanc" au musée d''Orsay ?', 'François Pompon', 'Antoine-Louis Barye', 'Emmanuel Frémiet', 'Auguste Rodin', 'A'),
('Musiques', 'Difficile', 'Avec qui est en couple Travis Kelce, joueur NFL des Kansas City Chiefs né en 1989 ?', 'Selena Gomez', 'Taylor Swift', 'Dua Lipa', 'Ariana Grande', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'De quel pays est originaire la chaîne YouTube T-Series, première à dépasser 100 millions d''abonnés ?', 'Pakistan', 'Inde', 'Bangladesh', 'Népal', 'B'),
('Jeux Vidéos / Culture Web', 'Difficile', 'Quel télécrochet Netflix avec SDM, Oli et Théodora comme juges est adapté de "Rhythm + Flow" ?', 'The Voice', 'Nouvelle École', 'Rap Game', 'The Four', 'B'),
('Histoire', 'Difficile', 'Dans quelle ville Nicolas Fouquet a-t-il été arrêté par d''Artagnan en 1661 ?', 'Paris', 'Nantes', 'Bordeaux', 'Orléans', 'B'),
('Sciences', 'Difficile', 'Quel adjectif tiré du latin qualifie le rythme biologique dont la période est proche de 24 heures ?', 'Ultradien', 'Circadien', 'Infradien', 'Lunaire', 'B'),
('Géographie', 'Difficile', 'Quel département français métropolitain est le plus peuplé avec plus de 2,6 millions d''habitants ?', 'Paris', 'Nord', 'Bouches-du-Rhône', 'Rhône', 'B'),
('Musiques', 'Difficile', 'Quel groupe de rock mythique avait pour membres John Bonham, Jimmy Page et Robert Plant ?', 'Deep Purple', 'Led Zeppelin', 'Black Sabbath', 'The Who', 'B'),
('Animaux et plantes', 'Difficile', 'Quel adjectif de nationalité est associé au lévrier également appelé Barzoï ?', 'Anglais', 'Russe', 'Afghan', 'Irlandais', 'B'),
('Culture générale', 'Difficile', 'À quel aliment se rapporte l''adjectif "caséeux", dérivé du latin "caseus" ?', 'Lait', 'Fromage', 'Beurre', 'Crème', 'B'),
('Géographie', 'Difficile', 'Avec une superficie de 236 800 km², quel pays d''Asie du Sud-Est n''a aucun accès maritime ?', 'Cambodge', 'Laos', 'Myanmar', 'Vietnam', 'B');

-- ============================================
-- FIN DU SCRIPT
-- ============================================
SELECT 'Installation terminée ! 120 questions insérées (35 Facile, 35 Moyen, 50 Difficile).' AS Message;
