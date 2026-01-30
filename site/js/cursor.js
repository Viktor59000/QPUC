// Ultra-simple Custom Cursor - Direct positioning for zero lag
document.addEventListener('DOMContentLoaded', () => {
    let cursor = document.getElementById('customCursor');
    if (!cursor) {
        cursor = document.createElement('div');
        cursor.id = 'customCursor';
        cursor.className = 'custom-cursor';
        document.body.appendChild(cursor);
    }

    let isClicking = false;

    // Direct update on mousemove - no RAF, no interpolation, no delay
    document.addEventListener('mousemove', (e) => {
        const scale = isClicking ? 'scale(0.8)' : '';
        cursor.style.transform = `translate3d(${e.clientX}px, ${e.clientY}px, 0) translate(-50%, -50%) ${scale}`;
    });

    // Hover effects
    document.querySelectorAll('a, button, .game-mode-card, .btn-answer, .glass-card, input, select, textarea, .pointer').forEach(el => {
        el.addEventListener('mouseenter', () => cursor.classList.add('cursor-hover'));
        el.addEventListener('mouseleave', () => cursor.classList.remove('cursor-hover'));
    });

    // Click effect via JS (not CSS, to avoid transform conflict)
    document.addEventListener('mousedown', (e) => {
        isClicking = true;
        cursor.style.transform = `translate3d(${e.clientX}px, ${e.clientY}px, 0) translate(-50%, -50%) scale(0.8)`;
    });
    document.addEventListener('mouseup', (e) => {
        isClicking = false;
        cursor.style.transform = `translate3d(${e.clientX}px, ${e.clientY}px, 0) translate(-50%, -50%)`;
    });
});

