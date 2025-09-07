<?php
// Shortcode view for [warehouse_dashboard]
if (!defined('ABSPATH')) { exit; }
if (function_exists('get_template_part')) {
    get_template_part('template-parts/modern-dashboard');
    get_template_part('template-parts/dashboard');
} else {
    echo '<p>Dashboard templates not found in the active theme.</p>';
}

