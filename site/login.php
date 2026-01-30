<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QPUC - Connexion / Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/background.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <!-- Simple CSS Background -->
    <div class="animated-bg"></div>

    <div class="container d-flex justify-content-center align-items-center min-vh-100" style="position: relative; z-index: 10;">
        
        <!-- Auth Container -->
        <div class="auth-box">
            <div class="form-box login">
                <form id="loginForm">
                    <h1>Connexion</h1>
                    <div class="input-box">
                        <input type="text" id="loginEmail" placeholder="Pseudo" required>
                        <i class="bx bxs-user"></i>
                    </div>
                    <div class="input-box">
                        <input type="password" id="loginPassword" placeholder="Mot de passe" required>
                        <i class="bx bxs-lock-alt"></i>
                    </div>
                    <div class="forgot-link">
                        <a href="#">Mot de passe oublié ?</a>
                    </div>
                    <button type="submit" class="btn-auth">Se connecter</button>
                    <p>ou connectez-vous avec</p>
                    <div class="social-icons">
                        <a href="#" id="googleBtn"><i class="bx bxl-google"></i></a>
                        <a href="#" id="facebookBtn"><i class="bx bxl-facebook"></i></a>
                    </div>
                </form>
            </div>

            <div class="form-box register">
                <form id="registerForm">
                    <h1>Inscription</h1>
                    <div class="input-box">
                        <input type="text" id="registerPseudo" placeholder="Pseudo" required>
                        <i class="bx bxs-user"></i>
                    </div>
                    <div class="input-box">
                        <input type="email" id="registerEmail" placeholder="Email" required>
                        <i class="bx bxs-envelope"></i>
                    </div>
                    <div class="input-box">
                        <input type="password" id="registerPassword" placeholder="Mot de passe" required>
                        <i class="bx bxs-lock-alt"></i>
                    </div>
                    <button type="submit" class="btn-auth">S'inscrire</button>
                    <p>ou inscrivez-vous avec</p>
                    <div class="social-icons">
                        <a href="#" class="google-social"><i class="bx bxl-google"></i></a>
                        <a href="#" class="facebook-social"><i class="bx bxl-facebook"></i></a>
                    </div>
                </form>
            </div>

            <div class="toggle-box">
                <div class="toggle-panel toggle-left">
                    <h1>Bienvenue !</h1>
                    <p>Tu n'as pas encore de compte ?</p>
                    <button type="button" class="btn-toggle register-btn">S'inscrire</button>
                </div>
                <div class="toggle-panel toggle-right">
                    <h1>Bon retour !</h1>
                    <p>Déjà parmi nous ?</p>
                    <button type="button" class="btn-toggle login-btn">Se connecter</button>
                </div>
            </div>
        </div>
    </div>
    
    <a href="index.php" class="btn btn-link text-white position-fixed" style="top: 20px; left: 20px; z-index: 100;">
        <i class="fas fa-arrow-left me-2"></i> Retour
    </a>

    <script src="js/cursor.js"></script>
    <script>
        const container = document.querySelector('.auth-box');
        const registerBtn = document.querySelector('.register-btn');
        const loginBtn = document.querySelector('.login-btn');
        const loginForm = document.getElementById('loginForm');
        const registerForm = document.getElementById('registerForm');

        // Toggle between login and register
        registerBtn.addEventListener('click', () => {
            container.classList.add('active');
        });

        loginBtn.addEventListener('click', () => {
            container.classList.remove('active');
        });

        // Handle Login (REAL API)
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const username = document.getElementById('loginEmail').value;
            const password = document.getElementById('loginPassword').value;
            
            try {
                const res = await fetch('api/login.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password })
                });
                
                const data = await res.json();
                
                if (data.success) {
                    localStorage.setItem('qpuc_logged_in', 'true');
                    localStorage.setItem('qpuc_player_name', data.username);
                    window.location.href = 'index.php';
                } else {
                    alert(data.message);
                    document.querySelector('.auth-box').classList.add('shake-anim');
                    setTimeout(() => document.querySelector('.auth-box').classList.remove('shake-anim'), 500);
                }
            } catch (err) {
                alert('Erreur de connexion au serveur');
            }
        });

        // Handle Register (REAL API)
        registerForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const username = document.getElementById('registerPseudo').value;
            const email = document.getElementById('registerEmail').value;
            const password = document.getElementById('registerPassword').value;
            
            try {
                const res = await fetch('api/register.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, email, password })
                });
                
                const data = await res.json();
                
                if (data.success) {
                    localStorage.setItem('qpuc_logged_in', 'true');
                    localStorage.setItem('qpuc_player_name', username);
                    window.location.href = 'index.php';
                } else {
                    alert(data.message);
                }
            } catch (err) {
                alert('Erreur de connexion au serveur');
            }
        });

        // Social Login (info message - requires OAuth setup)
        document.querySelectorAll('.social-icons a').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                alert("Pour activer le login Google/Facebook, le site doit être hébergé avec HTTPS et des clés OAuth2 configurées.");
            });
        });
    </script>
</body>
</html>
