﻿--
-- Описание для таблицы auc13_contact_details
--
CREATE TABLE IF NOT EXISTS auc13_contact_details (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL DEFAULT '',
  alias varchar(255) binary character SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  con_position varchar(255) DEFAULT NULL,
  address text DEFAULT NULL,
  suburb varchar(100) DEFAULT NULL,
  state varchar(100) DEFAULT NULL,
  country varchar(100) DEFAULT NULL,
  postcode varchar(100) DEFAULT NULL,
  telephone varchar(255) DEFAULT NULL,
  fax varchar(255) DEFAULT NULL,
  misc mediumtext DEFAULT NULL,
  image varchar(255) DEFAULT NULL,
  imagepos varchar(20) DEFAULT NULL,
  email_to varchar(255) DEFAULT NULL,
  default_con tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  published tinyint(1) NOT NULL DEFAULT 0,
  checked_out int(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  ordering int(11) NOT NULL DEFAULT 0,
  params text NOT NULL,
  user_id int(11) NOT NULL DEFAULT 0,
  catid int(11) NOT NULL DEFAULT 0,
  access int(10) UNSIGNED NOT NULL DEFAULT 0,
  mobile varchar(255) NOT NULL DEFAULT '',
  webpage varchar(255) NOT NULL DEFAULT '',
  sortname1 varchar(255) NOT NULL,
  sortname2 varchar(255) NOT NULL,
  sortname3 varchar(255) NOT NULL,
  language char(7) NOT NULL,
  created datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by int(10) UNSIGNED NOT NULL DEFAULT 0,
  created_by_alias varchar(255) NOT NULL DEFAULT '',
  modified datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by int(10) UNSIGNED NOT NULL DEFAULT 0,
  metakey text NOT NULL,
  metadesc text NOT NULL,
  metadata text NOT NULL,
  featured tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Set if article is featured.',
  xreference varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  publish_up datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  INDEX idx_access (access),
  INDEX idx_catid (catid),
  INDEX idx_checkout (checked_out),
  INDEX idx_createdby (created_by),
  INDEX idx_featured_catid (featured, catid),
  INDEX idx_language (language),
  INDEX idx_state (published),
  INDEX idx_xreference (xreference)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
character SET utf8
COLLATE utf8_general_ci;