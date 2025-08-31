/**
 * Warehouse Inventory Manager - Frontend JavaScript
 * Modern frontend interface functionality
 */

(function($) {
    'use strict';

    // Initialize frontend functionality
    $(document).ready(function() {
        initializeFrontend();
    });

    function initializeFrontend() {
        // Initialize inventory grid
        initInventoryGrid();
        
        // Initialize filters
        initFilters();
        
        // Initialize search
        initSearch();
        
        // Initialize pagination
        initPagination();
        
        // Initialize modals
        initModals();
        
        // Initialize cart
        initCart();
    }

    // Inventory grid functionality
    function initInventoryGrid() {
        loadInventoryItems();
        
        // Infinite scroll
        $(window).on('scroll', function() {
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                loadMoreItems();
            }
        });
    }

    // Filter functionality
    function initFilters() {
        $('.warehouse-filter-select').on('change', function() {
            applyFilters();
        });

        $('.warehouse-filter-input').on('input', function() {
            debounce(applyFilters, 300)();
        });

        $('.warehouse-clear-filters').on('click', function() {
            clearFilters();
        });
    }

    // Search functionality
    function initSearch() {
        $('.warehouse-search-form').on('submit', function(e) {
            e.preventDefault();
            performSearch();
        });

        $('.warehouse-search-input').on('input', function() {
            debounce(performSearch, 500)();
        });
    }

    // Pagination
    function initPagination() {
        $('.warehouse-pagination').on('click', '.page-link', function(e) {
            e.preventDefault();
            const page = $(this).data('page');
            goToPage(page);
        });
    }

    // Modal functionality
    function initModals() {
        // Item detail modal
        $('.warehouse-grid').on('click', '.warehouse-item', function(e) {
            if (!$(e.target).closest('.btn').length) {
                const itemId = $(this).data('id');
                openItemModal(itemId);
            }
        });

        // Close modals (scoped to plugin modals)
        $(document).on('click', '.wh-modal .modal-close, .wh-modal .modal-backdrop', function() {
            closeModals();
        });

        $(document).on('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModals();
            }
        });
    }

    // Cart functionality
    function initCart() {
        // Add to cart
        $('.warehouse-grid').on('click', '.btn-add-to-cart', function() {
            const itemId = $(this).data('id');
            const quantity = 1;
            addToCart(itemId, quantity);
        });

        // Update cart
        $(document).on('click', '.btn-update-cart', function() {
            updateCart();
        });

        // Remove from cart
        $(document).on('click', '.btn-remove-from-cart', function() {
            const itemId = $(this).data('id');
            removeFromCart(itemId);
        });
    }

    // Load inventory items
    function loadInventoryItems(page = 1) {
        const container = $('.warehouse-grid');
        const loading = $('.warehouse-loading');
        
        loading.show();
        
        $.ajax({
            url: warehouse_ajax.ajax_url,
            type: 'POST',
            data: {
                action: 'get_inventory_items',
                nonce: warehouse_ajax.nonce,
                page: page,
                per_page: 12
            },
            success: function(response) {
                loading.hide();
                
                if (response.success) {
                    renderInventoryItems(response.data.items);
                    renderPagination(response.data.total, response.data.current_page);
                } else {
                    showError('Failed to load inventory items');
                }
            },
            error: function() {
                loading.hide();
                showError('Network error. Please try again.');
            }
        });
    }

    // Render inventory items
    function renderInventoryItems(items) {
        const container = $('.warehouse-grid');
        
        if (items.length === 0) {
            container.html(`
                <div class="warehouse-empty">
                    <i class="fas fa-boxes"></i>
                    <h3>No items found</h3>
                    <p>Try adjusting your filters or search terms</p>
                </div>
            `);
            return;
        }
        
        const html = items.map(item => `
            <div class="warehouse-item" data-id="${item.id}">
                <div class="warehouse-item-image">
                    ${item.image_url ? 
                        `<img src="${item.image_url}" alt="${item.name}" style="width: 100%; height: 100%; object-fit: cover;">` : 
                        '<i class="fas fa-box" style="font-size: 3rem;"></i>'
                    }
                </div>
                <div class="warehouse-item-content">
                    <h3 class="warehouse-item-title">${item.name}</h3>
                    <p class="warehouse-item-description">${item.description || 'No description available'}</p>
                    <div class="warehouse-item-meta">
                        <span class="warehouse-item-price">$${parseFloat(item.selling_price || 0).toFixed(2)}</span>
                        <span class="warehouse-item-stock ${getStockClass(item.quantity, item.min_stock_level)}">
                            ${getStockText(item.quantity, item.min_stock_level)}
                        </span>
                    </div>
                    <div class="warehouse-item-actions">
                        <button class="btn btn-primary btn-sm btn-add-to-cart" data-id="${item.id}">
                            <i class="fas fa-shopping-cart"></i> Add to Cart
                        </button>
                        <button class="btn btn-outline btn-sm btn-view-details" data-id="${item.id}">
                            <i class="fas fa-eye"></i> Details
                        </button>
                    </div>
                </div>
            </div>
        `).join('');
        
        container.html(html);
    }

    // Get stock class
    function getStockClass(quantity, minStock) {
        if (quantity <= 0) return 'out-of-stock';
        if (quantity <= minStock) return 'low-stock';
        return 'in-stock';
    }

    // Get stock text
    function getStockText(quantity, minStock) {
        if (quantity <= 0) return 'Out of Stock';
        if (quantity <= minStock) return `${quantity} left`;
        return 'In Stock';
    }

    // Apply filters
    function applyFilters() {
        const filters = {
            category: $('.warehouse-filter-category').val(),
            location: $('.warehouse-filter-location').val(),
            status: $('.warehouse-filter-status').val(),
            search: $('.warehouse-search-input').val()
        };
        
        loadInventoryItems(1, filters);
    }

    // Clear filters
    function clearFilters() {
        $('.warehouse-filter-select').val('');
        $('.warehouse-search-input').val('');
        loadInventoryItems(1);
    }

    // Perform search
    function performSearch() {
        const searchTerm = $('.warehouse-search-input').val();
        loadInventoryItems(1, { search: searchTerm });
    }

    // Pagination
    function goToPage(page) {
        loadInventoryItems(page);
        $('html, body').animate({ scrollTop: 0 }, 300);
    }

    // Load more items (infinite scroll)
    function loadMoreItems() {
        const currentPage = parseInt($('.warehouse-pagination').data('current-page') || 1);
        const totalPages = parseInt($('.warehouse-pagination').data('total-pages') || 1);
        
        if (currentPage < totalPages) {
            loadInventoryItems(currentPage + 1);
        }
    }

    // Item modal
    function openItemModal(itemId) {
        $.ajax({
            url: warehouse_ajax.ajax_url,
            type: 'POST',
            data: {
                action: 'get_inventory_item',
                id: itemId,
                nonce: warehouse_ajax.nonce
            },
            success: function(response) {
                if (response.success) {
                    renderItemModal(response.data);
                } else {
                    showError('Failed to load item details');
                }
            },
            error: function() {
                showError('Network error. Please try again.');
            }
        });
    }

    // Render item modal
    function renderItemModal(item) {
        const modal = $(`
            <div class="wh-modal">
                <div class="modal-backdrop"></div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h3>${item.name}</h3>
                        <button class="modal-close">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="item-details">
                            ${item.image_url ? `<img src="${item.image_url}" alt="${item.name}" style="max-width: 100%; height: auto; margin-bottom: 1rem;">` : ''}
                            <p><strong>Description:</strong> ${item.description || 'No description available'}</p>
                            <p><strong>Price:</strong> $${parseFloat(item.selling_price || 0).toFixed(2)}</p>
                            <p><strong>Stock:</strong> ${item.quantity} available</p>
                            <p><strong>Location:</strong> ${item.location_name || 'N/A'}</p>
                            <p><strong>Category:</strong> ${item.category_name || 'N/A'}</p>
                        </div>
                        <div class="modal-actions">
                            <button class="btn btn-primary btn-add-to-cart" data-id="${item.id}">
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `);
        
        $('body').append(modal);
        modal.fadeIn();
    }

    // Cart functionality
    function addToCart(itemId, quantity) {
        $.ajax({
            url: warehouse_ajax.ajax_url,
            type: 'POST',
            data: {
                action: 'add_to_cart',
                item_id: itemId,
                quantity: quantity,
                nonce: warehouse_ajax.nonce
            },
            success: function(response) {
                if (response.success) {
                    showNotification('Item added to cart');
                    updateCartDisplay();
                } else {
                    showError(response.data || 'Failed to add item to cart');
                }
            },
            error: function() {
                showError('Network error. Please try again.');
            }
        });
    }

    // Utility functions
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

    function showNotification(message) {
        const notification = $(`
            <div class="notification notification-success">
                <div class="notification-content">
                    <span>${message}</span>
                    <button class="notification-close">&times;</button>
                </div>
            </div>
        `);
        
        $('body').append(notification);
        
        setTimeout(() => {
            notification.fadeOut(() => notification.remove());
        }, 3000);
    }

    function showError(message) {
        const error = $(`
            <div class="notification notification-error">
                <div class="notification-content">
                    <span>${message}</span>
                    <button class="notification-close">&times;</button>
                </div>
            </div>
        `);
        
        $('body').append(error);
        
        setTimeout(() => {
            error.fadeOut(() => error.remove());
        }, 5000);
    }

    function closeModals() {
        $('.modal').fadeOut(() => $('.modal').remove());
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
                        ${type === 'success' ? '✅' : type === 'error' ? '❌' : type === 'warning' ? '⚠️' : 'ℹ️'}
                    </div>
                    <div class="notification-message">${message}</div>
                    <button class="notification-close">&times;</button>
                </div>
            </div>
        `);

        $('body').append(notification);
        
        setTimeout(() => {
            notification.fadeOut(() => notification.remove());
        }, duration);
        
        notification.find('.notification-close').on('click', () => {
            notification.fadeOut(() => notification.remove());
        });
    }

    // Smooth scroll to sections
    function scrollToSection(sectionId) {
        const section = $(`#${sectionId}`);
        if (section.length) {
            $('html, body').animate({
                scrollTop: section.offset().top - 100
            }, 600);
        }
    }

    // Intersection Observer for animations
    function initScrollAnimations() {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, { threshold: 0.1 });

        $('.animate-on-scroll').each((_, element) => {
            observer.observe(element);
        });
    }

    // Enhanced search with highlighting
    function initEnhancedSearch() {
        const searchInput = $('.warehouse-search-input');
        if (searchInput.length) {
            const debouncedSearch = debounce(function() {
                const query = $(this).val().toLowerCase();
                performSearch(query);
            }, 300);

            searchInput.on('input', debouncedSearch);
        }
    }

    // Cart animations
    function animateCartAdd(item) {
        const cartIcon = $('.cart-icon');
        if (cartIcon.length) {
            cartIcon.addClass('bounce');
            setTimeout(() => cartIcon.removeClass('bounce'), 1000);
        }
    }

    // Image lazy loading
    function initLazyLoading() {
        const images = document.querySelectorAll('img[data-src]');
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });

        images.forEach(img => imageObserver.observe(img));
    }

    // Performance utilities
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
        initScrollAnimations();
        initEnhancedSearch();
        initLazyLoading();
        
        // Add smooth scrolling
        $('html').css('scroll-behavior', 'smooth');
        
        // Add hover effects
        $('.warehouse-item').hover(
            function() { $(this).addClass('hover-lift'); },
            function() { $(this).removeClass('hover-lift'); }
        );
    }

    // Global functions
    window.WarehouseFrontend = {
        loadInventoryItems: loadInventoryItems,
        applyFilters: applyFilters,
        addToCart: addToCart,
        showNotification: showEnhancedNotification,
        showLoading: showLoadingState,
        hideLoading: hideLoadingState,
        scrollToSection: scrollToSection,
        debounce: debounce,
        throttle: throttle
    };

    // Initialize enhanced features
    $(document).ready(() => {
        initializeEnhancedFeatures();
    });

})(jQuery);
