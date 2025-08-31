<?php
/*
Plugin Name: Testing Environment Watermark (MU)
Description: Displays a persistent TESTING badge to differentiate environments. Present only on the testing branch.
Version: 0.1.0
Author: Codex CLI
*/

if (!defined('ABSPATH')) { exit; }

// Render a simple corner ribbon on both front-end and admin.
function codex_testing_watermark_render() {
    // Minimal inline styles + markup to avoid external asset dependencies.
    echo '<style id="codex-testing-watermark">\n'
       . '.codex-testing-watermark{position:fixed;z-index:1000;left:12px;bottom:12px;padding:6px 10px;background:#b91c1c;color:#fff;font:600 12px/1.2 system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Cantarell,Noto Sans,sans-serif;border-radius:6px;box-shadow:0 4px 10px rgba(0,0,0,.18);letter-spacing:.06em;text-transform:uppercase;opacity:.9}\n'
       . '.codex-testing-watermark small{display:block;font-weight:500;opacity:.85;letter-spacing:.04em}\n'
       . '.codex-testing-watermark:hover{opacity:1}\n'
       . '</style>';

    echo '<div class="codex-testing-watermark" aria-label="Testing Environment">'
       . 'TESTING'
       . '<small>branch</small>'
       . '</div>';
}

add_action('wp_footer', 'codex_testing_watermark_render');
add_action('admin_footer', 'codex_testing_watermark_render');
