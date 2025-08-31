/**
 * Advanced Loading Manager for Warehouse Inventory System
 * Handles loading states, skeleton screens, and progress indicators
 */

(function() {
    'use strict';

    class LoadingManager {
        constructor() {
            this.activeLoaders = new Set();
            this.init();
        }

        init() {
            this.createGlobalStyles();
            this.setupGlobalLoadingOverlay();
        }

        createGlobalStyles() {
            const style = document.createElement('style');
            style.textContent = `
                .loading-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: hsl(var(--background) / 0.8);
                    backdrop-filter: blur(4px);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    z-index: 9999;
                    opacity: 0;
                    visibility: hidden;
                    transition: all 0.3s ease;
                }

                .loading-overlay.active {
                    opacity: 1;
                    visibility: visible;
                }

                .loading-spinner {
                    width: 3rem;
                    height: 3rem;
                    border: 3px solid hsl(var(--border));
                    border-top: 3px solid hsl(var(--primary));
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                }

                .loading-dots {
                    display: flex;
                    gap: 0.5rem;
                }

                .loading-dots div {
                    width: 0.75rem;
                    height: 0.75rem;
                    background: hsl(var(--primary));
                    border-radius: 50%;
                    animation: bounce 1.4s infinite ease-in-out both;
                }

                .loading-dots div:nth-child(1) { animation-delay: -0.32s; }
                .loading-dots div:nth-child(2) { animation-delay: -0.16s; }
                .loading-dots div:nth-child(3) { animation-delay: 0s; }

                @keyframes spin {
                    0% { transform: rotate(0deg); }
                    100% { transform: rotate(360deg); }
                }

                @keyframes bounce {
                    0%, 80%, 100% {
                        transform: scale(0);
                    }
                    40% {
                        transform: scale(1);
                    }
                }

                .skeleton {
                    background: linear-gradient(
                        90deg,
                        hsl(var(--muted)) 25%,
                        hsl(var(--muted) / 0.5) 50%,
                        hsl(var(--muted)) 75%
                    );
                    background-size: 200% 100%;
                    animation: shimmer 1.5s infinite;
                    border-radius: var(--radius);
                }

                @keyframes shimmer {
                    0% { background-position: -200% 0; }
                    100% { background-position: 200% 0; }
                }

                .skeleton-text {
                    height: 1rem;
                    margin-bottom: 0.5rem;
                    border-radius: 0.25rem;
                }

                .skeleton-card {
                    height: 200px;
                    margin-bottom: 1rem;
                }

                .progress-bar {
                    height: 0.25rem;
                    background: hsl(var(--muted));
                    border-radius: 9999px;
                    overflow: hidden;
                }

                .progress-fill {
                    height: 100%;
                    background: linear-gradient(90deg, hsl(var(--primary)), hsl(var(--primary) / 0.8));
                    border-radius: 9999px;
                    transition: width 0.3s ease;
                    animation: shimmer 2s infinite;
                }
            `;
            document.head.appendChild(style);
        }

        setupGlobalLoadingOverlay() {
            const overlay = document.createElement('div');
            overlay.className = 'loading-overlay';
            overlay.innerHTML = `
                <div class="loading-content">
                    <div class="loading-dots">
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                    <p class="loading-text" style="margin-top: 1rem; color: hsl(var(--foreground));">
                        Loading...
                    </p>
                </div>
            `;
            document.body.appendChild(overlay);
            this.globalOverlay = overlay;
        }

        showGlobalLoading(text = 'Loading...') {
            const textElement = this.globalOverlay.querySelector('.loading-text');
            if (textElement) {
                textElement.textContent = text;
            }
            this.globalOverlay.classList.add('active');
        }

        hideGlobalLoading() {
            this.globalOverlay.classList.remove('active');
        }

        createSkeleton(type, count = 1) {
            const skeletons = [];
            for (let i = 0; i < count; i++) {
                const skeleton = document.createElement('div');
                skeleton.className = `skeleton skeleton-${type}`;
                
                switch (type) {
                    case 'text':
                        skeleton.style.height = '1rem';
                        skeleton.style.marginBottom = '0.5rem';
                        skeleton.style.width = Math.random() > 0.5 ? '100%' : `${60 + Math.random() * 40}%`;
                        break;
                    case 'card':
                        skeleton.style.height = '200px';
                        skeleton.style.marginBottom = '1rem';
                        break;
                    case 'avatar':
                        skeleton.style.width = '2.5rem';
                        skeleton.style.height = '2.5rem';
                        skeleton.style.borderRadius = '50%';
                        break;
                    case 'button':
                        skeleton.style.height = '2.5rem';
                        skeleton.style.width = '120px';
                        break;
                    case 'table-row':
                        skeleton.style.height = '3rem';
                        skeleton.style.marginBottom = '0.5rem';
                        break;
                }
                
                skeletons.push(skeleton);
            }
            return skeletons;
        }

        showSkeleton(container, type, count = 3) {
            container.innerHTML = '';
            const skeletons = this.createSkeleton(type, count);
            skeletons.forEach(skeleton => container.appendChild(skeleton));
            return skeletons;
        }

        hideSkeleton(container) {
            const skeletons = container.querySelectorAll('.skeleton');
            skeletons.forEach(skeleton => skeleton.remove());
        }

        createProgressBar() {
            const container = document.createElement('div');
            container.className = 'progress-bar';
            container.innerHTML = '<div class="progress-fill" style="width: 0%"></div>';
            return container;
        }

        updateProgress(progressBar, percentage) {
            const fill = progressBar.querySelector('.progress-fill');
            if (fill) {
                fill.style.width = `${Math.min(100, Math.max(0, percentage))}%`;
            }
        }

        showInlineLoading(element, text = 'Loading...') {
            const originalContent = element.innerHTML;
            element.innerHTML = `
                <div class="inline-loading" style="display: flex; align-items: center; gap: 0.5rem;">
                    <div class="loading-spinner" style="width: 1rem; height: 1rem; border-width: 2px;"></div>
                    <span>${text}</span>
                </div>
            `;
            
            return () => {
                element.innerHTML = originalContent;
            };
        }

        createToast(message, type = 'info', duration = 3000) {
            const toast = document.createElement('div');
            toast.className = `toast toast-${type}`;
            toast.style.cssText = `
                position: fixed;
                top: 1rem;
                right: 1rem;
                z-index: 1000;
                max-width: 420px;
                border-radius: var(--radius);
                border: 1px solid hsl(var(--border));
                background-color: hsl(var(--background));
                color: hsl(var(--foreground));
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                padding: 1rem;
                animation: slide-in-right 0.3s ease-out;
            `;
            
            const icon = type === 'success' ? '✅' : type === 'error' ? '❌' : type === 'warning' ? '⚠️' : 'ℹ️';
            toast.innerHTML = `
                <div style="display: flex; align-items: center; gap: 0.75rem;">
                    <span>${icon}</span>
                    <span>${message}</span>
                    <button onclick="this.parentElement.parentElement.remove()" style="margin-left: auto; background: none; border: none; cursor: pointer; font-size: 1.2rem;">×</button>
                </div>
            `;
            
            document.body.appendChild(toast);
            
            setTimeout(() => {
                if (toast.parentElement) {
                    toast.style.animation = 'slide-in-right 0.3s ease-out reverse';
                    setTimeout(() => toast.remove(), 300);
                }
            }, duration);
            
            return toast;
        }

        // AJAX wrapper with loading states
        async fetchWithLoading(url, options = {}) {
            const loadingId = Date.now();
            this.activeLoaders.add(loadingId);
            
            try {
                this.showGlobalLoading();
                const response = await fetch(url, options);
                return await response.json();
            } finally {
                this.activeLoaders.delete(loadingId);
                if (this.activeLoaders.size === 0) {
                    this.hideGlobalLoading();
                }
            }
        }

        // Utility methods
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
        }

        throttle(func, limit) {
            let inThrottle;
            return function() {
                const args = arguments;
                const context = this;
                if (!inThrottle) {
                    func.apply(context, args);
                    inThrottle = true;
                    setTimeout(() => inThrottle = false, limit);
                }
            };
        }
    }

    // Initialize loading manager
    const loadingManager = new LoadingManager();
    
    // Make it globally available
    window.WarehouseLoading = loadingManager;
    
    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slide-in-right {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    `;
    document.head.appendChild(style);
})();