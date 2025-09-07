# Warehouse Inventory Management System — Agents Guide

This document gives agents a single, authoritative view of the project: architecture, active components, key paths, data schema, features, endpoints, and day‑to‑day workflows. Keep this file current when shipping changes.

## Project Overview
A comprehensive WordPress‑based warehouse inventory management system. It provides inventory tracking, hierarchical categories and locations, task management with kanban, team collaboration and chat, QR code generation and scanning, and sales tracking with analytics.

## Active Components
- Active Theme: Warehouse Inventory Manager (`wp-content/themes/warehouse-inventory-manager`)
- Active Plugin: Warehouse Inventory Manager (`wp-content/plugins/warehouse-inventory-manager`)

## Technology Stack

### Frontend
- Framework: WordPress Theme + progressive React components (planned migration)
- Styling: Custom CSS → Tailwind CSS (planned migration)
- UI Components: shadcn/ui (planned integration)
- Icons: Font Awesome
- Charts: Chart.js (dashboard analytics)
- QR Codes: qrcode.js
- Theme JS (present):
  - `assets/js/warehouse.js`
  - `assets/js/theme-toggle.js` (dark/light toggle + persistence)
  - `assets/js/loading-manager.js`
  - `assets/js/production.js`
  - `assets/js/qr-scanner.js`
- Theme CSS (present):
  - `assets/css/style.css` (main)
  - `assets/css/shadcn-components.css`
  - `assets/css/animations.css`
  - `assets/css/production.css`
  - `assets/css/dark-override.css` (dark‑mode overrides)

### Backend
- Platform: WordPress
- Database: MySQL with custom tables
- Plugin: Custom WordPress plugin for inventory management
- API: WordPress REST API + AJAX handlers

### Development Tools
- Version Control: Git
- Build Tools: Webpack (planned for React migration)
- Testing: WordPress testing framework

## Project Structure

### WordPress Theme (`warehouse-inventory-manager/`)
```
warehouse-inventory-manager/
├── assets/
│   ├── css/
│   │   ├── style.css            # Main stylesheet
│   │   └── shadcn-components.css# Modern component styles
│   ├── js/
│   │   ├── script.js            # Core JavaScript functionality
│   │   ├── warehouse.js         # Warehouse-specific features
│   │   └── qr-scanner.js        # QR code scanning functionality
│   └── images/                  # Theme assets
├── template-parts/              # Modular template components
│   ├── categories.php           # Category management
│   ├── dashboard.php            # Main dashboard
│   ├── inventory.php            # Inventory management
│   ├── locations.php            # Location management
│   ├── modern-dashboard.php     # New dashboard design
│   ├── qr-codes.php             # QR code generation
│   ├── sales.php                # Sales tracking
│   ├── tasks.php                # Task management
│   ├── team.php                 # Team management
│   └── task-card-template.php   # Reusable task card
├── functions.php                # Theme functions
├── header.php                   # Theme header
├── footer.php                   # Theme footer
└── index.php                    # Main template
```

### WordPress Plugin (`warehouse-inventory-manager/`)
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
- `wp_wh_inventory_items` — Main inventory items
- `wp_wh_categories` — Product categories
- `wp_wh_locations` — Storage locations
- `wp_wh_sales` — Sales records
- `wp_wh_tasks` — Task management
- `wp_wh_team_members` — Team member management

### Supporting Tables (present in migration)
- `wp_wh_stock_movements` — Track quantity changes and costing
- `wp_wh_suppliers` — Suppliers registry
- `wp_wh_task_history` — Completed task audit trail
- `wp_wh_chat_messages` — Team chat messages
- `wp_wh_settings` — Lightweight settings (e.g., language)

## Key Features

### Completed
1. Inventory Management — CRUD, stock levels, category + location assignment, stock status
2. Location Management — CRUD, filtering, type classification
3. Category Management — Hierarchy, filtering, stats
4. Task Management — Kanban drag/drop, assignment, history, priority levels, team chat
5. QR Code System — Generate, bulk generate, scan, printable labels
6. Sales Tracking — Record transactions, profit, analytics, monthly/yearly reports
7. Team Management — Roles/permissions, profiles, task assignment

### In Progress
- Modern UI Migration — shadcn/ui, Tailwind, responsive improvements
- React/Next.js Migration — Component architecture, state management, performance

### Planned
- Advanced Analytics — Predictive alerts, forecasting, performance dashboards
- Mobile App — PWA, offline, mobile‑optimized UI
- Integrations — Barcode scanning, 3rd‑party APIs, export/import

## Development Setup

### Prerequisites
- WordPress 6.0+
- PHP 7.4+
- MySQL 5.7+
- Node.js 16+ (for React migration)

### Installation
1. Clone repository and install WordPress.
2. Copy theme `warehouse-inventory-manager/` to `wp-content/themes/`.
3. Copy plugin `warehouse-inventory-manager/` to `wp-content/plugins/`.
4. Activate the theme and plugin in WP admin.
5. Database migration runs automatically on plugin activation.

### Local Tips
- Use Local by Flywheel. For SSL, trust the Local certificate and switch the site to HTTPS. Optional in `wp-config.php`:
  ```php
  define('FORCE_SSL_ADMIN', true);
  ```
- Activate theme and plugin; migrations will run on activation.
- Bundles are prebuilt in `dist/` (no root `package.json` yet).

## Adding New Features

### New Module (PHP)
1. Create a new PHP file in `includes/` with hooks.
2. Add a corresponding template under `template-parts/`.
3. Add JavaScript in `assets/js/` if needed.
4. Update the database schema when necessary.

### New React Component
1. Create under `src/components/`.
2. Add to the relevant page template.
3. Update build configuration.
4. Test thoroughly.

### Database Schema Updates
1. Update `includes/database-migration.php`.
2. Add a migration version.
3. Test the migration path.
4. Document the change (update this file and changelog).

## Access Control & Dark Mode
- App pages require login; unauthenticated users see the theme’s sign‑in screen.
- Dark/light toggle (`assets/js/theme-toggle.js`) persists user choice; theme sets `data-theme` on `<html>` before styles load to avoid FOUC.
- Dark overrides live in `assets/css/dark-override.css`.

## Changelog (engineering updates)
Keep this section updated after fixes/changes.

### 2025‑08‑31
- Dark mode: added `assets/css/dark-override.css` and early `data-theme` boot.
- Theme toggle: enqueued on theme pages and aligned in header next to Logout.
- Auth protection: app requires login; restricted `wp_ajax_nopriv` to safe reads; modernized login UI.
- AJAX URL: switched to relative `admin-ajax.php` to avoid http/https warnings.
- Inventory/Categories/Locations (dark): unified card/list/badge colors; icon‑only buttons adjusted.
- Sales (dark): stat cards, search form, profit controls, date input, and table colors fixed.
- Forms (modals): standardized `.modal` containers, removed inline separators, normalized field layout; scoped top‑level layout via `.modal-form` to preserve two‑column rows; inputs/selects/textarea full‑width with correct colors in light+dark.
- Modal layout fixes: ensured buttons align inside modal, hid stray side labels, normalized number input spinners, and prevented select truncation; added fallback `.btn` styles. Implemented in plugin `assets/css/{frontend.css,admin.css}`.

### 2025‑10‑07
- Security quick wins (plugin):
  - Removed exposed backup `warehouse-inventory-manager.php.bak`.
  - Escaped LIKE terms with `$wpdb->esc_like(...)` in `handle_get_inventory_items`.
  - Redacted sensitive fields on unauthenticated inventory responses; full data for authenticated users.
  - Removed raw debug `print_r($_POST, ...)` and noisy SQL/user logs from team handlers.
- Tasks UI/UX:
  - Asana‑like columns with colored sticky headers and transparent panels.
  - Grid board + clamped sidebar; fixed column overflow; no overlap on common laptop sizes.
  - Forced 3 kanban columns always visible.
  - Auto‑fit `.tasks-main-container` height to viewport so chat input stays visible.
- Dark mode: Add Task modal fully themed; improved contrast.
- Docs: updated this file.

### 2025‑10‑08
- Categories & Locations hierarchy:
  - Converted pages to nested hierarchical trees with expand/collapse.
  - Inline “Add subcategory/sublocation”; parent_id prefilled on modals.
  - Unlimited depth; recursive render with indentation guides.
  - Dark theming for rows, toggles, badges, modals, indent guides.
- QR Codes (dark): themed scanner/generator panels, cards, print modal.
- Versioning: bumped to 1.1.2 after QR dark fixes.

### 2025‑10‑09
- Tasks UI: viewport‑fit height, forced 3 columns visible; responsive refinements.
- Team (dark): fixed table, badges, modals, and inputs.
- Categories vs Locations parity:
  - Removed inline link colors in categories; aligned typography and spacing with locations.
  - Implemented breadcrumb path and sub‑count chips.
  - Switched categories dropdown to locations model using `.expanded` class and max‑height animation; unified toggle icon rotation.
  - Added scroll clamp for `.categories-tree` to match locations.
- Versioning: bumped to 1.1.3 for parity pass; bumped to 1.1.4 after JS/CSS parity fix.

### 2025‑10‑10
- Internationalization:
  - Added lightweight i18n helper `wh_t()` with Lithuanian strings.
  - Language switcher dropdown beside theme toggle (persists; reloads page).
  - Wired nav/section labels/buttons; strings can be added incrementally.
- UI: header company logo placeholder (gradient LOGO box; swappable later).
- Header: enabled WordPress Custom Logo and centered header title/logo.
- Versioning: bumped to 1.3.5 (feature + subsequent fixes on language + logo).

### 2025‑10‑11
- Security hardening (plugin):
  - Baseline security headers via `send_headers`: `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`, `Permissions-Policy`, and a conservative CSP placeholder.
  - Transient‑based rate limiting helper; applied to `get_inventory_items` (120 req/min/IP).
  - Hardened logo upload: 2MB max, strict MIME allowlist (jpeg/png/gif/webp), and mimes override in `wp_handle_upload`.
  - Reduced data exposure in inventory query by selecting a safe column subset; unauthenticated responses remain redacted.
  - Verified nonce and capability checks across AJAX handlers; search uses `$wpdb->esc_like` and prepared statements.
  - Note: CSP currently broad to avoid breaking inline assets; future iteration to nonce‑based CSP.

### 2025‑10‑12
- Deploy/CI: `.github/workflows/deploy.yml` syncs theme + plugin to Hostinger on push to `main` (SSH deploy key, `TARGET_DIR`).
- DB schema & migrations:
  - `db/schema.sql`: tasks `updated_at`, inventory `idx_updated_at`, stock movements FK `RESTRICT`, and `wp_wh_settings` with language seeds (`language=en`, `language_available=en,lt`).
  - Theme `functions.php` ensures required task columns (`updated_at`, `completed_at`) exist before writes and creates `wp_wh_task_history` if missing.
  - Task history insert made schema‑aware (supports legacy/new columns).
- Theme/Header/UI:
  - Consolidated actions into Settings dropdown (moved Logo upload + Logout inside Settings). Added “Company Logo” entry opening the same modal.
  - Fixed dark‑mode color inconsistencies on Tasks header buttons; added high‑specificity overrides.
  - Language: header boot syncs `warehouse_lang` cookie from localStorage to keep server‑rendered labels consistent across tabs.
- Tasks (Kanban):
  - Scoped Tasks’ button styles to `.tasks-content`.
  - Robust archive flow: when task dragged to Completed, auto‑archives after 3s and refreshes History; returns concrete DB errors if any.
  - New task creation returns created task and injects a card into Pending without full reload (with assignee, created date, due date, overdue badge).
  - Removed stray PHP output that previously broke JSON and forced Quirks Mode.
- Service Worker / Caching:
  - Network‑first for HTML/navigation and excluded admin‑ajax/wp‑json from caching; static assets use stale‑while‑revalidate. Immediate SW activation with one‑time reload.
  - `assets/js/production.js` avoids page pre‑cache and auto‑activates new SW version.
- Plugin: added missing plugin view files under `includes/admin/*.php` and `includes/shortcodes/*.php` to avoid include errors; they reuse theme template parts.

## API Endpoints (AJAX Handlers)
- `get_inventory_items` — Get all inventory items
- `save_inventory_item` — Save inventory item
- `delete_inventory_item` — Delete inventory item
- `get_categories` — Get all categories
- `save_category` — Save category
- `delete_category` — Delete category
- `get_locations` — Get all locations
- `save_location` — Save location
- `delete_location` — Delete location
- `generate_qr_code` — Generate QR code
- `add_task` — Add new task
- `update_task_status` — Update task status
- `get_task_history` — Get completed tasks
- `send_chat_message` — Send team chat message
- Additional: `get_dashboard_stats`, `get_profit_data`, `rebuild_profit_data`, `fix_purchase_prices`, `debug_profit_data`, `get_team_members`, `add_team_member`, `update_team_member`, `delete_team_member`, `reset_user_password`, `get_inactive_items`, `permanently_delete_item`, `bulk_cleanup_inactive_items`.

Public read‑only (no login): `get_inventory_items`, `get_dashboard_stats` (with rate limiting and redactions as applicable).

## Troubleshooting
- Database: verify `wp-config.php` credentials.
- Permissions: ensure proper file permissions.
- AJAX: confirm nonce validation and capability checks.
- Styling: clear cache; verify `assets/css/dark-override.css` and `assets/js/theme-toggle.js` are loaded.
- Mixed Content/SSL: enable HTTPS in Local; optionally set `FORCE_SSL_ADMIN`.

## Debug Mode
Enable in `wp-config.php`:
```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

## Contributing
1. Create feature branch from `main`.
2. Follow coding standards.
3. Add tests for new features.
4. Update documentation (this file + user‑facing docs as needed).
5. Submit pull request.

## Versioning Rules
- Bug fix: bump patch `+0.0.1`.
- New feature: bump minor `+0.1`.
- Record the change in the changelog and update any visible version strings in the theme/plugin UI if present.

## Support
- WordPress documentation
- Plugin documentation
- Theme documentation
- GitHub issues

