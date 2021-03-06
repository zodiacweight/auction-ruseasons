﻿--
-- Описание для таблицы auc13_virtuemart_userinfos
--
CREATE TABLE IF NOT EXISTS auc13_virtuemart_userinfos (
  virtuemart_userinfo_id int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_user_id int(1) UNSIGNED NOT NULL DEFAULT 0,
  address_type char(2) NOT NULL DEFAULT '',
  address_type_name char(32) NOT NULL DEFAULT '',
  name char(64) DEFAULT NULL,
  company char(64) DEFAULT NULL,
  title char(32) DEFAULT NULL,
  last_name char(32) DEFAULT NULL,
  first_name char(32) DEFAULT NULL,
  middle_name char(32) DEFAULT NULL,
  phone_1 char(24) DEFAULT NULL,
  phone_2 char(24) DEFAULT NULL,
  fax char(24) DEFAULT NULL,
  address_1 char(64) NOT NULL DEFAULT '',
  address_2 char(64) DEFAULT NULL,
  city char(32) NOT NULL DEFAULT '',
  virtuemart_state_id smallint(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_country_id smallint(1) UNSIGNED NOT NULL DEFAULT 0,
  zip char(32) NOT NULL DEFAULT '',
  agreed tinyint(1) NOT NULL DEFAULT 0,
  created_on datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by int(11) NOT NULL DEFAULT 0,
  modified_on datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by int(11) NOT NULL DEFAULT 0,
  locked_on datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_userinfo_id),
  INDEX idx_userinfo_virtuemart_user_id (virtuemart_userinfo_id, virtuemart_user_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
character SET utf8
COLLATE utf8_general_ci
COMMENT = 'Customer Information, BT = BillTo and ST = ShipTo';