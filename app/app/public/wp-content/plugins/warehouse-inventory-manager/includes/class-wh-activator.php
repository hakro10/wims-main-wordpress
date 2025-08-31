<?php

if (!defined('ABSPATH')) { exit; }

class WarehouseInventoryActivator {
    public static function activate() {
        // Ensure required classes are loaded for table creation
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-inventory.php';
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-locations.php';
        require_once WH_INVENTORY_PLUGIN_DIR . 'includes/class-wh-categories.php';

        // Create/upgrade DB tables
        (new WH_Inventory())->create_tables();
        (new WH_Locations())->create_tables();
        (new WH_Categories())->create_tables();

        // Track DB version for future migrations
        update_option('wh_inventory_db_version', WH_INVENTORY_DB_VERSION);
    }
}

