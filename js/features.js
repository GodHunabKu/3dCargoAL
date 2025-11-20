(function() {
    'use strict';
    const ToastManager = {
        container: null,
        init: function() {
            this.container = document.createElement('div');
            this.container.className = 'toast-container';
            document.body.appendChild(this.container);
        },
        show: function(message, type = 'info', duration = 3000) {
            const toast = document.createElement('div');
            toast.className = `toast toast-${type} animate-slideInRight`;
            const icon = this.getIcon(type);
            toast.innerHTML = `
                <span style="font-size: 1.25rem;">${icon}</span>
                <span style="flex: 1; color: var(--text-primary);">${message}</span>
                <button onclick="this.parentElement.remove()" style="background: none; border: none; color: var(--text-secondary); cursor: pointer; font-size: 1.25rem; padding: 0; margin-left: var(--space-2);" aria-label="Close">×</button>
            `;
            this.container.appendChild(toast);
            setTimeout(() => {
                toast.remove();
            }, duration);
            return toast;
        },
        getIcon: function(type) {
            const icons = {
                success: '✓',
                error: '✕',
                warning: '⚠',
                info: 'ℹ'
            };
            return icons[type] || icons.info;
        },
        success: function(message, duration) {
            return this.show(message, 'success', duration);
        },
        error: function(message, duration) {
            return this.show(message, 'error', duration);
        },
        warning: function(message, duration) {
            return this.show(message, 'warning', duration);
        },
        info: function(message, duration) {
            return this.show(message, 'info', duration);
        }
    };
    const LoadingManager = {
        addToButton: function(button) {
            if (!button) return;
            button.classList.add('btn-loading');
            button.setAttribute('disabled', 'disabled');
            button.dataset.originalText = button.textContent;
        },
        removeFromButton: function(button) {
            if (!button) return;
            button.classList.remove('btn-loading');
            button.removeAttribute('disabled');
            if (button.dataset.originalText) {
                button.textContent = button.dataset.originalText;
            }
        },
        showPageLoader: function() {
            let loader = document.getElementById('page-loader');
            if (!loader) {
                loader = document.createElement('div');
                loader.id = 'page-loader';
                loader.innerHTML = '<div class="spinner"></div>';
                loader.style.cssText = 'position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 9999; pointer-events: auto;';
                document.body.appendChild(loader);
            }
            loader.style.display = 'flex';
            loader.style.pointerEvents = 'auto';
        },
        hidePageLoader: function() {
            const loader = document.getElementById('page-loader');
            if (loader) {
                loader.style.display = 'none';
                loader.style.pointerEvents = 'none';
            }
        }
    };
    const SmoothScroll = {
        init: function() {
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (href === '#') return;
                    const target = document.querySelector(href);
                    if (target) {
                        e.preventDefault();
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        }
    };
    const FormEnhancer = {
        init: function() {
            document.querySelectorAll('input[type="text"], input[type="email"], input[type="password"], textarea, select').forEach(input => {
                if (!input.classList.contains('input-modern')) {
                    input.classList.add('input-modern');
                }
            });
            document.querySelectorAll('button[type="submit"], input[type="submit"]').forEach(button => {
                if (!button.classList.contains('btn-modern')) {
                    button.classList.add('btn-modern', 'btn-primary-modern');
                }
            });
            this.enhanceAjaxForms();
        },
        enhanceAjaxForms: function() {
            document.querySelectorAll('form').forEach(form => {
                form.addEventListener('submit', function(e) {
                    const submitBtn = this.querySelector('button[type="submit"], input[type="submit"]');
                    if (submitBtn) {
                        LoadingManager.addToButton(submitBtn);
                        setTimeout(() => {
                            LoadingManager.removeFromButton(submitBtn);
                        }, 10000);
                    }
                });
            });
        }
    };
    const CardAnimator = {
        init: function() {
            document.querySelectorAll('.card, .panel, .box').forEach(card => {
                if (!card.classList.contains('card-modern')) {
                    card.classList.add('card-modern');
                }
            });
            return;
        }
    };
    const AccessibilityEnhancer = {
        init: function() {
            document.querySelectorAll('button, a, input, select, textarea').forEach(el => {
                el.classList.add('focus-visible');
            });
            document.querySelectorAll('button:not([aria-label])').forEach(btn => {
                const text = btn.textContent.trim();
                if (text) {
                    btn.setAttribute('aria-label', text);
                }
            });
            this.addSkipLink();
        },
        addSkipLink: function() {
            const main = document.querySelector('main, #main, .main-content');
            if (main && !main.id) {
                main.id = 'main-content';
            }
            if (main && !document.querySelector('.skip-to-main')) {
                const skipLink = document.createElement('a');
                skipLink.href = '#main-content';
                skipLink.className = 'skip-to-main sr-only focus-visible';
                skipLink.textContent = 'Skip to main content';
                skipLink.style.cssText = 'position: absolute; top: 0; left: 0; z-index: 99999;';
                skipLink.addEventListener('focus', function() {
                    this.classList.remove('sr-only');
                });
                skipLink.addEventListener('blur', function() {
                    this.classList.add('sr-only');
                });
                document.body.insertBefore(skipLink, document.body.firstChild);
            }
        }
    };
    const AjaxEnhancer = {
        init: function() {
            if (window.jQuery) {
                const originalAjax = jQuery.ajax;
                jQuery.ajax = function(options) {
                    const originalSuccess = options.success;
                    const originalError = options.error;
                    options.success = function(data, textStatus, jqXHR) {
                        if (originalSuccess) {
                            originalSuccess.apply(this, arguments);
                        }
                    };
                    options.error = function(jqXHR, textStatus, errorThrown) {
                        if (originalError) {
                            originalError.apply(this, arguments);
                        } else {
                            ToastManager.error('Connection error. Please try again.');
                        }
                    };
                    return originalAjax.call(jQuery, options);
                };
            }
        }
    };
    const PerformanceOptimizer = {
        init: function() {
            this.lazyLoadImages();
            this.optimizeResizeEvents();
        },
        lazyLoadImages: function() {
            const images = document.querySelectorAll('img[data-src]');
            const imageObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        imageObserver.unobserve(img);
                    }
                });
            });
            images.forEach(img => imageObserver.observe(img));
        },
        optimizeResizeEvents: function() {
            let resizeTimer;
            window.addEventListener('resize', function() {
                clearTimeout(resizeTimer);
                resizeTimer = setTimeout(function() {
                    window.dispatchEvent(new Event('optimizedResize'));
                }, 250);
            });
        }
    };
    function initModernFeatures() {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', init);
        } else {
            init();
        }
        function init() {
            ToastManager.init();
            SmoothScroll.init();
            FormEnhancer.init();
            CardAnimator.init();
            AccessibilityEnhancer.init();
            AjaxEnhancer.init();
            PerformanceOptimizer.init();
        }
    }
    initModernFeatures();
    window.ModernFeatures = {
        toast: ToastManager,
        loading: LoadingManager
    };
})();
