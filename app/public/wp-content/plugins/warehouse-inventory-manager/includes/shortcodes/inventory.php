<?php
// Shortcode view for [warehouse_inventory]
if (!defined('ABSPATH')) { exit; }
if (function_exists('get_template_part')) {
    get_template_part('template-parts/inventory');
} else {
    echo '<p>Inventory template not found in the active theme.</p>';
}

