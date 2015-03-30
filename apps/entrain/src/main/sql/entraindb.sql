-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: entraindb
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

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
-- Table structure for table `pos`
--

DROP TABLE IF EXISTS `pos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pos` (
  `id` int(1) NOT NULL DEFAULT '0',
  `pos` varchar(32) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pos`
--

LOCK TABLES `pos` WRITE;
/*!40000 ALTER TABLE `pos` DISABLE KEYS */;
INSERT INTO `pos` VALUES (1,'verb','Verbs show actions or states of being. Can be linking, action, helping, modal, regular, irregular and some other'),(2,'noun','Nouns name people, places, things, or ideas. There are many different types of nouns. Here are a few: proper nouns, common nouns, collective nouns, and compound nouns.'),(3,'adjective','Adjectives describe, or modify, nouns and pronouns.'),(4,'adverb','Adverbs modify verbs, adjectives, and other adverbs.'),(5,'pronoun','Pronouns take the place of nouns. Just like nouns, there are many different types of pronouns. Here are a few of them: reflexive pronouns, indefinite pronouns, possessive pronouns, and relative pronouns.'),(6,'preposition','Prepositions show the relationship between a noun or a pronoun and some other word in the rest of the sentence.'),(7,'conjunction','Conjunctions join two or more words, phrases, or clauses.'),(8,'interjection','Interjections show excitement or emotion. They are not grammatically related to the rest of the sentence.');
/*!40000 ALTER TABLE `pos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `words`
--

DROP TABLE IF EXISTS `words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `words` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `enw` varchar(255) DEFAULT NULL,
  `uaw` varchar(255) DEFAULT NULL,
  `ensyn` varchar(255) DEFAULT NULL,
  `uasyn` varchar(255) DEFAULT NULL,
  `pos` int(1) DEFAULT NULL,
  `postype` varchar(32) DEFAULT NULL,
  `irvp` varchar(32) DEFAULT NULL,
  `irvpp` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `words`
--

LOCK TABLES `words` WRITE;
/*!40000 ALTER TABLE `words` DISABLE KEYS */;
INSERT INTO `words` VALUES (1,'mood','настрій',NULL,NULL,2,NULL,NULL,NULL),(2,'window','вікно',NULL,NULL,2,NULL,NULL,NULL),(3,'door','двері',NULL,NULL,2,NULL,NULL,NULL),(4,'wall','стіна',NULL,NULL,2,NULL,NULL,NULL),(5,'affair','справа',NULL,'подія, інцидент, міроприємство, явище',2,NULL,NULL,NULL),(6,'distinguish','розрізняти',NULL,'відрізняти, роздивлятися, розглядати, виділяти, характеризувати',1,'regular',NULL,NULL),(7,'towel','рушник',NULL,NULL,2,NULL,NULL,NULL),(8,'engage','зацікавлювати',NULL,NULL,1,'regular',NULL,NULL),(9,'assume','передбачати',NULL,NULL,1,'regular',NULL,NULL),(10,'sneak','крастися',NULL,'підкрадатися',1,'irregular','sneacked, snuck','sneacked, snuck'),(11,'scramble','сутичка',NULL,NULL,2,NULL,NULL,NULL),(12,'sing','співати',NULL,NULL,1,'irregular','sang','sung'),(13,'lend','позичати',NULL,NULL,1,'irregular','lent','lent');
/*!40000 ALTER TABLE `words` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-10-24 16:07:36
