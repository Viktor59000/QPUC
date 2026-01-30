document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.auth-container');
    const registerBtn = document.querySelector('.register-btn');
    const loginBtn = document.querySelector('.login-btn');
    const authTriggerInfo = document.getElementById('authTriggerInfo'); // Optional trigger

    if (registerBtn && container) {
        registerBtn.addEventListener('click', () => {
            container.classList.add('active');
        });
    }

    if (loginBtn && container) {
        loginBtn.addEventListener('click', () => {
            container.classList.remove('active');
        });
    }
});
