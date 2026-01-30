<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QPUC - Résultats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/background.css">
</head>
<body>
    <!-- Simple CSS Background -->
    <div class="animated-bg"></div>

    <div class="container main-content d-flex flex-column justify-content-center py-5">
        
        <div class="glass-panel p-5 mx-auto" style="max-width: 800px; width: 100%;">
            
            <!-- Header Résultat -->
            <div class="text-center mb-5">
                <div id="resultIcon" class="mb-3">
                    <i class="fas fa-trophy fa-4x text-gold"></i>
                </div>
                <h1 id="resultTitle" class="text-gold display-4 mb-3">FIN DE LA PARTIE</h1>
                <div id="scoreValue" class="display-1 fw-bold text-white mb-2">--</div>
                <p id="resultSubtitle" class="lead text-white-50">Chargement...</p>
                <div class="progress mt-3" style="height: 10px; background: rgba(255,255,255,0.1);">
                    <div id="progressBarResult" class="progress-bar bg-gold" style="width: 0%"></div>
                </div>
            </div>

            <!-- Débrief -->
            <h3 class="text-white mb-4 border-bottom border-secondary pb-2">
                <i class="fas fa-clipboard-list me-2"></i> Le Débrief
            </h3>

            <div id="debriefList" class="list-group mb-5">
                <!-- Dynamically filled -->
            </div>

            <!-- Actions -->
            <div class="d-flex justify-content-center gap-4 flex-wrap">
                <a href="index.php" class="btn btn-glass btn-lg px-5">
                    <i class="fas fa-home me-2"></i> Accueil
                </a>
                <a id="replayBtn" href="quiz.php" class="btn btn-primary-glass btn-lg px-5">
                    <i class="fas fa-redo me-2"></i> Rejouer
                </a>
            </div>
        </div>
    </div>

    <!-- Music Player Widget -->
    <div class="player-widget glass-panel p-3">
        <div class="d-flex align-items-center">
            <img id="trackCover" src="https://raw.githubusercontent.com/muhammederdem/mini-player/master/img/1.jpg" alt="Cover" class="rounded-circle me-3" style="width: 50px; height: 50px; object-fit: cover;">
            <div class="flex-grow-1 overflow-hidden">
                <h6 id="trackTitle" class="mb-0 text-truncate text-white">Titre</h6>
                <small id="trackArtist" class="text-white-50">Artiste</small>
            </div>
            <div class="d-flex align-items-center ms-2">
                <button id="prevBtn" class="btn btn-link text-white p-2"><i class="fas fa-backward"></i></button>
                <button id="playBtn" class="btn btn-link text-gold p-2"><i class="fas fa-play"></i></button>
                <button id="nextBtn" class="btn btn-link text-white p-2"><i class="fas fa-forward"></i></button>
            </div>
        </div>
    </div>

    <script src="js/cursor.js"></script>
    <script src="js/player.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Récupérer les résultats depuis sessionStorage
            const resultsJson = sessionStorage.getItem('qpuc_results');
            const urlParams = new URLSearchParams(window.location.search);
            const mode = urlParams.get('mode') || '9pg';
            const isWin = urlParams.get('win') === '1';
            
            // Éléments DOM
            const resultIcon = document.getElementById('resultIcon');
            const resultTitle = document.getElementById('resultTitle');
            const scoreValue = document.getElementById('scoreValue');
            const resultSubtitle = document.getElementById('resultSubtitle');
            const progressBar = document.getElementById('progressBarResult');
            const debriefList = document.getElementById('debriefList');
            const replayBtn = document.getElementById('replayBtn');
            
            // Mode titre
            const modeTitles = { '9pg': '9 Points Gagnants', '4als': '4 à la Suite', 'faf': 'Face-à-Face' };
            
            // Bouton rejouer avec le même mode
            replayBtn.href = `quiz.php?mode=${mode}`;
            
            if (resultsJson) {
                const results = JSON.parse(resultsJson);
                const answers = results.answers || [];
                const correctCount = answers.filter(a => a.isCorrect).length;
                const totalCount = answers.length;
                const percentage = totalCount > 0 ? Math.round((correctCount / totalCount) * 100) : 0;
                
                // Affichage selon victoire/défaite
                if (isWin) {
                    resultIcon.innerHTML = '<i class="fas fa-crown fa-4x text-gold"></i>';
                    resultTitle.textContent = 'VICTOIRE !';
                    resultTitle.classList.add('text-gold');
                } else {
                    resultIcon.innerHTML = '<i class="fas fa-flag-checkered fa-4x text-white"></i>';
                    resultTitle.textContent = 'PARTIE TERMINÉE';
                }
                
                // Score
                scoreValue.textContent = `${results.playerScore || 0} pts`;
                resultSubtitle.textContent = `${correctCount}/${totalCount} bonnes réponses - ${modeTitles[mode]}`;
                progressBar.style.width = `${percentage}%`;
                
                // Mention
                let mention = '';
                if (percentage >= 90) mention = '🏆 Excellent !';
                else if (percentage >= 70) mention = '👍 Très bien !';
                else if (percentage >= 50) mention = '😊 Bien joué';
                else mention = '💪 Peut mieux faire';
                resultSubtitle.textContent += ` - ${mention}`;
                
                // Débrief - Affichage des questions
                if (answers.length === 0) {
                    debriefList.innerHTML = '<p class="text-white-50 text-center">Aucune donnée de partie disponible.</p>';
                } else {
                    answers.forEach((answer, index) => {
                        const item = document.createElement('div');
                        item.className = 'list-group-item bg-transparent border-secondary text-white p-3 mb-2';
                        item.style.borderLeft = answer.isCorrect ? '4px solid #10b981' : '4px solid #ef4444';
                        
                        const statusBadge = answer.isCorrect 
                            ? '<span class="badge bg-success me-2">✓</span>'
                            : '<span class="badge bg-danger me-2">✗</span>';
                        
                        const pointsBadge = `<span class="badge bg-dark ms-2">${answer.points || 1} pt${(answer.points || 1) > 1 ? 's' : ''}</span>`;
                        
                        const answerHtml = answer.isCorrect
                            ? `<small class="text-success"><i class="fas fa-check me-1"></i> ${answer.userAnswer}</small>`
                            : `<div class="d-flex gap-3 flex-wrap">
                                <small class="text-danger"><i class="fas fa-times me-1"></i> ${answer.userAnswer}</small>
                                <small class="text-success"><i class="fas fa-check me-1"></i> ${answer.correctAnswer}</small>
                               </div>`;
                        
                        item.innerHTML = `
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div class="d-flex align-items-center">
                                    ${statusBadge}
                                    <span class="text-white-50">Q${index + 1}</span>
                                    ${pointsBadge}
                                </div>
                            </div>
                            <h6 class="mb-2 text-white">${answer.question}</h6>
                            ${answerHtml}
                        `;
                        
                        debriefList.appendChild(item);
                    });
                }
                
            } else {
                // Pas de données
                scoreValue.textContent = '--';
                resultSubtitle.textContent = 'Aucun résultat trouvé';
                debriefList.innerHTML = '<p class="text-white-50 text-center">Aucune donnée de partie disponible.</p>';
            }
        });
    </script>
</body>
</html>
