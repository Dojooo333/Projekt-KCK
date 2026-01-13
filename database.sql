CREATE DATABASE  IF NOT EXISTS `kck` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kck`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kck
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `class_members`
--

DROP TABLE IF EXISTS `class_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_members` (
  `id` int NOT NULL,
  `classID` int NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID_FK_idx` (`userID`),
  KEY `classID_FK_idx` (`classID`),
  CONSTRAINT `classmembers_classID_FK` FOREIGN KEY (`classID`) REFERENCES `classes` (`id`),
  CONSTRAINT `classmembers_userID_FK` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_members`
--

LOCK TABLES `class_members` WRITE;
/*!40000 ALTER TABLE `class_members` DISABLE KEYS */;
INSERT INTO `class_members` VALUES (1034,1073,1184),(1035,1323,1184),(1036,1073,1185);
/*!40000 ALTER TABLE `class_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `id` int NOT NULL,
  `className` varchar(100) COLLATE utf8mb3_polish_ci NOT NULL,
  `creatorID` int NOT NULL,
  `description` varchar(200) COLLATE utf8mb3_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID_FK_idx` (`creatorID`),
  CONSTRAINT `userID_FK` FOREIGN KEY (`creatorID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1073,'Politechnika Łódzka - Zagadnienia ogólnouczelniane',1189,'Wszystkie wydziały - Rok 2025/2026'),(1323,'Podstawy Programowania',1183,'Wszystkie wydziały - Rok 2025/2026');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `login` varchar(50) COLLATE utf8mb3_polish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb3_polish_ci NOT NULL,
  `title` varchar(20) COLLATE utf8mb3_polish_ci DEFAULT NULL,
  `firstName` varchar(50) COLLATE utf8mb3_polish_ci NOT NULL,
  `lastName` varchar(50) COLLATE utf8mb3_polish_ci NOT NULL,
  `isLecturer` tinyint NOT NULL,
  `imgName` varchar(50) COLLATE utf8mb3_polish_ci DEFAULT 'person.jpg',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1183,'mzajac','marek.zajac@p.lodz.pl','mgr inż.','Marek','Zając',1,'no-picture.jpg'),(1184,'224051','224051@edu.p.lodz.pl',NULL,'Jan','Kowalski',0,'224051.jpg'),(1185,'239102','239102@edu.p.lodz.pl',NULL,'Anna','Nowak',0,'239102.jpg'),(1186,'221543','221543@edu.p.lodz.pl',NULL,'Piotr','Wiśniewski',0,'no-picture.jpg'),(1187,'235678','235678@edu.p.lodz.pl',NULL,'Katarzyna','Wójcik',0,'no-picture.jpg'),(1188,'228991','228991@edu.p.lodz.pl',NULL,'Michał','Kamiński',0,'228991.jpg'),(1189,'abnowa','adam.nowak@p.lodz.pl','dr inż.','Adam','Nowak',1,'abnowa.jpg'),(1190,'230112','230112@edu.p.lodz.pl',NULL,'Magdalena','Lewandowska',0,'230112.jpg'),(1191,'225667','225667@edu.p.lodz.pl',NULL,'Tomasz','Zieliński',0,'no-picture.jpg'),(1192,'238884','238884@edu.p.lodz.pl',NULL,'Agnieszka','Szymańska',0,'no-picture.jpg'),(1193,'222345','222345@edu.p.lodz.pl',NULL,'Paweł','Woźniak',0,'222345.jpg'),(1194,'233456','233456@edu.p.lodz.pl',NULL,'Aleksandra','Dąbrowska',0,'no-picture.jpg'),(1195,'bakrol','barbara.krol@p.lodz.pl','prof. dr hab.','Barbara','Król',1,'bakrol.jpg'),(1196,'229789','229789@edu.p.lodz.pl',NULL,'Krzysztof','Kozłowski',0,'no-picture.jpg'),(1197,'237123','237123@edu.p.lodz.pl',NULL,'Monika','Jankowska',0,'no-picture.jpg'),(1198,'226781','226781@edu.p.lodz.pl',NULL,'Marcin','Mazur',0,'226781.jpg'),(1199,'231222','231222@edu.p.lodz.pl',NULL,'Joanna','Kwiatkowska',0,'no-picture.jpg'),(1200,'220999','220999@edu.p.lodz.pl',NULL,'Jakub','Krawczyk',0,'220999.jpg');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-13  2:13:44
