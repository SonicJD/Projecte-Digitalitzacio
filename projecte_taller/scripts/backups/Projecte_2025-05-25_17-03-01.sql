/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Projecte
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `accessoris`
--

DROP TABLE IF EXISTS `accessoris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accessoris` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(50) NOT NULL,
  `any_fabricacio` int(11) NOT NULL,
  `preu` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessoris`
--

LOCK TABLES `accessoris` WRITE;
/*!40000 ALTER TABLE `accessoris` DISABLE KEYS */;
INSERT INTO `accessoris` VALUES
(1,'Retroid Official Dock',2024,49.99),
(2,'Retroid Official Grip for RP4/4Pro',2023,29.99),
(3,'Retroid Pocket 5 Protector Shell',2023,19.99),
(4,'ANBERNIC handle silicone sleeve for RG405M',2024,14.99),
(5,'ANBERNIC RG350/RG350M/RG350P',2022,24.99),
(6,'ANBERNIC RG35XXSP',2024,34.99),
(7,'Odin 2 Super Dock',2024,49.99),
(8,'Odin2 Mini 65w Charger',2024,39.99),
(9,'Odin2 Portal ABXY(NS Layout)',2024,19.99);
/*!40000 ALTER TABLE `accessoris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `DNI` char(9) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `telefon` varchar(20) NOT NULL,
  `correu` varchar(100) NOT NULL,
  PRIMARY KEY (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES
('01234567J','Oriol Mora','602345678','oriol.mora@example.com'),
('12345678A','Anna Puig','612345678','anna.puig@example.com'),
('20569996S','Biel Duran','682140523','bielduranlaroca@gmail.com'),
('23456789B','Marc Garcia','622345678','marc.garcia@example.com'),
('34567890C','Laura Vidal','632345678','laura.vidal@example.com'),
('45678901D','Pere Soler','642345678','pere.soler@example.com'),
('56789012E','Marta Roca','652345678','marta.roca@example.com'),
('67890123F','Joan Ferrer','662345678','joan.ferrer@example.com'),
('78901234G','Clara Serra','672345678','clara.serra@example.com'),
('89012345H','David Pons','682345678','david.pons@example.com'),
('90123456I','Núria Bosch','692345678','nuria.bosch@example.com');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consoles`
--

DROP TABLE IF EXISTS `consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(50) NOT NULL,
  `any_fabricacio` int(11) NOT NULL,
  `preu` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consoles`
--

LOCK TABLES `consoles` WRITE;
/*!40000 ALTER TABLE `consoles` DISABLE KEYS */;
INSERT INTO `consoles` VALUES
(1,'Retroid Pocket Flip 2 Handheld',2024,289.99),
(2,'Retroid Pocket Classic Handheld',2023,149.99),
(3,'Retroid Pocket 4/4Pro Handheld',2023,199.99),
(4,'ANBERNIC RG 557',2024,359.99),
(5,'ANBERNIC RG 40XXV',2024,399.99),
(6,'ANBERNIC RG 34XX',2023,449.99),
(7,'Odin2 Portal',2024,219.99),
(8,'Odin 2',2024,149.99),
(9,'Odin2 Mini',2024,99.99);
/*!40000 ALTER TABLE `consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factures`
--

DROP TABLE IF EXISTS `factures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `factures` (
  `numFactura` varchar(20) NOT NULL,
  `client_DNI` char(9) NOT NULL,
  `id_consoles` int(11) NOT NULL,
  `id_accessoris` int(11) NOT NULL,
  `data_factura` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numFactura`),
  KEY `client_DNI` (`client_DNI`),
  KEY `id_consoles` (`id_consoles`),
  KEY `id_accessoris` (`id_accessoris`),
  CONSTRAINT `factures_ibfk_1` FOREIGN KEY (`client_DNI`) REFERENCES `clients` (`DNI`),
  CONSTRAINT `factures_ibfk_2` FOREIGN KEY (`id_consoles`) REFERENCES `consoles` (`id`),
  CONSTRAINT `factures_ibfk_3` FOREIGN KEY (`id_accessoris`) REFERENCES `accessoris` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factures`
--

LOCK TABLES `factures` WRITE;
/*!40000 ALTER TABLE `factures` DISABLE KEYS */;
INSERT INTO `factures` VALUES
('F001','12345678A',1,1,'2025-04-01',289.99),
('F002','23456789B',2,1,'2025-04-02',149.99),
('F003','34567890C',1,2,'2025-04-03',199.99),
('F004','45678901D',3,1,'2025-04-04',359.99),
('F005','56789012E',2,2,'2025-04-05',99.99),
('F006','67890123F',3,3,'2025-04-06',399.99),
('F007','78901234G',1,3,'2025-04-07',49.99),
('F008','89012345H',2,1,'2025-04-08',449.99),
('F009','90123456I',1,2,'2025-04-09',219.99),
('F010','01234567J',3,2,'2025-04-10',149.99);
/*!40000 ALTER TABLE `factures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencies`
--

DROP TABLE IF EXISTS `incidencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consola_id` int(11) DEFAULT NULL,
  `id_accessoris` int(11) DEFAULT NULL,
  `client_DNI` char(9) NOT NULL,
  `data_incidencia` timestamp NOT NULL,
  `servei_solicitat` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `consola_id` (`consola_id`),
  KEY `id_accessoris` (`id_accessoris`),
  KEY `client_DNI` (`client_DNI`),
  CONSTRAINT `incidencies_ibfk_1` FOREIGN KEY (`consola_id`) REFERENCES `consoles` (`id`),
  CONSTRAINT `incidencies_ibfk_2` FOREIGN KEY (`id_accessoris`) REFERENCES `accessoris` (`id`),
  CONSTRAINT `incidencies_ibfk_3` FOREIGN KEY (`client_DNI`) REFERENCES `clients` (`DNI`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencies`
--

LOCK TABLES `incidencies` WRITE;
/*!40000 ALTER TABLE `incidencies` DISABLE KEYS */;
INSERT INTO `incidencies` VALUES
(1,3,3,'12345678A','2025-05-29 12:00:00','a'),
(2,2,3,'20569996S','2025-05-29 12:00:00','a'),
(3,2,3,'12345678A','2025-05-30 12:00:00','a'),
(4,2,3,'12345678A','2025-05-30 12:00:00','a'),
(5,2,NULL,'12345678A','2025-05-30 12:00:00','a'),
(6,1,NULL,'12345678A','2025-05-28 12:00:00','a'),
(7,NULL,3,'12345678A','2025-05-28 12:00:00','a'),
(8,7,3,'12345678A','2025-05-28 12:00:00','a');
/*!40000 ALTER TABLE `incidencies` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-05-25 17:03:01
