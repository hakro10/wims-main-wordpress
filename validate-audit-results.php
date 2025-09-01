<?php
/**
 * Validation script to verify audit results
 */

echo "Validating audit results...\n";

// Check if audit report exists
if (!file_exists('project-audit-report.json')) {
    echo "ERROR: Audit report not found. Run project-audit.php first.\n";
    exit(1);
}

// Load audit results
$audit_data = json_decode(file_get_contents('project-audit-report.json'), true);

if (!$audit_data) {
    echo "ERROR: Could not parse audit report.\n";
    exit(1);
}

echo "Audit report loaded successfully.\n";
echo "Timestamp: " . $audit_data['timestamp'] . "\n";
echo "Total files scanned: " . $audit_data['summary']['total_files_scanned'] . "\n";
echo "Total discrepancies: " . $audit_data['summary']['total_discrepancies'] . "\n";

// Validate key findings
$key_findings = [
    'theme_name_mismatch' => false,
    'missing_dist_folder' => false,
    'missing_class_files' => 0
];

foreach ($audit_data['all_discrepancies'] as $discrepancy) {
    if ($discrepancy['type'] === 'naming_inconsistency' && 
        strpos($discrepancy['description'], 'Theme name mismatch') !== false) {
        $key_findings['theme_name_mismatch'] = true;
    }
    
    if ($discrepancy['type'] === 'missing_directory' && 
        strpos($discrepancy['description'], 'dist/') !== false) {
        $key_findings['missing_dist_folder'] = true;
    }
    
    if ($discrepancy['type'] === 'missing_file' && 
        strpos($discrepancy['file'], 'class-wh-') !== false) {
        $key_findings['missing_class_files']++;
    }
}

echo "\nKey findings validation:\n";
echo "- Theme name mismatch detected: " . ($key_findings['theme_name_mismatch'] ? "YES" : "NO") . "\n";
echo "- Missing dist folder detected: " . ($key_findings['missing_dist_folder'] ? "YES" : "NO") . "\n";
echo "- Missing class files detected: " . $key_findings['missing_class_files'] . "\n";

// Verify actual file structure matches expectations
echo "\nVerifying file structure:\n";

$expected_theme_files = [
    'app/public/wp-content/themes/warehouse-inventory/style.css',
    'app/public/wp-content/themes/warehouse-inventory/functions.php',
    'app/public/wp-content/themes/warehouse-inventory/assets/css/style.css',
    'app/public/wp-content/themes/warehouse-inventory/assets/js/warehouse.js'
];

foreach ($expected_theme_files as $file) {
    $exists = file_exists($file);
    echo "- {$file}: " . ($exists ? "EXISTS" : "MISSING") . "\n";
}

$expected_plugin_files = [
    'app/public/wp-content/plugins/warehouse-inventory-manager/warehouse-inventory-manager.php',
    'app/public/wp-content/plugins/warehouse-inventory-manager/includes/database-migration.php'
];

foreach ($expected_plugin_files as $file) {
    $exists = file_exists($file);
    echo "- {$file}: " . ($exists ? "EXISTS" : "MISSING") . "\n";
}

echo "\nValidation completed successfully!\n";