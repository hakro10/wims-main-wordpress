<div class="search-input">
    <select id="location-select" class="form-input">
        <option value="">Select Location</option>
        <?php foreach ($locations as $location): ?>
            <option value="<?php echo $location->name; ?>"><?php echo $location->name; ?></option>
        <?php endforeach; ?>
    </select>
    <i class="fas fa-map-marker-alt search-icon"></i>
</div> 

const location = document.getElementById('location-select').value;

$location = isset($_POST['location']) ? sanitize_text_field($_POST['location']) : '';

// Modify the query to include location filtering
if (!empty($location)) {
    $query .= " AND location LIKE '%" . $wpdb->esc_like($location) . "%'";
}

// Update the search and filter handlers
search: search,
location: location,