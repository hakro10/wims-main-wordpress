<?php
/**
 * Warehouse Inventory System - Testing Script
 * 
 * This script tests all core functionality of the warehouse inventory system
 * Run: php test-system.php
 */

// Ensure we're in the WordPress environment
if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/');
}

// Load WordPress
require_once ABSPATH . 'wp-load.php';

echo "=== Warehouse Inventory System Test Suite ===\n\n";

// Test 1: Plugin Activation
echo "1. Testing Plugin Activation...\n";
if (class_exists('WarehouseInventoryManager')) {
    echo "✅ Plugin class loaded successfully\n";
} else {
    echo "❌ Plugin class not found\n";
    exit(1);
}

// Test 2: Database Tables
echo "\n2. Testing Database Tables...\n";
global $wpdb;

$tables = [
    $wpdb->prefix . 'wh_inventory_items',
    $wpdb->prefix . 'wh_categories',
    $wpdb->prefix . 'wh_locations',
    $wpdb->prefix . 'wh_sales',
    $wpdb->prefix . 'wh_suppliers',
    $wpdb->prefix . 'wh_team_members',
    $wpdb->prefix . 'wh_stock_movements'
];

foreach ($tables as $table) {
    $exists = $wpdb->get_var("SHOW TABLES LIKE '$table'") === $table;
    echo $exists ? "✅ Table exists: $table\n" : "❌ Table missing: $table\n";
}

// Test 3: Default Data
echo "\n3. Testing Default Data...\n";
$categories = $wpdb->get_var("SELECT COUNT(*) FROM {$wpdb->prefix}wh_categories");
$locations = $wpdb->get_var("SELECT COUNT(*) FROM {$wpdb->prefix}wh_locations");

echo $categories > 0 ? "✅ Categories loaded: $categories\n" : "❌ No categories found\n";
echo $locations > 0 ? "✅ Locations loaded: $locations\n" : "❌ No locations found\n";

// Test 4: AJAX Handlers
echo "\n4. Testing AJAX Handlers...\n";
$plugin = new WarehouseInventoryManager();
$handlers = [
    'get_dashboard_stats',
    'get_inventory_items',
    'add_inventory_item',
    'update_inventory_item',
    'get_categories',
    'get_locations',
    'record_sale'
];

foreach ($handlers as $handler) {
    $method = "handle_$handler";
    if (method_exists($plugin, $method)) {
        echo "✅ Handler exists: $handler\n";
    } else {
        echo "❌ Handler missing: $handler\n";
    }
}

// Test 5: Shortcodes
echo "\n5. Testing Shortcodes...\n";
$shortcodes = ['warehouse_dashboard', 'warehouse_inventory'];
foreach ($shortcodes as $shortcode) {
    if (shortcode_exists($shortcode)) {
        echo "✅ Shortcode registered: $shortcode\n";
    } else {
        echo "❌ Shortcode missing: $shortcode\n";
    }
}

// Test 6: Theme Integration
echo "\n6. Testing Theme Integration...\n";
$theme_dir = get_template_directory();
$theme_files = [
    '/template-parts/modern-dashboard.php',
    '/assets/css/shadcn-components.css',
    '/assets/js/warehouse.js'
];

foreach ($theme_files as $file) {
    $full_path = $theme_dir . $file;
    if (file_exists($full_path)) {
        echo "✅ Theme file exists: $file\n";
    } else {
        echo "❌ Theme file missing: $file\n";
    }
}

// Test 7: Plugin Assets
echo "\n7. Testing Plugin Assets...\n";
$plugin_dir = WP_PLUGIN_DIR . '/warehouse-inventory-manager';
$plugin_files = [
    '/assets/css/admin.css',
    '/assets/js/admin.js',
    '/assets/css/frontend.css',
    '/assets/js/frontend.js'
];

foreach ($plugin_files as $file) {
    $full_path = $plugin_dir . $file;
    if (file_exists($full_path)) {
        echo "✅ Plugin asset exists: $file\n";
    } else {
        echo "❌ Plugin asset missing: $file\n";
    }
}

// Test 8: Database Schema Validation
echo "\n8. Testing Database Schema...\n";
$schema_tests = [
    'wh_inventory_items' => ['id', 'name', 'quantity', 'selling_price'],
    'wh_categories' => ['id', 'name', 'color'],
    'wh_locations' => ['id', 'name', 'type'],
    'wh_sales' => ['id', 'sale_number', 'total_amount']
];

foreach ($schema_tests as $table => $columns) {
    $table_name = $wpdb->prefix . $table;
    $all_exist = true;
    
    foreach ($columns as $column) {
        $exists = $wpdb->get_var("SHOW COLUMNS FROM $table_name LIKE '$column'");
        if (!$exists) {
            $all_exist = false;
            break;
        }
    }
    
    echo $all_exist ? "✅ Schema valid: $table\n" : "❌ Schema invalid: $table\n";
}

// Test 9: User Roles and Capabilities
echo "\n9. Testing User System...\n";
$current_user = wp_get_current_user();
if ($current_user->ID) {
    echo "✅ User logged in: {$current_user->display_name}\n";
    
    $can_edit = current_user_can('edit_posts');
    echo $can_edit ? "✅ User can edit posts\n" : "❌ User cannot edit posts\n";
    
    $can_manage = current_user_can('manage_options');
    echo $can_manage ? "✅ User can manage options\n" : "❌ User cannot manage options\n";
} else {
    echo "❌ No user logged in\n";
}

// Test 10: QR Code Functionality
echo "\n10. Testing QR Code System...\n";
if (class_exists('WH_QR_Codes')) {
    echo "✅ QR Code class loaded\n";
} else {
    echo "❌ QR Code class not found\n";
}

// Summary
echo "\n=== Test Summary ===\n";
echo "System Status: ";
echo "Plugin: " . (class_exists('WarehouseInventoryManager') ? "✅" : "❌") . "\n";
echo "Database: " . (count($tables) === count(array_filter($tables, function($t) use ($wpdb) {
    return $wpdb->get_var("SHOW TABLES LIKE '$t'") === $t;
})) ? "✅" : "❌") . "\n";
echo "Theme: " . (file_exists(get_template_directory() . '/template-parts/modern-dashboard.php') ? "✅" : "❌") . "\n";
echo "Assets: " . (file_exists($plugin_dir . '/assets/css/admin.css') ? "✅" : "❌") . "\n";

echo "\n=== Test Complete ===\n";
echo "Run this test again after making changes to verify system integrity.\n";
?>