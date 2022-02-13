CREATE DATABASE  IF NOT EXISTS `HouseRental` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `HouseRental`;
-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: HouseRental
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `HouseRating`
--

DROP TABLE IF EXISTS `HouseRating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HouseRating` (
  `idHouseRating` int NOT NULL AUTO_INCREMENT,
  `Rating` double NOT NULL,
  `NoOfRatings` int NOT NULL,
  `HouseNumberRating` varchar(30) NOT NULL,
  PRIMARY KEY (`idHouseRating`),
  KEY `HouseNumberRating_idx` (`HouseNumberRating`),
  CONSTRAINT `HouseNumberRating` FOREIGN KEY (`HouseNumberRating`) REFERENCES `Houses` (`HouseNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HouseRating`
--

LOCK TABLES `HouseRating` WRITE;
/*!40000 ALTER TABLE `HouseRating` DISABLE KEYS */;
/*!40000 ALTER TABLE `HouseRating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Houses`
--

DROP TABLE IF EXISTS `Houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Houses` (
  `HouseNo` varchar(30) NOT NULL,
  `Location` varchar(45) NOT NULL,
  `PricePerHour` int NOT NULL,
  `Owner` int NOT NULL,
  `DateAdded` datetime NOT NULL,
  `Availibility` int DEFAULT NULL,
  PRIMARY KEY (`HouseNo`),
  KEY `OwnerForeign_idx` (`Owner`),
  CONSTRAINT `OwnerForeign` FOREIGN KEY (`Owner`) REFERENCES `Landlord` (`idLandlord`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Houses`
--

LOCK TABLES `Houses` WRITE;
/*!40000 ALTER TABLE `Houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `Houses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HousingImages`
--

DROP TABLE IF EXISTS `HousingImages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HousingImages` (
  `imageID` int NOT NULL AUTO_INCREMENT,
  `HouseNoID` varchar(30) NOT NULL,
  `ImageUrl` varchar(50) NOT NULL,
  PRIMARY KEY (`imageID`),
  KEY `HouseNumber_idx` (`HouseNoID`),
  CONSTRAINT `HouseNoID` FOREIGN KEY (`HouseNoID`) REFERENCES `Houses` (`HouseNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HousingImages`
--

LOCK TABLES `HousingImages` WRITE;
/*!40000 ALTER TABLE `HousingImages` DISABLE KEYS */;
/*!40000 ALTER TABLE `HousingImages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HousingInfo`
--

DROP TABLE IF EXISTS `HousingInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HousingInfo` (
  `idHousingInfo` int NOT NULL AUTO_INCREMENT,
  `sqArea` int NOT NULL,
  `NoOfBedrooms` int NOT NULL,
  `Legality` varchar(45) NOT NULL,
  `HouseNumber` varchar(30) NOT NULL,
  PRIMARY KEY (`idHousingInfo`),
  KEY `HouseNumber_idx` (`HouseNumber`),
  CONSTRAINT `HouseNumber` FOREIGN KEY (`HouseNumber`) REFERENCES `Houses` (`HouseNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HousingInfo`
--

LOCK TABLES `HousingInfo` WRITE;
/*!40000 ALTER TABLE `HousingInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `HousingInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Landlord`
--

DROP TABLE IF EXISTS `Landlord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Landlord` (
  `idLandlord` int NOT NULL AUTO_INCREMENT,
  `Password` varchar(45) NOT NULL,
  `LandlordRating` int DEFAULT NULL,
  `PersonalInfoLandlord` int NOT NULL,
  PRIMARY KEY (`idLandlord`),
  KEY `PersonalInfoForeign_idx` (`PersonalInfoLandlord`),
  CONSTRAINT `PersonalInfoLandlord` FOREIGN KEY (`PersonalInfoLandlord`) REFERENCES `PersonalInfo` (`idPersonalInfo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Landlord`
--

LOCK TABLES `Landlord` WRITE;
/*!40000 ALTER TABLE `Landlord` DISABLE KEYS */;
/*!40000 ALTER TABLE `Landlord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalInfo`
--

DROP TABLE IF EXISTS `PersonalInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonalInfo` (
  `idPersonalInfo` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `PhoneNumber` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `EmergencyContact` varchar(45) NOT NULL,
  `Location` varchar(45) NOT NULL,
  PRIMARY KEY (`idPersonalInfo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalInfo`
--

LOCK TABLES `PersonalInfo` WRITE;
/*!40000 ALTER TABLE `PersonalInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `PersonalInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RentalRequest`
--

DROP TABLE IF EXISTS `RentalRequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RentalRequest` (
  `idRentalRequest` int NOT NULL AUTO_INCREMENT,
  `Tenant` int NOT NULL,
  `HouseNumberId` varchar(30) NOT NULL,
  PRIMARY KEY (`idRentalRequest`),
  KEY `HouseNumberId_idx` (`HouseNumberId`),
  KEY `TenantForeign_idx` (`Tenant`),
  CONSTRAINT `HouseNumberId` FOREIGN KEY (`HouseNumberId`) REFERENCES `Houses` (`HouseNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TenantForeign` FOREIGN KEY (`Tenant`) REFERENCES `Tenant` (`idTenant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RentalRequest`
--

LOCK TABLES `RentalRequest` WRITE;
/*!40000 ALTER TABLE `RentalRequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `RentalRequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tenant`
--

DROP TABLE IF EXISTS `Tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tenant` (
  `idTenant` int NOT NULL AUTO_INCREMENT,
  `Password` varchar(45) NOT NULL,
  `Rating` int DEFAULT NULL,
  `PersonalInfoTenant` int NOT NULL,
  PRIMARY KEY (`idTenant`),
  KEY `PersonalInfoForeign_idx` (`PersonalInfoTenant`),
  CONSTRAINT `PersonalInfoTenant` FOREIGN KEY (`PersonalInfoTenant`) REFERENCES `PersonalInfo` (`idPersonalInfo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tenant`
--

LOCK TABLES `Tenant` WRITE;
/*!40000 ALTER TABLE `Tenant` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tenant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-14  0:41:02
