<?php

class WH_Locations {
    private $table_name;
    
    public function __construct() {
        global $wpdb;
        $this->table_name = $wpdb->prefix . 'wh_locations';
        
        // Initialize hooks
        add_action('wp_ajax_get_locations', array($this, 'get_locations'));
        add_action('wp_ajax_nopriv_get_locations', array($this, 'get_locations'));
        add_action('wp_ajax_save_location', array($this, 'save_location'));
        add_action('wp_ajax_delete_location', array($this, 'delete_location'));
    }
    
    public function get_locations() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        global $wpdb;
        
        $locations = $wpdb->get_results("
            SELECT l.*, 
                   (SELECT COUNT(*) FROM {$wpdb->prefix}wh_inventory WHERE location_id = l.id) as items_count
            FROM {$this->table_name} l
            ORDER BY l.name ASC
        ");
        
        wp_send_json_success(array(
            'locations' => $locations
        ));
    }
    
    public function save_location() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        if (!current_user_can('manage_options')) {
            wp_send_json_error('Insufficient permissions');
            return;
        }
        
        global $wpdb;
        
        $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
        $data = array(
            'name' => sanitize_text_field($_POST['name']),
            'description' => sanitize_textarea_field($_POST['description']),
            'parent_id' => intval($_POST['parent_id']),
            'level' => intval($_POST['level'])
        );
        
        if ($id > 0) {
            $wpdb->update(
                $this->table_name,
                $data,
                array('id' => $id)
            );
        } else {
            $wpdb->insert($this->table_name, $data);
            $id = $wpdb->insert_id;
        }
        
        wp_send_json_success(array(
            'id' => $id,
            'message' => 'Location saved successfully'
        ));
    }
    
    public function delete_location() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        if (!current_user_can('manage_options')) {
            wp_send_json_error('Insufficient permissions');
            return;
        }
        
        global $wpdb;
        
        $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
        
        // Check if location has items
        $items_count = $wpdb->get_var($wpdb->prepare(
            "SELECT COUNT(*) FROM {$wpdb->prefix}wh_inventory WHERE location_id = %d",
            $id
        ));
        
        if ($items_count > 0) {
            wp_send_json_error('Cannot delete location with assigned items');
            return;
        }
        
        // Check if location has child locations
        $children_count = $wpdb->get_var($wpdb->prepare(
            "SELECT COUNT(*) FROM {$this->table_name} WHERE parent_id = %d",
            $id
        ));
        
        if ($children_count > 0) {
            wp_send_json_error('Cannot delete location with child locations');
            return;
        }
        
        if ($id > 0) {
            $wpdb->delete($this->table_name, array('id' => $id));
            wp_send_json_success('Location deleted successfully');
        } else {
            wp_send_json_error('Invalid location ID');
        }
    }
    
    public function get_locations_hierarchy() {
        global $wpdb;
        
        $locations = $wpdb->get_results("
            SELECT * FROM {$this->table_name}
            ORDER BY level ASC, name ASC
        ");
        
        $hierarchy = array();
        foreach ($locations as $location) {
            if ($location->parent_id == 0) {
                $hierarchy[$location->id] = $location;
                $hierarchy[$location->id]->children = array();
            } else {
                if (isset($hierarchy[$location->parent_id])) {
                    $hierarchy[$location->parent_id]->children[$location->id] = $location;
                }
            }
        }
        
        return $hierarchy;
    }
    
    public function create_tables() {
        global $wpdb;
        
        $charset_collate = $wpdb->get_charset_collate();
        
        $sql = "CREATE TABLE IF NOT EXISTS {$this->table_name} (
            id bigint(20) NOT NULL AUTO_INCREMENT,
            name varchar(255) NOT NULL,
            description text,
            parent_id bigint(20) DEFAULT 0,
            level int(11) DEFAULT 1,
            created_at datetime DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY  (id)
        ) $charset_collate;";
        
        require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
        dbDelta($sql);
    }
} 
