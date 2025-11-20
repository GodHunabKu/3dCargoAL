(function() {
    'use strict';
    const CONFIG = {
        particles: {
            count: 0,
            colors: ['#FFD700', '#FFA500', '#FFED4E', '#B8860B'],
            speed: { min: 1, max: 3 },
            size: { min: 2, max: 6 }
        },
        parallax: {
            enabled: false,
            intensity: 0.05
        },
        animations: {
            duration: 600,
            easing: 'cubic-bezier(0.34, 1.56, 0.64, 1)'
        }
    };
    class PremiumParticleSystem {
        constructor() {
            this.canvas = null;
            this.ctx = null;
            this.particles = [];
            this.animationId = null;
            this.mouseX = 0;
            this.mouseY = 0;
        }
        init() {
            if (!document.querySelector('.hero-section')) return;
            this.createCanvas();
            this.createParticles();
            this.animate();
            this.addEventListeners();
        }
        createCanvas() {
            this.canvas = document.createElement('canvas');
            this.canvas.className = 'particles-canvas';
            this.canvas.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
                opacity: 0.6;
            `;
            const heroSection = document.querySelector('.hero-section');
            if (heroSection) {
                heroSection.style.position = 'relative';
                heroSection.insertBefore(this.canvas, heroSection.firstChild);
            }
            this.ctx = this.canvas.getContext('2d');
            this.resize();
        }
        resize() {
            if (!this.canvas) return;
            this.canvas.width = window.innerWidth;
            this.canvas.height = window.innerHeight;
        }
        createParticles() {
            for (let i = 0; i < CONFIG.particles.count; i++) {
                this.particles.push({
                    x: Math.random() * this.canvas.width,
                    y: Math.random() * this.canvas.height,
                    size: Math.random() * (CONFIG.particles.size.max - CONFIG.particles.size.min) + CONFIG.particles.size.min,
                    speedX: (Math.random() - 0.5) * 0.5,
                    speedY: -(Math.random() * (CONFIG.particles.speed.max - CONFIG.particles.speed.min) + CONFIG.particles.speed.min),
                    color: CONFIG.particles.colors[Math.floor(Math.random() * CONFIG.particles.colors.length)],
                    opacity: Math.random() * 0.5 + 0.3,
                    pulseSpeed: Math.random() * 0.02 + 0.01,
                    pulsePhase: Math.random() * Math.PI * 2
                });
            }
        }
        animate() {
            if (!this.ctx || !this.canvas) return;
            this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
            this.particles.forEach((particle, index) => {
                particle.y += particle.speedY;
                particle.x += particle.speedX;
                const dx = this.mouseX - particle.x;
                const dy = this.mouseY - particle.y;
                const distance = Math.sqrt(dx * dx + dy * dy);
                if (distance < 100) {
                    const force = (100 - distance) / 100;
                    particle.x -= dx * force * 0.01;
                    particle.y -= dy * force * 0.01;
                }
                if (particle.y < -10) {
                    particle.y = this.canvas.height + 10;
                    particle.x = Math.random() * this.canvas.width;
                }
                if (particle.x < -10 || particle.x > this.canvas.width + 10) {
                    particle.x = Math.random() * this.canvas.width;
                }
                particle.pulsePhase += particle.pulseSpeed;
                const pulse = Math.sin(particle.pulsePhase) * 0.3 + 0.7;
                this.ctx.save();
                const gradient = this.ctx.createRadialGradient(
                    particle.x, particle.y, 0,
                    particle.x, particle.y, particle.size * 3
                );
                gradient.addColorStop(0, particle.color + Math.floor(particle.opacity * pulse * 255).toString(16).padStart(2, '0'));
                gradient.addColorStop(0.5, particle.color + '40');
                gradient.addColorStop(1, particle.color + '00');
                this.ctx.fillStyle = gradient;
                this.ctx.beginPath();
                this.ctx.arc(particle.x, particle.y, particle.size * 3, 0, Math.PI * 2);
                this.ctx.fill();
                this.ctx.fillStyle = particle.color;
                this.ctx.globalAlpha = particle.opacity * pulse;
                this.ctx.beginPath();
                this.ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2);
                this.ctx.fill();
                this.ctx.restore();
            });
            this.animationId = requestAnimationFrame(() => this.animate());
        }
        addEventListeners() {
            window.addEventListener('resize', () => this.resize());
            document.addEventListener('mousemove', (e) => {
                this.mouseX = e.clientX;
                this.mouseY = e.clientY;
            });
        }
        destroy() {
            if (this.animationId) {
                cancelAnimationFrame(this.animationId);
            }
            if (this.canvas && this.canvas.parentNode) {
                this.canvas.parentNode.removeChild(this.canvas);
            }
        }
    }
    class Parallax3D {
        constructor() {
            this.elements = [];
            this.mouseX = 0;
            this.mouseY = 0;
            this.targetX = 0;
            this.targetY = 0;
        }
        init() {
            if (!CONFIG.parallax.enabled) return;
            this.elements = [
                { el: document.querySelector('.hero-logo'), depth: 20 },
                { el: document.querySelectorAll('.stat-box'), depth: 15 },
                { el: document.querySelectorAll('.content-box'), depth: 10 }
            ];
            this.addEventListeners();
            this.animate();
        }
        addEventListeners() {
            document.addEventListener('mousemove', (e) => {
                const centerX = window.innerWidth / 2;
                const centerY = window.innerHeight / 2;
                this.targetX = (e.clientX - centerX) / centerX;
                this.targetY = (e.clientY - centerY) / centerY;
            });
        }
        animate() {
            this.mouseX += (this.targetX - this.mouseX) * 0.1;
            this.mouseY += (this.targetY - this.mouseY) * 0.1;
            this.elements.forEach(item => {
                if (!item.el) return;
                const elements = item.el instanceof NodeList ? item.el : [item.el];
                elements.forEach(el => {
                    if (el) {
                        const x = this.mouseX * item.depth * CONFIG.parallax.intensity;
                        const y = this.mouseY * item.depth * CONFIG.parallax.intensity;
                        el.style.transform = `translate3d(${x}px, ${y}px, 0) perspective(1000px)`;
                    }
                });
            });
            requestAnimationFrame(() => this.animate());
        }
    }
    class AnimatedCounter {
        static init() {
            const counters = document.querySelectorAll('.stat-info h4');
            counters.forEach(counter => {
                const target = parseInt(counter.textContent.replace(/\D/g, ''));
                if (isNaN(target)) return;
                let current = 0;
                const increment = target / 60;
                const duration = 2000;
                const frameTime = duration / 60;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    counter.textContent = Math.floor(current).toLocaleString();
                }, frameTime);
            });
        }
    }
    class SmoothScrollEnhanced {
        static init() {
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (href === '#') return;
                    const target = document.querySelector(href);
                    if (target) {
                        e.preventDefault();
                        const headerOffset = 100;
                        const elementPosition = target.getBoundingClientRect().top;
                        const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                        window.scrollTo({
                            top: offsetPosition,
                            behavior: 'smooth'
                        });
                    }
                });
            });
        }
    }
    class ScrollReveal {
        static init() {
            return;
        }
    }
    class VideoLazyLoad {
        static init() {
            const videoWrapper = document.querySelector('.video-wrapper');
            if (!videoWrapper) return;
            const iframe = videoWrapper.querySelector('iframe');
            if (!iframe) return;
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        if (!iframe.src) {
                            iframe.src = iframe.getAttribute('data-src') || iframe.src;
                        }
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.25 });
            observer.observe(videoWrapper);
        }
    }
    class MicroInteractions {
        static init() {
            return;
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                ripple.classList.add('ripple-effect');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(255, 255, 255, 0.5);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s ease-out;
                    pointer-events: none;
                `;
                this.appendChild(ripple);
                setTimeout(() => ripple.remove(), 600);
            });
            document.querySelectorAll('.stat-box').forEach(box => {
                box.addEventListener('mouseenter', function() {
                    const icon = this.querySelector('.stat-icon i');
                    if (icon) {
                        icon.style.animation = 'none';
                        setTimeout(() => {
                            icon.style.animation = 'iconRotate3D 0.6s ease-in-out';
                        }, 10);
                    }
                });
            });
        }
    }
    class PerformanceMonitor {
        static init() {
            const connection = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
            if (connection && connection.effectiveType === 'slow-2g') {
                document.documentElement.classList.add('reduce-animations');
            }
            if (window.innerWidth < 768) {
                CONFIG.particles.count = 20;
            }
        }
    }
    class KeyboardNav {
        static init() {
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') {
                    document.querySelectorAll('.modal.active').forEach(modal => {
                        modal.classList.remove('active');
                    });
                }
                if (e.key === 'PageDown' || e.key === 'PageUp') {
                    e.preventDefault();
                    const delta = e.key === 'PageDown' ? 600 : -600;
                    window.scrollBy({ top: delta, behavior: 'smooth' });
                }
            });
        }
    }
    function initHomepagePremium() {
        if (!document.querySelector('.hero-section')) return;
        PerformanceMonitor.init();
        const particleSystem = new PremiumParticleSystem();
        particleSystem.init();
        const parallax = new Parallax3D();
        parallax.init();
        setTimeout(() => AnimatedCounter.init(), 500);
        ScrollReveal.init();
        SmoothScrollEnhanced.init();
        VideoLazyLoad.init();
        MicroInteractions.init();
        KeyboardNav.init();
    }
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initHomepagePremium);
    } else {
        initHomepagePremium();
    }
    if (!document.getElementById('ripple-styles')) {
        const style = document.createElement('style');
        style.id = 'ripple-styles';
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
            .cta-button {
                position: relative;
                overflow: hidden;
            }
        `;
        document.head.appendChild(style);
    }
})();
