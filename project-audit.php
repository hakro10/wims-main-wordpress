<?php
/**
 * Comprehensive Project Audit Script
 * 
 * This script scans all project files and generates an inventory,
 * validates file existence for documented references, and creates
 * a report of discrepancies between documentation and actual structure.
 * 
 * Requirements: 1.1, 2.1, 5.1
 */

// Prevent direct access if run in web context
if (!defined('ABSPATH') && php_sapi_name() !== 'cli') {
    exit('This script should be run from command line or WordPress context.');
}

class ProjectAuditScript {
    
    private $project_root;
    private $wp_root;
    private $theme_path;
    private $plugin_path;
    private $audit_results = [];
    private $discrepancies = [];
    private $file_inventory = [];
    
    public function __construct() {
        $this->project_root = dirname(__FILE__);
        $this->wp_root = $this->project_root . '/app/public';
        $this->theme_path = $this->wp_root . '/wp-content/themes/warehouse-inventory';
        $this->plugin_path = $this->wp_root . '/wp-content/plugins/warehouse-inventory-manager';
        
        $this->audit_results = [
            'timestamp' => date('Y-m-d H:i:s'),
            'project_structure' => [],
            'documentation_references' => [],
            'missing_files' => [],
            'extra_files' => [],
            'naming_inconsistencies' => [],
            'version_discrepancies' => [],
            'asset_validation' => []
        ];
    }
    
    /**
     * Main audit execution method
     */
    public function run_audit() {
        echo "Starting comprehensive project audit...\n";
        
        // Step 1: Generate file inventory
        $this->generate_file_inventory();
        
        // Step 2: Validate documentation references
        $this->validate_documentation_references();
        
        // Step 3: Check naming consistency
        $this->check_naming_consistency();
        
        // Step 4: Validate version consistency
        $this->validate_version_consistency();
        
        // Step 5: Validate asset references
        $this->validate_asset_references();
        
        // Step 6: Generate report
        $this->generate_report();
        
        echo "Audit completed. Report saved to project-audit-report.json\n";
    }
    
    /**
     * Generate comprehensive file inventory
     */
    private function generate_file_inventory() {
        echo "Generating file inventory...\n";
        
        $this->file_inventory = [
            'theme_files' => $this->scan_directory($this->theme_path),
            'plugin_files' => $this->scan_directory($this->plugin_path),
            'documentation_files' => $this->scan_documentation_files(),
            'config_files' => $this->scan_config_files()
        ];
        
        $this->audit_results['project_structure'] = $this->file_inventory;
    }
    
    /**
     * Recursively scan directory and return file structure
     */
    private function scan_directory($path, $relative_to = null) {
        if (!is_dir($path)) {
            return [];
        }
        
        $base_path = $relative_to ?: $path;
        $files = [];
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($path, RecursiveDirectoryIterator::SKIP_DOTS)
        );
        
        foreach ($iterator as $file) {
            $relative_path = str_replace($base_path . '/', '', $file->getPathname());
            $files[] = [
                'path' => $relative_path,
                'full_path' => $file->getPathname(),
                'type' => $file->isDir() ? 'directory' : 'file',
                'size' => $file->isFile() ? $file->getSize() : null,
                'modified' => $file->getMTime(),
                'extension' => $file->isFile() ? $file->getExtension() : null
            ];
        }
        
        return $files;
    }
    
    /**
     * Scan documentation files
     */
    private function scan_documentation_files() {
        $doc_files = [];
        $doc_patterns = ['*.md', '*.txt', 'README*'];
        
        foreach ($doc_patterns as $pattern) {
            $files = glob($this->project_root . '/' . $pattern);
            foreach ($files as $file) {
                $doc_files[] = [
                    'path' => str_replace($this->project_root . '/', '', $file),
                    'full_path' => $file,
                    'type' => 'file',
                    'size' => filesize($file),
                    'modified' => filemtime($file)
                ];
            }
        }
        
        return $doc_files;
    }
    
    /**
     * Scan configuration files
     */
    private function scan_config_files() {
        $config_files = [];
        $config_patterns = [
            'package.json',
            'webpack.config.js',
            'composer.json',
            '.gitignore',
            'wp-config.php'
        ];
        
        foreach ($config_patterns as $pattern) {
            $file = $this->project_root . '/' . $pattern;
            if (file_exists($file)) {
                $config_files[] = [
                    'path' => $pattern,
                    'full_path' => $file,
                    'exists' => true,
                    'size' => filesize($file)
                ];
            } else {
                $config_files[] = [
                    'path' => $pattern,
                    'exists' => false
                ];
            }
        }
        
        return $config_files;
    }
    
    /**
     * Validate all references in documentation against actual files
     */
    private function validate_documentation_references() {
        echo "Validating documentation references...\n";
        
        // Read main documentation file
        $agents_md = $this->project_root . '/agents.md';
        if (file_exists($agents_md)) {
            $content = file_get_contents($agents_md);
            $this->validate_file_references_in_content($content, 'agents.md');
        }
        
        // Check other documentation files
        foreach ($this->file_inventory['documentation_files'] as $doc_file) {
            if (pathinfo($doc_file['path'], PATHINFO_EXTENSION) === 'md') {
                $content = file_get_contents($doc_file['full_path']);
                $this->validate_file_references_in_content($content, $doc_file['path']);
            }
        }
    }
    
    /**
     * Extract and validate file references from content
     */
    private function validate_file_references_in_content($content, $source_file) {
        // Extract file paths from various patterns
        $patterns = [
            // Theme/plugin directory references
            '/wp-content\/themes\/([^\/\s\)\`]+)/' => 1,
            '/wp-content\/plugins\/([^\/\s\)\`]+)/' => 1,
            // Asset file references
            '/assets\/([^\/\s\)\`]+\/[^\s\)\`]+)/' => 1,
            // Include/require statements
            '/(?:include|require)(?:_once)?\s*\(\s*[\'"]([^\'"]+)[\'"]/' => 1,
            // Enqueue script/style references
            '/wp_enqueue_(?:script|style)\([^,]+,\s*[\'"]([^\'"]+)[\'"]/' => 1,
            // File path references in backticks or quotes
            '/[\'"`]([^\'"`]*\.(?:php|js|css|png|jpg|jpeg|gif|svg))[\'"`]/' => 1,
            // Specific class file references
            '/class-([a-z-]+)\.php/' => 0,
        ];
        
        foreach ($patterns as $pattern => $match_index) {
            preg_match_all($pattern, $content, $matches);
            if (isset($matches[$match_index]) && is_array($matches[$match_index])) {
                foreach ($matches[$match_index] as $file_ref) {
                    if (!empty(trim($file_ref))) {
                        $this->validate_single_file_reference($file_ref, $source_file);
                    }
                }
            }
        }
    }
    
    /**
     * Validate a single file reference
     */
    private function validate_single_file_reference($file_ref, $source_file) {
        // Clean up the file reference
        $file_ref = trim($file_ref);
        
        // Skip empty references or obvious non-file references
        if (empty($file_ref) || strlen($file_ref) < 3 || strpos($file_ref, ' ') !== false) {
            return;
        }
        
        $possible_paths = [
            $this->project_root . '/' . $file_ref,
            $this->wp_root . '/' . $file_ref,
            $this->theme_path . '/' . $file_ref,
            $this->plugin_path . '/' . $file_ref,
            // For asset references, try with assets/ prefix
            $this->theme_path . '/assets/' . $file_ref,
            $this->plugin_path . '/assets/' . $file_ref,
            // For includes directory
            $this->plugin_path . '/includes/' . $file_ref
        ];
        
        $exists = false;
        $actual_path = null;
        
        foreach ($possible_paths as $path) {
            if (file_exists($path)) {
                $exists = true;
                $actual_path = $path;
                break;
            }
        }
        
        $this->audit_results['documentation_references'][] = [
            'reference' => $file_ref,
            'source_file' => $source_file,
            'exists' => $exists,
            'actual_path' => $actual_path,
            'checked_paths' => $possible_paths
        ];
        
        if (!$exists) {
            $this->discrepancies[] = [
                'type' => 'missing_file',
                'description' => "File referenced in {$source_file} does not exist: {$file_ref}",
                'file' => $file_ref,
                'source' => $source_file
            ];
        }
    }
    
    /**
     * Check naming consistency throughout the project
     */
    private function check_naming_consistency() {
        echo "Checking naming consistency...\n";
        
        // Check theme name consistency
        $documented_theme_name = 'warehouse-inventory-manager';
        $actual_theme_name = 'warehouse-inventory';
        
        if ($documented_theme_name !== $actual_theme_name) {
            $this->discrepancies[] = [
                'type' => 'naming_inconsistency',
                'description' => "Theme name mismatch: Documentation uses '{$documented_theme_name}' but actual directory is '{$actual_theme_name}'",
                'documented' => $documented_theme_name,
                'actual' => $actual_theme_name,
                'severity' => 'high'
            ];
        }
        
        // Check for references to non-existent dist folder
        $agents_content = file_get_contents($this->project_root . '/agents.md');
        if (strpos($agents_content, 'dist/') !== false) {
            $dist_path = $this->plugin_path . '/dist';
            if (!is_dir($dist_path)) {
                $this->discrepancies[] = [
                    'type' => 'missing_directory',
                    'description' => "Documentation references 'dist/' folder but it does not exist in plugin",
                    'expected_path' => $dist_path,
                    'severity' => 'medium'
                ];
            }
        }
        
        $this->audit_results['naming_inconsistencies'] = $this->discrepancies;
    }
    
    /**
     * Validate version consistency across files
     */
    private function validate_version_consistency() {
        echo "Validating version consistency...\n";
        
        $versions = [];
        
        // Check plugin version
        $plugin_file = $this->plugin_path . '/warehouse-inventory-manager.php';
        if (file_exists($plugin_file)) {
            $plugin_content = file_get_contents($plugin_file);
            
            // Extract version from plugin header
            if (preg_match('/Version:\s*([^\n\r]+)/', $plugin_content, $matches)) {
                $versions['plugin_header'] = trim($matches[1]);
            }
            
            // Extract version from constant
            if (preg_match('/define\s*\(\s*[\'"]WH_INVENTORY_VERSION[\'"],\s*[\'"]([^\'"]+)[\'"]/', $plugin_content, $matches)) {
                $versions['plugin_constant'] = trim($matches[1]);
            }
        }
        
        // Check theme version
        $theme_style = $this->theme_path . '/style.css';
        if (file_exists($theme_style)) {
            $style_content = file_get_contents($theme_style);
            if (preg_match('/Version:\s*([^\n\r]+)/', $style_content, $matches)) {
                $versions['theme_style'] = trim($matches[1]);
            }
        }
        
        $theme_functions = $this->theme_path . '/functions.php';
        if (file_exists($theme_functions)) {
            $functions_content = file_get_contents($theme_functions);
            if (preg_match('/[\'"]version[\'"].*?[\'"]([^\'"]+)[\'"]/', $functions_content, $matches)) {
                $versions['theme_functions'] = trim($matches[1]);
            }
        }
        
        // Check for version inconsistencies
        $unique_versions = array_unique($versions);
        if (count($unique_versions) > 1) {
            $this->discrepancies[] = [
                'type' => 'version_inconsistency',
                'description' => 'Version numbers are inconsistent across files',
                'versions_found' => $versions,
                'severity' => 'high'
            ];
        }
        
        $this->audit_results['version_discrepancies'] = $versions;
    }
    
    /**
     * Validate asset file references in PHP files
     */
    private function validate_asset_references() {
        echo "Validating asset references...\n";
        
        $php_files = [];
        
        // Get all PHP files from theme and plugin
        foreach ($this->file_inventory['theme_files'] as $file) {
            if ($file['extension'] === 'php') {
                $php_files[] = $file['full_path'];
            }
        }
        
        foreach ($this->file_inventory['plugin_files'] as $file) {
            if ($file['extension'] === 'php') {
                $php_files[] = $file['full_path'];
            }
        }
        
        foreach ($php_files as $php_file) {
            $this->validate_assets_in_php_file($php_file);
        }
    }
    
    /**
     * Validate asset references in a single PHP file
     */
    private function validate_assets_in_php_file($php_file) {
        $content = file_get_contents($php_file);
        
        // Look for wp_enqueue_script and wp_enqueue_style calls
        $patterns = [
            '/wp_enqueue_script\s*\([^,]+,\s*[\'"]([^\'"]+)[\'"]/',
            '/wp_enqueue_style\s*\([^,]+,\s*[\'"]([^\'"]+)[\'"]/',
            '/get_template_directory_uri\(\)\s*\.\s*[\'"]([^\'"]+)[\'"]/',
            '/WH_INVENTORY_PLUGIN_URL\s*\.\s*[\'"]([^\'"]+)[\'"]/'
        ];
        
        foreach ($patterns as $pattern) {
            preg_match_all($pattern, $content, $matches);
            foreach ($matches[1] as $asset_path) {
                $this->validate_asset_file($asset_path, $php_file);
            }
        }
    }
    
    /**
     * Validate a single asset file
     */
    private function validate_asset_file($asset_path, $source_file) {
        // Remove leading slash if present
        $asset_path = ltrim($asset_path, '/');
        
        $possible_paths = [
            $this->theme_path . '/' . $asset_path,
            $this->plugin_path . '/' . $asset_path,
            $this->wp_root . '/' . $asset_path
        ];
        
        $exists = false;
        foreach ($possible_paths as $path) {
            if (file_exists($path)) {
                $exists = true;
                break;
            }
        }
        
        $this->audit_results['asset_validation'][] = [
            'asset_path' => $asset_path,
            'source_file' => str_replace($this->project_root . '/', '', $source_file),
            'exists' => $exists,
            'checked_paths' => $possible_paths
        ];
        
        if (!$exists) {
            $this->discrepancies[] = [
                'type' => 'missing_asset',
                'description' => "Asset file referenced in PHP does not exist: {$asset_path}",
                'asset' => $asset_path,
                'source' => str_replace($this->project_root . '/', '', $source_file),
                'severity' => 'medium'
            ];
        }
    }
    
    /**
     * Generate comprehensive audit report
     */
    private function generate_report() {
        echo "Generating audit report...\n";
        
        // Add summary statistics
        $this->audit_results['summary'] = [
            'total_files_scanned' => count($this->file_inventory['theme_files']) + count($this->file_inventory['plugin_files']),
            'total_discrepancies' => count($this->discrepancies),
            'critical_issues' => count(array_filter($this->discrepancies, function($d) { 
                return isset($d['severity']) && $d['severity'] === 'high'; 
            })),
            'medium_issues' => count(array_filter($this->discrepancies, function($d) { 
                return isset($d['severity']) && $d['severity'] === 'medium'; 
            })),
            'theme_exists' => is_dir($this->theme_path),
            'plugin_exists' => is_dir($this->plugin_path),
            'theme_name_correct' => basename($this->theme_path) === 'warehouse-inventory',
            'plugin_name_correct' => basename($this->plugin_path) === 'warehouse-inventory-manager'
        ];
        
        // Add all discrepancies to results
        $this->audit_results['all_discrepancies'] = $this->discrepancies;
        
        // Save detailed report as JSON
        $report_file = $this->project_root . '/project-audit-report.json';
        file_put_contents($report_file, json_encode($this->audit_results, JSON_PRETTY_PRINT));
        
        // Generate human-readable summary
        $this->generate_summary_report();
    }
    
    /**
     * Generate human-readable summary report
     */
    private function generate_summary_report() {
        $summary_file = $this->project_root . '/project-audit-summary.txt';
        $summary = [];
        
        $summary[] = "PROJECT AUDIT SUMMARY";
        $summary[] = "====================";
        $summary[] = "Generated: " . $this->audit_results['timestamp'];
        $summary[] = "";
        
        $summary[] = "OVERVIEW:";
        $summary[] = "- Total files scanned: " . $this->audit_results['summary']['total_files_scanned'];
        $summary[] = "- Total discrepancies found: " . $this->audit_results['summary']['total_discrepancies'];
        $summary[] = "- Critical issues: " . $this->audit_results['summary']['critical_issues'];
        $summary[] = "- Medium issues: " . $this->audit_results['summary']['medium_issues'];
        $summary[] = "";
        
        $summary[] = "STRUCTURE VALIDATION:";
        $summary[] = "- Theme directory exists: " . ($this->audit_results['summary']['theme_exists'] ? 'YES' : 'NO');
        $summary[] = "- Plugin directory exists: " . ($this->audit_results['summary']['plugin_exists'] ? 'YES' : 'NO');
        $summary[] = "- Theme name correct: " . ($this->audit_results['summary']['theme_name_correct'] ? 'YES' : 'NO');
        $summary[] = "- Plugin name correct: " . ($this->audit_results['summary']['plugin_name_correct'] ? 'YES' : 'NO');
        $summary[] = "";
        
        if (!empty($this->discrepancies)) {
            $summary[] = "CRITICAL ISSUES FOUND:";
            foreach ($this->discrepancies as $discrepancy) {
                if (isset($discrepancy['severity']) && $discrepancy['severity'] === 'high') {
                    $summary[] = "- " . $discrepancy['description'];
                }
            }
            $summary[] = "";
            
            $summary[] = "MEDIUM PRIORITY ISSUES:";
            foreach ($this->discrepancies as $discrepancy) {
                if (isset($discrepancy['severity']) && $discrepancy['severity'] === 'medium') {
                    $summary[] = "- " . $discrepancy['description'];
                }
            }
            $summary[] = "";
            
            $summary[] = "OTHER ISSUES:";
            foreach ($this->discrepancies as $discrepancy) {
                if (!isset($discrepancy['severity'])) {
                    $summary[] = "- " . $discrepancy['description'];
                }
            }
        } else {
            $summary[] = "No critical issues found!";
        }
        
        $summary[] = "";
        $summary[] = "For detailed information, see project-audit-report.json";
        
        file_put_contents($summary_file, implode("\n", $summary));
        
        // Also output to console
        echo "\n" . implode("\n", $summary) . "\n";
    }
}

// Run the audit if called directly
if (php_sapi_name() === 'cli' || (defined('WP_CLI') && WP_CLI)) {
    $audit = new ProjectAuditScript();
    $audit->run_audit();
} else {
    // Provide a way to run from WordPress admin if needed
    if (isset($_GET['run_audit']) && current_user_can('manage_options')) {
        $audit = new ProjectAuditScript();
        $audit->run_audit();
    }
}