<?php
/**
 * Modern Dashboard with shadcn/ui styling
 */

// Get dashboard stats using the theme function
$stats = get_dashboard_stats();

// Get additional data for charts
global $wpdb;

// Get categories with item counts for chart
$categories_data = $wpdb->get_results("
    SELECT c.name, COUNT(i.id) as item_count
    FROM {$wpdb->prefix}wh_categories c
    LEFT JOIN {$wpdb->prefix}wh_inventory_items i ON c.id = i.category_id AND i.status != 'inactive'
    WHERE c.is_active = 1
    GROUP BY c.id, c.name
    ORDER BY item_count DESC
    LIMIT 10
");

// Get locations with item counts for chart
$locations_data = $wpdb->get_results("
    SELECT l.name, COUNT(i.id) as item_count
    FROM {$wpdb->prefix}wh_locations l
    LEFT JOIN {$wpdb->prefix}wh_inventory_items i ON l.id = i.location_id AND i.status != 'inactive'
    GROUP BY l.id, l.name
    ORDER BY item_count DESC
    LIMIT 8
");

// Get recent sales data for trend chart (last 7 days)
$sales_trend = $wpdb->get_results("
    SELECT DATE(sale_date) as date, SUM(total_amount) as total_sales, COUNT(*) as sales_count
    FROM {$wpdb->prefix}wh_sales
    WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    GROUP BY DATE(sale_date)
    ORDER BY DATE(sale_date) ASC
");

// Get top selling items (last 30 days)
$top_items = $wpdb->get_results("
    SELECT i.name, SUM(s.quantity) as total_sold, SUM(s.total_amount) as total_revenue
    FROM {$wpdb->prefix}wh_sales s
    JOIN {$wpdb->prefix}wh_inventory_items i ON s.item_id = i.id
    WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    GROUP BY s.item_id, i.name
    ORDER BY total_sold DESC
    LIMIT 5
");
?>

<div class="modern-dashboard">
    <!-- Header Section -->
    <div class="dashboard-header">
        <div class="header-content">
            <div class="header-text">
                <h1 class="dashboard-title">📊 Dashboard</h1>
                <p class="dashboard-subtitle">Overview of your warehouse operations</p>
            </div>
            <div class="header-actions">
                <button class="btn btn-outline btn-sm" onclick="refreshDashboard()">
                    <i class="fas fa-refresh"></i>
                    Refresh
                </button>
                <button class="btn btn-primary btn-sm" onclick="showQuickActions()">
                    <i class="fas fa-plus"></i>
                    Quick Add
                </button>
            </div>
        </div>
    </div>

    <!-- Stats Cards Grid -->
    <div class="stats-grid grid grid-cols-4">
        <div class="card stat-card hover-lift">
            <div class="card-content">
                <div class="stat-header">
                    <div class="stat-icon primary">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-trend">
                        <span class="trend-indicator positive">
                            <i class="fas fa-arrow-up"></i>
                        </span>
                    </div>
                </div>
                <div class="stat-content">
                    <div class="stat-value">$<?php echo isset($stats['total_value']) ? esc_html(number_format($stats['total_value'], 2)) : '0.00'; ?></div>
                    <div class="stat-label">Total Inventory Value</div>
                </div>
            </div>
        </div>

        <div class="card stat-card hover-lift">
            <div class="card-content">
                <div class="stat-header">
                    <div class="stat-icon success">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-trend">
                        <span class="trend-indicator positive">
                            <i class="fas fa-arrow-up"></i>
                        </span>
                    </div>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><?php echo isset($stats['in_stock']) ? esc_html($stats['in_stock']) : '0'; ?></div>
                    <div class="stat-label">Items In Stock</div>
                </div>
            </div>
        </div>

        <div class="card stat-card hover-lift">
            <div class="card-content">
                <div class="stat-header">
                    <div class="stat-icon warning">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="stat-trend">
                        <span class="trend-indicator neutral">
                            <i class="fas fa-minus"></i>
                        </span>
                    </div>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><?php echo isset($stats['low_stock']) ? esc_html($stats['low_stock']) : '0'; ?></div>
                    <div class="stat-label">Low Stock Items</div>
                </div>
            </div>
        </div>

        <div class="card stat-card hover-lift">
            <div class="card-content">
                <div class="stat-header">
                    <div class="stat-icon destructive">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <div class="stat-trend">
                        <span class="trend-indicator negative">
                            <i class="fas fa-arrow-down"></i>
                        </span>
                    </div>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><?php echo isset($stats['out_of_stock']) ? esc_html($stats['out_of_stock']) : '0'; ?></div>
                    <div class="stat-label">Out of Stock Items</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="charts-section">
        <div class="grid grid-cols-2">
            <!-- Stock Status Chart -->
            <div class="card chart-card">
                <div class="card-header">
                    <div class="card-title">📈 Stock Status Distribution</div>
                    <p class="card-description">Current inventory status overview</p>
                </div>
                <div class="card-content">
                    <div class="chart-container">
                        <canvas id="stockStatusChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Sales Trend Chart -->
            <div class="card chart-card">
                <div class="card-header">
                    <div class="card-title">🛍️ Sales Trend (Last 7 Days)</div>
                    <p class="card-description">Daily sales performance</p>
                </div>
                <div class="card-content">
                    <div class="chart-container">
                        <canvas id="salesTrendChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-2">
            <!-- Categories Chart -->
            <div class="card chart-card">
                <div class="card-header">
                    <div class="card-title">📦 Items by Category</div>
                    <p class="card-description">Distribution of inventory by category</p>
                </div>
                <div class="card-content">
                    <div class="chart-container">
                        <canvas id="categoriesChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Locations Chart -->
            <div class="card chart-card">
                <div class="card-header">
                    <div class="card-title">🏢 Items by Location</div>
                    <p class="card-description">Inventory distribution across locations</p>
                </div>
                <div class="card-content">
                    <div class="chart-container">
                        <canvas id="locationsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Top Items Chart - Full Width -->
        <div class="card chart-card">
            <div class="card-header">
                <div class="card-title">🔥 Top Selling Items (Last 30 Days)</div>
                <p class="card-description">Best performing products</p>
            </div>
            <div class="card-content">
                <div class="chart-container chart-horizontal">
                    <canvas id="topItemsChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity Section -->
    <div class="activity-section">
        <div class="grid grid-cols-3">
            <!-- Quick Stats -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">⚡ Quick Stats</div>
                </div>
                <div class="card-content">
                    <div class="quick-stats">
                        <div class="quick-stat-item">
                            <span class="quick-stat-label">Categories</span>
                            <span class="quick-stat-value"><?php echo isset($stats['categories_count']) ? esc_html($stats['categories_count']) : '0'; ?></span>
                        </div>
                        <div class="quick-stat-item">
                            <span class="quick-stat-label">Total Items</span>
                            <span class="quick-stat-value"><?php echo isset($stats['total_items']) ? esc_html($stats['total_items']) : '0'; ?></span>
                        </div>
                        <div class="quick-stat-item">
                            <span class="quick-stat-label">Pending Tasks</span>
                            <span class="quick-stat-value"><?php echo isset($stats['pending_tasks']) ? esc_html($stats['pending_tasks']) : '0'; ?></span>
                        </div>
                        <div class="quick-stat-item">
                            <span class="quick-stat-label">Sales Today</span>
                            <span class="quick-stat-value">$<?php echo isset($stats['sales_today']) ? esc_html(number_format($stats['sales_today'], 2)) : '0.00'; ?></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Low Stock Alert -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">⚠️ Low Stock Alert</div>
                </div>
                <div class="card-content">
                    <div id="low-stock-items" class="low-stock-list">
                        <div class="skeleton-loader">
                            <div class="skeleton"></div>
                            <div class="skeleton"></div>
                            <div class="skeleton"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">🚀 Quick Actions</div>
                </div>
                <div class="card-content">
                    <div class="quick-actions">
                        <button class="btn btn-outline btn-sm w-full" onclick="addNewItem()">
                            <i class="fas fa-plus"></i>
                            Add Item
                        </button>
                        <button class="btn btn-outline btn-sm w-full" onclick="viewInventory()">
                            <i class="fas fa-boxes"></i>
                            View Inventory
                        </button>
                        <button class="btn btn-outline btn-sm w-full" onclick="recordSale()">
                            <i class="fas fa-shopping-cart"></i>
                            Record Sale
                        </button>
                        <button class="btn btn-outline btn-sm w-full" onclick="createTask()">
                            <i class="fas fa-tasks"></i>
                            Create Task
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div id="dashboard-loading" class="loading-overlay" style="display: none;">
    <div class="loading-content">
        <div class="loading-spinner"></div>
        <p>Loading dashboard...</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// Modern Dashboard JavaScript
jQuery(document).ready(function($) {
    initializeCharts();
    loadLowStockItems();
    
    // Add loading states to stat cards
    $('.stat-card').addClass('loading');
    setTimeout(() => {
        $('.stat-card').removeClass('loading');
    }, 1000);
});

function initializeCharts() {
    // Chart.js default config
    Chart.defaults.font.family = 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", sans-serif';
    Chart.defaults.color = 'hsl(215.4 16.3% 46.9%)';
    
    // Stock Status Chart (Donut)
    const stockCtx = document.getElementById('stockStatusChart').getContext('2d');
    new Chart(stockCtx, {
        type: 'doughnut',
        data: {
            labels: ['In Stock', 'Low Stock', 'Out of Stock'],
            datasets: [{
                data: [
                    <?php echo isset($stats['in_stock']) ? $stats['in_stock'] : 0; ?>,
                    <?php echo isset($stats['low_stock']) ? $stats['low_stock'] : 0; ?>,
                    <?php echo isset($stats['out_of_stock']) ? $stats['out_of_stock'] : 0; ?>
                ],
                backgroundColor: [
                    'hsl(142.1 76.2% 36.3%)', // green
                    'hsl(45.4 93.4% 47.5%)',  // yellow
                    'hsl(0 84.2% 60.2%)'      // red
                ],
                borderWidth: 0,
                borderRadius: 8,
                spacing: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 20,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                }
            },
            cutout: '70%'
        }
    });

    // Sales Trend Chart (Line)
    const salesCtx = document.getElementById('salesTrendChart').getContext('2d');
    new Chart(salesCtx, {
        type: 'line',
        data: {
            labels: [
                <?php 
                foreach ($sales_trend as $day) {
                    echo "'" . date('M j', strtotime($day->date)) . "',";
                }
                ?>
            ],
            datasets: [{
                label: 'Sales ($)',
                data: [
                    <?php 
                    foreach ($sales_trend as $day) {
                        echo $day->total_sales . ',';
                    }
                    ?>
                ],
                borderColor: 'hsl(221.2 83.2% 53.3%)',
                backgroundColor: 'hsl(221.2 83.2% 53.3% / 0.1)',
                fill: true,
                tension: 0.4,
                pointBackgroundColor: 'hsl(221.2 83.2% 53.3%)',
                pointBorderColor: 'hsl(0 0% 100%)',
                pointBorderWidth: 2,
                pointRadius: 6,
                pointHoverRadius: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    border: {
                        display: false
                    },
                    grid: {
                        color: 'hsl(214.3 31.8% 91.4%)'
                    },
                    ticks: {
                        callback: function(value) {
                            return '$' + value.toFixed(0);
                        }
                    }
                },
                x: {
                    border: {
                        display: false
                    },
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // Categories Chart (Bar)
    const categoriesCtx = document.getElementById('categoriesChart').getContext('2d');
    new Chart(categoriesCtx, {
        type: 'bar',
        data: {
            labels: [
                <?php 
                foreach ($categories_data as $category) {
                    echo "'" . esc_js($category->name) . "',";
                }
                ?>
            ],
            datasets: [{
                label: 'Items',
                data: [
                    <?php 
                    foreach ($categories_data as $category) {
                        echo $category->item_count . ',';
                    }
                    ?>
                ],
                backgroundColor: 'hsl(262.1 83.3% 57.8%)',
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    border: {
                        display: false
                    },
                    grid: {
                        color: 'hsl(214.3 31.8% 91.4%)'
                    },
                    ticks: {
                        stepSize: 1
                    }
                },
                x: {
                    border: {
                        display: false
                    },
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // Locations Chart (Pie)
    const locationsCtx = document.getElementById('locationsChart').getContext('2d');
    new Chart(locationsCtx, {
        type: 'pie',
        data: {
            labels: [
                <?php 
                foreach ($locations_data as $location) {
                    echo "'" . esc_js($location->name) . "',";
                }
                ?>
            ],
            datasets: [{
                data: [
                    <?php 
                    foreach ($locations_data as $location) {
                        echo $location->item_count . ',';
                    }
                    ?>
                ],
                backgroundColor: [
                    'hsl(45.4 93.4% 47.5%)', 'hsl(142.1 76.2% 36.3%)', 'hsl(221.2 83.2% 53.3%)', 
                    'hsl(262.1 83.3% 57.8%)', 'hsl(0 84.2% 60.2%)', 'hsl(189.4 94.5% 42.2%)', 
                    'hsl(84.2 85.2% 40.4%)', 'hsl(24.6 95% 53.1%)'
                ],
                borderWidth: 0,
                borderRadius: 4,
                spacing: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right',
                    labels: {
                        padding: 15,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                }
            }
        }
    });

    // Top Items Chart (Horizontal Bar)
    const topItemsCtx = document.getElementById('topItemsChart').getContext('2d');
    new Chart(topItemsCtx, {
        type: 'bar',
        data: {
            labels: [
                <?php 
                foreach ($top_items as $item) {
                    echo "'" . esc_js($item->name) . "',";
                }
                ?>
            ],
            datasets: [{
                label: 'Units Sold',
                data: [
                    <?php 
                    foreach ($top_items as $item) {
                        echo $item->total_sold . ',';
                    }
                    ?>
                ],
                backgroundColor: 'hsl(142.1 76.2% 36.3%)',
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            indexAxis: 'y',
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    border: {
                        display: false
                    },
                    grid: {
                        color: 'hsl(214.3 31.8% 91.4%)'
                    },
                    ticks: {
                        stepSize: 1
                    }
                },
                y: {
                    border: {
                        display: false
                    },
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}

function loadLowStockItems() {
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'get_low_stock_items',
        nonce: warehouse_ajax.nonce
    }, function(response) {
        if (response.success) {
            const container = document.getElementById('low-stock-items');
            const items = response.data;
            
            if (items.length === 0) {
                container.innerHTML = `
                    <div class="empty-state-small">
                        <i class="fas fa-check-circle"></i>
                        <p>All items are well stocked!</p>
                    </div>
                `;
            } else {
                container.innerHTML = items.map(item => `
                    <div class="low-stock-item">
                        <div class="item-info">
                            <span class="item-name">${item.name}</span>
                            <span class="item-quantity">${item.quantity} left</span>
                        </div>
                        <button class="btn btn-ghost btn-sm" onclick="viewItem(${item.id})">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                `).join('');
            }
        }
    });
}

function refreshDashboard() {
    const loading = document.getElementById('dashboard-loading');
    loading.style.display = 'flex';
    
    setTimeout(() => {
        location.reload();
    }, 1000);
}

function showQuickActions() {
    // You can implement a modal or dropdown here
    console.log('Quick actions modal');
}

function addNewItem() {
    // Navigate to inventory with add modal
    window.location.href = '?tab=inventory&action=add';
}

function viewInventory() {
    window.location.href = '?tab=inventory';
}

function recordSale() {
    window.location.href = '?tab=inventory&action=sell';
}

function createTask() {
    window.location.href = '?tab=tasks&action=add';
}

function viewItem(itemId) {
    window.location.href = `?tab=inventory&item=${itemId}&highlight=true`;
}
</script>

<style>
/* Modern Dashboard Styles */
.modern-dashboard {
    padding: 2rem 0;
    max-width: 1400px;
    margin: 0 auto;
}

.dashboard-header {
    margin-bottom: 2rem;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 2rem;
}

.dashboard-title {
    font-size: 2.25rem;
    font-weight: 700;
    margin: 0 0 0.5rem 0;
    color: hsl(var(--foreground));
    line-height: 1.2;
}

.dashboard-subtitle {
    font-size: 1.125rem;
    color: hsl(var(--muted-foreground));
    margin: 0;
}

.header-actions {
    display: flex;
    gap: 0.75rem;
    flex-shrink: 0;
}

/* Stats Grid */
.stats-grid {
    margin-bottom: 3rem;
}

.stat-card {
    position: relative;
    overflow: hidden;
}

.stat-card.loading::after {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.8), transparent);
    animation: shimmer 2s infinite;
}

@keyframes shimmer {
    0% { left: -100%; }
    100% { left: 100%; }
}

.hover-lift {
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.hover-lift:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px 0 rgba(0, 0, 0, 0.1);
}

.stat-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.stat-icon {
    width: 48px;
    height: 48px;
    border-radius: var(--radius);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.25rem;
}

.stat-icon.primary {
    background: hsl(221.2 83.2% 53.3% / 0.1);
    color: hsl(221.2 83.2% 53.3%);
}

.stat-icon.success {
    background: hsl(142.1 76.2% 36.3% / 0.1);
    color: hsl(142.1 76.2% 36.3%);
}

.stat-icon.warning {
    background: hsl(45.4 93.4% 47.5% / 0.1);
    color: hsl(45.4 93.4% 47.5%);
}

.stat-icon.destructive {
    background: hsl(0 84.2% 60.2% / 0.1);
    color: hsl(0 84.2% 60.2%);
}

.trend-indicator {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 24px;
    height: 24px;
    border-radius: 50%;
    font-size: 0.75rem;
}

.trend-indicator.positive {
    background: hsl(142.1 76.2% 36.3% / 0.1);
    color: hsl(142.1 76.2% 36.3%);
}

.trend-indicator.negative {
    background: hsl(0 84.2% 60.2% / 0.1);
    color: hsl(0 84.2% 60.2%);
}

.trend-indicator.neutral {
    background: hsl(45.4 93.4% 47.5% / 0.1);
    color: hsl(45.4 93.4% 47.5%);
}

.stat-value {
    font-size: 2.25rem;
    font-weight: 700;
    line-height: 1;
    margin-bottom: 0.5rem;
    color: hsl(var(--foreground));
}

.stat-label {
    font-size: 0.875rem;
    font-weight: 500;
    color: hsl(var(--muted-foreground));
}

/* Charts Section */
.charts-section {
    margin-bottom: 3rem;
}

.chart-card {
    height: 400px;
}

.chart-container {
    position: relative;
    height: 280px;
}

.chart-horizontal {
    height: 200px;
}

/* Activity Section */
.activity-section {
    margin-bottom: 2rem;
}

.quick-stats {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.quick-stat-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 0;
    border-bottom: 1px solid hsl(var(--border));
}

.quick-stat-item:last-child {
    border-bottom: none;
}

.quick-stat-label {
    font-size: 0.875rem;
    color: hsl(var(--muted-foreground));
}

.quick-stat-value {
    font-weight: 600;
    color: hsl(var(--foreground));
}

.low-stock-list {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.low-stock-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem;
    background: hsl(var(--muted) / 0.5);
    border-radius: var(--radius);
    border: 1px solid hsl(var(--border));
}

.item-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.item-name {
    font-weight: 500;
    color: hsl(var(--foreground));
    font-size: 0.875rem;
}

.item-quantity {
    font-size: 0.75rem;
    color: hsl(var(--muted-foreground));
}

.quick-actions {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.w-full {
    width: 100%;
}

.empty-state-small {
    text-align: center;
    padding: 2rem 1rem;
    color: hsl(var(--muted-foreground));
}

.empty-state-small i {
    font-size: 2rem;
    margin-bottom: 0.5rem;
    color: hsl(142.1 76.2% 36.3%);
}

.empty-state-small p {
    margin: 0;
    font-size: 0.875rem;
}

/* Skeleton Loader */
.skeleton-loader {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.skeleton {
    height: 1rem;
    background: linear-gradient(90deg, hsl(var(--muted)) 25%, hsl(var(--muted) / 0.5) 50%, hsl(var(--muted)) 75%);
    background-size: 200% 100%;
    animation: skeleton-loading 1.5s infinite;
    border-radius: var(--radius);
}

/* Loading Overlay */
.loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.loading-content {
    background: hsl(var(--background));
    padding: 2rem;
    border-radius: var(--radius);
    text-align: center;
    border: 1px solid hsl(var(--border));
}

.loading-spinner {
    width: 2rem;
    height: 2rem;
    border: 2px solid hsl(var(--border));
    border-top: 2px solid hsl(var(--primary));
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 1rem;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Responsive Design */
@media (max-width: 1024px) {
    .stats-grid {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .charts-section .grid {
        grid-template-columns: 1fr;
    }
    
    .activity-section .grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 768px) {
    .modern-dashboard {
        padding: 1rem 0;
    }
    
    .header-content {
        flex-direction: column;
        gap: 1rem;
    }
    
    .dashboard-title {
        font-size: 1.875rem;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
    }
    
    .stat-value {
        font-size: 1.875rem;
    }
    
    .chart-card {
        height: 300px;
    }
    
    .chart-container {
        height: 200px;
    }
}
</style>