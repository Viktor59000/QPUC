# QPUC - Questions Pour Un Champion 🏆

> Quiz interactif inspiré du célèbre jeu télévisé français, avec interface premium et backend PHP/MySQL.

---

## 📋 Table des Matières

1. [Présentation](#-présentation)
2. [Fonctionnalités](#-fonctionnalités)
3. [Modes de Jeu](#-modes-de-jeu)
4. [Architecture](#-architecture)
5. [Base de Données](#-base-de-données)
6. [Installation](#-installation)
7. [Technologies](#-technologies)
8. [Design](#-design)

---

## 🎯 Présentation

**QPUC** reproduit l'ambiance du jeu télévisé avec :
- Interface **glassmorphism** premium
- **100 questions** organisées par thème et difficulté
- **3 modes de jeu** fidèles à l'émission
- Backend **PHP/MySQL** dynamique
- Mélange aléatoire des réponses

---

## ✨ Fonctionnalités

| Fonctionnalité | Description |
|----------------|-------------|
| **Auth Guard** | Vue Guest/Player avec localStorage |
| **3 Modes** | 9PG, 4ALS, Face-à-Face |
| **API REST** | Chargement dynamique depuis MySQL |
| **Thèmes affichés** | Badge coloré par catégorie |
| **Difficulté** | 🟢 Facile, 🟠 Moyen, 🔴 Difficile |
| **Timer** | Circulaire 20s (9PG/FAF) ou global 40s (4ALS) |
| **Bot Adversaire** | IA en Face-à-Face (55% précision) |
| **Mélange A/B/C/D** | Réponses toujours aléatoires |
| **Pondération 1-2-3** | Points cycliques en 9PG |
| **Points dégressifs** | 4→3→2→1 en FAF selon le temps |
| **Feedback visuel** | Infusion couleur, shake, highlight |

---

## 🎮 Modes de Jeu

| Mode | Objectif | Timer | Mécanique |
|------|----------|-------|-----------|
| **9 Points Gagnants** | Atteindre 9 pts | 20s/question | 1-2-3 pts cycliques |
| **4 à la Suite** | 4 bonnes consécutives | 40s global | Reset combo si erreur |
| **Face-à-Face** | 15 pts avant le bot | 20s/question | Points dégressifs + adversaire IA |

---

## 🏗 Architecture

```
QPUC/
├── api/
│   ├── get_questions.php    # API REST → JSON
│   ├── login.php            # Authentification
│   ├── register.php         # Inscription
│   ├── check_session.php    # Vérification session
│   └── logout.php           # Déconnexion
├── css/
│   ├── style.css            # Styles principaux
│   ├── background.css       # Fond animé CSS
│   └── login.css            # Formulaire auth
├── js/
│   ├── quiz.js              # Moteur de jeu
│   ├── player.js            # Lecteur musique
│   └── cursor.js            # Curseur custom
├── sql/
│   └── setup.sql            # ⭐ Script complet (BDD + 100 questions)
├── db.php                   # Connexion PDO MySQL
├── index.php                # Accueil (Guest/Player)
├── login.php                # Authentification
├── quiz.php                 # Plateau de jeu
├── resultat.php             # Écran résultats
└── admin.php                # Panel admin
```

### Flux de Données

```
MySQL (questions) → API PHP → fetch() JS → Affichage dynamique
                            ↓
                    sessionStorage → resultat.php
```

---

## 🗃 Base de Données

### Structure de la table `questions`

| Colonne | Type | Description |
|---------|------|-------------|
| `id` | INT | Clé primaire |
| `theme` | VARCHAR(50) | Catégorie (Sport, Cinéma...) |
| `difficulte` | VARCHAR(20) | Facile, Moyen, Difficile |
| `question` | TEXT | L'énoncé |
| `indice` | TEXT | Indice optionnel |
| `reponse_A` à `D` | VARCHAR(255) | Les 4 options |
| `bonne_reponse` | CHAR(1) | A, B, C ou D |

### Répartition des 100 questions

- **25 Faciles** : Culture générale accessible
- **25 Moyennes** : Niveau standard
- **50 Difficiles** : Questions d'expertise

### Import

```sql
-- Dans phpMyAdmin, importer le fichier :
sql/setup.sql
```

Ce script crée automatiquement :
- La base de données `quiz_db`
- La table `users`
- La table `questions` avec les **100 questions**

---

## 🚀 Installation

### Prérequis
- **WAMP/XAMPP** (Apache + MySQL + PHP 7.4+)
- Navigateur moderne

### Étapes

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   ```

2. **Importer la base de données**
   - Ouvrir phpMyAdmin
   - Aller dans l'onglet **Importer**
   - Sélectionner `sql/setup.sql`
   - Cliquer sur **Exécuter**
   
   > ✅ Cela crée automatiquement la BDD, les tables et insère les 100 questions !

3. **Configurer `db.php`** (si nécessaire)
   ```php
   $host = 'localhost';
   $dbname = 'quiz_db';
   $username = 'root';
   $password = '';
   ```

4. **Lancer le serveur**
   ```bash
   php -S localhost:8000
   ```

5. **Ouvrir** : `http://localhost:8000/index.php`

---

## 🛠 Technologies

### Core
| Tech | Usage |
|------|-------|
| HTML5/CSS3 | Structure, animations |
| JavaScript ES6+ | Logique quiz, fetch API |
| PHP 7.4+ | Backend, API REST |
| MySQL | Stockage questions |

### Frameworks
| Nom | Usage |
|-----|-------|
| Bootstrap 5.3 | Grille, composants |
| FontAwesome 6 | Icônes |
| Google Fonts | Syne, Inter, Space Grotesk |

### APIs Navigateur
- `localStorage` : Auth, musique
- `sessionStorage` : Résultats partie
- `fetch()` : Appels API

---

## 🎨 Design

### Palette

| Variable | Hex | Usage |
|----------|-----|-------|
| `--color-midnight` | `#0a0e27` | Fond |
| `--color-gold` | `#fbbf24` | Accents, score |
| `--color-amber` | `#f15a22` | Mode 4ALS |

### Couleurs Thèmes (badges)

| Thème | Couleur |
|-------|---------|
| Sport | 🟢 Emerald |
| Cinéma | 🟠 Amber |
| Histoire | 🟣 Violet |
| Musique | 🩷 Pink |
| Géographie | 🔵 Blue |

### Couleurs Difficulté

| Niveau | Badge |
|--------|-------|
| Facile | 🟢 Vert |
| Moyen | 🟠 Orange |
| Difficile | 🔴 Rouge |

---

## 📊 Statistiques

| Métrique | Valeur |
|----------|--------|
| Fichiers PHP | 6 |
| Fichiers JS | 6 |
| Fichiers CSS | 3 |
| Questions | 100 |
| Thèmes | 25+ |
| Lignes CSS | ~900 |
| Lignes JS | ~500 |

---

## 📄 Licence

Projet pédagogique - Semestre 4 Cartailler

---

*Développé avec ❤️ pour la culture générale*

**Dernière mise à jour** : 30 Janvier 2026
