<?php
/**
 * Locations Management Template Part - Hierarchical View
 */

$locations_tree = get_locations_tree();
$all_locations = get_all_locations();

function render_location_tree($locations, $level = 0) {
    if (empty($locations)) return;
    
    foreach ($locations as $location) {
        $indent = str_repeat('  ', $level);
        $has_children = !empty($location->children);
        
        // Map location type to icon
        $type_icons = [
            'warehouse' => 'warehouse',
            'town' => 'city',
            'section' => 'th-large',
            'aisle' => 'arrows-alt-h',
            'rack' => 'layer-group',
            'shelf' => 'bars',
            'bin' => 'box'
        ];
        $icon = $type_icons[$location->type] ?? 'map-marker-alt';
        
        // Map location type to color
        $type_colors = [
            'warehouse' => '#8b5cf6',
            'town' => '#06b6d4', 
            'section' => '#10b981',
            'aisle' => '#f59e0b',
            'rack' => '#ef4444',
            'shelf' => '#6366f1',
            'bin' => '#84cc16'
        ];
        $color = $type_colors[$location->type] ?? '#6b7280';
        ?>
        <div class="location-row" data-level="<?php echo $level; ?>" data-location-id="<?php echo $location->id; ?>">
            <div class="location-content">
                <div class="location-indent" style="width: <?php echo $level * 20; ?>px;"></div>
                
                <?php if ($has_children): ?>
                    <button class="location-toggle" onclick="toggleLocationChildren(<?php echo $location->id; ?>)">
                        <i class="fas fa-chevron-down"></i>
                    </button>
                <?php else: ?>
                    <div class="location-spacer"></div>
                <?php endif; ?>
                
                <div class="location-icon" style="background-color: <?php echo esc_attr($color); ?>">
                    <i class="fas fa-<?php echo esc_attr($icon); ?>"></i>
                </div>
                
                <div class="location-info">
                    <div class="location-header">
                        <span class="location-name"><?php echo esc_html($location->name); ?></span>
                        <?php if (!empty($location->code)): ?>
                            <span class="location-code"><?php echo esc_html($location->code); ?></span>
                        <?php endif; ?>
                        <span class="location-type"><?php echo ucfirst($location->type); ?></span>
                        <?php if (isset($location->item_count) && $location->item_count > 0): ?>
                            <span class="item-count"><?php echo $location->item_count; ?> items</span>
                        <?php endif; ?>
                    </div>
                    <?php 
                        if (function_exists('get_location_path')) {
                            $path_nodes = get_location_path($location->id);
                            if (!empty($path_nodes)) {
                                $path_names = array_map(function($n){ return esc_html($n->name); }, $path_nodes);
                                echo '<div class="location-description" style="margin-top:2px">' . implode(' / ', $path_names) . '</div>';
                            }
                        }
                    ?>
                    <?php if (!empty($location->description)): ?>
                        <div class="location-description"><?php echo esc_html($location->description); ?></div>
                    <?php endif; ?>
                </div>
                
                <div class="location-actions">
                    <button class="action-btn add-sublocation" onclick="openLocationModal(<?php echo $location->id; ?>)" title="Add Sub-location">
                        <i class="fas fa-plus"></i>
                    </button>
                    <button class="action-btn edit-location" onclick="editLocation(<?php echo $location->id; ?>)" title="Edit Location">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn generate-qr" onclick="generateQR(<?php echo $location->id; ?>)" title="Generate QR Code">
                        <i class="fas fa-qrcode"></i>
                    </button>
                    <button class="action-btn delete-location" onclick="deleteLocation(<?php echo $location->id; ?>)" title="Delete Location">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            
            <?php if ($has_children): ?>
                <div class="location-children" id="children-<?php echo $location->id; ?>">
                    <?php render_location_tree($location->children, $level + 1); ?>
                </div>
            <?php endif; ?>
        </div>
        <?php
    }
}
?>

<div class="warehouse-content">
    <div class="page-header">
        <h2><?php echo function_exists('wh_t') ? wh_t('Locations Management') : 'Locations Management'; ?></h2>
        <div class="header-actions">
            <button class="btn btn-secondary" onclick="toggleAllLocations()">
                <i class="fas fa-expand-arrows-alt"></i> <?php echo function_exists('wh_t') ? wh_t('Expand All') : 'Expand All'; ?>
            </button>
            <button class="btn btn-primary" onclick="openLocationModal()">
                <i class="fas fa-plus"></i> <?php echo function_exists('wh_t') ? wh_t('Add Location') : 'Add Location'; ?>
            </button>
        </div>
    </div>

    <div class="locations-container">
        <?php if (!empty($locations_tree)): ?>
            <div class="locations-tree">
                <?php render_location_tree($locations_tree); ?>
            </div>
        <?php else: ?>
            <div class="no-data">
                <i class="fas fa-map-marker-alt"></i>
                <h3>No Locations Found</h3>
                <p>Start by adding your first location to organize your warehouse layout.</p>
                <button class="btn btn-primary" onclick="openLocationModal()">
                    <i class="fas fa-plus"></i> Add Your First Location
                </button>
            </div>
        <?php endif; ?>
    </div>
</div>

<!-- Add/Edit Location Modal -->
<div id="add-location-modal" class="modal-overlay" style="display:none;">
    <div class="modal">
        <div class="modal-header">
            <h3 id="modalTitle" class="modal-title">Add New Location</h3>
            <button class="modal-close" onclick="closeLocationModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="add-location-form">
                <table class="modal-form">
                    <tr>
                        <td>
                            <label class="form-label">Location Name *</label>
                            <input type="text" id="locationName" name="name" required class="form-input">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Location Code</label>
                            <input type="text" id="locationCode" name="code" class="form-input">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Parent Location</label>
                            <select name="parent_id" id="parentLocation" class="form-select">
                                <option value="">None (Top Level)</option>
                                <?php 
                                // Get hierarchical locations for parent selection
                                foreach ($all_locations as $loc):
                                    $display_name = $loc->name;
                                    $indent = '';
                                    
                                    if ($loc->level > 1) {
                                        $indent = str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $loc->level - 1) . '↳ ';
                                    }
                                ?>
                                    <option value="<?php echo $loc->id; ?>" data-level="<?php echo $loc->level; ?>" data-parent-id="<?php echo $loc->parent_id ?: ''; ?>">
                                        <?php echo $indent . esc_html($display_name); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Type</label>
                            <select name="type" id="locationType" class="form-select">
                                <option value="town">Town</option>
                                <option value="warehouse">Warehouse</option>
                                <option value="section">Section</option>
                                <option value="aisle">Aisle</option>
                                <option value="rack">Rack</option>
                                <option value="shelf">Shelf</option>
                                <option value="bin">Bin</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Description</label>
                            <textarea name="description" id="locationDescription" rows="3" placeholder="Optional description for this location..." class="form-input"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeLocationModal()">Cancel</button>
            <button type="button" id="submitLocationBtn" class="btn btn-primary" onclick="submitAddLocation()">Add Location</button>
        </div>
    </div>
</div>

<style>
.warehouse-content {
    padding: 2rem 0;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.header-actions {
    display: flex;
    gap: 0.5rem;
}

.locations-container {
    background: white;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    overflow: hidden;
}

.locations-tree {
    max-height: 70vh;
    overflow-y: auto;
}

.location-row {
    border-bottom: 1px solid #f3f4f6;
    transition: background-color 0.2s;
}

.location-row:hover {
    background-color: #f9fafb;
}

.location-content {
    display: flex;
    align-items: center;
    padding: 12px 16px;
    gap: 8px;
}

.location-indent {
    flex-shrink: 0;
}

.location-toggle {
    width: 24px;
    height: 24px;
    border: none;
    background: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 4px;
    color: #6b7280;
    transition: all 0.2s;
}

.location-toggle:hover {
    background-color: #f3f4f6;
    color: #374151;
}

.location-toggle.expanded i {
    transform: rotate(180deg);
}

.location-spacer {
    width: 24px;
    height: 24px;
}

.location-icon {
    width: 32px;
    height: 32px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 14px;
    flex-shrink: 0;
}

.location-info {
    flex: 1;
    min-width: 0;
}

.location-header {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
}

.location-name {
    font-weight: 600;
    color: #111827;
    font-size: 14px;
}

.location-code {
    background: #f3f4f6;
    color: #6b7280;
    padding: 2px 6px;
    border-radius: 4px;
    font-size: 12px;
    font-family: monospace;
}

.location-type {
    background: #dbeafe;
    color: #1e40af;
    padding: 2px 6px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 500;
}

.item-count {
    color: #059669;
    font-size: 12px;
    font-weight: 500;
}

.location-description {
    color: #6b7280;
    font-size: 13px;
    margin-top: 4px;
    line-height: 1.4;
}

.location-actions {
    display: flex;
    gap: 4px;
    margin-left: auto;
}

.action-btn {
    width: 32px;
    height: 32px;
    border: none;
    background: none;
    cursor: pointer;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #6b7280;
    transition: all 0.2s;
    font-size: 14px;
}

.action-btn:hover {
    background-color: #f3f4f6;
    color: #374151;
}

.action-btn.delete-location:hover {
    background-color: #fee2e2;
    color: #dc2626;
}

.location-children {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease-out;
}

.location-children.expanded {
    max-height: 1000px;
}

.no-data {
    text-align: center;
    padding: 4rem 2rem;
    color: #6b7280;
}

.no-data i {
    font-size: 4rem;
    color: #d1d5db;
    margin-bottom: 1rem;
}

.no-data h3 {
    color: #374151;
    margin-bottom: 0.5rem;
}

.btn {
    padding: 8px 16px;
    border-radius: 6px;
    font-weight: 500;
    cursor: pointer;
    border: none;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: all 0.2s;
}

.btn-primary {
    background: #3b82f6;
    color: white;
}

.btn-primary:hover {
    background: #2563eb;
}

.btn-secondary {
    background: #f3f4f6;
    color: #374151;
    border: 1px solid #d1d5db;
}

.btn-secondary:hover {
    background: #e5e7eb;
}
</style>

<script>
let currentEditingLocationId = null;

function toggleLocationChildren(locationId) {
    const children = document.getElementById('children-' + locationId);
    const toggle = document.querySelector(`[data-location-id="${locationId}"] .location-toggle`);
    
    if (children) {
        if (children.classList.contains('expanded')) {
            children.classList.remove('expanded');
            toggle.classList.remove('expanded');
        } else {
            children.classList.add('expanded');
            toggle.classList.add('expanded');
        }
    }
}

function toggleAllLocations() {
    const allChildren = document.querySelectorAll('.location-children');
    const allToggles = document.querySelectorAll('.location-toggle');
    const button = event.target.closest('button');
    
    const isExpanding = button.textContent.includes('Expand');
    
    allChildren.forEach(child => {
        if (isExpanding) {
            child.classList.add('expanded');
        } else {
            child.classList.remove('expanded');
        }
    });
    
    allToggles.forEach(toggle => {
        if (isExpanding) {
            toggle.classList.add('expanded');
        } else {
            toggle.classList.remove('expanded');
        }
    });
    
    button.innerHTML = isExpanding ? 
        '<i class="fas fa-compress-arrows-alt"></i> Collapse All' : 
        '<i class="fas fa-expand-arrows-alt"></i> Expand All';
}

function openLocationModal(parentId = null) {
    const modal = document.getElementById('add-location-modal');
    const title = document.getElementById('modalTitle');
    const form = document.getElementById('add-location-form');
    const submitBtn = document.getElementById('submitLocationBtn');
    // Disable smooth scrolling while modal is open to prevent native select flicker
    try { document.documentElement.style.scrollBehavior = 'auto'; } catch(_) {}
    
    // Reset form
    form.reset();
    currentEditingLocationId = null;
    
    if (parentId) {
        title.textContent = 'Add Sub-location';
        document.getElementById('parentLocation').value = parentId;
        submitBtn.textContent = 'Add Sub-location';
    } else {
        title.textContent = 'Add New Location';
        submitBtn.textContent = 'Add Location';
    }
    
    modal.style.display = 'block';
}

function closeLocationModal() {
    const modal = document.getElementById('add-location-modal');
    modal.style.display = 'none';
    currentEditingLocationId = null;
    try { document.documentElement.style.scrollBehavior = ''; } catch(_) {}
}

function editLocation(locationId) {
    // Get location data via AJAX
    jQuery.ajax({
        url: warehouse_ajax.ajax_url,
        type: 'POST',
        data: {
            action: 'get_location_data',
            location_id: locationId,
            nonce: warehouse_ajax.nonce
        },
        success: function(response) {
            if (response.success) {
                const location = response.data;
                currentEditingLocationId = locationId;
                
                // Populate form
                document.getElementById('locationName').value = location.name || '';
                document.getElementById('locationCode').value = location.code || '';
                document.getElementById('parentLocation').value = location.parent_id || '';
                document.getElementById('locationType').value = location.type || 'warehouse';
                document.getElementById('locationDescription').value = location.description || '';
                
                // Update modal
                document.getElementById('modalTitle').textContent = 'Edit Location';
                document.getElementById('submitLocationBtn').textContent = 'Update Location';
                document.getElementById('add-location-modal').style.display = 'block';
            } else {
                alert('Error loading location data: ' + (response.data || 'Unknown error'));
            }
        },
        error: function() {
            alert('Error communicating with server');
        }
    });
}

function submitAddLocation() {
    const form = document.getElementById('add-location-form');
    const formData = new FormData(form);
    
    const action = currentEditingLocationId ? 'update_location' : 'add_location';
    formData.append('action', action);
    formData.append('nonce', warehouse_ajax.nonce);
    
    if (currentEditingLocationId) {
        formData.append('location_id', currentEditingLocationId);
    }
    
    jQuery.ajax({
        url: warehouse_ajax.ajax_url,
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                closeLocationModal();
                location.reload(); // Refresh page to show changes
            } else {
                alert('Error: ' + (response.data || 'Unknown error'));
            }
        },
        error: function() {
            alert('Error communicating with server');
        }
    });
}

function deleteLocation(locationId) {
    if (!confirm('Are you sure you want to delete this location? This action cannot be undone.')) {
        return;
    }
    
    jQuery.ajax({
        url: warehouse_ajax.ajax_url,
        type: 'POST',
        data: {
            action: 'delete_location',
            location_id: locationId,
            nonce: warehouse_ajax.nonce
        },
        success: function(response) {
            if (response.success) {
                location.reload(); // Refresh page to show changes
            } else {
                alert('Error deleting location: ' + (response.data || 'Unknown error'));
            }
        },
        error: function() {
            alert('Error communicating with server');
        }
    });
}

function generateQR(locationId) {
    // Implementation for QR code generation
    jQuery.ajax({
        url: warehouse_ajax.ajax_url,
        type: 'POST',
        data: {
            action: 'generate_qr_code',
            location_id: locationId,
            nonce: warehouse_ajax.nonce
        },
        success: function(response) {
            if (response.success) {
                // Show QR code in modal or download
                window.open(response.data.qr_url, '_blank');
            } else {
                alert('Error generating QR code: ' + (response.data || 'Unknown error'));
            }
        },
        error: function() {
            alert('Error communicating with server');
        }
    });
}

// Accessibility: close with Escape; avoid outside-click close to prevent native select issues
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        closeLocationModal();
    }
});

// Stabilize native selects inside the location modal by converting to an inline listbox while focused
;(function(){
    function stabilize(select){
        if (!select) return;
        let opened = false;
        const maxSize = Math.min(8, Math.max(3, select.options.length));
        function open(){ if (opened) return; opened = true; select.size = maxSize; select.setAttribute('data-open','1'); }
        function close(){ if (!opened) return; opened = false; select.size = 0; select.removeAttribute('data-open'); }
        select.addEventListener('focus', open);
        select.addEventListener('mousedown', function(){ open(); });
        select.addEventListener('change', function(){ close(); select.blur(); });
        select.addEventListener('blur', function(){ setTimeout(close, 0); });
    }
    document.addEventListener('DOMContentLoaded', function(){
        stabilize(document.getElementById('parentLocation'));
        stabilize(document.getElementById('locationType'));
    });
})();
</script> 
