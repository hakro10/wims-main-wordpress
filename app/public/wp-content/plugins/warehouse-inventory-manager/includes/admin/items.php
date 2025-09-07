<?php
// Admin Items wrapper -> reuse theme inventory UI
if (!defined('ABSPATH')) { exit; }
echo '<div class="wrap"><h1>Inventory Items</h1>';
if (function_exists('get_template_part')) {
    get_template_part('template-parts/inventory');
} else {
    echo '<p>Inventory template not found.</p>';
}
echo '</div>';

