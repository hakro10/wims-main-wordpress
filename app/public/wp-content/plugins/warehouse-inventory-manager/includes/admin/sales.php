<?php
// Admin Sales wrapper -> reuse theme sales UI
if (!defined('ABSPATH')) { exit; }
echo '<div class="wrap"><h1>Sales</h1>';
if (function_exists('get_template_part')) {
    get_template_part('template-parts/sales');
} else {
    echo '<p>Sales template not found.</p>';
}
echo '</div>';

