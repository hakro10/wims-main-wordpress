<?php

class WH_Categories {
    private $table_name;
    
    public function __construct() {
        global $wpdb;
        $this->table_name = $wpdb->prefix . 'wh_categories';
        
        // Initialize hooks
        add_action('wp_ajax_get_categories', array($this, 'get_categories'));
        add_action('wp_ajax_nopriv_get_categories', array($this, 'get_categories'));
        add_action('wp_ajax_save_category', array($this, 'save_category'));
        add_action('wp_ajax_delete_category', array($this, 'delete_category'));
    }
    
    public function get_categories() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        global $wpdb;
        
        $categories = $wpdb->get_results("
            SELECT c.*, 
                   (SELECT COUNT(*) FROM {$wpdb->prefix}wh_inventory WHERE category_id = c.id) as items_count
            FROM {$this->table_name} c
            ORDER BY c.name ASC
        ");
        
        wp_send_json_success(array(
            'categories' => $categories
        ));
    }
    
    public function save_category() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        if (!current_user_can('manage_options')) {
            wp_send_json_error('Insufficient permissions');
            return;
        }
        
        global $wpdb;
        
        $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
        $data = array(
            'name' => sanitize_text_field($_POST['name']),
            'description' => isset($_POST['description']) ? sanitize_textarea_field($_POST['description']) : '',
            'parent_id' => isset($_POST['parent_id']) ? intval($_POST['parent_id']) : 0
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
            'message' => 'Category saved successfully'
        ));
    }
    
    public function delete_category() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        if (!current_user_can('manage_options')) {
            wp_send_json_error('Insufficient permissions');
            return;
        }
        
        global $wpdb;
        
        $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
        
        // Check if category has items
        $items_count = $wpdb->get_var($wpdb->prepare(
            "SELECT COUNT(*) FROM {$wpdb->prefix}wh_inventory WHERE category_id = %d",
            $id
        ));
        
        if ($items_count > 0) {
            wp_send_json_error('Cannot delete category with assigned items');
            return;
        }
        
        if ($id > 0) {
            $wpdb->delete($this->table_name, array('id' => $id));
            wp_send_json_success('Category deleted successfully');
        } else {
            wp_send_json_error('Invalid category ID');
        }
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
