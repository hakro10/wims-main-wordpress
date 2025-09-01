-- MySQL dump 10.13  Distrib 8.0.35, for macos13 (arm64)
--
-- Host: localhost    Database: local
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
INSERT INTO `wp_comments` VALUES (1,1,'A WordPress Commenter','wapuu@wordpress.example','https://wordpress.org/','','2025-06-08 08:20:05','2025-06-08 08:20:05','Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href=\"https://gravatar.com/\">Gravatar</a>.',0,'1','','comment',0,0);
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_links` (
  `link_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint unsigned NOT NULL DEFAULT '1',
  `link_rating` int NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_options` (
  `option_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=558 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (1,'cron','a:12:{i:1756759562;a:1:{s:21:\"wp_update_user_counts\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1756761203;a:1:{s:23:\"warehouse_daily_cleanup\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1756761605;a:1:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1756761606;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1756763405;a:1:{s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1756765205;a:1:{s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1756801206;a:1:{s:32:\"recovery_mode_clean_expired_keys\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1756802762;a:2:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1756802765;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1756862953;a:1:{s:30:\"wp_delete_temp_updater_backups\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}i:1757319606;a:1:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}s:7:\"version\";i:2;}','on');
INSERT INTO `wp_options` VALUES (2,'siteurl','http://auris.local','on');
INSERT INTO `wp_options` VALUES (3,'home','http://auris.local','on');
INSERT INTO `wp_options` VALUES (4,'blogname','auris','on');
INSERT INTO `wp_options` VALUES (5,'blogdescription','','on');
INSERT INTO `wp_options` VALUES (6,'users_can_register','0','on');
INSERT INTO `wp_options` VALUES (7,'admin_email','dev-email@wpengine.local','on');
INSERT INTO `wp_options` VALUES (8,'start_of_week','1','on');
INSERT INTO `wp_options` VALUES (9,'use_balanceTags','0','on');
INSERT INTO `wp_options` VALUES (10,'use_smilies','1','on');
INSERT INTO `wp_options` VALUES (11,'require_name_email','1','on');
INSERT INTO `wp_options` VALUES (12,'comments_notify','1','on');
INSERT INTO `wp_options` VALUES (13,'posts_per_rss','10','on');
INSERT INTO `wp_options` VALUES (14,'rss_use_excerpt','0','on');
INSERT INTO `wp_options` VALUES (15,'mailserver_url','mail.example.com','on');
INSERT INTO `wp_options` VALUES (16,'mailserver_login','login@example.com','on');
INSERT INTO `wp_options` VALUES (17,'mailserver_pass','','on');
INSERT INTO `wp_options` VALUES (18,'mailserver_port','110','on');
INSERT INTO `wp_options` VALUES (19,'default_category','1','on');
INSERT INTO `wp_options` VALUES (20,'default_comment_status','open','on');
INSERT INTO `wp_options` VALUES (21,'default_ping_status','open','on');
INSERT INTO `wp_options` VALUES (22,'default_pingback_flag','1','on');
INSERT INTO `wp_options` VALUES (23,'posts_per_page','10','on');
INSERT INTO `wp_options` VALUES (24,'date_format','F j, Y','on');
INSERT INTO `wp_options` VALUES (25,'time_format','g:i a','on');
INSERT INTO `wp_options` VALUES (26,'links_updated_date_format','F j, Y g:i a','on');
INSERT INTO `wp_options` VALUES (27,'comment_moderation','0','on');
INSERT INTO `wp_options` VALUES (28,'moderation_notify','1','on');
INSERT INTO `wp_options` VALUES (29,'permalink_structure','/%postname%/','on');
INSERT INTO `wp_options` VALUES (30,'rewrite_rules','a:94:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:17:\"^wp-sitemap\\.xml$\";s:23:\"index.php?sitemap=index\";s:17:\"^wp-sitemap\\.xsl$\";s:36:\"index.php?sitemap-stylesheet=sitemap\";s:23:\"^wp-sitemap-index\\.xsl$\";s:34:\"index.php?sitemap-stylesheet=index\";s:48:\"^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$\";s:75:\"index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]\";s:34:\"^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$\";s:47:\"index.php?sitemap=$matches[1]&paged=$matches[2]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:13:\"favicon\\.ico$\";s:19:\"index.php?favicon=1\";s:12:\"sitemap\\.xml\";s:24:\"index.php??sitemap=index\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:27:\"[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\"[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\"[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:20:\"([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:35:\"([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:16:\"[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:26:\"[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:46:\"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:22:\"[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','on');
INSERT INTO `wp_options` VALUES (31,'hack_file','0','on');
INSERT INTO `wp_options` VALUES (32,'blog_charset','UTF-8','on');
INSERT INTO `wp_options` VALUES (33,'moderation_keys','','off');
INSERT INTO `wp_options` VALUES (34,'active_plugins','a:1:{i:0;s:59:\"warehouse-inventory-manager/warehouse-inventory-manager.php\";}','on');
INSERT INTO `wp_options` VALUES (35,'category_base','','on');
INSERT INTO `wp_options` VALUES (36,'ping_sites','https://rpc.pingomatic.com/','on');
INSERT INTO `wp_options` VALUES (37,'comment_max_links','2','on');
INSERT INTO `wp_options` VALUES (38,'gmt_offset','0','on');
INSERT INTO `wp_options` VALUES (39,'default_email_category','1','on');
INSERT INTO `wp_options` VALUES (40,'recently_edited','','off');
INSERT INTO `wp_options` VALUES (41,'template','warehouse-inventory','on');
INSERT INTO `wp_options` VALUES (42,'stylesheet','warehouse-inventory','on');
INSERT INTO `wp_options` VALUES (43,'comment_registration','0','on');
INSERT INTO `wp_options` VALUES (44,'html_type','text/html','on');
INSERT INTO `wp_options` VALUES (45,'use_trackback','0','on');
INSERT INTO `wp_options` VALUES (46,'default_role','subscriber','on');
INSERT INTO `wp_options` VALUES (47,'db_version','60421','on');
INSERT INTO `wp_options` VALUES (48,'uploads_use_yearmonth_folders','1','on');
INSERT INTO `wp_options` VALUES (49,'upload_path','','on');
INSERT INTO `wp_options` VALUES (50,'blog_public','1','on');
INSERT INTO `wp_options` VALUES (51,'default_link_category','2','on');
INSERT INTO `wp_options` VALUES (52,'show_on_front','posts','on');
INSERT INTO `wp_options` VALUES (53,'tag_base','','on');
INSERT INTO `wp_options` VALUES (54,'show_avatars','1','on');
INSERT INTO `wp_options` VALUES (55,'avatar_rating','G','on');
INSERT INTO `wp_options` VALUES (56,'upload_url_path','','on');
INSERT INTO `wp_options` VALUES (57,'thumbnail_size_w','150','on');
INSERT INTO `wp_options` VALUES (58,'thumbnail_size_h','150','on');
INSERT INTO `wp_options` VALUES (59,'thumbnail_crop','1','on');
INSERT INTO `wp_options` VALUES (60,'medium_size_w','300','on');
INSERT INTO `wp_options` VALUES (61,'medium_size_h','300','on');
INSERT INTO `wp_options` VALUES (62,'avatar_default','mystery','on');
INSERT INTO `wp_options` VALUES (63,'large_size_w','1024','on');
INSERT INTO `wp_options` VALUES (64,'large_size_h','1024','on');
INSERT INTO `wp_options` VALUES (65,'image_default_link_type','none','on');
INSERT INTO `wp_options` VALUES (66,'image_default_size','','on');
INSERT INTO `wp_options` VALUES (67,'image_default_align','','on');
INSERT INTO `wp_options` VALUES (68,'close_comments_for_old_posts','0','on');
INSERT INTO `wp_options` VALUES (69,'close_comments_days_old','14','on');
INSERT INTO `wp_options` VALUES (70,'thread_comments','1','on');
INSERT INTO `wp_options` VALUES (71,'thread_comments_depth','5','on');
INSERT INTO `wp_options` VALUES (72,'page_comments','0','on');
INSERT INTO `wp_options` VALUES (73,'comments_per_page','50','on');
INSERT INTO `wp_options` VALUES (74,'default_comments_page','newest','on');
INSERT INTO `wp_options` VALUES (75,'comment_order','asc','on');
INSERT INTO `wp_options` VALUES (76,'sticky_posts','a:0:{}','on');
INSERT INTO `wp_options` VALUES (77,'widget_categories','a:0:{}','on');
INSERT INTO `wp_options` VALUES (78,'widget_text','a:0:{}','on');
INSERT INTO `wp_options` VALUES (79,'widget_rss','a:0:{}','on');
INSERT INTO `wp_options` VALUES (80,'uninstall_plugins','a:0:{}','off');
INSERT INTO `wp_options` VALUES (81,'timezone_string','','on');
INSERT INTO `wp_options` VALUES (82,'page_for_posts','0','on');
INSERT INTO `wp_options` VALUES (83,'page_on_front','0','on');
INSERT INTO `wp_options` VALUES (84,'default_post_format','0','on');
INSERT INTO `wp_options` VALUES (85,'link_manager_enabled','0','on');
INSERT INTO `wp_options` VALUES (86,'finished_splitting_shared_terms','1','on');
INSERT INTO `wp_options` VALUES (87,'site_icon','0','on');
INSERT INTO `wp_options` VALUES (88,'medium_large_size_w','768','on');
INSERT INTO `wp_options` VALUES (89,'medium_large_size_h','0','on');
INSERT INTO `wp_options` VALUES (90,'wp_page_for_privacy_policy','3','on');
INSERT INTO `wp_options` VALUES (91,'show_comments_cookies_opt_in','1','on');
INSERT INTO `wp_options` VALUES (92,'admin_email_lifespan','1764922805','on');
INSERT INTO `wp_options` VALUES (93,'disallowed_keys','','off');
INSERT INTO `wp_options` VALUES (94,'comment_previously_approved','1','on');
INSERT INTO `wp_options` VALUES (95,'auto_plugin_theme_update_emails','a:0:{}','off');
INSERT INTO `wp_options` VALUES (96,'auto_update_core_dev','enabled','on');
INSERT INTO `wp_options` VALUES (97,'auto_update_core_minor','enabled','on');
INSERT INTO `wp_options` VALUES (98,'auto_update_core_major','enabled','on');
INSERT INTO `wp_options` VALUES (99,'wp_force_deactivated_plugins','a:0:{}','on');
INSERT INTO `wp_options` VALUES (100,'wp_attachment_pages_enabled','0','on');
INSERT INTO `wp_options` VALUES (101,'initial_db_version','58975','on');
INSERT INTO `wp_options` VALUES (102,'wp_user_roles','a:7:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:65:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:16:\"manage_warehouse\";b:1;s:14:\"view_warehouse\";b:1;s:14:\"edit_inventory\";b:1;s:16:\"delete_inventory\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}s:17:\"warehouse_manager\";a:2:{s:4:\"name\";s:17:\"Warehouse Manager\";s:12:\"capabilities\";a:7:{s:4:\"read\";b:1;s:10:\"edit_posts\";b:1;s:12:\"delete_posts\";b:1;s:16:\"manage_warehouse\";b:1;s:14:\"view_warehouse\";b:1;s:14:\"edit_inventory\";b:1;s:16:\"delete_inventory\";b:1;}}s:18:\"warehouse_employee\";a:2:{s:4:\"name\";s:18:\"Warehouse Employee\";s:12:\"capabilities\";a:4:{s:4:\"read\";b:1;s:10:\"edit_posts\";b:1;s:14:\"view_warehouse\";b:1;s:14:\"edit_inventory\";b:1;}}}','on');
INSERT INTO `wp_options` VALUES (103,'fresh_site','1','off');
INSERT INTO `wp_options` VALUES (104,'user_count','5','off');
INSERT INTO `wp_options` VALUES (105,'widget_block','a:6:{i:2;a:1:{s:7:\"content\";s:19:\"<!-- wp:search /-->\";}i:3;a:1:{s:7:\"content\";s:154:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Posts</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->\";}i:4;a:1:{s:7:\"content\";s:227:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Comments</h2><!-- /wp:heading --><!-- wp:latest-comments {\"displayAvatar\":false,\"displayDate\":false,\"displayExcerpt\":false} /--></div><!-- /wp:group -->\";}i:5;a:1:{s:7:\"content\";s:146:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->\";}i:6;a:1:{s:7:\"content\";s:150:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->\";}s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (106,'sidebars_widgets','a:2:{s:19:\"wp_inactive_widgets\";a:5:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";i:3;s:7:\"block-5\";i:4;s:7:\"block-6\";}s:13:\"array_version\";i:3;}','auto');
INSERT INTO `wp_options` VALUES (107,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (108,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (109,'widget_archives','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (110,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (111,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (112,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (113,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (114,'widget_meta','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (115,'widget_search','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (116,'widget_recent-posts','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (117,'widget_recent-comments','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (118,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (119,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (120,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (121,'_transient_wp_core_block_css_files','a:2:{s:7:\"version\";s:5:\"6.8.1\";s:5:\"files\";a:536:{i:0;s:23:\"archives/editor-rtl.css\";i:1;s:27:\"archives/editor-rtl.min.css\";i:2;s:19:\"archives/editor.css\";i:3;s:23:\"archives/editor.min.css\";i:4;s:22:\"archives/style-rtl.css\";i:5;s:26:\"archives/style-rtl.min.css\";i:6;s:18:\"archives/style.css\";i:7;s:22:\"archives/style.min.css\";i:8;s:20:\"audio/editor-rtl.css\";i:9;s:24:\"audio/editor-rtl.min.css\";i:10;s:16:\"audio/editor.css\";i:11;s:20:\"audio/editor.min.css\";i:12;s:19:\"audio/style-rtl.css\";i:13;s:23:\"audio/style-rtl.min.css\";i:14;s:15:\"audio/style.css\";i:15;s:19:\"audio/style.min.css\";i:16;s:19:\"audio/theme-rtl.css\";i:17;s:23:\"audio/theme-rtl.min.css\";i:18;s:15:\"audio/theme.css\";i:19;s:19:\"audio/theme.min.css\";i:20;s:21:\"avatar/editor-rtl.css\";i:21;s:25:\"avatar/editor-rtl.min.css\";i:22;s:17:\"avatar/editor.css\";i:23;s:21:\"avatar/editor.min.css\";i:24;s:20:\"avatar/style-rtl.css\";i:25;s:24:\"avatar/style-rtl.min.css\";i:26;s:16:\"avatar/style.css\";i:27;s:20:\"avatar/style.min.css\";i:28;s:21:\"button/editor-rtl.css\";i:29;s:25:\"button/editor-rtl.min.css\";i:30;s:17:\"button/editor.css\";i:31;s:21:\"button/editor.min.css\";i:32;s:20:\"button/style-rtl.css\";i:33;s:24:\"button/style-rtl.min.css\";i:34;s:16:\"button/style.css\";i:35;s:20:\"button/style.min.css\";i:36;s:22:\"buttons/editor-rtl.css\";i:37;s:26:\"buttons/editor-rtl.min.css\";i:38;s:18:\"buttons/editor.css\";i:39;s:22:\"buttons/editor.min.css\";i:40;s:21:\"buttons/style-rtl.css\";i:41;s:25:\"buttons/style-rtl.min.css\";i:42;s:17:\"buttons/style.css\";i:43;s:21:\"buttons/style.min.css\";i:44;s:22:\"calendar/style-rtl.css\";i:45;s:26:\"calendar/style-rtl.min.css\";i:46;s:18:\"calendar/style.css\";i:47;s:22:\"calendar/style.min.css\";i:48;s:25:\"categories/editor-rtl.css\";i:49;s:29:\"categories/editor-rtl.min.css\";i:50;s:21:\"categories/editor.css\";i:51;s:25:\"categories/editor.min.css\";i:52;s:24:\"categories/style-rtl.css\";i:53;s:28:\"categories/style-rtl.min.css\";i:54;s:20:\"categories/style.css\";i:55;s:24:\"categories/style.min.css\";i:56;s:19:\"code/editor-rtl.css\";i:57;s:23:\"code/editor-rtl.min.css\";i:58;s:15:\"code/editor.css\";i:59;s:19:\"code/editor.min.css\";i:60;s:18:\"code/style-rtl.css\";i:61;s:22:\"code/style-rtl.min.css\";i:62;s:14:\"code/style.css\";i:63;s:18:\"code/style.min.css\";i:64;s:18:\"code/theme-rtl.css\";i:65;s:22:\"code/theme-rtl.min.css\";i:66;s:14:\"code/theme.css\";i:67;s:18:\"code/theme.min.css\";i:68;s:22:\"columns/editor-rtl.css\";i:69;s:26:\"columns/editor-rtl.min.css\";i:70;s:18:\"columns/editor.css\";i:71;s:22:\"columns/editor.min.css\";i:72;s:21:\"columns/style-rtl.css\";i:73;s:25:\"columns/style-rtl.min.css\";i:74;s:17:\"columns/style.css\";i:75;s:21:\"columns/style.min.css\";i:76;s:33:\"comment-author-name/style-rtl.css\";i:77;s:37:\"comment-author-name/style-rtl.min.css\";i:78;s:29:\"comment-author-name/style.css\";i:79;s:33:\"comment-author-name/style.min.css\";i:80;s:29:\"comment-content/style-rtl.css\";i:81;s:33:\"comment-content/style-rtl.min.css\";i:82;s:25:\"comment-content/style.css\";i:83;s:29:\"comment-content/style.min.css\";i:84;s:26:\"comment-date/style-rtl.css\";i:85;s:30:\"comment-date/style-rtl.min.css\";i:86;s:22:\"comment-date/style.css\";i:87;s:26:\"comment-date/style.min.css\";i:88;s:31:\"comment-edit-link/style-rtl.css\";i:89;s:35:\"comment-edit-link/style-rtl.min.css\";i:90;s:27:\"comment-edit-link/style.css\";i:91;s:31:\"comment-edit-link/style.min.css\";i:92;s:32:\"comment-reply-link/style-rtl.css\";i:93;s:36:\"comment-reply-link/style-rtl.min.css\";i:94;s:28:\"comment-reply-link/style.css\";i:95;s:32:\"comment-reply-link/style.min.css\";i:96;s:30:\"comment-template/style-rtl.css\";i:97;s:34:\"comment-template/style-rtl.min.css\";i:98;s:26:\"comment-template/style.css\";i:99;s:30:\"comment-template/style.min.css\";i:100;s:42:\"comments-pagination-numbers/editor-rtl.css\";i:101;s:46:\"comments-pagination-numbers/editor-rtl.min.css\";i:102;s:38:\"comments-pagination-numbers/editor.css\";i:103;s:42:\"comments-pagination-numbers/editor.min.css\";i:104;s:34:\"comments-pagination/editor-rtl.css\";i:105;s:38:\"comments-pagination/editor-rtl.min.css\";i:106;s:30:\"comments-pagination/editor.css\";i:107;s:34:\"comments-pagination/editor.min.css\";i:108;s:33:\"comments-pagination/style-rtl.css\";i:109;s:37:\"comments-pagination/style-rtl.min.css\";i:110;s:29:\"comments-pagination/style.css\";i:111;s:33:\"comments-pagination/style.min.css\";i:112;s:29:\"comments-title/editor-rtl.css\";i:113;s:33:\"comments-title/editor-rtl.min.css\";i:114;s:25:\"comments-title/editor.css\";i:115;s:29:\"comments-title/editor.min.css\";i:116;s:23:\"comments/editor-rtl.css\";i:117;s:27:\"comments/editor-rtl.min.css\";i:118;s:19:\"comments/editor.css\";i:119;s:23:\"comments/editor.min.css\";i:120;s:22:\"comments/style-rtl.css\";i:121;s:26:\"comments/style-rtl.min.css\";i:122;s:18:\"comments/style.css\";i:123;s:22:\"comments/style.min.css\";i:124;s:20:\"cover/editor-rtl.css\";i:125;s:24:\"cover/editor-rtl.min.css\";i:126;s:16:\"cover/editor.css\";i:127;s:20:\"cover/editor.min.css\";i:128;s:19:\"cover/style-rtl.css\";i:129;s:23:\"cover/style-rtl.min.css\";i:130;s:15:\"cover/style.css\";i:131;s:19:\"cover/style.min.css\";i:132;s:22:\"details/editor-rtl.css\";i:133;s:26:\"details/editor-rtl.min.css\";i:134;s:18:\"details/editor.css\";i:135;s:22:\"details/editor.min.css\";i:136;s:21:\"details/style-rtl.css\";i:137;s:25:\"details/style-rtl.min.css\";i:138;s:17:\"details/style.css\";i:139;s:21:\"details/style.min.css\";i:140;s:20:\"embed/editor-rtl.css\";i:141;s:24:\"embed/editor-rtl.min.css\";i:142;s:16:\"embed/editor.css\";i:143;s:20:\"embed/editor.min.css\";i:144;s:19:\"embed/style-rtl.css\";i:145;s:23:\"embed/style-rtl.min.css\";i:146;s:15:\"embed/style.css\";i:147;s:19:\"embed/style.min.css\";i:148;s:19:\"embed/theme-rtl.css\";i:149;s:23:\"embed/theme-rtl.min.css\";i:150;s:15:\"embed/theme.css\";i:151;s:19:\"embed/theme.min.css\";i:152;s:19:\"file/editor-rtl.css\";i:153;s:23:\"file/editor-rtl.min.css\";i:154;s:15:\"file/editor.css\";i:155;s:19:\"file/editor.min.css\";i:156;s:18:\"file/style-rtl.css\";i:157;s:22:\"file/style-rtl.min.css\";i:158;s:14:\"file/style.css\";i:159;s:18:\"file/style.min.css\";i:160;s:23:\"footnotes/style-rtl.css\";i:161;s:27:\"footnotes/style-rtl.min.css\";i:162;s:19:\"footnotes/style.css\";i:163;s:23:\"footnotes/style.min.css\";i:164;s:23:\"freeform/editor-rtl.css\";i:165;s:27:\"freeform/editor-rtl.min.css\";i:166;s:19:\"freeform/editor.css\";i:167;s:23:\"freeform/editor.min.css\";i:168;s:22:\"gallery/editor-rtl.css\";i:169;s:26:\"gallery/editor-rtl.min.css\";i:170;s:18:\"gallery/editor.css\";i:171;s:22:\"gallery/editor.min.css\";i:172;s:21:\"gallery/style-rtl.css\";i:173;s:25:\"gallery/style-rtl.min.css\";i:174;s:17:\"gallery/style.css\";i:175;s:21:\"gallery/style.min.css\";i:176;s:21:\"gallery/theme-rtl.css\";i:177;s:25:\"gallery/theme-rtl.min.css\";i:178;s:17:\"gallery/theme.css\";i:179;s:21:\"gallery/theme.min.css\";i:180;s:20:\"group/editor-rtl.css\";i:181;s:24:\"group/editor-rtl.min.css\";i:182;s:16:\"group/editor.css\";i:183;s:20:\"group/editor.min.css\";i:184;s:19:\"group/style-rtl.css\";i:185;s:23:\"group/style-rtl.min.css\";i:186;s:15:\"group/style.css\";i:187;s:19:\"group/style.min.css\";i:188;s:19:\"group/theme-rtl.css\";i:189;s:23:\"group/theme-rtl.min.css\";i:190;s:15:\"group/theme.css\";i:191;s:19:\"group/theme.min.css\";i:192;s:21:\"heading/style-rtl.css\";i:193;s:25:\"heading/style-rtl.min.css\";i:194;s:17:\"heading/style.css\";i:195;s:21:\"heading/style.min.css\";i:196;s:19:\"html/editor-rtl.css\";i:197;s:23:\"html/editor-rtl.min.css\";i:198;s:15:\"html/editor.css\";i:199;s:19:\"html/editor.min.css\";i:200;s:20:\"image/editor-rtl.css\";i:201;s:24:\"image/editor-rtl.min.css\";i:202;s:16:\"image/editor.css\";i:203;s:20:\"image/editor.min.css\";i:204;s:19:\"image/style-rtl.css\";i:205;s:23:\"image/style-rtl.min.css\";i:206;s:15:\"image/style.css\";i:207;s:19:\"image/style.min.css\";i:208;s:19:\"image/theme-rtl.css\";i:209;s:23:\"image/theme-rtl.min.css\";i:210;s:15:\"image/theme.css\";i:211;s:19:\"image/theme.min.css\";i:212;s:29:\"latest-comments/style-rtl.css\";i:213;s:33:\"latest-comments/style-rtl.min.css\";i:214;s:25:\"latest-comments/style.css\";i:215;s:29:\"latest-comments/style.min.css\";i:216;s:27:\"latest-posts/editor-rtl.css\";i:217;s:31:\"latest-posts/editor-rtl.min.css\";i:218;s:23:\"latest-posts/editor.css\";i:219;s:27:\"latest-posts/editor.min.css\";i:220;s:26:\"latest-posts/style-rtl.css\";i:221;s:30:\"latest-posts/style-rtl.min.css\";i:222;s:22:\"latest-posts/style.css\";i:223;s:26:\"latest-posts/style.min.css\";i:224;s:18:\"list/style-rtl.css\";i:225;s:22:\"list/style-rtl.min.css\";i:226;s:14:\"list/style.css\";i:227;s:18:\"list/style.min.css\";i:228;s:22:\"loginout/style-rtl.css\";i:229;s:26:\"loginout/style-rtl.min.css\";i:230;s:18:\"loginout/style.css\";i:231;s:22:\"loginout/style.min.css\";i:232;s:25:\"media-text/editor-rtl.css\";i:233;s:29:\"media-text/editor-rtl.min.css\";i:234;s:21:\"media-text/editor.css\";i:235;s:25:\"media-text/editor.min.css\";i:236;s:24:\"media-text/style-rtl.css\";i:237;s:28:\"media-text/style-rtl.min.css\";i:238;s:20:\"media-text/style.css\";i:239;s:24:\"media-text/style.min.css\";i:240;s:19:\"more/editor-rtl.css\";i:241;s:23:\"more/editor-rtl.min.css\";i:242;s:15:\"more/editor.css\";i:243;s:19:\"more/editor.min.css\";i:244;s:30:\"navigation-link/editor-rtl.css\";i:245;s:34:\"navigation-link/editor-rtl.min.css\";i:246;s:26:\"navigation-link/editor.css\";i:247;s:30:\"navigation-link/editor.min.css\";i:248;s:29:\"navigation-link/style-rtl.css\";i:249;s:33:\"navigation-link/style-rtl.min.css\";i:250;s:25:\"navigation-link/style.css\";i:251;s:29:\"navigation-link/style.min.css\";i:252;s:33:\"navigation-submenu/editor-rtl.css\";i:253;s:37:\"navigation-submenu/editor-rtl.min.css\";i:254;s:29:\"navigation-submenu/editor.css\";i:255;s:33:\"navigation-submenu/editor.min.css\";i:256;s:25:\"navigation/editor-rtl.css\";i:257;s:29:\"navigation/editor-rtl.min.css\";i:258;s:21:\"navigation/editor.css\";i:259;s:25:\"navigation/editor.min.css\";i:260;s:24:\"navigation/style-rtl.css\";i:261;s:28:\"navigation/style-rtl.min.css\";i:262;s:20:\"navigation/style.css\";i:263;s:24:\"navigation/style.min.css\";i:264;s:23:\"nextpage/editor-rtl.css\";i:265;s:27:\"nextpage/editor-rtl.min.css\";i:266;s:19:\"nextpage/editor.css\";i:267;s:23:\"nextpage/editor.min.css\";i:268;s:24:\"page-list/editor-rtl.css\";i:269;s:28:\"page-list/editor-rtl.min.css\";i:270;s:20:\"page-list/editor.css\";i:271;s:24:\"page-list/editor.min.css\";i:272;s:23:\"page-list/style-rtl.css\";i:273;s:27:\"page-list/style-rtl.min.css\";i:274;s:19:\"page-list/style.css\";i:275;s:23:\"page-list/style.min.css\";i:276;s:24:\"paragraph/editor-rtl.css\";i:277;s:28:\"paragraph/editor-rtl.min.css\";i:278;s:20:\"paragraph/editor.css\";i:279;s:24:\"paragraph/editor.min.css\";i:280;s:23:\"paragraph/style-rtl.css\";i:281;s:27:\"paragraph/style-rtl.min.css\";i:282;s:19:\"paragraph/style.css\";i:283;s:23:\"paragraph/style.min.css\";i:284;s:35:\"post-author-biography/style-rtl.css\";i:285;s:39:\"post-author-biography/style-rtl.min.css\";i:286;s:31:\"post-author-biography/style.css\";i:287;s:35:\"post-author-biography/style.min.css\";i:288;s:30:\"post-author-name/style-rtl.css\";i:289;s:34:\"post-author-name/style-rtl.min.css\";i:290;s:26:\"post-author-name/style.css\";i:291;s:30:\"post-author-name/style.min.css\";i:292;s:26:\"post-author/editor-rtl.css\";i:293;s:30:\"post-author/editor-rtl.min.css\";i:294;s:22:\"post-author/editor.css\";i:295;s:26:\"post-author/editor.min.css\";i:296;s:25:\"post-author/style-rtl.css\";i:297;s:29:\"post-author/style-rtl.min.css\";i:298;s:21:\"post-author/style.css\";i:299;s:25:\"post-author/style.min.css\";i:300;s:33:\"post-comments-form/editor-rtl.css\";i:301;s:37:\"post-comments-form/editor-rtl.min.css\";i:302;s:29:\"post-comments-form/editor.css\";i:303;s:33:\"post-comments-form/editor.min.css\";i:304;s:32:\"post-comments-form/style-rtl.css\";i:305;s:36:\"post-comments-form/style-rtl.min.css\";i:306;s:28:\"post-comments-form/style.css\";i:307;s:32:\"post-comments-form/style.min.css\";i:308;s:26:\"post-content/style-rtl.css\";i:309;s:30:\"post-content/style-rtl.min.css\";i:310;s:22:\"post-content/style.css\";i:311;s:26:\"post-content/style.min.css\";i:312;s:23:\"post-date/style-rtl.css\";i:313;s:27:\"post-date/style-rtl.min.css\";i:314;s:19:\"post-date/style.css\";i:315;s:23:\"post-date/style.min.css\";i:316;s:27:\"post-excerpt/editor-rtl.css\";i:317;s:31:\"post-excerpt/editor-rtl.min.css\";i:318;s:23:\"post-excerpt/editor.css\";i:319;s:27:\"post-excerpt/editor.min.css\";i:320;s:26:\"post-excerpt/style-rtl.css\";i:321;s:30:\"post-excerpt/style-rtl.min.css\";i:322;s:22:\"post-excerpt/style.css\";i:323;s:26:\"post-excerpt/style.min.css\";i:324;s:34:\"post-featured-image/editor-rtl.css\";i:325;s:38:\"post-featured-image/editor-rtl.min.css\";i:326;s:30:\"post-featured-image/editor.css\";i:327;s:34:\"post-featured-image/editor.min.css\";i:328;s:33:\"post-featured-image/style-rtl.css\";i:329;s:37:\"post-featured-image/style-rtl.min.css\";i:330;s:29:\"post-featured-image/style.css\";i:331;s:33:\"post-featured-image/style.min.css\";i:332;s:34:\"post-navigation-link/style-rtl.css\";i:333;s:38:\"post-navigation-link/style-rtl.min.css\";i:334;s:30:\"post-navigation-link/style.css\";i:335;s:34:\"post-navigation-link/style.min.css\";i:336;s:27:\"post-template/style-rtl.css\";i:337;s:31:\"post-template/style-rtl.min.css\";i:338;s:23:\"post-template/style.css\";i:339;s:27:\"post-template/style.min.css\";i:340;s:24:\"post-terms/style-rtl.css\";i:341;s:28:\"post-terms/style-rtl.min.css\";i:342;s:20:\"post-terms/style.css\";i:343;s:24:\"post-terms/style.min.css\";i:344;s:24:\"post-title/style-rtl.css\";i:345;s:28:\"post-title/style-rtl.min.css\";i:346;s:20:\"post-title/style.css\";i:347;s:24:\"post-title/style.min.css\";i:348;s:26:\"preformatted/style-rtl.css\";i:349;s:30:\"preformatted/style-rtl.min.css\";i:350;s:22:\"preformatted/style.css\";i:351;s:26:\"preformatted/style.min.css\";i:352;s:24:\"pullquote/editor-rtl.css\";i:353;s:28:\"pullquote/editor-rtl.min.css\";i:354;s:20:\"pullquote/editor.css\";i:355;s:24:\"pullquote/editor.min.css\";i:356;s:23:\"pullquote/style-rtl.css\";i:357;s:27:\"pullquote/style-rtl.min.css\";i:358;s:19:\"pullquote/style.css\";i:359;s:23:\"pullquote/style.min.css\";i:360;s:23:\"pullquote/theme-rtl.css\";i:361;s:27:\"pullquote/theme-rtl.min.css\";i:362;s:19:\"pullquote/theme.css\";i:363;s:23:\"pullquote/theme.min.css\";i:364;s:39:\"query-pagination-numbers/editor-rtl.css\";i:365;s:43:\"query-pagination-numbers/editor-rtl.min.css\";i:366;s:35:\"query-pagination-numbers/editor.css\";i:367;s:39:\"query-pagination-numbers/editor.min.css\";i:368;s:31:\"query-pagination/editor-rtl.css\";i:369;s:35:\"query-pagination/editor-rtl.min.css\";i:370;s:27:\"query-pagination/editor.css\";i:371;s:31:\"query-pagination/editor.min.css\";i:372;s:30:\"query-pagination/style-rtl.css\";i:373;s:34:\"query-pagination/style-rtl.min.css\";i:374;s:26:\"query-pagination/style.css\";i:375;s:30:\"query-pagination/style.min.css\";i:376;s:25:\"query-title/style-rtl.css\";i:377;s:29:\"query-title/style-rtl.min.css\";i:378;s:21:\"query-title/style.css\";i:379;s:25:\"query-title/style.min.css\";i:380;s:25:\"query-total/style-rtl.css\";i:381;s:29:\"query-total/style-rtl.min.css\";i:382;s:21:\"query-total/style.css\";i:383;s:25:\"query-total/style.min.css\";i:384;s:20:\"query/editor-rtl.css\";i:385;s:24:\"query/editor-rtl.min.css\";i:386;s:16:\"query/editor.css\";i:387;s:20:\"query/editor.min.css\";i:388;s:19:\"quote/style-rtl.css\";i:389;s:23:\"quote/style-rtl.min.css\";i:390;s:15:\"quote/style.css\";i:391;s:19:\"quote/style.min.css\";i:392;s:19:\"quote/theme-rtl.css\";i:393;s:23:\"quote/theme-rtl.min.css\";i:394;s:15:\"quote/theme.css\";i:395;s:19:\"quote/theme.min.css\";i:396;s:23:\"read-more/style-rtl.css\";i:397;s:27:\"read-more/style-rtl.min.css\";i:398;s:19:\"read-more/style.css\";i:399;s:23:\"read-more/style.min.css\";i:400;s:18:\"rss/editor-rtl.css\";i:401;s:22:\"rss/editor-rtl.min.css\";i:402;s:14:\"rss/editor.css\";i:403;s:18:\"rss/editor.min.css\";i:404;s:17:\"rss/style-rtl.css\";i:405;s:21:\"rss/style-rtl.min.css\";i:406;s:13:\"rss/style.css\";i:407;s:17:\"rss/style.min.css\";i:408;s:21:\"search/editor-rtl.css\";i:409;s:25:\"search/editor-rtl.min.css\";i:410;s:17:\"search/editor.css\";i:411;s:21:\"search/editor.min.css\";i:412;s:20:\"search/style-rtl.css\";i:413;s:24:\"search/style-rtl.min.css\";i:414;s:16:\"search/style.css\";i:415;s:20:\"search/style.min.css\";i:416;s:20:\"search/theme-rtl.css\";i:417;s:24:\"search/theme-rtl.min.css\";i:418;s:16:\"search/theme.css\";i:419;s:20:\"search/theme.min.css\";i:420;s:24:\"separator/editor-rtl.css\";i:421;s:28:\"separator/editor-rtl.min.css\";i:422;s:20:\"separator/editor.css\";i:423;s:24:\"separator/editor.min.css\";i:424;s:23:\"separator/style-rtl.css\";i:425;s:27:\"separator/style-rtl.min.css\";i:426;s:19:\"separator/style.css\";i:427;s:23:\"separator/style.min.css\";i:428;s:23:\"separator/theme-rtl.css\";i:429;s:27:\"separator/theme-rtl.min.css\";i:430;s:19:\"separator/theme.css\";i:431;s:23:\"separator/theme.min.css\";i:432;s:24:\"shortcode/editor-rtl.css\";i:433;s:28:\"shortcode/editor-rtl.min.css\";i:434;s:20:\"shortcode/editor.css\";i:435;s:24:\"shortcode/editor.min.css\";i:436;s:24:\"site-logo/editor-rtl.css\";i:437;s:28:\"site-logo/editor-rtl.min.css\";i:438;s:20:\"site-logo/editor.css\";i:439;s:24:\"site-logo/editor.min.css\";i:440;s:23:\"site-logo/style-rtl.css\";i:441;s:27:\"site-logo/style-rtl.min.css\";i:442;s:19:\"site-logo/style.css\";i:443;s:23:\"site-logo/style.min.css\";i:444;s:27:\"site-tagline/editor-rtl.css\";i:445;s:31:\"site-tagline/editor-rtl.min.css\";i:446;s:23:\"site-tagline/editor.css\";i:447;s:27:\"site-tagline/editor.min.css\";i:448;s:26:\"site-tagline/style-rtl.css\";i:449;s:30:\"site-tagline/style-rtl.min.css\";i:450;s:22:\"site-tagline/style.css\";i:451;s:26:\"site-tagline/style.min.css\";i:452;s:25:\"site-title/editor-rtl.css\";i:453;s:29:\"site-title/editor-rtl.min.css\";i:454;s:21:\"site-title/editor.css\";i:455;s:25:\"site-title/editor.min.css\";i:456;s:24:\"site-title/style-rtl.css\";i:457;s:28:\"site-title/style-rtl.min.css\";i:458;s:20:\"site-title/style.css\";i:459;s:24:\"site-title/style.min.css\";i:460;s:26:\"social-link/editor-rtl.css\";i:461;s:30:\"social-link/editor-rtl.min.css\";i:462;s:22:\"social-link/editor.css\";i:463;s:26:\"social-link/editor.min.css\";i:464;s:27:\"social-links/editor-rtl.css\";i:465;s:31:\"social-links/editor-rtl.min.css\";i:466;s:23:\"social-links/editor.css\";i:467;s:27:\"social-links/editor.min.css\";i:468;s:26:\"social-links/style-rtl.css\";i:469;s:30:\"social-links/style-rtl.min.css\";i:470;s:22:\"social-links/style.css\";i:471;s:26:\"social-links/style.min.css\";i:472;s:21:\"spacer/editor-rtl.css\";i:473;s:25:\"spacer/editor-rtl.min.css\";i:474;s:17:\"spacer/editor.css\";i:475;s:21:\"spacer/editor.min.css\";i:476;s:20:\"spacer/style-rtl.css\";i:477;s:24:\"spacer/style-rtl.min.css\";i:478;s:16:\"spacer/style.css\";i:479;s:20:\"spacer/style.min.css\";i:480;s:20:\"table/editor-rtl.css\";i:481;s:24:\"table/editor-rtl.min.css\";i:482;s:16:\"table/editor.css\";i:483;s:20:\"table/editor.min.css\";i:484;s:19:\"table/style-rtl.css\";i:485;s:23:\"table/style-rtl.min.css\";i:486;s:15:\"table/style.css\";i:487;s:19:\"table/style.min.css\";i:488;s:19:\"table/theme-rtl.css\";i:489;s:23:\"table/theme-rtl.min.css\";i:490;s:15:\"table/theme.css\";i:491;s:19:\"table/theme.min.css\";i:492;s:24:\"tag-cloud/editor-rtl.css\";i:493;s:28:\"tag-cloud/editor-rtl.min.css\";i:494;s:20:\"tag-cloud/editor.css\";i:495;s:24:\"tag-cloud/editor.min.css\";i:496;s:23:\"tag-cloud/style-rtl.css\";i:497;s:27:\"tag-cloud/style-rtl.min.css\";i:498;s:19:\"tag-cloud/style.css\";i:499;s:23:\"tag-cloud/style.min.css\";i:500;s:28:\"template-part/editor-rtl.css\";i:501;s:32:\"template-part/editor-rtl.min.css\";i:502;s:24:\"template-part/editor.css\";i:503;s:28:\"template-part/editor.min.css\";i:504;s:27:\"template-part/theme-rtl.css\";i:505;s:31:\"template-part/theme-rtl.min.css\";i:506;s:23:\"template-part/theme.css\";i:507;s:27:\"template-part/theme.min.css\";i:508;s:30:\"term-description/style-rtl.css\";i:509;s:34:\"term-description/style-rtl.min.css\";i:510;s:26:\"term-description/style.css\";i:511;s:30:\"term-description/style.min.css\";i:512;s:27:\"text-columns/editor-rtl.css\";i:513;s:31:\"text-columns/editor-rtl.min.css\";i:514;s:23:\"text-columns/editor.css\";i:515;s:27:\"text-columns/editor.min.css\";i:516;s:26:\"text-columns/style-rtl.css\";i:517;s:30:\"text-columns/style-rtl.min.css\";i:518;s:22:\"text-columns/style.css\";i:519;s:26:\"text-columns/style.min.css\";i:520;s:19:\"verse/style-rtl.css\";i:521;s:23:\"verse/style-rtl.min.css\";i:522;s:15:\"verse/style.css\";i:523;s:19:\"verse/style.min.css\";i:524;s:20:\"video/editor-rtl.css\";i:525;s:24:\"video/editor-rtl.min.css\";i:526;s:16:\"video/editor.css\";i:527;s:20:\"video/editor.min.css\";i:528;s:19:\"video/style-rtl.css\";i:529;s:23:\"video/style-rtl.min.css\";i:530;s:15:\"video/style.css\";i:531;s:19:\"video/style.min.css\";i:532;s:19:\"video/theme-rtl.css\";i:533;s:23:\"video/theme-rtl.min.css\";i:534;s:15:\"video/theme.css\";i:535;s:19:\"video/theme.min.css\";}}','on');
INSERT INTO `wp_options` VALUES (125,'recovery_keys','a:0:{}','off');
INSERT INTO `wp_options` VALUES (126,'WPLANG','','auto');
INSERT INTO `wp_options` VALUES (128,'theme_mods_twentytwentyfive','a:2:{s:18:\"custom_css_post_id\";i:-1;s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1749373791;s:4:\"data\";a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";}s:9:\"sidebar-2\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}}}}','off');
INSERT INTO `wp_options` VALUES (129,'_transient_wp_styles_for_blocks','a:2:{s:4:\"hash\";s:32:\"8c7d46a72d7d4591fc1dd9485bedb304\";s:6:\"blocks\";a:5:{s:11:\"core/button\";s:0:\"\";s:14:\"core/site-logo\";s:0:\"\";s:18:\"core/post-template\";s:120:\":where(.wp-block-post-template.is-layout-flex){gap: 1.25em;}:where(.wp-block-post-template.is-layout-grid){gap: 1.25em;}\";s:12:\"core/columns\";s:102:\":where(.wp-block-columns.is-layout-flex){gap: 2em;}:where(.wp-block-columns.is-layout-grid){gap: 2em;}\";s:14:\"core/pullquote\";s:69:\":root :where(.wp-block-pullquote){font-size: 1.5em;line-height: 1.6;}\";}}','on');
INSERT INTO `wp_options` VALUES (130,'_site_transient_update_plugins','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1756735604;s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:0:{}s:7:\"checked\";a:1:{s:59:\"warehouse-inventory-manager/warehouse-inventory-manager.php\";s:5:\"1.0.1\";}}','off');
INSERT INTO `wp_options` VALUES (152,'_site_transient_wp_plugin_dependencies_plugin_data','a:0:{}','off');
INSERT INTO `wp_options` VALUES (153,'recently_activated','a:1:{s:74:\"warehouse-inventory-manager.bak-1756657761/warehouse-inventory-manager.php\";i:1756658765;}','off');
INSERT INTO `wp_options` VALUES (158,'finished_updating_comment_type','1','auto');
INSERT INTO `wp_options` VALUES (161,'wh_inventory_version','1.1.2','auto');
INSERT INTO `wp_options` VALUES (162,'wh_inventory_settings','a:4:{s:8:\"currency\";s:3:\"USD\";s:19:\"low_stock_threshold\";i:5;s:15:\"enable_qr_codes\";b:1;s:23:\"enable_barcode_scanning\";b:0;}','auto');
INSERT INTO `wp_options` VALUES (163,'current_theme','Warehouse Inventory Management','auto');
INSERT INTO `wp_options` VALUES (164,'theme_mods_warehouse-inventory','a:3:{i:0;b:0;s:18:\"nav_menu_locations\";a:0:{}s:18:\"custom_css_post_id\";i:-1;}','on');
INSERT INTO `wp_options` VALUES (165,'theme_switched','','auto');
INSERT INTO `wp_options` VALUES (193,'_transient_health-check-site-status-result','{\"good\":15,\"recommended\":4,\"critical\":1}','on');
INSERT INTO `wp_options` VALUES (462,'_site_transient_timeout_php_check_617fc4d260191bf0de418d0d961f5a43','1757243209','off');
INSERT INTO `wp_options` VALUES (463,'_site_transient_php_check_617fc4d260191bf0de418d0d961f5a43','a:5:{s:19:\"recommended_version\";s:3:\"8.3\";s:15:\"minimum_version\";s:6:\"7.2.24\";s:12:\"is_supported\";b:0;s:9:\"is_secure\";b:1;s:13:\"is_acceptable\";b:1;}','off');
INSERT INTO `wp_options` VALUES (473,'_site_transient_timeout_browser_9bb586dfc3329d2b522978a294f5c138','1757262269','off');
INSERT INTO `wp_options` VALUES (474,'_site_transient_browser_9bb586dfc3329d2b522978a294f5c138','a:10:{s:4:\"name\";s:7:\"Firefox\";s:7:\"version\";s:5:\"142.0\";s:8:\"platform\";s:9:\"Macintosh\";s:10:\"update_url\";s:32:\"https://www.mozilla.org/firefox/\";s:7:\"img_src\";s:44:\"http://s.w.org/images/browsers/firefox.png?1\";s:11:\"img_src_ssl\";s:45:\"https://s.w.org/images/browsers/firefox.png?1\";s:15:\"current_version\";s:2:\"56\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}','off');
INSERT INTO `wp_options` VALUES (489,'_site_transient_update_themes','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1756735604;s:7:\"checked\";a:4:{s:16:\"twentytwentyfive\";s:3:\"1.3\";s:16:\"twentytwentyfour\";s:3:\"1.3\";s:17:\"twentytwentythree\";s:3:\"1.6\";s:19:\"warehouse-inventory\";s:5:\"1.0.1\";}s:8:\"response\";a:0:{}s:9:\"no_update\";a:3:{s:16:\"twentytwentyfive\";a:6:{s:5:\"theme\";s:16:\"twentytwentyfive\";s:11:\"new_version\";s:3:\"1.3\";s:3:\"url\";s:46:\"https://wordpress.org/themes/twentytwentyfive/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/theme/twentytwentyfive.1.3.zip\";s:8:\"requires\";s:3:\"6.7\";s:12:\"requires_php\";s:3:\"7.2\";}s:16:\"twentytwentyfour\";a:6:{s:5:\"theme\";s:16:\"twentytwentyfour\";s:11:\"new_version\";s:3:\"1.3\";s:3:\"url\";s:46:\"https://wordpress.org/themes/twentytwentyfour/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/theme/twentytwentyfour.1.3.zip\";s:8:\"requires\";s:3:\"6.4\";s:12:\"requires_php\";s:3:\"7.0\";}s:17:\"twentytwentythree\";a:6:{s:5:\"theme\";s:17:\"twentytwentythree\";s:11:\"new_version\";s:3:\"1.6\";s:3:\"url\";s:47:\"https://wordpress.org/themes/twentytwentythree/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/theme/twentytwentythree.1.6.zip\";s:8:\"requires\";s:3:\"6.1\";s:12:\"requires_php\";s:3:\"5.6\";}}s:12:\"translations\";a:0:{}}','off');
INSERT INTO `wp_options` VALUES (493,'db_upgraded','','on');
INSERT INTO `wp_options` VALUES (495,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-6.8.2.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-6.8.2.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-6.8.2-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-6.8.2-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:5:\"6.8.2\";s:7:\"version\";s:5:\"6.8.2\";s:11:\"php_version\";s:6:\"7.2.24\";s:13:\"mysql_version\";s:5:\"5.5.5\";s:11:\"new_bundled\";s:3:\"6.7\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1756735602;s:15:\"version_checked\";s:5:\"6.8.2\";s:12:\"translations\";a:0:{}}','off');
INSERT INTO `wp_options` VALUES (496,'can_compress_scripts','0','on');
INSERT INTO `wp_options` VALUES (499,'wh_migration_log','a:42:{i:0;s:56:\"2025-08-31 16:41:19: === Starting Database Migration ===\";i:1;s:110:\"2025-08-31 16:41:19: Backed up table wp_wh_inventory_items to wp_wh_inventory_items_backup_2025_08_31_16_41_19\";i:2;s:100:\"2025-08-31 16:41:19: Backed up table wp_wh_categories to wp_wh_categories_backup_2025_08_31_16_41_19\";i:3;s:98:\"2025-08-31 16:41:19: Backed up table wp_wh_locations to wp_wh_locations_backup_2025_08_31_16_41_19\";i:4;s:90:\"2025-08-31 16:41:19: Backed up table wp_wh_sales to wp_wh_sales_backup_2025_08_31_16_41_19\";i:5;s:90:\"2025-08-31 16:41:19: Backed up table wp_wh_tasks to wp_wh_tasks_backup_2025_08_31_16_41_19\";i:6;s:71:\"2025-08-31 16:41:19: Added column stock_status to wp_wh_inventory_items\";i:7;s:62:\"2025-08-31 16:41:19: Added column sku to wp_wh_inventory_items\";i:8;s:66:\"2025-08-31 16:41:19: Added column barcode to wp_wh_inventory_items\";i:9;s:76:\"2025-08-31 16:41:19: Added column reserved_quantity to wp_wh_inventory_items\";i:10;s:74:\"2025-08-31 16:41:19: Added column max_stock_level to wp_wh_inventory_items\";i:11;s:69:\"2025-08-31 16:41:19: Added column cost_price to wp_wh_inventory_items\";i:12;s:70:\"2025-08-31 16:41:19: Added column supplier_id to wp_wh_inventory_items\";i:13;s:71:\"2025-08-31 16:41:19: Added column supplier_sku to wp_wh_inventory_items\";i:14;s:65:\"2025-08-31 16:41:19: Added column weight to wp_wh_inventory_items\";i:15;s:69:\"2025-08-31 16:41:19: Added column dimensions to wp_wh_inventory_items\";i:16;s:63:\"2025-08-31 16:41:19: Added column unit to wp_wh_inventory_items\";i:17;s:68:\"2025-08-31 16:41:19: Added column image_url to wp_wh_inventory_items\";i:18;s:64:\"2025-08-31 16:41:19: Added column notes to wp_wh_inventory_items\";i:19;s:74:\"2025-08-31 16:41:19: Added column last_counted_at to wp_wh_inventory_items\";i:20;s:69:\"2025-08-31 16:41:19: Added column updated_by to wp_wh_inventory_items\";i:21;s:57:\"2025-08-31 16:41:19: Added column path to wp_wh_locations\";i:22;s:60:\"2025-08-31 16:41:19: Added column address to wp_wh_locations\";i:23;s:67:\"2025-08-31 16:41:19: Added column contact_person to wp_wh_locations\";i:24;s:58:\"2025-08-31 16:41:19: Added column phone to wp_wh_locations\";i:25;s:58:\"2025-08-31 16:41:19: Added column email to wp_wh_locations\";i:26;s:61:\"2025-08-31 16:41:19: Added column capacity to wp_wh_locations\";i:27;s:69:\"2025-08-31 16:41:19: Added column current_capacity to wp_wh_locations\";i:28;s:57:\"2025-08-31 16:41:19: Added column zone to wp_wh_locations\";i:29;s:58:\"2025-08-31 16:41:19: Added column aisle to wp_wh_locations\";i:30;s:57:\"2025-08-31 16:41:19: Added column rack to wp_wh_locations\";i:31;s:58:\"2025-08-31 16:41:19: Added column shelf to wp_wh_locations\";i:32;s:56:\"2025-08-31 16:41:19: Added column bin to wp_wh_locations\";i:33;s:60:\"2025-08-31 16:41:19: Added column barcode to wp_wh_locations\";i:34;s:75:\"2025-08-31 16:41:19: Added column temperature_controlled to wp_wh_locations\";i:35;s:62:\"2025-08-31 16:41:19: Added column is_active to wp_wh_locations\";i:36;s:63:\"2025-08-31 16:41:19: Added column updated_at to wp_wh_locations\";i:37;s:53:\"2025-08-31 16:41:19: Created wh_stock_movements table\";i:38;s:75:\"2025-08-31 16:41:19: Data migration completed - using unified plugin schema\";i:39;s:68:\"2025-08-31 16:41:19: Theme dependencies updated to use plugin tables\";i:40;s:54:\"2025-08-31 16:41:19: Duplicate table cleanup completed\";i:41;s:70:\"2025-08-31 16:41:19: === Database Migration Completed Successfully ===\";}','auto');
INSERT INTO `wp_options` VALUES (500,'wh_inventory_db_version','1.0','auto');
INSERT INTO `wp_options` VALUES (543,'_site_transient_timeout_theme_roots','1756737402','off');
INSERT INTO `wp_options` VALUES (545,'_site_transient_theme_roots','a:4:{s:16:\"twentytwentyfive\";s:7:\"/themes\";s:16:\"twentytwentyfour\";s:7:\"/themes\";s:17:\"twentytwentythree\";s:7:\"/themes\";s:19:\"warehouse-inventory\";s:7:\"/themes\";}','off');
INSERT INTO `wp_options` VALUES (555,'_site_transient_timeout_wp_theme_files_patterns-bebd471143826cc9f1196a0a6d762fa0','1756759738','off');
INSERT INTO `wp_options` VALUES (556,'_site_transient_wp_theme_files_patterns-bebd471143826cc9f1196a0a6d762fa0','a:2:{s:7:\"version\";s:5:\"1.1.2\";s:8:\"patterns\";a:0:{}}','off');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES (1,2,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (2,3,'_wp_page_template','default');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_posts` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES (1,1,'2025-06-08 08:20:05','2025-06-08 08:20:05','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','publish','open','open','','hello-world','','','2025-06-08 08:20:05','2025-06-08 08:20:05','',0,'http://auris.local/?p=1',0,'post','',1);
INSERT INTO `wp_posts` VALUES (2,1,'2025-06-08 08:20:05','2025-06-08 08:20:05','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://auris.local/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','publish','closed','open','','sample-page','','','2025-06-08 08:20:05','2025-06-08 08:20:05','',0,'http://auris.local/?page_id=2',0,'page','',0);
INSERT INTO `wp_posts` VALUES (3,1,'2025-06-08 08:20:05','2025-06-08 08:20:05','<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we are</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Our website address is: http://auris.local.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Comments</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Media</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Cookies</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Embedded content from other websites</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we share your data with</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">How long we retain your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">What rights you have over your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Where your data is sent</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p>\n<!-- /wp:paragraph -->\n','Privacy Policy','','draft','closed','open','','privacy-policy','','','2025-06-08 08:20:05','2025-06-08 08:20:05','',0,'http://auris.local/?page_id=3',0,'page','',0);
INSERT INTO `wp_posts` VALUES (4,0,'2025-06-08 08:20:24','2025-06-08 08:20:24','<!-- wp:page-list /-->','Navigation','','publish','closed','closed','','navigation','','','2025-06-08 08:20:24','2025-06-08 08:20:24','',0,'http://auris.local/navigation/',0,'wp_navigation','',0);
INSERT INTO `wp_posts` VALUES (6,1,'2025-06-08 08:46:57','2025-06-08 08:46:57','{\"version\": 3, \"isGlobalStylesUserThemeJSON\": true }','Custom Styles','','publish','closed','closed','','wp-global-styles-twentytwentyfive','','','2025-06-08 08:46:57','2025-06-08 08:46:57','',0,'http://auris.local/wp-global-styles-twentytwentyfive/',0,'wp_global_styles','',0);
INSERT INTO `wp_posts` VALUES (10,1,'2025-08-31 16:24:29','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2025-08-31 16:24:29','0000-00-00 00:00:00','',0,'http://auris.local/?p=10',0,'post','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
INSERT INTO `wp_term_relationships` VALUES (1,1,0);
INSERT INTO `wp_term_relationships` VALUES (6,2,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint unsigned NOT NULL DEFAULT '0',
  `count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES (1,1,'category','',0,1);
INSERT INTO `wp_term_taxonomy` VALUES (2,2,'wp_theme','',0,1);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES (1,'Uncategorized','uncategorized',0);
INSERT INTO `wp_terms` VALUES (2,'twentytwentyfive','twentytwentyfive',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','auris');
INSERT INTO `wp_usermeta` VALUES (2,1,'first_name','');
INSERT INTO `wp_usermeta` VALUES (3,1,'last_name','');
INSERT INTO `wp_usermeta` VALUES (4,1,'description','');
INSERT INTO `wp_usermeta` VALUES (5,1,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (6,1,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (7,1,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (8,1,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (9,1,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (10,1,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (11,1,'locale','');
INSERT INTO `wp_usermeta` VALUES (12,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (13,1,'wp_user_level','10');
INSERT INTO `wp_usermeta` VALUES (14,1,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (15,1,'show_welcome_panel','1');
INSERT INTO `wp_usermeta` VALUES (17,1,'wp_dashboard_quick_press_last_post_id','10');
INSERT INTO `wp_usermeta` VALUES (18,1,'managenav-menuscolumnshidden','a:5:{i:0;s:11:\"link-target\";i:1;s:11:\"css-classes\";i:2;s:3:\"xfn\";i:3;s:11:\"description\";i:4;s:15:\"title-attribute\";}');
INSERT INTO `wp_usermeta` VALUES (19,1,'metaboxhidden_nav-menus','a:1:{i:0;s:12:\"add-post_tag\";}');
INSERT INTO `wp_usermeta` VALUES (34,3,'nickname','domas');
INSERT INTO `wp_usermeta` VALUES (35,3,'first_name','asdad');
INSERT INTO `wp_usermeta` VALUES (36,3,'last_name','adad');
INSERT INTO `wp_usermeta` VALUES (37,3,'description','');
INSERT INTO `wp_usermeta` VALUES (38,3,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (39,3,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (40,3,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (41,3,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (42,3,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (43,3,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (44,3,'locale','');
INSERT INTO `wp_usermeta` VALUES (45,3,'wp_capabilities','a:1:{s:18:\"warehouse_employee\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (46,3,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (47,3,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (146,11,'nickname','marius');
INSERT INTO `wp_usermeta` VALUES (147,11,'first_name','lkmjkn');
INSERT INTO `wp_usermeta` VALUES (148,11,'last_name','klmkl');
INSERT INTO `wp_usermeta` VALUES (149,11,'description','');
INSERT INTO `wp_usermeta` VALUES (150,11,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (151,11,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (152,11,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (153,11,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (154,11,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (155,11,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (156,11,'locale','');
INSERT INTO `wp_usermeta` VALUES (157,11,'wp_capabilities','a:1:{s:18:\"warehouse_employee\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (158,11,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (159,11,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (161,11,'wp_dashboard_quick_press_last_post_id','7');
INSERT INTO `wp_usermeta` VALUES (166,12,'nickname','zydre');
INSERT INTO `wp_usermeta` VALUES (167,12,'first_name','zydre');
INSERT INTO `wp_usermeta` VALUES (168,12,'last_name','aleksandriene');
INSERT INTO `wp_usermeta` VALUES (169,12,'description','');
INSERT INTO `wp_usermeta` VALUES (170,12,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (171,12,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (172,12,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (173,12,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (174,12,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (175,12,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (176,12,'locale','');
INSERT INTO `wp_usermeta` VALUES (177,12,'wp_capabilities','a:1:{s:18:\"warehouse_employee\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (178,12,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (179,12,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (181,12,'wp_dashboard_quick_press_last_post_id','8');
INSERT INTO `wp_usermeta` VALUES (187,13,'nickname','Vitalka');
INSERT INTO `wp_usermeta` VALUES (188,13,'first_name','Vitalijus');
INSERT INTO `wp_usermeta` VALUES (189,13,'last_name','Aleksandra');
INSERT INTO `wp_usermeta` VALUES (190,13,'description','');
INSERT INTO `wp_usermeta` VALUES (191,13,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (192,13,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (193,13,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (194,13,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (195,13,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (196,13,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (197,13,'locale','');
INSERT INTO `wp_usermeta` VALUES (198,13,'wp_capabilities','a:1:{s:18:\"warehouse_employee\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (199,13,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (200,13,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (201,13,'session_tokens','a:1:{s:64:\"0adff4b41f970a636072cb473ab683867a351003df4df899d17c74a6122b0806\";a:4:{s:10:\"expiration\";i:1750167382;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:84:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:139.0) Gecko/20100101 Firefox/139.0\";s:5:\"login\";i:1749994582;}}');
INSERT INTO `wp_usermeta` VALUES (203,1,'community-events-location','a:1:{s:2:\"ip\";s:9:\"127.0.0.0\";}');
INSERT INTO `wp_usermeta` VALUES (215,1,'session_tokens','a:1:{s:64:\"bb563c1cba2175dc7ef64b1206b8036fc867a12712736d23f85958ee8b4756f7\";a:4:{s:10:\"expiration\";i:1756908415;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:84:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:142.0) Gecko/20100101 Firefox/142.0\";s:5:\"login\";i:1756735615;}}');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_users` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'auris','$wp$2y$10$ruR73Ug/2i6fYuvkrT8nluLgJoa5gwK3hV72Somks20.T78s7KX9.','auris','dev-email@wpengine.local','http://auris.local','2025-06-08 08:20:05','',0,'auris');
INSERT INTO `wp_users` VALUES (3,'domas','$wp$2y$10$I8mH5ngL1M3AGzwPTkbnY.iFVFJ9bz3jSyDwUo5drkdwygw00pKfy','domas','sdasdafd@sdfasd.lk','','2025-06-11 11:09:25','',0,'asdad adad');
INSERT INTO `wp_users` VALUES (11,'marius','$wp$2y$10$mK5yMVw8fuuEPvEiq9frwOaqxlxTYb/A.uMzXoWCiy8cp2AvEAUxi','marius','sadasd@sdasd.lt','','2025-06-11 20:43:55','',0,'lkmjkn klmkl');
INSERT INTO `wp_users` VALUES (12,'zydre','$wp$2y$10$5reLNQwhXPvB0hLAydoWQOdDSpvenI3BNNOwSrtmAB4eUihHzjEMy','zydre','sdasda@sadasd.lt','','2025-06-11 21:29:04','',0,'zydre aleksandriene');
INSERT INTO `wp_users` VALUES (13,'Vitalka','$wp$2y$10$.68reqqxXFZEjqZ9yLJu5unhQoNHWD1Z3mKzq8kcr1Fj.MqisuWk2','vitalka','asdasfd@dfsadas.lt','','2025-06-15 13:35:10','',0,'Vitalijus Aleksandra');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_categories`
--

DROP TABLE IF EXISTS `wp_wh_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_categories` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `color` varchar(7) COLLATE utf8mb4_unicode_520_ci DEFAULT '#3b82f6',
  `item_count` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `slug` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `parent_id` mediumint DEFAULT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'tag',
  `sort_order` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_categories`
--

LOCK TABLES `wp_wh_categories` WRITE;
/*!40000 ALTER TABLE `wp_wh_categories` DISABLE KEYS */;
INSERT INTO `wp_wh_categories` VALUES (1,'Test Category','Test description','#3b82f6',0,'2025-06-08 12:22:14','test-category',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories` VALUES (2,'Electronics','Electronic devices and components','#3b82f6',0,'2025-06-08 12:22:14','electronics',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories` VALUES (3,'Tools','Hand tools and equipment','#10b981',0,'2025-06-08 12:22:14','tools',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories` VALUES (4,'Office Supplies','Office equipment and supplies','#f59e0b',0,'2025-06-08 12:22:14','office-supplies',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories` VALUES (6,'Automotive','Vehicle parts and accessories','#06b6d4',0,'2025-06-08 12:22:14','automotive',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories` VALUES (7,'Hardware','Screws, bolts, and fasteners','#64748b',0,'2025-06-08 12:22:14','hardware',NULL,'tag',0,0,'2025-07-10 20:50:49');
INSERT INTO `wp_wh_categories` VALUES (8,'Cleaning','Cleaning supplies and equipment','#22c55e',0,'2025-06-08 12:22:14','cleaning',NULL,'tag',0,0,'2025-07-10 20:50:41');
INSERT INTO `wp_wh_categories` VALUES (180,'phones','','#3b82f6',0,'2025-07-10 19:45:11','phones',2,'tag',0,1,'2025-07-10 19:45:11');
INSERT INTO `wp_wh_categories` VALUES (181,'fura-1','','#3b82f6',0,'2025-07-10 19:45:37','fura-1',NULL,'tag',0,1,'2025-07-10 19:45:37');
INSERT INTO `wp_wh_categories` VALUES (182,'1-palete','','#3b82f6',0,'2025-07-10 19:45:51','1-palete',181,'tag',0,1,'2025-07-10 19:45:51');
INSERT INTO `wp_wh_categories` VALUES (183,'Electronics','Electronic devices and components','#3b82f6',0,'2025-08-31 17:41:19','electronics',NULL,'laptop',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories` VALUES (184,'Tools','Hand tools and equipment','#10b981',0,'2025-08-31 17:41:19','tools',NULL,'tools',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories` VALUES (185,'Office Supplies','Office equipment and supplies','#f59e0b',0,'2025-08-31 17:41:19','office-supplies',NULL,'briefcase',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories` VALUES (186,'Safety Equipment','Safety gear and protective equipment','#ef4444',0,'2025-08-31 17:41:19','safety-equipment',NULL,'shield-alt',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories` VALUES (187,'Consumables','Consumable items and supplies','#8b5cf6',0,'2025-08-31 17:41:19','consumables',NULL,'shopping-bag',0,1,'2025-08-31 17:41:19');
/*!40000 ALTER TABLE `wp_wh_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_categories_backup_2025_08_31_16_41_19`
--

DROP TABLE IF EXISTS `wp_wh_categories_backup_2025_08_31_16_41_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_categories_backup_2025_08_31_16_41_19` (
  `id` mediumint NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `color` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT '#3b82f6',
  `item_count` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `parent_id` mediumint DEFAULT NULL,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'tag',
  `sort_order` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_categories_backup_2025_08_31_16_41_19`
--

LOCK TABLES `wp_wh_categories_backup_2025_08_31_16_41_19` WRITE;
/*!40000 ALTER TABLE `wp_wh_categories_backup_2025_08_31_16_41_19` DISABLE KEYS */;
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (1,'Test Category','Test description','#3b82f6',0,'2025-06-08 12:22:14','test-category',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (2,'Electronics','Electronic devices and components','#3b82f6',0,'2025-06-08 12:22:14','electronics',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (3,'Tools','Hand tools and equipment','#10b981',0,'2025-06-08 12:22:14','tools',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (4,'Office Supplies','Office equipment and supplies','#f59e0b',0,'2025-06-08 12:22:14','office-supplies',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (6,'Automotive','Vehicle parts and accessories','#06b6d4',0,'2025-06-08 12:22:14','automotive',NULL,'tag',0,1,'2025-07-10 19:43:36');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (7,'Hardware','Screws, bolts, and fasteners','#64748b',0,'2025-06-08 12:22:14','hardware',NULL,'tag',0,0,'2025-07-10 20:50:49');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (8,'Cleaning','Cleaning supplies and equipment','#22c55e',0,'2025-06-08 12:22:14','cleaning',NULL,'tag',0,0,'2025-07-10 20:50:41');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (180,'phones','','#3b82f6',0,'2025-07-10 19:45:11','phones',2,'tag',0,1,'2025-07-10 19:45:11');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (181,'fura-1','','#3b82f6',0,'2025-07-10 19:45:37','fura-1',NULL,'tag',0,1,'2025-07-10 19:45:37');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (182,'1-palete','','#3b82f6',0,'2025-07-10 19:45:51','1-palete',181,'tag',0,1,'2025-07-10 19:45:51');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (183,'Electronics','Electronic devices and components','#3b82f6',0,'2025-08-31 17:41:19','electronics',NULL,'laptop',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (184,'Tools','Hand tools and equipment','#10b981',0,'2025-08-31 17:41:19','tools',NULL,'tools',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (185,'Office Supplies','Office equipment and supplies','#f59e0b',0,'2025-08-31 17:41:19','office-supplies',NULL,'briefcase',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (186,'Safety Equipment','Safety gear and protective equipment','#ef4444',0,'2025-08-31 17:41:19','safety-equipment',NULL,'shield-alt',0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_categories_backup_2025_08_31_16_41_19` VALUES (187,'Consumables','Consumable items and supplies','#8b5cf6',0,'2025-08-31 17:41:19','consumables',NULL,'shopping-bag',0,1,'2025-08-31 17:41:19');
/*!40000 ALTER TABLE `wp_wh_categories_backup_2025_08_31_16_41_19` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_chat_messages`
--

DROP TABLE IF EXISTS `wp_wh_chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_chat_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_chat_messages`
--

LOCK TABLES `wp_wh_chat_messages` WRITE;
/*!40000 ALTER TABLE `wp_wh_chat_messages` DISABLE KEYS */;
INSERT INTO `wp_wh_chat_messages` VALUES (1,1,'labas','2025-07-10 20:57:34');
INSERT INTO `wp_wh_chat_messages` VALUES (2,1,'kas geresnio?','2025-07-10 21:07:57');
INSERT INTO `wp_wh_chat_messages` VALUES (3,1,'labas','2025-07-10 21:15:16');
INSERT INTO `wp_wh_chat_messages` VALUES (4,1,'test','2025-07-10 21:35:50');
INSERT INTO `wp_wh_chat_messages` VALUES (5,1,'testas','2025-07-10 21:37:19');
INSERT INTO `wp_wh_chat_messages` VALUES (6,1,'ir vel testas','2025-07-10 21:37:26');
INSERT INTO `wp_wh_chat_messages` VALUES (7,1,'kas jus tolie?','2025-09-01 20:01:55');
/*!40000 ALTER TABLE `wp_wh_chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_inventory`
--

DROP TABLE IF EXISTS `wp_wh_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_inventory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `category_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_inventory`
--

LOCK TABLES `wp_wh_inventory` WRITE;
/*!40000 ALTER TABLE `wp_wh_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wh_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_inventory_items`
--

DROP TABLE IF EXISTS `wp_wh_inventory_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_inventory_items` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `internal_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `serial_number` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `category_id` mediumint DEFAULT NULL,
  `location_id` mediumint DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `min_stock_level` int DEFAULT '1',
  `purchase_price` decimal(10,2) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `total_lot_price` decimal(10,2) DEFAULT NULL,
  `supplier` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'in-stock',
  `tested` tinyint(1) DEFAULT '0',
  `qr_code_image` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` mediumint DEFAULT NULL,
  `tested_status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'not_tested',
  `stock_status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'in-stock',
  `sku` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `barcode` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `reserved_quantity` int NOT NULL DEFAULT '0',
  `max_stock_level` int DEFAULT NULL,
  `cost_price` decimal(10,2) DEFAULT NULL,
  `supplier_id` mediumint DEFAULT NULL,
  `supplier_sku` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `weight` decimal(8,2) DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `unit` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'pieces',
  `image_url` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_520_ci,
  `last_counted_at` datetime DEFAULT NULL,
  `updated_by` mediumint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `internal_id` (`internal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_inventory_items`
--

LOCK TABLES `wp_wh_inventory_items` WRITE;
/*!40000 ALTER TABLE `wp_wh_inventory_items` DISABLE KEYS */;
INSERT INTO `wp_wh_inventory_items` VALUES (4,'Drill Set DeWalt','Item-1',NULL,'Professional cordless drill set',2,3,18,3,89.99,149.99,2000.00,'','inactive',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%224%22%2C%22internal_id%22%3A%22Item-1%22%2C%22name%22%3A%22Drill+Set+DeWalt%22%2C%22quantity%22%3A%2218%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-07-11 00:05:27',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (5,'Hammer Claw 16oz','Item-2',NULL,'Standard claw hammer',2,3,44,10,12.99,24.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%225%22%2C%22internal_id%22%3A%22Item-2%22%2C%22name%22%3A%22Hammer+Claw+16oz%22%2C%22quantity%22%3A%2244%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (6,'Paper A4 White','Item-3',NULL,'Premium white A4 paper 500 sheets',3,4,125,20,4.99,8.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%226%22%2C%22internal_id%22%3A%22Item-3%22%2C%22name%22%3A%22Paper+A4+White%22%2C%22quantity%22%3A%22125%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (7,'Pen Set Blue','Item-4',NULL,'Blue ballpoint pens pack of 12',3,4,85,15,3.99,7.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%227%22%2C%22internal_id%22%3A%22Item-4%22%2C%22name%22%3A%22Pen+Set+Blue%22%2C%22quantity%22%3A%2285%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (8,'Hard Hat Yellow','Item-5',NULL,'OSHA approved safety helmet',4,1,35,10,18.99,32.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%228%22%2C%22internal_id%22%3A%22Item-5%22%2C%22name%22%3A%22Hard+Hat+Yellow%22%2C%22quantity%22%3A%2235%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (9,'Safety Goggles Clear','Item-6',NULL,'Anti-fog safety goggles',4,1,48,12,12.99,22.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%229%22%2C%22internal_id%22%3A%22Item-6%22%2C%22name%22%3A%22Safety+Goggles+Clear%22%2C%22quantity%22%3A%2248%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (13,'lietnykas','Item-7',NULL,'',6,1,2,1,55.00,65.00,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2213%22%2C%22internal_id%22%3A%22Item-7%22%2C%22name%22%3A%22lietnykas%22%2C%22quantity%22%3A%222%22%2C%22tested%22%3A%220%22%7D','2025-06-12 00:49:28','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (14,'spurgiukas','Item-8',NULL,'',6,2,3,1,5.00,8.00,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2214%22%2C%22internal_id%22%3A%22Item-8%22%2C%22name%22%3A%22spurgiukas%22%2C%22quantity%22%3A%223%22%2C%22tested%22%3A%220%22%7D','2025-06-12 02:37:54','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (16,'iphone X','Item-9',NULL,'',180,NULL,14,1,450.00,540.00,0.00,'','inactive',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2216%22%2C%22internal_id%22%3A%22Item-9%22%2C%22name%22%3A%22iphone+X%22%2C%22quantity%22%3A%2215%22%2C%22tested%22%3A%220%22%7D','2025-06-12 13:11:49','2025-07-10 23:58:07',1,'tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (17,'Iphone 15 Pro Max','item 5',NULL,'',12,1,1,1,800.00,850.00,NULL,NULL,'low-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2217%22%2C%22internal_id%22%3A%22item+5%22%2C%22name%22%3A%22Iphone+15+Pro+Max%22%2C%22quantity%22%3A%221%22%2C%22tested%22%3A%221%22%7D','2025-06-12 16:18:50','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (18,'tablet 8','Item-11',NULL,'',2,4,6,1,150.00,160.00,NULL,NULL,'in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2218%22%2C%22internal_id%22%3A%22Item-11%22%2C%22name%22%3A%22tablet+8%22%2C%22quantity%22%3A%226%22%2C%22tested%22%3A%221%22%7D','2025-06-12 17:30:21','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (19,'tablet 10','item-12',NULL,'',2,4,4,1,210.00,220.00,1050.00,NULL,'in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2219%22%2C%22internal_id%22%3A%22item-12%22%2C%22name%22%3A%22tablet+10%22%2C%22quantity%22%3A%224%22%2C%22tested%22%3A%221%22%7D','2025-06-12 17:47:37','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (20,'tablet 13 pro','item-13',NULL,'',2,129,5,1,345.00,370.00,1725.00,NULL,'in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2220%22%2C%22internal_id%22%3A%22item-13%22%2C%22name%22%3A%22tablet+13+pro%22%2C%22quantity%22%3A%225%22%2C%22tested%22%3A%221%22%7D','2025-06-12 20:28:59','2025-06-15 16:25:32',1,'not_tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (21,'kavos puoduks','item-10',NULL,'',4,128,1,1,10.00,15.00,20.00,'','inactive',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2221%22%2C%22internal_id%22%3A%22item-10%22%2C%22name%22%3A%22kavos+puoduks%22%2C%22quantity%22%3A%222%22%2C%22tested%22%3A%221%22%7D','2025-06-14 07:52:14','2025-07-11 00:01:56',1,'tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_inventory_items` VALUES (22,'amazfit','',NULL,'',NULL,NULL,1,1,45.00,90.00,90.00,'','in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2222%22%2C%22internal_id%22%3A%22%22%2C%22name%22%3A%22amazfit%22%2C%22quantity%22%3A%222%22%2C%22tested%22%3A%221%22%7D','2025-06-15 16:18:49','2025-07-10 21:12:24',1,'tested','in-stock',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'pieces',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `wp_wh_inventory_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_inventory_items_backup_2025_08_31_16_41_19`
--

DROP TABLE IF EXISTS `wp_wh_inventory_items_backup_2025_08_31_16_41_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_inventory_items_backup_2025_08_31_16_41_19` (
  `id` mediumint NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `internal_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `serial_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `category_id` mediumint DEFAULT NULL,
  `location_id` mediumint DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `min_stock_level` int DEFAULT '1',
  `purchase_price` decimal(10,2) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `total_lot_price` decimal(10,2) DEFAULT NULL,
  `supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'in-stock',
  `tested` tinyint(1) DEFAULT '0',
  `qr_code_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` mediumint DEFAULT NULL,
  `tested_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'not_tested'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_inventory_items_backup_2025_08_31_16_41_19`
--

LOCK TABLES `wp_wh_inventory_items_backup_2025_08_31_16_41_19` WRITE;
/*!40000 ALTER TABLE `wp_wh_inventory_items_backup_2025_08_31_16_41_19` DISABLE KEYS */;
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (4,'Drill Set DeWalt','Item-1',NULL,'Professional cordless drill set',2,3,18,3,89.99,149.99,2000.00,'','inactive',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%224%22%2C%22internal_id%22%3A%22Item-1%22%2C%22name%22%3A%22Drill+Set+DeWalt%22%2C%22quantity%22%3A%2218%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-07-11 00:05:27',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (5,'Hammer Claw 16oz','Item-2',NULL,'Standard claw hammer',2,3,44,10,12.99,24.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%225%22%2C%22internal_id%22%3A%22Item-2%22%2C%22name%22%3A%22Hammer+Claw+16oz%22%2C%22quantity%22%3A%2244%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (6,'Paper A4 White','Item-3',NULL,'Premium white A4 paper 500 sheets',3,4,125,20,4.99,8.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%226%22%2C%22internal_id%22%3A%22Item-3%22%2C%22name%22%3A%22Paper+A4+White%22%2C%22quantity%22%3A%22125%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (7,'Pen Set Blue','Item-4',NULL,'Blue ballpoint pens pack of 12',3,4,85,15,3.99,7.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%227%22%2C%22internal_id%22%3A%22Item-4%22%2C%22name%22%3A%22Pen+Set+Blue%22%2C%22quantity%22%3A%2285%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (8,'Hard Hat Yellow','Item-5',NULL,'OSHA approved safety helmet',4,1,35,10,18.99,32.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%228%22%2C%22internal_id%22%3A%22Item-5%22%2C%22name%22%3A%22Hard+Hat+Yellow%22%2C%22quantity%22%3A%2235%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (9,'Safety Goggles Clear','Item-6',NULL,'Anti-fog safety goggles',4,1,48,12,12.99,22.99,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%229%22%2C%22internal_id%22%3A%22Item-6%22%2C%22name%22%3A%22Safety+Goggles+Clear%22%2C%22quantity%22%3A%2248%22%2C%22tested%22%3A%220%22%7D','2025-06-08 12:22:14','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (13,'lietnykas','Item-7',NULL,'',6,1,2,1,55.00,65.00,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2213%22%2C%22internal_id%22%3A%22Item-7%22%2C%22name%22%3A%22lietnykas%22%2C%22quantity%22%3A%222%22%2C%22tested%22%3A%220%22%7D','2025-06-12 00:49:28','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (14,'spurgiukas','Item-8',NULL,'',6,2,3,1,5.00,8.00,NULL,NULL,'in-stock',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2214%22%2C%22internal_id%22%3A%22Item-8%22%2C%22name%22%3A%22spurgiukas%22%2C%22quantity%22%3A%223%22%2C%22tested%22%3A%220%22%7D','2025-06-12 02:37:54','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (16,'iphone X','Item-9',NULL,'',180,NULL,14,1,450.00,540.00,0.00,'','inactive',0,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2216%22%2C%22internal_id%22%3A%22Item-9%22%2C%22name%22%3A%22iphone+X%22%2C%22quantity%22%3A%2215%22%2C%22tested%22%3A%220%22%7D','2025-06-12 13:11:49','2025-07-10 23:58:07',1,'tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (17,'Iphone 15 Pro Max','item 5',NULL,'',12,1,1,1,800.00,850.00,NULL,NULL,'low-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2217%22%2C%22internal_id%22%3A%22item+5%22%2C%22name%22%3A%22Iphone+15+Pro+Max%22%2C%22quantity%22%3A%221%22%2C%22tested%22%3A%221%22%7D','2025-06-12 16:18:50','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (18,'tablet 8','Item-11',NULL,'',2,4,6,1,150.00,160.00,NULL,NULL,'in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2218%22%2C%22internal_id%22%3A%22Item-11%22%2C%22name%22%3A%22tablet+8%22%2C%22quantity%22%3A%226%22%2C%22tested%22%3A%221%22%7D','2025-06-12 17:30:21','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (19,'tablet 10','item-12',NULL,'',2,4,4,1,210.00,220.00,1050.00,NULL,'in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2219%22%2C%22internal_id%22%3A%22item-12%22%2C%22name%22%3A%22tablet+10%22%2C%22quantity%22%3A%224%22%2C%22tested%22%3A%221%22%7D','2025-06-12 17:47:37','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (20,'tablet 13 pro','item-13',NULL,'',2,129,5,1,345.00,370.00,1725.00,NULL,'in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2220%22%2C%22internal_id%22%3A%22item-13%22%2C%22name%22%3A%22tablet+13+pro%22%2C%22quantity%22%3A%225%22%2C%22tested%22%3A%221%22%7D','2025-06-12 20:28:59','2025-06-15 16:25:32',1,'not_tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (21,'kavos puoduks','item-10',NULL,'',4,128,1,1,10.00,15.00,20.00,'','inactive',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2221%22%2C%22internal_id%22%3A%22item-10%22%2C%22name%22%3A%22kavos+puoduks%22%2C%22quantity%22%3A%222%22%2C%22tested%22%3A%221%22%7D','2025-06-14 07:52:14','2025-07-11 00:01:56',1,'tested');
INSERT INTO `wp_wh_inventory_items_backup_2025_08_31_16_41_19` VALUES (22,'amazfit','',NULL,'',NULL,NULL,1,1,45.00,90.00,90.00,'','in-stock',1,'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22item%22%2C%22id%22%3A%2222%22%2C%22internal_id%22%3A%22%22%2C%22name%22%3A%22amazfit%22%2C%22quantity%22%3A%222%22%2C%22tested%22%3A%221%22%7D','2025-06-15 16:18:49','2025-07-10 21:12:24',1,'tested');
/*!40000 ALTER TABLE `wp_wh_inventory_items_backup_2025_08_31_16_41_19` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_locations`
--

DROP TABLE IF EXISTS `wp_wh_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_locations` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'warehouse',
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `qr_code_image` text COLLATE utf8mb4_unicode_520_ci,
  `parent_id` mediumint DEFAULT NULL,
  `level` int DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `path` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_520_ci,
  `contact_person` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `current_capacity` int DEFAULT '0',
  `zone` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `aisle` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `rack` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `shelf` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `bin` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `barcode` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `temperature_controlled` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_locations`
--

LOCK TABLES `wp_wh_locations` WRITE;
/*!40000 ALTER TABLE `wp_wh_locations` DISABLE KEYS */;
INSERT INTO `wp_wh_locations` VALUES (1,'Main Warehouse',NULL,'warehouse','Primary storage facility','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%221%22%2C%22name%22%3A%22Main+Warehouse%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22warehouse%22%7D',NULL,1,'2025-06-08 12:22:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (2,'Section A',NULL,'section','Electronics section','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%222%22%2C%22name%22%3A%22Section+A%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22section%22%7D',1,2,'2025-06-08 12:22:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (3,'Section B',NULL,'section','Tools section','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%223%22%2C%22name%22%3A%22Section+B%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22section%22%7D',1,2,'2025-06-08 12:22:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (4,'Section C',NULL,'section','Office supplies section','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%224%22%2C%22name%22%3A%22Section+C%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22section%22%7D',1,2,'2025-06-08 12:22:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (5,'Aisle A1',NULL,'aisle','First aisle in Section A','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%225%22%2C%22name%22%3A%22Aisle+A1%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22aisle%22%7D',2,3,'2025-06-08 12:22:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (6,'Aisle A2',NULL,'aisle','Second aisle in Section A','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%226%22%2C%22name%22%3A%22Aisle+A2%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22aisle%22%7D',2,3,'2025-06-08 12:22:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (123,'Siauliai','','town','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A123%2C%22name%22%3A%22Siauliai%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22town%22%2C%22path%22%3A%22Siauliai%22%7D',NULL,1,'2025-06-12 17:47:38',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (124,'vilnius','vilnius','town','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A124%2C%22name%22%3A%22vilnius%22%2C%22code%22%3A%22vilnius%22%2C%22location_type%22%3A%22town%22%7D',NULL,1,'2025-06-12 20:23:09',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (125,'Parduotuves sandelys','PAR-684b294c8c6e6','warehouse','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%22125%22%2C%22name%22%3A%22Parduotuves+sandelys%22%2C%22location_type%22%3A%22warehouse%22%7D',124,2,'2025-06-12 20:23:56',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (126,'spintos lentyna 1','SPI-684b299a05581','aisle','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A126%2C%22name%22%3A%22spintos+lentyna+1%22%2C%22code%22%3A%22SPI-684b299a05581%22%2C%22location_type%22%3A%22aisle%22%7D',125,3,'2025-06-12 20:25:14',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (127,'Siauliu sandelys','SIA-684b29c8d0dd1','warehouse','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A127%2C%22name%22%3A%22Siauliu+sandelys%22%2C%22code%22%3A%22SIA-684b29c8d0dd1%22%2C%22location_type%22%3A%22warehouse%22%7D',123,2,'2025-06-12 20:26:00',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (128,'Namu Garazas','NAM-684b29eaef6b7','warehouse','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A128%2C%22name%22%3A%22Namu+Garazas%22%2C%22code%22%3A%22NAM-684b29eaef6b7%22%2C%22location_type%22%3A%22warehouse%22%7D',123,2,'2025-06-12 20:26:34',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (129,'Spinta 1','SPI-684b2a16e6a67','section','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A129%2C%22name%22%3A%22Spinta+1%22%2C%22code%22%3A%22SPI-684b2a16e6a67%22%2C%22location_type%22%3A%22section%22%7D',128,3,'2025-06-12 20:27:18',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (130,'Main Warehouse','WH001','warehouse','Primary storage facility',NULL,NULL,1,'2025-08-31 17:41:19',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (131,'Section A','SEC-A','section','Electronics section',NULL,1,2,'2025-08-31 17:41:19',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (132,'Section B','SEC-B','section','Tools section',NULL,1,2,'2025-08-31 17:41:19',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (133,'Aisle A1','A1','aisle','First aisle in Section A',NULL,2,3,'2025-08-31 17:41:19',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations` VALUES (134,'Aisle A2','A2','aisle','Second aisle in Section A',NULL,2,3,'2025-08-31 17:41:19',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,1,'2025-08-31 17:41:19');
/*!40000 ALTER TABLE `wp_wh_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_locations_backup_2025_08_31_16_41_19`
--

DROP TABLE IF EXISTS `wp_wh_locations_backup_2025_08_31_16_41_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_locations_backup_2025_08_31_16_41_19` (
  `id` mediumint NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'warehouse',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `qr_code_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `parent_id` mediumint DEFAULT NULL,
  `level` int DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_locations_backup_2025_08_31_16_41_19`
--

LOCK TABLES `wp_wh_locations_backup_2025_08_31_16_41_19` WRITE;
/*!40000 ALTER TABLE `wp_wh_locations_backup_2025_08_31_16_41_19` DISABLE KEYS */;
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (1,'Main Warehouse',NULL,'warehouse','Primary storage facility','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%221%22%2C%22name%22%3A%22Main+Warehouse%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22warehouse%22%7D',NULL,1,'2025-06-08 12:22:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (2,'Section A',NULL,'section','Electronics section','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%222%22%2C%22name%22%3A%22Section+A%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22section%22%7D',1,2,'2025-06-08 12:22:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (3,'Section B',NULL,'section','Tools section','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%223%22%2C%22name%22%3A%22Section+B%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22section%22%7D',1,2,'2025-06-08 12:22:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (4,'Section C',NULL,'section','Office supplies section','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%224%22%2C%22name%22%3A%22Section+C%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22section%22%7D',1,2,'2025-06-08 12:22:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (5,'Aisle A1',NULL,'aisle','First aisle in Section A','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%225%22%2C%22name%22%3A%22Aisle+A1%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22aisle%22%7D',2,3,'2025-06-08 12:22:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (6,'Aisle A2',NULL,'aisle','Second aisle in Section A','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%226%22%2C%22name%22%3A%22Aisle+A2%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22aisle%22%7D',2,3,'2025-06-08 12:22:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (123,'Siauliai','','town','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A123%2C%22name%22%3A%22Siauliai%22%2C%22code%22%3A%22%22%2C%22location_type%22%3A%22town%22%2C%22path%22%3A%22Siauliai%22%7D',NULL,1,'2025-06-12 17:47:38');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (124,'vilnius','vilnius','town','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A124%2C%22name%22%3A%22vilnius%22%2C%22code%22%3A%22vilnius%22%2C%22location_type%22%3A%22town%22%7D',NULL,1,'2025-06-12 20:23:09');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (125,'Parduotuves sandelys','PAR-684b294c8c6e6','warehouse','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A%22125%22%2C%22name%22%3A%22Parduotuves+sandelys%22%2C%22location_type%22%3A%22warehouse%22%7D',124,2,'2025-06-12 20:23:56');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (126,'spintos lentyna 1','SPI-684b299a05581','aisle','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A126%2C%22name%22%3A%22spintos+lentyna+1%22%2C%22code%22%3A%22SPI-684b299a05581%22%2C%22location_type%22%3A%22aisle%22%7D',125,3,'2025-06-12 20:25:14');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (127,'Siauliu sandelys','SIA-684b29c8d0dd1','warehouse','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A127%2C%22name%22%3A%22Siauliu+sandelys%22%2C%22code%22%3A%22SIA-684b29c8d0dd1%22%2C%22location_type%22%3A%22warehouse%22%7D',123,2,'2025-06-12 20:26:00');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (128,'Namu Garazas','NAM-684b29eaef6b7','warehouse','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A128%2C%22name%22%3A%22Namu+Garazas%22%2C%22code%22%3A%22NAM-684b29eaef6b7%22%2C%22location_type%22%3A%22warehouse%22%7D',123,2,'2025-06-12 20:26:34');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (129,'Spinta 1','SPI-684b2a16e6a67','section','','https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=%7B%22type%22%3A%22location%22%2C%22id%22%3A129%2C%22name%22%3A%22Spinta+1%22%2C%22code%22%3A%22SPI-684b2a16e6a67%22%2C%22location_type%22%3A%22section%22%7D',128,3,'2025-06-12 20:27:18');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (130,'Main Warehouse','WH001','warehouse','Primary storage facility',NULL,NULL,1,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (131,'Section A','SEC-A','section','Electronics section',NULL,1,2,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (132,'Section B','SEC-B','section','Tools section',NULL,1,2,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (133,'Aisle A1','A1','aisle','First aisle in Section A',NULL,2,3,'2025-08-31 17:41:19');
INSERT INTO `wp_wh_locations_backup_2025_08_31_16_41_19` VALUES (134,'Aisle A2','A2','aisle','Second aisle in Section A',NULL,2,3,'2025-08-31 17:41:19');
/*!40000 ALTER TABLE `wp_wh_locations_backup_2025_08_31_16_41_19` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_profit_tracking`
--

DROP TABLE IF EXISTS `wp_wh_profit_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_profit_tracking` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `date_period` date NOT NULL,
  `period_type` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'daily',
  `total_sales` decimal(10,2) DEFAULT '0.00',
  `total_cost` decimal(10,2) DEFAULT '0.00',
  `total_profit` decimal(10,2) DEFAULT '0.00',
  `profit_margin` decimal(5,2) DEFAULT '0.00',
  `sales_count` int DEFAULT '0',
  `items_sold` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_period` (`date_period`,`period_type`),
  KEY `idx_date` (`date_period`),
  KEY `idx_type` (`period_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_profit_tracking`
--

LOCK TABLES `wp_wh_profit_tracking` WRITE;
/*!40000 ALTER TABLE `wp_wh_profit_tracking` DISABLE KEYS */;
INSERT INTO `wp_wh_profit_tracking` VALUES (9,'2025-06-11','daily',31.00,20.00,11.00,35.48,2,2,'2025-06-12 01:39:06','2025-06-12 01:39:06');
INSERT INTO `wp_wh_profit_tracking` VALUES (10,'2025-06-01','monthly',1268.00,1097.99,170.01,13.41,7,7,'2025-06-12 01:39:06','2025-06-15 16:32:25');
INSERT INTO `wp_wh_profit_tracking` VALUES (11,'2025-06-12','daily',292.00,232.99,59.01,20.21,3,3,'2025-06-12 01:39:06','2025-06-12 17:51:28');
INSERT INTO `wp_wh_profit_tracking` VALUES (12,'2025-06-14','daily',945.00,845.00,100.00,10.58,2,2,'2025-06-14 07:55:11','2025-06-15 16:32:25');
/*!40000 ALTER TABLE `wp_wh_profit_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_sales`
--

DROP TABLE IF EXISTS `wp_wh_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_sales` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `sale_number` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` mediumint NOT NULL,
  `inventory_item_id` mediumint NOT NULL,
  `quantity_sold` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `tax_amount` decimal(10,2) DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_phone` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_address` text COLLATE utf8mb4_unicode_520_ci,
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'completed',
  `delivery_method` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `delivery_status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `delivery_address` text COLLATE utf8mb4_unicode_520_ci,
  `tracking_number` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `warranty_period` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `warranty_expiry_date` datetime DEFAULT NULL,
  `sale_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `sold_by` mediumint DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_520_ci,
  `metadata` text COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_number` (`sale_number`),
  KEY `idx_sale_number` (`sale_number`),
  KEY `idx_item` (`item_id`),
  KEY `idx_payment_status` (`payment_status`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_sales`
--

LOCK TABLES `wp_wh_sales` WRITE;
/*!40000 ALTER TABLE `wp_wh_sales` DISABLE KEYS */;
INSERT INTO `wp_wh_sales` VALUES (1,'SALE-20250611-0623',11,0,1,15.00,0.00,0.00,15.00,'Donatas','','243213123','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:10:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodukas\",\"item_internal_id\":\"item-1\"}');
INSERT INTO `wp_wh_sales` VALUES (2,'SALE-20250611-9781',11,0,1,16.00,0.00,0.00,16.00,'Donatas','','2312312','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:11:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodukas\",\"item_internal_id\":\"item-1\"}');
INSERT INTO `wp_wh_sales` VALUES (3,'SALE-20250611-0060',12,0,1,16.00,0.00,0.00,16.00,'Donatas','','34234234','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:19:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodelis\",\"item_internal_id\":\"item 1\"}');
INSERT INTO `wp_wh_sales` VALUES (4,'SALE-20250611-1262',1,0,1,1299.99,0.00,0.00,1299.99,'Domas','','324234','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:32:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"Laptop Dell Inspiron 15\",\"item_internal_id\":\"WH-LAPTOP001\"}');
INSERT INTO `wp_wh_sales` VALUES (5,'SALE-20250611-3793',12,0,1,15.00,0.00,0.00,15.00,'Domas','','24144124','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 23:35:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodelis\",\"item_internal_id\":\"item 1\"}');
INSERT INTO `wp_wh_sales` VALUES (6,'SALE-20250611-9774',5,0,1,30.00,0.00,0.00,30.00,'domas','','32432','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-12 23:50:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"Hammer Claw 16oz\",\"item_internal_id\":\"WH-HAMMER001\"}');
INSERT INTO `wp_wh_sales` VALUES (7,'SALE-20250612-8941',12,0,1,17.00,0.00,0.00,17.00,'donatas','','564665','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-12 12:06:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodelis\",\"item_internal_id\":\"item 1\"}');
INSERT INTO `wp_wh_sales` VALUES (8,'SALE-20250612-3224',19,0,1,245.00,0.00,0.00,245.00,'Donatas','','231123','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-12 16:50:00',1,'','{\"warranty_period\":\"30_days\",\"warranty_expiry\":\"2025-07-12 16:50:00\",\"item_name\":\"tablet 10\",\"item_internal_id\":\"item-12\"}');
INSERT INTO `wp_wh_sales` VALUES (9,'SALE-20250614-5105',17,0,1,850.00,0.00,0.00,850.00,'Domas','','41241231','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-14 04:54:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"Iphone 15 Pro Max\",\"item_internal_id\":\"item 5\"}');
INSERT INTO `wp_wh_sales` VALUES (10,'SALE-20250615-8220',22,0,1,95.00,0.00,0.00,95.00,'Domas','','342342','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-14 13:29:00',1,'parduota pazystamui','{\"warranty_period\":\"30_days\",\"warranty_expiry\":\"2025-07-14 13:29:00\",\"item_name\":\"amazfit\",\"item_internal_id\":\"\"}');
INSERT INTO `wp_wh_sales` VALUES (11,'SALE-20250710-1613',21,21,1,15.00,0.00,0.00,15.00,'Marius','',NULL,NULL,'cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-10 21:44:23',1,'',NULL);
INSERT INTO `wp_wh_sales` VALUES (12,'SALE-20250710-0736',16,16,1,540.00,0.00,0.00,540.00,'Marius','',NULL,NULL,'cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-10 21:51:45',1,'',NULL);
/*!40000 ALTER TABLE `wp_wh_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_sales_backup_2025_08_31_16_41_19`
--

DROP TABLE IF EXISTS `wp_wh_sales_backup_2025_08_31_16_41_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_sales_backup_2025_08_31_16_41_19` (
  `id` mediumint NOT NULL DEFAULT '0',
  `sale_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` mediumint NOT NULL,
  `inventory_item_id` mediumint NOT NULL,
  `quantity_sold` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `tax_amount` decimal(10,2) DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'completed',
  `delivery_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `delivery_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `delivery_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `warranty_period` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `warranty_expiry_date` datetime DEFAULT NULL,
  `sale_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `sold_by` mediumint DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `metadata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_sales_backup_2025_08_31_16_41_19`
--

LOCK TABLES `wp_wh_sales_backup_2025_08_31_16_41_19` WRITE;
/*!40000 ALTER TABLE `wp_wh_sales_backup_2025_08_31_16_41_19` DISABLE KEYS */;
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (1,'SALE-20250611-0623',11,0,1,15.00,0.00,0.00,15.00,'Donatas','','243213123','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:10:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodukas\",\"item_internal_id\":\"item-1\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (2,'SALE-20250611-9781',11,0,1,16.00,0.00,0.00,16.00,'Donatas','','2312312','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:11:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodukas\",\"item_internal_id\":\"item-1\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (3,'SALE-20250611-0060',12,0,1,16.00,0.00,0.00,16.00,'Donatas','','34234234','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:19:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodelis\",\"item_internal_id\":\"item 1\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (4,'SALE-20250611-1262',1,0,1,1299.99,0.00,0.00,1299.99,'Domas','','324234','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 22:32:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"Laptop Dell Inspiron 15\",\"item_internal_id\":\"WH-LAPTOP001\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (5,'SALE-20250611-3793',12,0,1,15.00,0.00,0.00,15.00,'Domas','','24144124','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 23:35:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodelis\",\"item_internal_id\":\"item 1\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (6,'SALE-20250611-9774',5,0,1,30.00,0.00,0.00,30.00,'domas','','32432','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-12 23:50:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"Hammer Claw 16oz\",\"item_internal_id\":\"WH-HAMMER001\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (7,'SALE-20250612-8941',12,0,1,17.00,0.00,0.00,17.00,'donatas','','564665','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-12 12:06:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"kavos puodelis\",\"item_internal_id\":\"item 1\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (8,'SALE-20250612-3224',19,0,1,245.00,0.00,0.00,245.00,'Donatas','','231123','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-12 16:50:00',1,'','{\"warranty_period\":\"30_days\",\"warranty_expiry\":\"2025-07-12 16:50:00\",\"item_name\":\"tablet 10\",\"item_internal_id\":\"item-12\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (9,'SALE-20250614-5105',17,0,1,850.00,0.00,0.00,850.00,'Domas','','41241231','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-14 04:54:00',1,'','{\"warranty_period\":\"\",\"warranty_expiry\":null,\"item_name\":\"Iphone 15 Pro Max\",\"item_internal_id\":\"item 5\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (10,'SALE-20250615-8220',22,0,1,95.00,0.00,0.00,95.00,'Domas','','342342','','cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-14 13:29:00',1,'parduota pazystamui','{\"warranty_period\":\"30_days\",\"warranty_expiry\":\"2025-07-14 13:29:00\",\"item_name\":\"amazfit\",\"item_internal_id\":\"\"}');
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (11,'SALE-20250710-1613',21,21,1,15.00,0.00,0.00,15.00,'Marius','',NULL,NULL,'cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-10 21:44:23',1,'',NULL);
INSERT INTO `wp_wh_sales_backup_2025_08_31_16_41_19` VALUES (12,'SALE-20250710-0736',16,16,1,540.00,0.00,0.00,540.00,'Marius','',NULL,NULL,'cash','completed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-10 21:51:45',1,'',NULL);
/*!40000 ALTER TABLE `wp_wh_sales_backup_2025_08_31_16_41_19` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_stock_movements`
--

DROP TABLE IF EXISTS `wp_wh_stock_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_stock_movements` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `item_id` mediumint NOT NULL,
  `movement_type` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `quantity_before` int NOT NULL,
  `quantity_changed` int NOT NULL,
  `quantity_after` int NOT NULL,
  `unit_cost` decimal(10,2) DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `reference_id` mediumint DEFAULT NULL,
  `location_from` mediumint DEFAULT NULL,
  `location_to` mediumint DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_520_ci,
  `performed_by` mediumint DEFAULT NULL,
  `performed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `batch_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_item` (`item_id`),
  KEY `idx_type` (`movement_type`),
  KEY `idx_date` (`performed_at`),
  KEY `idx_batch` (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_stock_movements`
--

LOCK TABLES `wp_wh_stock_movements` WRITE;
/*!40000 ALTER TABLE `wp_wh_stock_movements` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wh_stock_movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_suppliers`
--

DROP TABLE IF EXISTS `wp_wh_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_suppliers` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_520_ci,
  `contact_person` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `tax_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_terms` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT 'USD',
  `website` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_520_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_active` (`is_active`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_suppliers`
--

LOCK TABLES `wp_wh_suppliers` WRITE;
/*!40000 ALTER TABLE `wp_wh_suppliers` DISABLE KEYS */;
INSERT INTO `wp_wh_suppliers` VALUES (1,'TechCorp Solutions','TechCorp','orders@techcorp.com','+1-555-0101','123 Tech Street, Silicon Valley, CA','John Smith','TC001',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (2,'Industrial Tools Inc','Industrial Tools','sales@indtools.com','+1-555-0102','456 Industry Ave, Detroit, MI','Sarah Johnson','IT002',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (3,'Office Depot Pro','Office Depot','wholesale@officedepot.com','+1-555-0103','789 Business Blvd, New York, NY','Mike Wilson','OD003',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (4,'Safety First Co','Safety First','info@safetyfirst.com','+1-555-0104','321 Safety Lane, Houston, TX','Lisa Davis','SF004',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (5,'AutoParts Direct','AutoParts','orders@autoparts.com','+1-555-0105','654 Motor Way, Chicago, IL','Tom Anderson','AP005',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (6,'TechCorp Solutions','TechCorp','orders@techcorp.com','+1-555-0101','123 Tech Street, Silicon Valley, CA','John Smith','TC001',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (7,'Industrial Tools Inc','Industrial Tools','sales@indtools.com','+1-555-0102','456 Industry Ave, Detroit, MI','Sarah Johnson','IT002',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
INSERT INTO `wp_wh_suppliers` VALUES (8,'Office Depot Pro','Office Depot','wholesale@officedepot.com','+1-555-0103','789 Business Blvd, New York, NY','Mike Wilson','OD003',NULL,'USD',NULL,NULL,1,'2025-06-08 12:22:14','2025-06-08 12:22:14');
/*!40000 ALTER TABLE `wp_wh_suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_task_history`
--

DROP TABLE IF EXISTS `wp_wh_task_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_task_history` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `original_task_id` mediumint NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `priority` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `assigned_to` mediumint DEFAULT NULL,
  `created_by` mediumint DEFAULT NULL,
  `completed_by` mediumint DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `completed_at` datetime NOT NULL,
  `time_taken` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `completion_notes` text COLLATE utf8mb4_unicode_520_ci,
  `task_id` mediumint NOT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'completed',
  `old_value` text COLLATE utf8mb4_unicode_520_ci,
  `new_value` text COLLATE utf8mb4_unicode_520_ci,
  `user_id` mediumint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_original_task` (`original_task_id`),
  KEY `idx_completed_at` (`completed_at`),
  KEY `idx_assigned` (`assigned_to`),
  KEY `idx_completed_by` (`completed_by`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_task_history`
--

LOCK TABLES `wp_wh_task_history` WRITE;
/*!40000 ALTER TABLE `wp_wh_task_history` DISABLE KEYS */;
INSERT INTO `wp_wh_task_history` VALUES (1,1,'Weekly Inventory Audit','Completed comprehensive audit of all warehouse sections','medium',1,1,1,NULL,'2025-06-01 10:22:14','2025-06-03 10:22:14',NULL,NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (2,2,'Update Supplier Contracts','Renewed contracts with top 3 suppliers','high',1,1,1,NULL,'2025-05-29 10:22:14','2025-05-31 10:22:14',NULL,NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (3,3,'Install New Shelving','Added additional shelving units in Section B','low',1,1,1,NULL,'2025-05-25 10:22:14','2025-05-27 10:22:14',NULL,NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (4,4,'Train New Employee','Onboarding and training for new warehouse associate','medium',1,1,1,NULL,'2025-06-02 10:22:14','2025-06-04 10:22:14',NULL,NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (5,2,'Restock Safety Equipment','Reorder hard hats and safety goggles - running low','urgent',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:01:46','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (6,12,'Restock Safety Equipment','Reorder hard hats and safety goggles - running low','urgent',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:02:17','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (7,5,'Monthly Sales Report','Generate and analyze monthly sales performance report','high',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:02:27','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (8,7,'Equipment Maintenance','Schedule maintenance for warehouse forklifts','high',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:02:41','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (9,15,'Monthly Sales Report','Generate and analyze monthly sales performance report','high',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:02:52','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (10,6,'Supplier Meeting Prep','Prepare materials for quarterly supplier review meeting','medium',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:13:05','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (11,10,'Quality Control Check','Random quality inspection of received shipments','medium',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:13:17','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (12,9,'System Backup','Perform weekly backup of warehouse management system','low',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:13:23','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (13,14,'Organize Tool Section','Reorganize tools section for better accessibility','low',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:13:30','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (14,11,'Inventory Count - Electronics','Perform quarterly inventory count for all electronics in Section A','high',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:13:43','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (15,1,'Inventory Count - Electronics','Perform quarterly inventory count for all electronics in Section A','high',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:15:08','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (16,8,'Staff Training Session','Conduct safety training for new warehouse staff','medium',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:16:11','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (17,3,'Update Product Labels','Print and apply new QR code labels for automotive section','medium',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:19:43','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (18,4,'Organize Tool Section','Reorganize tools section for better accessibility','low',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:19:49','1 hour',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (19,13,'Update Product Labels','Print and apply new QR code labels for automotive section','medium',1,1,1,NULL,'2025-06-08 12:22:14','2025-06-08 11:23:47','58 minutes',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (20,18,'pavalgyti','','urgent',1,1,1,NULL,'2025-06-08 13:33:17','2025-06-08 11:33:46','2 hours',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (21,17,'reikia nauju batu','','high',1,1,1,NULL,'2025-06-08 13:32:56','2025-06-08 11:37:05','2 hours',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (22,20,'eik pasivaikscioti','','medium',1,1,1,NULL,'2025-06-08 13:46:21','2025-06-10 21:00:53','2 days',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (23,21,'hgjhg','','urgent',1,1,1,NULL,'2025-06-08 13:46:48','2025-06-11 01:03:22','2 days',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (24,19,'nupirk duonos','','medium',1,1,1,NULL,'2025-06-08 13:45:55','2025-06-11 01:03:24','2 days',NULL,0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (25,46,'neveikia inventorius','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 19:52:04','2025-07-10 20:35:39',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (26,47,'nupirk pieno','','medium',1,1,1,'0000-00-00 00:00:00','2025-07-10 20:37:47','2025-07-10 20:38:11',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (27,48,'nupirk grietines','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 20:38:35','2025-07-10 20:38:42',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (28,49,'nupirk cukraus','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 20:42:11','2025-07-10 20:42:30',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (29,50,'nueik i parduotuve','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 20:48:48','2025-07-10 20:48:57',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (30,52,'nupirk sampano','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 21:01:19','2025-07-10 21:02:29',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (31,51,'nupirk alaus','','low',1,1,1,'2025-07-10 00:00:00','2025-07-10 20:56:18','2025-07-10 21:33:22',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (32,53,'test','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 21:33:50','2025-07-10 21:34:08',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (33,54,'test 2','','medium',1,1,1,'2025-07-10 00:00:00','2025-07-10 21:36:56','2025-07-10 21:37:10',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
INSERT INTO `wp_wh_task_history` VALUES (34,55,'nupirti pieno','','medium',1,1,1,'2025-09-01 00:00:00','2025-09-01 19:55:53','2025-09-01 19:56:16',NULL,'Task archived from completed status',0,'completed',NULL,NULL,1);
/*!40000 ALTER TABLE `wp_wh_task_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_tasks`
--

DROP TABLE IF EXISTS `wp_wh_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_tasks` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'pending',
  `priority` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'medium',
  `assigned_to` mediumint DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` mediumint DEFAULT NULL,
  `estimated_hours` decimal(5,2) DEFAULT NULL,
  `actual_hours` decimal(5,2) DEFAULT NULL,
  `tags` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `dependencies` text COLLATE utf8mb4_unicode_520_ci,
  `completion_notes` text COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_tasks`
--

LOCK TABLES `wp_wh_tasks` WRITE;
/*!40000 ALTER TABLE `wp_wh_tasks` DISABLE KEYS */;
INSERT INTO `wp_wh_tasks` VALUES (22,'isgerti kavos su zmonike','','archived','urgent',1,'2025-06-11 00:00:00','2025-06-11 12:42:12','2025-06-11 03:04:16','2025-06-11 14:42:15',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (23,'Inventory Audit - Warehouse A','Complete physical count of all items in Warehouse A section 1-5','archived','high',1,'2025-06-14 13:47:26','2025-06-11 12:41:50','2025-06-11 13:47:26','2025-06-11 14:41:53',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (24,'Update Product Labels','Print and replace outdated product labels in electronics section','archived','medium',1,'2025-06-18 13:47:26','2025-06-11 12:42:18','2025-06-11 13:47:26','2025-06-11 14:42:21',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (25,'Equipment Maintenance','Schedule and perform routine maintenance on forklifts','archived','low',1,'2025-06-25 13:47:26','2025-06-11 12:42:25','2025-06-11 13:47:26','2025-06-11 14:42:28',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (26,'Inventory Audit - Warehouse A','Complete physical count of all items in Warehouse A section 1-5','archived','high',1,'2025-06-14 14:05:43','2025-06-11 12:52:05','2025-06-11 14:05:43','2025-06-11 14:52:08',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (27,'Update Product Labels','Print and replace outdated product labels in electronics section','archived','medium',1,'2025-06-18 14:05:43','2025-06-11 12:51:49','2025-06-11 14:05:43','2025-06-11 14:51:52',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (28,'Equipment Maintenance','Schedule and perform routine maintenance on forklifts','archived','low',1,'2025-06-25 14:05:43','2025-06-11 12:53:43','2025-06-11 14:05:43','2025-06-11 14:53:47',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (29,'nupirkti pieno','sdsa','archived','medium',3,'2025-06-11 00:00:00','2025-06-11 21:26:20','2025-06-11 22:09:55','2025-06-11 22:26:23',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (30,'nupirkti duonos','','archived','urgent',1,'2025-06-11 00:00:00','2025-06-11 21:11:23','2025-06-11 22:10:29','2025-06-11 22:11:26',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (31,'eik i darba','','archived','low',3,'2025-06-11 00:00:00','2025-06-11 21:11:30','2025-06-11 22:11:14','2025-06-11 22:11:33',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (32,'nupirkti','erwe','archived','medium',1,'2025-06-11 00:00:00','2025-06-11 21:13:13','2025-06-11 22:12:54','2025-06-11 22:13:16',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (33,'asdad','asda','archived','medium',1,'2025-06-11 00:00:00','2025-06-11 21:28:30','2025-06-11 22:27:25','2025-06-11 22:28:33',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (34,'asdasas','asdas','archived','medium',12,'2025-06-11 00:00:00','2025-06-11 21:30:37','2025-06-11 22:30:07','2025-06-11 22:30:40',12,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (36,'nupirk duonos','','archived','medium',1,'2025-06-12 00:00:00','2025-06-11 23:21:27','2025-06-12 00:21:17','2025-06-12 00:21:30',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (37,'nupirk spurga','','archived','medium',1,'2025-06-12 00:00:00','2025-06-12 00:25:59','2025-06-12 00:47:56','2025-06-12 01:26:02',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (38,'nupirk spurgu','dsada','archived','medium',1,'2025-06-12 00:00:00','2025-06-12 01:26:11','2025-06-12 02:03:40','2025-06-12 02:26:14',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (39,'dssad','','archived','medium',1,'2025-06-12 00:00:00','2025-06-12 11:59:50','2025-06-12 02:53:48','2025-06-12 12:59:53',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (40,'pavizdys','','archived','medium',1,'2025-06-12 00:00:00','2025-07-10 11:00:16','2025-06-12 12:59:30','2025-07-10 11:00:16',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (41,'nupirk pieno','','archived','urgent',12,'2025-06-12 00:00:00','2025-06-12 12:09:24','2025-06-12 13:09:08','2025-06-12 13:09:27',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (42,'isgerti kavos su zmonike','','archived','urgent',1,'2025-06-14 00:00:00','2025-06-14 05:38:45','2025-06-14 08:38:30','2025-06-14 08:38:48',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (43,'isgek kavbos su tadu','','archived','urgent',1,'2025-06-14 00:00:00','2025-06-14 12:05:55','2025-06-14 15:05:10','2025-06-14 15:05:58',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (44,'pakurti sandeli','','archived','medium',12,NULL,'2025-06-15 13:24:31','2025-06-15 16:24:12','2025-06-15 16:24:34',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (45,'duona','nupirk duonos','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 18:42:03','2025-07-10 11:03:28','2025-07-10 18:42:03',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (46,'neveikia inventorius','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:35:39','2025-07-10 19:52:04','2025-07-10 20:35:39',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (47,'nupirk pieno','','archived','medium',1,'0000-00-00 00:00:00','2025-07-10 20:38:11','2025-07-10 20:37:47','2025-07-10 20:38:11',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (48,'nupirk grietines','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:38:42','2025-07-10 20:38:35','2025-07-10 20:38:42',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (49,'nupirk cukraus','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:42:30','2025-07-10 20:42:11','2025-07-10 20:42:30',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (50,'nueik i parduotuve','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:48:57','2025-07-10 20:48:48','2025-07-10 20:48:57',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (51,'nupirk alaus','','archived','low',1,'2025-07-10 00:00:00','2025-07-10 21:33:22','2025-07-10 20:56:18','2025-07-10 21:33:22',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (52,'nupirk sampano','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 21:02:29','2025-07-10 21:01:19','2025-07-10 21:02:29',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (53,'test','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 21:34:08','2025-07-10 21:33:50','2025-07-10 21:34:08',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (54,'test 2','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 21:37:10','2025-07-10 21:36:56','2025-07-10 21:37:10',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (55,'nupirti pieno','','archived','medium',1,'2025-09-01 00:00:00','2025-09-01 19:56:16','2025-09-01 19:55:53','2025-09-01 19:56:16',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks` VALUES (56,'ka nors sugalvoti','','pending','medium',1,'2025-09-02 00:00:00',NULL,'2025-09-01 20:28:56','2025-09-01 21:28:56',1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `wp_wh_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_tasks_backup_2025_08_31_16_41_19`
--

DROP TABLE IF EXISTS `wp_wh_tasks_backup_2025_08_31_16_41_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_tasks_backup_2025_08_31_16_41_19` (
  `id` mediumint NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'pending',
  `priority` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'medium',
  `assigned_to` mediumint DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` mediumint DEFAULT NULL,
  `estimated_hours` decimal(5,2) DEFAULT NULL,
  `actual_hours` decimal(5,2) DEFAULT NULL,
  `tags` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `dependencies` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `completion_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_tasks_backup_2025_08_31_16_41_19`
--

LOCK TABLES `wp_wh_tasks_backup_2025_08_31_16_41_19` WRITE;
/*!40000 ALTER TABLE `wp_wh_tasks_backup_2025_08_31_16_41_19` DISABLE KEYS */;
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (22,'isgerti kavos su zmonike','','archived','urgent',1,'2025-06-11 00:00:00','2025-06-11 12:42:12','2025-06-11 03:04:16','2025-06-11 14:42:15',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (23,'Inventory Audit - Warehouse A','Complete physical count of all items in Warehouse A section 1-5','archived','high',1,'2025-06-14 13:47:26','2025-06-11 12:41:50','2025-06-11 13:47:26','2025-06-11 14:41:53',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (24,'Update Product Labels','Print and replace outdated product labels in electronics section','archived','medium',1,'2025-06-18 13:47:26','2025-06-11 12:42:18','2025-06-11 13:47:26','2025-06-11 14:42:21',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (25,'Equipment Maintenance','Schedule and perform routine maintenance on forklifts','archived','low',1,'2025-06-25 13:47:26','2025-06-11 12:42:25','2025-06-11 13:47:26','2025-06-11 14:42:28',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (26,'Inventory Audit - Warehouse A','Complete physical count of all items in Warehouse A section 1-5','archived','high',1,'2025-06-14 14:05:43','2025-06-11 12:52:05','2025-06-11 14:05:43','2025-06-11 14:52:08',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (27,'Update Product Labels','Print and replace outdated product labels in electronics section','archived','medium',1,'2025-06-18 14:05:43','2025-06-11 12:51:49','2025-06-11 14:05:43','2025-06-11 14:51:52',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (28,'Equipment Maintenance','Schedule and perform routine maintenance on forklifts','archived','low',1,'2025-06-25 14:05:43','2025-06-11 12:53:43','2025-06-11 14:05:43','2025-06-11 14:53:47',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (29,'nupirkti pieno','sdsa','archived','medium',3,'2025-06-11 00:00:00','2025-06-11 21:26:20','2025-06-11 22:09:55','2025-06-11 22:26:23',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (30,'nupirkti duonos','','archived','urgent',1,'2025-06-11 00:00:00','2025-06-11 21:11:23','2025-06-11 22:10:29','2025-06-11 22:11:26',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (31,'eik i darba','','archived','low',3,'2025-06-11 00:00:00','2025-06-11 21:11:30','2025-06-11 22:11:14','2025-06-11 22:11:33',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (32,'nupirkti','erwe','archived','medium',1,'2025-06-11 00:00:00','2025-06-11 21:13:13','2025-06-11 22:12:54','2025-06-11 22:13:16',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (33,'asdad','asda','archived','medium',1,'2025-06-11 00:00:00','2025-06-11 21:28:30','2025-06-11 22:27:25','2025-06-11 22:28:33',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (34,'asdasas','asdas','archived','medium',12,'2025-06-11 00:00:00','2025-06-11 21:30:37','2025-06-11 22:30:07','2025-06-11 22:30:40',12,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (36,'nupirk duonos','','archived','medium',1,'2025-06-12 00:00:00','2025-06-11 23:21:27','2025-06-12 00:21:17','2025-06-12 00:21:30',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (37,'nupirk spurga','','archived','medium',1,'2025-06-12 00:00:00','2025-06-12 00:25:59','2025-06-12 00:47:56','2025-06-12 01:26:02',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (38,'nupirk spurgu','dsada','archived','medium',1,'2025-06-12 00:00:00','2025-06-12 01:26:11','2025-06-12 02:03:40','2025-06-12 02:26:14',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (39,'dssad','','archived','medium',1,'2025-06-12 00:00:00','2025-06-12 11:59:50','2025-06-12 02:53:48','2025-06-12 12:59:53',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (40,'pavizdys','','archived','medium',1,'2025-06-12 00:00:00','2025-07-10 11:00:16','2025-06-12 12:59:30','2025-07-10 11:00:16',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (41,'nupirk pieno','','archived','urgent',12,'2025-06-12 00:00:00','2025-06-12 12:09:24','2025-06-12 13:09:08','2025-06-12 13:09:27',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (42,'isgerti kavos su zmonike','','archived','urgent',1,'2025-06-14 00:00:00','2025-06-14 05:38:45','2025-06-14 08:38:30','2025-06-14 08:38:48',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (43,'isgek kavbos su tadu','','archived','urgent',1,'2025-06-14 00:00:00','2025-06-14 12:05:55','2025-06-14 15:05:10','2025-06-14 15:05:58',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (44,'pakurti sandeli','','archived','medium',12,NULL,'2025-06-15 13:24:31','2025-06-15 16:24:12','2025-06-15 16:24:34',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (45,'duona','nupirk duonos','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 18:42:03','2025-07-10 11:03:28','2025-07-10 18:42:03',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (46,'neveikia inventorius','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:35:39','2025-07-10 19:52:04','2025-07-10 20:35:39',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (47,'nupirk pieno','','archived','medium',1,'0000-00-00 00:00:00','2025-07-10 20:38:11','2025-07-10 20:37:47','2025-07-10 20:38:11',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (48,'nupirk grietines','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:38:42','2025-07-10 20:38:35','2025-07-10 20:38:42',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (49,'nupirk cukraus','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:42:30','2025-07-10 20:42:11','2025-07-10 20:42:30',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (50,'nueik i parduotuve','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 20:48:57','2025-07-10 20:48:48','2025-07-10 20:48:57',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (51,'nupirk alaus','','archived','low',1,'2025-07-10 00:00:00','2025-07-10 21:33:22','2025-07-10 20:56:18','2025-07-10 21:33:22',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (52,'nupirk sampano','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 21:02:29','2025-07-10 21:01:19','2025-07-10 21:02:29',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (53,'test','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 21:34:08','2025-07-10 21:33:50','2025-07-10 21:34:08',1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `wp_wh_tasks_backup_2025_08_31_16_41_19` VALUES (54,'test 2','','archived','medium',1,'2025-07-10 00:00:00','2025-07-10 21:37:10','2025-07-10 21:36:56','2025-07-10 21:37:10',1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `wp_wh_tasks_backup_2025_08_31_16_41_19` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wh_team_members`
--

DROP TABLE IF EXISTS `wp_wh_team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wh_team_members` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `user_id` mediumint DEFAULT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'warehouse_employee',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'active',
  `phone` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `position` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `permissions` text COLLATE utf8mb4_unicode_520_ci,
  `notes` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` mediumint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_username` (`username`),
  KEY `idx_email` (`email`),
  KEY `idx_role` (`role`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wh_team_members`
--

LOCK TABLES `wp_wh_team_members` WRITE;
/*!40000 ALTER TABLE `wp_wh_team_members` DISABLE KEYS */;
INSERT INTO `wp_wh_team_members` VALUES (1,1,'auris','dev-email@wpengine.local','Admin','User','administrator','active',NULL,NULL,NULL,NULL,'2025-09-01 14:06:55',NULL,NULL,'2025-06-11 03:45:40','2025-09-01 15:06:55',1);
INSERT INTO `wp_wh_team_members` VALUES (4,3,'domas','sdasdafd@sdfasd.lk','','','subscriber','inactive',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-11 13:09:25','2025-06-11 13:56:52',1);
INSERT INTO `wp_wh_team_members` VALUES (20,11,'marius','sadasd@sdasd.lt','','','subscriber','active',NULL,NULL,NULL,NULL,'2025-06-11 20:46:23',NULL,NULL,'2025-06-11 21:43:55','2025-06-11 21:46:23',1);
INSERT INTO `wp_wh_team_members` VALUES (22,12,'zydre','sdasda@sadasd.lt','','','subscriber','active',NULL,NULL,NULL,NULL,'2025-06-11 21:31:49',NULL,NULL,'2025-06-11 22:29:04','2025-06-11 22:31:49',1);
INSERT INTO `wp_wh_team_members` VALUES (24,13,'Vitalka','asdasfd@dfsadas.lt','','','subscriber','active',NULL,NULL,NULL,NULL,'2025-06-15 13:36:22',NULL,NULL,'2025-06-15 16:35:10','2025-06-15 16:36:22',1);
/*!40000 ALTER TABLE `wp_wh_team_members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-01 21:31:02
