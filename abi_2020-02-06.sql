# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.0.19)
# Database: abi
# Generation Time: 2020-02-06 19:59:07 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table dialogues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dialogues`;

CREATE TABLE `dialogues` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `text` text,
  `author_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `dialogues` WRITE;
/*!40000 ALTER TABLE `dialogues` DISABLE KEYS */;

INSERT INTO `dialogues` (`id`, `text`, `author_id`)
VALUES
	(2,'Deutsch Wagner\r\nWagner: Was ist eine Applikation?\r\nFynn: Ein Reißverschluss\r\n',92);

/*!40000 ALTER TABLE `dialogues` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table memories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `memories`;

CREATE TABLE `memories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

LOCK TABLES `memories` WRITE;
/*!40000 ALTER TABLE `memories` DISABLE KEYS */;

INSERT INTO `memories` (`id`, `text`, `author_id`)
VALUES
	(27,'hallo\r\n',74),
	(28,'sköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffjsköd löskj kj aölkdfjkjaldkjsl jffj\r\n',74),
	(30,'sjhdfijhdfi hdsih isduhi uhsidf',68),
	(42,'asdasdsadasd',39);

/*!40000 ALTER TABLE `memories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table personal_notes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `personal_notes`;

CREATE TABLE `personal_notes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int NOT NULL,
  `profile_id` int NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

LOCK TABLES `personal_notes` WRITE;
/*!40000 ALTER TABLE `personal_notes` DISABLE KEYS */;

INSERT INTO `personal_notes` (`id`, `author_id`, `profile_id`, `text`)
VALUES
	(1,63,63,'hallo'),
	(2,63,3,'123polizei'),
	(9,68,74,'sdflkjsfljkjsdf'),
	(10,64,19,'kann kein info'),
	(14,64,63,'sadsfsfsaf'),
	(15,64,13,'sdsdsadad'),
	(17,96,96,'alki'),
	(19,39,22,'tiefe stimme\r\n');

/*!40000 ALTER TABLE `personal_notes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table poll
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll`;

CREATE TABLE `poll` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;

INSERT INTO `poll` (`id`, `title`)
VALUES
	(1,'Wer ist der lustigste Lehrer?'),
	(2,'Wer ist der Klassenclown?');

/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table poll_answers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll_answers`;

CREATE TABLE `poll_answers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` text,
  `creator_id` int DEFAULT NULL,
  `poll_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `poll_answers` WRITE;
/*!40000 ALTER TABLE `poll_answers` DISABLE KEYS */;

INSERT INTO `poll_answers` (`id`, `title`, `creator_id`, `poll_id`)
VALUES
	(1,'Krüger',64,1),
	(2,'Stritz',64,1),
	(3,'Malcher',64,1),
	(4,'Stede',64,1),
	(5,'Wagner',64,1),
	(6,'Vollmer',64,1),
	(7,'Hoo',64,2),
	(8,'Tam',64,2),
	(9,'Ben',64,2),
	(10,'Mohammad',64,2),
	(11,'Mohammad',64,2),
	(12,'',64,2);

/*!40000 ALTER TABLE `poll_answers` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table poll_votes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll_votes`;

CREATE TABLE `poll_votes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `answer_id` int DEFAULT NULL,
  `poll_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `poll_votes` WRITE;
/*!40000 ALTER TABLE `poll_votes` DISABLE KEYS */;

INSERT INTO `poll_votes` (`id`, `user_id`, `answer_id`, `poll_id`)
VALUES
	(1,64,6,1),
	(8,64,7,2),
	(9,63,9,2),
	(10,68,1,1),
	(11,39,6,1),
	(12,63,2,1);

/*!40000 ALTER TABLE `poll_votes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` text NOT NULL,
  `lastname` text NOT NULL,
  `password` text NOT NULL,
  `username` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `firstname`, `lastname`, `password`, `username`)
VALUES
	(1,'Annika','Arndt','AArndt','AArndt'),
	(2,'Annika','Knapp','AKnapp','AKnapp'),
	(3,'Annika','Terhörst','ATerhörst','ATerhörst'),
	(4,'Ben','Schojohann','BSchojohann','BSchojohann'),
	(5,'Benedikt','Ritterbach','BRitterbach','BRitterbach'),
	(6,'Björn','Sutthoff','BSutthoff','BSutthoff'),
	(7,'Carina','Huber','CHuber','CHuber'),
	(8,'Carla','Bultschnieder','CBultschnieder','CBultschnieder'),
	(9,'Chiara-Marie','Erbe','CErbe','CErbe'),
	(10,'Clara-Luisa','Jehn','CJehn','CJehn'),
	(11,'Cosima','Schrickel','CSchrickel','CSchrickel'),
	(12,'Damian','Reisewitz','DReisewitz','DReisewitz'),
	(13,'David','Danila','DDanila','DDanila'),
	(14,'Elena','Bretschneider','EBretschneider','EBretschneider'),
	(15,'Enrico','Wall','EWall','EWall'),
	(16,'Erik','Lachowetzki','ELachowetzki','ELachowetzki'),
	(17,'Felicia-Adriana','Olariu','FOlariu','FOlariu'),
	(18,'Felix','Melcher','FMelcher','FMelcher'),
	(19,'Felix','Sternberg','FSternberg','FSternberg'),
	(20,'Fynn','Lohmann','FLohmann','FLohmann'),
	(21,'Hannah','Kipp','HKipp','HKipp'),
	(22,'Henric','Wulff','HWulff','HWulff'),
	(23,'Isabel','Alke','IAlke','IAlke'),
	(24,'Isabel','Kipp','IKipp','IKipp'),
	(25,'Jakob','Grochtmann','JGrochtmann','JGrochtmann'),
	(26,'Jan','Schiebe','JSchiebe','JSchiebe'),
	(27,'Janine','Schulz','JSchulz','JSchulz'),
	(28,'Jessica','Negt','JNegt','JNegt'),
	(29,'Johanna','Gerks','JGerks','JGerks'),
	(30,'Johanna','Rawe','JRawe','JRawe'),
	(31,'John','Rees','JRees','JRees'),
	(32,'Joline','Wagner','JWagner','JWagner'),
	(33,'Jonathan','Hunold','JHunold','JHunold'),
	(34,'Judith','Bultschnieder','JBultschnieder','JBultschnieder'),
	(35,'Julia','Eckervogt','JEckervogt','JEckervogt'),
	(36,'Julia','Gemkow','JGemkow','JGemkow'),
	(37,'Julia','Max','JMax','JMax'),
	(38,'Julius','Mecklinger','JMecklinger','JMecklinger'),
	(39,'Justin','Ladwig','JLadwig','JLadwig'),
	(40,'Justus','Weber','JWeber','JWeber'),
	(41,'Katharina','Schnauber','KSchnauber','KSchnauber'),
	(42,'Katharina','Westermann','KWestermann','KWestermann'),
	(43,'Kevin','Moor','KMoor','KMoor'),
	(44,'Kilian','Linnemann','KLinnemann','KLinnemann'),
	(45,'Kirsten','Bünte','KBünte','KBünte'),
	(46,'Lana','Savic','LSavic','LSavic'),
	(47,'Lars','Wittenbrink','LWittenbrink','LWittenbrink'),
	(48,'Leonard','Brinkmeier','LBrinkmeier','LBrinkmeier'),
	(49,'Linn','Bönhoff','LBönhoff','LBönhoff'),
	(50,'Linus','Linnemann','LLinnemann','LLinnemann'),
	(51,'Linus','Rottkemper','LRottkemper','LRottkemper'),
	(52,'Lisa','Micke','LMicke','LMicke'),
	(53,'Lukas','Brünjes','LBrünjes','LBrünjes'),
	(54,'Madeleine','Surmann','MSurmann','MSurmann'),
	(55,'Maja','Berken','MBerken','MBerken'),
	(56,'Malin','Löhner','MLöhner','MLöhner'),
	(57,'Malte','Reichow','MReichow','MReichow'),
	(58,'Marcel','Kedik','MKedik','MKedik'),
	(59,'Marie','Kuhn','MKuhn','MKuhn'),
	(60,'Marit','Focken','MFocken','MFocken'),
	(61,'Marko','Reinker','MReinker','MReinker'),
	(62,'Marlon','Rothmann','MRothmann','MRothmann'),
	(63,'Mathilda','Appel','MAppel','MAppel'),
	(64,'Matteo','Illing','MIlling','MIlling'),
	(65,'Maxima','Friesen','MFriesen','MFriesen'),
	(66,'Maximilian','Rodax','MRodax','MRodax'),
	(67,'Maximilian','Zopp','MZopp','MZopp'),
	(68,'Michael','Schendelmann','MSchendelmann','MSchendelmann'),
	(69,'Mischa','Buch','MBuch','MBuch'),
	(70,'Moritz','Güth','MGüth','MGüth'),
	(71,'Muhammed','Altunyay','MAltunyay','MAltunyay'),
	(72,'Nele','Barwich','NBarwich','NBarwich'),
	(73,'Nele','Jakuschona','NJakuschona','NJakuschona'),
	(74,'Nele','van_Almsick','Nvan_Almsick','Nvan_Almsick'),
	(75,'Nico','Meyer','NMeyer','NMeyer'),
	(76,'Nienke','Bruns','NBruns','NBruns'),
	(77,'Nils','Hahne','NHahne','NHahne'),
	(78,'Nils','Kaul','NKaul','NKaul'),
	(79,'Nils','Ströker','NStröker','NStröker'),
	(80,'Nina','Dammann','NDammann','NDammann'),
	(81,'Ole','Stollmeier','OStollmeier','OStollmeier'),
	(82,'Pascal','Rehkemper','PRehkemper','PRehkemper'),
	(83,'Paul','Hartwig','PHartwig','PHartwig'),
	(84,'Paulina','Baumhüter','PBaumhüter','PBaumhüter'),
	(85,'Paulina','Specht','PSpecht','PSpecht'),
	(86,'Pauline','Pabel','PPabel','PPabel'),
	(87,'Samuel','Gök','SGök','SGök'),
	(88,'Sara','Schlautmann','SSchlautmann','SSchlautmann'),
	(89,'Sila','Pehlivan','SPehlivan','SPehlivan'),
	(90,'Tabea','Haun','THaun','THaun'),
	(91,'Tabea','Langert','TLangert','TLangert'),
	(92,'Tessa','Simora','TSimora','TSimora'),
	(93,'Theresa','Knäuper','TKnäuper','TKnäuper'),
	(94,'Tim','Niewöhner','TNiewöhner','TNiewöhner'),
	(95,'Tim','Sanke','TSanke','TSanke'),
	(96,'Aleksandra','Stippa','AStippa','AStippa');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
