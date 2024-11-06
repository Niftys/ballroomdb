-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ballroomdb
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
-- Table structure for table `comp`
--

DROP TABLE IF EXISTS `comp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comp`
--

LOCK TABLES `comp` WRITE;
/*!40000 ALTER TABLE `comp` DISABLE KEYS */;
INSERT INTO `comp` VALUES (1,'Austin Open 2024'),(2,'Dances With Owls 2024'),(3,'Cougar Classic 2024');
/*!40000 ALTER TABLE `comp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `fifth_place`
--

DROP TABLE IF EXISTS `fifth_place`;
/*!50001 DROP VIEW IF EXISTS `fifth_place`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fifth_place` AS SELECT 
 1 AS `Score`,
 1 AS `Dancers`,
 1 AS `Judge`,
 1 AS `Style`,
 1 AS `Competition`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `first_place`
--

DROP TABLE IF EXISTS `first_place`;
/*!50001 DROP VIEW IF EXISTS `first_place`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `first_place` AS SELECT 
 1 AS `Score`,
 1 AS `Dancers`,
 1 AS `Judge`,
 1 AS `Style`,
 1 AS `Competition`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `fourth_place`
--

DROP TABLE IF EXISTS `fourth_place`;
/*!50001 DROP VIEW IF EXISTS `fourth_place`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fourth_place` AS SELECT 
 1 AS `Score`,
 1 AS `Dancers`,
 1 AS `Judge`,
 1 AS `Style`,
 1 AS `Competition`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `judges`
--

DROP TABLE IF EXISTS `judges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `judges`
--

LOCK TABLES `judges` WRITE;
/*!40000 ALTER TABLE `judges` DISABLE KEYS */;
INSERT INTO `judges` VALUES (1,'Phillip Stephens'),(2,'Curtis Prevost'),(3,'Pamelyn Shefman'),(4,'Ryan Lewis'),(5,'Pamela Romano'),(6,'Mark Moy'),(7,'Ryan Ford'),(8,'Viktoria Soto'),(9,'Damon D\'Amico');
/*!40000 ALTER TABLE `judges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Millen Loa & Vennila Natarajan'),(2,'Joshua Maxwell & Emily Martinez'),(3,'Ryan Boyce & Malini Prasad'),(4,'Seth Lowery & Jennifer Le'),(5,'Eythan Karp & Naila Hajiyeva'),(6,'Joshua Hillis & Sophia Bombach'),(7,'Rodrigo Brandao & Eve Nguyen'),(8,'Daniel Maxenberger & Sandy Baadsgaard'),(9,'Anthony Karam & Subarna Mandal'),(10,'Trevor Hastings & Audrey Rupley'),(11,'Pascual Ortiz & Hannah Seymour'),(12,'Dylan Powell & Anne Hulme'),(13,'Grant MacDonald & Delaney Gaston'),(14,'Parker Holland & Kira Murillo'),(15,'Jaryd Domine & Anne Hulme'),(16,'Kireeti Singam Setty & Jacqueline McCoy'),(17,'Millen Loa & Delaney Gaston'),(18,'Cady Johnson & Julian Herrera'),(19,'Trevor Hastings & Nicole Deichl'),(20,'Bryce Shurts & Vennila Natarajan'),(21,'Grace Dreifuerst & Malini Prasad'),(22,'Alfredo Espinoza & Angelina Covey'),(23,'Bohdan Potochnyak & Mariam Galstyan'),(24,'Steven Callahan & Eve Nguyen'),(25,'Clayton Helms & Paulina Volkova'),(26,'Tyler Dinh & Khanh Thi Nguyen'),(27,'Seth Lowery & Amanda Jones'),(28,'Ryan Boyce & Gina Gates'),(29,'Sophia Cha & Nicole Imming'),(30,'Clayton Ramsey & Pearl Zhang'),(31,'Damien Young & Ebony Tatmon'),(32,'Bryan Bowling & Lindsey Szabo'),(33,'Julian Herrera & Cady Johnson');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scores` (
  `score_id` int NOT NULL AUTO_INCREMENT,
  `judge_id` int DEFAULT NULL,
  `people_id` int DEFAULT NULL,
  `style_id` int DEFAULT NULL,
  `score` int NOT NULL,
  `comp_id` int DEFAULT NULL,
  PRIMARY KEY (`score_id`),
  KEY `judge_id` (`judge_id`),
  KEY `people_id` (`people_id`),
  KEY `style_id` (`style_id`),
  KEY `comp_id` (`comp_id`),
  CONSTRAINT `comp_id` FOREIGN KEY (`comp_id`) REFERENCES `comp` (`id`),
  CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`judge_id`) REFERENCES `judges` (`id`),
  CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`people_id`) REFERENCES `people` (`id`),
  CONSTRAINT `scores_ibfk_3` FOREIGN KEY (`style_id`) REFERENCES `style` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=672 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
INSERT INTO `scores` VALUES (1,1,1,1,1,1),(2,1,2,1,2,1),(3,1,3,1,3,1),(4,1,4,1,5,1),(5,1,5,1,4,1),(6,1,6,1,6,1),(7,2,1,1,1,1),(8,2,2,1,2,1),(9,2,3,1,3,1),(10,2,4,1,4,1),(11,2,5,1,5,1),(12,2,6,1,6,1),(13,3,1,1,1,1),(14,3,2,1,2,1),(15,3,3,1,3,1),(16,3,4,1,5,1),(17,3,5,1,4,1),(18,3,6,1,6,1),(19,4,1,1,1,1),(20,4,2,1,2,1),(21,4,3,1,5,1),(22,4,4,1,3,1),(23,4,5,1,4,1),(24,4,6,1,6,1),(25,5,1,1,1,1),(26,5,2,1,3,1),(27,5,3,1,4,1),(28,5,4,1,2,1),(29,5,5,1,5,1),(30,5,6,1,6,1),(31,1,1,2,1,1),(32,1,2,2,2,1),(33,1,3,2,3,1),(34,1,4,2,7,1),(35,1,7,2,4,1),(36,1,5,2,5,1),(37,1,8,2,6,1),(38,1,9,2,8,1),(39,1,10,2,9,1),(40,2,1,2,1,1),(41,2,2,2,2,1),(42,2,3,2,3,1),(43,2,4,2,7,1),(44,2,7,2,4,1),(45,2,5,2,5,1),(46,2,8,2,9,1),(47,2,9,2,7,1),(48,2,10,2,8,1),(49,3,1,2,1,1),(50,3,2,2,3,1),(51,3,3,2,2,1),(52,3,4,2,6,1),(53,3,7,2,5,1),(54,3,5,2,7,1),(55,3,8,2,4,1),(56,3,9,2,9,1),(57,3,10,2,8,1),(58,4,1,2,1,1),(59,4,2,2,2,1),(60,4,3,2,3,1),(61,4,4,2,4,1),(62,4,7,2,7,1),(63,4,5,2,6,1),(64,4,8,2,5,1),(65,4,9,2,8,1),(66,4,10,2,9,1),(67,5,1,2,2,1),(68,5,2,2,3,1),(69,5,3,2,6,1),(70,5,4,2,1,1),(71,5,7,2,5,1),(72,5,5,2,4,1),(73,5,8,2,8,1),(74,5,9,2,7,1),(75,5,10,2,9,1),(76,1,1,3,1,1),(77,1,2,3,2,1),(78,1,11,3,4,1),(79,1,4,3,5,1),(80,1,5,3,3,1),(81,1,6,3,6,1),(82,1,12,3,7,1),(83,2,1,3,1,1),(84,2,2,3,2,1),(85,2,11,3,3,1),(86,2,4,3,4,1),(87,2,5,3,6,1),(88,2,6,3,5,1),(89,2,12,3,7,1),(90,3,1,3,1,1),(91,3,2,3,3,1),(92,3,11,3,4,1),(93,3,4,3,5,1),(94,3,5,3,2,1),(95,3,6,3,6,1),(96,3,12,3,7,1),(97,4,1,3,1,1),(98,4,2,3,2,1),(99,4,11,3,3,1),(100,4,4,3,4,1),(101,4,5,3,6,1),(102,4,6,3,7,1),(103,4,12,3,5,1),(104,5,1,3,1,1),(105,5,2,3,3,1),(106,5,11,3,4,1),(107,5,4,3,2,1),(108,5,5,3,5,1),(109,5,6,3,7,1),(110,5,12,3,6,1),(111,1,1,4,1,1),(112,1,2,4,3,1),(113,1,3,4,2,1),(114,1,4,4,5,1),(115,1,11,4,4,1),(116,1,5,4,6,1),(117,1,7,4,7,1),(118,1,12,4,8,1),(119,2,1,4,2,1),(120,2,2,4,5,1),(121,2,3,4,3,1),(122,2,4,4,1,1),(123,2,11,4,4,1),(124,2,5,4,6,1),(125,2,7,4,7,1),(126,2,12,4,8,1),(127,3,1,4,1,1),(128,3,2,4,2,1),(129,3,3,4,3,1),(130,3,4,4,4,1),(131,3,11,4,5,1),(132,3,5,4,8,1),(133,3,7,4,7,1),(134,3,12,4,6,1),(135,4,1,4,1,1),(136,4,2,4,2,1),(137,4,3,4,3,1),(138,4,4,4,5,1),(139,4,11,4,8,1),(140,4,5,4,7,1),(141,4,7,4,6,1),(142,4,12,4,4,1),(143,5,1,4,2,1),(144,5,2,4,3,1),(145,5,3,4,4,1),(146,5,4,4,1,1),(147,5,11,4,6,1),(148,5,5,4,5,1),(149,5,7,4,7,1),(150,5,12,4,8,1),(151,1,1,5,1,1),(152,1,2,5,3,1),(153,1,3,5,2,1),(154,1,4,5,6,1),(155,1,5,5,4,1),(156,1,13,5,7,1),(157,1,7,5,5,1),(158,2,1,5,1,1),(159,2,2,5,2,1),(160,2,3,5,3,1),(161,2,4,5,4,1),(162,2,5,5,6,1),(163,2,13,5,7,1),(164,2,7,5,5,1),(165,3,1,5,1,1),(166,3,2,5,3,1),(167,3,3,5,2,1),(168,3,4,5,6,1),(169,3,5,5,5,1),(170,3,13,5,4,1),(171,3,7,5,7,1),(172,4,1,5,1,1),(173,4,2,5,2,1),(174,4,3,5,4,1),(175,4,4,5,3,1),(176,4,5,5,6,1),(177,4,13,5,5,1),(178,4,7,5,7,1),(179,5,1,5,3,1),(180,5,2,5,2,1),(181,5,3,5,4,1),(182,5,4,5,1,1),(183,5,5,5,5,1),(184,5,13,5,6,1),(185,5,7,5,7,1),(186,2,14,19,1,1),(187,2,2,19,2,1),(188,2,15,19,8,1),(189,2,4,19,5,1),(190,2,16,19,6,1),(191,2,17,19,4,1),(192,2,5,19,3,1),(193,2,7,19,7,1),(194,4,14,19,2,1),(195,4,2,19,3,1),(196,4,15,19,4,1),(197,4,4,19,6,1),(198,4,16,19,5,1),(199,4,17,19,1,1),(200,4,5,19,7,1),(201,4,7,19,8,1),(202,6,14,19,1,1),(203,6,2,19,3,1),(204,6,15,19,4,1),(205,6,4,19,5,1),(206,6,16,19,2,1),(207,6,17,19,7,1),(208,6,5,19,6,1),(209,6,7,19,8,1),(210,5,14,19,1,1),(211,5,2,19,4,1),(212,5,15,19,2,1),(213,5,4,19,3,1),(214,5,16,19,6,1),(215,5,17,19,5,1),(216,5,5,19,7,1),(217,5,7,19,8,1),(218,7,14,19,1,1),(219,7,2,19,5,1),(220,7,15,19,3,1),(221,7,4,19,4,1),(222,7,16,19,2,1),(223,7,17,19,8,1),(224,7,5,19,6,1),(225,7,7,19,7,1),(226,2,14,20,1,1),(227,2,18,20,8,1),(228,2,2,20,2,1),(229,2,19,20,5,1),(230,2,17,20,6,1),(231,2,20,20,4,1),(232,2,15,20,7,1),(233,2,4,20,9,1),(234,2,5,20,3,1),(235,4,14,20,2,1),(236,4,18,20,1,1),(237,4,2,20,4,1),(238,4,19,20,5,1),(239,4,17,20,3,1),(240,4,20,20,9,1),(241,4,15,20,6,1),(242,4,4,20,8,1),(243,4,5,20,7,1),(244,6,14,20,1,1),(245,6,18,20,2,1),(246,6,2,20,3,1),(247,6,19,20,8,1),(248,6,17,20,5,1),(249,6,20,20,7,1),(250,6,15,20,4,1),(251,6,4,20,6,1),(252,6,5,20,9,1),(253,5,14,20,2,1),(254,5,18,20,7,1),(255,5,2,20,4,1),(256,5,19,20,1,1),(257,5,17,20,5,1),(258,5,20,20,6,1),(259,5,15,20,9,1),(260,5,4,20,3,1),(261,5,5,20,8,1),(262,7,14,20,2,1),(263,7,18,20,1,1),(264,7,2,20,3,1),(265,7,19,20,4,1),(266,7,17,20,8,1),(267,7,20,20,5,1),(268,7,15,20,6,1),(269,7,4,20,7,1),(270,7,5,20,9,1),(271,2,14,21,2,1),(272,2,18,21,3,1),(273,2,2,21,7,1),(274,2,15,21,6,1),(275,2,21,21,1,1),(276,2,19,21,8,1),(277,2,5,21,4,1),(278,2,4,21,9,1),(279,2,17,21,5,1),(280,4,14,21,2,1),(281,4,18,21,1,1),(282,4,2,21,4,1),(283,4,15,21,8,1),(284,4,21,21,6,1),(285,4,19,21,7,1),(286,4,5,21,9,1),(287,4,4,21,3,1),(288,4,17,21,5,1),(289,6,14,21,1,1),(290,6,18,21,3,1),(291,6,2,21,2,1),(292,6,15,21,6,1),(293,6,21,21,4,1),(294,6,19,21,5,1),(295,6,5,21,9,1),(296,6,4,21,7,1),(297,6,17,21,8,1),(298,5,14,21,1,1),(299,5,18,21,4,1),(300,5,2,21,3,1),(301,5,15,21,5,1),(302,5,21,21,9,1),(303,5,19,21,2,1),(304,5,5,21,6,1),(305,5,4,21,8,1),(306,5,17,21,7,1),(307,7,14,21,2,1),(308,7,18,21,1,1),(309,7,2,21,4,1),(310,7,15,21,3,1),(311,7,21,21,8,1),(312,7,19,21,6,1),(313,7,5,21,5,1),(314,7,4,21,7,1),(315,7,17,21,9,1),(316,2,14,22,1,1),(317,2,18,22,6,1),(318,2,19,22,2,1),(319,2,16,22,3,1),(320,2,15,22,5,1),(321,2,2,22,7,1),(322,2,4,22,4,1),(323,4,14,22,1,1),(324,4,18,22,3,1),(325,4,19,22,4,1),(326,4,16,22,6,1),(327,4,15,22,5,1),(328,4,2,22,2,1),(329,4,4,22,7,1),(330,6,14,22,1,1),(331,6,18,22,3,1),(332,6,19,22,7,1),(333,6,16,22,4,1),(334,6,15,22,5,1),(335,6,2,22,2,1),(336,6,4,22,6,1),(337,5,14,22,5,1),(338,5,18,22,2,1),(339,5,19,22,3,1),(340,5,16,22,4,1),(341,5,15,22,6,1),(342,5,2,22,7,1),(343,5,4,22,1,1),(344,7,14,22,5,1),(345,7,18,22,1,1),(346,7,19,22,3,1),(347,7,16,22,2,1),(348,7,15,22,4,1),(349,7,2,22,6,1),(350,7,4,22,7,1),(351,2,22,23,5,1),(352,2,2,23,2,1),(353,2,18,23,1,1),(354,2,7,23,4,1),(355,2,4,23,8,1),(356,2,15,23,6,1),(357,2,19,23,3,1),(358,2,16,23,7,1),(359,2,20,23,9,1),(360,4,22,23,4,1),(361,4,2,23,1,1),(362,4,18,23,2,1),(363,4,7,23,3,1),(364,4,4,23,5,1),(365,4,15,23,9,1),(366,4,19,23,7,1),(367,4,16,23,8,1),(368,4,20,23,6,1),(369,6,22,23,1,1),(370,6,2,23,2,1),(371,6,18,23,4,1),(372,6,7,23,5,1),(373,6,4,23,7,1),(374,6,15,23,6,1),(375,6,19,23,8,1),(376,6,16,23,3,1),(377,6,20,23,9,1),(378,5,22,23,2,1),(379,5,2,23,4,1),(380,5,18,23,6,1),(381,5,7,23,9,1),(382,5,4,23,1,1),(383,5,15,23,3,1),(384,5,19,23,5,1),(385,5,16,23,7,1),(386,5,20,23,8,1),(387,7,22,23,1,1),(388,7,2,23,3,1),(389,7,18,23,2,1),(390,7,7,23,4,1),(391,7,4,23,5,1),(392,7,15,23,6,1),(393,7,19,23,7,1),(394,7,16,23,8,1),(395,7,20,23,9,1),(396,8,23,24,2,2),(397,8,26,24,3,2),(398,8,24,24,7,2),(399,8,29,24,1,2),(400,8,28,24,5,2),(401,8,25,24,4,2),(402,8,30,24,6,2),(403,3,23,24,2,2),(404,3,26,24,1,2),(405,3,24,24,3,2),(406,3,29,24,7,2),(407,3,28,24,4,2),(408,3,25,24,5,2),(409,3,30,24,6,2),(410,9,23,24,7,2),(411,9,26,24,5,2),(412,9,24,24,1,2),(413,9,29,24,3,2),(414,9,28,24,2,2),(415,9,25,24,4,2),(416,9,30,24,6,2),(441,8,2,25,6,2),(442,8,23,25,2,2),(443,8,26,25,3,2),(444,8,29,25,1,2),(445,8,24,25,7,2),(446,8,30,25,5,2),(447,8,28,25,8,2),(448,8,25,25,4,2),(449,3,2,25,2,2),(450,3,23,25,1,2),(451,3,26,25,3,2),(452,3,29,25,8,2),(453,3,24,25,4,2),(454,3,30,25,7,2),(455,3,28,25,5,2),(456,3,25,25,6,2),(457,9,2,25,1,2),(458,9,23,25,8,2),(459,9,26,25,6,2),(460,9,29,25,4,2),(461,9,24,25,3,2),(462,9,30,25,2,2),(463,9,28,25,5,2),(464,9,25,25,7,2),(465,8,30,26,5,2),(466,8,29,26,2,2),(467,8,26,26,1,2),(468,8,28,26,4,2),(469,8,2,26,3,2),(470,8,25,26,6,2),(471,8,27,26,7,2),(472,8,24,26,8,2),(473,3,30,26,1,2),(474,3,29,26,8,2),(475,3,26,26,4,2),(476,3,28,26,7,2),(477,3,2,26,6,2),(478,3,25,26,2,2),(479,3,27,26,5,2),(480,3,24,26,3,2),(481,9,30,26,2,2),(482,9,29,26,3,2),(483,9,26,26,5,2),(484,9,28,26,1,2),(485,9,2,26,4,2),(486,9,25,26,7,2),(487,9,27,26,6,2),(488,9,24,26,8,2),(489,8,23,27,1,2),(490,8,29,27,2,2),(491,8,26,27,3,2),(492,8,27,27,4,2),(493,8,28,27,5,2),(494,3,23,27,3,2),(495,3,29,27,5,2),(496,3,26,27,1,2),(497,3,27,27,2,2),(498,3,28,27,4,2),(499,9,23,27,2,2),(500,9,29,27,1,2),(501,9,26,27,5,2),(502,9,27,27,3,2),(503,9,28,27,4,2),(504,8,2,28,6,2),(505,8,23,28,3,2),(506,8,24,28,2,2),(507,8,25,28,4,2),(508,8,26,28,1,2),(509,8,27,28,5,2),(510,8,28,28,7,2),(511,3,2,28,1,2),(512,3,23,28,4,2),(513,3,24,28,6,2),(514,3,25,28,3,2),(515,3,26,28,5,2),(516,3,27,28,7,2),(517,3,28,28,2,2),(518,9,2,28,1,2),(519,9,23,28,2,2),(520,9,24,28,4,2),(521,9,25,28,7,2),(522,9,26,28,5,2),(523,9,27,28,3,2),(524,9,28,28,6,2),(525,8,31,29,1,2),(526,8,32,29,3,2),(527,8,33,29,2,2),(528,8,2,29,5,2),(529,8,24,29,7,2),(530,8,5,29,6,2),(531,8,7,29,4,2),(532,3,31,29,1,2),(533,3,32,29,2,2),(534,3,33,29,4,2),(535,3,2,29,3,2),(536,3,24,29,5,2),(537,3,5,29,6,2),(538,3,7,29,7,2),(539,9,31,29,4,2),(540,9,32,29,1,2),(541,9,33,29,2,2),(542,9,2,29,7,2),(543,9,24,29,5,2),(544,9,5,29,3,2),(545,9,7,29,6,2),(546,8,31,30,1,2),(547,8,32,30,2,2),(548,8,33,30,3,2),(549,8,24,30,7,2),(550,8,5,30,4,2),(551,8,2,30,5,2),(552,8,7,30,6,2),(553,3,31,30,1,2),(554,3,32,30,2,2),(555,3,33,30,6,2),(556,3,24,30,4,2),(557,3,5,30,3,2),(558,3,2,30,5,2),(559,3,7,30,7,2),(560,9,31,30,4,2),(561,9,32,30,1,2),(562,9,33,30,3,2),(563,9,24,30,2,2),(564,9,5,30,7,2),(565,9,2,30,6,2),(566,9,7,30,5,2),(567,8,31,31,1,2),(568,8,33,31,3,2),(569,8,32,31,2,2),(570,8,2,31,5,2),(571,8,24,31,7,2),(572,8,27,31,6,2),(573,8,5,31,4,2),(574,3,31,31,1,2),(575,3,33,31,2,2),(576,3,32,31,3,2),(577,3,2,31,4,2),(578,3,24,31,5,2),(579,3,27,31,7,2),(580,3,5,31,6,2),(581,9,31,31,1,2),(582,9,33,31,3,2),(583,9,32,31,4,2),(584,9,2,31,6,2),(585,9,24,31,5,2),(586,9,27,31,2,2),(587,9,5,31,7,2),(630,8,31,32,1,2),(631,8,32,32,2,2),(632,8,33,32,3,2),(633,8,2,32,4,2),(634,8,24,32,7,2),(635,8,5,32,6,2),(636,8,27,32,5,2),(637,3,31,32,1,2),(638,3,32,32,3,2),(639,3,33,32,4,2),(640,3,2,32,2,2),(641,3,24,32,5,2),(642,3,5,32,6,2),(643,3,27,32,7,2),(644,9,31,32,2,2),(645,9,32,32,1,2),(646,9,33,32,3,2),(647,9,2,32,5,2),(648,9,24,32,4,2),(649,9,5,32,6,2),(650,9,27,32,7,2),(651,8,31,33,1,2),(652,8,2,33,2,2),(653,8,33,33,3,2),(654,8,32,33,4,2),(655,8,24,33,6,2),(656,8,5,33,7,2),(657,8,27,33,5,2),(658,3,31,33,1,2),(659,3,2,33,3,2),(660,3,33,33,6,2),(661,3,32,33,5,2),(662,3,24,33,4,2),(663,3,5,33,2,2),(664,3,27,33,7,2),(665,9,31,33,4,2),(666,9,2,33,5,2),(667,9,33,33,3,2),(668,9,32,33,1,2),(669,9,24,33,2,2),(670,9,5,33,6,2),(671,9,27,33,7,2);
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `second_place`
--

DROP TABLE IF EXISTS `second_place`;
/*!50001 DROP VIEW IF EXISTS `second_place`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `second_place` AS SELECT 
 1 AS `Score`,
 1 AS `Dancers`,
 1 AS `Judge`,
 1 AS `Style`,
 1 AS `Competition`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `style`
--

DROP TABLE IF EXISTS `style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `style` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `style`
--

LOCK TABLES `style` WRITE;
/*!40000 ALTER TABLE `style` DISABLE KEYS */;
INSERT INTO `style` VALUES (1,'Beginning International Standard Waltz'),(2,'Beginning International Standard Viennese Waltz'),(3,'Beginning International Standard Tango'),(4,'Beginning International Standard Quickstep'),(5,'Beginning International Standard Foxtrot'),(19,'Intermediate International Standard Waltz'),(20,'Intermediate International Standard Tango'),(21,'Intermediate International Standard Viennese Waltz'),(22,'Intermediate International Standard Foxtrot'),(23,'Intermediate International Standard Quickstep'),(24,'Silver International Standard Waltz'),(25,'Silver International Standard Tango'),(26,'Silver International Standard Viennese Waltz'),(27,'Silver International Standard Foxtrot'),(28,'Silver International Standard Quickstep'),(29,'Gold International Standard Waltz'),(30,'Gold International Standard Tango'),(31,'Gold International Standard Viennese Waltz'),(32,'Gold International Standard Foxtrot'),(33,'Gold International Standard Quickstep');
/*!40000 ALTER TABLE `style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `third_place`
--

DROP TABLE IF EXISTS `third_place`;
/*!50001 DROP VIEW IF EXISTS `third_place`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `third_place` AS SELECT 
 1 AS `Score`,
 1 AS `Dancers`,
 1 AS `Judge`,
 1 AS `Style`,
 1 AS `Competition`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `fifth_place`
--

/*!50001 DROP VIEW IF EXISTS `fifth_place`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fifth_place` AS select `scores`.`score` AS `Score`,`people`.`name` AS `Dancers`,`judges`.`name` AS `Judge`,`style`.`name` AS `Style`,`comp`.`name` AS `Competition` from ((((`scores` join `people` on((`scores`.`people_id` = `people`.`id`))) join `judges` on((`scores`.`judge_id` = `judges`.`id`))) join `style` on((`scores`.`style_id` = `style`.`id`))) join `comp` on((`scores`.`comp_id` = `comp`.`id`))) where (`scores`.`score` = 5) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `first_place`
--

/*!50001 DROP VIEW IF EXISTS `first_place`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `first_place` AS select `scores`.`score` AS `Score`,`people`.`name` AS `Dancers`,`judges`.`name` AS `Judge`,`style`.`name` AS `Style`,`comp`.`name` AS `Competition` from ((((`scores` join `people` on((`scores`.`people_id` = `people`.`id`))) join `judges` on((`scores`.`judge_id` = `judges`.`id`))) join `style` on((`scores`.`style_id` = `style`.`id`))) join `comp` on((`scores`.`comp_id` = `comp`.`id`))) where (`scores`.`score` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `fourth_place`
--

/*!50001 DROP VIEW IF EXISTS `fourth_place`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fourth_place` AS select `scores`.`score` AS `Score`,`people`.`name` AS `Dancers`,`judges`.`name` AS `Judge`,`style`.`name` AS `Style`,`comp`.`name` AS `Competition` from ((((`scores` join `people` on((`scores`.`people_id` = `people`.`id`))) join `judges` on((`scores`.`judge_id` = `judges`.`id`))) join `style` on((`scores`.`style_id` = `style`.`id`))) join `comp` on((`scores`.`comp_id` = `comp`.`id`))) where (`scores`.`score` = 4) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `second_place`
--

/*!50001 DROP VIEW IF EXISTS `second_place`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `second_place` AS select `scores`.`score` AS `Score`,`people`.`name` AS `Dancers`,`judges`.`name` AS `Judge`,`style`.`name` AS `Style`,`comp`.`name` AS `Competition` from ((((`scores` join `people` on((`scores`.`people_id` = `people`.`id`))) join `judges` on((`scores`.`judge_id` = `judges`.`id`))) join `style` on((`scores`.`style_id` = `style`.`id`))) join `comp` on((`scores`.`comp_id` = `comp`.`id`))) where (`scores`.`score` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `third_place`
--

/*!50001 DROP VIEW IF EXISTS `third_place`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `third_place` AS select `scores`.`score` AS `Score`,`people`.`name` AS `Dancers`,`judges`.`name` AS `Judge`,`style`.`name` AS `Style`,`comp`.`name` AS `Competition` from ((((`scores` join `people` on((`scores`.`people_id` = `people`.`id`))) join `judges` on((`scores`.`judge_id` = `judges`.`id`))) join `style` on((`scores`.`style_id` = `style`.`id`))) join `comp` on((`scores`.`comp_id` = `comp`.`id`))) where (`scores`.`score` = 3) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-06 14:30:48
