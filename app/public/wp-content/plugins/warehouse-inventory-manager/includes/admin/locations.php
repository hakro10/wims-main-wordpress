<?php
// Admin Locations wrapper -> reuse theme locations UI
if (!defined('ABSPATH')) { exit; }
echo '<div class="wrap"><h1>Locations</h1>';
if (function_exists('get_template_part')) {
    get_template_part('template-parts/locations');
} else {
    echo '<p>Locations template not found.</p>';
}
echo '</div>';

