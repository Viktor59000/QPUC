/**
 * QPUC - Base de Données des Questions
 * Questions extraites du PDF avec thèmes et réponses crédibles
 */

const questionsData = [
    {
        id: 1,
        theme: "Littérature",
        question: "Après la Bible, quel livre publié en 1943 par Saint-Exupéry est le plus traduit au monde ?",
        options: ["Le Petit Prince", "L'Étranger", "Vol de Nuit", "Terre des Hommes"],
        correct: 0 // Le Petit Prince
    },
    {
        id: 2,
        theme: "Sport",
        question: "Combien de joueurs sont présents sur le terrain au début d'un match de football ?",
        options: ["11", "22", "15", "24"],
        correct: 1 // 22 (11 par équipe)
    },
    {
        id: 3,
        theme: "Internet",
        question: "Quelle anagramme de son prénom le youtubeur Maxime Chabroud a-t-il utilisé comme pseudo ?",
        options: ["Amixem", "Maxime", "Mixame", "Eximma"],
        correct: 0 // Amixem
    },
    {
        id: 4,
        theme: "Nature",
        question: "Quelle fleur a laissé son nom à la révolution portugaise du 25 avril 1974 ?",
        options: ["La Rose", "L'Oeillet", "Le Coquelicot", "La Tulipe"],
        correct: 1 // Oeillets
    },
    {
        id: 5,
        theme: "Astronomie",
        question: "Quelle planète est la plus proche du Soleil ?",
        options: ["Vénus", "Mercure", "Mars", "La Terre"],
        correct: 1 // Mercure
    },
    {
        id: 6,
        theme: "Musique",
        question: "Quelle chanteuse islandaise fut la meneuse du groupe The Sugarcubes ?",
        options: ["Björk", "Enya", "Aurora", "Sia"],
        correct: 0 // Bjork
    },
    {
        id: 7,
        theme: "Animaux",
        question: "Quel oiseau disparu de l'île Maurice porte un nom constitué d'une syllabe redoublée ?",
        options: ["Le Dodo", "Le Kiki", "Le Tantan", "Le Loulou"],
        correct: 0 // Dodo
    },
    {
        id: 8,
        theme: "Politique",
        question: "Quel surnom donne-t-on au représentant d'un chef d'État lors des G7 ou G20 ?",
        options: ["Le Guide", "Le Sherpa", "L'Éclaireur", "Le Sage"],
        correct: 1 // Sherpa
    },
    {
        id: 9,
        theme: "Cinéma",
        question: "À quel réalisateur japonais doit-on les films 'Rashomon' et 'Les Sept Samouraïs' ?",
        options: ["Hayao Miyazaki", "Akira Kurosawa", "Takeshi Kitano", "Yasujirō Ozu"],
        correct: 1 // Akira Kurosawa
    },
    {
        id: 10,
        theme: "Géographie",
        question: "Avec quel pays le Kazakhstan partage-t-il la souveraineté sur la Mer d'Aral ?",
        options: ["La Russie", "L'Ouzbékistan", "Le Turkménistan", "L'Iran"],
        correct: 1 // Ouzbékistan
    },
    {
        id: 11,
        theme: "Technologie",
        question: "Quelle pâtisserie donne son nom à un petit fichier traceur sur le web ?",
        options: ["Le Cookie", "Le Brownie", "Le Muffin", "Le Donut"],
        correct: 0 // Cookie
    },
    {
        id: 12,
        theme: "Musique",
        question: "À quel groupe italien doit-on le titre 'I wanna be your slave' après l'Eurovision 2021 ?",
        options: ["Måneskin", "Il Volo", "Mahmood", "Zitti E Buoni"],
        correct: 0 // Måneskin
    },
    {
        id: 13,
        theme: "Histoire",
        question: "Quel Président US a présenté son programme des 'Quatorze Points' en 1918 ?",
        options: ["F.D. Roosevelt", "Woodrow Wilson", "J.F. Kennedy", "Abraham Lincoln"],
        correct: 1 // Woodrow Wilson
    },
    {
        id: 14,
        theme: "Jeu Vidéo",
        question: "Que signifie le sigle FPS dans le domaine du jeu vidéo ?",
        options: ["First Person Shooter", "Frame Per Second", "Free Play System", "Final Player Score"],
        correct: 0 // First Person Shooter
    },
    {
        id: 15,
        theme: "Géographie",
        question: "Quelle montagne est le deuxième plus haut sommet du monde (8611m) ?",
        options: ["L'Everest", "Le K2", "Le Mont Blanc", "Le Kangchenjunga"],
        correct: 1 // K2
    },
    {
        id: 16,
        theme: "Cuisine",
        question: "De quelle forme sont les samoussas dans la cuisine indienne ?",
        options: ["Carrée", "Triangulaire", "Ronde", "Ovale"],
        correct: 1 // Triangulaire
    },
    {
        id: 17,
        theme: "Musique",
        question: "Quelle marque de bière fictive des Simpson existe réellement depuis 2006 ?",
        options: ["Duff", "Pawtucket", "Buzz Cola", "Flaming Moe"],
        correct: 0 // Duff
    },
    {
        id: 18,
        theme: "Histoire",
        question: "Dans quelle ville a eu lieu l'assassinat de l'archiduc François-Ferdinand en 1914 ?",
        options: ["Belgrade", "Sarajevo", "Vienne", "Budapest"],
        correct: 1 // Sarajevo
    },
    {
        id: 19,
        theme: "Sport",
        question: "Quel terme de bowling désigne le fait de faire tomber les 10 quilles en deux coups ?",
        options: ["Strike", "Spare", "Split", "Turkey"],
        correct: 1 // Spare
    },
    {
        id: 20,
        theme: "Cinéma",
        question: "Quel humoriste a réalisé le film à succès 'Un p'tit truc en plus' en 2024 ?",
        options: ["Philippe Lacheau", "Artus", "Ahmed Sylla", "Dany Boon"],
        correct: 1 // Artus
    }
];
