# GEMINI Project Context

## Project Overview

This project is a **Warehouse Inventory Management System** built on **WordPress**. It consists of a custom plugin (`warehouse-inventory-manager`) and a custom theme (`warehouse-inventory`). The system provides features for managing inventory, tracking sales, and includes a modern user interface with a dashboard, charts, and QR code generation.

**Key Technologies:**

*   **Backend:** PHP, WordPress, MySQL
*   **Frontend:** shadcn/ui, JavaScript, CSS
*   **Development:** Local by Flywheel is recommended for local development.

## Building and Running

### Local Development Setup

1.  **Prerequisites:**
    *   WordPress 6.0+
    *   PHP 8.0+
    *   MySQL 8.0+
    *   [Local by Flywheel](https://localwp.com/)

2.  **Installation:**
    *   Clone the repository.
    *   Use Local by Flywheel to create a new WordPress site.
    *   Copy the repository files to your WordPress installation directory.
    *   Install the **Warehouse Inventory Manager** plugin by copying the `warehouse-inventory-manager/` directory to `wp-content/plugins/` and activating it in the WordPress admin.
    *   Install the **Warehouse Inventory Manager** theme by copying the `warehouse-inventory-manager/` directory to `wp-content/themes/` and activating it in the WordPress admin.

### Running Tests

The project includes an automated test suite. To run the tests, execute the following command in your terminal:

```bash
php test-system.php
```

### Database

The database schema is created automatically when the plugin is activated. A script is available to check the inventory data and add test items:

```bash
php app/public/check-inventory-data.php
```

## Development Conventions

*   **Branching:** The `testing-kilo-code` branch is used for development.
*   **Custom Plugin and Theme:** The core functionality is encapsulated in the `warehouse-inventory-manager` plugin, with the frontend presentation handled by the `warehouse-inventory` theme.
*   **Auditing:** The project includes a script to audit for inconsistencies and missing files. This can be run with:
    ```bash
    php project-audit.php
    ```
*   **Deployment:** The `DEPLOYMENT.md` file contains detailed instructions for deploying the project to a production environment.
*   **Configuration:** The WordPress configuration is managed in the `app/public/wp-config.php` file.
