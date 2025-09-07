<?php
// Admin Reports placeholder
if (!defined('ABSPATH')) { exit; }
echo '<div class="wrap"><h1>Reports</h1>';
if (function_exists('get_template_part')) {
    // Reuse dashboard or sales as a basic report for now
    get_template_part('template-parts/modern-dashboard');
} else {
    echo '<p>Reports view not available.</p>';
}
echo '</div>';

