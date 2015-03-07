#
# SQL Export
# Created by Querious (957)
# Created: March 6, 2015 at 8:59:37 PM CST
# Encoding: Unicode (UTF-8)
#


DROP TABLE IF EXISTS `person_contact`;
DROP TABLE IF EXISTS `contact`;
DROP TABLE IF EXISTS `authority_person`;
DROP TABLE IF EXISTS `person`;
DROP TABLE IF EXISTS `authority_address`;
DROP TABLE IF EXISTS `authority`;
DROP TABLE IF EXISTS `address`;


CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_1` varchar(128) NOT NULL DEFAULT '',
  `address_2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `county` varchar(128) DEFAULT NULL,
  `state` char(2) NOT NULL DEFAULT '',
  `zipcode` varchar(10) NOT NULL DEFAULT '',
  `create_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;


CREATE TABLE `authority` (
  `authority_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `code` varchar(128) NOT NULL DEFAULT '',
  `create_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`authority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


CREATE TABLE `authority_address` (
  `authority_id` int(11) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  KEY `authority_address_ibfk_1` (`authority_id`),
  KEY `authority_address_ibfk_2` (`address_id`),
  FOREIGN KEY (`authority_id`) REFERENCES `authority` (`authority_id`) ON DELETE CASCADE,
  FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(128) NOT NULL DEFAULT '',
  `lname` varchar(128) DEFAULT NULL,
  `role` varchar(128) DEFAULT NULL,
  `create_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `authority_person` (
  `authority_id` int(11) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL DEFAULT '0',
  KEY `authority_person_ibfk_1` (`authority_id`) USING BTREE,
  KEY `authority_person_ibfk_2` (`person_id`) USING BTREE,
  FOREIGN KEY (`authority_id`) REFERENCES `authority` (`authority_id`) ON DELETE CASCADE,
  FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL DEFAULT '',
  `value` varchar(128) NOT NULL DEFAULT '',
  `create_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `person_contact` (
  `person_id` int(11) NOT NULL DEFAULT '0',
  `contact_id` int(11) NOT NULL DEFAULT '0',
  KEY `person_contact_ibfk_1` (`person_id`) USING BTREE,
  KEY `person_contact_ibfk_2` (`contact_id`) USING BTREE,
  FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE,
  FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




