-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: db    Database: whatsapp_scheduler
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Contato',7,'add_contact'),(26,'Can change Contato',7,'change_contact'),(27,'Can delete Contato',7,'delete_contact'),(28,'Can view Contato',7,'view_contact'),(29,'Can add Configuração Evolution',8,'add_evolutionconfig'),(30,'Can change Configuração Evolution',8,'change_evolutionconfig'),(31,'Can delete Configuração Evolution',8,'delete_evolutionconfig'),(32,'Can view Configuração Evolution',8,'view_evolutionconfig'),(33,'Can add Grupo',9,'add_group'),(34,'Can change Grupo',9,'change_group'),(35,'Can delete Grupo',9,'delete_group'),(36,'Can view Grupo',9,'view_group'),(37,'Can add Template de Mensagem',10,'add_messagetemplate'),(38,'Can change Template de Mensagem',10,'change_messagetemplate'),(39,'Can delete Template de Mensagem',10,'delete_messagetemplate'),(40,'Can view Template de Mensagem',10,'view_messagetemplate'),(41,'Can add Mensagem Agendada',11,'add_scheduledmessage'),(42,'Can change Mensagem Agendada',11,'change_scheduledmessage'),(43,'Can delete Mensagem Agendada',11,'delete_scheduledmessage'),(44,'Can view Mensagem Agendada',11,'view_scheduledmessage'),(45,'Can add Log de Mensagem',12,'add_messagelog'),(46,'Can change Log de Mensagem',12,'change_messagelog'),(47,'Can delete Log de Mensagem',12,'delete_messagelog'),(48,'Can view Log de Mensagem',12,'view_messagelog'),(49,'Can add crontab',13,'add_crontabschedule'),(50,'Can change crontab',13,'change_crontabschedule'),(51,'Can delete crontab',13,'delete_crontabschedule'),(52,'Can view crontab',13,'view_crontabschedule'),(53,'Can add interval',14,'add_intervalschedule'),(54,'Can change interval',14,'change_intervalschedule'),(55,'Can delete interval',14,'delete_intervalschedule'),(56,'Can view interval',14,'view_intervalschedule'),(57,'Can add periodic task',15,'add_periodictask'),(58,'Can change periodic task',15,'change_periodictask'),(59,'Can delete periodic task',15,'delete_periodictask'),(60,'Can view periodic task',15,'view_periodictask'),(61,'Can add periodic task track',16,'add_periodictasks'),(62,'Can change periodic task track',16,'change_periodictasks'),(63,'Can delete periodic task track',16,'delete_periodictasks'),(64,'Can view periodic task track',16,'view_periodictasks'),(65,'Can add solar event',17,'add_solarschedule'),(66,'Can change solar event',17,'change_solarschedule'),(67,'Can delete solar event',17,'delete_solarschedule'),(68,'Can view solar event',17,'view_solarschedule'),(69,'Can add clocked',18,'add_clockedschedule'),(70,'Can change clocked',18,'change_clockedschedule'),(71,'Can delete clocked',18,'delete_clockedschedule'),(72,'Can view clocked',18,'view_clockedschedule');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_clockedschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_clockedschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_celery_beat_clockedschedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clocked_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_clockedschedule`
--

LOCK TABLES `django_celery_beat_clockedschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_clockedschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_clockedschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_crontabschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_crontabschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_celery_beat_crontabschedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `minute` varchar(240) NOT NULL,
  `hour` varchar(96) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(124) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  `timezone` varchar(63) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_crontabschedule`
--

LOCK TABLES `django_celery_beat_crontabschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_crontabschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_crontabschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_intervalschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_intervalschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_celery_beat_intervalschedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `every` int NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_intervalschedule`
--

LOCK TABLES `django_celery_beat_intervalschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_intervalschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_intervalschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_periodictask`
--

DROP TABLE IF EXISTS `django_celery_beat_periodictask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_celery_beat_periodictask` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int DEFAULT NULL,
  `interval_id` int DEFAULT NULL,
  `solar_id` int DEFAULT NULL,
  `one_off` tinyint(1) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `priority` int unsigned DEFAULT NULL,
  `headers` longtext NOT NULL DEFAULT (_utf8mb3'{}'),
  `clocked_id` int DEFAULT NULL,
  `expire_seconds` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` (`crontab_id`),
  KEY `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` (`interval_id`),
  KEY `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` (`solar_id`),
  KEY `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` (`clocked_id`),
  CONSTRAINT `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` FOREIGN KEY (`clocked_id`) REFERENCES `django_celery_beat_clockedschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`),
  CONSTRAINT `django_celery_beat_periodictask_chk_1` CHECK ((`total_run_count` >= 0)),
  CONSTRAINT `django_celery_beat_periodictask_chk_2` CHECK ((`priority` >= 0)),
  CONSTRAINT `django_celery_beat_periodictask_chk_3` CHECK ((`expire_seconds` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_periodictask`
--

LOCK TABLES `django_celery_beat_periodictask` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_periodictask` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_periodictask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_periodictasks`
--

DROP TABLE IF EXISTS `django_celery_beat_periodictasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_periodictasks`
--

LOCK TABLES `django_celery_beat_periodictasks` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_periodictasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_periodictasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_beat_solarschedule`
--

DROP TABLE IF EXISTS `django_celery_beat_solarschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_celery_beat_solarschedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event` varchar(24) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq` (`event`,`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_beat_solarschedule`
--

LOCK TABLES `django_celery_beat_solarschedule` WRITE;
/*!40000 ALTER TABLE `django_celery_beat_solarschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_beat_solarschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(18,'django_celery_beat','clockedschedule'),(13,'django_celery_beat','crontabschedule'),(14,'django_celery_beat','intervalschedule'),(15,'django_celery_beat','periodictask'),(16,'django_celery_beat','periodictasks'),(17,'django_celery_beat','solarschedule'),(7,'scheduler','contact'),(8,'scheduler','evolutionconfig'),(9,'scheduler','group'),(12,'scheduler','messagelog'),(10,'scheduler','messagetemplate'),(11,'scheduler','scheduledmessage'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-07-01 03:11:59.350028'),(2,'auth','0001_initial','2025-07-01 03:12:00.612457'),(3,'admin','0001_initial','2025-07-01 03:12:00.893606'),(4,'admin','0002_logentry_remove_auto_add','2025-07-01 03:12:00.908689'),(5,'admin','0003_logentry_add_action_flag_choices','2025-07-01 03:12:00.922911'),(6,'contenttypes','0002_remove_content_type_name','2025-07-01 03:12:01.175627'),(7,'auth','0002_alter_permission_name_max_length','2025-07-01 03:12:01.431071'),(8,'auth','0003_alter_user_email_max_length','2025-07-01 03:12:01.467430'),(9,'auth','0004_alter_user_username_opts','2025-07-01 03:12:01.480969'),(10,'auth','0005_alter_user_last_login_null','2025-07-01 03:12:01.571789'),(11,'auth','0006_require_contenttypes_0002','2025-07-01 03:12:01.582000'),(12,'auth','0007_alter_validators_add_error_messages','2025-07-01 03:12:01.597624'),(13,'auth','0008_alter_user_username_max_length','2025-07-01 03:12:01.698963'),(14,'auth','0009_alter_user_last_name_max_length','2025-07-01 03:12:01.813711'),(15,'auth','0010_alter_group_name_max_length','2025-07-01 03:12:01.885200'),(16,'auth','0011_update_proxy_permissions','2025-07-01 03:12:01.914018'),(17,'auth','0012_alter_user_first_name_max_length','2025-07-01 03:12:02.033806'),(18,'django_celery_beat','0001_initial','2025-07-01 03:12:02.533743'),(19,'django_celery_beat','0002_auto_20161118_0346','2025-07-01 03:12:02.694230'),(20,'django_celery_beat','0003_auto_20161209_0049','2025-07-01 03:12:02.728070'),(21,'django_celery_beat','0004_auto_20170221_0000','2025-07-01 03:12:02.734785'),(22,'django_celery_beat','0005_add_solarschedule_events_choices','2025-07-01 03:12:02.741322'),(23,'django_celery_beat','0006_auto_20180322_0932','2025-07-01 03:12:02.898291'),(24,'django_celery_beat','0007_auto_20180521_0826','2025-07-01 03:12:03.205487'),(25,'django_celery_beat','0008_auto_20180914_1922','2025-07-01 03:12:03.296300'),(26,'django_celery_beat','0006_auto_20180210_1226','2025-07-01 03:12:03.330488'),(27,'django_celery_beat','0006_periodictask_priority','2025-07-01 03:12:03.451675'),(28,'django_celery_beat','0009_periodictask_headers','2025-07-01 03:12:03.573031'),(29,'django_celery_beat','0010_auto_20190429_0326','2025-07-01 03:12:04.052820'),(30,'django_celery_beat','0011_auto_20190508_0153','2025-07-01 03:12:04.342988'),(31,'django_celery_beat','0012_periodictask_expire_seconds','2025-07-01 03:12:04.474225'),(32,'django_celery_beat','0013_auto_20200609_0727','2025-07-01 03:12:04.488782'),(33,'django_celery_beat','0014_remove_clockedschedule_enabled','2025-07-01 03:12:04.542436'),(34,'django_celery_beat','0015_edit_solarschedule_events_choices','2025-07-01 03:12:04.549900'),(35,'django_celery_beat','0016_alter_crontabschedule_timezone','2025-07-01 03:12:04.565068'),(36,'django_celery_beat','0017_alter_crontabschedule_month_of_year','2025-07-01 03:12:04.578599'),(37,'django_celery_beat','0018_improve_crontab_helptext','2025-07-01 03:12:04.591402'),(38,'django_celery_beat','0019_alter_periodictasks_options','2025-07-01 03:12:04.599063'),(39,'scheduler','0001_initial','2025-07-01 03:12:05.251978'),(40,'sessions','0001_initial','2025-07-01 03:12:05.320620');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_contact`
--

DROP TABLE IF EXISTS `scheduler_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_contact` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_contact`
--

LOCK TABLES `scheduler_contact` WRITE;
/*!40000 ALTER TABLE `scheduler_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_evolutionconfig`
--

DROP TABLE IF EXISTS `scheduler_evolutionconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_evolutionconfig` (
  `id` char(32) NOT NULL,
  `instance_name` varchar(100) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `base_url` varchar(200) NOT NULL,
  `webhook_url` varchar(200) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_connected` tinyint(1) NOT NULL,
  `last_check` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_evolutionconfig`
--

LOCK TABLES `scheduler_evolutionconfig` WRITE;
/*!40000 ALTER TABLE `scheduler_evolutionconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_evolutionconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_group`
--

DROP TABLE IF EXISTS `scheduler_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_group` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `group_id` varchar(100) NOT NULL,
  `description` longtext,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_group`
--

LOCK TABLES `scheduler_group` WRITE;
/*!40000 ALTER TABLE `scheduler_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_messagelog`
--

DROP TABLE IF EXISTS `scheduler_messagelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_messagelog` (
  `id` char(32) NOT NULL,
  `recipient` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL,
  `sent_at` datetime(6) NOT NULL,
  `delivered_at` datetime(6) DEFAULT NULL,
  `error_message` longtext,
  `evolution_message_id` varchar(100) DEFAULT NULL,
  `scheduled_message_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduler_messagelog_scheduled_message_id_07611c8d_fk_scheduler` (`scheduled_message_id`),
  CONSTRAINT `scheduler_messagelog_scheduled_message_id_07611c8d_fk_scheduler` FOREIGN KEY (`scheduled_message_id`) REFERENCES `scheduler_scheduledmessage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_messagelog`
--

LOCK TABLES `scheduler_messagelog` WRITE;
/*!40000 ALTER TABLE `scheduler_messagelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_messagelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_messagetemplate`
--

DROP TABLE IF EXISTS `scheduler_messagetemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_messagetemplate` (
  `id` char(32) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` longtext NOT NULL,
  `media_type` varchar(10) NOT NULL,
  `media_file` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_messagetemplate`
--

LOCK TABLES `scheduler_messagetemplate` WRITE;
/*!40000 ALTER TABLE `scheduler_messagetemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_messagetemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_scheduledmessage`
--

DROP TABLE IF EXISTS `scheduler_scheduledmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_scheduledmessage` (
  `id` char(32) NOT NULL,
  `title` varchar(100) NOT NULL,
  `recipient_type` varchar(10) NOT NULL,
  `frequency` varchar(10) NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `day_of_week` int DEFAULT NULL,
  `day_of_month` int DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `last_sent` datetime(6) DEFAULT NULL,
  `next_execution` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `contact_id` char(32) DEFAULT NULL,
  `group_id` char(32) DEFAULT NULL,
  `message_template_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduler_scheduledm_contact_id_36688634_fk_scheduler` (`contact_id`),
  KEY `scheduler_scheduledm_group_id_8012f9c7_fk_scheduler` (`group_id`),
  KEY `scheduler_scheduledm_message_template_id_4b4c316f_fk_scheduler` (`message_template_id`),
  CONSTRAINT `scheduler_scheduledm_contact_id_36688634_fk_scheduler` FOREIGN KEY (`contact_id`) REFERENCES `scheduler_contact` (`id`),
  CONSTRAINT `scheduler_scheduledm_group_id_8012f9c7_fk_scheduler` FOREIGN KEY (`group_id`) REFERENCES `scheduler_group` (`id`),
  CONSTRAINT `scheduler_scheduledm_message_template_id_4b4c316f_fk_scheduler` FOREIGN KEY (`message_template_id`) REFERENCES `scheduler_messagetemplate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_scheduledmessage`
--

LOCK TABLES `scheduler_scheduledmessage` WRITE;
/*!40000 ALTER TABLE `scheduler_scheduledmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_scheduledmessage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01  3:13:12
