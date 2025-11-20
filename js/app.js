(function() {
    'use strict';
    const Utils = {
        debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        },
        throttle(func, limit) {
            let inThrottle;
            return function(...args) {
                if (!inThrottle) {
                    func.apply(this, args);
                    inThrottle = true;
                    setTimeout(() => inThrottle = false, limit);
                }
            };
        },
        smoothScroll(target, duration = 800) {
            const targetPosition = target.getBoundingClientRect().top + window.pageYOffset;
            const startPosition = window.pageYOffset;
            const distance = targetPosition - startPosition;
            let startTime = null;
            function animation(currentTime) {
                if (startTime === null) startTime = currentTime;
                const timeElapsed = currentTime - startTime;
                const run = ease(timeElapsed, startPosition, distance, duration);
                window.scrollTo(0, run);
                if (timeElapsed < duration) requestAnimationFrame(animation);
            }
            function ease(t, b, c, d) {
                t /= d / 2;
                if (t < 1) return c / 2 * t * t + b;
                t--;
                return -c / 2 * (t * (t - 2) - 1) + b;
            }
            requestAnimationFrame(animation);
        }
    };
    const PreloaderModule = {
        init() {
            const preloader = document.getElementById('preloader');
            if (!preloader) return;
            window.addEventListener('load', () => {
                setTimeout(() => {
                    preloader.classList.add('loaded');
                    document.body.classList.add('loaded');
                    setTimeout(() => {
                        preloader.style.display = 'none';
                    }, 500);
                }, 300);
            });
            setTimeout(() => {
                if (!preloader.classList.contains('loaded')) {
                    preloader.classList.add('loaded');
                    document.body.classList.add('loaded');
                }
            }, 5000);
        }
    };
    const MobileMenuModule = {
        init() {
            const mobileMenuButton = document.getElementById('mobile-menu-toggle');
            const sidebar = document.querySelector('.sidebar');
            if (!mobileMenuButton || !sidebar) return;
            mobileMenuButton.addEventListener('click', (e) => {
                e.stopPropagation();
                this.toggleMenu();
            });
            document.addEventListener('click', (e) => {
                if (document.body.classList.contains('sidebar-open')) {
                    if (!sidebar.contains(e.target) && !mobileMenuButton.contains(e.target)) {
                        this.closeMenu();
                    }
                }
            });
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && document.body.classList.contains('sidebar-open')) {
                    this.closeMenu();
                }
            });
            sidebar.querySelectorAll('a').forEach(link => {
                link.addEventListener('click', () => {
                    this.closeMenu();
                });
            });
        },
        toggleMenu() {
            document.body.classList.toggle('sidebar-open');
            const isOpen = document.body.classList.contains('sidebar-open');
            if (isOpen) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = '';
            }
        },
        closeMenu() {
            document.body.classList.remove('sidebar-open');
            document.body.style.overflow = '';
        }
    };
    const SmoothScrollModule = {
        init() {
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (!href || href === '#') return;
                    const target = document.querySelector(href);
                    if (target) {
                        e.preventDefault();
                        Utils.smoothScroll(target);
                    }
                });
            });
        }
    };
    const BackToTopModule = {
        init() {
            if (!document.getElementById('back-to-top')) {
                const button = document.createElement('button');
                button.id = 'back-to-top';
                button.innerHTML = '<i class="fas fa-arrow-up"></i>';
                button.setAttribute('aria-label', 'Torna su');
                document.body.appendChild(button);
                this.addStyles();
            }
            const backToTopButton = document.getElementById('back-to-top');
            if (!backToTopButton) return;
            window.addEventListener('scroll', Utils.throttle(() => {
                if (window.pageYOffset > 300) {
                    backToTopButton.classList.add('visible');
                } else {
                    backToTopButton.classList.remove('visible');
                }
            }, 200));
            backToTopButton.addEventListener('click', () => {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        },
        addStyles() {
            const style = document.createElement('style');
            style.textContent = `
                #back-to-top {
                    position: fixed;
                    bottom: 30px;
                    right: 30px;
                    width: 50px;
                    height: 50px;
                    background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-primary-dark) 100%);
                    border: none;
                    border-radius: 50%;
                    color: white;
                    font-size: 20px;
                    cursor: pointer;
                    opacity: 0;
                    visibility: hidden;
                    transform: translateY(20px);
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
                    z-index: 998;
                }
                #back-to-top.visible {
                    opacity: 1;
                    visibility: visible;
                    transform: translateY(0);
                }
                #back-to-top:hover {
                    transform: translateY(-5px) scale(1.05);
                    box-shadow: 0 8px 25px rgba(231, 76, 60, 0.5);
                }
                #back-to-top:active {
                    transform: translateY(-2px) scale(0.98);
                }
                @media (max-width: 768px) {
                    #back-to-top {
                        bottom: 20px;
                        right: 20px;
                        width: 45px;
                        height: 45px;
                        font-size: 18px;
                    }
                }
            `;
            document.head.appendChild(style);
        }
    };
    const DropdownModule = {
        init() {
            const dropdowns = document.querySelectorAll('.dropdown');
            dropdowns.forEach(dropdown => {
                const button = dropdown.querySelector('.dropbtn');
                const content = dropdown.querySelector('.dropdown-content');
                if (!button || !content) return;
                button.addEventListener('click', (e) => {
                    e.stopPropagation();
                    this.closeAllDropdowns();
                    dropdown.classList.toggle('active');
                });
                document.addEventListener('click', () => {
                    dropdown.classList.remove('active');
                });
            });
        },
        closeAllDropdowns() {
            document.querySelectorAll('.dropdown.active').forEach(d => {
                d.classList.remove('active');
            });
        }
    };
    const HoverEffectsModule = {
        init() {
            this.addRippleEffect();
            this.addNavGlowEffect();
        },
        addRippleEffect() {
            const buttons = document.querySelectorAll('.btn-submit, .btn-download, .btn-more, .search-btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.5);
                        left: ${x}px;
                        top: ${y}px;
                        pointer-events: none;
                        animation: ripple-effect 0.6s ease-out;
                    `;
                    if (!document.getElementById('ripple-keyframes')) {
                        const style = document.createElement('style');
                        style.id = 'ripple-keyframes';
                        style.textContent = `
                            @keyframes ripple-effect {
                                from {
                                    transform: scale(0);
                                    opacity: 1;
                                }
                                to {
                                    transform: scale(2);
                                    opacity: 0;
                                }
                            }
                        `;
                        document.head.appendChild(style);
                    }
                    this.appendChild(ripple);
                    setTimeout(() => ripple.remove(), 600);
                });
            });
        },
        addNavGlowEffect() {
            const navLinks = document.querySelectorAll('.main-nav a, .sidebar-nav a');
            navLinks.forEach(link => {
                link.addEventListener('mouseenter', function() {
                    const icon = this.querySelector('i');
                    if (icon) {
                        icon.style.filter = 'drop-shadow(0 0 8px var(--color-primary))';
                    }
                });
                link.addEventListener('mouseleave', function() {
                    const icon = this.querySelector('i');
                    if (icon) {
                        icon.style.filter = '';
                    }
                });
            });
        }
    };
    const PerformanceModule = {
        init() {
            if (!('performance' in window)) return;
            window.addEventListener('load', () => {
                setTimeout(() => {
                    const perfData = performance.timing;
                    const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;
                    const connectTime = perfData.responseEnd - perfData.requestStart;
                }, 0);
            });
        }
    };
    const FormValidationModule = {
        init() {
            const passwordInput = document.getElementById('password');
            const rpasswordInput = document.getElementById('rpassword');
            if (passwordInput && rpasswordInput) {
                this.validatePasswordMatch();
                this.addPasswordStrength();
            }
            const emailInputs = document.querySelectorAll('input[type="email"]');
            emailInputs.forEach(input => {
                input.addEventListener('blur', () => {
                    if (input.value && !this.isValidEmail(input.value)) {
                        input.style.borderColor = 'var(--color-primary)';
                    } else {
                        input.style.borderColor = '';
                    }
                });
            });
        },
        validatePasswordMatch() {
            const passwordInput = document.getElementById('password');
            const rpasswordInput = document.getElementById('rpassword');
            const checkPasswordEl = document.getElementById('checkpassword');
            if (!passwordInput || !rpasswordInput) return;
            rpasswordInput.addEventListener('input', () => {
                if (checkPasswordEl) checkPasswordEl.textContent = '';
                if (rpasswordInput.value.length > 0 &&
                    passwordInput.value !== rpasswordInput.value) {
                    if (checkPasswordEl) {
                        checkPasswordEl.textContent = 'Le password non coincidono';
                        checkPasswordEl.style.color = 'var(--color-primary)';
                    }
                    rpasswordInput.style.borderColor = 'var(--color-primary)';
                } else {
                    rpasswordInput.style.borderColor = '';
                }
            });
        },
        addPasswordStrength() {
            const passwordInput = document.getElementById('password');
            if (!passwordInput) return;
            let strengthContainer = document.getElementById('password-strength');
            if (!strengthContainer) {
                strengthContainer = document.createElement('div');
                strengthContainer.id = 'password-strength';
                strengthContainer.style.cssText = `
                    margin-top: 8px;
                    height: 4px;
                    background: rgba(255, 255, 255, 0.1);
                    border-radius: 2px;
                    overflow: hidden;
                `;
                const strengthBar = document.createElement('div');
                strengthBar.id = 'strength-bar';
                strengthBar.style.cssText = `
                    height: 100%;
                    width: 0%;
                    transition: width 0.3s, background 0.3s;
                    border-radius: 2px;
                `;
                strengthContainer.appendChild(strengthBar);
                passwordInput.parentNode.appendChild(strengthContainer);
            }
            passwordInput.addEventListener('input', () => {
                const strength = this.calculatePasswordStrength(passwordInput.value);
                const strengthBar = document.getElementById('strength-bar');
                if (strengthBar) {
                    strengthBar.style.width = strength.percentage + '%';
                    strengthBar.style.background = strength.color;
                }
            });
        },
        calculatePasswordStrength(password) {
            if (password.length === 0) {
                return { percentage: 0, color: 'transparent' };
            }
            let score = 0;
            if (password.length >= 5) score += 25;
            if (password.length >= 8) score += 25;
            if (/[A-Z]/.test(password)) score += 25;
            if (/[0-9]/.test(password)) score += 25;
            if (/[^A-Za-z0-9]/.test(password)) score = Math.min(100, score + 10);
            let color;
            if (score <= 25) {
                color = '#E74C3C';
            } else if (score <= 50) {
                color = '#F39C12';
            } else if (score <= 75) {
                color = '#3498DB';
            } else {
                color = '#27AE60';
            }
            return { percentage: score, color };
        },
        isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }
    };
    const TypingEffectModule = {
        init() {
            const tagline = document.querySelector('.hero-tagline');
            if (!tagline || tagline.dataset.typed) return;
            const text = tagline.textContent;
            tagline.textContent = '';
            tagline.dataset.typed = 'true';
            let index = 0;
            const speed = 50;
            function typeWriter() {
                if (index < text.length) {
                    tagline.textContent += text.charAt(index);
                    index++;
                    setTimeout(typeWriter, speed);
                } else {
                    tagline.style.borderRight = 'none';
                }
            }
            tagline.style.borderRight = '2px solid var(--color-primary)';
            tagline.style.paddingRight = '5px';
            setTimeout(typeWriter, 500);
        }
    };
    document.addEventListener('DOMContentLoaded', () => {
        try {
            PreloaderModule.init();
            MobileMenuModule.init();
            SmoothScrollModule.init();
            BackToTopModule.init();
            DropdownModule.init();
            PerformanceModule.init();
            HoverEffectsModule.init();
            FormValidationModule.init();
            TypingEffectModule.init();
        } catch (error) {
            console.error('Errore durante l\'inizializzazione:', error);
        }
    });
    let resizeTimer;
    window.addEventListener('resize', () => {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(() => {
        }, 250);
    });
})();
