-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: online_food
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Address`
--
DROP DATABASE IF EXISTS `online_food`;
CREATE SCHEMA `online_food`;
USE `online_food`;
DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Address` (
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `CUSTOMER_ADDRESS` varchar(30) NOT NULL,
  PRIMARY KEY (`CUSTOMER_PHONE`,`CUSTOMER_ADDRESS`),
  CONSTRAINT `Address_ibfk_1` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,'1-Indira_Nagar'),(2,'2-Indira_Nagar'),(3,'3-Indira_Nagar'),(4,'4-Indira_Nagar'),(5,'5-Indira_Nagar');
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Calls`
--

DROP TABLE IF EXISTS `Calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Calls` (
  `CUSTOMER_CARE_PHONE` int(11) NOT NULL,
  `CUSTOMER_PHONE` int(11) NOT NULL,
  PRIMARY KEY (`CUSTOMER_CARE_PHONE`,`CUSTOMER_PHONE`),
  KEY `CUSTOMER_PHONE` (`CUSTOMER_PHONE`),
  CONSTRAINT `Calls_ibfk_1` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calls`
--

LOCK TABLES `Calls` WRITE;
/*!40000 ALTER TABLE `Calls` DISABLE KEYS */;
INSERT INTO `Calls` VALUES (33,1),(33,3),(33,5);
/*!40000 ALTER TABLE `Calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `PHONE_NO` int(11) NOT NULL,
  `FIRST_NAME` varchar(30) NOT NULL,
  `LAST_NAME` varchar(30) NOT NULL,
  `DOB` date NOT NULL,
  `GENDER` varchar(30) NOT NULL,
  PRIMARY KEY (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'sonu','guru','2000-08-17','Male'),(2,'pushkar','talwalkar','2000-09-19','Male'),(3,'youre','nub','2001-04-23','Female'),(4,'cave','jojo','1999-07-15','Female'),(5,'bhavesh','shukla','2000-08-30','Male');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer1`
--

DROP TABLE IF EXISTS `Customer1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer1` (
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `CUSTOMER_NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`CUSTOMER_PHONE`),
  CONSTRAINT `Customer1_ibfk_1` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer1`
--

LOCK TABLES `Customer1` WRITE;
/*!40000 ALTER TABLE `Customer1` DISABLE KEYS */;
INSERT INTO `Customer1` VALUES (1,'sonu'),(2,'pushkar'),(3,'youre'),(4,'cave'),(5,'bhavesh');
/*!40000 ALTER TABLE `Customer1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Delivery`
--

DROP TABLE IF EXISTS `Delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Delivery` (
  `ORDER_ID` int(11) NOT NULL,
  `CASH_TO_COLLECT` int(11) NOT NULL,
  `CUSTOMER_ADDRESS` varchar(30) NOT NULL,
  `DELIVERY_PHONE` int(11) NOT NULL,
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `REST_ID` int(11) NOT NULL,
  `STATUS` varchar(30) NOT NULL,
  PRIMARY KEY (`ORDER_ID`),
  KEY `CUSTOMER_PHONE` (`CUSTOMER_PHONE`),
  KEY `REST_ID` (`REST_ID`),
  CONSTRAINT `Delivery_ibfk_1` FOREIGN KEY (`ORDER_ID`) REFERENCES `Order` (`ORDER_ID`),
  CONSTRAINT `Delivery_ibfk_2` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`),
  CONSTRAINT `Delivery_ibfk_3` FOREIGN KEY (`REST_ID`) REFERENCES `Restaurant` (`REST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Delivery`
--

LOCK TABLES `Delivery` WRITE;
/*!40000 ALTER TABLE `Delivery` DISABLE KEYS */;
INSERT INTO `Delivery` VALUES (1,500,'101-gachibowli',11,1,1,'no'),(2,100,'102-gachibowli',22,2,2,'no'),(3,120,'103-gachibowli',55,3,3,'no'),(4,0,'104-gachibowli',22,4,2,'no'),(5,0,'105-gachibowli',22,5,3,'no'),(6,0,'101-gachibowli',11,1,1,'no'),(7,0,'102-gachibowli',22,2,1,'no'),(8,0,'103-gachibowli',55,3,2,'no'),(9,100,'104-gachibowli',11,4,2,'no'),(10,0,'105-gachibowli',22,5,2,'no'),(11,0,'101-gachibowli',22,1,2,'no'),(12,250,'102-gachibowli',55,2,1,'no'),(13,250,'103-gachibowli',22,3,1,'no'),(14,30,'104-gachibowli',55,4,3,'no'),(15,0,'105-gachibowli',55,5,3,'no');
/*!40000 ALTER TABLE `Delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Delivery_Boy1`
--

DROP TABLE IF EXISTS `Delivery_Boy1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Delivery_Boy1` (
  `DELIVERY_PHONE` int(11) NOT NULL,
  `DELIVERY_NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`DELIVERY_PHONE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Delivery_Boy1`
--

LOCK TABLES `Delivery_Boy1` WRITE;
/*!40000 ALTER TABLE `Delivery_Boy1` DISABLE KEYS */;
INSERT INTO `Delivery_Boy1` VALUES (11,'aman'),(22,'karan'),(55,'champak');
/*!40000 ALTER TABLE `Delivery_Boy1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dependants`
--

DROP TABLE IF EXISTS `Dependants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dependants` (
  `EID` int(11) NOT NULL,
  `GENDER` varchar(30) NOT NULL,
  `DOB` date NOT NULL,
  `RELATIONSHIP` varchar(30) NOT NULL,
  `DEPENDANT_NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`EID`,`DEPENDANT_NAME`),
  CONSTRAINT `Dependants_ibfk_1` FOREIGN KEY (`EID`) REFERENCES `Employee` (`EID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dependants`
--

LOCK TABLES `Dependants` WRITE;
/*!40000 ALTER TABLE `Dependants` DISABLE KEYS */;
INSERT INTO `Dependants` VALUES (1,'male','2000-01-06','Son','Ravi'),(1,'female','1980-04-06','Wife','sonam'),(2,'male','1940-08-15','father','amit'),(2,'female','1947-08-15','mother','dipti'),(3,'male','2010-11-19','son','harish'),(3,'male','2000-11-13','son','manish'),(4,'female','1950-02-07','mother','asha'),(4,'female','1990-01-05','daughter','disha'),(5,'female','2002-10-19','daughter','roshni'),(5,'female','1982-12-17','wife','ruchi');
/*!40000 ALTER TABLE `Dependants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Does`
--

DROP TABLE IF EXISTS `Does`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Does` (
  `DELIVERY_EMP_ID` int(11) NOT NULL,
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `ORDER_ID` int(11) NOT NULL,
  PRIMARY KEY (`DELIVERY_EMP_ID`,`CUSTOMER_PHONE`,`ORDER_ID`),
  KEY `CUSTOMER_PHONE` (`CUSTOMER_PHONE`),
  KEY `ORDER_ID` (`ORDER_ID`),
  KEY `DELIVERY_EMP_ID` (`DELIVERY_EMP_ID`),
  CONSTRAINT `Does_ibfk_1` FOREIGN KEY (`DELIVERY_EMP_ID`) REFERENCES `Employee` (`EID`),
  CONSTRAINT `Does_ibfk_2` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`),
  CONSTRAINT `Does_ibfk_3` FOREIGN KEY (`ORDER_ID`) REFERENCES `Order` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Does`
--

LOCK TABLES `Does` WRITE;
/*!40000 ALTER TABLE `Does` DISABLE KEYS */;
INSERT INTO `Does` VALUES (1,1,1),(1,1,6),(2,1,11),(2,2,2),(2,2,7),(5,2,12),(2,3,13),(5,3,3),(5,3,8),(1,4,9),(2,4,4),(5,4,14),(2,5,5),(2,5,10),(5,5,15);
/*!40000 ALTER TABLE `Does` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Email`
--

DROP TABLE IF EXISTS `Email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Email` (
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `CUSTOMER_EMAIL` varchar(30) NOT NULL,
  PRIMARY KEY (`CUSTOMER_PHONE`,`CUSTOMER_EMAIL`),
  CONSTRAINT `Email_ibfk_1` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Email`
--

LOCK TABLES `Email` WRITE;
/*!40000 ALTER TABLE `Email` DISABLE KEYS */;
INSERT INTO `Email` VALUES (1,'sonu@gmail.com'),(2,'pushkar@gmail.com'),(3,'youre@gmail.com'),(4,'cave@gmail.com'),(5,'bhavesh@gmail.com');
/*!40000 ALTER TABLE `Email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employee` (
  `EID` int(11) NOT NULL,
  `PHONE_NO` int(11) NOT NULL,
  `FIRST_NAME` varchar(30) NOT NULL,
  `LAST_NAME` varchar(30) NOT NULL,
  `DOB` date NOT NULL,
  `GENDER` varchar(30) NOT NULL,
  `SALARY` int(11) NOT NULL,
  `EMAIL` varchar(30) NOT NULL,
  `JOINING_DATE` date NOT NULL,
  `TYPE` varchar(30) NOT NULL,
  PRIMARY KEY (`EID`),
  UNIQUE KEY `PHONE_NO` (`PHONE_NO`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,11,'aman','sharma','1979-02-09','male',4000,'aman@gmail.com','2010-05-07','Delivery'),(2,22,'karan','gupta','1960-03-04','male',5000,'karan@gmail.com','2005-11-19','Delivery'),(3,33,'harsh','goyal','1977-08-20','male',8000,'harsh@gmail.com','2005-11-19','customer_care'),(4,44,'tushar','verma','1965-03-16','male',9000,'tushar@gmail.com','2005-11-19','developer'),(5,55,'champak','gada','1977-04-11','male',5000,'champak@gmail.com','2005-11-19','Delivery');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feedback`
--

DROP TABLE IF EXISTS `Feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Feedback` (
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `RESTAURANT_NAME` varchar(30) NOT NULL,
  `MESSAGE` varchar(30) NOT NULL,
  `RATINGS_OUT_OF_5` int(11) NOT NULL,
  PRIMARY KEY (`CUSTOMER_PHONE`,`RESTAURANT_NAME`),
  CONSTRAINT `Feedback_ibfk_1` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feedback`
--

LOCK TABLES `Feedback` WRITE;
/*!40000 ALTER TABLE `Feedback` DISABLE KEYS */;
INSERT INTO `Feedback` VALUES (1,'a','avg',4),(1,'b','avg',3),(1,'c','excellent',5),(2,'a','good',4),(2,'b','bad',2),(2,'c','excellent',5),(3,'a','excellent',5),(3,'b','good',4),(3,'c','good',4),(4,'a','good',4),(4,'b','bad',2),(4,'c','good',4),(5,'a','excellent',5),(5,'b','good',4),(5,'c','excellent',5);
/*!40000 ALTER TABLE `Feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Has`
--

DROP TABLE IF EXISTS `Has`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Has` (
  `REST_ID` int(11) NOT NULL,
  `ITEM_ID` int(11) NOT NULL,
  PRIMARY KEY (`REST_ID`,`ITEM_ID`),
  CONSTRAINT `Has_ibfk_1` FOREIGN KEY (`REST_ID`) REFERENCES `Restaurant` (`REST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Has`
--

LOCK TABLES `Has` WRITE;
/*!40000 ALTER TABLE `Has` DISABLE KEYS */;
INSERT INTO `Has` VALUES (1,1),(1,2),(2,1),(2,2),(3,1),(3,2);
/*!40000 ALTER TABLE `Has` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Item` (
  `REST_ID` int(11) NOT NULL,
  `ITEM_ID` int(11) NOT NULL,
  `ITEM_NAME` varchar(30) NOT NULL,
  `COST` int(11) NOT NULL,
  PRIMARY KEY (`REST_ID`,`ITEM_ID`),
  CONSTRAINT `Item_ibfk_1` FOREIGN KEY (`REST_ID`) REFERENCES `Restaurant` (`REST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES (1,1,'Cheese_pizza',250),(1,2,'Paneer_pizza',250),(2,1,'Noodles',100),(2,2,'Manchurian',100),(3,1,'Palak_Paneer',200),(3,2,'Naan',30);
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order` (
  `ORDER_ID` int(11) NOT NULL,
  `PRODUCT_COST` int(11) NOT NULL,
  `PRODUCT_QTY` int(11) NOT NULL,
  `PRODUCT_NAME` varchar(30) NOT NULL,
  `STATUS` varchar(30) NOT NULL,
  PRIMARY KEY (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES (1,250,2,'cheese_pizza','no'),(2,100,1,'noodles','no'),(3,30,4,'naan','no'),(4,100,2,'manchurian','no'),(5,250,1,'palak_paneer','no'),(6,250,1,'cheese_pizza','no'),(7,250,1,'cheese_pizza','no'),(8,100,1,'noodles','no'),(9,100,1,'noodles','no'),(10,100,1,'manchurian','no'),(11,100,1,'manchurian','no'),(12,250,1,'cheese_pizza','no'),(13,250,1,'cheese_pizza','no'),(14,30,1,'naan','no'),(15,30,1,'naan','no');
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payment` (
  `ORDER_ID` int(11) NOT NULL,
  `METHOD` varchar(30) NOT NULL,
  `PRODUCT_COST` int(11) NOT NULL,
  `STATUS` varchar(30) NOT NULL,
  PRIMARY KEY (`ORDER_ID`),
  CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`ORDER_ID`) REFERENCES `Order` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
INSERT INTO `Payment` VALUES (1,'COD',500,'no'),(2,'COD',100,'no'),(3,'COD',120,'no'),(4,'paytm',200,'no'),(5,'paytm',250,'no'),(6,'paytm',250,'no'),(7,'paytm',250,'no'),(8,'paytm',100,'no'),(9,'COD',100,'no'),(10,'paytm',100,'no'),(11,'paytm',100,'no'),(12,'COD',250,'no'),(13,'COD',250,'no'),(14,'COD',30,'no'),(15,'paytm',30,'no');
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restaurant`
--

DROP TABLE IF EXISTS `Restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Restaurant` (
  `REST_ID` int(11) NOT NULL,
  `PHONE_NO` int(11) NOT NULL,
  `TYPE` varchar(30) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `ADDRESS` varchar(30) NOT NULL,
  `EMAIL` varchar(30) NOT NULL,
  PRIMARY KEY (`REST_ID`),
  UNIQUE KEY `PHONE_NO` (`PHONE_NO`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurant`
--

LOCK TABLES `Restaurant` WRITE;
/*!40000 ALTER TABLE `Restaurant` DISABLE KEYS */;
INSERT INTO `Restaurant` VALUES (1,11,'italian','martin_kitchen','11-gachibowli','martin@gmail.com'),(2,22,'chinese','chinatown','12-gachibowli','chinatown@gmail.com'),(3,33,'indian','sharmaji_ka_dhaba','13-gachibowli','dhaba@gmail.com');
/*!40000 ALTER TABLE `Restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restaurant1`
--

DROP TABLE IF EXISTS `Restaurant1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Restaurant1` (
  `REST_ID` int(11) NOT NULL,
  `RESTAURANT_ADDRESS` varchar(30) NOT NULL,
  PRIMARY KEY (`REST_ID`),
  CONSTRAINT `Restaurant1_ibfk_1` FOREIGN KEY (`REST_ID`) REFERENCES `Restaurant` (`REST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurant1`
--

LOCK TABLES `Restaurant1` WRITE;
/*!40000 ALTER TABLE `Restaurant1` DISABLE KEYS */;
INSERT INTO `Restaurant1` VALUES (1,'11-gachibowli'),(2,'12-gachibowli'),(3,'13-gachibowli');
/*!40000 ALTER TABLE `Restaurant1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Uses`
--

DROP TABLE IF EXISTS `Uses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Uses` (
  `REST_ID` int(11) NOT NULL,
  `CUSTOMER_PHONE` int(11) NOT NULL,
  `ORDER_ID` int(11) NOT NULL,
  PRIMARY KEY (`REST_ID`,`CUSTOMER_PHONE`,`ORDER_ID`),
  KEY `CUSTOMER_PHONE` (`CUSTOMER_PHONE`),
  KEY `ORDER_ID` (`ORDER_ID`),
  CONSTRAINT `Uses_ibfk_1` FOREIGN KEY (`REST_ID`) REFERENCES `Restaurant` (`REST_ID`),
  CONSTRAINT `Uses_ibfk_2` FOREIGN KEY (`CUSTOMER_PHONE`) REFERENCES `Customer` (`PHONE_NO`),
  CONSTRAINT `Uses_ibfk_3` FOREIGN KEY (`ORDER_ID`) REFERENCES `Order` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Uses`
--

LOCK TABLES `Uses` WRITE;
/*!40000 ALTER TABLE `Uses` DISABLE KEYS */;
INSERT INTO `Uses` VALUES (1,1,1),(1,1,6),(2,1,11),(1,2,7),(1,2,12),(2,2,2),(1,3,13),(2,3,8),(3,3,3),(2,4,4),(2,4,9),(3,4,14),(2,5,10),(3,5,5),(3,5,15);
/*!40000 ALTER TABLE `Uses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-13  6:14:34
