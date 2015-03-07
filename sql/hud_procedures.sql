#
# SQL Export
# Created by Querious (957)
# Created: March 6, 2015 at 9:00:12 PM CST
# Encoding: Unicode (UTF-8)
#


DROP PROCEDURE IF EXISTS `update_person`;
DROP PROCEDURE IF EXISTS `update_contact`;
DROP PROCEDURE IF EXISTS `update_authority`;
DROP PROCEDURE IF EXISTS `update_address`;
DROP PROCEDURE IF EXISTS `delete_person`;
DROP PROCEDURE IF EXISTS `delete_contact`;
DROP PROCEDURE IF EXISTS `delete_authority`;
DROP PROCEDURE IF EXISTS `delete_address`;
DROP PROCEDURE IF EXISTS `create_person_contact`;
DROP PROCEDURE IF EXISTS `create_person`;
DROP PROCEDURE IF EXISTS `create_contact`;
DROP PROCEDURE IF EXISTS `create_authority_person`;
DROP PROCEDURE IF EXISTS `create_authority_address`;
DROP PROCEDURE IF EXISTS `create_authority`;
DROP PROCEDURE IF EXISTS `create_address`;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_address`(IN p_address_1 varchar(128), IN p_address_2 varchar(128), IN p_city varchar(128), IN p_county varchar(128), IN p_state char(2), IN p_zipcode varchar(10), OUT p_address_id int)
    DETERMINISTIC
    COMMENT 'CREATE an address record.'
BEGIN

	-- Insert a record.
	INSERT INTO	address (
		address_1,
		address_2,
		city,
		county,
		state,
		zipcode
	)
	VALUES (
		p_address_1,
		p_address_2,
		p_city,
		p_county,
		p_state,
		p_zipcode
	);
	
	-- Return the _id of the newly created record.
	SET p_address_id = LAST_INSERT_ID();
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_authority`(IN p_name varchar(128), IN p_code varchar(128), OUT p_authority_id int)
    DETERMINISTIC
    COMMENT 'CREATE an authority record.'
BEGIN

	-- Insert a record.
	INSERT INTO	authority (
		name,
		code
	)
	VALUES (
		p_name,
		p_code
	);
		
	-- Return the _id of the newly created record.
	SET p_authority_id = LAST_INSERT_ID();	
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_authority_address`(IN p_authority_id int, IN p_address_1 varchar(128), IN p_address_2 varchar(128), IN p_city varchar(128), IN p_county varchar(128), IN p_state char(2), IN p_zipcode varchar(10))
    DETERMINISTIC
    COMMENT 'CREATE an address record attached to an authority record.'
BEGIN

	-- Insert address record.
	CALL create_address(p_address_1, p_address_2, p_city, p_county, p_state, p_zipcode, @address_id);
	
	-- Insert authority_address record.
	INSERT INTO	authority_address (
		authority_id,
		address_id
	)
	VALUES (
		p_authority_id,
		@address_id
	);
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_authority_person`(IN p_authority_id int, IN p_fname varchar(128), IN p_lname varchar(128), IN p_role varchar(128))
    DETERMINISTIC
    COMMENT 'CREATE a person record attached to an authority record.'
BEGIN

	-- Insert person record.
	CALL create_person(p_fname, p_lname, p_role, @person_id);
	
	-- Insert authority_person record.
	INSERT INTO	authority_person (
		authority_id,
		person_id
	)
	VALUES (
		p_authority_id,
		@person_id
	);
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_contact`(IN p_type varchar(128), IN p_value varchar(128), OUT p_contact_id int)
    DETERMINISTIC
    COMMENT 'CREATE a contact record.'
BEGIN

	-- Insert a record.
	INSERT INTO	contact (
		type,
		value
	)
	VALUES (
		p_type,
		p_value
	);
		
	-- Return the _id of the newly created record.
	SET p_contact_id = LAST_INSERT_ID();	
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_person`(IN p_fname varchar(128), IN p_lname varchar(128), IN p_role varchar(128), OUT p_person_id int)
    DETERMINISTIC
    COMMENT 'CREATE a person record.'
BEGIN

	-- Insert a record.
	INSERT INTO	person (
		fname,
		lname,
		role
	)
	VALUES (
		p_fname,
		p_lname,
		p_role
	);
		
	-- Return the _id of the newly created record.
	SET p_person_id = LAST_INSERT_ID();	
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_person_contact`(IN p_person_id int, IN p_type varchar(128), IN p_value varchar(128))
    DETERMINISTIC
    COMMENT 'CREATE a contact record attached to a person record.'
BEGIN

	-- Insert contact record.
	CALL create_contact(p_type, p_value, @contact_id);
	
	-- Insert person_contact record.
	INSERT INTO	person_contact (
		person_id,
		contact_id
	)
	VALUES (
		p_person_id,
		@contact_id
	);
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_address`(IN p_authority_id int)
    COMMENT 'DELETE an authority record (and all children records).'
BEGIN

	-- Delete children records.
	DELETE	ad
	FROM	address ad
	INNER JOIN 	authority_address aa on (aa.address_id = ad.address_id)
	WHERE 	aa.authority_id = p_authority_id;
	
	-- Delete the record.
	DELETE	a
	FROM	authority a
	WHERE	a.authority_id = p_authority_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_authority`(IN p_contact_id int)
    COMMENT 'DELETE a contact record.'
BEGIN
	
	-- Delete the record.
	DELETE	c
	FROM	contact c
	WHERE	c.contact_id = p_contact_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_contact`(IN p_person_id int)
    COMMENT 'DELETE an person record.'
BEGIN
	
	-- Delete the record.
	DELETE	p
	FROM	person p
	WHERE	p.person_id = p_person_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_person`(IN p_address_id int)
    COMMENT 'DELETE an address record.'
BEGIN
	
	-- Delete the record.
	DELETE	ad
	FROM	address ad
	WHERE	ad.address_id = p_address_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address`(IN p_address_id int, IN p_address_1 varchar(128), IN p_address_2 varchar(128), IN p_city varchar(128), IN p_county varchar(128), IN p_state char(2), IN p_zipcode varchar(10))
    DETERMINISTIC
    COMMENT 'UPDATE an address record.'
BEGIN

	-- Update the record.
	UPDATE	address
	SET		address_1 = p_address_1,
			address_2 = p_address_2,
			city = p_city,
			county = p_county,
			state = p_state,
			zipcode = p_zipcode
	WHERE	address_id = p_address_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_authority`(IN p_contact_id int, IN p_type varchar(128), IN p_value varchar(128))
    DETERMINISTIC
    COMMENT 'UPDATE a contact record.'
BEGIN

	-- Update the record.
	UPDATE	contact
	SET		type = p_type,
			value = p_value
	WHERE	contact_id = p_contact_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_contact`(IN p_person_id int, IN p_fname varchar(128), IN p_lname varchar(128), IN p_role varchar(128))
    DETERMINISTIC
    COMMENT 'UPDATE an person record.'
BEGIN

	-- Update the record.
	UPDATE	person
	SET		fname = p_fname,
			lname = p_lname,
			role = p_role
	WHERE	person_id = p_person_id;
	
END;
//
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_person`(IN p_authority_id int, IN p_name varchar(128), IN p_code varchar(128))
    DETERMINISTIC
    COMMENT 'UPDATE an authority record.'
BEGIN

	-- Update the record.
	UPDATE	authority
	SET		name = p_name,
			code = p_code
	WHERE	authority_id = p_authority_id;
	
END;
//
DELIMITER ;




