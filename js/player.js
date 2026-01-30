/**
 * QPUC - Music Player with Audio Persistence
 * Sauvegarde l'état de la musique entre les pages
 */

document.addEventListener('DOMContentLoaded', () => {
    // Éléments DOM
    const playBtn = document.getElementById('playBtn');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const progressContainer = document.getElementById('progressContainer');
    const progressBar = document.getElementById('progressBar');
    const trackTitle = document.getElementById('trackTitle');
    const trackArtist = document.getElementById('trackArtist');
    const trackCover = document.getElementById('trackCover');

    // Playlist (mock data - à remplacer par de vraies pistes)
    const playlist = [
        {
            title: "Ambiance Quiz",
            artist: "QPUC",
            cover: "https://raw.githubusercontent.com/muhammederdem/mini-player/master/img/1.jpg",
            src: "" // Pas de fichier audio réel pour l'instant
        },
        {
            title: "Tension Finale",
            artist: "QPUC",
            cover: "https://raw.githubusercontent.com/muhammederdem/mini-player/master/img/2.jpg",
            src: ""
        },
        {
            title: "Victoire",
            artist: "QPUC",
            cover: "https://raw.githubusercontent.com/muhammederdem/mini-player/master/img/3.jpg",
            src: ""
        }
    ];

    let currentTrack = parseInt(localStorage.getItem('qpuc_track_index')) || 0;
    let isPlaying = localStorage.getItem('qpuc_music_playing') === 'true';
    let fakeProgress = parseFloat(localStorage.getItem('qpuc_music_progress')) || 0;
    let progressInterval = null;

    // Initialiser l'affichage
    function loadTrack(index) {
        if (index < 0) index = playlist.length - 1;
        if (index >= playlist.length) index = 0;
        currentTrack = index;

        const track = playlist[currentTrack];
        if (trackTitle) trackTitle.textContent = track.title;
        if (trackArtist) trackArtist.textContent = track.artist;
        if (trackCover) trackCover.src = track.cover;

        localStorage.setItem('qpuc_track_index', currentTrack);
    }

    // Lecture/Pause
    function togglePlay() {
        isPlaying = !isPlaying;
        updatePlayButton();
        localStorage.setItem('qpuc_music_playing', isPlaying);

        if (isPlaying) {
            startFakeProgress();
        } else {
            stopFakeProgress();
        }
    }

    function updatePlayButton() {
        if (!playBtn) return;
        const icon = playBtn.querySelector('i');
        if (icon) {
            icon.className = isPlaying ? 'fas fa-pause' : 'fas fa-play';
        }
    }

    // Progress bar simulée (puisqu'on n'a pas de vrai audio)
    function startFakeProgress() {
        stopFakeProgress();
        progressInterval = setInterval(() => {
            fakeProgress += 0.5;
            if (fakeProgress >= 100) {
                fakeProgress = 0;
                nextTrack();
            }
            updateProgressBar();
            localStorage.setItem('qpuc_music_progress', fakeProgress);
        }, 1000);
    }

    function stopFakeProgress() {
        if (progressInterval) {
            clearInterval(progressInterval);
            progressInterval = null;
        }
    }

    function updateProgressBar() {
        if (progressBar) {
            progressBar.style.width = `${fakeProgress}%`;
        }
    }

    // Navigation
    function prevTrack() {
        fakeProgress = 0;
        loadTrack(currentTrack - 1);
    }

    function nextTrack() {
        fakeProgress = 0;
        loadTrack(currentTrack + 1);
    }

    // Event Listeners
    if (playBtn) playBtn.addEventListener('click', togglePlay);
    if (prevBtn) prevBtn.addEventListener('click', prevTrack);
    if (nextBtn) nextBtn.addEventListener('click', nextTrack);

    if (progressContainer) {
        progressContainer.addEventListener('click', (e) => {
            const rect = progressContainer.getBoundingClientRect();
            const clickX = e.clientX - rect.left;
            fakeProgress = (clickX / rect.width) * 100;
            updateProgressBar();
            localStorage.setItem('qpuc_music_progress', fakeProgress);
        });
    }

    // Sauvegarder avant de quitter la page
    window.addEventListener('beforeunload', () => {
        localStorage.setItem('qpuc_music_playing', isPlaying);
        localStorage.setItem('qpuc_music_progress', fakeProgress);
        localStorage.setItem('qpuc_track_index', currentTrack);
    });

    // Initialisation au chargement
    loadTrack(currentTrack);
    updateProgressBar();
    updatePlayButton();

    // Restaurer l'état de lecture
    if (isPlaying) {
        startFakeProgress();
    }
});
