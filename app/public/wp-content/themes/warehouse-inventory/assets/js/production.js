/**
 * Production Optimizations for Warehouse Inventory System
 * Performance monitoring, security, and deployment utilities
 */

(function() {
    'use strict';

    class ProductionManager {
        constructor() {
            this.init();
        }

        init() {
            this.setupPerformanceMonitoring();
            this.setupSecurityFeatures();
            this.setupErrorHandling();
            this.setupServiceWorker();
            this.setupOfflineSupport();
        }

        // Performance monitoring
        setupPerformanceMonitoring() {
            if ('performance' in window) {
                window.addEventListener('load', () => {
                    this.measurePerformance();
                });
            }
        }

        measurePerformance() {
            const perfData = {
                loadTime: performance.timing.loadEventEnd - performance.timing.navigationStart,
                domContentLoaded: performance.timing.domContentLoadedEventEnd - performance.timing.navigationStart,
                firstPaint: this.getFirstPaint(),
                firstContentfulPaint: this.getFirstContentfulPaint()
            };

            // Log performance metrics
            console.log('Performance Metrics:', perfData);
            
            // Send to analytics if available
            if (window.gtag) {
                gtag('event', 'performance_metrics', perfData);
            }
        }

        getFirstPaint() {
            try {
                const paintEntries = performance.getEntriesByType('paint');
                const firstPaint = paintEntries.find(entry => entry.name === 'first-paint');
                return firstPaint ? firstPaint.startTime : null;
            } catch (e) {
                return null;
            }
        }

        getFirstContentfulPaint() {
            try {
                const paintEntries = performance.getEntriesByType('paint');
                const fcp = paintEntries.find(entry => entry.name === 'first-contentful-paint');
                return fcp ? fcp.startTime : null;
            } catch (e) {
                return null;
            }
        }

        // Security features
        setupSecurityFeatures() {
            this.setupCSRFProtection();
            this.setupInputValidation();
            this.setupXSSProtection();
        }

        setupCSRFProtection() {
            // Add CSRF token to all AJAX requests
            const originalFetch = window.fetch;
            window.fetch = function(...args) {
                const [url, options = {}] = args;
                if (typeof url === 'string' && url.includes('wp-admin/admin-ajax.php')) {
                    const formData = new FormData();
                    formData.append('_wpnonce', window.warehouse_ajax?.nonce || '');
                    
                    if (options.body instanceof FormData) {
                        options.body.append('_wpnonce', window.warehouse_ajax?.nonce || '');
                    } else {
                        options.headers = options.headers || {};
                        options.headers['X-WP-Nonce'] = window.warehouse_ajax?.nonce || '';
                    }
                }
                return originalFetch.apply(this, args);
            };
        }

        setupInputValidation() {
            // Real-time input validation
            document.addEventListener('input', (e) => {
                if (e.target.matches('[data-validate]')) {
                    this.validateInput(e.target);
                }
            });
        }

        validateInput(input) {
            const type = input.dataset.validate;
            const value = input.value;
            let isValid = true;
            let errorMessage = '';

            switch (type) {
                case 'email':
                    isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
                    errorMessage = 'Please enter a valid email address';
                    break;
                case 'number':
                    isValid = !isNaN(value) && value !== '';
                    errorMessage = 'Please enter a valid number';
                    break;
                case 'required':
                    isValid = value.trim() !== '';
                    errorMessage = 'This field is required';
                    break;
                case 'price':
                    isValid = /^\d+(\.\d{1,2})?$/.test(value);
                    errorMessage = 'Please enter a valid price';
                    break;
            }

            this.showValidationResult(input, isValid, errorMessage);
        }

        showValidationResult(input, isValid, errorMessage) {
            const formGroup = input.closest('.form-group');
            if (!formGroup) return;

            const errorElement = formGroup.querySelector('.validation-error');
            
            if (isValid) {
                input.classList.remove('error');
                input.classList.add('success');
                errorElement?.remove();
            } else {
                input.classList.remove('success');
                input.classList.add('error');
                
                if (!errorElement) {
                    const error = document.createElement('div');
                    error.className = 'validation-error';
                    error.textContent = errorMessage;
                    formGroup.appendChild(error);
                } else {
                    errorElement.textContent = errorMessage;
                }
            }
        }

        setupXSSProtection() {
            // Sanitize HTML content
            window.sanitizeHTML = (html) => {
                const div = document.createElement('div');
                div.textContent = html;
                return div.innerHTML;
            };

            // Prevent inline scripts
            document.addEventListener('DOMContentLoaded', () => {
                const scripts = document.querySelectorAll('script:not([src])');
                scripts.forEach(script => {
                    if (script.textContent.includes('eval(') || script.textContent.includes('innerHTML')) {
                        console.warn('Potentially unsafe script detected:', script);
                    }
                });
            });
        }

        // Error handling
        setupErrorHandling() {
            window.addEventListener('error', (event) => {
                this.logError({
                    message: event.message,
                    filename: event.filename,
                    lineno: event.lineno,
                    colno: event.colno,
                    stack: event.error?.stack
                });
            });

            window.addEventListener('unhandledrejection', (event) => {
                this.logError({
                    message: 'Unhandled promise rejection',
                    reason: event.reason
                });
            });
        }

        logError(error) {
            console.error('Production Error:', error);
            
            // Send to server if available
            if (window.warehouse_ajax) {
                fetch(window.warehouse_ajax.ajax_url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams({
                        action: 'log_error',
                        nonce: window.warehouse_ajax.nonce,
                        error: JSON.stringify(error)
                    })
                });
            }
        }

        // Service worker setup
        setupServiceWorker() {
            if ('serviceWorker' in navigator) {
                navigator.serviceWorker.register('/wp-content/themes/warehouse-inventory/sw.js')
                    .then(registration => {
                        console.log('Service Worker registered:', registration);
                    })
                    .catch(error => {
                        console.log('Service Worker registration failed:', error);
                    });
            }
        }

        // Offline support
        setupOfflineSupport() {
            if ('caches' in window) {
                this.setupOfflineCache();
            }
        }

        setupOfflineCache() {
            const cacheName = 'warehouse-v1';
            const urlsToCache = [
                '/',
                '/wp-content/themes/warehouse-inventory/assets/css/production.css',
                '/wp-content/themes/warehouse-inventory/assets/js/production.js',
                '/wp-content/plugins/warehouse-inventory-manager/assets/css/frontend.css',
                '/wp-content/plugins/warehouse-inventory-manager/assets/js/frontend.js'
            ];

            // Cache critical resources
            caches.open(cacheName).then(cache => {
                return cache.addAll(urlsToCache);
            });
        }

        // Utility functions
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

        // Security scanner
        scanSecurity() {
            const issues = [];
            
            // Check for HTTPS
            if (location.protocol !== 'https:') {
                issues.push('Site is not using HTTPS');
            }
            
            // Check for CSP
            if (!document.querySelector('meta[http-equiv="Content-Security-Policy"]')) {
                issues.push('Content Security Policy not found');
            }
            
            // Check for secure cookies
            const cookies = document.cookie;
            if (cookies && !cookies.includes('Secure')) {
                issues.push('Cookies may not be secure');
            }
            
            return issues;
        }

        // Performance report
        generatePerformanceReport() {
            const report = {
                timestamp: new Date().toISOString(),
                url: window.location.href,
                userAgent: navigator.userAgent,
                performance: this.getPerformanceMetrics(),
                security: this.scanSecurity()
            };
            
            return report;
        }

        getPerformanceMetrics() {
            if (!('performance' in window)) return null;
            
            const navigation = performance.getEntriesByType('navigation')[0];
            return {
                loadTime: navigation.loadEventEnd - navigation.loadEventStart,
                domContentLoaded: navigation.domContentLoadedEventEnd - navigation.domContentLoadedEventStart,
                firstPaint: this.getFirstPaint(),
                firstContentfulPaint: this.getFirstContentfulPaint()
            };
        }
    }

    // Initialize production manager
    const productionManager = new ProductionManager();
    
    // Make available globally
    window.WarehouseProduction = productionManager;
    
    // Auto-initialize on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => productionManager.init());
    } else {
        productionManager.init();
    }
})();