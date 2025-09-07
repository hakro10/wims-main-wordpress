<?php
// Admin Dashboard wrapper
if (!defined('ABSPATH')) { exit; }
echo '<div class="wrap"><h1>Warehouse Dashboard</h1>';
// Reuse theme dashboard (modern if available)
if (function_exists('get_template_part')) {
    get_template_part('template-parts/modern-dashboard');
    get_template_part('template-parts/dashboard');
} else {
    echo '<p>Theme templates not found.</p>';
}
echo '</div>';

