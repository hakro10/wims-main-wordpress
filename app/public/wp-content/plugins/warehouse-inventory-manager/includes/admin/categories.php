<?php
// Admin Categories wrapper -> reuse theme categories UI
if (!defined('ABSPATH')) { exit; }
echo '<div class="wrap"><h1>Categories</h1>';
if (function_exists('get_template_part')) {
    get_template_part('template-parts/categories');
} else {
    echo '<p>Categories template not found.</p>';
}
echo '</div>';

