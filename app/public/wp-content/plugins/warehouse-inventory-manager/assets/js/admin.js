/**
 * Warehouse Inventory Manager - Admin JavaScript
 * Modern admin interface functionality
 */

(function($) {
    'use strict';

    // Initialize admin functionality
    $(document).ready(function() {
        initializeAdmin();
    });

    function initializeAdmin() {
        // Initialize tabs
        initTabs();
        
        // Initialize forms
        initForms();
        
        // Initialize tables
        initTables();
        
        // Initialize modals
        initModals();
        
        // Initialize notifications
        initNotifications();
    }

    // Tab functionality
    function initTabs() {
        $('.warehouse-tab').on('click', function() {
            const tabId = $(this).data('tab');
            
            // Remove active class from all tabs
            $('.warehouse-tab').removeClass('active');
            $('.warehouse-tab-content').removeClass('active');
            
            // Add active class to clicked tab
            $(this).addClass('active');
            $(`#${tabId}`).addClass('active');
        });
    }

    // Form handling
    function initForms() {
        // Form validation
        $('.warehouse-form').on('submit', function(e) {
            e.preventDefault();
            const form = $(this);
            const formData = new FormData(this);
            
            // Add nonce for security
            formData.append('nonce', warehouse_ajax.nonce);
            
            // Show loading state
            showLoading(form);
            
            // Submit form via AJAX
            $.ajax({
                url: warehouse_ajax.ajax_url,
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    hideLoading(form);
                    
                    if (response.success) {
                        showNotification('success', response.data.message || 'Operation completed successfully');
                        resetForm(form);
                        refreshData();
                    } else {
                        showNotification('error', response.data || 'An error occurred');
                    }
                },
                error: function() {
                    hideLoading(form);
                    showNotification('error', 'Network error. Please try again.');
                }
            });
        });

        // Real-time validation
        $('.warehouse-form-input').on('blur', function() {
            validateField($(this));
        });
    }

    // Table functionality
    function initTables() {
        // Sortable columns
        $('.warehouse-table th[data-sort]').on('click', function() {
            const column = $(this).data('sort');
            const direction = $(this).hasClass('sort-asc') ? 'desc' : 'asc';
            
            sortTable(column, direction);
        });

        // Row actions
        $('.warehouse-table').on('click', '.btn-edit', function() {
            const id = $(this).data('id');
            editItem(id);
        });

        $('.warehouse-table').on('click', '.btn-delete', function() {
            const id = $(this).data('id');
            const name = $(this).data('name');
            confirmDelete(id, name);
        });
    }

    // Modal functionality
    function initModals() {
        // Open modal
        $('.btn-add').on('click', function() {
            openModal('add');
        });

        // Close modal (scoped to plugin modals)
        $('.wh-modal .modal-close, .wh-modal .modal-backdrop').on('click', function() {
            closeModal();
        });

        // Close on escape key
        $(document).on('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });
    }

    // Notification system
    function initNotifications() {
        // Auto-hide notifications after 5 seconds
        setTimeout(function() {
            $('.notification').fadeOut();
        }, 5000);
    }

    // Utility functions
    function showLoading(element) {
        element.addClass('loading');
        element.find('button[type="submit"]').prop('disabled', true);
    }

    function hideLoading(element) {
        element.removeClass('loading');
        element.find('button[type="submit"]').prop('disabled', false);
    }

    function showNotification(type, message) {
        const notification = $(`
            <div class="notification notification-${type}">
                <div class="notification-content">
                    <span class="notification-message">${message}</span>
                    <button class="notification-close">&times;</button>
                </div>
            </div>
        `);

        $('body').append(notification);
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            notification.fadeOut(() => notification.remove());
        }, 5000);
    }

    function resetForm(form) {
        form[0].reset();
        form.find('.error').removeClass('error');
        form.find('.error-message').remove();
    }

    function refreshData() {
        // Refresh table data
        if (typeof refreshTableData === 'function') {
            refreshTableData();
        }
    }

    function validateField(field) {
        const value = field.val().trim();
        const required = field.prop('required');
        
        field.removeClass('error');
        field.next('.error-message').remove();
        
        if (required && !value) {
            showFieldError(field, 'This field is required');
            return false;
        }
        
        // Additional validation rules
        if (field.attr('type') === 'email' && value && !isValidEmail(value)) {
            showFieldError(field, 'Please enter a valid email address');
            return false;
        }
        
        if (field.attr('type') === 'number' && value && isNaN(value)) {
            showFieldError(field, 'Please enter a valid number');
            return false;
        }
        
        return true;
    }

    function showFieldError(field, message) {
        field.addClass('error');
        field.after(`<div class="error-message">${message}</div>`);
    }

    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    function sortTable(column, direction) {
        // Implementation for table sorting
        console.log(`Sorting by ${column} ${direction}`);
    }

    function editItem(id) {
        // Implementation for editing items
        console.log(`Editing item ${id}`);
    }

    function confirmDelete(id, name) {
        if (confirm(`Are you sure you want to delete "${name}"?`)) {
            deleteItem(id);
        }
    }

    function deleteItem(id) {
        $.ajax({
            url: warehouse_ajax.ajax_url,
            type: 'POST',
            data: {
                action: 'delete_inventory_item',
                id: id,
                nonce: warehouse_ajax.nonce
            },
            success: function(response) {
                if (response.success) {
                    showNotification('success', response.data.message || 'Item deleted successfully');
                    refreshData();
                } else {
                    showNotification('error', response.data || 'Failed to delete item');
                }
            },
            error: function() {
                showNotification('error', 'Network error. Please try again.');
            }
        });
    }

    function openModal(type, data = null) {
        const modal = $(`
            <div class="wh-modal">
                <div class="modal-backdrop"></div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">${type === 'add' ? 'Add New Item' : 'Edit Item'}</h3>
                        <button class="modal-close">&times;</button>
                    </div>
                    <div class="modal-body">
                        <!-- Form content will be loaded here -->
                    </div>
                </div>
            </div>
        `);
        
        $('body').append(modal);
        modal.fadeIn();
    }

    function closeModal() {
        $('.wh-modal').fadeOut(() => $('.wh-modal').remove());
    }

    // Enhanced loading states
    function showLoadingState(container, type = 'skeleton') {
        const loadingHtml = type === 'skeleton'
            ? '<div class="skeleton-loader" style="height: 200px;"></div>'
            : '<div class="loading-spinner"></div>';
        
        container.html(loadingHtml);
    }

    function hideLoadingState(container) {
        container.find('.skeleton-loader, .loading-spinner').remove();
    }

    // Enhanced notifications with animations
    function showEnhancedNotification(type, message, duration = 5000) {
        const notification = $(`
            <div class="notification notification-${type} animate-in">
                <div class="notification-content">
                    <div class="notification-icon">
                        ${type === 'success' ? '✅' : type === 'error' ? '❌' : 'ℹ️'}
                    </div>
                    <div class="notification-message">${message}</div>
                    <button class="notification-close">&times;</button>
                </div>
                <div class="notification-progress"></div>
            </div>
        `);

        $('body').append(notification);
        
        // Auto-progress bar
        const progress = notification.find('.notification-progress');
        let width = 100;
        const interval = setInterval(() => {
            width -= (100 / (duration / 100));
            progress.css('width', width + '%');
            if (width <= 0) {
                clearInterval(interval);
                notification.fadeOut(() => notification.remove());
            }
        }, 100);

        // Manual close
        notification.find('.notification-close').on('click', () => {
            clearInterval(interval);
            notification.fadeOut(() => notification.remove());
        });
    }

    // Dark mode support
    function initDarkMode() {
        const themeToggle = $('.theme-toggle');
        if (themeToggle.length) {
            themeToggle.on('click', () => {
                const currentTheme = document.documentElement.getAttribute('data-theme');
                const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
                document.documentElement.setAttribute('data-theme', newTheme);
                localStorage.setItem('warehouse-theme', newTheme);
            });
        }
    }

    // Scroll animations
    function initScrollAnimations() {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        });

        $('.animate-on-scroll').each((_, element) => {
            observer.observe(element);
        });
    }

    // Enhanced table interactions
    function initEnhancedTable() {
        $('.warehouse-table').on('mouseenter', 'tr', function() {
            $(this).addClass('hover-lift');
        }).on('mouseleave', 'tr', function() {
            $(this).removeClass('hover-lift');
        });

        // Keyboard navigation
        $(document).on('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });
    }

    // Real-time search with debouncing
    function initRealTimeSearch() {
        const searchInput = $('.warehouse-search');
        if (searchInput.length) {
            const debouncedSearch = debounce(function() {
                const query = $(this).val();
                performSearch(query);
            }, 300);

            searchInput.on('input', debouncedSearch);
        }
    }

    // Performance optimizations
    function debounce(func, wait) {
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

    function throttle(func, limit) {
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

    // Initialize enhanced features
    function initializeEnhancedFeatures() {
        initDarkMode();
        initScrollAnimations();
        initEnhancedTable();
        initRealTimeSearch();
        
        // Add smooth scrolling
        $('html').css('scroll-behavior', 'smooth');
    }

    // Global functions for external access
    window.WarehouseAdmin = {
        showNotification: showEnhancedNotification,
        refreshData: refreshData,
        openModal: openModal,
        closeModal: closeModal,
        showLoading: showLoadingState,
        hideLoading: hideLoadingState,
        debounce: debounce,
        throttle: throttle
    };

    // Initialize enhanced features after DOM ready
    $(document).ready(() => {
        initializeEnhancedFeatures();
    });

})(jQuery);
