# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.34)
# Database: easyrec
# Generation Time: 2017-04-24 13:54:20 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table action
# ------------------------------------------------------------

DROP TABLE IF EXISTS `action`;

CREATE TABLE `action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tenantId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `sessionId` varchar(50) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `itemId` int(11) DEFAULT NULL,
  `itemTypeId` int(11) NOT NULL,
  `actionTypeId` int(11) NOT NULL,
  `ratingValue` int(11) DEFAULT NULL,
  `actionInfo` varchar(500) CHARACTER SET utf8 DEFAULT NULL,
  `actionTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_reader` (`tenantId`,`userId`,`actionTypeId`,`itemTypeId`),
  KEY `charts` (`tenantId`,`actionTypeId`,`actionTime`,`itemId`,`itemTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing user actions';

LOCK TABLES `action` WRITE;
/*!40000 ALTER TABLE `action` DISABLE KEYS */;

INSERT INTO `action` (`id`, `tenantId`, `userId`, `sessionId`, `ip`, `itemId`, `itemTypeId`, `actionTypeId`, `ratingValue`, `actionInfo`, `actionTime`)
VALUES
	(1,1,2,'initA','127.0.0.1',3,1,1,NULL,'{\"price\":5}','2017-04-22 11:08:16'),
	(2,1,4,'initB','127.0.0.1',3,1,1,NULL,'{\"price\":5}','2017-04-22 11:08:16'),
	(3,1,2,'initA','127.0.0.1',5,1,1,NULL,'{\"price\":7}','2017-04-22 11:08:16'),
	(4,1,4,'initB','127.0.0.1',5,1,1,NULL,'{\"price\":7}','2017-04-22 11:08:16'),
	(5,1,2,'initA','127.0.0.1',6,1,1,NULL,'{\"price\":3}','2017-04-22 11:08:16'),
	(6,1,4,'initB','127.0.0.1',6,1,1,NULL,'{\"price\":3}','2017-04-22 11:08:16'),
	(7,1,4,'b','0:0:0:0:0:0:0:1',3,1,1,NULL,NULL,'2017-04-23 10:58:37'),
	(8,1,4,'b','0:0:0:0:0:0:0:1',3,1,1,NULL,NULL,'2017-04-23 10:58:46'),
	(9,1,4,'b','0:0:0:0:0:0:0:1',5,1,3,NULL,NULL,'2017-04-23 10:58:48'),
	(10,1,4,'b','0:0:0:0:0:0:0:1',6,1,2,10,NULL,'2017-04-23 10:58:50'),
	(11,1,4,'b','0:0:0:0:0:0:0:1',6,1,2,10,NULL,'2017-04-23 10:59:34');

/*!40000 ALTER TABLE `action` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table actionarch
# ------------------------------------------------------------

DROP TABLE IF EXISTS `actionarch`;

CREATE TABLE `actionarch` (
  `id` int(11) unsigned NOT NULL,
  `tenantId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `sessionId` varchar(50) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `itemId` int(11) DEFAULT NULL,
  `itemTypeId` int(11) NOT NULL,
  `actionTypeId` int(11) NOT NULL,
  `ratingValue` int(11) DEFAULT NULL,
  `actionInfo` varchar(500) CHARACTER SET utf8 DEFAULT NULL,
  `actionTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing archived actions';



# Dump of table actiontype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `actiontype`;

CREATE TABLE `actiontype` (
  `tenantId` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  `hasvalue` bit(1) NOT NULL DEFAULT b'0',
  `weight` int(11) NOT NULL DEFAULT '1',
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  UNIQUE KEY `tenantId_2` (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing actiontypes';

LOCK TABLES `actiontype` WRITE;
/*!40000 ALTER TABLE `actiontype` DISABLE KEYS */;

INSERT INTO `actiontype` (`tenantId`, `name`, `id`, `hasvalue`, `weight`)
VALUES
	(1,'BUY',3,b'0',1),
	(1,'RATE',2,b'0',1),
	(1,'VIEW',1,b'0',1);

/*!40000 ALTER TABLE `actiontype` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table aggregatetype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `aggregatetype`;

CREATE TABLE `aggregatetype` (
  `tenantId` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  UNIQUE KEY `tenantId_2` (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing aggregatetypes';

LOCK TABLES `aggregatetype` WRITE;
/*!40000 ALTER TABLE `aggregatetype` DISABLE KEYS */;

INSERT INTO `aggregatetype` (`tenantId`, `name`, `id`)
VALUES
	(1,'AVERAGE',1),
	(1,'FIRST',2),
	(1,'MAXIMUM',3),
	(1,'MOST_FREQUENT',4),
	(1,'NEWEST',5),
	(1,'OLDEST',6);

/*!40000 ALTER TABLE `aggregatetype` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assoctype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assoctype`;

CREATE TABLE `assoctype` (
  `tenantId` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  `visible` bit(1) NOT NULL DEFAULT b'1',
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  UNIQUE KEY `tenantId_2` (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing assoctypes';

LOCK TABLES `assoctype` WRITE;
/*!40000 ALTER TABLE `assoctype` DISABLE KEYS */;

INSERT INTO `assoctype` (`tenantId`, `name`, `id`, `visible`)
VALUES
	(1,'BELONGS_TO',7,b'0'),
	(1,'BOUGHT_TOGETHER',3,b'1'),
	(1,'GOOD_RATED_TOGETHER',2,b'1'),
	(1,'IS_PARENT_OF',6,b'0'),
	(1,'IS_RELATED',4,b'1'),
	(1,'PROFILE_SIMILARITY',5,b'1'),
	(1,'VIEWED_TOGETHER',1,b'1');

/*!40000 ALTER TABLE `assoctype` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table authentication
# ------------------------------------------------------------

DROP TABLE IF EXISTS `authentication`;

CREATE TABLE `authentication` (
  `tenantId` int(11) unsigned NOT NULL,
  `domainURL` varchar(250) NOT NULL DEFAULT '',
  UNIQUE KEY `unique_authentication` (`tenantId`,`domainURL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing valid access domains for tenants';



# Dump of table backtracking
# ------------------------------------------------------------

DROP TABLE IF EXISTS `backtracking`;

CREATE TABLE `backtracking` (
  `userId` int(11) unsigned NOT NULL DEFAULT '0',
  `tenantId` int(11) unsigned NOT NULL,
  `itemFromId` int(11) unsigned NOT NULL,
  `itemFromTypeId` int(11) unsigned NOT NULL,
  `itemToId` int(11) unsigned NOT NULL,
  `itemToTypeId` int(11) unsigned NOT NULL,
  `recType` int(11) unsigned NOT NULL,
  `actionTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `assoc` (`tenantId`,`itemFromId`,`itemFromTypeId`,`recType`,`itemToId`,`itemToTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Backtracking information about recommendations';



# Dump of table easyrec
# ------------------------------------------------------------

DROP TABLE IF EXISTS `easyrec`;

CREATE TABLE `easyrec` (
  `version` float(9,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `easyrec` WRITE;
/*!40000 ALTER TABLE `easyrec` DISABLE KEYS */;

INSERT INTO `easyrec` (`version`)
VALUES
	(1.000);

/*!40000 ALTER TABLE `easyrec` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table idmapping
# ------------------------------------------------------------

DROP TABLE IF EXISTS `idmapping`;

CREATE TABLE `idmapping` (
  `intId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stringId` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  PRIMARY KEY (`intId`),
  UNIQUE KEY `unique_mapping` (`stringId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing id mapping';

LOCK TABLES `idmapping` WRITE;
/*!40000 ALTER TABLE `idmapping` DISABLE KEYS */;

INSERT INTO `idmapping` (`intId`, `stringId`)
VALUES
	(3,'42'),
	(5,'43'),
	(6,'44'),
	(2,'A'),
	(4,'B'),
	(1,'CLUSTERS');

/*!40000 ALTER TABLE `idmapping` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenantId` int(11) NOT NULL,
  `itemid` varchar(250) NOT NULL DEFAULT '',
  `itemtype` varchar(20) NOT NULL DEFAULT '',
  `description` varchar(500) DEFAULT NULL,
  `profileData` text,
  `url` varchar(500) DEFAULT NULL,
  `imageurl` varchar(500) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changedate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `itemTripple` (`tenantId`,`itemid`,`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table containing items with profiles';

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;

INSERT INTO `item` (`id`, `tenantId`, `itemid`, `itemtype`, `description`, `profileData`, `url`, `imageurl`, `active`, `creationdate`, `changedate`)
VALUES
	(1,1,'CLUSTERS','CLUSTER',NULL,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><clusterVO><description>The root object of every cluster hierarchy. Cannot be removed!</description><name>CLUSTERS</name></clusterVO>',NULL,NULL,1,'2017-04-22 11:08:16','0000-00-00 00:00:00'),
	(2,1,'42','ITEM','Fatboy Slim - The Rockafeller Skank','{\"genres\":[\"Electronic\",\"Pop\"],\"label\":\"EMI\"}','/item/fatboyslim','/img/covers/fatboyslim.jpg',1,'2017-04-22 11:08:16','0000-00-00 00:00:00'),
	(3,1,'43','ITEM','Beastie Boys - Intergalactic','{\"genres\":[\"Electronic\"],\"label\":\"EMI\"}','/item/beastieboyz','/img/covers/beastieboys.jpg',1,'2017-04-22 11:08:16','0000-00-00 00:00:00'),
	(4,1,'44','ITEM','Gorillaz - Clint Eastwood','{\"genres\":[\"Pop\",\"Hiphop\"],\"label\":\"Ariola\"}','/item/gorillaz','/img/covers/gorillaz.jpg',1,'2017-04-22 11:08:16','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table itemassoc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itemassoc`;

CREATE TABLE `itemassoc` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tenantId` int(11) NOT NULL DEFAULT '0',
  `itemFromId` int(11) NOT NULL DEFAULT '0',
  `itemFromTypeId` int(11) unsigned NOT NULL DEFAULT '0',
  `assocTypeId` int(11) unsigned NOT NULL DEFAULT '0',
  `assocValue` double NOT NULL DEFAULT '0',
  `itemToId` int(11) NOT NULL DEFAULT '0',
  `itemToTypeId` int(11) unsigned NOT NULL DEFAULT '0',
  `sourceTypeId` int(11) NOT NULL DEFAULT '0',
  `sourceInfo` varchar(250) DEFAULT '0',
  `viewTypeId` int(11) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `changeDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_itemassoc` (`tenantId`,`itemFromId`,`itemFromTypeId`,`itemToId`,`itemToTypeId`,`assocTypeId`,`sourceTypeId`),
  KEY `idFrom_assoc` (`itemFromId`,`itemFromTypeId`,`assocTypeId`,`tenantId`),
  KEY `recommender` (`itemFromId`,`itemFromTypeId`,`itemToTypeId`,`assocTypeId`,`tenantId`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing item associations';



# Dump of table itemtype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itemtype`;

CREATE TABLE `itemtype` (
  `tenantId` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  `visible` bit(1) NOT NULL DEFAULT b'1',
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  UNIQUE KEY `tenantId_2` (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing itemtypes';

LOCK TABLES `itemtype` WRITE;
/*!40000 ALTER TABLE `itemtype` DISABLE KEYS */;

INSERT INTO `itemtype` (`tenantId`, `name`, `id`, `visible`)
VALUES
	(1,'CLUSTER',2,b'0'),
	(1,'ITEM',1,b'1');

/*!40000 ALTER TABLE `itemtype` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table operator
# ------------------------------------------------------------

DROP TABLE IF EXISTS `operator`;

CREATE TABLE `operator` (
  `operatorid` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(250) NOT NULL DEFAULT '',
  `firstname` varchar(250) DEFAULT NULL,
  `lastname` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `company` varchar(250) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `apikey` varchar(32) DEFAULT NULL,
  `ip` varchar(39) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `creationdate` date DEFAULT NULL,
  `accesslevel` smallint(6) DEFAULT '0',
  `lastlogin` date DEFAULT NULL,
  `logincount` int(10) unsigned DEFAULT '0',
  `token` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`operatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;

INSERT INTO `operator` (`operatorid`, `password`, `firstname`, `lastname`, `email`, `phone`, `company`, `address`, `apikey`, `ip`, `active`, `creationdate`, `accesslevel`, `lastlogin`, `logincount`, `token`)
VALUES
	('fansy','*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9','Fansy','Fansy',NULL,NULL,NULL,NULL,'0df6465975814c4a1876c60c3fac1d4c',NULL,1,'2017-04-22',1,'2017-04-23',9,'075aa7b247ccb076b1b1fe3d06ef1227');
INSERT INTO `operator` (`operatorid`, `password`, `firstname`, `lastname`, `email`, `phone`, `company`, `address`, `apikey`, `ip`, `active`, `creationdate`, `accesslevel`, `lastlogin`, `logincount`, `token`)
VALUES
	('admin','*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9','Admin','Admin',NULL,NULL,NULL,NULL,'0df6465975814c4a1876c60c3fac1d4c',NULL,1,'2017-04-22',1,'2017-04-23',9,'075aa7b247ccb076b1b1fe3d06ef1227');

/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugin`;

CREATE TABLE `plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `displayname` varchar(150) DEFAULT NULL,
  `pluginid` varchar(500) NOT NULL,
  `version` varchar(50) NOT NULL,
  `origfilename` varchar(150) DEFAULT '',
  `state` varchar(50) NOT NULL,
  `file` longblob,
  `changeDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pluginId` (`pluginid`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing plugins';



# Dump of table plugin_configuration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugin_configuration`;

CREATE TABLE `plugin_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenantId` int(11) NOT NULL,
  `assocTypeId` int(11) NOT NULL,
  `pluginId` varchar(500) NOT NULL,
  `pluginVersion` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `configuration` text NOT NULL,
  `active` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_configuration` (`tenantId`,`assocTypeId`,`pluginId`(250),`pluginVersion`,`name`(250)),
  KEY `idx_tenantAssoc` (`tenantId`,`assocTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='store plugin configurations for tenants';



# Dump of table plugin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugin_log`;

CREATE TABLE `plugin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenantId` int(11) unsigned NOT NULL,
  `pluginId` varchar(500) NOT NULL,
  `pluginVersion` varchar(50) NOT NULL,
  `startDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endDate` timestamp NULL DEFAULT NULL,
  `assocTypeId` int(11) NOT NULL,
  `configuration` text NOT NULL,
  `statistics` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_plugin_log` (`tenantId`,`pluginId`(255),`pluginVersion`,`assocTypeId`,`startDate`),
  KEY `idx_tenantId` (`tenantId`),
  KEY `idx_endDate` (`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='store runs of plugins';



# Dump of table recommendation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recommendation`;

CREATE TABLE `recommendation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tenantId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `queriedItemId` int(11) DEFAULT NULL,
  `queriedItemTypeId` int(11) DEFAULT NULL,
  `queriedAssocTypeId` int(11) DEFAULT NULL,
  `relatedActionTypeId` int(11) DEFAULT NULL,
  `recommendationStrategy` varchar(50) DEFAULT NULL,
  `explanation` varchar(255) DEFAULT NULL,
  `recommendationTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing the history of recommendations';



# Dump of table recommendeditem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recommendeditem`;

CREATE TABLE `recommendeditem` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `itemId` int(11) NOT NULL,
  `itemTypeId` int(11) NOT NULL,
  `recommendationId` int(11) NOT NULL,
  `predictionValue` double NOT NULL DEFAULT '0',
  `itemAssocId` int(11) DEFAULT NULL,
  `explanation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_recommended_item` (`itemId`,`itemTypeId`,`recommendationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing all recommended items (ever)';



# Dump of table sourcetype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sourcetype`;

CREATE TABLE `sourcetype` (
  `tenantId` int(11) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `id` int(11) NOT NULL,
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  UNIQUE KEY `tenantId_2` (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing sourcetypes';

LOCK TABLES `sourcetype` WRITE;
/*!40000 ALTER TABLE `sourcetype` DISABLE KEYS */;

INSERT INTO `sourcetype` (`tenantId`, `name`, `id`)
VALUES
	(1,'MANUALLY_CREATED',1),
	(1,'http://www.easyrec.org/plugins/ARM/1.0',2);

/*!40000 ALTER TABLE `sourcetype` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tenant
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tenant`;

CREATE TABLE `tenant` (
  `id` int(11) unsigned NOT NULL,
  `stringId` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `ratingRangeMin` int(11) unsigned DEFAULT NULL,
  `ratingRangeMax` int(11) unsigned DEFAULT NULL,
  `ratingRangeNeutral` double DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `operatorid` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `creationdate` datetime DEFAULT NULL,
  `tenantConfig` mediumblob,
  `tenantStatistic` mediumblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stringId` (`stringId`,`operatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing tenants';

LOCK TABLES `tenant` WRITE;
/*!40000 ALTER TABLE `tenant` DISABLE KEYS */;

INSERT INTO `tenant` (`id`, `stringId`, `description`, `ratingRangeMin`, `ratingRangeMax`, `ratingRangeNeutral`, `active`, `operatorid`, `url`, `creationdate`, `tenantConfig`, `tenantStatistic`)
VALUES
	(1,'EASYREC_DEMO','This is a demo tenant.',1,10,5.5,1,'fansy','http://localhost:8080','2017-04-22 11:08:16',X'230A23536174204170722032322031313A30383A31362043535420323031370A53455353494F4E5F544F5F555345525F4D415050494E472E656E61626C65643D66616C73650A6261636B747261636B696E673D747275650A4155544F5F41524348495645522E656E61626C65643D747275650A4155544F5F52554C454D494E45522E656E61626C65643D747275650A4155544F5F41524348495645522E74696D6552616E67653D313832350A4155544F5F52554C454D494E45522E657865637574696F6E54696D653D30325C3A30300A',X'230A2353756E204170722032332031313A30303A34312043535420323031370A4153534F432E6974656D735769746852756C65732E42454C4F4E47535F544F3D300A4153534F432E72756C65732E49535F504152454E545F4F463D300A555345522E312E616374696F6E3D300A4153534F432E76616C75652E677265617465722E7468616E2E6D696E6173736F6376616C7565343D300A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E50524F46494C455F53494D494C41524954593D300A4153534F432E76616C75652E677265617465722E7468616E2E6D696E6173736F6376616C7565333D300A54454E414E542E7265636F6D6D656E646174696F6E436F7665726167653D302E300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E42454C4F4E47535F544F3D300A4153534F432E6974656D735769746852756C65732E50524F46494C455F53494D494C41524954593D300A4153534F432E76616C75652E677265617465722E7468616E2E6D696E6173736F6376616C7565323D300A4153534F432E76616C75652E677265617465722E7468616E2E6D696E6173736F6376616C7565313D300A4153534F432E616374696F6E732E49535F504152454E545F4F463D300A4153534F432E6974656D735769746852756C65732E49535F504152454E545F4F463D300A434F4E56455253494F4E2E7265636F6D6D656E646174696F6E546F427579436F756E743D300A4153534F432E6974656D735769746852756C65732E424F554748545F544F4745544845523D300A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E49535F504152454E545F4F463D300A54454E414E542E6261636B747261636B733D300A4153534F432E72756C65732E424F554748545F544F4745544845523D300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E49535F504152454E545F4F463D300A4153534F432E72756C65732E49535F52454C415445443D300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E5649455745445F544F4745544845523D300A4153534F432E72756C65732E474F4F445F52415445445F544F4745544845523D300A4153534F432E616374696F6E732E49535F52454C415445443D300A555345522E322E616374696F6E733D300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E474F4F445F52415445445F544F4745544845523D300A54454E414E542E616374696F6E733D31310A555345522E3130312E616E642E6D6F72652E616374696F6E733D300A54454E414E542E75736572733D320A4153534F432E616374696F6E732E474F4F445F52415445445F544F4745544845523D320A4153534F432E72756C65732E42454C4F4E47535F544F3D300A4153534F432E616374696F6E732E42454C4F4E47535F544F3D300A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E5649455745445F544F4745544845523D300A4153534F432E746F74616C2E6974656D732E776974682E72756C65733D300A555345522E332E31302E616374696F6E733D320A4153534F432E616374696F6E732E5649455745445F544F4745544845523D380A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E49535F52454C415445443D300A4153534F432E72756C65732E50524F46494C455F53494D494C41524954593D300A4153534F432E616374696F6E732E50524F46494C455F53494D494C41524954593D300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E424F554748545F544F4745544845523D300A555345522E31312E3130302E616374696F6E733D300A54454E414E542E6974656D733D330A54454E414E542E61766572616765416374696F6E73506572557365723D352E350A54454E414E542E6D6F6E74686C792E616374696F6E733D31310A4153534F432E6974656D735769746852756C65732E49535F52454C415445443D300A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E42454C4F4E47535F544F3D300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E50524F46494C455F53494D494C41524954593D300A4153534F432E6974656D735769746852756C65732E5649455745445F544F4745544845523D300A4153534F432E7374644E756D6265724F6652756C65735065724974656D2E49535F52454C415445443D300A4153534F432E72756C65732E5649455745445F544F4745544845523D300A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E424F554748545F544F4745544845523D300A4153534F432E616374696F6E732E424F554748545F544F4745544845523D310A4153534F432E617665726167654E756D6265724F6652756C65735065724974656D2E474F4F445F52415445445F544F4745544845523D300A4153534F432E6974656D735769746852756C65732E474F4F445F52415445445F544F4745544845523D300A');

/*!40000 ALTER TABLE `tenant` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table viewtype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `viewtype`;

CREATE TABLE `viewtype` (
  `tenantId` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  UNIQUE KEY `tenantId_2` (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table containing viewtypes';

LOCK TABLES `viewtype` WRITE;
/*!40000 ALTER TABLE `viewtype` DISABLE KEYS */;

INSERT INTO `viewtype` (`tenantId`, `name`, `id`)
VALUES
	(1,'ADMIN',1),
	(1,'COMMUNITY',2),
	(1,'SYSTEM',3);

/*!40000 ALTER TABLE `viewtype` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
