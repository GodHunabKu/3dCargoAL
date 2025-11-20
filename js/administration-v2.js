(function() {
    'use strict';
    function initNotifications() {
        const notification = document.getElementById('mainNotification');
        if (notification) {
            setTimeout(function() {
                notification.style.animation = 'slideOutUp 0.5s ease';
                setTimeout(function() {
                    notification.remove();
                }, 500);
            }, 5000);
        }
    }
    function initFormConfirmations() {
        const forms = document.querySelectorAll('.action-item form');
        forms.forEach(function(form) {
            form.addEventListener('submit', function(e) {
                const button = form.querySelector('button[type="submit"]');
                if (button) {
                    button.disabled = true;
                    button.style.opacity = '0.6';
                    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Invio...';
                    setTimeout(function() {
                        if (!confirm('Sei sicuro di voler procedere?')) {
                            button.disabled = false;
                            button.style.opacity = '1';
                            const originalText = button.getAttribute('data-original-text');
                            if (originalText) {
                                button.innerHTML = originalText;
                            }
                        }
                    }, 100);
                }
            });
            const button = form.querySelector('button[type="submit"]');
            if (button) {
                button.setAttribute('data-original-text', button.innerHTML);
            }
        });
    }
    function createClickEffect(e) {
        const ripple = document.createElement('span');
        ripple.style.position = 'absolute';
        ripple.style.borderRadius = '50%';
        ripple.style.background = 'rgba(255, 255, 255, 0.6)';
        ripple.style.width = '20px';
        ripple.style.height = '20px';
        ripple.style.left = e.offsetX + 'px';
        ripple.style.top = e.offsetY + 'px';
        ripple.style.transform = 'translate(-50%, -50%)';
        ripple.style.pointerEvents = 'none';
        ripple.style.animation = 'rippleEffect 0.6s ease-out';
        this.appendChild(ripple);
        setTimeout(function() {
            ripple.remove();
        }, 600);
    }
    function initButtonEffects() {
        const buttons = document.querySelectorAll('.action-btn');
        buttons.forEach(function(btn) {
            btn.style.position = 'relative';
            btn.style.overflow = 'hidden';
            btn.addEventListener('click', createClickEffect);
        });
        if (!document.getElementById('rippleAnimation')) {
            const style = document.createElement('style');
            style.id = 'rippleAnimation';
            style.textContent = `
                @keyframes rippleEffect {
                    from {
                        transform: translate(-50%, -50%) scale(0);
                        opacity: 1;
                    }
                    to {
                        transform: translate(-50%, -50%) scale(4);
                        opacity: 0;
                    }
                }
                @keyframes slideOutUp {
                    from {
                        opacity: 1;
                        transform: translateY(0);
                    }
                    to {
                        opacity: 0;
                        transform: translateY(-20px);
                    }
                }
            `;
            document.head.appendChild(style);
        }
    }
    function initSmoothScroll() {
        document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    function init() {
        initNotifications();
        initButtonEffects();
        initSmoothScroll();
    }
})();

(function() {
    document.addEventListener('DOMContentLoaded', function() {
        const phpNotification = document.getElementById('mainNotification');
        if (phpNotification && window.ModernFeatures && window.ModernFeatures.toast) {
            const type = phpNotification.classList.contains('notification-success') ? 'success' :
                        phpNotification.classList.contains('notification-error') ? 'error' :
                        phpNotification.classList.contains('notification-warning') ? 'warning' : 'info';
            const titleEl = phpNotification.querySelector('strong');
            const messageEl = phpNotification.querySelector('p');
            const title = titleEl ? titleEl.textContent : '';
            const message = messageEl ? messageEl.textContent : '';
            const fullMessage = title + (title && message ? ': ' : '') + message;
            phpNotification.remove();
            window.ModernFeatures.toast.show(fullMessage, type, 5000);
        }
    });
})();
