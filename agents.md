# Warehouse Inventory Management System - Developer Documentation

## Project Overview
A comprehensive WordPress-based warehouse inventory management system built with modern web technologies. The system provides complete inventory tracking, location management, category organization, task management, team collaboration, QR code generation, and sales tracking capabilities.

## Active Components
- Active Theme: Warehouse Inventory Manager (`wp-content/themes/warehouse-inventory-manager`)
- Active Plugin: Warehouse Inventory Manager (`wp-content/plugins/warehouse-inventory-manager`)

## Technology Stack

### Frontend
- **Framework**: WordPress Theme + React Components (planned migration)
- **Styling**: Tailwind CSS (planned migration from custom CSS)
- **UI Components**: shadcn/ui (planned integration)
- **Icons**: Font Awesome
- **Charts**: Chart.js (for dashboard analytics)
- **QR Codes**: qrcode.js library
- **Theme JS (present)**:
  - `assets/js/warehouse.js`
  - `assets/js/theme-toggle.js` (dark/light toggle + persistence)
  - `assets/js/loading-manager.js`
  - `assets/js/production.js`
  - `assets/js/qr-scanner.js`
- **Theme CSS (present)**:
  - `assets/css/style.css` (main)
  - `assets/css/shadcn-components.css`
  - `assets/css/animations.css`
  - `assets/css/production.css`
  - `assets/css/dark-override.css` (dark‑mode overrides)

### Backend
- **Platform**: WordPress
- **Database**: MySQL with custom tables
- **Plugin**: Custom WordPress plugin for inventory management
- **API**: WordPress REST API + AJAX handlers

### Development Tools
- **Version Control**: Git
- **Build Tools**: Webpack (planned for React migration)
- **Testing**: WordPress testing framework

## Project Structure

### WordPress Theme (`warehouse-inventory-manager/`)
```
warehouse-inventory-manager/
├── assets/
│   ├── css/
│   │   ├── style.css          # Main stylesheet
│   │   └── shadcn-components.css # Modern component styles
│   ├── js/
│   │   ├── script.js          # Core JavaScript functionality
│   │   ├── warehouse.js       # Warehouse-specific features
│   │   └── qr-scanner.js      # QR code scanning functionality
│   └── images/                # Theme assets
├── template-parts/            # Modular template components
│   ├── categories.php         # Category management
│   ├── dashboard.php          # Main dashboard
│   ├── inventory.php          # Inventory management
│   ├── locations.php          # Location management
│   ├── modern-dashboard.php   # New dashboard design
│   ├── qr-codes.php          # QR code generation
│   ├── sales.php             # Sales tracking
│   ├── tasks.php             # Task management
│   ├── team.php              # Team management
│   └── task-card-template.php # Reusable task card
├── functions.php             # Theme functions
├── header.php               # Theme header
├── footer.php               # Theme footer
└── index.php               # Main template
```

### WordPress Plugin (`warehouse-inventory-manager/`)
Current structure:
```
warehouse-inventory-manager/
├── warehouse-inventory-manager.php       # Main plugin file (menus, AJAX, shortcodes)
├── includes/
│   └── database-migration.php            # Database schema management
├── assets/
│   ├── css/{admin.css, frontend.css}
│   └── js/{admin.js, frontend.js}
└── dist/{admin.bundle.js, public.bundle.js, *.LICENSE.txt}
```
Note: Older references to `class-wh-activator.php`, `class-wh-deactivator.php`, `class-wh-loader.php`, `class-wh-qr-codes.php` are not used in the current plugin.

## Database Schema

### Core Tables
- `wp_wh_inventory_items` - Main inventory items
- `wp_wh_categories` - Product categories
- `wp_wh_locations` - Storage locations
- `wp_wh_sales` - Sales records
- `wp_wh_tasks` - Task management
- `wp_wh_team_members` - Team member management
### Supporting Tables (present in migration)
- `wp_wh_stock_movements` - Track quantity changes and costing
- `wp_wh_suppliers` - Suppliers registry
- `wp_wh_task_history` - Completed task audit trail
- `wp_wh_chat_messages` - Team chat messages

## Key Features

### ✅ Completed Features
1. **Inventory Management**
   - Add/edit/delete inventory items
   - Stock level tracking
   - Category assignment
   - Location management
   - Stock status (in-stock, low-stock, out-of-stock)

2. **Location Management**
   - Create/edit/delete storage locations
   - Location-based inventory filtering
   - Location type classification

3. **Category Management**
   - Hierarchical category system
   - Category-based filtering
   - Category statistics

4. **Task Management**
   - Kanban board with drag-and-drop
   - Task assignment to team members
   - Task history tracking
   - Priority levels (low, medium, high, urgent)
   - Team chat integration

5. **QR Code System**
   - Generate QR codes for inventory items
   - Bulk QR code generation
   - QR code scanning functionality
   - Printable QR code labels

6. **Sales Tracking**
   - Record sales transactions
   - Profit calculation
   - Sales analytics
   - Monthly/yearly reports

7. **Team Management**
   - User roles and permissions
   - Team member profiles
   - Task assignment system

### 🔄 In Progress Features
1. **Modern UI Migration**
   - shadcn/ui component integration
   - Tailwind CSS implementation
   - Responsive design improvements

2. **React/Next.js Migration**
   - Component-based architecture
   - Modern state management
   - Improved performance

### 📋 Planned Features
1. **Advanced Analytics**
   - Predictive inventory alerts
   - Sales forecasting
   - Performance dashboards

2. **Mobile App**
   - PWA implementation
   - Offline functionality
   - Mobile-optimized UI

3. **Integration Features**
   - Barcode scanning
   - Third-party API integrations
   - Export/import functionality

## Development Setup

### Prerequisites
- WordPress 6.0+
- PHP 7.4+
- MySQL 5.7+
- Node.js 16+ (for React migration)

### Installation Steps
1. Clone the repository
2. Install WordPress
3. Copy theme `warehouse-inventory-manager/` to `wp-content/themes/`
4. Copy plugin `warehouse-inventory-manager/` to `wp-content/plugins/`
5. Activate theme and plugin in WordPress admin
6. Run database migration (automatic on plugin activation)

### Development Commands
The repo does not include a root `package.json` with build scripts yet. Plugin bundles are prebuilt in `dist/`.

Recommended local steps:
- Run WordPress locally (e.g., Local by Flywheel).
- For SSL: trust the Local certificate and switch the site to `https`. Optionally add in `wp-config.php`:
```php
define('FORCE_SSL_ADMIN', true);
```
- Activate the theme and plugin. Database migrations run automatically on activation.

## Adding New Features

### Adding a New Module
1. Create new PHP file in `includes/` directory
2. Add class with proper WordPress hooks
3. Create corresponding template in `template-parts/`
4. Add JavaScript functionality in `assets/js/`
5. Update database schema if needed

### Adding New React Component
1. Create component in `src/components/`
2. Add to appropriate page template
3. Update build configuration
4. Test thoroughly

### Database Schema Updates
1. Update `database-migration.php`
2. Add migration version
3. Test migration process
4. Document changes

## Access Control & Dark Mode
- App pages require login; unauthenticated users see the theme’s sign‑in screen.
- A dark/light toggle (`assets/js/theme-toggle.js`) persists user choice; the theme sets `data-theme` on `<html>` before styles load to avoid FOUC.
- Dark overrides live in `assets/css/dark-override.css`.

## Changelog (engineering updates)
> Keep this section updated after fixes/changes.

### 2025‑08‑31
- Dark mode: added `assets/css/dark-override.css` and early `data-theme` boot.
- Theme toggle: enqueued on theme pages and aligned in header next to Logout.
- Auth protection: app requires login; restricted `wp_ajax_nopriv` to safe reads; modernized login UI.
- AJAX URL: switched to relative `admin-ajax.php` to avoid http/https warnings.
- Inventory/Categories/Locations (dark): unified card/list/badge colors; icon‑only buttons adjusted.
- Sales (dark): stat cards, search form, profit controls, date input, and table colors fixed.
- Forms (modals): standardized `.modal` containers, removed inline separators, normalized field layout; scoped top‑level layout via `.modal-form` to preserve two‑column rows; inputs/selects/textarea full‑width with correct colors in light+dark.
 - Modal layout fixes: ensured buttons align inside modal, hid stray side labels, normalized number input spinners, and prevented select truncation; added fallback `.btn` styles. Implemented in plugin `assets/css/{frontend.css,admin.css}`.

## API Endpoints

### AJAX Handlers
- `get_inventory_items` - Get all inventory items
- `save_inventory_item` - Save inventory item
- `delete_inventory_item` - Delete inventory item
- `get_categories` - Get all categories
- `save_category` - Save category
- `delete_category` - Delete category
- `get_locations` - Get all locations
- `save_location` - Save location
- `delete_location` - Delete location
- `generate_qr_code` - Generate QR code
- `add_task` - Add new task
- `update_task_status` - Update task status
- `get_task_history` - Get completed tasks
- `send_chat_message` - Send team chat message

Additional handlers (selection): `get_dashboard_stats`, `get_profit_data`, `rebuild_profit_data`, `fix_purchase_prices`, `debug_profit_data`, `get_team_members`, `add_team_member`, `update_team_member`, `delete_team_member`, `reset_user_password`, `get_inactive_items`, `permanently_delete_item`, `bulk_cleanup_inactive_items`.

Public read‑only (no login): `get_inventory_items`, `get_dashboard_stats`.

## Troubleshooting

### Common Issues
1. **Database Connection**: Check wp-config.php settings
2. **Permission Errors**: Ensure proper file permissions
3. **AJAX Failures**: Check nonce validation
4. **Styling Issues**: Clear browser cache and verify that `assets/css/dark-override.css` and `assets/js/theme-toggle.js` are loaded.
5. **Mixed Content/SSL**: If you see warnings about password fields on HTTP, enable HTTPS in Local and `FORCE_SSL_ADMIN`.

### Debug Mode
Enable WordPress debug mode in wp-config.php:
```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

## Contributing
1. Create feature branch from `main`
2. Follow coding standards
3. Add tests for new features
4. Update documentation
5. Submit pull request

## Versioning Rules
- After committing a bug fix: bump app version by `+0.0.1` (patch).
- After adding a new feature: bump app version by `+0.1` (minor).
- Record the change in the changelog and update any visible version strings in the theme/plugin UI if present.

## Support
For technical support or questions, refer to:
- WordPress documentation
- Plugin documentation
- Theme documentation
- GitHub issues
