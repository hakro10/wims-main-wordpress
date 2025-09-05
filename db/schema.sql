-- Warehouse Inventory Management System - Database Schema (no data)
-- Safe to import on Hostinger. Creates required tables with indexes and constraints.
-- Notes:
-- - Uses InnoDB + utf8mb4 for reliability and full Unicode.
-- - Assumes WordPress table prefix `wp_`. Adjust if your prefix differs.
-- - All foreign keys are ON DELETE SET NULL or CASCADE where appropriate.
-- - No data is inserted here.

SET NAMES utf8mb4;
SET time_zone = '+00:00';

-- Ensure database engine and charset
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE';

-- Core app tables (prefix-aware by replacing `wp_` if needed)

CREATE TABLE IF NOT EXISTS `wp_wh_categories` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `parent_id` MEDIUMINT UNSIGNED NULL,
  `color` VARCHAR(7) NOT NULL DEFAULT '#3b82f6',
  `icon` VARCHAR(50) NULL,
  `sort_order` INT NOT NULL DEFAULT 0,
  `item_count` INT NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_slug` (`slug`),
  KEY `idx_parent` (`parent_id`),
  KEY `idx_active` (`is_active`),
  CONSTRAINT `fk_cat_parent` FOREIGN KEY (`parent_id`) REFERENCES `wp_wh_categories`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_locations` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `code` VARCHAR(50) NULL,
  `type` VARCHAR(50) NOT NULL DEFAULT 'storage',
  `description` TEXT NULL,
  `parent_id` MEDIUMINT UNSIGNED NULL,
  `level` INT NOT NULL DEFAULT 1,
  `path` VARCHAR(500) NULL,
  `address` TEXT NULL,
  `contact_person` VARCHAR(255) NULL,
  `phone` VARCHAR(50) NULL,
  `email` VARCHAR(255) NULL,
  `capacity` INT NULL,
  `current_capacity` INT NOT NULL DEFAULT 0,
  `zone` VARCHAR(100) NULL,
  `aisle` VARCHAR(50) NULL,
  `rack` VARCHAR(50) NULL,
  `shelf` VARCHAR(50) NULL,
  `bin` VARCHAR(50) NULL,
  `qr_code_image` TEXT NULL,
  `barcode` VARCHAR(100) NULL,
  `temperature_controlled` TINYINT(1) NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_parent` (`parent_id`),
  KEY `idx_type` (`type`),
  KEY `idx_active` (`is_active`),
  KEY `idx_code` (`code`),
  CONSTRAINT `fk_loc_parent` FOREIGN KEY (`parent_id`) REFERENCES `wp_wh_locations`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_suppliers` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `company` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `phone` VARCHAR(50) NULL,
  `address` TEXT NULL,
  `contact_person` VARCHAR(255) NULL,
  `tax_id` VARCHAR(100) NULL,
  `payment_terms` VARCHAR(100) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_inventory_items` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `internal_id` VARCHAR(100) NOT NULL,
  `sku` VARCHAR(100) NULL,
  `barcode` VARCHAR(100) NULL,
  `serial_number` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `category_id` MEDIUMINT UNSIGNED NULL,
  `location_id` MEDIUMINT UNSIGNED NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `reserved_quantity` INT NOT NULL DEFAULT 0,
  `min_stock_level` INT NOT NULL DEFAULT 1,
  `max_stock_level` INT NULL,
  `purchase_price` DECIMAL(10,2) NULL,
  `selling_price` DECIMAL(10,2) NULL,
  `cost_price` DECIMAL(10,2) NULL,
  `supplier_id` MEDIUMINT UNSIGNED NULL,
  `supplier_sku` VARCHAR(100) NULL,
  `weight` DECIMAL(8,2) NULL,
  `dimensions` VARCHAR(100) NULL,
  `unit` VARCHAR(20) NOT NULL DEFAULT 'pieces',
  `status` VARCHAR(50) NOT NULL DEFAULT 'active',
  `stock_status` VARCHAR(50) NOT NULL DEFAULT 'in-stock',
  `image_url` VARCHAR(500) NULL,
  `qr_code_image` TEXT NULL,
  `notes` TEXT NULL,
  `last_counted_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` MEDIUMINT UNSIGNED NULL,
  `updated_by` MEDIUMINT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_internal_id` (`internal_id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_location` (`location_id`),
  KEY `idx_status` (`status`),
  KEY `idx_stock_status` (`stock_status`),
  CONSTRAINT `fk_item_category` FOREIGN KEY (`category_id`) REFERENCES `wp_wh_categories`(`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_item_location` FOREIGN KEY (`location_id`) REFERENCES `wp_wh_locations`(`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_item_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `wp_wh_suppliers`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_stock_movements` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` MEDIUMINT UNSIGNED NOT NULL,
  `movement_type` VARCHAR(50) NOT NULL,
  `quantity_before` INT NOT NULL,
  `quantity_changed` INT NOT NULL,
  `quantity_after` INT NOT NULL,
  `unit_cost` DECIMAL(10,2) NULL,
  `total_cost` DECIMAL(10,2) NULL,
  `reference_type` VARCHAR(50) NULL,
  `reference_id` MEDIUMINT UNSIGNED NULL,
  `location_from` MEDIUMINT UNSIGNED NULL,
  `location_to` MEDIUMINT UNSIGNED NULL,
  `reason` VARCHAR(255) NULL,
  `notes` TEXT NULL,
  `performed_by` MEDIUMINT UNSIGNED NULL,
  `performed_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `batch_id` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_item` (`item_id`),
  KEY `idx_type` (`movement_type`),
  KEY `idx_date` (`performed_at`),
  KEY `idx_batch` (`batch_id`),
  CONSTRAINT `fk_move_item` FOREIGN KEY (`item_id`) REFERENCES `wp_wh_inventory_items`(`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_move_loc_from` FOREIGN KEY (`location_from`) REFERENCES `wp_wh_locations`(`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_move_loc_to` FOREIGN KEY (`location_to`) REFERENCES `wp_wh_locations`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_sales` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sale_number` VARCHAR(100) NOT NULL,
  `item_id` MEDIUMINT UNSIGNED NOT NULL,
  `quantity_sold` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `discount_amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `tax_amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `customer_name` VARCHAR(255) NULL,
  `customer_email` VARCHAR(255) NULL,
  `customer_phone` VARCHAR(50) NULL,
  `customer_address` TEXT NULL,
  `payment_method` VARCHAR(50) NULL,
  `payment_status` VARCHAR(50) NOT NULL DEFAULT 'pending',
  `delivery_method` VARCHAR(50) NULL,
  `delivery_status` VARCHAR(50) NULL,
  `delivery_address` TEXT NULL,
  `tracking_number` VARCHAR(100) NULL,
  `sale_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` DATETIME NULL,
  `sold_by` MEDIUMINT UNSIGNED NULL,
  `notes` TEXT NULL,
  `metadata` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_sale_number` (`sale_number`),
  KEY `idx_item` (`item_id`),
  KEY `idx_date` (`sale_date`),
  KEY `idx_customer` (`customer_email`),
  KEY `idx_status` (`payment_status`),
  CONSTRAINT `fk_sales_item` FOREIGN KEY (`item_id`) REFERENCES `wp_wh_inventory_items`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_tasks` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `priority` VARCHAR(20) NOT NULL DEFAULT 'medium',
  `assigned_to` BIGINT UNSIGNED NULL,
  `due_date` DATE NULL,
  `status` VARCHAR(20) NOT NULL DEFAULT 'pending',
  `created_by` BIGINT UNSIGNED NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_assigned_to` (`assigned_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_task_history` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `task_id` MEDIUMINT UNSIGNED NULL,
  `user_id` BIGINT UNSIGNED NULL,
  `title` VARCHAR(255) NULL,
  `action` VARCHAR(50) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  KEY `idx_task` (`task_id`),
  KEY `idx_date` (`created_at`),
  CONSTRAINT `fk_task_hist_task` FOREIGN KEY (`task_id`) REFERENCES `wp_wh_tasks`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_team_members` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `username` VARCHAR(60) NULL,
  `email` VARCHAR(100) NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `role` VARCHAR(100) NULL,
  `department` VARCHAR(100) NULL,
  `phone` VARCHAR(50) NULL,
  `status` VARCHAR(20) NOT NULL DEFAULT 'active',
  `last_login` DATETIME NULL,
  `created_by` BIGINT UNSIGNED NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_wh_chat_messages` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel` VARCHAR(50) NOT NULL DEFAULT 'general',
  `user_id` BIGINT UNSIGNED NULL,
  `message` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_channel_date` (`channel`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Restore SQL mode
SET SQL_MODE=@OLD_SQL_MODE;

