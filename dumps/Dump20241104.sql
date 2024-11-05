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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `judges`
--

LOCK TABLES `judges` WRITE;
/*!40000 ALTER TABLE `judges` DISABLE KEYS */;
INSERT INTO `judges` VALUES (1,'Phillip Stephens'),(2,'Curtis Prevost'),(3,'Pamelyn Shefman'),(4,'Ryan Lewis'),(5,'Pamela Romano');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Millen Loa & Vennila Natarajan'),(2,'Joshua Maxwell & Emily Martinez'),(3,'Ryan Boyce & Malini Prasad'),(4,'Seth Lowery & Jennifer Le'),(5,'Eythan Karp & Naila Hajiyeva'),(6,'Joshua Hillis & Sophia Bombach'),(7,'Rodrigo Brandao & Eve Nguyen'),(8,'Daniel Maxenberger & Sandy Baadsgaard'),(9,'Anthony Karam & Subarna Mandal'),(10,'Trevor Hastings & Audrey Rupley'),(11,'Pascual Ortiz & Hannah Seymour'),(12,'Dylan Powell & Anne Hulme'),(13,'Grant MacDonald & Delaney Gaston');
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
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
INSERT INTO `scores` VALUES (1,1,1,1,1),(2,1,2,1,2),(3,1,3,1,3),(4,1,4,1,5),(5,1,5,1,4),(6,1,6,1,6),(7,2,1,1,1),(8,2,2,1,2),(9,2,3,1,3),(10,2,4,1,4),(11,2,5,1,5),(12,2,6,1,6),(13,3,1,1,1),(14,3,2,1,2),(15,3,3,1,3),(16,3,4,1,5),(17,3,5,1,4),(18,3,6,1,6),(19,4,1,1,1),(20,4,2,1,2),(21,4,3,1,5),(22,4,4,1,3),(23,4,5,1,4),(24,4,6,1,6),(25,5,1,1,1),(26,5,2,1,3),(27,5,3,1,4),(28,5,4,1,2),(29,5,5,1,5),(30,5,6,1,6),(31,1,1,2,1),(32,1,2,2,2),(33,1,3,2,3),(34,1,4,2,7),(35,1,7,2,4),(36,1,5,2,5),(37,1,8,2,6),(38,1,9,2,8),(39,1,10,2,9),(40,2,1,2,1),(41,2,2,2,2),(42,2,3,2,3),(43,2,4,2,7),(44,2,7,2,4),(45,2,5,2,5),(46,2,8,2,9),(47,2,9,2,7),(48,2,10,2,8),(49,3,1,2,1),(50,3,2,2,3),(51,3,3,2,2),(52,3,4,2,6),(53,3,7,2,5),(54,3,5,2,7),(55,3,8,2,4),(56,3,9,2,9),(57,3,10,2,8),(58,4,1,2,1),(59,4,2,2,2),(60,4,3,2,3),(61,4,4,2,4),(62,4,7,2,7),(63,4,5,2,6),(64,4,8,2,5),(65,4,9,2,8),(66,4,10,2,9),(67,5,1,2,2),(68,5,2,2,3),(69,5,3,2,6),(70,5,4,2,1),(71,5,7,2,5),(72,5,5,2,4),(73,5,8,2,8),(74,5,9,2,7),(75,5,10,2,9),(76,1,1,3,1),(77,1,2,3,2),(78,1,11,3,4),(79,1,4,3,5),(80,1,5,3,3),(81,1,6,3,6),(82,1,12,3,7),(83,2,1,3,1),(84,2,2,3,2),(85,2,11,3,3),(86,2,4,3,4),(87,2,5,3,6),(88,2,6,3,5),(89,2,12,3,7),(90,3,1,3,1),(91,3,2,3,3),(92,3,11,3,4),(93,3,4,3,5),(94,3,5,3,2),(95,3,6,3,6),(96,3,12,3,7),(97,4,1,3,1),(98,4,2,3,2),(99,4,11,3,3),(100,4,4,3,4),(101,4,5,3,6),(102,4,6,3,7),(103,4,12,3,5),(104,5,1,3,1),(105,5,2,3,3),(106,5,11,3,4),(107,5,4,3,2),(108,5,5,3,5),(109,5,6,3,7),(110,5,12,3,6),(111,1,1,4,1),(112,1,2,4,3),(113,1,3,4,2),(114,1,4,4,5),(115,1,11,4,4),(116,1,5,4,6),(117,1,7,4,7),(118,1,12,4,8),(119,2,1,4,2),(120,2,2,4,5),(121,2,3,4,3),(122,2,4,4,1),(123,2,11,4,4),(124,2,5,4,6),(125,2,7,4,7),(126,2,12,4,8),(127,3,1,4,1),(128,3,2,4,2),(129,3,3,4,3),(130,3,4,4,4),(131,3,11,4,5),(132,3,5,4,8),(133,3,7,4,7),(134,3,12,4,6),(135,4,1,4,1),(136,4,2,4,2),(137,4,3,4,3),(138,4,4,4,5),(139,4,11,4,8),(140,4,5,4,7),(141,4,7,4,6),(142,4,12,4,4),(143,5,1,4,2),(144,5,2,4,3),(145,5,3,4,4),(146,5,4,4,1),(147,5,11,4,6),(148,5,5,4,5),(149,5,7,4,7),(150,5,12,4,8),(151,1,1,5,1),(152,1,2,5,3),(153,1,3,5,2),(154,1,4,5,6),(155,1,5,5,4),(156,1,13,5,7),(157,1,7,5,5),(158,2,1,5,1),(159,2,2,5,2),(160,2,3,5,3),(161,2,4,5,4),(162,2,5,5,6),(163,2,13,5,7),(164,2,7,5,5),(165,3,1,5,1),(166,3,2,5,3),(167,3,3,5,2),(168,3,4,5,6),(169,3,5,5,5),(170,3,13,5,4),(171,3,7,5,7),(172,4,1,5,1),(173,4,2,5,2),(174,4,3,5,4),(175,4,4,5,3),(176,4,5,5,6),(177,4,13,5,5),(178,4,7,5,7),(179,5,1,5,3),(180,5,2,5,2),(181,5,3,5,4),(182,5,4,5,1),(183,5,5,5,5),(184,5,13,5,6),(185,5,7,5,7);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `style`
--

LOCK TABLES `style` WRITE;
/*!40000 ALTER TABLE `style` DISABLE KEYS */;
INSERT INTO `style` VALUES (1,'Beginning International Standard Waltz'),(2,'Beginning International Standard Viennese Waltz'),(3,'Beginning International Standard Tango'),(4,'Beginning International Standard Quickstep'),(5,'Beginning International Standard Foxtrot');
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

-- Dump completed on 2024-11-04 19:40:09
