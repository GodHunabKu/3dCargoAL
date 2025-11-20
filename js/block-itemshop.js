document.addEventListener('DOMContentLoaded', function() {
    const shopLinks = document.querySelectorAll('a[href*="shop"], .itemshop-premium a');
    shopLinks.forEach(function(link) {
        link.style.cursor = 'not-allowed';
        link.style.opacity = '0.7';
        link.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            showShopAlert();
            return false;
        });
    });
});
function showShopAlert() {
    const existingAlert = document.querySelector('.shop-blocked-alert');
    if (existingAlert) {
        existingAlert.remove();
    }
    const alert = document.createElement('div');
    alert.className = 'alert-modern alert-warning shop-blocked-alert';
    alert.innerHTML = `
        <div class="alert-icon">
            <i class="fas fa-hourglass-half"></i>
        </div>
        <div class="alert-content">
            <strong>Item-Shop Non Disponibile</strong>
            <p>L'Item-Shop sarà disponibile poche ore prima dello start del server!</p>
            <small style="color: #856404; margin-top: 5px; display: block;">Resta sintonizzato per l'apertura ufficiale 🎮</small>
        </div>
        <button type="button" class="alert-close" onclick="this.parentElement.remove()">
            <i class="fas fa-times"></i>
        </button>
    `;
    document.body.appendChild(alert);
    setTimeout(function() {
        if (alert.parentNode) {
            alert.style.animation = 'alertSlideOut 0.5s ease';
            setTimeout(function() {
                alert.remove();
            }, 500);
        }
    }, 5000);
}
const style = document.createElement('style');
style.textContent = `
@keyframes alertSlideOut {
    from {
        opacity: 1;
        transform: translateX(-50%) translateY(0) scale(1);
    }
    to {
        opacity: 0;
        transform: translateX(-50%) translateY(-30px) scale(0.9);
    }
}
`;
document.head.appendChild(style);
