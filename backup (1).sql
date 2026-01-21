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
  `className` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `creatorID` int NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
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
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` int NOT NULL,
  `quizID` int NOT NULL,
  `userID` int NOT NULL,
  `startedDate` datetime NOT NULL,
  `finishedDate` datetime DEFAULT NULL,
  `result` tinyint unsigned NOT NULL,
  `correctQuestions` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `games_quizID_FK_idx` (`quizID`),
  KEY `games_userID_FK_idx` (`userID`),
  CONSTRAINT `games_quizID_FK` FOREIGN KEY (`quizID`) REFERENCES `quizes` (`id`),
  CONSTRAINT `games_userID_FK` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL DEFAULT '1500',
  `quizID` int NOT NULL,
  `questionNr` int NOT NULL,
  `question` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `answerA` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `answerB` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `answerC` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `answerD` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `correctAnswer` enum('A','B','C','D') CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questions_quizID_FK_idx` (`quizID`),
  CONSTRAINT `questions_quizID_FK` FOREIGN KEY (`quizID`) REFERENCES `quizes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1457,1500,1,'Jaki jest indeks pierwszego elementu tablicy w C?','1','0','-1','Zależy od deklaracji','B'),(1458,1500,2,'Który nagłówek należy dołączyć, aby korzystać z funkcji printf()?','<stdlib.h>','<stdio.h>','<string.h>','<math.h>','B'),(1459,1500,3,'Ile bajtów zajmuje typ char w standardzie C?','1 bajt','2 bajty','4 bajty','Zależy od kompilatora','A'),(1460,1500,4,'Który specyfikator formatu jest używany do wyświetlania liczby zmiennoprzecinkowej?','%d','%f','%c','%s','B'),(1461,1500,5,'Co robi instrukcja break w pętli?','Kończy program','Przechodzi do następnej iteracji','Wychodzi z pętli','Zatrzymuje kompilację','C'),(1462,1500,6,'Który znak kończy ciąg znaków w C?','\n','\0','EOF','NULL','B'),(1463,1500,7,'Jak zadeklarować tablicę 10 liczb całkowitych?','int array;','array int;','int array;','integer array;','A'),(1464,1500,8,'Która instrukcja jest używana do wielokrotnego wyboru w C?','if-else','switch-case','select','choose','B'),(1465,1500,9,'Jaki jest typ zwracany przez funkcję main(), jeśli nie określono inaczej?','void','int','char','float','B'),(1466,1500,10,'Co oznacza operator && w języku C?','Logiczne LUB','Bitowe AND','Logiczne AND','Przypisanie','C'),(1467,1500,11,'Która funkcja służy do alokacji pamięci dynamicznej?','alloc()','new()','malloc()','memory()','C'),(1468,1500,12,'Która funkcja służy do zwalniania pamięci dynamicznej?','delete()','remove()','free()','clear()','C'),(1469,1500,13,'Co zwróci wyrażenie: sizeof(int) na typowej 32-bitowej platformie?','2','4','8','16','B'),(1470,1500,14,'Która pętla sprawdza warunek przed wykonaniem bloku kodu?','do-while','Tylko while','while i for','Żadna z powyższych','C'),(1471,1500,15,'Jaki będzie wynik wyrażenia: 5 / 2 w języku C?','2.5','2','3','2.0','B'),(1472,1500,16,'Jaki jest poprawny sposób deklaracji wskaźnika na zmienną typu int?','int ptr;','int ptr;','pointer int ptr;','int &ptr;','A'),(1473,1500,17,'Co robi operator & w kontekście wskaźników?','Dereferencja wskaźnika','Zwraca adres zmiennej','Porównuje wskaźniki','Alokuje pamięć','B'),(1474,1500,18,'Który operator służy do dostępu do pola struktury przez wskaźnik?','.','::','->','*','C'),(1475,1500,19,'Co oznacza słowo kluczowe void w deklaracji funkcji?','Funkcja nie zwraca wartości','Funkcja nie przyjmuje argumentów','Oba powyższe, w zależności od kontekstu','Funkcja jest prywatna','C'),(1476,1500,20,'Jak przekazać tablicę do funkcji w C?','Przez wartość','Przez wskaźnik (automatycznie)','Należy użyć słowa kluczowego array','Nie można przekazać tablicy','B'),(1477,1501,1,'Który typ w C najczęściej służy do przechowywania pojedynczego znaku?','int','char','float','double','B'),(1478,1501,2,'Który specyfikator formatu w printf() jest poprawny dla typu unsigned int?','%d','%u','%f','%s','B'),(1479,1501,3,'Który specyfikator formatu w printf() jest typowo używany dla long long int?','%ld','%lld','%u','%p','B'),(1480,1501,4,'Które słowo kluczowe służy do zdefiniowania typu wyliczeniowego?','struct','union','enum','typedef','C'),(1481,1501,5,'Jaki typ (C99) reprezentuje wartości logiczne 0/1 na poziomie języka?','bool','_Bool','bit','logic','B');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizes`
--

DROP TABLE IF EXISTS `quizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizes` (
  `id` int NOT NULL,
  `classID` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `questionsCount` smallint unsigned NOT NULL,
  `difficulty` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quizes_classID_FK_idx` (`classID`),
  CONSTRAINT `quizes_classID_FK` FOREIGN KEY (`classID`) REFERENCES `classes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizes`
--

LOCK TABLES `quizes` WRITE;
/*!40000 ALTER TABLE `quizes` DISABLE KEYS */;
INSERT INTO `quizes` VALUES (1500,1323,'Język C',20,'hard'),(1501,1323,'Typy danych w Języku C',5,'easy'),(3427,1073,'Kampusy i inne ważne budynki',12,'easy'),(3428,1073,'Historia i powstanie uczelni',15,'medium'),(3429,1073,'Władze i struktura',12,'hard'),(3430,1073,'Symbole i ciekawostki',15,'medium');
/*!40000 ALTER TABLE `quizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `login` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `title` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci DEFAULT NULL,
  `firstName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `lastName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `isLecturer` tinyint NOT NULL,
  `imgName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci DEFAULT 'person.jpg',
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

--
-- Dumping routines for database 'kck'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-21 13:30:51
