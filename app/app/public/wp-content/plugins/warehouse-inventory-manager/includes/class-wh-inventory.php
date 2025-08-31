<?php

class WH_Inventory {
    private $table_name;
    
    public function __construct() {
        global $wpdb;
        $this->table_name = $wpdb->prefix . 'wh_inventory';
        
        // Initialize hooks
        add_action('wp_ajax_get_inventory_items', array($this, 'get_inventory_items'));
        add_action('wp_ajax_save_inventory_item', array($this, 'save_inventory_item'));
        add_action('wp_ajax_delete_inventory_item', array($this, 'delete_inventory_item'));
    }
    
    public function get_inventory_items() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        global $wpdb;
        
        $search = isset($_POST['search']) ? sanitize_text_field($_POST['search']) : '';
        $category = isset($_POST['category']) ? intval($_POST['category']) : 0;
        $location = isset($_POST['location']) ? intval($_POST['location']) : 0;
        $status = isset($_POST['status']) ? sanitize_text_field($_POST['status']) : '';
        
        $query = "SELECT i.*, c.name as category_name, l.name as location_name 
                 FROM {$this->table_name} i
                 LEFT JOIN {$wpdb->prefix}wh_categories c ON i.category_id = c.id
                 LEFT JOIN {$wpdb->prefix}wh_locations l ON i.location_id = l.id
                 WHERE 1=1";
        
        $params = array();
        
        if (!empty($search)) {
            $query .= " AND (i.name LIKE %s OR i.description LIKE %s)";
            $params[] = '%' . $wpdb->esc_like($search) . '%';
            $params[] = '%' . $wpdb->esc_like($search) . '%';
        }
        
        if ($category > 0) {
            $query .= " AND i.category_id = %d";
            $params[] = $category;
        }
        
        if ($location > 0) {
            $query .= " AND i.location_id = %d";
            $params[] = $location;
        }
        
        if (!empty($status)) {
            $query .= " AND i.status = %s";
            $params[] = $status;
        }
        
        $query .= " ORDER BY i.name ASC";
        
        if (!empty($params)) {
            $query = $wpdb->prepare($query, $params);
        }
        
        $items = $wpdb->get_results($query);
        
        $items = apply_filters('wh_inventory_items', $items);
        $items = apply_filters('wh_inventory_items', $items);
        wp_send_json_success(array(
            'items' => $items
        ));
    }
    
    public function save_inventory_item() {
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
            'category_id' => intval($_POST['category_id']),
            'location_id' => intval($_POST['location_id']),
            'quantity' => intval($_POST['quantity']),
            'status' => sanitize_text_field($_POST['status']),
            'last_updated' => current_time('mysql')
        );
        
        if ($id > 0) {
            $wpdb->update(
                $this->table_name,
                $data,
                array('id' => $id)
            );
        } else {
            $data['created_at'] = current_time('mysql');
            $wpdb->insert($this->table_name, $data);
            $id = $wpdb->insert_id;
        }
        
        wp_send_json_success(array(
            'id' => $id,
            'message' => 'Item saved successfully'
        ));
    }
    
    public function delete_inventory_item() {
        check_ajax_referer('wh_inventory_nonce', 'nonce');
        
        if (!current_user_can('manage_options')) {
            wp_send_json_error('Insufficient permissions');
            return;
        }
        
        global $wpdb;
        
        $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
        
        if ($id > 0) {
            $wpdb->delete($this->table_name, array('id' => $id));
            wp_send_json_success('Item deleted successfully');
        } else {
            wp_send_json_error('Invalid item ID');
        }
    }
    
    public function create_tables() {
        global $wpdb;
        
        $charset_collate = $wpdb->get_charset_collate();
        
        $sql = "CREATE TABLE IF NOT EXISTS {$this->table_name} (
            id bigint(20) NOT NULL AUTO_INCREMENT,
            name varchar(255) NOT NULL,
            description text,
            category_id bigint(20),
            location_id bigint(20),
            quantity int(11) DEFAULT 0,
            status varchar(50),
            created_at datetime DEFAULT CURRENT_TIMESTAMP,
            last_updated datetime DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY  (id)
        ) $charset_collate;";
        
        require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
        dbDelta($sql);
    }
} 