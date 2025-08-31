# Warehouse Inventory Management System - Installation Guide

## Quick Start Guide

### Prerequisites
- WordPress 6.0+
- PHP 8.0+
- MySQL 8.0+
- Local by Flywheel (for local development)

### Installation Steps

#### 1. Clone the Repository
```bash
git clone https://github.com/hakro10/wims_mariaus_wordpress.git
cd wims_mariaus_wordpress
```

#### 2. Switch to Testing Branch
```bash
git checkout testing-kilo-code
```

#### 3. Install WordPress
- Use Local by Flywheel to create a new WordPress site
- Copy the repository files to your WordPress installation

#### 4. Install the Plugin (Active: Warehouse Inventory Manager)
1. Copy `warehouse-inventory-manager/` to `wp-content/plugins/`
2. Activate the plugin "Warehouse Inventory Manager" in WordPress Admin → Plugins

#### 5. Install the Theme (Active: Warehouse Inventory Manager)
1. Copy `warehouse-inventory-manager/` to `wp-content/themes/`
2. Activate the theme "Warehouse Inventory Manager" in WordPress Admin → Appearance → Themes

#### 6. Run Database Migration
The plugin will automatically create all necessary tables on activation.

### Configuration

#### 1. Basic Settings
- Navigate to WordPress Admin → Warehouse → Settings
- Configure currency, low stock threshold, and other preferences

#### 2. Create Sample Data
- Categories: Electronics, Tools, Office Supplies, Safety Equipment, Consumables
- Locations: Main Warehouse, Section A, Section B, Aisle A1, Aisle A2

#### 3. Set Up Pages
Create these pages with the corresponding shortcodes:
- **Dashboard**: `[warehouse_dashboard]`
- **Inventory**: `[warehouse_inventory]`

### Testing the System

#### Run Automated Tests
```bash
php test-system.php
```

#### Manual Testing Checklist
- [ ] Plugin activates without errors
- [ ] Database tables are created
- [ ] Dashboard loads with charts
- [ ] Inventory items can be added/edited/deleted
- [ ] Categories and locations work correctly
- [ ] Sales can be recorded
- [ ] QR codes generate properly
- [ ] Team management functions work
- [ ] Responsive design on mobile

### Features Overview

#### Core Features
- **Inventory Management**: Full CRUD operations with categories and locations
- **Sales Tracking**: Record sales with profit calculations
- **Dashboard**: Modern shadcn/ui interface with charts
- **QR Codes**: Generate QR codes for items and locations
- **Team Management**: User roles and permissions
- **Task Management**: Create and assign tasks
- **Real-time Chat**: Team communication system

#### Modern UI Features
- **shadcn/ui Components**: Modern, accessible interface
- **Dark Mode**: Toggle between light and dark themes
- **Responsive Design**: Mobile-first approach
- **Loading States**: Smooth loading animations
- **Charts**: Interactive data visualizations

### Troubleshooting

#### Common Issues

**Database Connection Error**
- Check wp-config.php settings
- Verify MySQL is running
- Check database credentials

**Missing Styles**
- Ensure theme is activated
- Check file permissions (755 for directories, 644 for files)
- Clear browser cache

**AJAX Errors**
- Check browser console for JavaScript errors
- Verify nonce values are correct
- Check WordPress debug log

#### Debug Mode
Enable WordPress debug mode by adding to wp-config.php:
```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

### Development Setup

#### Local Development
1. Install Local by Flywheel
2. Create new WordPress site
3. Clone repository to site directory
4. Follow installation steps above

#### Database Reset
To reset the database:
```bash
wp db reset --allow-root
wp plugin deactivate warehouse-inventory-manager --allow-root
wp plugin activate warehouse-inventory-manager --allow-root
```

### API Endpoints

#### AJAX Handlers
- `get_dashboard_stats`: Get dashboard statistics
- `get_inventory_items`: Get inventory items with pagination
- `add_inventory_item`: Add new inventory item
- `update_inventory_item`: Update existing item
- `delete_inventory_item`: Delete inventory item
- `get_categories`: Get all categories
- `get_locations`: Get all locations
- `record_sale`: Record a new sale

### Security Features

- **Nonce Validation**: All AJAX requests use WordPress nonces
- **Capability Checks**: User permissions enforced
- **Data Sanitization**: All input data is sanitized
- **SQL Injection Prevention**: Prepared statements used throughout

### Performance Optimization

- **Database Indexing**: Optimized queries with proper indexes
- **Caching**: WordPress transients for expensive operations
- **Lazy Loading**: Images and data loaded on demand
- **Minification**: CSS and JavaScript minified in production

### Support

#### Documentation
- [Developer Guide](agents.md)
- [Development Log](dev-logs.md)
- [API Documentation](docs/api.md)

#### Getting Help
- Check the [GitHub Issues](https://github.com/hakro10/wims_mariaus_wordpress/issues)
- Review the troubleshooting section above
- Run the test suite: `php test-system.php`

### Next Steps

After installation:
1. Add your first inventory items
2. Set up categories and locations
3. Create team members
4. Start recording sales
5. Explore the dashboard analytics

### License
GPL v2 or later - See LICENSE file for details
