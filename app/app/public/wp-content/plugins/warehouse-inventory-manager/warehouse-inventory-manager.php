<?php
/**
 * Plugin Name: Warehouse Inventory Manager
 * Description: Complete warehouse inventory management system with items, categories, locations, and QR codes
 * Version: 1.0.0
 * Author: Your Name
 * Text Domain: warehouse-inventory-manager
 */

if (!defined('ABSPATH')) {
    exit;
}

// Plugin constants
define('WH_INVENTORY_VERSION', '1.1.0');
define('WH_INVENTORY_PLUGIN_DIR', plugin_dir_path(__FILE__));
define('WH_INVENTORY_PLUGIN_URL', plugin_dir_url(__FILE__));
define('WH_INVENTORY_DB_VERSION', '1.0');

class WarehouseInventoryManager {
    private static $instance = null;

    public static function getInstance() {
        if (self::$instance == null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    private function __construct() {
        $this->init_hooks();
    }

    private function init_hooks() {
        // Activation and deactivation hooks
        register_activation_hook(__FILE__, array($this, 'activate'));
        register_deactivation_hook(__FILE__, array($this, 'deactivate'));

        // Init plugin
        add_action('plugins_loaded', array($this, 'init_plugin'));
        
        // Admin menus
        add_action('admin_menu', array($this, 'add_menu_pages'));
        
        // AJAX handlers
        
        // Enqueue scripts and styles
        add_action('wp_enqueue_scripts', array($this, 'enqueue_scripts'));
        add_action('admin_enqueue_scripts', array($this, 'admin_enqueue_scripts'));
    }

    public function activate() {
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-activator.php';
        WarehouseInventoryActivator::activate();
    }

    public function deactivate() {
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-deactivator.php';
        WarehouseInventoryDeactivator::deactivate();
    }

    public function init_plugin() {
        // Load dependencies
        $this->load_dependencies();
        
        // Initialize components
        $this->init_components();
    }

    private function load_dependencies() {
        // Core classes
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-loader.php';
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-inventory.php';
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-locations.php';
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-categories.php';
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-qr-codes.php';
    }

    private function init_components() {
        // Initialize components
        $this->inventory = new WH_Inventory();
        $this->locations = new WH_Locations();
        $this->categories = new WH_Categories();
        $this->qr_codes = new WH_QR_Codes();
    }

    public function add_menu_pages() {
        add_menu_page(
            'Warehouse Inventory',
            'Warehouse',
            'manage_options',
            'warehouse-inventory',
            array($this, 'render_main_page'),
            'dashicons-archive',
            30
        );

        // Add submenus
        add_submenu_page(
            'warehouse-inventory',
            'Inventory',
            'Inventory',
            'manage_options',
            'warehouse-inventory',
            array($this, 'render_main_page')
        );

        add_submenu_page(
            'warehouse-inventory',
            'Locations',
            'Locations',
            'manage_options',
            'warehouse-locations',
            array($this, 'render_locations_page')
        );

        add_submenu_page(
            'warehouse-inventory',
            'Categories',
            'Categories',
            'manage_options',
            'warehouse-categories',
            array($this, 'render_categories_page')
        );

        add_submenu_page(
            'warehouse-inventory',
            'QR Codes',
            'QR Codes',
            'manage_options',
            'warehouse-qr-codes',
            array($this, 'render_qr_codes_page')
        );
    }

    public function render_main_page() {
        require_once WH_INVENTORY_PLUGIN_DIR . 'admin/views/inventory.php';
    }

    public function render_locations_page() {
        require_once WH_INVENTORY_PLUGIN_DIR . 'admin/views/locations.php';
    }

    public function render_categories_page() {
        require_once WH_INVENTORY_PLUGIN_DIR . 'admin/views/categories.php';
    }

    public function render_qr_codes_page() {
        require_once WH_INVENTORY_PLUGIN_DIR . 'admin/views/qr-codes.php';
    }

    public function enqueue_scripts() {
        wp_enqueue_style('wh-inventory-style', WH_INVENTORY_PLUGIN_URL . 'assets/css/style.css', array(), WH_INVENTORY_VERSION);
        wp_enqueue_script('wh-inventory-script', WH_INVENTORY_PLUGIN_URL . 'assets/js/script.js', array('jquery'), WH_INVENTORY_VERSION, true);
        
        wp_localize_script('wh-inventory-script', 'whInventory', array(
            'ajax_url' => admin_url('admin-ajax.php'),
            'nonce' => wp_create_nonce('wh_inventory_nonce')
        ));
    }

    public function admin_enqueue_scripts() {
        wp_enqueue_style('wh-inventory-admin-style', WH_INVENTORY_PLUGIN_URL . 'admin/css/admin.css', array(), WH_INVENTORY_VERSION);
        wp_enqueue_script('wh-inventory-admin-script', WH_INVENTORY_PLUGIN_URL . 'admin/js/admin.js', array('jquery'), WH_INVENTORY_VERSION, true);
    }
}

// Initialize the plugin
function run_warehouse_inventory() {
    return WarehouseInventoryManager::getInstance();
}

// Start the plugin
run_warehouse_inventory(); 