CREATE DATABASE  IF NOT EXISTS `empresas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `empresas`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: empresas
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `empregado`
--

DROP TABLE IF EXISTS `empregado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empregado` (
  `Matricula` int NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `rua` varchar(50) DEFAULT NULL,
  `bairro` varchar(30) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `datanasc` date DEFAULT NULL,
  `dataadm` date DEFAULT NULL,
  `funcao` varchar(30) DEFAULT NULL,
  `coddepart` int DEFAULT NULL,
  `matgerente` int DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `comissao` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Matricula`),
  KEY `coddepart` (`coddepart`),
  KEY `matgerente` (`matgerente`),
  CONSTRAINT `empregado_ibfk_1` FOREIGN KEY (`coddepart`) REFERENCES `departamento` (`Cod`),
  CONSTRAINT `empregado_ibfk_2` FOREIGN KEY (`matgerente`) REFERENCES `empregado` (`Matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empregado`
--

LOCK TABLES `empregado` WRITE;
/*!40000 ALTER TABLE `empregado` DISABLE KEYS */;
INSERT INTO `empregado` VALUES (2,'Jose Lopes',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,2500.00,NULL),(3,'Maria Conceição',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,3500.00,NULL),(4,'Victor Augusto',NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,9600.00,NULL),(5,'Carla Visa',NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,2500.00,NULL),(6,'Joao Lopes',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1500.00,NULL),(101,'Carlos Andrade','Rua das Flores, 120','Centro','11999990001','1980-05-12','2018-03-01','Gerente de RH',1,NULL,8500.00,0.00),(102,'Mariana Souza','Av. Atlântica, 400','Copacabana','21998887777','1985-11-03','2019-07-10','Gerente de TI',2,NULL,9500.00,0.00),(103,'Ricardo Lima','Rua Amazonas, 88','Savassi','31997776655','1978-02-28','2017-01-20','Gerente Financeiro',3,NULL,9200.00,0.00),(104,'Fernanda Alves','Rua XV de Novembro, 300','Centro','41996665544','1990-09-25','2020-05-05','Gerente de Marketing',4,NULL,8700.00,0.00),(105,'João Pereira','Rua das Laranjeiras, 45','Pituba','71995554433','1988-06-15','2021-09-12','Gerente de Vendas',1,NULL,8800.00,0.00),(201,'Ana Costa','Rua dos Pinheiros, 250','Moema','11991112222','1995-03-18','2022-02-01','Analista de RH',1,101,4500.00,500.00);
/*!40000 ALTER TABLE `empregado` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-21  7:20:34
