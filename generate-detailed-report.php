<?php
/**
 * Generate detailed discrepancy report with recommendations
 */

require_once 'project-audit.php';

class DetailedReportGenerator {
    
    private $audit_data;
    
    public function __construct() {
        if (!file_exists('project-audit-report.json')) {
            echo "Running audit first...\n";
            $audit = new ProjectAuditScript();
            $audit->run_audit();
        }
        
        $this->audit_data = json_decode(file_get_contents('project-audit-report.json'), true);
    }
    
    public function generate_detailed_report() {
        $report = [];
        
        $report[] = "WAREHOUSE INVENTORY MANAGEMENT SYSTEM";
        $report[] = "COMPREHENSIVE PROJECT AUDIT REPORT";
        $report[] = str_repeat("=", 50);
        $report[] = "Generated: " . $this->audit_data['timestamp'];
        $report[] = "";
        
        // Executive Summary
        $report[] = "EXECUTIVE SUMMARY";
        $report[] = str_repeat("-", 20);
        $report[] = "This audit identified " . $this->audit_data['summary']['total_discrepancies'] . " discrepancies between";
        $report[] = "the project documentation and actual codebase structure.";
        $report[] = "";
        $report[] = "Critical Issues: " . $this->audit_data['summary']['critical_issues'];
        $report[] = "Medium Priority: " . $this->audit_data['summary']['medium_issues'];
        $report[] = "Total Files Scanned: " . $this->audit_data['summary']['total_files_scanned'];
        $report[] = "";
        
        // Critical Issues Analysis
        $report[] = "CRITICAL ISSUES ANALYSIS";
        $report[] = str_repeat("-", 25);
        
        $critical_issues = array_filter($this->audit_data['all_discrepancies'], function($d) {
            return isset($d['severity']) && $d['severity'] === 'high';
        });
        
        foreach ($critical_issues as $issue) {
            $report[] = "1. " . $issue['description'];
            $report[] = "   Impact: High - This affects documentation accuracy and developer onboarding";
            $report[] = "   Recommendation: Update all documentation to use correct theme name 'warehouse-inventory'";
            $report[] = "";
        }
        
        // Medium Priority Issues
        $report[] = "MEDIUM PRIORITY ISSUES";
        $report[] = str_repeat("-", 22);
        
        $medium_issues = array_filter($this->audit_data['all_discrepancies'], function($d) {
            return isset($d['severity']) && $d['severity'] === 'medium';
        });
        
        foreach ($medium_issues as $issue) {
            $report[] = "1. " . $issue['description'];
            $report[] = "   Impact: Medium - May cause confusion about build processes";
            $report[] = "   Recommendation: Either create dist/ folder with build process or remove references";
            $report[] = "";
        }
        
        // File Structure Analysis
        $report[] = "FILE STRUCTURE ANALYSIS";
        $report[] = str_repeat("-", 23);
        $report[] = "Theme Structure: " . ($this->audit_data['summary']['theme_exists'] ? "✓ Correct" : "✗ Issues found");
        $report[] = "Plugin Structure: " . ($this->audit_data['summary']['plugin_exists'] ? "✓ Correct" : "✗ Issues found");
        $report[] = "";
        
        // Missing Files Summary
        $missing_files = array_filter($this->audit_data['all_discrepancies'], function($d) {
            return $d['type'] === 'missing_file';
        });
        
        $report[] = "MISSING FILES SUMMARY (" . count($missing_files) . " files)";
        $report[] = str_repeat("-", 25);
        
        $file_categories = [
            'Legacy Class Files' => [],
            'Asset Files' => [],
            'Configuration Files' => [],
            'Other Files' => []
        ];
        
        foreach ($missing_files as $file) {
            $filename = $file['file'];
            if (strpos($filename, 'class-wh-') !== false) {
                $file_categories['Legacy Class Files'][] = $filename;
            } elseif (strpos($filename, '.css') !== false || strpos($filename, '.js') !== false) {
                $file_categories['Asset Files'][] = $filename;
            } elseif (strpos($filename, '.json') !== false || strpos($filename, 'config') !== false) {
                $file_categories['Configuration Files'][] = $filename;
            } else {
                $file_categories['Other Files'][] = $filename;
            }
        }
        
        foreach ($file_categories as $category => $files) {
            if (!empty($files)) {
                $report[] = "";
                $report[] = $category . ":";
                foreach (array_unique($files) as $file) {
                    $report[] = "  - " . $file;
                }
            }
        }
        
        $report[] = "";
        
        // Version Analysis
        if (!empty($this->audit_data['version_discrepancies'])) {
            $report[] = "VERSION CONSISTENCY ANALYSIS";
            $report[] = str_repeat("-", 28);
            
            $versions = $this->audit_data['version_discrepancies'];
            $unique_versions = array_unique($versions);
            
            if (count($unique_versions) > 1) {
                $report[] = "⚠ Version inconsistencies detected:";
                foreach ($versions as $location => $version) {
                    $report[] = "  - {$location}: {$version}";
                }
                $report[] = "";
                $report[] = "Recommendation: Standardize all version numbers to match plugin header version.";
            } else {
                $report[] = "✓ Version numbers are consistent across all files.";
            }
            $report[] = "";
        }
        
        // Recommendations
        $report[] = "IMPLEMENTATION RECOMMENDATIONS";
        $report[] = str_repeat("-", 30);
        $report[] = "";
        $report[] = "Priority 1 (Critical):";
        $report[] = "1. Update agents.md to use correct theme name 'warehouse-inventory'";
        $report[] = "2. Search and replace all 'warehouse-inventory-manager' theme references";
        $report[] = "";
        $report[] = "Priority 2 (High):";
        $report[] = "3. Remove references to non-existent class files or mark as legacy";
        $report[] = "4. Clarify build process documentation (dist/ folder)";
        $report[] = "";
        $report[] = "Priority 3 (Medium):";
        $report[] = "5. Validate all asset file references in PHP code";
        $report[] = "6. Update documentation to reflect actual file structure";
        $report[] = "";
        $report[] = "Priority 4 (Low):";
        $report[] = "7. Create automated validation tests";
        $report[] = "8. Implement version synchronization system";
        $report[] = "";
        
        // Next Steps
        $report[] = "NEXT STEPS";
        $report[] = str_repeat("-", 10);
        $report[] = "1. Review this report with the development team";
        $report[] = "2. Prioritize fixes based on impact and effort";
        $report[] = "3. Update documentation first (quick wins)";
        $report[] = "4. Address structural issues systematically";
        $report[] = "5. Implement automated validation to prevent future discrepancies";
        $report[] = "";
        $report[] = "For detailed technical information, see project-audit-report.json";
        
        // Save detailed report
        file_put_contents('detailed-audit-report.txt', implode("\n", $report));
        
        // Output to console
        echo implode("\n", $report) . "\n";
    }
}

// Generate the detailed report
$generator = new DetailedReportGenerator();
$generator->generate_detailed_report();

echo "\nDetailed report saved to: detailed-audit-report.txt\n";