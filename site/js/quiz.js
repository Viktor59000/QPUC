/**
 * QPUC - Moteur de Quiz ULTIME v2
 * Avec support images et Face-à-Face amélioré
 *
 * Mécaniques:
 * - 9PG: Questions par difficulté (Facile=1pt, Moyen=2pts, Difficile=3pts)
 * - 4ALS: Timer global 40s + combo dots
 * - FAF: Main aléatoire, switch aux paliers 5s, bot IA, points par zone
 */

/* =========================================
   CONFIGURATION & VARIABLES
   ========================================= */
const urlParams = new URLSearchParams(window.location.search);
const gameMode = urlParams.get('mode') || '9pg';

// Pools de questions par difficulté
let questionsPool = {
    Facile: [],
    Moyen: [],
    Difficile: []
};

// État du jeu
let currentQuestion = null;
let currentCorrectIndex = 0;
let playerScore = 0;
let botScore = 0;
let combo = 0;
let qIndexGlobal = 0;
let isGameLocked = false;
let gameHistory = []; // Historique pour le débrief

// Timers
let mainTimer;
let globalTimer;
let botThinkTimeout;
let timeLeft = 20;
let globalTimeLeft = 40;

// Face-à-Face specifics
let isPlayerHand = true;
let currentZone = 4; // 4, 3, 2, 1 pts
const FAF_GOAL = 21; // Points pour gagner

// Éléments DOM
const domQuestion = document.getElementById('questionText');
const domQNum = document.getElementById('qNum');
const domTheme = document.getElementById('questionTheme');
const domDifficulty = document.getElementById('questionDifficulty');
const domScoreDisplay = document.getElementById('scoreDisplay');
const domBotScoreDisplay = document.getElementById('botScoreDisplay');
const domTimerText = document.getElementById('timerText');
const domTimerCircle = document.getElementById('timerCircle');
const domGameTitle = document.getElementById('gameModeTitle');
const domGaugeFill = document.getElementById('gaugeFill');
const domGaugeContainer = document.getElementById('gaugeContainer');
const domBg = document.getElementById('animatedBg');
const domAnswers = document.querySelectorAll('.btn-answer');
const domImageContainer = document.getElementById('imageContainer');
const domQuestionImage = document.getElementById('questionImage');
const domPlayerHandIcon = document.getElementById('playerHandIcon');
const domBotHandIcon = document.getElementById('botHandIcon');
const domHandIndicator = document.getElementById('handIndicator');
const domHandIndicatorText = document.getElementById('handIndicatorText');
const domBotStatus = document.getElementById('botStatus');
const domBotStatusText = document.getElementById('botStatusText');
const domFafTimer = document.getElementById('fafTimer');

/* =========================================
   INITIALISATION
   ========================================= */
document.addEventListener('DOMContentLoaded', () => {
    setupModeUI();
    fetchQuestions();
});

function setupModeUI() {
    // Masquer éléments spécifiques selon le mode
    if (gameMode === '9pg') {
        if (domGameTitle) domGameTitle.innerHTML = '9 POINTS GAGNANTS';
        if (domGaugeContainer) domGaugeContainer.style.display = 'block';
        if (domBotScoreDisplay) domBotScoreDisplay.classList.add('d-none');

    } else if (gameMode === '4als') {
        if (domGameTitle) {
            domGameTitle.innerHTML = `
                <div>4 À LA SUITE</div>
                <div class="combo-visuals d-flex gap-2 mt-2 justify-content-center">
                    <div class="combo-dot" id="comboDot1"></div>
                    <div class="combo-dot" id="comboDot2"></div>
                    <div class="combo-dot" id="comboDot3"></div>
                    <div class="combo-dot" id="comboDot4"></div>
                </div>
            `;
            domGameTitle.style.color = '#f15a22';
        }
        if (domGaugeContainer) domGaugeContainer.style.display = 'none';
        if (domBotScoreDisplay) domBotScoreDisplay.classList.add('d-none');
        // CACHER LE TIMER CIRCULAIRE (doublon)
        const circularTimer = document.querySelector('.timer-container');
        if (circularTimer) circularTimer.style.display = 'none';

    } else if (gameMode === 'faf') {
        if (domGameTitle) {
            domGameTitle.innerHTML = 'FACE À FACE';
            domGameTitle.style.color = '#ef4444';
        }
        if (domGaugeContainer) domGaugeContainer.style.display = 'none';
        if (domBotScoreDisplay) domBotScoreDisplay.classList.remove('d-none');
        if (domHandIndicator) domHandIndicator.classList.remove('d-none');
        if (domScoreDisplay) {
            domScoreDisplay.innerHTML = '<i class="fas fa-user me-1"></i> MOI: 0';
            domScoreDisplay.className = 'badge bg-success rounded-pill px-3 py-2';
        }
    }

    updateScoreDisplay();
}

function fetchQuestions() {
    if (domQuestion) {
        domQuestion.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Chargement...';
    }

    fetch('api/get_questions.php')
        .then(r => r.json())
        .then(data => {
            if (data.error) throw new Error(data.error);

            // Pour FAF : filtrer les questions sans image (questions longues)
            if (gameMode === 'faf') {
                data = data.filter(q => !q.image || q.image === '' || q.image === null);
            }

            // Trier par difficulté
            data.forEach(q => {
                const diff = q.difficulte || 'Moyen';
                if (questionsPool[diff]) {
                    questionsPool[diff].push(q);
                } else {
                    questionsPool['Moyen'].push(q);
                }
            });

            console.log('✅ Questions chargées:', {
                Facile: questionsPool.Facile.length,
                Moyen: questionsPool.Moyen.length,
                Difficile: questionsPool.Difficile.length
            });

            startGame();
        })
        .catch(error => {
            console.error('❌ Erreur:', error);
            if (domQuestion) {
                domQuestion.innerHTML = `<i class="fas fa-exclamation-triangle me-2"></i> ${error.message}`;
            }
        });
}

function startGame() {
    if (gameMode === '4als') {
        startGlobalTimer();
    }
    nextQuestion();
}

/* =========================================
   SÉLECTION DE QUESTION
   ========================================= */
function nextQuestion() {
    clearTimers();
    isGameLocked = false;

    let difficultyTarget = 'Moyen';
    let pointsValue = 1;

    // --- 9 Points Gagnants : Cycle 1-2-3 ---
    if (gameMode === '9pg') {
        const cycle = (qIndexGlobal % 3) + 1;
        pointsValue = cycle;

        if (cycle === 1) difficultyTarget = 'Facile';
        else if (cycle === 2) difficultyTarget = 'Moyen';
        else difficultyTarget = 'Difficile';

        if (domGameTitle) {
            const ptColor = cycle === 1 ? '#10b981' : (cycle === 2 ? '#fbbf24' : '#ef4444');
            domGameTitle.innerHTML = `9PG - Question à <span style="color:${ptColor}">${pointsValue} pt${pointsValue > 1 ? 's' : ''}</span>`;
        }
    }
    // --- 4 à la Suite ---
    else if (gameMode === '4als') {
        difficultyTarget = 'Moyen';
        pointsValue = 1;
    }
    // --- Face-à-Face ---
    else if (gameMode === 'faf') {
        difficultyTarget = Math.random() > 0.3 ? 'Difficile' : 'Moyen';
        timeLeft = 20;
        currentZone = 4;
        // Main ALÉATOIRE au début de chaque question
        isPlayerHand = Math.random() < 0.5;
        updateHandVisuals();
    }

    // Piocher une question
    let pool = questionsPool[difficultyTarget];
    if (pool.length === 0) {
        pool = questionsPool['Moyen'];
        if (pool.length === 0) pool = questionsPool['Facile'];
        if (pool.length === 0) pool = questionsPool['Difficile'];
    }

    if (pool.length === 0) {
        endGame(playerScore >= 9);
        return;
    }

    const randIndex = Math.floor(Math.random() * pool.length);
    currentQuestion = pool.splice(randIndex, 1)[0];
    currentQuestion.points = pointsValue;

    displayQuestion(currentQuestion);

    // Lancer le timer approprié
    if (gameMode === 'faf') {
        startFAFTimer();
    } else if (gameMode === '9pg') {
        startQuestionTimer();
    }
    // 4ALS : timer global déjà en cours

    qIndexGlobal++;
}

/* =========================================
   AFFICHAGE QUESTION
   ========================================= */
function displayQuestion(q) {
    if (domQNum) domQNum.innerText = qIndexGlobal + 1;

    // Thème
    if (domTheme) {
        domTheme.innerText = q.theme.toUpperCase();
        domTheme.style.backgroundColor = getThemeColor(q.theme);
        domTheme.style.color = '#fff';
    }

    // Difficulté
    if (domDifficulty) {
        domDifficulty.innerText = q.difficulte.toUpperCase();
        if (q.difficulte === 'Facile') {
            domDifficulty.style.backgroundColor = '#10b981';
        } else if (q.difficulte === 'Moyen') {
            domDifficulty.style.backgroundColor = '#f59e0b';
        } else {
            domDifficulty.style.backgroundColor = '#ef4444';
        }
        domDifficulty.style.color = '#fff';
    }

    // IMAGE - Afficher ou masquer
    if (domImageContainer && domQuestionImage) {
        if (q.image && q.image !== '' && q.image !== null) {
            domQuestionImage.src = q.image;
            domImageContainer.classList.remove('d-none');
            domImageContainer.classList.add('d-block');
        } else {
            domImageContainer.classList.add('d-none');
            domImageContainer.classList.remove('d-block');
            domQuestionImage.src = '';
        }
    }

    // Question
    if (domQuestion) {
        domQuestion.innerText = q.question;
        domQuestion.classList.remove('text-sm', 'text-xs', 'text-md');
        if (q.question.length > 120) domQuestion.classList.add('text-xs');
        else if (q.question.length > 60) domQuestion.classList.add('text-sm');
        else domQuestion.classList.add('text-md');
    }

    // Mélanger les réponses
    let indices = [0, 1, 2, 3];
    shuffleArray(indices);

    domAnswers.forEach((btn, i) => {
        btn.classList.remove('correct', 'incorrect', 'correct-highlight');
        btn.disabled = false;
        const textEl = btn.querySelector('.answer-text');
        if (textEl) textEl.innerText = q.options[indices[i]];
        if (indices[i] === q.correct) currentCorrectIndex = i;
    });

    if (domBg) domBg.classList.remove('bg-success-infuse', 'bg-error-infuse');

    // Reset bot status
    if (domBotStatus) domBotStatus.classList.add('d-none');
}

/* =========================================
   TIMER STANDARD (9PG)
   ========================================= */
function startQuestionTimer() {
    timeLeft = 20;
    updateTimerVisuals(timeLeft, 20);

    mainTimer = setInterval(() => {
        timeLeft--;
        updateTimerVisuals(timeLeft, 20);

        if (timeLeft <= 0) {
            clearInterval(mainTimer);
            handleTimeout();
        }
    }, 1000);
}

/* =========================================
   TIMER GLOBAL (4ALS)
   ========================================= */
function startGlobalTimer() {
    globalTimeLeft = 40;

    globalTimer = setInterval(() => {
        globalTimeLeft--;
        updateTimerVisuals(globalTimeLeft, 40);

        if (domFafTimer) {
            const color = globalTimeLeft <= 10 ? '#ef4444' : (globalTimeLeft <= 20 ? '#fbbf24' : '#10b981');
            domFafTimer.innerHTML = `<span style="color:${color}">${globalTimeLeft}s</span>`;
        }

        if (globalTimeLeft <= 0) {
            clearInterval(globalTimer);
            endGame(false);
        }
    }, 1000);
}

/* =========================================
   FACE-À-FACE TIMER & LOGIQUE
   ========================================= */
function startFAFTimer() {
    timeLeft = 20;
    currentZone = 4;
    updateTimerVisuals(timeLeft, 20);
    updateFAFTitle();

    mainTimer = setInterval(() => {
        timeLeft--;
        updateTimerVisuals(timeLeft, 20);

        // Zones de points: 20-16=4pts, 15-11=3pts, 10-6=2pts, 5-0=1pt
        const newZone = Math.max(1, Math.ceil(timeLeft / 5));

        // Changement de zone = Changement de main AUTOMATIQUE
        if (newZone !== currentZone && timeLeft > 0) {
            currentZone = newZone;
            switchHand();
        }

        updateFAFTitle();

        // Si c'est au bot, il réfléchit
        if (!isPlayerHand && !isGameLocked) {
            botThink();
        }

        if (timeLeft <= 0) {
            clearInterval(mainTimer);
            // Personne n'a trouvé
            showCorrectAnswer();
            setTimeout(nextQuestion, 2500);
        }
    }, 1000);
}

function updateFAFTitle() {
    if (domGameTitle) {
        const zoneColor = currentZone >= 3 ? '#10b981' : (currentZone >= 2 ? '#fbbf24' : '#ef4444');
        domGameTitle.innerHTML = `FAF - <span style="color:${zoneColor}">${currentZone} PT${currentZone > 1 ? 'S' : ''}</span>`;
    }
    if (domFafTimer) {
        domFafTimer.innerHTML = `${timeLeft}s`;
    }
}

function switchHand() {
    isPlayerHand = !isPlayerHand;
    updateHandVisuals();
    clearTimeout(botThinkTimeout);
}

function updateHandVisuals() {
    if (domPlayerHandIcon && domBotHandIcon) {
        if (isPlayerHand) {
            domPlayerHandIcon.classList.remove('d-none');
            domBotHandIcon.classList.add('d-none');
        } else {
            domPlayerHandIcon.classList.add('d-none');
            domBotHandIcon.classList.remove('d-none');
        }
    }

    if (domHandIndicator && domHandIndicatorText) {
        if (isPlayerHand) {
            domHandIndicator.className = 'hand-indicator player-turn';
            domHandIndicatorText.innerHTML = 'À VOUS LA MAIN';
        } else {
            domHandIndicator.className = 'hand-indicator bot-turn';
            domHandIndicatorText.innerHTML = 'MAIN ADVERSE';
        }
    }

    // Enable/disable answers
    domAnswers.forEach(btn => {
        btn.style.opacity = isPlayerHand ? '1' : '0.5';
        btn.style.pointerEvents = isPlayerHand ? 'auto' : 'none';
    });

    // Bot status
    if (domBotStatus && domBotStatusText) {
        if (!isPlayerHand) {
            domBotStatus.classList.remove('d-none');
            domBotStatusText.innerHTML = 'L\'adversaire réfléchit...';
        } else {
            domBotStatus.classList.add('d-none');
        }
    }
}

function botThink() {
    // Le bot a une chance de répondre qui augmente avec le temps
    let chance = 0.08;
    if (currentZone === 3) chance = 0.15;
    if (currentZone === 2) chance = 0.25;
    if (currentZone === 1) chance = 0.40;

    if (Math.random() < chance) {
        isGameLocked = true;
        clearInterval(mainTimer);

        if (domBotStatusText) domBotStatusText.innerHTML = 'L\'adversaire buzze !';

        setTimeout(() => {
            // Bot a 65% de chance d'avoir juste
            const botCorrect = Math.random() < 0.65;

            if (botCorrect) {
                botScore += currentZone;
                updateScoreDisplay();

                if (domBotStatusText) domBotStatusText.innerHTML = `Bonne réponse ! +${currentZone} pts`;
                domBotStatus.className = 'container mb-3';
                domBotStatus.querySelector('.alert').className = 'alert alert-danger text-center py-2';

                showCorrectAnswer();

                if (botScore >= FAF_GOAL) {
                    setTimeout(() => endGame(false), 2000);
                } else {
                    setTimeout(nextQuestion, 2500);
                }
            } else {
                // Bot se trompe -> Main au joueur IMMÉDIATEMENT
                if (domBotStatusText) domBotStatusText.innerHTML = 'L\'adversaire s\'est trompé ! À vous !';
                domBotStatus.querySelector('.alert').className = 'alert alert-success text-center py-2';

                isPlayerHand = true;
                isGameLocked = false;
                updateHandVisuals();

                // Reprendre le timer
                startFAFTimer();
            }
        }, 1200);
    }
}

/* =========================================
   RÉPONSE JOUEUR
   ========================================= */
function handleAnswer(btn, index) {
    if (isGameLocked) return;
    if (gameMode === 'faf' && !isPlayerHand) return;

    isGameLocked = true;
    clearTimers();

    const isCorrect = (parseInt(index) === currentCorrectIndex);
    const userAnswerText = domAnswers[index].querySelector('.answer-text')?.innerText || '';
    const correctAnswerText = domAnswers[currentCorrectIndex].querySelector('.answer-text')?.innerText || '';

    // Sauvegarde pour le débrief
    gameHistory.push({
        question: currentQuestion.question,
        userAnswer: userAnswerText,
        correctAnswer: correctAnswerText,
        isCorrect: isCorrect,
        points: currentQuestion.points || 1
    });

    if (isCorrect) {
        btn.classList.add('correct');
        if (domBg) domBg.classList.add('bg-success-infuse');

        if (gameMode === '9pg') {
            playerScore += currentQuestion.points;
            updateGauge();
            updateScoreDisplay();
            if (playerScore >= 9) {
                setTimeout(() => endGame(true), 1500);
                return;
            }
        }
        else if (gameMode === '4als') {
            combo++;
            updateComboVisuals();
            updateScoreDisplay();
            if (combo >= 4) {
                setTimeout(() => endGame(true), 1500);
                return;
            }
        }
        else if (gameMode === 'faf') {
            playerScore += currentZone;
            updateScoreDisplay();
            if (playerScore >= FAF_GOAL) {
                setTimeout(() => endGame(true), 1500);
                return;
            }
        }
    } else {
        btn.classList.add('incorrect');
        if (domBg) domBg.classList.add('bg-error-infuse');
        showCorrectAnswer();

        if (gameMode === '4als') {
            combo = 0;
            updateComboVisuals();
            updateScoreDisplay();
            triggerShake();
        }
        else if (gameMode === 'faf') {
            // Erreur en FAF -> main passe au bot immédiatement
            isPlayerHand = false;
            updateHandVisuals();
        }
    }

    setTimeout(nextQuestion, 2000);
}

function handleTimeout() {
    isGameLocked = true;
    if (domBg) domBg.classList.add('bg-error-infuse');
    showCorrectAnswer();

    if (gameMode === '4als') {
        combo = 0;
        updateComboVisuals();
        updateScoreDisplay();
        triggerShake();
    }

    setTimeout(nextQuestion, 2500);
}

function showCorrectAnswer() {
    domAnswers[currentCorrectIndex].classList.add('correct-highlight');
}

/* =========================================
   UI UPDATES
   ========================================= */
function updateScoreDisplay() {
    if (!domScoreDisplay) return;

    if (gameMode === '9pg') {
        domScoreDisplay.innerHTML = `<i class="fas fa-star me-1"></i> ${playerScore}/9 pts`;
        domScoreDisplay.className = 'badge bg-success rounded-pill px-3 py-2';
    } else if (gameMode === '4als') {
        domScoreDisplay.innerHTML = `<i class="fas fa-bolt me-1"></i> Combo: ${combo}/4`;
        const colors = combo === 0 ? 'bg-danger' : (combo < 3 ? 'bg-warning' : 'bg-success');
        domScoreDisplay.className = `badge ${colors} rounded-pill px-3 py-2`;
    } else if (gameMode === 'faf') {
        domScoreDisplay.innerHTML = `<i class="fas fa-user me-1"></i> MOI: ${playerScore}`;
        if (domBotScoreDisplay) {
            domBotScoreDisplay.innerHTML = `<i class="fas fa-robot me-1"></i> BOT: ${botScore}`;
        }
    }
}

function updateComboVisuals() {
    for (let i = 1; i <= 4; i++) {
        const dot = document.getElementById(`comboDot${i}`);
        if (dot) {
            if (i <= combo) {
                dot.classList.add('active');
            } else {
                dot.classList.remove('active');
            }
        }
    }
}

function updateGauge() {
    if (!domGaugeFill) return;
    const percent = Math.min((playerScore / 9) * 100, 100);
    domGaugeFill.style.height = `${percent}%`;
}

function updateTimerVisuals(current, max) {
    if (domTimerText) domTimerText.innerText = current;

    if (domTimerCircle) {
        const offset = 283 - (current / max) * 283;
        domTimerCircle.style.strokeDashoffset = offset;

        if (current <= 5) {
            domTimerCircle.style.stroke = "#ef4444";
            if (domTimerText) domTimerText.style.color = "#ef4444";
        } else if (current <= 10) {
            domTimerCircle.style.stroke = "#fbbf24";
            if (domTimerText) domTimerText.style.color = "#fbbf24";
        } else {
            domTimerCircle.style.stroke = "#10b981";
            if (domTimerText) domTimerText.style.color = "#fff";
        }
    }
}

function triggerShake() {
    document.body.classList.add('shake-anim');
    setTimeout(() => document.body.classList.remove('shake-anim'), 500);
}

/* =========================================
   FIN DE JEU
   ========================================= */
function endGame(won) {
    clearTimers();

    // Stats localStorage
    const games = parseInt(localStorage.getItem('qpuc_games') || '0') + 1;
    const wins = parseInt(localStorage.getItem('qpuc_wins') || '0') + (won ? 1 : 0);
    localStorage.setItem('qpuc_games', games);
    localStorage.setItem('qpuc_wins', wins);

    // Sauvegarde de l'historique pour le débrief
    const results = {
        mode: gameMode,
        playerScore: playerScore,
        botScore: botScore,
        combo: combo,
        totalQuestions: qIndexGlobal,
        won: won,
        answers: gameHistory
    };
    sessionStorage.setItem('qpuc_results', JSON.stringify(results));

    window.location.href = `resultat.php?mode=${gameMode}&win=${won ? 1 : 0}&score=${playerScore}`;
}

/* =========================================
   UTILITAIRES
   ========================================= */
function clearTimers() {
    clearInterval(mainTimer);
    clearTimeout(botThinkTimeout);
}

function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
}

function getThemeColor(theme) {
    const colors = {
        'Sport': '#10b981',
        'Histoire': '#8b5cf6',
        'Géographie': '#3b82f6',
        'Sciences': '#14b8a6',
        'Musiques': '#ec4899',
        'Classique': '#6366f1',
        'Moderne': '#f59e0b',
        'Jeux Vidéos / Culture Web': '#ef4444',
        'Animaux et plantes': '#22c55e',
        'Culture générale': '#6b7280'
    };
    return colors[theme] || '#6b7280';
}

// Expose for onclick
window.handleAnswer = handleAnswer;
