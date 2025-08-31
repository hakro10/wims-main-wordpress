# Warehouse Inventory Management System - Developer Documentation

## Project Overview
A comprehensive WordPress-based warehouse inventory management system built with modern web technologies. The system provides complete inventory tracking, location management, category organization, task management, team collaboration, QR code generation, and sales tracking capabilities.

## Technology Stack

### Frontend
- **Framework**: WordPress Theme + React Components (planned migration)
- **Styling**: Tailwind CSS (planned migration from custom CSS)
- **UI Components**: shadcn/ui (planned integration)
- **Icons**: Font Awesome
- **Charts**: Chart.js (for dashboard analytics)
- **QR Codes**: qrcode.js library

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

### WordPress Theme (`warehouse-inventory/`)
```
warehouse-inventory/
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
```
warehouse-inventory-manager/
├── warehouse-inventory-manager.php  # Main plugin file
├── includes/
│   ├── class-wh-activator.php      # Plugin activation
│   ├── class-wh-deactivator.php    # Plugin deactivation
│   ├── class-wh-loader.php         # Class autoloader
│   ├── class-wh-qr-codes.php       # QR code functionality
│   └── database-migration.php      # Database schema management
```

## Database Schema

### Core Tables
- `wp_wh_inventory_items` - Main inventory items
- `wp_wh_categories` - Product categories
- `wp_wh_locations` - Storage locations
- `wp_wh_sales` - Sales records
- `wp_wh_tasks` - Task management
- `wp_wh_team_members` - Team member management

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
3. Copy theme to `wp-content/themes/`
4. Copy plugin to `wp-content/plugins/`
5. Activate theme and plugin in WordPress admin
6. Run database migration (automatic on plugin activation)

### Development Commands
```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run tests
npm test

# Database migration
wp wh-migrate
```

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

## Troubleshooting

### Common Issues
1. **Database Connection**: Check wp-config.php settings
2. **Permission Errors**: Ensure proper file permissions
3. **AJAX Failures**: Check nonce validation
4. **Styling Issues**: Clear browser cache

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

## Support
For technical support or questions, refer to:
- WordPress documentation
- Plugin documentation
- Theme documentation
- GitHub issues