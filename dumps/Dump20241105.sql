-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ao2024
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
-- Table structure for table `judges`
--

DROP TABLE IF EXISTS `judges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `judges`
--

LOCK TABLES `judges` WRITE;
/*!40000 ALTER TABLE `judges` DISABLE KEYS */;
INSERT INTO `judges` VALUES (1,'Phillip Stephens'),(2,'Curtis Prevost'),(3,'Pamelyn Shefman'),(4,'Ryan Lewis'),(5,'Pamela Romano'),(6,'Mark Moy'),(7,'Ryan Ford');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Millen Loa & Vennila Natarajan'),(2,'Joshua Maxwell & Emily Martinez'),(3,'Ryan Boyce & Malini Prasad'),(4,'Seth Lowery & Jennifer Le'),(5,'Eythan Karp & Naila Hajiyeva'),(6,'Joshua Hillis & Sophia Bombach'),(7,'Rodrigo Brandao & Eve Nguyen'),(8,'Daniel Maxenberger & Sandy Baadsgaard'),(9,'Anthony Karam & Subarna Mandal'),(10,'Trevor Hastings & Audrey Rupley'),(11,'Pascual Ortiz & Hannah Seymour'),(12,'Dylan Powell & Anne Hulme'),(13,'Grant MacDonald & Delaney Gaston'),(14,'Parker Holland & Kira Murillo'),(15,'Jaryd Domine & Anne Hulme'),(16,'Kireeti Singam Setty & Jacqueline McCoy'),(17,'Millen Loa & Delaney Gaston'),(18,'Cady Johnson & Julian Herrera'),(19,'Trevor Hastings & Nicole Deichl'),(20,'Bryce Shurts & Vennila Natarajan'),(21,'Grace Dreifuerst & Malini Prasad'),(22,'Alfredo Espinoza & Angelina Covey');
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
  PRIMARY KEY (`score_id`),
  KEY `judge_id` (`judge_id`),
  KEY `people_id` (`people_id`),
  KEY `style_id` (`style_id`),
  CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`judge_id`) REFERENCES `judges` (`id`),
  CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`people_id`) REFERENCES `people` (`id`),
  CONSTRAINT `scores_ibfk_3` FOREIGN KEY (`style_id`) REFERENCES `style` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
INSERT INTO `scores` VALUES (1,1,1,1,1),(2,1,2,1,2),(3,1,3,1,3),(4,1,4,1,5),(5,1,5,1,4),(6,1,6,1,6),(7,2,1,1,1),(8,2,2,1,2),(9,2,3,1,3),(10,2,4,1,4),(11,2,5,1,5),(12,2,6,1,6),(13,3,1,1,1),(14,3,2,1,2),(15,3,3,1,3),(16,3,4,1,5),(17,3,5,1,4),(18,3,6,1,6),(19,4,1,1,1),(20,4,2,1,2),(21,4,3,1,5),(22,4,4,1,3),(23,4,5,1,4),(24,4,6,1,6),(25,5,1,1,1),(26,5,2,1,3),(27,5,3,1,4),(28,5,4,1,2),(29,5,5,1,5),(30,5,6,1,6),(31,1,1,2,1),(32,1,2,2,2),(33,1,3,2,3),(34,1,4,2,7),(35,1,7,2,4),(36,1,5,2,5),(37,1,8,2,6),(38,1,9,2,8),(39,1,10,2,9),(40,2,1,2,1),(41,2,2,2,2),(42,2,3,2,3),(43,2,4,2,7),(44,2,7,2,4),(45,2,5,2,5),(46,2,8,2,9),(47,2,9,2,7),(48,2,10,2,8),(49,3,1,2,1),(50,3,2,2,3),(51,3,3,2,2),(52,3,4,2,6),(53,3,7,2,5),(54,3,5,2,7),(55,3,8,2,4),(56,3,9,2,9),(57,3,10,2,8),(58,4,1,2,1),(59,4,2,2,2),(60,4,3,2,3),(61,4,4,2,4),(62,4,7,2,7),(63,4,5,2,6),(64,4,8,2,5),(65,4,9,2,8),(66,4,10,2,9),(67,5,1,2,2),(68,5,2,2,3),(69,5,3,2,6),(70,5,4,2,1),(71,5,7,2,5),(72,5,5,2,4),(73,5,8,2,8),(74,5,9,2,7),(75,5,10,2,9),(76,1,1,3,1),(77,1,2,3,2),(78,1,11,3,4),(79,1,4,3,5),(80,1,5,3,3),(81,1,6,3,6),(82,1,12,3,7),(83,2,1,3,1),(84,2,2,3,2),(85,2,11,3,3),(86,2,4,3,4),(87,2,5,3,6),(88,2,6,3,5),(89,2,12,3,7),(90,3,1,3,1),(91,3,2,3,3),(92,3,11,3,4),(93,3,4,3,5),(94,3,5,3,2),(95,3,6,3,6),(96,3,12,3,7),(97,4,1,3,1),(98,4,2,3,2),(99,4,11,3,3),(100,4,4,3,4),(101,4,5,3,6),(102,4,6,3,7),(103,4,12,3,5),(104,5,1,3,1),(105,5,2,3,3),(106,5,11,3,4),(107,5,4,3,2),(108,5,5,3,5),(109,5,6,3,7),(110,5,12,3,6),(111,1,1,4,1),(112,1,2,4,3),(113,1,3,4,2),(114,1,4,4,5),(115,1,11,4,4),(116,1,5,4,6),(117,1,7,4,7),(118,1,12,4,8),(119,2,1,4,2),(120,2,2,4,5),(121,2,3,4,3),(122,2,4,4,1),(123,2,11,4,4),(124,2,5,4,6),(125,2,7,4,7),(126,2,12,4,8),(127,3,1,4,1),(128,3,2,4,2),(129,3,3,4,3),(130,3,4,4,4),(131,3,11,4,5),(132,3,5,4,8),(133,3,7,4,7),(134,3,12,4,6),(135,4,1,4,1),(136,4,2,4,2),(137,4,3,4,3),(138,4,4,4,5),(139,4,11,4,8),(140,4,5,4,7),(141,4,7,4,6),(142,4,12,4,4),(143,5,1,4,2),(144,5,2,4,3),(145,5,3,4,4),(146,5,4,4,1),(147,5,11,4,6),(148,5,5,4,5),(149,5,7,4,7),(150,5,12,4,8),(151,1,1,5,1),(152,1,2,5,3),(153,1,3,5,2),(154,1,4,5,6),(155,1,5,5,4),(156,1,13,5,7),(157,1,7,5,5),(158,2,1,5,1),(159,2,2,5,2),(160,2,3,5,3),(161,2,4,5,4),(162,2,5,5,6),(163,2,13,5,7),(164,2,7,5,5),(165,3,1,5,1),(166,3,2,5,3),(167,3,3,5,2),(168,3,4,5,6),(169,3,5,5,5),(170,3,13,5,4),(171,3,7,5,7),(172,4,1,5,1),(173,4,2,5,2),(174,4,3,5,4),(175,4,4,5,3),(176,4,5,5,6),(177,4,13,5,5),(178,4,7,5,7),(179,5,1,5,3),(180,5,2,5,2),(181,5,3,5,4),(182,5,4,5,1),(183,5,5,5,5),(184,5,13,5,6),(185,5,7,5,7),(186,2,14,19,1),(187,2,2,19,2),(188,2,15,19,8),(189,2,4,19,5),(190,2,16,19,6),(191,2,17,19,4),(192,2,5,19,3),(193,2,7,19,7),(194,4,14,19,2),(195,4,2,19,3),(196,4,15,19,4),(197,4,4,19,6),(198,4,16,19,5),(199,4,17,19,1),(200,4,5,19,7),(201,4,7,19,8),(202,6,14,19,1),(203,6,2,19,3),(204,6,15,19,4),(205,6,4,19,5),(206,6,16,19,2),(207,6,17,19,7),(208,6,5,19,6),(209,6,7,19,8),(210,5,14,19,1),(211,5,2,19,4),(212,5,15,19,2),(213,5,4,19,3),(214,5,16,19,6),(215,5,17,19,5),(216,5,5,19,7),(217,5,7,19,8),(218,7,14,19,1),(219,7,2,19,5),(220,7,15,19,3),(221,7,4,19,4),(222,7,16,19,2),(223,7,17,19,8),(224,7,5,19,6),(225,7,7,19,7),(226,2,14,20,1),(227,2,18,20,8),(228,2,2,20,2),(229,2,19,20,5),(230,2,17,20,6),(231,2,20,20,4),(232,2,15,20,7),(233,2,4,20,9),(234,2,5,20,3),(235,4,14,20,2),(236,4,18,20,1),(237,4,2,20,4),(238,4,19,20,5),(239,4,17,20,3),(240,4,20,20,9),(241,4,15,20,6),(242,4,4,20,8),(243,4,5,20,7),(244,6,14,20,1),(245,6,18,20,2),(246,6,2,20,3),(247,6,19,20,8),(248,6,17,20,5),(249,6,20,20,7),(250,6,15,20,4),(251,6,4,20,6),(252,6,5,20,9),(253,5,14,20,2),(254,5,18,20,7),(255,5,2,20,4),(256,5,19,20,1),(257,5,17,20,5),(258,5,20,20,6),(259,5,15,20,9),(260,5,4,20,3),(261,5,5,20,8),(262,7,14,20,2),(263,7,18,20,1),(264,7,2,20,3),(265,7,19,20,4),(266,7,17,20,8),(267,7,20,20,5),(268,7,15,20,6),(269,7,4,20,7),(270,7,5,20,9),(271,2,14,21,2),(272,2,18,21,3),(273,2,2,21,7),(274,2,15,21,6),(275,2,21,21,1),(276,2,19,21,8),(277,2,5,21,4),(278,2,4,21,9),(279,2,17,21,5),(280,4,14,21,2),(281,4,18,21,1),(282,4,2,21,4),(283,4,15,21,8),(284,4,21,21,6),(285,4,19,21,7),(286,4,5,21,9),(287,4,4,21,3),(288,4,17,21,5),(289,6,14,21,1),(290,6,18,21,3),(291,6,2,21,2),(292,6,15,21,6),(293,6,21,21,4),(294,6,19,21,5),(295,6,5,21,9),(296,6,4,21,7),(297,6,17,21,8),(298,5,14,21,1),(299,5,18,21,4),(300,5,2,21,3),(301,5,15,21,5),(302,5,21,21,9),(303,5,19,21,2),(304,5,5,21,6),(305,5,4,21,8),(306,5,17,21,7),(307,7,14,21,2),(308,7,18,21,1),(309,7,2,21,4),(310,7,15,21,3),(311,7,21,21,8),(312,7,19,21,6),(313,7,5,21,5),(314,7,4,21,7),(315,7,17,21,9),(316,2,14,22,1),(317,2,18,22,6),(318,2,19,22,2),(319,2,16,22,3),(320,2,15,22,5),(321,2,2,22,7),(322,2,4,22,4),(323,4,14,22,1),(324,4,18,22,3),(325,4,19,22,4),(326,4,16,22,6),(327,4,15,22,5),(328,4,2,22,2),(329,4,4,22,7),(330,6,14,22,1),(331,6,18,22,3),(332,6,19,22,7),(333,6,16,22,4),(334,6,15,22,5),(335,6,2,22,2),(336,6,4,22,6),(337,5,14,22,5),(338,5,18,22,2),(339,5,19,22,3),(340,5,16,22,4),(341,5,15,22,6),(342,5,2,22,7),(343,5,4,22,1),(344,7,14,22,5),(345,7,18,22,1),(346,7,19,22,3),(347,7,16,22,2),(348,7,15,22,4),(349,7,2,22,6),(350,7,4,22,7),(351,2,22,23,5),(352,2,2,23,2),(353,2,18,23,1),(354,2,7,23,4),(355,2,4,23,8),(356,2,15,23,6),(357,2,19,23,3),(358,2,16,23,7),(359,2,20,23,9),(360,4,22,23,4),(361,4,2,23,1),(362,4,18,23,2),(363,4,7,23,3),(364,4,4,23,5),(365,4,15,23,9),(366,4,19,23,7),(367,4,16,23,8),(368,4,20,23,6),(369,6,22,23,1),(370,6,2,23,2),(371,6,18,23,4),(372,6,7,23,5),(373,6,4,23,7),(374,6,15,23,6),(375,6,19,23,8),(376,6,16,23,3),(377,6,20,23,9),(378,5,22,23,2),(379,5,2,23,4),(380,5,18,23,6),(381,5,7,23,9),(382,5,4,23,1),(383,5,15,23,3),(384,5,19,23,5),(385,5,16,23,7),(386,5,20,23,8),(387,7,22,23,1),(388,7,2,23,3),(389,7,18,23,2),(390,7,7,23,4),(391,7,4,23,5),(392,7,15,23,6),(393,7,19,23,7),(394,7,16,23,8),(395,7,20,23,9);
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `style`
--

LOCK TABLES `style` WRITE;
/*!40000 ALTER TABLE `style` DISABLE KEYS */;
INSERT INTO `style` VALUES (1,'Beginning International Standard Waltz'),(2,'Beginning International Standard Viennese Waltz'),(3,'Beginning International Standard Tango'),(4,'Beginning International Standard Quickstep'),(5,'Beginning International Standard Foxtrot'),(19,'Intermediate International Standard Waltz'),(20,'Intermediate International Standard Tango'),(21,'Intermediate International Standard Viennese Waltz'),(22,'Intermediate International Standard Foxtrot'),(23,'Intermediate International Standard Quickstep');
/*!40000 ALTER TABLE `style` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-05  1:30:16
