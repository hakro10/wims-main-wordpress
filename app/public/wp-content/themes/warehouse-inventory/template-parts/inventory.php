<?php
/**
 * Inventory Management Template Part
 */

$categories = get_all_categories();
$locations = get_all_locations();
?>

<div class="inventory-content">
    <!-- Search and Filters -->
    <div class="search-filters">
        <div class="search-row">
            <div class="search-input">
                <input type="text" id="inventory-search" placeholder="Search items..." class="form-input">
                <i class="fas fa-search search-icon"></i>
            </div>
            
            <select id="category-filter" class="form-select">
                <option value="">All Categories</option>
                <?php 
                // Use hierarchical categories for filter dropdown too
                global $wpdb;
                
                // Check if is_active column exists
                $columns = $wpdb->get_results("SHOW COLUMNS FROM {$wpdb->prefix}wh_categories LIKE 'is_active'");
                $where_clause = !empty($columns) ? "WHERE c.is_active = 1" : "";
                
                $filter_categories = $wpdb->get_results("
                    SELECT c.*, 
                           parent.name as parent_name
                    FROM {$wpdb->prefix}wh_categories c
                    LEFT JOIN {$wpdb->prefix}wh_categories parent ON c.parent_id = parent.id
                    {$where_clause}
                    ORDER BY c.parent_id IS NULL DESC, c.parent_id, 
                             " . (!empty($columns) ? "c.sort_order," : "") . " c.name
                ");
                
                foreach ($filter_categories as $category):
                    $display_name = $category->name;
                    $indent = '';
                    
                    if ($category->parent_id) {
                        $indent = '&nbsp;&nbsp;&nbsp;&nbsp;↳ ';
                        $display_name = $category->parent_name . ' → ' . $category->name;
                    }
                ?>
                    <option value="<?php echo $category->id; ?>" data-level="<?php echo $category->parent_id ? '1' : '0'; ?>">
                        <?php echo $indent . esc_html($display_name); ?>
                    </option>
                <?php endforeach; ?>
            </select>
            
            <select id="status-filter" class="form-select">
                <option value="">All Status</option>
                <option value="in-stock">In Stock</option>
                <option value="low-stock">Low Stock</option>
                <option value="out-of-stock">Out of Stock</option>
            </select>
            
            <button class="btn btn-secondary" onclick="openInactiveItemsModal()" title="View and permanently delete inactive items">
                <i class="fas fa-trash-alt"></i> Cleanup
            </button>
            
            <button class="btn btn-primary" onclick="openModal('add-item-modal')">
                <i class="fas fa-plus"></i> Add Item
            </button>
        </div>
    </div>

    <!-- Inventory Grid -->
    <div id="inventory-grid" class="inventory-grid">
        <!-- Items will be loaded via AJAX -->
    </div>
</div>

<!-- Add Item Modal -->
<div id="add-item-modal" class="modal-overlay" style="display:none;">
    <div class="modal" style="position: absolute !important; top: 50% !important; left: 50% !important; transform: translate(-50%, -50%) !important; border-radius: 8px !important; width: 90% !important; max-width: 600px !important; max-height: 80vh !important; overflow-y: auto !important; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3) !important;">
        <div class="modal-header">
            <h3 class="modal-title">Add New Item</h3>
            <button class="modal-close" onclick="closeModal('add-item-modal')">&times;</button>
        </div>
        
        <div class="modal-body">
            <form id="add-item-form">
                <table class="modal-form">
                    <tr>
                        <td>
                            <label class="form-label">Item Name *</label>
                            <input type="text" name="name" required class="form-input">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Description</label>
                            <textarea name="description" rows="3" class="form-input"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="two-col">
                                <div>
                                    <label class="form-label">Category</label>
                                    <select name="category_id" class="form-select">
                                        <?php echo get_hierarchical_categories_for_select(); ?>
                                    </select>
                                    <small class="form-hint">Subcategories show as: Parent → Child</small>
                                </div>
                                <div>
                                    <label class="form-label">Location</label>
                                    <select name="location_id" class="form-select">
                                        <option value="">Select Location</option>
                                        <?php foreach ($locations as $location): ?>
                                            <option value="<?php echo $location->id; ?>"><?php echo esc_html($location->name); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="two-col">
                                <div>
                                    <label class="form-label">Quantity *</label>
                                    <input type="number" name="quantity" min="0" required class="form-input">
                                </div>
                                <div>
                                    <label class="form-label">Min Stock Level</label>
                                    <input type="number" name="min_stock_level" min="1" value="1" class="form-input">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <table style="width: 100% !important; border-collapse: collapse !important;">
                                <tr>
                                    <td style="width: 50% !important; padding-right: 15px !important; vertical-align: top !important;">
                                        <label class="form-label">Purchase Price (per unit)</label>
                                        <input type="number" name="purchase_price" step="0.01" min="0" id="purchase-price-input" class="form-input">
                                    </td>
                                    <td style="vertical-align: top !important;">
                                        <label class="form-label">Selling Price</label>
                                        <input type="number" name="selling_price" step="0.01" min="0" class="form-input">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">💰 Total Lot Price</label>
                            <input type="number" name="total_lot_price" step="0.01" min="0" placeholder="0.00" id="total-lot-price-input" class="form-input">
                            <small class="form-hint">Total amount paid for this batch/lot of items</small>

                            <div id="lot-calculations" class="lot-calculations">
                                <div>Per unit cost: <span id="per-unit-cost">$0.00</span></div>
                                <div>Total quantity: <span id="total-quantity">0</span></div>
                                <div>Total lot cost: <span id="total-lot-cost">$0.00</span></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Supplier</label>
                            <input type="text" name="supplier" class="form-input">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeModal('add-item-modal')">Cancel</button>
            <button type="button" class="btn btn-primary" onclick="submitAddItem()">Add Item</button>
        </div>
    </div>
</div>

<!-- Edit Item Modal -->
<div id="edit-item-modal" style="display: none; position: fixed !important; top: 0 !important; left: 0 !important; width: 100vw !important; height: 100vh !important; background: rgba(0, 0, 0, 0.5) !important; z-index: 999999 !important; overflow-y: auto !important;">
    <div class="modal" style="position: absolute !important; top: 50% !important; left: 50% !important; transform: translate(-50%, -50%) !important; border-radius: 8px !important; width: 90% !important; max-width: 600px !important; max-height: 80vh !important; overflow-y: auto !important; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3) !important;">
        <div class="modal-header">
            <h3 class="modal-title">Edit Item</h3>
            <button class="modal-close" onclick="closeModal('edit-item-modal')">&times;</button>
        </div>
        
        <div class="modal-body">
            <form id="edit-item-form">
                <input type="hidden" name="id" value="">
                <table class="modal-form">
                    <tr>
                        <td>
                            <label class="form-label">Item Name *</label>
                            <input type="text" name="name" required class="form-input">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Description</label>
                            <textarea name="description" rows="3" class="form-input"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="two-col">
                                <div>
                                    <label class="form-label">Category</label>
                                    <select name="category_id" id="edit-category-select" class="form-select">
                                        <?php echo get_hierarchical_categories_for_select(); ?>
                                    </select>
                                    <small class="form-hint">Subcategories show as: Parent → Child</small>
                                </div>
                                <div>
                                    <label class="form-label">Location</label>
                                    <select name="location_id" class="form-select">
                                        <option value="">Select Location</option>
                                        <?php foreach ($locations as $location): ?>
                                            <option value="<?php echo $location->id; ?>"><?php echo esc_html($location->name); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>
                        </td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="two-col">
                                <div>
                                    <label class="form-label">Quantity *</label>
                                    <input type="number" name="quantity" min="0" required class="form-input">
                                </div>
                                <div>
                                    <label class="form-label">Min Stock Level</label>
                                    <input type="number" name="min_stock_level" min="1" value="1" class="form-input">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <table style="width: 100% !important; border-collapse: collapse !important;">
                                <tr>
                                    <td style="width: 50% !important; padding-right: 15px !important; vertical-align: top !important;">
                                        <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Purchase Price</label>
                                        <input type="number" name="purchase_price" step="0.01" min="0" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                                    </td>
                                    <td style="vertical-align: top !important;">
                                        <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Selling Price</label>
                                        <input type="number" name="selling_price" step="0.01" min="0" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Total Lot Price</label>
                            <input type="number" name="total_lot_price" step="0.01" min="0" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <table style="width: 100% !important; border-collapse: collapse !important;">
                                <tr>
                                    <td style="width: 50% !important; padding-right: 15px !important; vertical-align: top !important;">
                                        <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Supplier</label>
                                        <input type="text" name="supplier" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                                    </td>
                                    <td style="vertical-align: top !important;">
                                        <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Tested Status</label>
                                        <select name="tested_status" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                                            <option value="not_tested">Not Tested</option>
                                            <option value="tested">Tested</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeModal('edit-item-modal')">Cancel</button>
            <button type="button" class="btn btn-primary" onclick="submitEditItem()">Update Item</button>
        </div>
    </div>
</div>

<!-- Sell Item Modal -->
<div id="sell-item-modal" class="modal-overlay" style="display:none;">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">Record Sale</h3>
            <button class="modal-close" onclick="closeModal('sell-item-modal')">&times;</button>
        </div>
        
        <div class="modal-body">
            <form id="sell-item-form">
                <input type="hidden" name="item_id" value="">
                
                <div class="sale-summary">
                    <h4 style="margin:0 0 .5rem 0;">Item: <span id="sell-item-name"></span></h4>
                    <p style="margin:0;">Available Stock: <span id="sell-available-stock"></span></p>
                </div>
                
                <table style="width: 100% !important; border-collapse: collapse !important;">
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Quantity to Sell *</label>
                            <input type="number" name="quantity" min="1" required style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Unit Price *</label>
                            <input type="number" name="unit_price" step="0.01" min="0" required style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Customer Name</label>
                            <input type="text" name="customer_name" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0 !important; vertical-align: top !important;">
                            <label style="display: block !important; font-weight: 600 !important; color: #374151 !important; margin-bottom: 5px !important;">Notes</label>
                            <textarea name="notes" rows="3" style="width: 100% !important; padding: 8px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; font-size: 14px !important; background: white !important; box-sizing: border-box !important; display: block !important; resize: vertical !important; font-family: inherit !important;"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeModal('sell-item-modal')">Cancel</button>
            <button type="button" class="btn btn-primary" onclick="submitSaleRecord()">Record Sale</button>
        </div>
    </div>
</div>

<!-- styles moved to theme stylesheet -->

<script>
// Load inventory items on page load
jQuery(document).ready(function() {
    console.log('Inventory page loaded');
    console.log('warehouse_ajax object:', typeof warehouse_ajax !== 'undefined' ? warehouse_ajax : 'NOT FOUND');
    
    if (typeof warehouse_ajax === 'undefined') {
        document.getElementById('inventory-grid').innerHTML = '<div class="empty-state" style="grid-column: 1 / -1;"><h3>Configuration Error</h3><p>AJAX not properly configured. Check if scripts are loaded.</p></div>';
        return;
    }
    
    // Check for URL parameters to set filters
    const urlParams = new URLSearchParams(window.location.search);
    const categoryParam = urlParams.get('category');
    const categoryNameParam = urlParams.get('category_name');
    const itemParam = urlParams.get('item');
    const highlightParam = urlParams.get('highlight');
    
    // Set category filter if provided
    if (categoryParam) {
        document.getElementById('category-filter').value = categoryParam;
        console.log('Set category filter to:', categoryParam);
        
        // Show notification about the filter
        if (categoryNameParam) {
            showNotification(`Showing items from category: ${decodeURIComponent(categoryNameParam)}`, 'info');
        }
    }
    
    // Store item to highlight if provided
    if (itemParam && highlightParam === 'true') {
        window.highlightItemId = itemParam;
        console.log('Will highlight item:', itemParam);
    }
    
    loadInventoryItems();
    
    // Add event listeners for search and filters
    document.getElementById('inventory-search').addEventListener('input', loadInventoryItems);
    document.getElementById('category-filter').addEventListener('change', loadInventoryItems);
    document.getElementById('status-filter').addEventListener('change', loadInventoryItems);
});

// Load inventory items
function loadInventoryItems() {
    console.log('Loading inventory items...');
    
    const search = document.getElementById('inventory-search').value;
    const category = document.getElementById('category-filter').value;
    const status = document.getElementById('status-filter').value;
    
    console.log('Search filters:', { search, category, status });
    
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'get_inventory_items',
        nonce: warehouse_ajax.nonce,
        search: search,
        category: category,
        status: status
    }, function(response) {
        console.log('AJAX Response:', response);
        if (response.success) {
            console.log('Items found:', response.data.items.length);
            renderInventoryGrid(response.data.items);
        } else {
            console.error('AJAX Error:', response.data);
            document.getElementById('inventory-grid').innerHTML = '<div class="empty-state" style="grid-column: 1 / -1;"><h3>Error loading items</h3><p>' + response.data + '</p></div>';
        }
    }).fail(function(xhr, status, error) {
        console.error('AJAX Failed:', { xhr, status, error });
        document.getElementById('inventory-grid').innerHTML = '<div class="empty-state" style="grid-column: 1 / -1;"><h3>Connection Error</h3><p>Failed to load inventory items. Check console for details.</p></div>';
    });
}

// Render inventory grid
function renderInventoryGrid(items) {
    const grid = document.getElementById('inventory-grid');
    
    if (items.length === 0) {
        grid.innerHTML = `
            <div class="empty-state" style="grid-column: 1 / -1;">
                <i class="fas fa-search" style="font-size: 4rem; color: #d1d5db; margin-bottom: 1rem;"></i>
                <h3>No items found</h3>
                <p>Try adjusting your search or filters.</p>
            </div>
        `;
        return;
    }
    
    grid.innerHTML = items.map(item => `
        <div class="inventory-item" data-item-id="${item.id}">
            <div class="item-header">
                <div class="item-info">
                    <h3 class="item-name">${item.name}</h3>
                    <div class="item-id">ID: ${item.internal_id}</div>
                    <div class="item-status-badges">
                        <button class="tested-badge ${(item.tested_status === 'tested' || item.tested_status === '1') ? 'tested' : 'not-tested'}" 
                                onclick="toggleTestedStatus(${item.id}, this)" 
                                title="Click to toggle tested status">
                            <i class="fas fa-${(item.tested_status === 'tested' || item.tested_status === '1') ? 'check-circle' : 'clock'}"></i>
                            ${(item.tested_status === 'tested' || item.tested_status === '1') ? 'Tested' : 'Not Tested'}
                        </button>
                    </div>
                </div>
                <div class="item-actions">
                    <button class="btn-icon edit-btn" onclick="editItem(${item.id})" title="Edit">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-icon sell-btn" onclick="sellItem(${item.id})" title="Sell">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                    <button class="btn-icon delete-btn" onclick="deleteItem(${item.id})" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            
            <div class="item-details">
                <div class="detail-item">
                    <div class="detail-label">Quantity</div>
                    <div class="detail-value">${item.quantity}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Status</div>
                    <div class="detail-value">
                        <span class="status-badge status-${item.status}">
                            ${item.status.replace('-', ' ').replace(/\b\w/g, l => l.toUpperCase())}
                        </span>
                    </div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Category</div>
                    <div class="detail-value">${item.category_name || 'Uncategorized'}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Location</div>
                    <div class="detail-value">${item.location_name || 'No location'}</div>
                </div>
            </div>
            
            ${item.purchase_price || item.selling_price || item.total_lot_price ? `
                <div class="item-pricing">
                    ${item.purchase_price ? `<span class="price-label cost-price">Cost: $${parseFloat(item.purchase_price).toFixed(2)}</span>` : ''}
                    ${item.selling_price ? `<span class="price-label sell-price">Sell: $${parseFloat(item.selling_price).toFixed(2)}</span>` : ''}
                    ${item.total_lot_price ? `<span class="price-label lot-price">Lot: $${parseFloat(item.total_lot_price).toFixed(2)}</span>` : ''}
                </div>
            ` : ''}
        </div>
    `).join('');
    
    // Highlight specific item if requested
    if (window.highlightItemId) {
        setTimeout(() => {
            const itemElement = document.querySelector(`[data-item-id="${window.highlightItemId}"]`);
            if (itemElement) {
                itemElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
                itemElement.style.animation = 'highlight-flash 2s ease-in-out';
                itemElement.style.border = '3px solid #10b981';
                itemElement.style.backgroundColor = '#ecfdf5';
                
                // Remove highlight after animation
                setTimeout(() => {
                    itemElement.style.animation = '';
                    itemElement.style.border = '';
                    itemElement.style.backgroundColor = '';
                }, 3000);
            }
            
            // Clear the highlight flag
            window.highlightItemId = null;
        }, 500);
    }
}

// Submit add item form
function submitAddItem() {
    const form = document.getElementById('add-item-form');
    const formData = new FormData(form);
    
    // Convert FormData to object for AJAX
    const data = {
        action: 'add_inventory_item',
        nonce: warehouse_ajax.nonce
    };
    
    for (let [key, value] of formData.entries()) {
        data[key] = value;
    }
    
    jQuery.post(warehouse_ajax.ajax_url, data, function(response) {
        if (response.success) {
            closeModal('add-item-modal');
            form.reset();
            loadInventoryItems();
            showNotification('Item added successfully!', 'success');
            
            // Refresh category counts since new item was added
            if (typeof refreshCategoryCounts === 'function') {
                refreshCategoryCounts();
            }
        } else {
            showNotification('Error: ' + response.data, 'error');
        }
    });
}

// Submit edit item form
function submitEditItem() {
    const form = document.getElementById('edit-item-form');
    const formData = new FormData(form);
    
    // Convert FormData to object for AJAX
    const data = {
        action: 'update_inventory_item',
        nonce: warehouse_ajax.nonce
    };
    
    for (let [key, value] of formData.entries()) {
        data[key] = value;
    }
    
    jQuery.post(warehouse_ajax.ajax_url, data, function(response) {
        if (response.success) {
            closeModal('edit-item-modal');
            loadInventoryItems();
            showNotification('Item updated successfully!', 'success');
            
            // Refresh category counts since item data might have changed
            if (typeof refreshCategoryCounts === 'function') {
                refreshCategoryCounts();
            }
        } else {
            showNotification('Error: ' + (response.data || 'Failed to update item'), 'error');
        }
    }).fail(function() {
        showNotification('Network error updating item', 'error');
    });
}

// Submit sale record
function submitSaleRecord() {
    const form = document.getElementById('sell-item-form');
    const formData = new FormData(form);
    
    // Basic validation
    const quantity = parseInt(formData.get('quantity'));
    const unitPrice = parseFloat(formData.get('unit_price'));
    
    if (!quantity || quantity <= 0) {
        showNotification('Please enter a valid quantity', 'error');
        return;
    }
    
    if (!unitPrice || unitPrice <= 0) {
        showNotification('Please enter a valid unit price', 'error');
        return;
    }
    
    // Convert FormData to object for AJAX
    const data = {
        action: 'record_sale',
        nonce: warehouse_ajax.nonce
    };
    
    for (let [key, value] of formData.entries()) {
        data[key] = value;
    }
    
    jQuery.post(warehouse_ajax.ajax_url, data, function(response) {
        if (response.success) {
            closeModal('sell-item-modal');
            form.reset();
            loadInventoryItems();
            showNotification('Sale recorded successfully!', 'success');
            
            // Refresh category counts since item quantity changed
            if (typeof refreshCategoryCounts === 'function') {
                refreshCategoryCounts();
            }
        } else {
            showNotification('Error: ' + (response.data || 'Failed to record sale'), 'error');
        }
    }).fail(function() {
        showNotification('Network error recording sale', 'error');
    });
}

// Modal functions
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Search and filter handlers
document.getElementById('inventory-search').addEventListener('input', loadInventoryItems);
document.getElementById('category-filter').addEventListener('change', loadInventoryItems);
document.getElementById('status-filter').addEventListener('change', loadInventoryItems);

// Load items on page load
document.addEventListener('DOMContentLoaded', function() {
    loadInventoryItems();
    setupLotPriceCalculations();
});

// Lot Price Calculations
function setupLotPriceCalculations() {
    const quantityInput = document.querySelector('input[name="quantity"]');
    const purchasePriceInput = document.getElementById('purchase-price-input');
    const totalLotPriceInput = document.getElementById('total-lot-price-input');
    const lotCalculations = document.getElementById('lot-calculations');
    
    // Add event listeners for auto-calculation
    if (quantityInput && purchasePriceInput && totalLotPriceInput) {
        quantityInput.addEventListener('input', updateLotCalculations);
        purchasePriceInput.addEventListener('input', updateLotCalculations);
        totalLotPriceInput.addEventListener('input', updateFromLotPrice);
    }
}

function updateLotCalculations() {
    const quantity = parseFloat(document.querySelector('input[name="quantity"]').value) || 0;
    const purchasePrice = parseFloat(document.getElementById('purchase-price-input').value) || 0;
    const totalLotPrice = parseFloat(document.getElementById('total-lot-price-input').value) || 0;
    
    const lotCalculations = document.getElementById('lot-calculations');
    
    // Show calculations if we have quantity and either purchase price or lot price
    if (quantity > 0 && (purchasePrice > 0 || totalLotPrice > 0)) {
        lotCalculations.style.display = 'block';
        
        let perUnitCost = purchasePrice;
        let totalCost = purchasePrice * quantity;
        
        // If total lot price is entered, calculate per unit cost
        if (totalLotPrice > 0 && quantity > 0) {
            perUnitCost = totalLotPrice / quantity;
            totalCost = totalLotPrice;
            
            // Update purchase price field if it's empty or different
            if (purchasePrice === 0 || Math.abs(purchasePrice - perUnitCost) > 0.01) {
                document.getElementById('purchase-price-input').value = perUnitCost.toFixed(2);
            }
        }
        
        // Update display values
        document.getElementById('per-unit-cost').textContent = '$' + perUnitCost.toFixed(2);
        document.getElementById('total-quantity').textContent = quantity;
        document.getElementById('total-lot-cost').textContent = '$' + totalCost.toFixed(2);
    } else {
        lotCalculations.style.display = 'none';
    }
}

function updateFromLotPrice() {
    const quantity = parseFloat(document.querySelector('input[name="quantity"]').value) || 0;
    const totalLotPrice = parseFloat(document.getElementById('total-lot-price-input').value) || 0;
    
    if (quantity > 0 && totalLotPrice > 0) {
        const perUnitCost = totalLotPrice / quantity;
        document.getElementById('purchase-price-input').value = perUnitCost.toFixed(2);
    }
    
    updateLotCalculations();
}

// Edit item function
function editItem(itemId) {
    if (!itemId) {
        showNotification('Invalid item ID', 'error');
        return;
    }
    
    // Get item data first
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'get_inventory_items',
        nonce: warehouse_ajax.nonce
    }, function(response) {
        if (response.success && response.data.items) {
            const item = response.data.items.find(i => i.id == itemId);
            if (item) {
                // Populate edit form with item data
                populateEditForm(item);
                openModal('edit-item-modal');
            } else {
                showNotification('Item not found', 'error');
            }
        } else {
            showNotification('Error loading item data', 'error');
        }
    }).fail(function() {
        showNotification('Network error loading item', 'error');
    });
}

// Delete item function
function deleteItem(itemId) {
    if (!itemId) {
        showNotification('Invalid item ID', 'error');
        return;
    }
    
    if (!confirm('⚠️ Are you sure you want to PERMANENTLY delete this item?\n\nThis will delete:\n• The item from inventory\n• All related sales records\n• All associated data\n\nThis action CANNOT be undone!')) {
        return;
    }
    
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'delete_inventory_item',
        nonce: warehouse_ajax.nonce,
        id: itemId
    }, function(response) {
        if (response.success) {
            let message = 'Item deleted successfully';
            if (response.data && response.data.sales_deleted > 0) {
                message += ` (${response.data.sales_deleted} related sales records also deleted)`;
            }
            showNotification(message, 'success');
            loadInventoryItems(); // Reload the inventory grid
            
            // Refresh category counts since item was deleted
            if (typeof refreshCategoryCounts === 'function') {
                refreshCategoryCounts();
            }
        } else {
            showNotification(response.data || 'Failed to delete item', 'error');
        }
    }).fail(function() {
        showNotification('Network error deleting item', 'error');
    });
}

// Sell item function
function sellItem(itemId) {
    if (!itemId) {
        showNotification('Invalid item ID', 'error');
        return;
    }
    
    // Get item data for selling
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'get_inventory_items',
        nonce: warehouse_ajax.nonce
    }, function(response) {
        if (response.success && response.data.items) {
            const item = response.data.items.find(i => i.id == itemId);
            if (item) {
                if (item.quantity <= 0) {
                    showNotification('Cannot sell item - no stock available', 'error');
                    return;
                }
                // Populate sell form with item data
                populateSellForm(item);
                openModal('sell-item-modal');
            } else {
                showNotification('Item not found', 'error');
            }
        } else {
            showNotification('Error loading item data', 'error');
        }
    }).fail(function() {
        showNotification('Network error loading item', 'error');
    });
}

// Helper function to populate edit form
function populateEditForm(item) {
    const form = document.getElementById('edit-item-form');
    if (!form) return;
    
    form.querySelector('[name="id"]').value = item.id;
    form.querySelector('[name="name"]').value = item.name || '';
    form.querySelector('[name="description"]').value = item.description || '';
    
    // Handle hierarchical category selection
    const categorySelect = form.querySelector('#edit-category-select');
    if (categorySelect && item.category_id) {
        categorySelect.value = item.category_id;
        
        // If the value wasn't set (category might not exist anymore), highlight this
        if (categorySelect.value != item.category_id) {
            console.warn('Category ID', item.category_id, 'not found in dropdown');
            showNotification('Warning: This item\'s category may have been deleted', 'warning');
        }
    }
    
    form.querySelector('[name="location_id"]').value = item.location_id || '';
    form.querySelector('[name="quantity"]').value = item.quantity || 0;
    form.querySelector('[name="min_stock_level"]').value = item.min_stock_level || 1;
    form.querySelector('[name="purchase_price"]').value = item.purchase_price || '';
    form.querySelector('[name="selling_price"]').value = item.selling_price || '';
    form.querySelector('[name="total_lot_price"]').value = item.total_lot_price || '';
    form.querySelector('[name="supplier"]').value = item.supplier || '';
    form.querySelector('[name="tested_status"]').value = (item.tested_status === 'tested' || item.tested_status === '1') ? 'tested' : 'not_tested';
}

// Helper function to populate sell form
function populateSellForm(item) {
    const form = document.getElementById('sell-item-form');
    if (!form) return;
    
    form.querySelector('[name="item_id"]').value = item.id;
    form.querySelector('#sell-item-name').textContent = item.name;
    form.querySelector('#sell-available-stock').textContent = item.quantity;
    form.querySelector('[name="quantity"]').max = item.quantity;
    form.querySelector('[name="unit_price"]').value = item.selling_price || '';
}

// Toggle tested status function
function toggleTestedStatus(itemId, buttonElement) {
    if (!itemId) {
        showNotification('Invalid item ID', 'error');
        return;
    }
    
    // Get current status from button classes
    const isTested = buttonElement.classList.contains('tested');
    const newStatus = isTested ? 'not_tested' : 'tested';
    
    // Optimistically update UI
    const icon = buttonElement.querySelector('i');
    const text = buttonElement.querySelector('i').nextSibling;
    
    if (newStatus === 'tested') {
        buttonElement.classList.remove('not-tested');
        buttonElement.classList.add('tested');
        icon.className = 'fas fa-check-circle';
        buttonElement.innerHTML = '<i class="fas fa-check-circle"></i>Tested';
    } else {
        buttonElement.classList.remove('tested');
        buttonElement.classList.add('not-tested');
        icon.className = 'fas fa-clock';
        buttonElement.innerHTML = '<i class="fas fa-clock"></i>Not Tested';
    }
    
    // Send AJAX request to update backend
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'update_item_tested_status',
        nonce: warehouse_ajax.nonce,
        item_id: itemId,
        tested_status: newStatus
    }, function(response) {
        if (response.success) {
            showNotification(`Item marked as ${newStatus === 'tested' ? 'tested' : 'not tested'}`, 'success');
        } else {
            // Revert UI changes on error
            if (newStatus === 'tested') {
                buttonElement.classList.remove('tested');
                buttonElement.classList.add('not-tested');
                buttonElement.innerHTML = '<i class="fas fa-clock"></i>Not Tested';
            } else {
                buttonElement.classList.remove('not-tested');
                buttonElement.classList.add('tested');
                buttonElement.innerHTML = '<i class="fas fa-check-circle"></i>Tested';
            }
            showNotification('Error updating tested status: ' + (response.data || 'Unknown error'), 'error');
        }
    }).fail(function() {
        // Revert UI changes on network error
        if (newStatus === 'tested') {
            buttonElement.classList.remove('tested');
            buttonElement.classList.add('not-tested');
            buttonElement.innerHTML = '<i class="fas fa-clock"></i>Not Tested';
        } else {
            buttonElement.classList.remove('not-tested');
            buttonElement.classList.add('tested');
            buttonElement.innerHTML = '<i class="fas fa-check-circle"></i>Tested';
        }
        showNotification('Network error updating tested status', 'error');
    });
}

// Notification function
function showNotification(message, type = 'info') {
    // Remove existing notifications
    const existing = document.querySelector('.notification-toast');
    if (existing) {
        existing.remove();
    }
    
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification-toast notification-${type}`;
    notification.innerHTML = `
        <div style="display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-${type === 'info' ? 'info-circle' : type === 'success' ? 'check-circle' : 'exclamation-triangle'}"></i>
            <span>${message}</span>
        </div>
        <button onclick="this.parentElement.remove()" style="background: none; border: none; color: inherit; cursor: pointer; font-size: 18px; padding: 0; margin-left: 10px;">&times;</button>
    `;
    
    // Add to page
    document.body.appendChild(notification);
    
    // Auto-remove after 5 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, 5000);
}
</script>

<style>
.inventory-content {
    padding: 2rem 0;
}

.search-row {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr auto;
    gap: 1rem;
    align-items: end;
}

@media (max-width: 768px) {
    .search-row {
        grid-template-columns: 1fr;
    }
}

.empty-state {
    text-align: center;
    padding: 3rem;
    background: white;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

/* Lot Price Section Styles */
.lot-price-section {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    padding: 1.5rem;
    margin: 1rem 0;
}

.lot-price-container {
    position: relative;
}

.lot-price-help {
    display: block;
    margin-top: 0.5rem;
    color: #64748b;
    font-style: italic;
}

.lot-calculations {
    margin-top: 1rem;
    background: white;
    border-radius: 6px;
    padding: 1rem;
    border: 1px solid #e2e8f0;
}

.calc-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem 0;
    border-bottom: 1px solid #f1f5f9;
}

.calc-row:last-child {
    border-bottom: none;
}

.calc-row.total-row {
    font-weight: 600;
    border-top: 2px solid #e2e8f0;
    margin-top: 0.5rem;
    padding-top: 1rem;
    color: #1e293b;
}

.calc-label {
    color: #475569;
}

.calc-value {
    font-weight: 500;
    color: #1e293b;
}

.total-row .calc-value {
    color: #059669;
    font-size: 1.1em;
}

/* Price label base styles */
.price-label {
    display: inline-block;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-weight: 600;
    font-size: 0.875rem;
    margin-right: 0.5rem;
    margin-bottom: 0.25rem;
    border: 1px solid transparent;
    transition: all 0.2s ease;
}

/* Cost price display - reddish/orange theme */
.price-label.cost-price {
    background: #fef3c7;
    color: #92400e;
    border-color: #fde68a;
}

.price-label.cost-price:hover {
    background: #fde68a;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(146, 64, 14, 0.15);
}

/* Sell price display - blue/teal theme */
.price-label.sell-price {
    background: #ecfeff;
    color: #0891b2;
    border-color: #a5f3fc;
}

.price-label.sell-price:hover {
    background: #cffafe;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(8, 145, 178, 0.15);
}

/* Lot price display - green theme (existing) */
.price-label.lot-price {
    background: #f0fdf4;
    color: #059669;
    border-color: #bbf7d0;
}

.price-label.lot-price:hover {
    background: #dcfce7;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(5, 150, 105, 0.15);
}

/* Item pricing container */
.item-pricing {
    margin-top: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #f1f5f9;
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    align-items: center;
}

/* Notification styles */
.notification-toast {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000000;
    padding: 15px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 400px;
    font-size: 14px;
    animation: slideInRight 0.3s ease-out;
}

.notification-info {
    background: #eff6ff;
    color: #1e40af;
    border: 1px solid #bfdbfe;
}

.notification-success {
    background: #f0fdf4;
    color: #166534;
    border: 1px solid #bbf7d0;
}

.notification-error {
    background: #fef2f2;
    color: #dc2626;
    border: 1px solid #fecaca;
}

/* Improved inventory card layout */
.inventory-item {
    position: relative;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    padding: 1.5rem;
    transition: all 0.2s ease;
}

.inventory-item:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    border-color: #d1d5db;
}

.item-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1rem;
    gap: 1rem;
}

.item-info {
    flex: 1;
    min-width: 0; /* Allows text to truncate if needed */
}

.item-name {
    margin: 0 0 0.5rem 0;
    font-size: 1.25rem;
    font-weight: 600;
    color: #111827;
    line-height: 1.3;
    word-wrap: break-word;
}

.item-id {
    font-size: 0.875rem;
    color: #6b7280;
    font-weight: 500;
}

.item-status-badges {
    margin-top: 0.75rem;
    display: flex;
    gap: 0.5rem;
}

.tested-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.375rem;
    padding: 0.375rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
    text-transform: uppercase;
    letter-spacing: 0.025em;
}

.tested-badge.tested {
    background: #dcfce7;
    color: #166534;
    border: 1px solid #bbf7d0;
}

.tested-badge.tested:hover {
    background: #bbf7d0;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(22, 101, 52, 0.15);
}

.tested-badge.not-tested {
    background: #fef3c7;
    color: #92400e;
    border: 1px solid #fde68a;
}

.tested-badge.not-tested:hover {
    background: #fde68a;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(146, 64, 14, 0.15);
}

.tested-badge i {
    font-size: 0.875rem;
}

.item-actions {
    display: flex;
    gap: 0.5rem;
    flex-shrink: 0;
    align-items: flex-start;
}

.btn-icon {
    width: 36px;
    height: 36px;
    border-radius: 6px;
    border: 1px solid #e5e7eb;
    background: #f9fafb;
    color: #6b7280;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
    font-size: 14px;
}

.btn-icon:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.edit-btn:hover {
    background: #eff6ff;
    border-color: #3b82f6;
    color: #3b82f6;
}

.sell-btn:hover {
    background: #f0fdf4;
    border-color: #059669;
    color: #059669;
}

.delete-btn:hover {
    background: #fef2f2;
    border-color: #dc2626;
    color: #dc2626;
}

/* Ensure content below header has proper spacing */
.inventory-item .item-details {
    margin-top: 1rem;
}

/* Make sure the grid layout is responsive */
.inventory-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

@media (max-width: 768px) {
    .inventory-grid {
        grid-template-columns: 1fr;
    }
    
    .item-header {
        gap: 0.75rem;
    }
    
    .item-actions {
        gap: 0.25rem;
    }
    
    .btn-icon {
        width: 32px;
        height: 32px;
        font-size: 12px;
    }
 }
 
 .notification-warning {
    background: #fffbeb;
    color: #92400e;
    border: 1px solid #fed7aa;
}

/* Highlight animation */
@keyframes highlight-flash {
    0% { 
        box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
        transform: scale(1);
    }
    50% { 
        box-shadow: 0 0 0 20px rgba(16, 185, 129, 0);
        transform: scale(1.02);
    }
    100% { 
        box-shadow: 0 0 0 0 rgba(16, 185, 129, 0);
        transform: scale(1);
    }
}

@keyframes slideInRight {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}
</style>

<!-- Inactive Items Modal -->
<div id="inactive-items-modal" style="display: none; position: fixed !important; top: 0 !important; left: 0 !important; width: 100vw !important; height: 100vh !important; background: rgba(0, 0, 0, 0.6) !important; z-index: 999999 !important; overflow-y: auto !important;">
    <div class="modal" style="position: absolute !important; top: 50% !important; left: 50% !important; transform: translate(-50%, -50%) !important; border-radius: 8px !important; width: 95% !important; max-width: 1000px !important; max-height: 85vh !important; overflow-y: auto !important; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3) !important;">
        <div style="padding: 20px !important; display: flex !important; justify-content: space-between !important; align-items: center !important; border-radius: 8px 8px 0 0 !important;">
            <h3 style="margin: 0 !important; color: #111827 !important; font-size: 1.25rem !important; display: flex !important; align-items: center !important; gap: 10px !important;">
                <i class="fas fa-trash-alt" style="color: #dc2626 !important;"></i>
                Inactive Items Cleanup
            </h3>
            <button onclick="closeInactiveItemsModal()" style="background: none !important; border: none !important; font-size: 24px !important; cursor: pointer !important; color: #6b7280 !important; padding: 0 !important; width: 30px !important; height: 30px !important; display: flex !important; align-items: center !important; justify-content: center !important;">&times;</button>
        </div>
        
        <div style="padding: 20px !important;">
            <div style="background: #fff3cd !important; border: 1px solid #ffeaa7 !important; border-radius: 6px !important; padding: 15px !important; margin-bottom: 20px !important;">
                <div style="display: flex !important; align-items: center !important; gap: 10px !important; margin-bottom: 10px !important;">
                    <i class="fas fa-exclamation-triangle" style="color: #d97706 !important; font-size: 18px !important;"></i>
                    <strong style="color: #92400e !important;">Warning: Permanent Deletion</strong>
                </div>
                <p style="margin: 0 !important; color: #92400e !important; font-size: 14px !important; line-height: 1.4 !important;">
                    These items were previously marked as deleted but are still in the database. 
                    Permanently deleting them will remove all traces including sales history and cannot be undone.
                </p>
            </div>
            
            <div style="display: flex !important; justify-content: space-between !important; align-items: center !important; margin-bottom: 20px !important;">
                <div style="display: flex !important; align-items: center !important; gap: 15px !important;">
                    <span style="color: #6b7280 !important; font-size: 14px !important;">Found <span id="inactive-count">0</span> inactive items</span>
                    <button onclick="refreshInactiveItems()" style="padding: 6px 12px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; background: white !important; color: #6b7280 !important; cursor: pointer !important; font-size: 12px !important; display: flex !important; align-items: center !important; gap: 5px !important;">
                        <i class="fas fa-refresh"></i> Refresh
                    </button>
                </div>
                
                <button onclick="bulkDeleteInactiveItems()" style="padding: 8px 16px !important; border: none !important; border-radius: 4px !important; background: #dc2626 !important; color: white !important; cursor: pointer !important; font-size: 14px !important; display: flex !important; align-items: center !important; gap: 8px !important;">
                    <i class="fas fa-trash-alt"></i> Delete All Inactive Items
                </button>
            </div>
            
            <div id="inactive-items-list" style="max-height: 400px !important; overflow-y: auto !important; border: 1px solid #e5e7eb !important; border-radius: 6px !important;">
                <div style="text-align: center !important; padding: 40px !important; color: #6b7280 !important;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 24px !important; margin-bottom: 10px !important;"></i>
                    <p style="margin: 0 !important;">Loading inactive items...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Inactive Items Management
function openInactiveItemsModal() {
    document.getElementById('inactive-items-modal').style.display = 'block';
    loadInactiveItems();
}

function closeInactiveItemsModal() {
    document.getElementById('inactive-items-modal').style.display = 'none';
}

function loadInactiveItems() {
    const listContainer = document.getElementById('inactive-items-list');
    const countElement = document.getElementById('inactive-count');
    
    // Show loading
    listContainer.innerHTML = `
        <div style="text-align: center; padding: 40px; color: #6b7280;">
            <i class="fas fa-spinner fa-spin" style="font-size: 24px; margin-bottom: 10px;"></i>
            <p style="margin: 0;">Loading inactive items...</p>
        </div>
    `;
    
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'get_inactive_items',
        nonce: warehouse_ajax.nonce
    }, function(response) {
        if (response.success) {
            const items = response.data;
            countElement.textContent = items.length;
            
            if (items.length === 0) {
                listContainer.innerHTML = `
                    <div style="text-align: center; padding: 40px; color: #6b7280;">
                        <i class="fas fa-check-circle" style="font-size: 48px; color: #10b981; margin-bottom: 15px;"></i>
                        <h4 style="margin: 0 0 10px 0; color: #111827;">All Clean!</h4>
                        <p style="margin: 0;">No inactive items found. Your database is clean.</p>
                    </div>
                `;
                return;
            }
            
            let html = `
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="background: #f9fafb; border-bottom: 1px solid #e5e7eb;">
                            <th style="padding: 12px; text-align: left; font-weight: 600; color: #374151;">Item</th>
                            <th style="padding: 12px; text-align: left; font-weight: 600; color: #374151;">ID</th>
                            <th style="padding: 12px; text-align: left; font-weight: 600; color: #374151;">Category</th>
                            <th style="padding: 12px; text-align: left; font-weight: 600; color: #374151;">Quantity</th>
                            <th style="padding: 12px; text-align: left; font-weight: 600; color: #374151;">Deleted At</th>
                            <th style="padding: 12px; text-align: center; font-weight: 600; color: #374151;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
            `;
            
            items.forEach(item => {
                html += `
                    <tr style="border-bottom: 1px solid #f3f4f6;" id="inactive-item-${item.id}">
                        <td style="padding: 12px; color: #111827; font-weight: 500;">${item.name}</td>
                        <td style="padding: 12px; color: #6b7280; font-family: monospace;">${item.internal_id || 'N/A'}</td>
                        <td style="padding: 12px; color: #6b7280;">${item.category_name || 'Uncategorized'}</td>
                        <td style="padding: 12px; color: #6b7280;">${item.quantity || 0}</td>
                        <td style="padding: 12px; color: #6b7280; font-size: 12px;">${item.updated_at || 'Unknown'}</td>
                        <td style="padding: 12px; text-align: center;">
                            <button onclick="permanentlyDeleteItem(${item.id}, '${item.name.replace(/'/g, "\\'")}', this)" 
                                    style="padding: 6px 12px; background: #dc2626; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; display: flex; align-items: center; gap: 5px; margin: 0 auto;">
                                <i class="fas fa-trash"></i> Delete Forever
                            </button>
                        </td>
                    </tr>
                `;
            });
            
            html += '</tbody></table>';
            listContainer.innerHTML = html;
        } else {
            listContainer.innerHTML = `
                <div style="text-align: center; padding: 40px; color: #dc2626;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 48px; margin-bottom: 15px;"></i>
                    <h4 style="margin: 0 0 10px 0;">Error Loading Items</h4>
                    <p style="margin: 0;">${response.data || 'Failed to load inactive items'}</p>
                </div>
            `;
        }
    }).fail(function() {
        listContainer.innerHTML = `
            <div style="text-align: center; padding: 40px; color: #dc2626;">
                <i class="fas fa-exclamation-triangle" style="font-size: 48px; margin-bottom: 15px;"></i>
                <h4 style="margin: 0 0 10px 0;">Connection Error</h4>
                <p style="margin: 0;">Failed to connect to server</p>
            </div>
        `;
    });
}

function refreshInactiveItems() {
    loadInactiveItems();
}

function permanentlyDeleteItem(itemId, itemName, button) {
    if (!confirm(`⚠️ PERMANENTLY DELETE "${itemName}"?\n\nThis will:\n• Delete the item completely\n• Delete all related sales records\n• Remove all traces from the database\n\nThis action CANNOT be undone!\n\nAre you absolutely sure?`)) {
        return;
    }
    
    // Show loading on button
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
    button.disabled = true;
    
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'permanently_delete_item',
        nonce: warehouse_ajax.nonce,
        id: itemId
    }, function(response) {
        if (response.success) {
            // Remove the row with animation
            const row = document.getElementById(`inactive-item-${itemId}`);
            if (row) {
                row.style.background = '#fef2f2';
                row.style.transform = 'translateX(100%)';
                row.style.opacity = '0';
                row.style.transition = 'all 0.3s ease';
                
                setTimeout(() => {
                    row.remove();
                    
                    // Update count
                    const countElement = document.getElementById('inactive-count');
                    countElement.textContent = parseInt(countElement.textContent) - 1;
                    
                    // Check if no more items
                    const remaining = document.querySelectorAll('#inactive-items-list tbody tr').length;
                    if (remaining === 0) {
                        loadInactiveItems(); // Reload to show "All Clean" message
                    }
                }, 300);
            }
            
            let message = `"${response.data.item_name}" permanently deleted`;
            if (response.data.sales_deleted > 0) {
                message += ` (${response.data.sales_deleted} sales records also deleted)`;
            }
            showNotification(message, 'success');
            
            // Refresh category counts since item was deleted
            if (typeof refreshCategoryCounts === 'function') {
                refreshCategoryCounts();
            }
        } else {
            showNotification(response.data || 'Failed to delete item', 'error');
            button.innerHTML = '<i class="fas fa-trash"></i> Delete Forever';
            button.disabled = false;
        }
    }).fail(function() {
        showNotification('Network error deleting item', 'error');
        button.innerHTML = '<i class="fas fa-trash"></i> Delete Forever';
        button.disabled = false;
    });
}

function bulkDeleteInactiveItems() {
    if (!confirm(`⚠️ PERMANENTLY DELETE ALL INACTIVE ITEMS?\n\nThis will:\n• Delete ALL inactive items completely\n• Delete ALL related sales records\n• Remove ALL traces from the database\n\nThis action CANNOT be undone!\n\nType "DELETE ALL" to confirm:`)) {
        return;
    }
    
    const confirmation = prompt('Type "DELETE ALL" to confirm bulk deletion:');
    if (confirmation !== 'DELETE ALL') {
        showNotification('Bulk deletion cancelled - confirmation text did not match', 'warning');
        return;
    }
    
    // Show loading
    const listContainer = document.getElementById('inactive-items-list');
    listContainer.innerHTML = `
        <div style="text-align: center; padding: 40px; color: #dc2626;">
            <i class="fas fa-spinner fa-spin" style="font-size: 24px; margin-bottom: 10px;"></i>
            <p style="margin: 0; font-weight: 600;">Permanently deleting all inactive items...</p>
            <p style="margin: 10px 0 0 0; font-size: 14px;">This may take a moment.</p>
        </div>
    `;
    
    jQuery.post(warehouse_ajax.ajax_url, {
        action: 'bulk_cleanup_inactive_items',
        nonce: warehouse_ajax.nonce
    }, function(response) {
        if (response.success) {
            showNotification(response.data.message + ` (${response.data.sales_deleted} sales records also deleted)`, 'success');
            loadInactiveItems(); // Reload to show "All Clean" message
            
            // Refresh category counts since items were deleted
            if (typeof refreshCategoryCounts === 'function') {
                refreshCategoryCounts();
            }
        } else {
            showNotification(response.data || 'Failed to cleanup inactive items', 'error');
            loadInactiveItems(); // Reload the list
        }
    }).fail(function() {
        showNotification('Network error during bulk cleanup', 'error');
        loadInactiveItems(); // Reload the list
    });
}

// Close modal when clicking outside
window.addEventListener('click', function(event) {
    const modal = document.getElementById('inactive-items-modal');
    if (event.target === modal) {
        closeInactiveItemsModal();
    }
});
</script> 
