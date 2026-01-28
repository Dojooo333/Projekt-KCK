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
  `id` int NOT NULL AUTO_INCREMENT,
  `classID` int NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID_FK_idx` (`userID`),
  KEY `classID_FK_idx` (`classID`),
  CONSTRAINT `classmembers_classID_FK` FOREIGN KEY (`classID`) REFERENCES `classes` (`id`),
  CONSTRAINT `classmembers_userID_FK` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_members`
--

LOCK TABLES `class_members` WRITE;
/*!40000 ALTER TABLE `class_members` DISABLE KEYS */;
INSERT INTO `class_members` VALUES (1,1,5),(2,1,6),(3,1,7),(4,1,8),(5,1,9),(6,1,10),(7,1,11),(8,1,12),(9,1,13),(10,1,14),(11,1,15),(12,1,16),(13,2,5),(14,2,7),(15,2,9),(16,2,11),(17,2,13),(18,2,15),(19,3,6),(20,3,8),(21,3,10),(22,3,12),(23,3,14),(24,4,5),(25,4,6),(26,4,7),(27,4,14),(28,4,15),(29,4,16),(30,4,8),(31,5,9),(32,5,10),(33,5,11),(34,5,12),(35,5,13),(36,1,17),(37,1,18),(38,1,19);
/*!40000 ALTER TABLE `class_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `className` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `creatorID` int NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID_FK_idx` (`creatorID`),
  CONSTRAINT `classes_creatorID_FK` FOREIGN KEY (`creatorID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,'Politechnika Łódzka - Zagadnienia ogólnouczelniane',1,'Wszystkie wydziały - Rok 2025/2026'),(2,'Wydział EEIA',1,'Wydział EEIA - Rok 2025/2026 - Grupa 5I1'),(3,'Komunikacja człowiek-komputer',2,'Wydział EEIA - Rok 2025/2026 - Grupa 5I1'),(4,'Bazy danych',3,'Wydział EEIA - Rok 2025/2026 - Grupa 5I1'),(5,'Systemy wbudowane',4,'Wydział EEIA - Rok 2025/2026 - Grupa 5I1');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` int NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (21,1,5,'2025-10-15 08:00:00','2025-10-15 08:12:30',1,10),(22,1,6,'2025-10-15 09:00:00','2025-10-15 09:10:40',1,10),(23,1,7,'2025-10-16 10:00:00','2025-10-16 10:09:15',0,0),(24,1,8,'2025-10-16 11:00:00','2025-10-16 11:13:55',1,10),(25,1,9,'2025-10-17 12:00:00','2025-10-17 12:08:20',1,10),(26,1,10,'2025-10-17 13:00:00','2025-10-17 13:11:10',1,10),(27,1,11,'2025-10-18 08:30:00','2025-10-18 08:39:05',0,5),(28,1,12,'2025-10-18 09:30:00','2025-10-18 09:44:30',1,10),(29,2,13,'2025-11-05 10:00:00','2025-11-05 10:16:25',1,12),(30,2,14,'2025-11-05 11:00:00','2025-11-05 11:14:40',1,12),(31,2,15,'2025-11-06 12:00:00','2025-11-06 12:10:05',0,8),(32,2,16,'2025-11-06 13:00:00','2025-11-06 13:18:20',1,12),(33,2,17,'2025-11-07 08:00:00','2025-11-07 08:12:45',1,12),(34,2,18,'2025-11-07 09:00:00','2025-11-07 09:16:10',1,12),(35,2,19,'2025-11-08 10:30:00','2025-11-08 10:38:55',0,1),(36,2,6,'2025-11-08 11:30:00','2025-11-08 11:47:15',1,12),(37,3,7,'2025-12-01 09:00:00','2025-12-01 09:11:25',1,10),(38,3,8,'2025-12-01 10:00:00','2025-12-01 10:08:35',1,10),(39,3,9,'2025-12-02 11:00:00','2025-12-02 11:06:40',0,3),(40,3,10,'2025-12-02 12:00:00','2025-12-02 12:13:10',1,10),(41,3,11,'2025-12-03 13:00:00','2025-12-03 13:09:20',1,10),(42,3,12,'2025-12-03 14:00:00','2025-12-03 14:05:30',0,5),(43,3,13,'2025-12-04 08:00:00','2025-12-04 08:12:05',1,10),(44,4,5,'2025-10-20 09:00:00','2025-10-20 09:13:30',1,10),(45,4,7,'2025-10-20 10:00:00','2025-10-20 10:08:10',0,0),(46,4,9,'2025-10-21 11:00:00','2025-10-21 11:12:40',1,10),(47,4,11,'2025-10-21 12:00:00','2025-10-21 12:10:25',1,10),(48,4,13,'2025-10-22 13:00:00','2025-10-22 13:07:55',0,0),(49,4,15,'2025-10-22 14:00:00','2025-10-22 14:11:05',1,10),(50,5,5,'2025-11-12 08:30:00','2025-11-12 08:49:10',1,12),(51,5,7,'2025-11-12 09:30:00','2025-11-12 09:41:45',0,5),(52,5,9,'2025-11-13 10:30:00','2025-11-13 10:52:20',1,12),(53,5,11,'2025-11-13 11:30:00','2025-11-13 11:43:05',0,0),(54,5,13,'2025-11-14 12:30:00','2025-11-14 12:55:10',1,12),(55,6,6,'2025-10-25 09:00:00','2025-10-25 09:12:10',1,10),(56,6,8,'2025-10-25 10:00:00','2025-10-25 10:07:35',0,6),(57,6,10,'2025-10-26 11:00:00','2025-10-26 11:10:50',1,10),(58,6,12,'2025-10-26 12:00:00','2025-10-26 12:15:20',1,10),(59,6,14,'2025-10-27 13:00:00','2025-10-27 13:06:45',0,2),(60,6,6,'2025-10-27 14:00:00','2025-10-27 14:12:05',1,10),(61,7,8,'2025-11-18 09:00:00','2025-11-18 09:27:30',1,15),(62,7,10,'2025-11-18 10:00:00','2025-11-18 10:22:10',1,15),(63,7,12,'2025-11-19 11:00:00','2025-11-19 11:14:40',0,8),(64,7,14,'2025-11-19 12:00:00','2025-11-19 12:26:15',1,15),(65,7,6,'2025-11-20 13:00:00','2025-11-20 13:20:05',1,15),(66,7,8,'2025-11-20 14:00:00','2025-11-20 14:09:30',0,1),(67,8,10,'2025-12-10 09:00:00','2025-12-10 09:18:10',1,12),(68,8,12,'2025-12-10 10:00:00','2025-12-10 10:12:40',0,7),(69,8,14,'2025-12-11 11:00:00','2025-12-11 11:21:55',1,12),(70,8,6,'2025-12-11 12:00:00','2025-12-11 12:13:30',1,12),(71,8,8,'2025-12-12 13:00:00','2025-12-12 13:08:20',0,0),(72,9,5,'2025-10-30 09:00:00','2025-10-30 09:17:10',1,12),(73,9,6,'2025-10-30 10:00:00','2025-10-30 10:08:35',0,1),(74,9,7,'2025-10-31 11:00:00','2025-10-31 11:20:45',1,12),(75,9,8,'2025-10-31 12:00:00','2025-10-31 12:13:05',1,12),(76,9,14,'2025-11-01 13:00:00','2025-11-01 13:07:55',0,8),(77,9,15,'2025-11-01 14:00:00','2025-11-01 14:18:30',1,12),(78,10,16,'2025-12-05 09:00:00','2025-12-05 09:26:15',1,15),(79,10,14,'2025-12-05 10:00:00','2025-12-05 10:11:40',0,5),(80,10,8,'2025-12-06 11:00:00','2025-12-06 11:29:05',1,15),(81,10,7,'2025-12-06 12:00:00','2025-12-06 12:15:55',0,7),(82,10,6,'2025-12-07 13:00:00','2025-12-07 13:24:35',1,15),(83,11,9,'2025-11-03 09:00:00','2025-11-03 09:21:20',1,12),(84,11,10,'2025-11-03 10:00:00','2025-11-03 10:12:10',0,6),(85,11,11,'2025-11-04 11:00:00','2025-11-04 11:19:45',1,12),(86,11,12,'2025-11-04 12:00:00','2025-11-04 12:09:25',0,5),(87,11,13,'2025-11-05 13:00:00','2025-11-05 13:17:05',1,12),(88,11,9,'2025-11-05 14:00:00','2025-11-05 14:10:40',1,12),(89,12,10,'2025-12-15 09:00:00','2025-12-15 09:11:55',1,10),(90,12,11,'2025-12-15 10:00:00','2025-12-15 10:05:20',0,5),(91,12,12,'2025-12-16 11:00:00','2025-12-16 11:12:45',1,10),(92,12,13,'2025-12-16 12:00:00','2025-12-16 12:08:15',1,10),(93,12,9,'2025-12-17 13:00:00','2025-12-17 13:04:10',0,5),(94,12,10,'2025-12-17 14:00:00','2025-12-17 14:10:30',1,10),(95,13,11,'2026-01-08 09:00:00','2026-01-08 09:24:50',1,15),(96,13,12,'2026-01-08 10:00:00','2026-01-08 10:12:30',0,13),(97,13,13,'2026-01-09 11:00:00','2026-01-09 11:28:05',1,15),(98,13,9,'2026-01-09 12:00:00','2026-01-09 12:09:40',0,2),(99,13,10,'2026-01-10 13:00:00','2026-01-10 13:31:15',1,15),(100,13,11,'2026-01-10 14:00:00','2026-01-10 14:18:25',1,15),(114,14,10,'2026-01-27 20:25:43','2026-01-27 20:26:02',1,4),(115,14,10,'2026-01-27 20:26:29','2026-01-27 20:26:31',0,0),(116,14,10,'2026-01-27 20:26:37','2026-01-27 20:26:49',0,2),(117,14,10,'2026-01-27 20:41:00','2026-01-27 20:41:00',0,0),(118,14,10,'2026-01-27 20:19:06','2026-01-27 20:41:23',1,4),(119,14,5,'2026-01-27 20:45:56','2026-01-27 20:46:22',1,4),(120,14,5,'2026-01-27 20:46:51','2026-01-27 20:47:07',1,4),(121,9,5,'2026-01-27 20:48:44','2026-01-27 20:50:44',1,12),(122,14,14,'2026-01-27 20:59:31','2026-01-27 20:59:48',1,4),(123,14,5,'2026-01-27 22:54:38','2026-01-27 22:54:40',0,0),(124,14,5,'2026-01-27 22:55:43','2026-01-27 22:55:43',0,0),(125,1,5,'2026-01-27 23:03:18','2026-01-27 23:03:18',0,0),(126,4,5,'2026-01-28 00:42:31','2026-01-28 00:42:31',0,0),(127,2,5,'2026-01-28 00:46:09','2026-01-28 00:47:03',0,4),(128,3,5,'2026-01-28 00:49:56','2026-01-28 00:50:19',0,1);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quizID` int NOT NULL,
  `questionNr` int NOT NULL,
  `question` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `answerA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `answerB` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `answerC` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `answerD` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `correctAnswer` enum('a','b','c','d') CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questions_quizID_FK_idx` (`quizID`),
  CONSTRAINT `questions_quizID_FK` FOREIGN KEY (`quizID`) REFERENCES `quizes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,1,'W którym roku powstała Politechnika Łódzka?','1939','1945','1955','1968','b'),(2,1,2,'Kto był pierwszym rektorem PŁ?','Bohdan Stefanowski','Tadeusz Kotarbiński','Jan Czochralski','Gabriel Narutowicz','a'),(3,1,3,'Ile wydziałów posiada obecnie PŁ?','7','9','12','15','b'),(4,1,4,'Jakie zwierzę znajduje się w dawnym logo PŁ?','Orzeł','Lew','Gryf','Sokół','b'),(5,1,5,'Gdzie znajduje się rektorat PŁ?','Willa Reinholda Richtera','Fabryka Geyera','Centrum Technologii','Zatoka Sportu','a'),(6,1,6,'Patronem Biblioteki Głównej PŁ jest:','Jan Paweł II','Stanisław Lem','Jan Czochralski','Maria Skłodowska-Curie','c'),(7,1,7,'Jak nazywa się kampus PŁ?','Kampus A','Kampus B','Obydwa','Kampus Centralny','c'),(8,1,8,'Który budynek jest najwyższy na kampusie?','Rektorat','Wydział Budownictwa','DS1','Alchemium','b'),(9,1,9,'Skrót IFE oznacza:','Instytut Fizyki Eksperymentalnej','International Faculty of Engineering','Informatyka dla Ekonomii','Interdyscyplinarne Forum Edukacji','b'),(10,1,10,'Kolor dominujący w identyfikacji PŁ to:','Zielony','Granatowy','Czerwony','Bordowy','d'),(11,2,1,'Ile punktów ECTS trzeba zdobyć, aby zaliczyć semestr?','20','25','30','35','c'),(12,2,2,'Co oznacza skrót IOS?','Indywidualna Organizacja Studiów','Internetowy Obszar Studenta','Inżynieria Oprogramowania Systemowego','Instytut Ochrony Środowiska','a'),(13,2,3,'Kiedy następuje skreślenie z listy studentów?','Po 1 niezaliczeniu','Brak opłaty i postępów','Po spóźnieniu na zajęcia','Brak legitymacji','b'),(14,2,4,'Jaka jest najwyższa ocena na studiach?','6.0','5.5','5.0','4.5','c'),(15,2,5,'Ile wynosi dług deficytowy punktów ECTS (zazwyczaj)?','6','12','15','18','b'),(16,2,6,'Kto przyznaje urlop dziekański?','Rektor','Dziekan','Prodziekan ds. studenckich','Starosta','c'),(17,2,7,'Czy obecność na wykładach jest obowiązkowa wg regulaminu?','Tak, zawsze','Nie, chyba że sylabus stanowi inaczej','Tylko na I roku','Tylko dla starostów','b'),(18,2,8,'Co to jest USOS?','Urząd Spraw Osobistych Studenta','Uniwersytecki System Obsługi Studiów','Uczelniana Sieć Oceniania','Urząd Statystyczny','b'),(19,2,9,'Ile razy można powtarzać ten sam przedmiot?','Nieskończenie wiele','Raz','Zgodnie z regulaminem opłat','Nie można','c'),(20,2,10,'Kiedy sesja poprawkowa?','W lipcu','W sierpniu','We wrześniu','W październiku','c'),(21,2,11,'Kto jest przedstawicielem studentów?','Rektor','Samorząd Studencki','Dziekanat','Kwestura','b'),(22,2,12,'Legitymacja jest ważna do:','30 września / 31 marca','1 stycznia / 1 czerwca','Cały rok','Do końca studiów','a'),(23,3,1,'Gdzie znajduje się Zatoka Sportu?','Kampus A','Kampus B','Poza kampusem','Przy akademiku nr 1','b'),(24,3,2,'Aleja Politechniki oddziela:','Kampus A od B','Kampus B od C','Rektorat od Biblioteki','Nie oddziela niczego','a'),(25,3,3,'Lodex to budynek wydziału:','Mechanicznego','EEIA','Chemicznego','BAIŚ','d'),(26,3,4,'Trzy Wydziały (B9) to siedziba:','Fizyki, Chemii, Matematyki','Mechanicznego, EEIA, Fizyki','EEIA, FTIMS, Chemicznego','Zarządzania','b'),(27,3,5,'W którym DS mieści się Bratniak?','DS 1','DS 3','DS 8','DS 10','a'),(28,3,6,'Klub studencki na osiedlu to:','Futurysta','Cotton','Siódemki','Spinka','a'),(29,3,7,'Audytorium Sołtana znajduje się na:','Wydziale Chemicznym','Wydziale Mechanicznym','Wydziale EEIA','Wydziale Binoż','c'),(30,3,8,'Gdzie jest stołówka?','Budynek A10','Zatoka Sportu','Lodex','Willa Richtera','a'),(31,3,9,'Park im. Klepacza słynie z:','Róż','Tulipanów','Cebulic syberyjskich','Dębów','c'),(32,3,10,'Fabryka Inżynierów XXI wieku to budynek:','A1','A10','A18','B19','c'),(55,6,1,'Co oznacza UX?','User Xylophone','User Experience','Unit X','Under X','b'),(56,6,2,'Co oznacza UI?','User Interface','User Interia','Unit Integer','Under Ice','a'),(57,6,3,'Który element nie jest częścią UX?','Badania','Prototypowanie','Kodowanie backendu','Testy','c'),(58,6,4,'Co to jest Wireframe?','Szkic układu strony','Gotowy projekt graficzny','Kod HTML','Baza danych','a'),(59,6,5,'Persona w UX to:','Osoba decyzyjna','Przykładowy profil użytkownika','Programista','Szef projektu','b'),(60,6,6,'Mapa cieplna (Heatmap) pokazuje:','Temperaturę CPU','Gdzie patrzą/klikają użytkownicy','Kolory strony','Błędy w kodzie','b'),(61,6,7,'Kolor czerwony w UI zwykle oznacza:','Sukces','Błąd/Uwaga','Informację','Neutralność','b'),(62,6,8,'Co to jest \"Call to Action\" (CTA)?','Numer telefonu','Przycisk wzywający do działania','Reklamacja','Kod błędu','b'),(63,6,9,'Responsive Web Design (RWD) to:','Strona na mobile','Strona szybka','Strona dopasowująca się do ekranu','Strona w React','c'),(64,6,10,'Prawo Fittsa dotyczy:','Kolorów','Wielkości i odległości celu','Czasu ładowania','Czytelności','b'),(65,7,1,'Ile jest heurystyk Nielsena?','5','8','10','12','c'),(66,7,2,'Heurystyka 1: Pokazywanie statusu systemu oznacza:','User wie co się dzieje','System jest szybki','System jest ładny','Brak błędów','a'),(67,7,3,'Heurystyka 2: Dopasowanie do świata rzeczywistego to:','Używanie żargonu','Używanie języka użytkownika','Wirtualna Rzeczywistość','Mapy Google','b'),(68,7,4,'Przycisk \"Cofnij\" realizuje heurystykę:','Kontrola użytkownika','Estetyka','Pomoc','Spójność','a'),(69,7,5,'Spójność i standardy (H4) oznacza:','Zawsze inne ikony','Te same działania znaczą to samo','Różne kolory','Nowoczesność','b'),(70,7,6,'Zapobieganie błędom jest lepsze niż:','Dobre komunikaty błędów','Szybka pomoc','Ładny wygląd','Tanie oprogramowanie','a'),(71,7,7,'Rozpoznawanie zamiast przypominania dotyczy:','Pamięci RAM','Obciążenia poznawczego','Szybkości łącza','Dysku twardego','b'),(72,7,8,'Elastyczność i efektywność użycia (H7) promuje:','Skróty klawiszowe','Tylko myszkę','Wolne działanie','Duże czcionki','a'),(73,7,9,'Estetyka i minimalizm (H8) mówi:','Im więcej tym lepiej','Nie zawierać nieistotnych informacji','Kolorowe tła','Dużo animacji','b'),(74,7,10,'Pomoc w rozpoznawaniu błędów (H9) wymaga:','Kodu błędu 0x001','Jasnego komunikatu językowego','Braku komunikatu','Restartu','b'),(75,7,11,'Pomoc i dokumentacja (H10) powinna być:','Długa','Łatwa do przeszukania','Ukryta','Płatna','b'),(76,7,12,'Kto opracował te heurystyki?','Steve Jobs','Jakob Nielsen','Bill Gates','Alan Turing','b'),(77,7,13,'Kiedy stosujemy analizę heurystyczną?','Tylko na końcu','Na etapie prototypu i projektu','Po wdrożeniu','Nigdy','b'),(78,7,14,'Czy heurystyki to prawo?','Tak','Nie, to wskazówki','To ustawa UE','To norma ISO','b'),(79,7,15,'Ewaluacja heurystyczna wymaga udziału:','Użytkowników','Ekspertów','Serwerów','Managerów','b'),(80,8,1,'Co oznacza WCAG?','Web Content Accessibility Guidelines','World Computer Association Group','Web Coding And Gaming','Wireless Connection Access Gateway','a'),(81,8,2,'Ile jest zasad (filrów) WCAG?','2','3','4','5','c'),(82,8,3,'Zasada POUR to:','Perceivable, Operable, Understandable, Robust','Play, Open, Use, Run','Print, Output, User, Read','Public, Open, Universal, Real','a'),(83,8,4,'Tekst alternatywny (alt) służy:','Dla ozdoby','Dla czytników ekranowych','Dla pozycjonowania','Dla szybkości','b'),(84,8,5,'Kontrast tekstu dla poziomu AA powinien wynosić:','1:1','3:1','4.5:1','10:1','c'),(85,8,6,'Poziomy zgodności WCAG to:','1, 2, 3','A, B, C','A, AA, AAA','X, Y, Z','c'),(86,8,7,'Napisy w filmach są dla:','Niesłyszących','Obcokrajowców','Osób w głośnym otoczeniu','Wszystkich wymienionych','d'),(87,8,8,'Fokus klawiatury powinien być:','Niewidoczny','Widoczny','Migający na czerwono','Brak wymogu','b'),(88,8,9,'Kierowca samochodu używający nawigacji głosowej to przykład niepełnosprawności:','Trwałej','Tymczasowej','Sytuacyjnej','Brak niepełnosprawności','c'),(89,8,10,'Linki typu \"Kliknij tutaj\" są:','Zalecane','Niezalecane (niejasne)','Wymagane','Obojętne','b'),(90,8,11,'Captcha powinna mieć alternatywę:','Graficzną','Audio','Tekstową','Nie musi','b'),(91,8,12,'Dostępność cyfrowa jest wymagana prawnie dla:','Instytucji publicznych','Blogów prywatnych','Gier','Chatów','a'),(92,9,1,'Komenda do pobierania danych to:','GET','FETCH','SELECT','TAKE','c'),(93,9,2,'Aby usunąć rekordy używamy:','REMOVE','DELETE','ERASE','DROP','b'),(94,9,3,'DROP TABLE służy do:','Usuwania danych','Usuwania struktury tabeli','Ukrywania tabeli','Zmiany nazwy','b'),(95,9,4,'Klauzula filtrująca wyniki to:','IF','FILTER','WHERE','WHEN','c'),(96,9,5,'Aby połączyć dwie tabele używamy:','LINK','MERGE','JOIN','CONNECT','c'),(97,9,6,'Klucz główny to:','PRIMARY KEY','MAIN KEY','UNIQUE ID','MASTER KEY','a'),(98,9,7,'Funkcja zliczająca wiersze to:','SUM()','TOTAL()','COUNT()','ADD()','c'),(99,9,8,'Znak wieloznaczny w SQL (wildcard) to:','*','#','&','$','a'),(100,9,9,'Sortowanie wyników odbywa się przez:','SORT BY','ORDER BY','ARRANGE','GROUP BY','b'),(101,9,10,'Wstawianie danych to:','ADD INTO','INSERT INTO','PUT INTO','CREATE ROW','b'),(102,9,11,'Wartość pusta w bazie to:','0','EMPTY','NULL','BLANK','c'),(103,9,12,'Unikalność wartości zapewnia:','DISTINCT','ONLY','SINGLE','ONE','a'),(104,10,1,'Proces organizacji danych w celu redukcji redundancji to:','Normalizacja','Optymalizacja','Indeksowanie','Kompilacja','a'),(105,10,2,'1NF wymaga:','Brak powtarzających się grup','Kluczy obcych','Relacji wiele-do-wielu','Braku NULL','a'),(106,10,3,'Wartości w kolumnie w 1NF muszą być:','Atomowe','Złożone','Listami','Obiektami','a'),(107,10,4,'2NF dotyczy zależności:','Funkcyjnej pełnej','Przechodniej','Wielowartościowej','Zwrotnej','a'),(108,10,5,'3NF usuwa zależności:','Przechodnie','Bezpośrednie','Częściowe','Trywialne','a'),(109,10,6,'Anomalia wstawiania polega na:','Niemożności dodania danych bez innych danych','Błędzie dysku','Wolnym działaniu','Duplikacji','a'),(110,10,7,'BCNF to:','Silniejsza wersja 3NF','Słabsza wersja 1NF','To samo co 2NF','Baza NoSQL','a'),(111,10,8,'Redundancja danych prowadzi do:','Niespójności','Szybszego działania','Mniejszego rozmiaru bazy','Lepszego bezpieczeństwa','a'),(112,10,9,'Relacja wiele-do-wielu wymaga:','Tabeli łącznikowej','Jednej tabeli','Klucza obcego w obu','Nie da się zrobić','a'),(113,10,10,'Klucz obcy (FK) wskazuje na:','Klucz główny innej tabeli','Dowolną kolumnę','Samego siebie','Nic','a'),(114,10,11,'Denormalizacja to:','Celowe wprowadzanie redundancji','Naprawa bazy','Usuwanie tabel','Błąd','a'),(115,10,12,'Kiedy stosujemy denormalizację?','Dla wydajności odczytu','Z lenistwa','Zawsze','Nigdy','a'),(116,10,13,'Zależność trywialna to:','A -> A','A -> B','A -> BC','AB -> C','a'),(117,10,14,'ACID dotyczy:','Transakcji','Normalizacji','Indeksów','Widoków','a'),(118,10,15,'Postać normalna 4NF dotyczy:','Zależności wielowartościowych','Zależności złączeniowych','Zależności funkcyjnych','Zależności czasowych','a'),(119,11,1,'CPU to:','Central Processing Unit','Computer Power Unit','Control Panel Unit','Central Port Unit','a'),(120,11,2,'Architektura von Neumanna ma:','Wspólną pamięć danych i kodu','Rozdzielną pamięć','Brak pamięci','Tylko rejestry','a'),(121,11,3,'Architektura harwardzka ma:','Rozdzielną pamięć danych i kodu','Wspólną pamięć','Tylko ROM','Tylko RAM','a'),(122,11,4,'Rejestr PC (Program Counter) przechowuje:','Adres następnej instrukcji','Wynik obliczeń','Stan flag','Adres stosu','a'),(123,11,5,'ALU wykonuje operacje:','Arytmetyczno-logiczne','Tylko zapisu','Tylko skoków','Graficzne','a'),(124,11,6,'Przerwanie (Interrupt) to:','Sygnał przerywający działanie programu','Błąd procesora','Wyłączenie zasilania','Koniec pętli','a'),(125,11,7,'Stos (Stack) działa w trybie:','LIFO','FIFO','LILO','RANDO','a'),(126,11,8,'Magistrala danych służy do:','Przesyłania danych','Zasilania','Zegara','Resetowania','a'),(127,11,9,'RISC oznacza:','Reduced Instruction Set Computer','Rapid Instruction','Real Intel System','Random Instruction','a'),(128,11,10,'CISC oznacza:','Complex Instruction Set Computer','Complete Intel','Computer Instruction','Common Interface','a'),(129,11,11,'GPIO to:','General Purpose Input Output','Global Position','General Processor','Graphic Port','a'),(130,11,12,'Watchdog Timer służy do:','Resetowania systemu przy zawieszeniu','Mierzenia czasu rzeczywistego','Budzenia procesora','Liczenia impulsów','a'),(131,12,1,'Standardowe napięcie Arduino Uno to:','5V','12V','24V','230V','a'),(132,12,2,'Funkcja setup() uruchamia się:','Raz po starcie','W pętli','Po każdym kliknięciu','Losowo','a'),(133,12,3,'Funkcja loop() uruchamia się:','Cyklicznie w nieskończoność','Raz','Tylko rano','Po błędzie','a'),(134,12,4,'digitalWrite(pin, HIGH) ustawia:','5V (logiczna 1)','0V (GND)','2.5V','Wejście','a'),(135,12,5,'ADC służy do:','Zamiany analog->cyfra','Zamiany cyfra->analog','Wzmacniania','Zasilania','a'),(136,12,6,'PWM pozwala na:','Symulację napięcia analogowego','Szybsze liczenie','Zwiększenie RAM','Lepsze WiFi','a'),(137,12,7,'Serial.begin(9600) ustawia:','Prędkość transmisji','Hasło','Pin','Zegar','a'),(138,12,8,'Biblioteka do serwomechanizmów to:','Servo.h','Motor.h','Move.h','Robot.h','a'),(139,12,9,'Pin oznaczony tyldą (~) obsługuje:','PWM','Tylko wejście','Tylko wyjście','Wysokie napięcie','a'),(140,12,10,'Bootloader pozwala na:','Wgrywanie programu przez USB','Szybsze działanie','Więcej pamięci','Lepszą grafikę','a'),(141,13,1,'RTOS to:','Real-Time Operating System','Run Time OS','Robot TOS','Rare Time OS','a'),(142,13,2,'Główna cecha RTOS to:','Determinizm czasowy','Ładny interfejs','Obsługa myszki','Duża baza danych','a'),(143,13,3,'Scheduler (planista) decyduje o:','Kolejności zadań','Kolorach','Zasilaniu','Pamięci','a'),(144,13,4,'Wyłaszczanie (Preemption) to:','Przerwanie zadania przez ważniejsze','Zakończenie programu','Błąd pamięci','Zapis na dysk','a'),(145,13,5,'Mutex służy do:','Synchronizacji dostępu do zasobu','Mierzenia czasu','Komunikacji sieciowej','Liczenia','a'),(146,13,6,'Semafor binarny ma wartości:','0 i 1','0 do 100','-1 do 1','Dowolne','a'),(147,13,7,'Deadlock to:','Zakleszczenie zadań','Martwa strefa','Koniec pamięci','Awaria zasilania','a'),(148,13,8,'Context Switch to:','Przełączenie między zadaniami','Zmiana zmiennej','Zmiana ekranu','Restart','a'),(149,13,9,'Priorytet zadania określa:','Jego ważność','Jego rozmiar','Jego autora','Jego czas trwania','a'),(150,13,10,'Problem inwersji priorytetów rozwiązuje:','Dziedziczenie priorytetów','Reset','Więcej RAM','Szybszy zegar','a'),(151,13,11,'Jitter to:','Zmienność opóźnienia','Szybkość','Błąd logiczny','Nazwa rejestru','a'),(152,13,12,'Zadanie w stanie BLOCKED czeka na:','Zdarzenie lub zasób','Procesor','Użytkownika','Nic','a'),(153,13,13,'Round Robin to algorytm:','Szeregowania cyklicznego','Szyfrowania','Kompresji','Sortowania','a'),(154,13,14,'Hard Real-Time oznacza:','Absolutny wymóg dotrzymania czasu','Trudne zadania','Sprzętowy zegar','Twardy dysk','a'),(155,13,15,'Soft Real-Time oznacza:','Przekroczenie czasu obniża jakość, ale nie jest krytyczne','Oprogramowanie','Miękki reset','Łatwe zadania','a'),(207,4,1,'Co oznacza skrót EEIA?','Elektronika, Energetyka...','Elektrotechnika, Elektronika, Informatyka, Automatyka','Elektryka, Ekologia...','Edukacja Elektroniczna...','b'),(208,4,2,'Siedziba dziekanatu EEIA to budynek:','A10','A18','A12','B9','a'),(209,4,3,'Katedra Mikroelektroniki i Technik Informatycznych to:','K-25','I-12','I-24','K-11','a'),(210,4,4,'Instytut Informatyki Stosowanej to:','I-12','I-24','K-25','I-32','b'),(211,4,5,'Ile kierunków studiów oferuje EEIA?','3','5','8','Ponad 10','d'),(212,4,6,'Kto jest Dziekanem Wydziału (2025)?','Prof. J. Zieliński','Dr A. Kowalski','Prof. M. Szymański','Informacja na stronie','d'),(213,4,7,'Kolor Wydziału EEIA to:','Niebieski','Żółty','Czarny','Fioletowy','a'),(214,4,8,'Gdzie odbywają się laboratoria wysokich napięć?','A5','A10','A18','D1','a'),(215,4,9,'Wydziałowa Rada Samorządu to:','WRS','URSS','NZS','BEST','a'),(216,4,10,'Czy EEIA ma własną bibliotekę?','Tak','Nie','Tylko online','W remoncie','a'),(287,5,1,'Kiedy zgłasza się temat pracy inżynierskiej?','Na 1 roku','Na 6 semestrze','Po obronie','W wakacje','b'),(288,5,2,'Ile egzemplarzy pracy składamy w dziekanacie?','0 (tylko ASAP)','1','2','3','a'),(289,5,3,'System antyplagiatowy to:','JSA','OSA','KIR','CBA','a'),(290,5,4,'Ile trwa prezentacja na obronie?','5 min','10-15 min','30 min','1 godzina','b'),(291,5,5,'Kto jest recenzentem pracy?','Promotor','Dowolny doktor','Osoba wyznaczona z tytułem min. dr','Student','c'),(292,5,6,'Czym jest karta obiegowa?','Kartą płatniczą','Dokumentem rozliczenia z uczelnią','Biletem wstępu','Kartą biblioteczną','b'),(293,5,7,'Kiedy otrzymuje się dyplom?','Od razu po obronie','W ciągu 30 dni','Po roku','Nigdy','b'),(294,5,8,'Co to jest suplemet do dyplomu?','Dodatkowa opłata','Wykaz ocen i przedmiotów','Zdjęcie','Okładka','b'),(295,5,9,'Czy praca musi być w jęz. angielskim?','Tak','Nie, zależy od kierunku','Tylko streszczenie','Nie wolno','b'),(296,5,10,'Minimalna ocena pozytywna pracy to:','2.0','3.0','3.5','4.0','b'),(297,5,11,'Kto zatwierdza temat pracy?','Prodziekan ds. kształcenia','Rektor','Portier','Starosta','a'),(298,5,12,'Czy na obronie są pytania z toku studiów?','Tak, losowane','Nie','Tylko z pracy','Zależy od pogody','a'),(303,17,1,'TIM6','No jest','co to','heh','...','a'),(304,17,2,'Przerwania systemowe?','Tak','Nie','Tak, ale...','Nie, ale...','a'),(323,14,1,'Kiedy rozpoczyna się rok akademicki w Polsce?','1 stycznia','1 września','1 października','1 listopada','c'),(324,14,2,'Co oznacza skrót ECTS?','Europejski System Transferu Punktów','Elektroniczne Centrum Transferu Studentów','Europejskie Centrum Technologii Stosowanych','Egzamin Centralny Techniczny Studentów','a'),(325,14,3,'Ile semestrów zazwyczaj trwają studia inżynierskie I stopnia?','3','5','7-8','10','c'),(326,14,4,'Pytanie testowe','a','B','c','d','b');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizes`
--

DROP TABLE IF EXISTS `quizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `classID` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `questionsCount` smallint unsigned NOT NULL,
  `difficulty` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quizes_classID_FK_idx` (`classID`),
  CONSTRAINT `quizes_classID_FK` FOREIGN KEY (`classID`) REFERENCES `classes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizes`
--

LOCK TABLES `quizes` WRITE;
/*!40000 ALTER TABLE `quizes` DISABLE KEYS */;
INSERT INTO `quizes` VALUES (1,1,'Historia i struktura PŁ',10,'easy'),(2,1,'Regulamin studiów - Prawa i obowiązki studenta',12,'medium'),(3,1,'Kampus PŁ - Topografia i budynki',10,'easy'),(4,2,'Władze i Instytuty Wydziału EEIA',10,'medium'),(5,2,'Procedury dyplomowania na EEIA',12,'hard'),(6,3,'Wprowadzenie do UX i UI Design',10,'easy'),(7,3,'Heurystyki użyteczności Nielsena',15,'hard'),(8,3,'Dostępność cyfrowa (WCAG)',12,'medium'),(9,4,'Podstawy języka SQL - SELECT i JOIN',12,'medium'),(10,4,'Normalizacja i relacje',15,'hard'),(11,5,'Architektura mikrokontrolerów',12,'medium'),(12,5,'Arduino - Wstęp do prototypowania',10,'easy'),(13,5,'Przerwania i systemy czasu rzeczywistego',15,'hard'),(14,1,'Szybki test wiedzy o rekrutacji',4,'easy'),(17,5,'STM32',2,'hard');
/*!40000 ALTER TABLE `quizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `firstName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `lastName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci NOT NULL,
  `isLecturer` tinyint NOT NULL,
  `imgName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci DEFAULT 'person.jpg',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'adakow','adam.kowalski@p.lodz.pl','dr inż.','Adam','Kowalski',1,'adakow.jpg'),(2,'ewanow','ewa.nowak@p.lodz.pl','mgr','Ewa','Nowak',1,'ewanow.jpg'),(3,'janzie','janusz.zielinski@p.lodz.pl','prof. dr hab.','Janusz','Zieliński',1,'janzie.jpg'),(4,'marwis','maria.wisniewska@p.lodz.pl','dr','Maria','Wiśniewska',1,'no-picture2.png'),(5,'250012','250012@edu.p.lodz.pl',NULL,'Piotr','Wójcik',0,'250012.jpg'),(6,'250145','250145@edu.p.lodz.pl',NULL,'Anna','Kamińska',0,'no-picture2.png'),(7,'250567','250567@edu.p.lodz.pl',NULL,'Tomasz','Lewandowski',0,'250567.jpg'),(8,'250999','250999@edu.p.lodz.pl',NULL,'Julia','Zielińska',0,'no-picture2.png'),(9,'251001','251001@edu.p.lodz.pl',NULL,'Michał','Szymański',0,'251001.jpg'),(10,'251230','251230@edu.p.lodz.pl',NULL,'Karolina','Dąbrowska',0,'no-picture2.png'),(11,'251555','251555@edu.p.lodz.pl',NULL,'Paweł','Kozłowski',0,'251555.jpg'),(12,'251888','251888@edu.p.lodz.pl',NULL,'Aleksandra','Jankowska',0,'no-picture2.png'),(13,'252100','252100@edu.p.lodz.pl',NULL,'Krzysztof','Mazur',0,'no-picture1.png'),(14,'252450','252450@edu.p.lodz.pl',NULL,'Zuzanna','Wojciechowska',0,'no-picture2.png'),(15,'252890','252890@edu.p.lodz.pl',NULL,'Kacper','Kwiatkowski',0,'252890.jpg'),(16,'252995','252995@edu.p.lodz.pl',NULL,'Maja','Krawczyk',0,'no-picture2.png'),(17,'252996','252996@edu.p.lodz.pl',NULL,'Robert','Makłowicz',0,'252996.jpg'),(18,'252997','252997@edu.p.lodz.pl',NULL,'Sanah','Jurczak',0,'no-picture2.png'),(19,'252998','252998@edu.p.lodz.pl',NULL,'Dawid','Podsiadło',0,'no-picture1.png');
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

-- Dump completed on 2026-01-28  1:31:44
