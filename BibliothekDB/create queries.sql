CREATE DATABASE `bibliothek` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `autor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vorname` text NOT NULL,
  `nachname` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `typ` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `buch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `autor` int NOT NULL,
  `typ` int NOT NULL,
  `ISBN` int NOT NULL,
  `vorhanden` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ISBN_UNIQUE` (`ISBN`),
  KEY `autor` (`autor`),
  KEY `typ` (`typ`),
  CONSTRAINT `buch_ibfk_1` FOREIGN KEY (`autor`) REFERENCES `autor` (`id`),
  CONSTRAINT `buch_ibfk_2` FOREIGN KEY (`typ`) REFERENCES `typ` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student` (
  `matrikelNr` int NOT NULL,
  `vorname` text NOT NULL,
  `nachname` text NOT NULL,
  PRIMARY KEY (`matrikelNr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `zimmer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nummer` int NOT NULL,
  `etage` int NOT NULL,
  `ist_frei` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `buchung` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matrikelNr` int NOT NULL,
  `zimmer` int NOT NULL,
  `gebuchtAm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stunden` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matrikelNr` (`matrikelNr`),
  KEY `zimmer` (`zimmer`),
  CONSTRAINT `buchung_ibfk_1` FOREIGN KEY (`matrikelNr`) REFERENCES `student` (`matrikelNr`),
  CONSTRAINT `buchung_ibfk_2` FOREIGN KEY (`zimmer`) REFERENCES `zimmer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `verleihung` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matrikelNr` int NOT NULL,
  `buch` int NOT NULL,
  `verleihDatum` date NOT NULL,
  `abgabeDatum` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matrikelNr` (`matrikelNr`),
  KEY `buch` (`buch`),
  CONSTRAINT `verleihung_ibfk_1` FOREIGN KEY (`matrikelNr`) REFERENCES `student` (`matrikelNr`),
  CONSTRAINT `verleihung_ibfk_2` FOREIGN KEY (`buch`) REFERENCES `buch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
