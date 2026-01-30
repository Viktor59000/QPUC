<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QPUC - L'Arène du Savoir</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/background.css">
</head>
<body class="d-flex flex-column min-vh-100">
    <div class="animated-bg"></div>

    <!-- Navigation Bar (Player only) -->
    <nav class="navbar fixed-top p-3" id="playerNav" style="display: none;">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <!-- Profile Widget -->
            <div id="profile-widget" class="pointer" data-bs-toggle="modal" data-bs-target="#statsModal">
                <div class="glass-badge d-flex align-items-center gap-3 px-4 py-2">
                    <img id="userAvatar" src="https://api.dicebear.com/7.x/avataaars/svg?seed=Champion" 
                         class="rounded-circle border border-2 border-white" width="40" alt="Avatar">
                    <div class="text-start">
                        <div class="text-gold fw-bold" id="usernameDisplay">Champion</div>
                        <small class="text-white-50" style="font-size: 0.7em;">VOIR STATISTIQUES</small>
                    </div>
                </div>
            </div>

            <!-- Logout Button -->
            <button id="logoutBtn" class="glass-btn-icon" title="Déconnexion">
                <i class="fas fa-power-off text-danger"></i>
            </button>
        </div>
    </nav>

    <!-- GUEST VIEW: Page d'accueil épurée -->
    <div id="guest-view" class="vh-100 d-flex flex-column justify-content-center align-items-center text-center px-4">
        <div class="animate-fade-in">
            <!-- Logo animé -->
            <div class="guest-icon mb-4">
                <i class="fas fa-crown fa-5x text-gold drop-shadow"></i>
            </div>
            
            <h1 class="display-2 fw-bold text-white mb-2" style="font-family: 'Syne'; text-shadow: 0 0 30px rgba(251, 191, 36, 0.3);">
                L'ARÈNE DU SAVOIR
            </h1>
            <p class="lead text-white-50 mb-5">La culture générale n'attend que vous.</p>
            
            <a href="login.php" class="btn-gold-lg pulsing text-decoration-none">
                ENTRER DANS LE JEU <i class="fas fa-chevron-right ms-2"></i>
            </a>
            
            <p class="text-white-50 mt-4 mb-0"><small>Connexion requise pour sauvegarder vos scores</small></p>
        </div>
    </div>

    <!-- PLAYER VIEW: Sélection du mode -->
    <div id="player-view" class="container d-none" style="padding-top: 100px;">
        <div class="text-center mb-5 animate-fade-in">
            <h2 class="text-white display-5 fw-bold">Choisissez votre épreuve</h2>
            <p class="text-white-50">Chaque mode a ses propres règles. À vous de jouer !</p>
        </div>
        
        <div class="row justify-content-center g-4">
            <!-- Mode 9PG -->
            <div class="col-lg-4 col-md-6">
                <a href="quiz.php?mode=9pg" class="text-decoration-none">
                    <div class="game-mode-card">
                        <div class="card-icon">
                            <i class="fas fa-cubes"></i>
                        </div>
                        <h3>9 Points Gagnants</h3>
                        <p class="text-white-50 mb-3">Questions à 1, 2 ou 3 points selon la difficulté. Atteignez 9 pour vous qualifier.</p>
                        <div class="mode-details">
                            <span class="badge bg-success me-1">1pt = Facile</span>
                            <span class="badge bg-warning text-dark me-1">2pts = Moyen</span>
                            <span class="badge bg-danger">3pts = Difficile</span>
                        </div>
                        <div class="mode-badge mt-3">
                            <span class="badge bg-gold text-dark">QUALIFICATION</span>
                        </div>
                    </div>
                </a>
            </div>
            
            <!-- Mode 4ALS -->
            <div class="col-lg-4 col-md-6">
                <a href="quiz.php?mode=4als" class="text-decoration-none">
                    <div class="game-mode-card featured">
                        <div class="card-icon gold">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h3>4 à la Suite</h3>
                        <p class="text-white-50 mb-3">40 secondes chrono. Enchaînez 4 bonnes réponses sans erreur. Le combo reset si vous vous trompez !</p>
                        <div class="mode-details">
                            <div class="combo-preview d-flex gap-2 justify-content-center">
                                <div class="combo-dot-mini"></div>
                                <div class="combo-dot-mini"></div>
                                <div class="combo-dot-mini"></div>
                                <div class="combo-dot-mini"></div>
                            </div>
                        </div>
                        <div class="mode-badge mt-3">
                            <span class="badge bg-warning text-dark">TENSION</span>
                        </div>
                    </div>
                </a>
            </div>
            
            <!-- Mode FAF -->
            <div class="col-lg-4 col-md-6">
                <a href="quiz.php?mode=faf" class="text-decoration-none">
                    <div class="game-mode-card">
                        <div class="card-icon white">
                            <i class="fas fa-user-friends"></i>
                        </div>
                        <h3>Face-à-Face</h3>
                        <p class="text-white-50 mb-3">Duel contre l'IA. La main change toutes les 5 secondes. Points dégressifs : 4→3→2→1.</p>
                        <div class="mode-details">
                            <span class="badge bg-success me-1">Votre main</span>
                            <span class="badge bg-danger">Main adverse</span>
                        </div>
                        <div class="mode-badge mt-3">
                            <span class="badge bg-danger">FINALE</span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Stats Modal -->
    <div class="modal fade" id="statsModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel border-0">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-gold"><i class="fas fa-chart-bar me-2"></i>Vos Performances</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-white">
                    <div class="d-flex justify-content-around text-center mb-4">
                        <div>
                            <h3 class="text-gold mb-0" id="statGames">0</h3>
                            <small class="text-white-50">Parties</small>
                        </div>
                        <div>
                            <h3 class="text-success mb-0" id="statWins">0</h3>
                            <small class="text-white-50">Victoires</small>
                        </div>
                        <div>
                            <h3 class="text-info mb-0" id="statTheme">-</h3>
                            <small class="text-white-50">Thème Favori</small>
                        </div>
                    </div>
                    <div class="text-center">
                        <div class="progress" style="height: 10px; background: rgba(255,255,255,0.1);">
                            <div class="progress-bar bg-gold" id="winRateBar" style="width: 0%"></div>
                        </div>
                        <small class="text-white-50 mt-2 d-block">Taux de victoire : <span id="winRate">0</span>%</small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Music Player Widget -->
    <div class="player-widget glass-panel p-3">
        <div class="d-flex align-items-center">
            <img id="trackCover" src="https://raw.githubusercontent.com/muhammederdem/mini-player/master/img/1.jpg" alt="Cover" class="rounded-circle me-3" style="width: 50px; height: 50px; object-fit: cover;">
            <div class="flex-grow-1 overflow-hidden">
                <h6 id="trackTitle" class="mb-0 text-truncate text-white">Ambiance Quiz</h6>
                <small id="trackArtist" class="text-white-50">QPUC</small>
            </div>
            <div class="d-flex align-items-center ms-2">
                <button id="prevBtn" class="btn btn-link text-white p-2"><i class="fas fa-backward"></i></button>
                <button id="playBtn" class="btn btn-link text-gold p-2"><i class="fas fa-play"></i></button>
                <button id="nextBtn" class="btn btn-link text-white p-2"><i class="fas fa-forward"></i></button>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="glass-footer mt-auto py-3 text-center">
        <div class="container">
            <small class="text-white-50">
                &copy; 2026 QPUC Digital. Projet Pédagogique.
                <a href="#" class="text-white text-decoration-none ms-3">Mentions Légales</a>
            </small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/cursor.js"></script>
    <script src="js/player.js"></script>
    
    <script>
        // Auth Guard
        document.addEventListener('DOMContentLoaded', () => {
            const isLoggedIn = localStorage.getItem('qpuc_logged_in') === 'true';
            const username = localStorage.getItem('qpuc_player_name') || 'Champion';
            
            const guestView = document.getElementById('guest-view');
            const playerView = document.getElementById('player-view');
            const playerNav = document.getElementById('playerNav');
            const usernameDisplay = document.getElementById('usernameDisplay');
            const userAvatar = document.getElementById('userAvatar');
            
            if (isLoggedIn) {
                guestView.classList.add('d-none');
                playerView.classList.remove('d-none');
                playerNav.style.display = 'flex';
                usernameDisplay.textContent = username;
                userAvatar.src = `https://api.dicebear.com/7.x/avataaars/svg?seed=${username}`;
                
                // Load stats
                loadUserStats();
            }
            
            // Logout
            document.getElementById('logoutBtn')?.addEventListener('click', () => {
                localStorage.removeItem('qpuc_logged_in');
                localStorage.removeItem('qpuc_player_name');
                window.location.reload();
            });
        });
        
        function loadUserStats() {
            // Simulé pour l'instant (à connecter à l'API plus tard)
            const games = parseInt(localStorage.getItem('qpuc_games') || '0');
            const wins = parseInt(localStorage.getItem('qpuc_wins') || '0');
            
            document.getElementById('statGames').textContent = games;
            document.getElementById('statWins').textContent = wins;
            
            const winRate = games > 0 ? Math.round((wins / games) * 100) : 0;
            document.getElementById('winRate').textContent = winRate;
            document.getElementById('winRateBar').style.width = winRate + '%';
        }
    </script>
</body>
</html>
