<?php
/**
 * Test script for the project audit functionality
 */

require_once 'project-audit.php';

echo "Testing Project Audit Script...\n";

// Test the audit class
$audit = new ProjectAuditScript();

// Test file existence checks
$test_files = [
    'app/public/wp-content/themes/warehouse-inventory/style.css',
    'app/public/wp-content/themes/warehouse-inventory/assets/css/style.css',
    'app/public/wp-content/themes/warehouse-inventory/assets/js/warehouse.js',
    'app/public/wp-content/plugins/warehouse-inventory-manager/warehouse-inventory-manager.php',
    'agents.md'
];

echo "\nTesting file existence:\n";
foreach ($test_files as $file) {
    $exists = file_exists($file);
    echo "- {$file}: " . ($exists ? "EXISTS" : "MISSING") . "\n";
}

echo "\nRunning full audit...\n";
$audit->run_audit();

echo "Test completed!\n";