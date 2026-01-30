<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QPUC - Le Plateau</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/background.css">
</head>
<body class="d-flex flex-column min-vh-100">
    <!-- Simple CSS Background -->
    <div class="animated-bg" id="animatedBg"></div>

    <div class="container-fluid main-content d-flex flex-column justify-content-center py-4 flex-grow-1">
        
        <!-- Top Bar - Split Screen for FAF -->
        <div class="container mb-4">
            <div class="row align-items-center">
                <!-- Left: Player Score -->
                <div class="col-4 text-start">
                    <div class="d-flex align-items-center gap-2">
                        <a href="index.php" class="btn btn-sm btn-outline-light rounded-pill px-3 me-2">
                            <i class="fas fa-arrow-left"></i>
                        </a>
                        <div class="badge bg-success rounded-pill px-3 py-2" id="scoreDisplay">
                            <i class="fas fa-star me-1"></i> 0/9 pts
                        </div>
                        <i id="playerHandIcon" class="fas fa-hand-paper text-success d-none fa-lg ms-2"></i>
                    </div>
                </div>

                <!-- Center: Game Mode Title -->
                <div class="col-4 text-center">
                    <h4 class="text-gold m-0" id="gameModeTitle">9 POINTS GAGNANTS</h4>
                    <div id="fafTimer" class="mt-1 text-white-50 fw-bold" style="font-family:'Space Grotesk'; font-size:1em;"></div>
                </div>

                <!-- Right: Bot Score (FAF only) -->
                <div class="col-4 text-end">
                    <div class="d-flex align-items-center justify-content-end gap-2">
                        <i id="botHandIcon" class="fas fa-hand-paper text-danger d-none fa-lg me-2"></i>
                        <div class="badge bg-danger rounded-pill px-3 py-2 d-none" id="botScoreDisplay">
                            <i class="fas fa-robot me-1"></i> BOT: 0
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bot Status Alert (FAF only) -->
        <div id="botStatus" class="container mb-3 d-none">
            <div class="alert alert-warning text-center py-2" role="alert">
                <i class="fas fa-robot me-2"></i> <span id="botStatusText">En attente...</span>
            </div>
        </div>
        
        <!-- Hand Indicator (FAF only) -->
        <div id="handIndicator" class="hand-indicator player-turn d-none">
            <i class="fas fa-hand-point-right me-2"></i> <span id="handIndicatorText">À VOUS LA MAIN</span>
        </div>

        <!-- Main Game Area -->
        <div class="container">
            <div class="row align-items-center">
                
                <!-- Left: Gauge (9PG) -->
                <div class="col-1 d-flex justify-content-center">
                    <div class="gauge-container" id="gaugeContainer">
                        <div class="gauge-fill" id="gaugeFill"></div>
                        <div class="gauge-markers">
                            <span class="marker" style="bottom: 100%">9</span>
                            <span class="marker" style="bottom: 66%">6</span>
                            <span class="marker" style="bottom: 33%">3</span>
                        </div>
                    </div>
                </div>

                <!-- Center: Question & Answers -->
                <div class="col-10">
                    <div class="glass-panel p-5 mb-4 text-center position-relative animate-fade-in">
                        <!-- Badge Question Number -->
                        <span class="badge bg-primary position-absolute top-0 start-50 translate-middle rounded-pill px-4">
                            QUESTION <span id="qNum">1</span>
                        </span>
                        
                        <!-- Theme Badge -->
                        <div class="mb-3 mt-2">
                            <span id="questionTheme" class="badge bg-light text-dark text-uppercase px-3 py-1" style="font-size: 0.8rem; letter-spacing: 2px;">
                                THÈME
                            </span>
                            <span id="questionDifficulty" class="badge ms-2 px-2 py-1" style="font-size: 0.7rem;">
                                NIVEAU
                            </span>
                        </div>

                        <!-- Image Container (Hidden by default) -->
                        <div id="imageContainer" class="mb-4 d-none">
                            <img src="" id="questionImage" class="img-fluid rounded shadow-lg" 
                                 style="max-height: 250px; object-fit: contain; border: 3px solid rgba(255,255,255,0.2);">
                        </div>

                        <!-- Question Text -->
                        <h2 class="mb-0" id="questionText">Chargement des questions...</h2>
                    </div>

                    <!-- Answer Grid -->
                    <div class="answer-grid animate-fade-in" style="animation-delay: 0.1s;">
                        <button class="btn btn-answer" onclick="handleAnswer(this, 0)">
                            <span class="badge bg-light text-dark rounded-circle me-3">A</span>
                            <span class="answer-text">Réponse A</span>
                        </button>
                        <button class="btn btn-answer" onclick="handleAnswer(this, 1)">
                            <span class="badge bg-light text-dark rounded-circle me-3">B</span>
                            <span class="answer-text">Réponse B</span>
                        </button>
                        <button class="btn btn-answer" onclick="handleAnswer(this, 2)">
                            <span class="badge bg-light text-dark rounded-circle me-3">C</span>
                            <span class="answer-text">Réponse C</span>
                        </button>
                        <button class="btn btn-answer" onclick="handleAnswer(this, 3)">
                            <span class="badge bg-light text-dark rounded-circle me-3">D</span>
                            <span class="answer-text">Réponse D</span>
                        </button>
                    </div>
                </div>

                <!-- Right: Timer -->
                <div class="col-1 d-flex justify-content-center">
                    <div class="timer-container">
                        <svg class="timer-svg" width="100" height="100" viewBox="0 0 100 100">
                            <circle class="timer-circle-bg" cx="50" cy="50" r="45"></circle>
                            <circle class="timer-circle-fg" id="timerCircle" cx="50" cy="50" r="45" 
                                    style="stroke-dasharray: 283; stroke-dashoffset: 0;"></circle>
                        </svg>
                        <div class="timer-text" id="timerText">20</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Music Player Widget (Fixed Position) -->
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
    <footer class="glass-footer py-2 text-center">
        <small class="text-white-50">&copy; 2026 QPUC Digital</small>
    </footer>

    <script src="js/cursor.js"></script>
    <script src="js/player.js"></script>
    <script src="js/quiz.js"></script>
</body>
</html>
