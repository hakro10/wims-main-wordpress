/**
 * Dark Mode Theme Toggle for Warehouse Inventory System
 * Advanced theme switching with system preference detection
 */

(function() {
    'use strict';

    class ThemeManager {
        constructor() {
            this.theme = this.getStoredTheme() || this.getSystemTheme();
            this.init();
        }

        init() {
            this.createToggleButton();
            this.applyTheme(this.theme);
            this.setupSystemThemeListener();
        }

        getStoredTheme() {
            return localStorage.getItem('warehouse-theme');
        }

        getSystemTheme() {
            return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        }

        setStoredTheme(theme) {
            localStorage.setItem('warehouse-theme', theme);
        }

        applyTheme(theme) {
            this.theme = theme;
            document.documentElement.setAttribute('data-theme', theme);
            this.updateToggleButton(theme);
            this.setStoredTheme(theme);
            
            // Dispatch custom event for other components
            window.dispatchEvent(new CustomEvent('themeChanged', { detail: { theme } }));
        }

        createToggleButton() {
            const button = document.createElement('button');
            button.className = 'theme-toggle';
            button.setAttribute('aria-label', 'Toggle theme');
            button.innerHTML = `
                <svg class="theme-icon theme-icon-light" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="5"></circle>
                    <line x1="12" y1="1" x2="12" y2="3"></line>
                    <line x1="12" y1="21" x2="12" y2="23"></line>
                    <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                    <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                    <line x1="1" y1="12" x2="3" y2="12"></line>
                    <line x1="21" y1="12" x2="23" y2="12"></line>
                    <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                    <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                </svg>
                <svg class="theme-icon theme-icon-dark" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                </svg>
            `;
            
            button.addEventListener('click', () => this.toggleTheme());
            // Prefer mounting inside header slot if available
            const slot = document.getElementById('theme-toggle-slot') || document.getElementById('theme-toggle-slot-guest');
            if (slot) {
                slot.parentNode.insertBefore(button, slot.nextSibling);
            } else {
                document.body.appendChild(button);
            }
            this.themeToggle = button;
        }

        updateToggleButton(theme) {
            if (!this.themeToggle) return;
            
            const lightIcon = this.themeToggle.querySelector('.theme-icon-light');
            const darkIcon = this.themeToggle.querySelector('.theme-icon-dark');
            
            if (theme === 'dark') {
                lightIcon.style.display = 'none';
                darkIcon.style.display = 'block';
            } else {
                lightIcon.style.display = 'block';
                darkIcon.style.display = 'none';
            }
        }

        toggleTheme() {
            const newTheme = this.theme === 'light' ? 'dark' : 'light';
            this.applyTheme(newTheme);
            
            // Add smooth transition effect
            document.documentElement.style.transition = 'color-scheme 0.3s ease';
            setTimeout(() => {
                document.documentElement.style.transition = '';
            }, 300);
        }

        setupSystemThemeListener() {
            const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
            mediaQuery.addEventListener('change', (e) => {
                if (!this.getStoredTheme()) {
                    this.applyTheme(e.matches ? 'dark' : 'light');
                }
            });
        }

        // Public API
        getCurrentTheme() {
            return this.theme;
        }

        setTheme(theme) {
            this.applyTheme(theme);
        }
    }

    // Initialize theme manager
    const themeManager = new ThemeManager();
    
    // Make it globally available
    window.WarehouseTheme = themeManager;
})();
