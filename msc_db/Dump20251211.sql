CREATE DATABASE  IF NOT EXISTS `systema_upravleniya_kontentom` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `systema_upravleniya_kontentom`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: systema_upravleniya_kontentom
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `name` varchar(45) NOT NULL,
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_UNIQUE` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'technology','Технологии',NULL),(2,'programming','Программирование',1),(3,'design','Дизайн',NULL),(4,'web-development','Веб-разработка',2),(5,'mobile-apps','Мобильные приложения',1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `excerpt` varchar(255) NOT NULL,
  `content_body` varchar(255) NOT NULL,
  `status` enum('Черновик','Опубликован','В архиве') NOT NULL,
  `published_at` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  `categories_id` int NOT NULL,
  PRIMARY KEY (`id`,`user_id`,`categories_id`),
  UNIQUE KEY `slug_UNIQUE` (`slug`),
  KEY `fk_content_user1_idx` (`user_id`),
  KEY `fk_content_categories1_idx` (`categories_id`),
  CONSTRAINT `fk_content_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_content_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,'Введение в MySQL','introduction-to-mysql','Основы работы с MySQL для начинающих','Изучим основные команды и синтаксис MySQL...','Опубликован','2025-11-15 10:30:00',1,4),(2,'Дизайн интерфейсов','ui-design-basics','Основные принципы дизайна пользовательских интерфейсов','Рассмотрим принципы юзабилити и визуального дизайна...','Черновик',NULL,2,3),(3,'Разработка мобильных приложений','mobile-app-development','Современные подходы к созданию мобильных приложений','Обзор фреймворков и технологий для мобильной разработки...','Опубликован','2025-12-01 14:45:00',5,5);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privelege`
--

DROP TABLE IF EXISTS `privelege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privelege` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privelege`
--

LOCK TABLES `privelege` WRITE;
/*!40000 ALTER TABLE `privelege` DISABLE KEYS */;
INSERT INTO `privelege` VALUES (1,'create_post','Позволяет создавать новые посты и статьи'),(2,'edit_post','Позволяет редактировать существующие посты и статьи'),(3,'delete_post','Позволяет удалять посты и статьи'),(4,'manage_users','Позволяет управлять пользователями: добавлять, редактировать, блокировать'),(5,'view_reports','Позволяет просматривать аналитические отчеты и статистику'),(6,'view_post','Позволяет просматривать пост');
/*!40000 ALTER TABLE `privelege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL,
  `system_role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'author'),(2,'editor'),(3,'admin'),(4,'viewer');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_has_privelege`
--

DROP TABLE IF EXISTS `roles_has_privelege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_has_privelege` (
  `roles_id` int NOT NULL,
  `privelege_id` int NOT NULL,
  PRIMARY KEY (`roles_id`,`privelege_id`),
  KEY `fk_roles_has_privelege_privelege1_idx` (`privelege_id`),
  KEY `fk_roles_has_privelege_roles_idx` (`roles_id`),
  CONSTRAINT `fk_roles_has_privelege_privelege1` FOREIGN KEY (`privelege_id`) REFERENCES `privelege` (`id`),
  CONSTRAINT `fk_roles_has_privelege_roles` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_has_privelege`
--

LOCK TABLES `roles_has_privelege` WRITE;
/*!40000 ALTER TABLE `roles_has_privelege` DISABLE KEYS */;
INSERT INTO `roles_has_privelege` VALUES (1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(3,4),(3,5),(1,6),(2,6),(3,6),(4,6);
/*!40000 ALTER TABLE `roles_has_privelege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `content_id` int NOT NULL,
  PRIMARY KEY (`id`,`content_id`),
  KEY `fk_tags_content1_idx` (`content_id`),
  CONSTRAINT `fk_tags_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'базы данных',1),(2,'mysql',1),(3,'sql',1),(4,'дизайн',2),(5,'ui',2),(6,'ux',2),(7,'мобильные приложения',3),(8,'разработка',3),(9,'программирование',3),(10,'android',3);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'john_doe','abc@gmail.com','+1234567890',NULL,1),(2,'jane_smith','jane@example.com','+0987654321',NULL,1),(3,'bob_wilson','bob@example.com','+1122334455','2023-10-15 14:30:00',0),(4,'alice_brown','alice@example.com','+2233445566','2024-01-20 09:15:00',0),(5,'charlie_davis','charlie@example.com','+3344556677','2025-11-28 16:45:00',1),(6,'emma_jones','emma@example.com','+4455667788','2025-12-05 11:20:00',1),(7,'dima_seleznev','emma@example.com','+4455667788','2025-12-05 11:20:00',1),(8,'danil_lyamin','emma@example.com','+4455667788','2025-12-05 11:20:00',1),(9,'denis_potolokov','emma@example.com','+4455667788','2025-12-05 11:20:00',1),(10,'Nikita_Popov','nikitomba@example.com','+4455667788','2025-12-18 17:30:00',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_roles`
--

DROP TABLE IF EXISTS `user_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_roles` (
  `user_id` int NOT NULL,
  `roles_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`roles_id`),
  KEY `fk_user_has_roles_roles1_idx` (`roles_id`),
  KEY `fk_user_has_roles_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_roles_roles1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `fk_user_has_roles_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_roles`
--

LOCK TABLES `user_has_roles` WRITE;
/*!40000 ALTER TABLE `user_has_roles` DISABLE KEYS */;
INSERT INTO `user_has_roles` VALUES (1,1),(3,1),(4,1),(8,1),(9,1),(2,2),(4,2),(6,2),(9,2),(5,3),(1,4),(6,4),(7,4),(8,4),(9,4);
/*!40000 ALTER TABLE `user_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'systema_upravleniya_kontentom'
--

--
-- Dumping routines for database 'systema_upravleniya_kontentom'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-11  9:33:35
