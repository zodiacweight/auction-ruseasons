﻿-- Скрипт сгенерирован Devart dbForge Studio Beta for MySQL, Версия 6.0.93.1
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 04.03.2013 18:45:35
-- Версия сервера: 5.1.40-community
-- Версия клиента: 4.1

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE auctionru_2013;

--
-- Описание для таблицы auc13_assets
--
DROP TABLE IF EXISTS auc13_assets;
CREATE TABLE auc13_assets (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  parent_id INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set parent.',
  lft INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set lft.',
  rgt INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set rgt.',
  level INT(10) UNSIGNED NOT NULL COMMENT 'The cached level in the nested tree.',
  name VARCHAR(50) NOT NULL COMMENT 'The unique name for the asset.
',
  title VARCHAR(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  rules VARCHAR(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (id),
  UNIQUE INDEX idx_asset_name (name),
  INDEX idx_lft_rgt (lft, rgt),
  INDEX idx_parent_id (parent_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 68
AVG_ROW_LENGTH = 142
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_associations
--
DROP TABLE IF EXISTS auc13_associations;
CREATE TABLE auc13_associations (
  id VARCHAR(50) NOT NULL COMMENT 'A reference to the associated item.',
  context VARCHAR(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` CHAR(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (context, id),
  INDEX idx_key (`key`)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_auction2013
--
DROP TABLE IF EXISTS auc13_auction2013;
CREATE TABLE auc13_auction2013 (
  id INT(11) NOT NULL AUTO_INCREMENT,
  abstract VARCHAR(255) NOT NULL COMMENT 'Заготовка',
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Заготовка таблицы для модели';

--
-- Описание для таблицы auc13_categories
--
DROP TABLE IF EXISTS auc13_categories;
CREATE TABLE auc13_categories (
  id INT(11) NOT NULL AUTO_INCREMENT,
  asset_id INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  parent_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  lft INT(11) NOT NULL DEFAULT 0,
  rgt INT(11) NOT NULL DEFAULT 0,
  level INT(10) UNSIGNED NOT NULL DEFAULT 0,
  path VARCHAR(255) NOT NULL DEFAULT '',
  extension VARCHAR(50) NOT NULL DEFAULT '',
  title VARCHAR(255) NOT NULL,
  alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  note VARCHAR(255) NOT NULL DEFAULT '',
  description MEDIUMTEXT NOT NULL,
  published TINYINT(1) NOT NULL DEFAULT 0,
  checked_out INT(11) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  access INT(10) UNSIGNED NOT NULL DEFAULT 0,
  params TEXT NOT NULL,
  metadesc VARCHAR(1024) NOT NULL COMMENT 'The meta description for the page.',
  metakey VARCHAR(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  metadata VARCHAR(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  created_user_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_user_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  modified_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  hits INT(10) UNSIGNED NOT NULL DEFAULT 0,
  language CHAR(7) NOT NULL,
  PRIMARY KEY (id),
  INDEX cat_idx (extension, published, access),
  INDEX idx_access (access),
  INDEX idx_alias (alias),
  INDEX idx_checkout (checked_out),
  INDEX idx_language (language),
  INDEX idx_left_right (lft, rgt),
  INDEX idx_path (path)
)
ENGINE = MYISAM
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 185
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_contact_details
--
DROP TABLE IF EXISTS auc13_contact_details;
CREATE TABLE auc13_contact_details (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL DEFAULT '',
  alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  con_position VARCHAR(255) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  suburb VARCHAR(100) DEFAULT NULL,
  state VARCHAR(100) DEFAULT NULL,
  country VARCHAR(100) DEFAULT NULL,
  postcode VARCHAR(100) DEFAULT NULL,
  telephone VARCHAR(255) DEFAULT NULL,
  fax VARCHAR(255) DEFAULT NULL,
  misc MEDIUMTEXT DEFAULT NULL,
  image VARCHAR(255) DEFAULT NULL,
  imagepos VARCHAR(20) DEFAULT NULL,
  email_to VARCHAR(255) DEFAULT NULL,
  default_con TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 0,
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  ordering INT(11) NOT NULL DEFAULT 0,
  params TEXT NOT NULL,
  user_id INT(11) NOT NULL DEFAULT 0,
  catid INT(11) NOT NULL DEFAULT 0,
  access INT(10) UNSIGNED NOT NULL DEFAULT 0,
  mobile VARCHAR(255) NOT NULL DEFAULT '',
  webpage VARCHAR(255) NOT NULL DEFAULT '',
  sortname1 VARCHAR(255) NOT NULL,
  sortname2 VARCHAR(255) NOT NULL,
  sortname3 VARCHAR(255) NOT NULL,
  language CHAR(7) NOT NULL,
  created DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_by_alias VARCHAR(255) NOT NULL DEFAULT '',
  modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  metakey TEXT NOT NULL,
  metadesc TEXT NOT NULL,
  metadata TEXT NOT NULL,
  featured TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Set if article is featured.',
  xreference VARCHAR(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
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
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_content
--
DROP TABLE IF EXISTS auc13_content;
CREATE TABLE auc13_content (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  asset_id INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  title VARCHAR(255) NOT NULL DEFAULT '',
  alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  title_alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Deprecated in Joomla! 3.0',
  introtext MEDIUMTEXT NOT NULL,
  `fulltext` MEDIUMTEXT NOT NULL,
  state TINYINT(3) NOT NULL DEFAULT 0,
  sectionid INT(10) UNSIGNED NOT NULL DEFAULT 0,
  mask INT(10) UNSIGNED NOT NULL DEFAULT 0,
  catid INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_by_alias VARCHAR(255) NOT NULL DEFAULT '',
  modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  images TEXT NOT NULL,
  urls TEXT NOT NULL,
  attribs VARCHAR(5120) NOT NULL,
  version INT(10) UNSIGNED NOT NULL DEFAULT 1,
  parentid INT(10) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(11) NOT NULL DEFAULT 0,
  metakey TEXT NOT NULL,
  metadesc TEXT NOT NULL,
  access INT(10) UNSIGNED NOT NULL DEFAULT 0,
  hits INT(10) UNSIGNED NOT NULL DEFAULT 0,
  metadata TEXT NOT NULL,
  featured TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Set if article is featured.',
  language CHAR(7) NOT NULL COMMENT 'The language code for the article.',
  xreference VARCHAR(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY (id),
  INDEX idx_access (access),
  INDEX idx_catid (catid),
  INDEX idx_checkout (checked_out),
  INDEX idx_createdby (created_by),
  INDEX idx_featured_catid (featured, catid),
  INDEX idx_language (language),
  INDEX idx_state (state),
  INDEX idx_xreference (xreference)
)
ENGINE = MYISAM
AUTO_INCREMENT = 24
AVG_ROW_LENGTH = 5104
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_content_frontpage
--
DROP TABLE IF EXISTS auc13_content_frontpage;
CREATE TABLE auc13_content_frontpage (
  content_id INT(11) NOT NULL DEFAULT 0,
  ordering INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (content_id)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_content_rating
--
DROP TABLE IF EXISTS auc13_content_rating;
CREATE TABLE auc13_content_rating (
  content_id INT(11) NOT NULL DEFAULT 0,
  rating_sum INT(10) UNSIGNED NOT NULL DEFAULT 0,
  rating_count INT(10) UNSIGNED NOT NULL DEFAULT 0,
  lastip VARCHAR(50) NOT NULL DEFAULT '',
  PRIMARY KEY (content_id)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_core_log_searches
--
DROP TABLE IF EXISTS auc13_core_log_searches;
CREATE TABLE auc13_core_log_searches (
  search_term VARCHAR(128) NOT NULL DEFAULT '',
  hits INT(10) UNSIGNED NOT NULL DEFAULT 0
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_extensions
--
DROP TABLE IF EXISTS auc13_extensions;
CREATE TABLE auc13_extensions (
  extension_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(20) NOT NULL,
  element VARCHAR(100) NOT NULL,
  folder VARCHAR(100) NOT NULL,
  client_id TINYINT(3) NOT NULL,
  enabled TINYINT(3) NOT NULL DEFAULT 1,
  access INT(10) UNSIGNED NOT NULL DEFAULT 1,
  protected TINYINT(3) NOT NULL DEFAULT 0,
  manifest_cache TEXT NOT NULL,
  params TEXT NOT NULL,
  custom_data TEXT NOT NULL,
  system_data TEXT NOT NULL,
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  ordering INT(11) DEFAULT 0,
  state INT(11) DEFAULT 0,
  PRIMARY KEY (extension_id),
  INDEX element_clientid (element, client_id),
  INDEX element_folder_clientid (element, folder, client_id),
  INDEX extension (type, element, folder, client_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 10069
AVG_ROW_LENGTH = 487
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_taxonomy
--
DROP TABLE IF EXISTS auc13_finder_taxonomy;
CREATE TABLE auc13_finder_taxonomy (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  parent_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  title VARCHAR(255) NOT NULL,
  state TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  access TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX access (access),
  INDEX idx_parent_published (parent_id, state, access),
  INDEX ordering (ordering),
  INDEX parent_id (parent_id),
  INDEX state (state)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 20
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_taxonomy_map
--
DROP TABLE IF EXISTS auc13_finder_taxonomy_map;
CREATE TABLE auc13_finder_taxonomy_map (
  link_id INT(10) UNSIGNED NOT NULL,
  node_id INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (link_id, node_id),
  INDEX link_id (link_id),
  INDEX node_id (node_id)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_terms
--
DROP TABLE IF EXISTS auc13_finder_terms;
CREATE TABLE auc13_finder_terms (
  term_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  term VARCHAR(75) NOT NULL,
  stem VARCHAR(75) NOT NULL,
  common TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  phrase TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  weight FLOAT UNSIGNED NOT NULL DEFAULT 0,
  soundex VARCHAR(75) NOT NULL,
  links INT(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (term_id),
  INDEX idx_soundex_phrase (soundex, phrase),
  INDEX idx_stem_phrase (stem, phrase),
  UNIQUE INDEX idx_term (term),
  INDEX idx_term_phrase (term, phrase)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_terms_common
--
DROP TABLE IF EXISTS auc13_finder_terms_common;
CREATE TABLE auc13_finder_terms_common (
  term VARCHAR(75) NOT NULL,
  language VARCHAR(3) NOT NULL,
  INDEX idx_lang (language),
  INDEX idx_word_lang (term, language)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 20
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_tokens
--
DROP TABLE IF EXISTS auc13_finder_tokens;
CREATE TABLE auc13_finder_tokens (
  term VARCHAR(75) NOT NULL,
  stem VARCHAR(75) NOT NULL,
  common TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  phrase TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  weight FLOAT UNSIGNED NOT NULL DEFAULT 1,
  context TINYINT(1) UNSIGNED NOT NULL DEFAULT 2,
  INDEX idx_context (context),
  INDEX idx_word (term)
)
ENGINE = MEMORY
AVG_ROW_LENGTH = 459
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_tokens_aggregate
--
DROP TABLE IF EXISTS auc13_finder_tokens_aggregate;
CREATE TABLE auc13_finder_tokens_aggregate (
  term_id INT(10) UNSIGNED NOT NULL,
  map_suffix CHAR(1) NOT NULL,
  term VARCHAR(75) NOT NULL,
  stem VARCHAR(75) NOT NULL,
  common TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  phrase TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  term_weight FLOAT UNSIGNED NOT NULL,
  context TINYINT(1) UNSIGNED NOT NULL DEFAULT 2,
  context_weight FLOAT UNSIGNED NOT NULL,
  total_weight FLOAT UNSIGNED NOT NULL,
  INDEX keyword_id (term_id),
  INDEX token (term)
)
ENGINE = MEMORY
AVG_ROW_LENGTH = 474
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_finder_types
--
DROP TABLE IF EXISTS auc13_finder_types;
CREATE TABLE auc13_finder_types (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  mime VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX title (title)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_languages
--
DROP TABLE IF EXISTS auc13_languages;
CREATE TABLE auc13_languages (
  lang_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  lang_code CHAR(7) NOT NULL,
  title VARCHAR(50) NOT NULL,
  title_native VARCHAR(50) NOT NULL,
  sef VARCHAR(50) NOT NULL,
  image VARCHAR(50) NOT NULL,
  description VARCHAR(512) NOT NULL,
  metakey TEXT NOT NULL,
  metadesc TEXT NOT NULL,
  sitename VARCHAR(1024) NOT NULL DEFAULT '',
  published INT(11) NOT NULL DEFAULT 0,
  access INT(10) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (lang_id),
  INDEX idx_access (access),
  UNIQUE INDEX idx_image (image),
  UNIQUE INDEX idx_langcode (lang_code),
  INDEX idx_ordering (ordering),
  UNIQUE INDEX idx_sef (sef)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 56
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_menu
--
DROP TABLE IF EXISTS auc13_menu;
CREATE TABLE auc13_menu (
  id INT(11) NOT NULL AUTO_INCREMENT,
  menutype VARCHAR(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  title VARCHAR(255) NOT NULL COMMENT 'The display title of the menu item.',
  alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  note VARCHAR(255) NOT NULL DEFAULT '',
  path VARCHAR(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  link VARCHAR(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  type VARCHAR(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  published TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'The published state of the menu link.',
  parent_id INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'The parent menu item in the menu tree.',
  level INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The relative level in the tree.',
  component_id INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to #__extensions.id',
  ordering INT(11) NOT NULL DEFAULT 0 COMMENT 'The relative ordering of the menu item in the tree.',
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to #__users.id',
  checked_out_time TIMESTAMP DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  browserNav TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'The click behaviour of the link.',
  access INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The access level required to view the menu item.',
  img VARCHAR(255) NOT NULL COMMENT 'The image of the menu item.',
  template_style_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  params TEXT NOT NULL COMMENT 'JSON encoded data for the menu item.',
  lft INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set lft.',
  rgt INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set rgt.',
  home TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Indicates if this menu item is the home or default page.',
  language CHAR(7) NOT NULL DEFAULT '',
  client_id TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX idx_alias (alias),
  UNIQUE INDEX idx_client_id_parent_id_alias_language (client_id, parent_id, alias, language),
  INDEX idx_componentid (component_id, menutype, published, access),
  INDEX idx_language (language),
  INDEX idx_left_right (lft, rgt),
  INDEX idx_menutype (menutype),
  INDEX idx_path (path(333))
)
ENGINE = MYISAM
AUTO_INCREMENT = 170
AVG_ROW_LENGTH = 385
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_menu_types
--
DROP TABLE IF EXISTS auc13_menu_types;
CREATE TABLE auc13_menu_types (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  menutype VARCHAR(24) NOT NULL,
  title VARCHAR(48) NOT NULL,
  description VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE INDEX idx_menutype (menutype)
)
ENGINE = MYISAM
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 129
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_messages
--
DROP TABLE IF EXISTS auc13_messages;
CREATE TABLE auc13_messages (
  message_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id_from INT(10) UNSIGNED NOT NULL DEFAULT 0,
  user_id_to INT(10) UNSIGNED NOT NULL DEFAULT 0,
  folder_id TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
  date_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  state TINYINT(1) NOT NULL DEFAULT 0,
  priority TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  subject VARCHAR(255) NOT NULL DEFAULT '',
  message TEXT NOT NULL,
  PRIMARY KEY (message_id),
  INDEX useridto_state (user_id_to, state)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_messages_cfg
--
DROP TABLE IF EXISTS auc13_messages_cfg;
CREATE TABLE auc13_messages_cfg (
  user_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  cfg_name VARCHAR(100) NOT NULL DEFAULT '',
  cfg_value VARCHAR(255) NOT NULL DEFAULT '',
  UNIQUE INDEX idx_user_var_name (user_id, cfg_name)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_modules
--
DROP TABLE IF EXISTS auc13_modules;
CREATE TABLE auc13_modules (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL DEFAULT '',
  note VARCHAR(255) NOT NULL DEFAULT '',
  content TEXT NOT NULL,
  ordering INT(11) NOT NULL DEFAULT 0,
  position VARCHAR(50) NOT NULL DEFAULT '',
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  published TINYINT(1) NOT NULL DEFAULT 0,
  module VARCHAR(50) DEFAULT NULL,
  access INT(10) UNSIGNED NOT NULL DEFAULT 0,
  showtitle TINYINT(3) UNSIGNED NOT NULL DEFAULT 1,
  params TEXT NOT NULL,
  client_id TINYINT(4) NOT NULL DEFAULT 0,
  language CHAR(7) NOT NULL,
  PRIMARY KEY (id),
  INDEX idx_language (language),
  INDEX newsfeeds (module, published),
  INDEX published (published, access)
)
ENGINE = MYISAM
AUTO_INCREMENT = 105
AVG_ROW_LENGTH = 538
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_modules_menu
--
DROP TABLE IF EXISTS auc13_modules_menu;
CREATE TABLE auc13_modules_menu (
  moduleid INT(11) NOT NULL DEFAULT 0,
  menuid INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (moduleid, menuid)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 9
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_newsfeeds
--
DROP TABLE IF EXISTS auc13_newsfeeds;
CREATE TABLE auc13_newsfeeds (
  catid INT(11) NOT NULL DEFAULT 0,
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL DEFAULT '',
  alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  link VARCHAR(200) NOT NULL DEFAULT '',
  filename VARCHAR(200) DEFAULT NULL,
  published TINYINT(1) NOT NULL DEFAULT 0,
  numarticles INT(10) UNSIGNED NOT NULL DEFAULT 1,
  cache_time INT(10) UNSIGNED NOT NULL DEFAULT 3600,
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  ordering INT(11) NOT NULL DEFAULT 0,
  rtl TINYINT(4) NOT NULL DEFAULT 0,
  access INT(10) UNSIGNED NOT NULL DEFAULT 0,
  language CHAR(7) NOT NULL DEFAULT '',
  params TEXT NOT NULL,
  created DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_by_alias VARCHAR(255) NOT NULL DEFAULT '',
  modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  metakey TEXT NOT NULL,
  metadesc TEXT NOT NULL,
  metadata TEXT NOT NULL,
  xreference VARCHAR(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  INDEX idx_access (access),
  INDEX idx_catid (catid),
  INDEX idx_checkout (checked_out),
  INDEX idx_createdby (created_by),
  INDEX idx_language (language),
  INDEX idx_state (published),
  INDEX idx_xreference (xreference)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_overrider
--
DROP TABLE IF EXISTS auc13_overrider;
CREATE TABLE auc13_overrider (
  id INT(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  constant VARCHAR(255) NOT NULL,
  string TEXT NOT NULL,
  file VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_product_favorites
--
DROP TABLE IF EXISTS auc13_product_favorites;
CREATE TABLE auc13_product_favorites (
  id INT(11) NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(11) NOT NULL,
  user_id INT(11) DEFAULT NULL,
  datetime DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 15
AVG_ROW_LENGTH = 21
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Избранное';

--
-- Описание для таблицы auc13_redirect_links
--
DROP TABLE IF EXISTS auc13_redirect_links;
CREATE TABLE auc13_redirect_links (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  old_url VARCHAR(255) NOT NULL,
  new_url VARCHAR(255) NOT NULL,
  referer VARCHAR(150) NOT NULL,
  comment VARCHAR(255) NOT NULL,
  hits INT(10) UNSIGNED NOT NULL DEFAULT 0,
  published TINYINT(4) NOT NULL,
  created_date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  INDEX idx_link_modifed (modified_date),
  UNIQUE INDEX idx_link_old (old_url)
)
ENGINE = MYISAM
AUTO_INCREMENT = 40
AVG_ROW_LENGTH = 143
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_schemas
--
DROP TABLE IF EXISTS auc13_schemas;
CREATE TABLE auc13_schemas (
  extension_id INT(11) NOT NULL,
  version_id VARCHAR(20) NOT NULL,
  PRIMARY KEY (extension_id, version_id)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 20
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_session
--
DROP TABLE IF EXISTS auc13_session;
CREATE TABLE auc13_session (
  session_id VARCHAR(200) NOT NULL DEFAULT '',
  client_id TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
  guest TINYINT(4) UNSIGNED DEFAULT 1,
  time VARCHAR(14) DEFAULT '',
  data MEDIUMTEXT DEFAULT NULL,
  userid INT(11) DEFAULT 0,
  username VARCHAR(150) DEFAULT '',
  usertype VARCHAR(50) DEFAULT '',
  PRIMARY KEY (session_id),
  INDEX time (time),
  INDEX userid (userid),
  INDEX whosonline (guest, usertype)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 8684
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_template_styles
--
DROP TABLE IF EXISTS auc13_template_styles;
CREATE TABLE auc13_template_styles (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  template VARCHAR(50) NOT NULL DEFAULT '',
  client_id TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  home CHAR(7) NOT NULL DEFAULT '0',
  title VARCHAR(255) NOT NULL DEFAULT '',
  params TEXT NOT NULL,
  PRIMARY KEY (id),
  INDEX idx_home (home),
  INDEX idx_template (template)
)
ENGINE = MYISAM
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 72
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_update_categories
--
DROP TABLE IF EXISTS auc13_update_categories;
CREATE TABLE auc13_update_categories (
  categoryid INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) DEFAULT '',
  description TEXT NOT NULL,
  parent INT(11) DEFAULT 0,
  updatesite INT(11) DEFAULT 0,
  PRIMARY KEY (categoryid)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Update Categories';

--
-- Описание для таблицы auc13_update_sites
--
DROP TABLE IF EXISTS auc13_update_sites;
CREATE TABLE auc13_update_sites (
  update_site_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) DEFAULT '',
  type VARCHAR(20) DEFAULT '',
  location TEXT NOT NULL,
  enabled INT(11) DEFAULT 0,
  last_check_timestamp BIGINT(20) DEFAULT 0,
  PRIMARY KEY (update_site_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 128
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Update Sites';

--
-- Описание для таблицы auc13_update_sites_extensions
--
DROP TABLE IF EXISTS auc13_update_sites_extensions;
CREATE TABLE auc13_update_sites_extensions (
  update_site_id INT(11) NOT NULL DEFAULT 0,
  extension_id INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (update_site_id, extension_id)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 9
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Links extensions to update sites';

--
-- Описание для таблицы auc13_updates
--
DROP TABLE IF EXISTS auc13_updates;
CREATE TABLE auc13_updates (
  update_id INT(11) NOT NULL AUTO_INCREMENT,
  update_site_id INT(11) DEFAULT 0,
  extension_id INT(11) DEFAULT 0,
  categoryid INT(11) DEFAULT 0,
  name VARCHAR(100) DEFAULT '',
  description TEXT NOT NULL,
  element VARCHAR(100) DEFAULT '',
  type VARCHAR(20) DEFAULT '',
  folder VARCHAR(20) DEFAULT '',
  client_id TINYINT(3) DEFAULT 0,
  version VARCHAR(10) DEFAULT '',
  data TEXT NOT NULL,
  detailsurl TEXT NOT NULL,
  infourl TEXT NOT NULL,
  PRIMARY KEY (update_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 82
AVG_ROW_LENGTH = 114
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Available Updates';

--
-- Описание для таблицы auc13_user_notes
--
DROP TABLE IF EXISTS auc13_user_notes;
CREATE TABLE auc13_user_notes (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  catid INT(10) UNSIGNED NOT NULL DEFAULT 0,
  subject VARCHAR(100) NOT NULL DEFAULT '',
  body TEXT NOT NULL,
  state TINYINT(3) NOT NULL DEFAULT 0,
  checked_out INT(10) UNSIGNED NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_user_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_user_id INT(10) UNSIGNED NOT NULL,
  modified_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  review_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  INDEX idx_category_id (catid),
  INDEX idx_user_id (user_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_user_profiles
--
DROP TABLE IF EXISTS auc13_user_profiles;
CREATE TABLE auc13_user_profiles (
  user_id INT(11) NOT NULL,
  profile_key VARCHAR(100) NOT NULL,
  profile_value VARCHAR(255) NOT NULL,
  ordering INT(11) NOT NULL DEFAULT 0,
  UNIQUE INDEX idx_user_id_profile_key (user_id, profile_key)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 48
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Simple user profile storage table';

--
-- Описание для таблицы auc13_user_usergroup_map
--
DROP TABLE IF EXISTS auc13_user_usergroup_map;
CREATE TABLE auc13_user_usergroup_map (
  user_id INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Foreign Key to #__users.id',
  group_id INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (user_id, group_id)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 9
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_usergroups
--
DROP TABLE IF EXISTS auc13_usergroups;
CREATE TABLE auc13_usergroups (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  parent_id INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Adjacency List Reference Id',
  lft INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set lft.',
  rgt INT(11) NOT NULL DEFAULT 0 COMMENT 'Nested set rgt.',
  title VARCHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  INDEX idx_usergroup_adjacency_lookup (parent_id),
  INDEX idx_usergroup_nested_set_lookup (lft, rgt),
  UNIQUE INDEX idx_usergroup_parent_title_lookup (parent_id, title),
  INDEX idx_usergroup_title_lookup (title)
)
ENGINE = MYISAM
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 30
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_users
--
DROP TABLE IF EXISTS auc13_users;
CREATE TABLE auc13_users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL DEFAULT '',
  middlename VARCHAR(150) NOT NULL COMMENT 'Отчество',
  lastname VARCHAR(200) NOT NULL COMMENT 'Фамилия',
  username VARCHAR(150) NOT NULL DEFAULT '',
  email VARCHAR(100) NOT NULL DEFAULT '',
  password VARCHAR(100) NOT NULL DEFAULT '',
  usertype VARCHAR(25) NOT NULL DEFAULT '',
  block TINYINT(4) NOT NULL DEFAULT 0,
  sendEmail TINYINT(4) DEFAULT 0,
  registerDate DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  lastvisitDate DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  company_name VARCHAR(60) NOT NULL COMMENT 'Орг-я',
  country_id INT(11) NOT NULL COMMENT 'id страны',
  zip VARCHAR(12) NOT NULL COMMENT 'zip',
  city VARCHAR(60) NOT NULL COMMENT 'Город',
  street VARCHAR(60) NOT NULL COMMENT 'Улица',
  house_number TEXT NOT NULL COMMENT '№ дома',
  corpus_number TEXT NOT NULL COMMENT '№ корпуса',
  flat_office_number TEXT NOT NULL COMMENT '№ квартиры или офиса',
  phone_number TEXT NOT NULL COMMENT '№ тел.',
  phone2_number TEXT NOT NULL COMMENT '№ доп. телефона',
  activation VARCHAR(100) NOT NULL DEFAULT '',
  params TEXT NOT NULL,
  lastResetTime DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  resetCount INT(11) NOT NULL DEFAULT 0 COMMENT 'Count of password resets since lastResetTime',
  PRIMARY KEY (id),
  INDEX email (email),
  INDEX idx_block (block),
  INDEX idx_name (name),
  INDEX username (username),
  INDEX usertype (usertype)
)
ENGINE = MYISAM
AUTO_INCREMENT = 369
AVG_ROW_LENGTH = 254
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_viewlevels
--
DROP TABLE IF EXISTS auc13_viewlevels;
CREATE TABLE auc13_viewlevels (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  title VARCHAR(100) NOT NULL DEFAULT '',
  ordering INT(11) NOT NULL DEFAULT 0,
  rules VARCHAR(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (id),
  UNIQUE INDEX idx_assetgroup_title_lookup (title)
)
ENGINE = MYISAM
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 26
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_adminmenuentries
--
DROP TABLE IF EXISTS auc13_virtuemart_adminmenuentries;
CREATE TABLE auc13_virtuemart_adminmenuentries (
  id TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  module_id TINYINT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The ID of the VM Module, this Item is assigned to',
  parent_id TINYINT(11) UNSIGNED NOT NULL DEFAULT 0,
  name CHAR(64) NOT NULL DEFAULT '0',
  link CHAR(64) NOT NULL DEFAULT '0',
  depends CHAR(64) NOT NULL DEFAULT '' COMMENT 'Names of the Parameters, this Item depends on',
  icon_class CHAR(96) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  tooltip CHAR(128) DEFAULT NULL,
  view CHAR(32) DEFAULT NULL,
  task CHAR(32) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX module_id (module_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 29
AVG_ROW_LENGTH = 1449
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Administration Menu Items';

--
-- Описание для таблицы auc13_virtuemart_calc_categories
--
DROP TABLE IF EXISTS auc13_virtuemart_calc_categories;
CREATE TABLE auc13_virtuemart_calc_categories (
  id MEDIUMINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_calc_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_category_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_calc_id (virtuemart_calc_id, virtuemart_category_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_calc_countries
--
DROP TABLE IF EXISTS auc13_virtuemart_calc_countries;
CREATE TABLE auc13_virtuemart_calc_countries (
  id MEDIUMINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_calc_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_country_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_calc_id (virtuemart_calc_id, virtuemart_country_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_calc_shoppergroups
--
DROP TABLE IF EXISTS auc13_virtuemart_calc_shoppergroups;
CREATE TABLE auc13_virtuemart_calc_shoppergroups (
  id MEDIUMINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_calc_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_shoppergroup_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_calc_id (virtuemart_calc_id, virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_calc_states
--
DROP TABLE IF EXISTS auc13_virtuemart_calc_states;
CREATE TABLE auc13_virtuemart_calc_states (
  id MEDIUMINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_calc_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_state_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_calc_id (virtuemart_calc_id, virtuemart_state_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_calcs
--
DROP TABLE IF EXISTS auc13_virtuemart_calcs;
CREATE TABLE auc13_virtuemart_calcs (
  virtuemart_calc_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Belongs to vendor',
  calc_jplugin_id INT(11) NOT NULL DEFAULT 0,
  calc_name CHAR(64) NOT NULL DEFAULT '' COMMENT 'Name of the rule',
  calc_descr CHAR(128) NOT NULL DEFAULT '' COMMENT 'Description',
  calc_kind CHAR(16) NOT NULL DEFAULT '' COMMENT 'Discount/Tax/Margin/Commission',
  calc_value_mathop CHAR(8) NOT NULL DEFAULT '' COMMENT 'the mathematical operation like (+,-,+%,-%)',
  calc_value DECIMAL(10, 4) NOT NULL DEFAULT 0.0000 COMMENT 'The Amount',
  calc_currency SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Currency of the Rule',
  calc_shopper_published TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Visible for Shoppers',
  calc_vendor_published TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Visible for Vendors',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Startdate if nothing is set = permanent',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Enddate if nothing is set = permanent',
  for_override TINYINT(1) NOT NULL DEFAULT 0,
  calc_params VARCHAR(18000) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_calc_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_categories
--
DROP TABLE IF EXISTS auc13_virtuemart_categories;
CREATE TABLE auc13_virtuemart_categories (
  virtuemart_category_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  category_template CHAR(128) DEFAULT NULL,
  category_layout CHAR(64) DEFAULT NULL,
  category_product_layout CHAR(64) DEFAULT NULL,
  products_per_row TINYINT(2) DEFAULT NULL,
  limit_list_start SMALLINT(1) UNSIGNED DEFAULT NULL,
  limit_list_step SMALLINT(1) UNSIGNED DEFAULT NULL,
  limit_list_max SMALLINT(1) UNSIGNED DEFAULT NULL,
  limit_list_initial SMALLINT(1) UNSIGNED DEFAULT NULL,
  hits INT(1) UNSIGNED NOT NULL DEFAULT 0,
  metarobot CHAR(40) NOT NULL DEFAULT '',
  metaauthor CHAR(64) NOT NULL DEFAULT '',
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_category_id),
  INDEX idx_category_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 52
AVG_ROW_LENGTH = 1141
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Product Categories are stored here';

--
-- Описание для таблицы auc13_virtuemart_categories_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_categories_ru_ru;
CREATE TABLE auc13_virtuemart_categories_ru_ru (
  virtuemart_category_id INT(1) UNSIGNED NOT NULL,
  category_name CHAR(180) NOT NULL DEFAULT '',
  category_description VARCHAR(20000) NOT NULL DEFAULT '',
  metadesc VARCHAR(400) NOT NULL DEFAULT '',
  metakey VARCHAR(400) NOT NULL DEFAULT '',
  customtitle CHAR(255) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_category_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 71
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_category_categories
--
DROP TABLE IF EXISTS auc13_virtuemart_category_categories;
CREATE TABLE auc13_virtuemart_category_categories (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  category_parent_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  category_child_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX category_child_id (category_child_id),
  UNIQUE INDEX i_category_parent_id (category_parent_id, category_child_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 52
AVG_ROW_LENGTH = 17
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Category child-parent relation list';

--
-- Описание для таблицы auc13_virtuemart_category_medias
--
DROP TABLE IF EXISTS auc13_virtuemart_category_medias;
CREATE TABLE auc13_virtuemart_category_medias (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_category_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_media_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_category_id (virtuemart_category_id, virtuemart_media_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 15
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_configs
--
DROP TABLE IF EXISTS auc13_virtuemart_configs;
CREATE TABLE auc13_virtuemart_configs (
  virtuemart_config_id TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  config TEXT DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_config_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 5280
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Holds configuration settings';

--
-- Описание для таблицы auc13_virtuemart_countries
--
DROP TABLE IF EXISTS auc13_virtuemart_countries;
CREATE TABLE auc13_virtuemart_countries (
  virtuemart_country_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_worldzone_id TINYINT(11) NOT NULL DEFAULT 1,
  country_name CHAR(64) DEFAULT NULL,
  country_3_code CHAR(3) DEFAULT NULL,
  country_2_code CHAR(2) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_country_id),
  INDEX idx_country_2_code (country_2_code),
  INDEX idx_country_3_code (country_3_code)
)
ENGINE = MYISAM
AUTO_INCREMENT = 249
AVG_ROW_LENGTH = 252
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Country records';

--
-- Описание для таблицы auc13_virtuemart_coupons
--
DROP TABLE IF EXISTS auc13_virtuemart_coupons;
CREATE TABLE auc13_virtuemart_coupons (
  virtuemart_coupon_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  coupon_code CHAR(32) NOT NULL DEFAULT '',
  percent_or_total ENUM('percent','total') NOT NULL DEFAULT 'percent',
  coupon_type ENUM('gift','permanent') NOT NULL DEFAULT 'gift',
  coupon_value DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  coupon_start_date DATETIME DEFAULT NULL,
  coupon_expiry_date DATETIME DEFAULT NULL,
  coupon_value_valid DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_coupon_id),
  INDEX idx_coupon_code (coupon_code)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Used to store coupon codes';

--
-- Описание для таблицы auc13_virtuemart_currencies
--
DROP TABLE IF EXISTS auc13_virtuemart_currencies;
CREATE TABLE auc13_virtuemart_currencies (
  virtuemart_currency_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  currency_name CHAR(64) DEFAULT NULL,
  currency_code_2 CHAR(2) DEFAULT NULL,
  currency_code_3 CHAR(3) DEFAULT NULL,
  currency_numeric_code INT(4) DEFAULT NULL,
  currency_exchange_rate DECIMAL(10, 5) DEFAULT NULL,
  currency_symbol CHAR(4) DEFAULT NULL,
  currency_decimal_place CHAR(4) DEFAULT NULL,
  currency_decimal_symbol CHAR(4) DEFAULT NULL,
  currency_thousands CHAR(4) DEFAULT NULL,
  currency_positive_style CHAR(64) DEFAULT NULL,
  currency_negative_style CHAR(64) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 1,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_currency_id),
  INDEX idx_currency_code_3 (currency_code_3),
  INDEX idx_currency_numeric_code (currency_numeric_code),
  INDEX virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 202
AVG_ROW_LENGTH = 697
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Used to store currencies';

--
-- Описание для таблицы auc13_virtuemart_customs
--
DROP TABLE IF EXISTS auc13_virtuemart_customs;
CREATE TABLE auc13_virtuemart_customs (
  virtuemart_custom_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  custom_parent_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  custom_jplugin_id INT(11) NOT NULL DEFAULT 0,
  custom_element CHAR(50) NOT NULL DEFAULT '',
  admin_only TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1:Display in admin only',
  custom_title CHAR(255) NOT NULL DEFAULT '' COMMENT 'field title',
  custom_tip CHAR(255) NOT NULL DEFAULT '' COMMENT 'tip',
  custom_value CHAR(255) DEFAULT NULL COMMENT 'defaut value',
  custom_field_desc CHAR(255) DEFAULT NULL COMMENT 'description or unit',
  field_type CHAR(1) NOT NULL DEFAULT '0' COMMENT 'S:string,I:int,P:parent, B:bool,D:date,T:time,H:hidden',
  is_list TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'list of values',
  is_hidden TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1:hidden',
  is_cart_attribute TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Add attributes to cart',
  layout_pos CHAR(24) DEFAULT NULL COMMENT 'Layout Position',
  custom_params TEXT DEFAULT NULL,
  shared TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'valide for all vendors?',
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_custom_id),
  INDEX idx_custom_parent_id (custom_parent_id),
  INDEX idx_custom_plugin_element (custom_element),
  INDEX idx_custom_plugin_ordering (ordering),
  INDEX idx_custom_plugin_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 21
AVG_ROW_LENGTH = 84
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'custom fields definition';

--
-- Описание для таблицы auc13_virtuemart_invoices
--
DROP TABLE IF EXISTS auc13_virtuemart_invoices;
CREATE TABLE auc13_virtuemart_invoices (
  virtuemart_invoice_id INT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  virtuemart_order_id INT(1) UNSIGNED DEFAULT NULL,
  invoice_number CHAR(64) DEFAULT NULL,
  order_status CHAR(2) DEFAULT NULL,
  xhtml TEXT DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_invoice_id),
  UNIQUE INDEX idx_invoice_number (invoice_number, virtuemart_vendor_id),
  INDEX idx_virtuemart_order_id (virtuemart_order_id),
  INDEX idx_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'custom fields definition';

--
-- Описание для таблицы auc13_virtuemart_manufacturer_medias
--
DROP TABLE IF EXISTS auc13_virtuemart_manufacturer_medias;
CREATE TABLE auc13_virtuemart_manufacturer_medias (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_manufacturer_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_media_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_manufacturer_id (virtuemart_manufacturer_id, virtuemart_media_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_manufacturercategories
--
DROP TABLE IF EXISTS auc13_virtuemart_manufacturercategories;
CREATE TABLE auc13_virtuemart_manufacturercategories (
  virtuemart_manufacturercategories_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_manufacturercategories_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 42
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Manufacturers are assigned to these categories';

--
-- Описание для таблицы auc13_virtuemart_manufacturercategories_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_manufacturercategories_ru_ru;
CREATE TABLE auc13_virtuemart_manufacturercategories_ru_ru (
  virtuemart_manufacturercategories_id INT(1) UNSIGNED NOT NULL,
  mf_category_name CHAR(180) NOT NULL DEFAULT '',
  mf_category_desc VARCHAR(20000) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_manufacturercategories_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 152
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_manufacturers
--
DROP TABLE IF EXISTS auc13_virtuemart_manufacturers;
CREATE TABLE auc13_virtuemart_manufacturers (
  virtuemart_manufacturer_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_manufacturercategories_id INT(11) DEFAULT NULL,
  hits INT(11) UNSIGNED NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_manufacturer_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 48
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Manufacturers are those who deliver products';

--
-- Описание для таблицы auc13_virtuemart_manufacturers_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_manufacturers_ru_ru;
CREATE TABLE auc13_virtuemart_manufacturers_ru_ru (
  virtuemart_manufacturer_id INT(1) UNSIGNED NOT NULL,
  mf_name CHAR(180) NOT NULL DEFAULT '',
  mf_email CHAR(255) NOT NULL DEFAULT '',
  mf_desc VARCHAR(20000) NOT NULL DEFAULT '',
  mf_url CHAR(255) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_manufacturer_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 92
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_medias
--
DROP TABLE IF EXISTS auc13_virtuemart_medias;
CREATE TABLE auc13_virtuemart_medias (
  virtuemart_media_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  file_title CHAR(126) NOT NULL DEFAULT '',
  file_description CHAR(254) NOT NULL DEFAULT '',
  file_meta CHAR(254) NOT NULL DEFAULT '',
  file_mimetype CHAR(64) NOT NULL DEFAULT '',
  file_type CHAR(32) NOT NULL DEFAULT '',
  file_url VARCHAR(1800) NOT NULL DEFAULT '',
  file_url_thumb CHAR(254) NOT NULL DEFAULT '',
  file_is_product_image TINYINT(1) NOT NULL DEFAULT 0,
  file_is_downloadable TINYINT(1) NOT NULL DEFAULT 0,
  file_is_forSale TINYINT(1) NOT NULL DEFAULT 0,
  file_params VARCHAR(19000) DEFAULT NULL,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_media_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2273
AVG_ROW_LENGTH = 195
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Additional Images and Files which are assigned to products';

--
-- Описание для таблицы auc13_virtuemart_migration_oldtonew_ids
--
DROP TABLE IF EXISTS auc13_virtuemart_migration_oldtonew_ids;
CREATE TABLE auc13_virtuemart_migration_oldtonew_ids (
  id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  cats LONGBLOB DEFAULT NULL,
  catsxref BLOB DEFAULT NULL,
  manus LONGBLOB DEFAULT NULL,
  mfcats BLOB DEFAULT NULL,
  shoppergroups LONGBLOB DEFAULT NULL,
  products LONGBLOB DEFAULT NULL,
  products_start INT(1) DEFAULT NULL,
  orderstates BLOB DEFAULT NULL,
  orders LONGBLOB DEFAULT NULL,
  orders_start INT(1) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'xref table for vm1 ids to vm2 ids';

--
-- Описание для таблицы auc13_virtuemart_modules
--
DROP TABLE IF EXISTS auc13_virtuemart_modules;
CREATE TABLE auc13_virtuemart_modules (
  module_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  module_name CHAR(255) DEFAULT NULL,
  module_description VARCHAR(21000) DEFAULT NULL,
  module_perms CHAR(255) DEFAULT NULL,
  published TINYINT(1) NOT NULL DEFAULT 1,
  is_admin ENUM('0','1') NOT NULL DEFAULT '0',
  ordering INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (module_id),
  INDEX idx_module_name (module_name),
  INDEX idx_module_ordering (ordering)
)
ENGINE = MYISAM
AUTO_INCREMENT = 14
AVG_ROW_LENGTH = 130
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'VirtueMart Core Modules, not: Joomla modules';

--
-- Описание для таблицы auc13_virtuemart_order_calc_rules
--
DROP TABLE IF EXISTS auc13_virtuemart_order_calc_rules;
CREATE TABLE auc13_virtuemart_order_calc_rules (
  virtuemart_order_calc_rule_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_order_id INT(11) DEFAULT NULL,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  virtuemart_order_item_id INT(11) DEFAULT NULL,
  calc_rule_name CHAR(64) NOT NULL DEFAULT '' COMMENT 'Name of the rule',
  calc_kind CHAR(16) NOT NULL DEFAULT '' COMMENT 'Discount/Tax/Margin/Commission',
  calc_mathop CHAR(16) NOT NULL DEFAULT '' COMMENT 'Discount/Tax/Margin/Commission',
  calc_amount DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  calc_value DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  calc_currency SMALLINT(1) DEFAULT NULL,
  calc_params VARCHAR(18000) DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_order_calc_rule_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores all calculation rules which are part of an order';

--
-- Описание для таблицы auc13_virtuemart_order_histories
--
DROP TABLE IF EXISTS auc13_virtuemart_order_histories;
CREATE TABLE auc13_virtuemart_order_histories (
  virtuemart_order_history_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_order_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  order_status_code CHAR(1) NOT NULL DEFAULT '0',
  customer_notified TINYINT(1) NOT NULL DEFAULT 0,
  comments VARCHAR(21000) DEFAULT NULL,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_order_history_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores all actions and changes that occur to an order';

--
-- Описание для таблицы auc13_virtuemart_order_items
--
DROP TABLE IF EXISTS auc13_virtuemart_order_items;
CREATE TABLE auc13_virtuemart_order_items (
  virtuemart_order_item_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_order_id INT(11) DEFAULT NULL,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  virtuemart_product_id INT(11) DEFAULT NULL,
  order_item_sku CHAR(64) NOT NULL DEFAULT '',
  order_item_name CHAR(255) NOT NULL DEFAULT '',
  product_quantity INT(11) DEFAULT NULL,
  product_item_price DECIMAL(15, 5) DEFAULT NULL,
  product_tax DECIMAL(15, 5) DEFAULT NULL,
  product_basePriceWithTax DECIMAL(15, 5) DEFAULT NULL,
  product_final_price DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  product_subtotal_discount DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  product_subtotal_with_tax DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  order_item_currency INT(11) DEFAULT NULL,
  order_status CHAR(1) DEFAULT NULL,
  product_attribute TEXT DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_order_item_id),
  INDEX idx_order_item_virtuemart_order_id (virtuemart_order_id),
  INDEX idx_order_item_virtuemart_vendor_id (virtuemart_vendor_id),
  INDEX virtuemart_product_id (virtuemart_product_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores all items (products) which are part of an order';

--
-- Описание для таблицы auc13_virtuemart_order_userinfos
--
DROP TABLE IF EXISTS auc13_virtuemart_order_userinfos;
CREATE TABLE auc13_virtuemart_order_userinfos (
  virtuemart_order_userinfo_id INT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_order_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_user_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  address_type CHAR(2) DEFAULT NULL,
  address_type_name CHAR(32) DEFAULT NULL,
  company CHAR(64) DEFAULT NULL,
  title CHAR(32) DEFAULT NULL,
  last_name CHAR(32) DEFAULT NULL,
  first_name CHAR(32) DEFAULT NULL,
  middle_name CHAR(32) DEFAULT NULL,
  phone_1 CHAR(24) DEFAULT NULL,
  phone_2 CHAR(24) DEFAULT NULL,
  fax CHAR(24) DEFAULT NULL,
  address_1 CHAR(64) NOT NULL DEFAULT '',
  address_2 CHAR(64) DEFAULT NULL,
  city CHAR(32) NOT NULL DEFAULT '',
  virtuemart_state_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_country_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  zip CHAR(16) NOT NULL DEFAULT '',
  email CHAR(255) DEFAULT NULL,
  agreed TINYINT(1) NOT NULL DEFAULT 0,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_order_userinfo_id),
  INDEX i_virtuemart_order_id (virtuemart_order_id),
  INDEX i_virtuemart_user_id (virtuemart_user_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores the BillTo and ShipTo Information at order time';

--
-- Описание для таблицы auc13_virtuemart_orders
--
DROP TABLE IF EXISTS auc13_virtuemart_orders;
CREATE TABLE auc13_virtuemart_orders (
  virtuemart_order_id INT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_user_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  order_number CHAR(64) DEFAULT NULL,
  order_pass CHAR(8) DEFAULT NULL,
  order_total DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  order_salesPrice DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  order_billTaxAmount DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  order_billDiscountAmount DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  order_discountAmount DECIMAL(15, 5) NOT NULL DEFAULT 0.00000,
  order_subtotal DECIMAL(15, 5) DEFAULT NULL,
  order_tax DECIMAL(10, 5) DEFAULT NULL,
  order_shipment DECIMAL(10, 2) DEFAULT NULL,
  order_shipment_tax DECIMAL(10, 5) DEFAULT NULL,
  order_payment DECIMAL(10, 2) DEFAULT NULL,
  order_payment_tax DECIMAL(10, 5) DEFAULT NULL,
  coupon_discount DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
  coupon_code CHAR(32) DEFAULT NULL,
  order_discount DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
  order_currency SMALLINT(1) DEFAULT NULL,
  order_status CHAR(1) DEFAULT NULL,
  user_currency_id SMALLINT(1) DEFAULT NULL,
  user_currency_rate DECIMAL(10, 5) NOT NULL DEFAULT 1.00000,
  virtuemart_paymentmethod_id MEDIUMINT(1) UNSIGNED DEFAULT NULL,
  virtuemart_shipmentmethod_id MEDIUMINT(1) UNSIGNED DEFAULT NULL,
  customer_note VARCHAR(21000) DEFAULT NULL,
  ip_address CHAR(15) NOT NULL DEFAULT '',
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_order_id),
  INDEX idx_orders_order_number (order_number),
  INDEX idx_orders_virtuemart_paymentmethod_id (virtuemart_paymentmethod_id),
  INDEX idx_orders_virtuemart_shipmentmethod_id (virtuemart_shipmentmethod_id),
  INDEX idx_orders_virtuemart_user_id (virtuemart_user_id),
  INDEX idx_orders_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Used to store all orders';

--
-- Описание для таблицы auc13_virtuemart_orderstates
--
DROP TABLE IF EXISTS auc13_virtuemart_orderstates;
CREATE TABLE auc13_virtuemart_orderstates (
  virtuemart_orderstate_id TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  order_status_code CHAR(1) NOT NULL DEFAULT '',
  order_status_name CHAR(64) DEFAULT NULL,
  order_status_description VARCHAR(20000) DEFAULT NULL,
  order_stock_handle CHAR(1) NOT NULL DEFAULT 'A',
  ordering INT(2) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_orderstate_id),
  INDEX idx_order_status_ordering (ordering),
  INDEX idx_order_status_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 8
AVG_ROW_LENGTH = 41
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'All available order statuses';

--
-- Описание для таблицы auc13_virtuemart_paymentmethod_shoppergroups
--
DROP TABLE IF EXISTS auc13_virtuemart_paymentmethod_shoppergroups;
CREATE TABLE auc13_virtuemart_paymentmethod_shoppergroups (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_paymentmethod_id MEDIUMINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_shoppergroup_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_paymentmethod_id (virtuemart_paymentmethod_id, virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'xref table for paymentmethods to shoppergroup';

--
-- Описание для таблицы auc13_virtuemart_paymentmethods
--
DROP TABLE IF EXISTS auc13_virtuemart_paymentmethods;
CREATE TABLE auc13_virtuemart_paymentmethods (
  virtuemart_paymentmethod_id MEDIUMINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  payment_jplugin_id INT(11) NOT NULL DEFAULT 0,
  slug CHAR(255) NOT NULL DEFAULT '',
  payment_element CHAR(50) NOT NULL DEFAULT '',
  payment_params VARCHAR(19000) DEFAULT NULL,
  shared TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'valide for all vendors?',
  ordering INT(2) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_paymentmethod_id),
  INDEX idx_payment_element (payment_element, virtuemart_vendor_id),
  INDEX idx_payment_jplugin_id (payment_jplugin_id),
  INDEX idx_payment_method_ordering (ordering)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'The payment methods of your store';

--
-- Описание для таблицы auc13_virtuemart_paymentmethods_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_paymentmethods_ru_ru;
CREATE TABLE auc13_virtuemart_paymentmethods_ru_ru (
  virtuemart_paymentmethod_id INT(1) UNSIGNED NOT NULL,
  payment_name CHAR(180) NOT NULL DEFAULT '',
  payment_desc VARCHAR(20000) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_paymentmethod_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_permgroups
--
DROP TABLE IF EXISTS auc13_virtuemart_permgroups;
CREATE TABLE auc13_virtuemart_permgroups (
  virtuemart_permgroup_id TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  group_name CHAR(128) DEFAULT NULL,
  group_level INT(11) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_permgroup_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 434
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Holds all the user groups';

--
-- Описание для таблицы auc13_virtuemart_product_categories
--
DROP TABLE IF EXISTS auc13_virtuemart_product_categories;
CREATE TABLE auc13_virtuemart_product_categories (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_category_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, virtuemart_category_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 476
AVG_ROW_LENGTH = 15
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Maps Products to Categories';

--
-- Описание для таблицы auc13_virtuemart_product_customfields
--
DROP TABLE IF EXISTS auc13_virtuemart_product_customfields;
CREATE TABLE auc13_virtuemart_product_customfields (
  virtuemart_customfield_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'field id',
  virtuemart_product_id INT(11) NOT NULL DEFAULT 0,
  virtuemart_custom_id INT(11) NOT NULL DEFAULT 1 COMMENT 'custom group id',
  custom_value VARCHAR(8000) DEFAULT NULL COMMENT 'field value',
  custom_price DECIMAL(15, 5) DEFAULT NULL COMMENT 'price',
  custom_param VARCHAR(12800) DEFAULT NULL COMMENT 'Param for Plugins',
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(1) UNSIGNED NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(1) UNSIGNED NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_customfield_id),
  INDEX idx_custom_value (custom_value(333)),
  INDEX idx_virtuemart_custom_id (virtuemart_custom_id),
  INDEX idx_virtuemart_product_id (virtuemart_product_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 16
AVG_ROW_LENGTH = 60
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'custom fields';

--
-- Описание для таблицы auc13_virtuemart_product_manufacturers
--
DROP TABLE IF EXISTS auc13_virtuemart_product_manufacturers;
CREATE TABLE auc13_virtuemart_product_manufacturers (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(11) DEFAULT NULL,
  virtuemart_manufacturer_id SMALLINT(1) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, virtuemart_manufacturer_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 11
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Maps a product to a manufacturer';

--
-- Описание для таблицы auc13_virtuemart_product_medias
--
DROP TABLE IF EXISTS auc13_virtuemart_product_medias;
CREATE TABLE auc13_virtuemart_product_medias (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_media_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, virtuemart_media_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2055
AVG_ROW_LENGTH = 17
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_product_prices
--
DROP TABLE IF EXISTS auc13_virtuemart_product_prices;
CREATE TABLE auc13_virtuemart_product_prices (
  virtuemart_product_price_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_shoppergroup_id INT(11) DEFAULT NULL,
  product_price DECIMAL(15, 5) DEFAULT NULL,
  override TINYINT(1) DEFAULT NULL,
  product_override_price DECIMAL(15, 5) DEFAULT NULL,
  product_tax_id INT(11) DEFAULT NULL,
  product_discount_id INT(11) DEFAULT NULL,
  product_currency SMALLINT(1) DEFAULT NULL,
  product_price_publish_up DATETIME DEFAULT NULL,
  product_price_publish_down DATETIME DEFAULT NULL,
  price_quantity_start INT(11) UNSIGNED DEFAULT NULL,
  price_quantity_end INT(11) UNSIGNED DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_product_price_id),
  INDEX idx_product_price_product_id (virtuemart_product_id),
  INDEX idx_product_price_virtuemart_shoppergroup_id (virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 532
AVG_ROW_LENGTH = 101
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Holds price records for a product';

--
-- Описание для таблицы auc13_virtuemart_product_relations
--
DROP TABLE IF EXISTS auc13_virtuemart_product_relations;
CREATE TABLE auc13_virtuemart_product_relations (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  related_products INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, related_products)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_product_shoppergroups
--
DROP TABLE IF EXISTS auc13_virtuemart_product_shoppergroups;
CREATE TABLE auc13_virtuemart_product_shoppergroups (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_shoppergroup_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 11
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Maps Products to Categories';

--
-- Описание для таблицы auc13_virtuemart_products
--
DROP TABLE IF EXISTS auc13_virtuemart_products;
CREATE TABLE auc13_virtuemart_products (
  virtuemart_product_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  product_parent_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  product_sku CHAR(64) DEFAULT NULL,
  product_weight DECIMAL(10, 4) DEFAULT NULL,
  product_weight_uom CHAR(7) DEFAULT NULL,
  product_length DECIMAL(10, 4) DEFAULT NULL,
  product_width DECIMAL(10, 4) DEFAULT NULL,
  product_height DECIMAL(10, 4) DEFAULT NULL,
  product_lwh_uom CHAR(7) DEFAULT NULL,
  product_url CHAR(255) DEFAULT NULL,
  product_in_stock INT(1) DEFAULT NULL,
  product_ordered INT(1) DEFAULT NULL,
  low_stock_notification INT(1) UNSIGNED DEFAULT NULL,
  product_available_date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  product_available_date_closed DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Дата закрытия торгов по лоту',
  product_availability CHAR(32) DEFAULT NULL,
  product_special TINYINT(1) DEFAULT NULL,
  auction_number TEXT NOT NULL COMMENT 'Номер аукциона',
  contract_number TEXT NOT NULL COMMENT 'Номер договора',
  lot_number INT(11) NOT NULL,
  auction_date_start DATETIME DEFAULT NULL,
  auction_date_finish DATETIME DEFAULT NULL,
  product_sales INT(1) UNSIGNED DEFAULT NULL,
  product_packaging DECIMAL(8, 4) UNSIGNED DEFAULT NULL,
  product_params VARCHAR(2000) DEFAULT NULL,
  hits INT(11) UNSIGNED DEFAULT NULL,
  intnotes VARCHAR(18000) DEFAULT NULL,
  metarobot VARCHAR(400) DEFAULT NULL,
  metaauthor VARCHAR(400) DEFAULT NULL,
  layout CHAR(16) DEFAULT NULL,
  published TINYINT(1) DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  product_unit CHAR(4) DEFAULT NULL,
  PRIMARY KEY (virtuemart_product_id),
  INDEX idx_product_product_parent_id (product_parent_id),
  INDEX idx_product_sku (product_sku),
  INDEX idx_product_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 605
AVG_ROW_LENGTH = 208
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'All products are stored here.';

--
-- Описание для таблицы auc13_virtuemart_products_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_products_ru_ru;
CREATE TABLE auc13_virtuemart_products_ru_ru (
  virtuemart_product_id INT(1) UNSIGNED NOT NULL,
  product_s_desc VARCHAR(2000) NOT NULL DEFAULT '',
  product_desc VARCHAR(18400) NOT NULL DEFAULT '',
  product_name CHAR(180) NOT NULL DEFAULT '',
  metadesc VARCHAR(400) NOT NULL DEFAULT '',
  metakey VARCHAR(400) NOT NULL DEFAULT '',
  customtitle CHAR(255) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_product_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 480
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Таблица предметов (продуктов)';

--
-- Описание для таблицы auc13_virtuemart_rating_reviews
--
DROP TABLE IF EXISTS auc13_virtuemart_rating_reviews;
CREATE TABLE auc13_virtuemart_rating_reviews (
  virtuemart_rating_review_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  comment VARCHAR(18000) DEFAULT NULL,
  review_ok TINYINT(1) NOT NULL DEFAULT 0,
  review_rates INT(1) UNSIGNED NOT NULL DEFAULT 0,
  review_ratingcount INT(1) UNSIGNED NOT NULL DEFAULT 0,
  review_rating DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  review_editable TINYINT(1) NOT NULL DEFAULT 1,
  lastip CHAR(50) NOT NULL DEFAULT '0',
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_rating_review_id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, created_by)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_rating_votes
--
DROP TABLE IF EXISTS auc13_virtuemart_rating_votes;
CREATE TABLE auc13_virtuemart_rating_votes (
  virtuemart_rating_vote_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  vote INT(11) NOT NULL DEFAULT 0,
  lastip CHAR(50) NOT NULL DEFAULT '0',
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_rating_vote_id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, created_by)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores all ratings for a product';

--
-- Описание для таблицы auc13_virtuemart_ratings
--
DROP TABLE IF EXISTS auc13_virtuemart_ratings;
CREATE TABLE auc13_virtuemart_ratings (
  virtuemart_rating_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  rates INT(11) NOT NULL DEFAULT 0,
  ratingcount INT(1) UNSIGNED NOT NULL DEFAULT 0,
  rating DECIMAL(10, 1) NOT NULL DEFAULT 0.0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_rating_id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, virtuemart_rating_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores all ratings for a product';

--
-- Описание для таблицы auc13_virtuemart_shipmentmethod_shoppergroups
--
DROP TABLE IF EXISTS auc13_virtuemart_shipmentmethod_shoppergroups;
CREATE TABLE auc13_virtuemart_shipmentmethod_shoppergroups (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_shipmentmethod_id MEDIUMINT(1) UNSIGNED DEFAULT NULL,
  virtuemart_shoppergroup_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_shipmentmethod_id (virtuemart_shipmentmethod_id, virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'xref table for shipment to shoppergroup';

--
-- Описание для таблицы auc13_virtuemart_shipmentmethods
--
DROP TABLE IF EXISTS auc13_virtuemart_shipmentmethods;
CREATE TABLE auc13_virtuemart_shipmentmethods (
  virtuemart_shipmentmethod_id MEDIUMINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  shipment_jplugin_id INT(11) NOT NULL DEFAULT 0,
  slug CHAR(255) NOT NULL DEFAULT '',
  shipment_element CHAR(50) NOT NULL DEFAULT '',
  shipment_params VARCHAR(19000) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_shipmentmethod_id),
  INDEX idx_shipment_element (shipment_element, virtuemart_vendor_id),
  INDEX idx_shipment_jplugin_id (shipment_jplugin_id),
  INDEX idx_shipment_method_ordering (ordering)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Shipment created from the shipment plugins';

--
-- Описание для таблицы auc13_virtuemart_shipmentmethods_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_shipmentmethods_ru_ru;
CREATE TABLE auc13_virtuemart_shipmentmethods_ru_ru (
  virtuemart_shipmentmethod_id INT(1) UNSIGNED NOT NULL,
  shipment_name CHAR(180) NOT NULL DEFAULT '',
  shipment_desc VARCHAR(20000) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_shipmentmethod_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_shoppergroups
--
DROP TABLE IF EXISTS auc13_virtuemart_shoppergroups;
CREATE TABLE auc13_virtuemart_shoppergroups (
  virtuemart_shoppergroup_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(11) NOT NULL DEFAULT 1,
  shopper_group_name CHAR(32) DEFAULT NULL,
  shopper_group_desc CHAR(128) DEFAULT NULL,
  custom_price_display TINYINT(1) NOT NULL DEFAULT 0,
  price_display BLOB DEFAULT NULL,
  `default` TINYINT(1) NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_shoppergroup_id),
  INDEX idx_shopper_group_name (shopper_group_name),
  INDEX idx_shopper_group_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 62
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Shopper Groups that users can be assigned to';

--
-- Описание для таблицы auc13_virtuemart_states
--
DROP TABLE IF EXISTS auc13_virtuemart_states;
CREATE TABLE auc13_virtuemart_states (
  virtuemart_state_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  virtuemart_country_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  virtuemart_worldzone_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  state_name CHAR(64) DEFAULT NULL,
  state_3_code CHAR(3) DEFAULT NULL,
  state_2_code CHAR(2) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_state_id),
  INDEX i_virtuemart_country_id (virtuemart_country_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id),
  UNIQUE INDEX idx_state_2_code (virtuemart_country_id, state_2_code),
  UNIQUE INDEX idx_state_3_code (virtuemart_country_id, state_3_code)
)
ENGINE = MYISAM
AUTO_INCREMENT = 730
AVG_ROW_LENGTH = 258
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'States that are assigned to a country';

--
-- Описание для таблицы auc13_virtuemart_userfield_values
--
DROP TABLE IF EXISTS auc13_virtuemart_userfield_values;
CREATE TABLE auc13_virtuemart_userfield_values (
  virtuemart_userfield_value_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_userfield_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  fieldtitle CHAR(255) NOT NULL DEFAULT '',
  fieldvalue CHAR(255) NOT NULL DEFAULT '',
  sys TINYINT(4) NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_userfield_value_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 20
AVG_ROW_LENGTH = 1578
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Holds the different values for dropdown and radio lists';

--
-- Описание для таблицы auc13_virtuemart_userfields
--
DROP TABLE IF EXISTS auc13_virtuemart_userfields;
CREATE TABLE auc13_virtuemart_userfields (
  virtuemart_userfield_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1,
  userfield_jplugin_id INT(11) NOT NULL DEFAULT 0,
  name CHAR(50) NOT NULL DEFAULT '',
  title CHAR(255) NOT NULL DEFAULT '',
  description MEDIUMTEXT DEFAULT NULL,
  type CHAR(50) NOT NULL DEFAULT '',
  maxlength INT(11) DEFAULT NULL,
  size INT(11) DEFAULT NULL,
  required TINYINT(4) NOT NULL DEFAULT 0,
  cols INT(11) DEFAULT NULL,
  rows INT(11) DEFAULT NULL,
  value CHAR(50) DEFAULT NULL,
  `default` CHAR(255) DEFAULT NULL,
  registration TINYINT(1) NOT NULL DEFAULT 0,
  shipment TINYINT(1) NOT NULL DEFAULT 0,
  account TINYINT(1) NOT NULL DEFAULT 1,
  readonly TINYINT(1) NOT NULL DEFAULT 0,
  calculated TINYINT(1) NOT NULL DEFAULT 0,
  sys TINYINT(4) NOT NULL DEFAULT 0,
  params VARCHAR(18000) DEFAULT NULL,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_userfield_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 27
AVG_ROW_LENGTH = 91
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Holds the fields for the user information';

--
-- Описание для таблицы auc13_virtuemart_userinfos
--
DROP TABLE IF EXISTS auc13_virtuemart_userinfos;
CREATE TABLE auc13_virtuemart_userinfos (
  virtuemart_userinfo_id INT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_user_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  address_type CHAR(2) NOT NULL DEFAULT '',
  address_type_name CHAR(32) NOT NULL DEFAULT '',
  name CHAR(64) DEFAULT NULL,
  company CHAR(64) DEFAULT NULL,
  title CHAR(32) DEFAULT NULL,
  last_name CHAR(32) DEFAULT NULL,
  first_name CHAR(32) DEFAULT NULL,
  middle_name CHAR(32) DEFAULT NULL,
  phone_1 CHAR(24) DEFAULT NULL,
  phone_2 CHAR(24) DEFAULT NULL,
  fax CHAR(24) DEFAULT NULL,
  address_1 CHAR(64) NOT NULL DEFAULT '',
  address_2 CHAR(64) DEFAULT NULL,
  city CHAR(32) NOT NULL DEFAULT '',
  virtuemart_state_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_country_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  zip CHAR(32) NOT NULL DEFAULT '',
  agreed TINYINT(1) NOT NULL DEFAULT 0,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_userinfo_id),
  INDEX idx_userinfo_virtuemart_user_id (virtuemart_userinfo_id, virtuemart_user_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Customer Information, BT = BillTo and ST = ShipTo';

--
-- Описание для таблицы auc13_virtuemart_vendor_medias
--
DROP TABLE IF EXISTS auc13_virtuemart_vendor_medias;
CREATE TABLE auc13_virtuemart_vendor_medias (
  id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_media_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_vendor_id (virtuemart_vendor_id, virtuemart_media_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_vendors
--
DROP TABLE IF EXISTS auc13_virtuemart_vendors;
CREATE TABLE auc13_virtuemart_vendors (
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  vendor_name CHAR(64) DEFAULT NULL,
  vendor_currency INT(11) DEFAULT NULL,
  vendor_accepted_currencies VARCHAR(1536) NOT NULL DEFAULT '',
  vendor_params VARCHAR(17000) DEFAULT NULL,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_vendor_id),
  INDEX idx_vendor_name (vendor_name)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 160
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Vendors manage their products in your store';

--
-- Описание для таблицы auc13_virtuemart_vendors_ru_ru
--
DROP TABLE IF EXISTS auc13_virtuemart_vendors_ru_ru;
CREATE TABLE auc13_virtuemart_vendors_ru_ru (
  virtuemart_vendor_id INT(1) UNSIGNED NOT NULL,
  vendor_store_desc TEXT NOT NULL,
  vendor_terms_of_service TEXT NOT NULL,
  vendor_legal_info TEXT NOT NULL,
  vendor_store_name CHAR(180) NOT NULL DEFAULT '',
  vendor_phone CHAR(26) NOT NULL DEFAULT '',
  vendor_url CHAR(255) NOT NULL DEFAULT '',
  slug CHAR(192) NOT NULL DEFAULT '',
  PRIMARY KEY (virtuemart_vendor_id),
  UNIQUE INDEX slug (slug)
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 5984
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_virtuemart_vmuser_shoppergroups
--
DROP TABLE IF EXISTS auc13_virtuemart_vmuser_shoppergroups;
CREATE TABLE auc13_virtuemart_vmuser_shoppergroups (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_user_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_shoppergroup_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_user_id (virtuemart_user_id, virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 11
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'xref table for users to shopper group';

--
-- Описание для таблицы auc13_virtuemart_vmusers
--
DROP TABLE IF EXISTS auc13_virtuemart_vmusers;
CREATE TABLE auc13_virtuemart_vmusers (
  virtuemart_user_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
  user_is_vendor TINYINT(1) NOT NULL DEFAULT 0,
  customer_number CHAR(32) DEFAULT NULL,
  perms CHAR(40) NOT NULL DEFAULT 'shopper',
  virtuemart_paymentmethod_id MEDIUMINT(1) UNSIGNED DEFAULT NULL,
  virtuemart_shipmentmethod_id MEDIUMINT(1) UNSIGNED DEFAULT NULL,
  agreed TINYINT(1) NOT NULL DEFAULT 0,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_user_id),
  UNIQUE INDEX i_virtuemart_user_id (virtuemart_user_id, virtuemart_vendor_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 108
AVG_ROW_LENGTH = 267
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Holds the unique user data';

--
-- Описание для таблицы auc13_virtuemart_waitingusers
--
DROP TABLE IF EXISTS auc13_virtuemart_waitingusers;
CREATE TABLE auc13_virtuemart_waitingusers (
  virtuemart_waitinguser_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_user_id INT(1) UNSIGNED NOT NULL DEFAULT 0,
  notify_email CHAR(150) NOT NULL DEFAULT '',
  notified TINYINT(1) NOT NULL DEFAULT 0,
  notify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ordering INT(2) NOT NULL DEFAULT 0,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_waitinguser_id),
  INDEX notify_email (notify_email),
  INDEX virtuemart_product_id (virtuemart_product_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Stores notifications, users waiting f. products out of stock';

--
-- Описание для таблицы auc13_virtuemart_worldzones
--
DROP TABLE IF EXISTS auc13_virtuemart_worldzones;
CREATE TABLE auc13_virtuemart_worldzones (
  virtuemart_worldzone_id SMALLINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_vendor_id SMALLINT(1) DEFAULT NULL,
  zone_name CHAR(255) DEFAULT NULL,
  zone_cost DECIMAL(10, 2) DEFAULT NULL,
  zone_limit DECIMAL(10, 2) DEFAULT NULL,
  zone_description VARCHAR(18000) DEFAULT NULL,
  zone_tax_rate INT(1) UNSIGNED NOT NULL DEFAULT 0,
  ordering INT(2) NOT NULL DEFAULT 0,
  shared TINYINT(1) NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(11) NOT NULL DEFAULT 0,
  modified_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(11) NOT NULL DEFAULT 0,
  locked_on DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  locked_by INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (virtuemart_worldzone_id),
  INDEX i_virtuemart_vendor_id (virtuemart_vendor_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'The Zones managed by the Zone Shipment Module';

--
-- Описание для таблицы auc13_weblinks
--
DROP TABLE IF EXISTS auc13_weblinks;
CREATE TABLE auc13_weblinks (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  catid INT(11) NOT NULL DEFAULT 0,
  sid INT(11) NOT NULL DEFAULT 0,
  title VARCHAR(250) NOT NULL DEFAULT '',
  alias VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  url VARCHAR(250) NOT NULL DEFAULT '',
  description TEXT NOT NULL,
  date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  hits INT(11) NOT NULL DEFAULT 0,
  state TINYINT(1) NOT NULL DEFAULT 0,
  checked_out INT(11) NOT NULL DEFAULT 0,
  checked_out_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  ordering INT(11) NOT NULL DEFAULT 0,
  archived TINYINT(1) NOT NULL DEFAULT 0,
  approved TINYINT(1) NOT NULL DEFAULT 1,
  access INT(11) NOT NULL DEFAULT 1,
  params TEXT NOT NULL,
  language CHAR(7) NOT NULL DEFAULT '',
  created DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_by_alias VARCHAR(255) NOT NULL DEFAULT '',
  modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_by INT(10) UNSIGNED NOT NULL DEFAULT 0,
  metakey TEXT NOT NULL,
  metadesc TEXT NOT NULL,
  metadata TEXT NOT NULL,
  featured TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Set if link is featured.',
  xreference VARCHAR(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  publish_up DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  publish_down DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  INDEX idx_access (access),
  INDEX idx_catid (catid),
  INDEX idx_checkout (checked_out),
  INDEX idx_createdby (created_by),
  INDEX idx_featured_catid (featured, catid),
  INDEX idx_language (language),
  INDEX idx_state (state),
  INDEX idx_xreference (xreference)
)
ENGINE = MYISAM
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы auc13_wf_profiles
--
DROP TABLE IF EXISTS auc13_wf_profiles;
CREATE TABLE auc13_wf_profiles (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  users TEXT NOT NULL,
  types TEXT NOT NULL,
  components TEXT NOT NULL,
  area TINYINT(3) NOT NULL,
  device VARCHAR(255) NOT NULL,
  rows TEXT NOT NULL,
  plugins TEXT NOT NULL,
  published TINYINT(3) NOT NULL,
  ordering INT(11) NOT NULL,
  checked_out TINYINT(3) NOT NULL,
  checked_out_time DATETIME NOT NULL,
  params TEXT NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 622
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- 
-- Вывод данных для таблицы auc13_assets
--
INSERT INTO auc13_assets VALUES
(1, 0, 1, 127, 0, 'root.1', 'Root Asset', '{"core.login.site":{"6":1,"2":1},"core.login.admin":{"6":1},"core.login.offline":{"6":1},"core.admin":{"8":1},"core.manage":{"7":1},"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(2, 1, 1, 2, 1, 'com_admin', 'com_admin', '{}'),
(3, 1, 3, 6, 1, 'com_banners', 'com_banners', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(4, 1, 7, 8, 1, 'com_cache', 'com_cache', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(5, 1, 9, 10, 1, 'com_checkin', 'com_checkin', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(6, 1, 11, 12, 1, 'com_config', 'com_config', '{}'),
(7, 1, 13, 16, 1, 'com_contact', 'com_contact', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(8, 1, 17, 70, 1, 'com_content', 'com_content', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":[]}'),
(9, 1, 71, 72, 1, 'com_cpanel', 'com_cpanel', '{}'),
(10, 1, 73, 74, 1, 'com_installer', 'com_installer', '{"core.admin":[],"core.manage":{"7":0},"core.delete":{"7":0},"core.edit.state":{"7":0}}'),
(11, 1, 75, 76, 1, 'com_languages', 'com_languages', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(12, 1, 77, 78, 1, 'com_login', 'com_login', '{}'),
(13, 1, 79, 80, 1, 'com_mailto', 'com_mailto', '{}'),
(14, 1, 81, 82, 1, 'com_massmail', 'com_massmail', '{}'),
(15, 1, 83, 84, 1, 'com_media', 'com_media', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":{"5":1}}'),
(16, 1, 85, 86, 1, 'com_menus', 'com_menus', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(17, 1, 87, 88, 1, 'com_messages', 'com_messages', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(18, 1, 89, 90, 1, 'com_modules', 'com_modules', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(19, 1, 91, 94, 1, 'com_newsfeeds', 'com_newsfeeds', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(20, 1, 95, 96, 1, 'com_plugins', 'com_plugins', '{"core.admin":{"7":1},"core.manage":[],"core.edit":[],"core.edit.state":[]}'),
(21, 1, 97, 98, 1, 'com_redirect', 'com_redirect', '{"core.admin":{"7":1},"core.manage":[]}'),
(22, 1, 99, 100, 1, 'com_search', 'com_search', '{"core.admin":{"7":1},"core.manage":{"6":1}}'),
(23, 1, 101, 102, 1, 'com_templates', 'com_templates', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(24, 1, 103, 106, 1, 'com_users', 'com_users', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(25, 1, 107, 110, 1, 'com_weblinks', 'com_weblinks', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":[]}'),
(26, 1, 111, 112, 1, 'com_wrapper', 'com_wrapper', '{}'),
(27, 8, 18, 55, 2, 'com_content.category.2', 'Default', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(28, 3, 4, 5, 2, 'com_banners.category.3', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(29, 7, 14, 15, 2, 'com_contact.category.4', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(30, 19, 92, 93, 2, 'com_newsfeeds.category.5', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(31, 25, 108, 109, 2, 'com_weblinks.category.6', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(32, 24, 104, 105, 1, 'com_users.category.7', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(33, 1, 113, 114, 1, 'com_finder', 'com_finder', '{"core.admin":{"7":1},"core.manage":{"6":1}}'),
(34, 1, 115, 116, 1, 'com_joomlaupdate', 'com_joomlaupdate', '{"core.admin":[],"core.manage":[],"core.delete":[],"core.edit.state":[]}'),
(35, 1, 117, 118, 1, 'com_virtuemart', 'virtuemart', '{}'),
(36, 1, 119, 120, 1, 'com_virtuemart_allinone', 'virtuemart_allinone', '{}'),
(66, 27, 51, 52, 3, 'com_content.article.22', 'Задать вопрос по лоту', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(38, 27, 19, 20, 3, 'com_content.article.1', 'Антикварный аукцион Русские сезоны', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(39, 27, 21, 22, 3, 'com_content.article.2', 'Аукцион', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(40, 27, 23, 24, 3, 'com_content.article.3', 'О нас', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(41, 8, 56, 63, 2, 'com_content.category.8', 'Правила', '{"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(42, 41, 57, 58, 3, 'com_content.article.4', 'Правила регистрации участников торгов Аукциона "Русские Сезоны"', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(43, 41, 59, 60, 3, 'com_content.article.5', 'Правила проведения онлайн торгов Аукциона "Русские Сезоны"', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(44, 41, 61, 62, 3, 'com_content.article.6', 'Правила проведения очных торгов Аукциона "Русские Сезоны"', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(45, 27, 25, 26, 3, 'com_content.article.7', 'Партнёры', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(46, 27, 27, 28, 3, 'com_content.article.8', 'Контакты', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(47, 27, 29, 30, 3, 'com_content.article.9', 'Вопросы', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(48, 27, 31, 32, 3, 'com_content.article.10', 'Доставка и оплата', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(49, 27, 33, 34, 3, 'com_content.article.11', 'Черный список', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(50, 27, 35, 36, 3, 'com_content.article.12', 'Расписание аукционов', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(51, 27, 37, 38, 3, 'com_content.article.13', 'Предложить предмет', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(52, 27, 39, 40, 3, 'com_content.article.14', 'Результаты торгов', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(53, 27, 41, 42, 3, 'com_content.article.15', 'Антикварная галерея', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(54, 27, 43, 44, 3, 'com_content.article.16', 'Антикварный салон', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(55, 1, 121, 122, 1, 'com_acymailing', 'acymailing', '{}'),
(56, 27, 45, 46, 3, 'com_content.article.17', 'Заказ каталогов', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(57, 1, 123, 124, 1, 'com_jce', 'jce', '{}'),
(58, 27, 47, 48, 3, 'com_content.article.18', 'Приём антиквариата на торги ', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(59, 1, 125, 126, 1, 'com_auction2013', 'auction2013', '{}'),
(61, 27, 49, 50, 3, 'com_content.article.19', 'Регистрация', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(62, 63, 65, 66, 3, 'com_content.article.20', 'Спасибо за регистрацию', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(63, 8, 64, 69, 2, 'com_content.category.9', 'Спасибо за...', '{"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(64, 63, 67, 68, 3, 'com_content.article.21', 'Спасибо за предложение предмета', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(67, 27, 53, 54, 3, 'com_content.article.23', 'Поставить заочный бид', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}');

-- 
-- Вывод данных для таблицы auc13_associations
--

-- Таблица auctionru_2013.auc13_associations не содержит данных

-- 
-- Вывод данных для таблицы auc13_auction2013
--

-- Таблица auctionru_2013.auc13_auction2013 не содержит данных

-- 
-- Вывод данных для таблицы auc13_categories
--
INSERT INTO auc13_categories VALUES
(1, 0, 0, 0, 17, 0, '', 'system', 'ROOT', 'root', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{}', '', '', '', 0, '2009-10-18 16:07:09', 0, '0000-00-00 00:00:00', 0, '*'),
(2, 27, 1, 1, 2, 1, 'uncategorised', 'com_content', 'Default', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 42, '2010-06-28 13:26:37', 107, '2013-02-02 11:14:12', 0, '*'),
(3, 28, 1, 3, 4, 1, 'uncategorised', 'com_banners', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":"","foobar":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:27:35', 0, '0000-00-00 00:00:00', 0, '*'),
(4, 29, 1, 5, 6, 1, 'uncategorised', 'com_contact', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:27:57', 0, '0000-00-00 00:00:00', 0, '*'),
(5, 30, 1, 7, 8, 1, 'uncategorised', 'com_newsfeeds', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:15', 0, '0000-00-00 00:00:00', 0, '*'),
(6, 31, 1, 9, 10, 1, 'uncategorised', 'com_weblinks', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:33', 0, '0000-00-00 00:00:00', 0, '*'),
(7, 32, 1, 11, 12, 1, 'uncategorised', 'com_users', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:33', 0, '0000-00-00 00:00:00', 0, '*'),
(8, 41, 1, 13, 14, 1, 'pravila', 'com_content', 'Правила', 'pravila', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"_:blog","image":""}', '', '', '{"author":"","robots":""}', 107, '2013-02-02 11:13:54', 107, '2013-02-02 12:07:26', 0, '*'),
(9, 63, 1, 15, 16, 1, 'thank-you', 'com_content', 'Спасибо за...', 'thank-you', '', '<p>Страницы, загружаемые после отравки юзером данных формы.</p>', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 107, '2013-02-10 18:47:49', 107, '2013-02-10 18:48:50', 0, '*');

-- 
-- Вывод данных для таблицы auc13_contact_details
--

-- Таблица auctionru_2013.auc13_contact_details не содержит данных

-- 
-- Вывод данных для таблицы auc13_content
--
INSERT INTO auc13_content VALUES
(1, 38, 'Антикварный аукцион Русские сезоны', 'auction-home', '', '<div class="Post-body">\r\n<h2 class="Post-inner">Антикварный аукцион</h2>\r\n<p>"Русские Сезоны"</p>\r\n<p class="Post-inner" style="text-align: center;"><strong>Уважаемые дамы и господа!</strong></p>\r\n<p class="Post-inner">&nbsp;</p>\r\n<div class="Post-inner"><strong>АНТИКВАРНЫЙ ОНЛАЙН АУКЦИОН №02</strong></div>\r\n<p class="Post-inner" style="text-align: right;"><strong>заканчивается 14 декабря в 15.00.</strong></p>\r\n<div class="Post-inner"><br /><strong>Торги идут! Добро пожаловать!</strong></div>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p class="Post-inner"><strong>АНТИКВАРНЫЙ ОЧНЫЙ АУКЦИОН №1</strong></p>\r\n<p class="Post-inner" style="text-align: right;">состоялся <strong>14 ноября</strong><br />в 12.00 в ГРАНД ОТЕЛЕ ЕВРОПА<br />Санкт-Петербург, Невский проспект,<br />ул. Михайловская, д. 1/7</p>\r\n<h3 class="Post-inner">Печатный каталог аукциона №1</h3>\r\n<p class="Post-inner">Печатный каталог вы можете приобрести в наших салоне и галерее. Чтобы заказать доставку каталога перейдите на <a href="index.php?a=28&amp;b=152" title="Заказ каталога антиквариат. Очный антикварный аукцион">страницу заказа каталога</a></p>\r\n<h3 class="Post-inner">Электронный каталог аукциона №1</h3>\r\n<div class="Post-inner">\r\n<table style="width: 337px;" border="0">\r\n<tbody>\r\n<tr>\r\n<td width="105"><span style="float: left; width: 105px;"><a href="documents/Russians_seasones_auction_01.jpg"></a><a href="documents/Russians_seasones_auction_01.jpg"><img src="documents/preview_Russians_seasones_auction_01.jpg" alt="Антиквариат Каталог №1" border="0" height="142" width="100" /></a></span></td>\r\n<td width="222">\r\n<p>Аукцион №1<br />14.11.2010<br /><a href="documents/Russians_seasones_auction_01.pdf">Скачать КАТАЛОГ в PDF формате</a></p>\r\n<p><a href="index.php?option=com_auction2013&amp;view=auction2013&amp;layout=results&amp;Itemid=128">Результаты торгов</a></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n<p class="Post-inner"><br />На все Ваши вопросы по аукциону ответят наши сотрудники по телефонам:</p>\r\n</div>\r\n<div class="Post-body">\r\n<p class="Post-inner"><strong>+7 (812) 579 53 57<br />+7 (812) 579 56 45<br />+7 (812) 273 91 61</strong></p>\r\n<p class="Post-inner"><strong>Во всех ситуациях мы найдём индивидуальное решение.</strong></p>\r\n<p class="Post-inner">&nbsp;</p>\r\n<p class="Post-inner">&nbsp;</p>\r\n<p class="Post-inner"><strong>&nbsp;</strong></p>\r\n</div>', '', 1, 0, 0, 2, '2013-02-02 08:03:58', 107, '', '2013-02-10 22:35:02', 107, 0, '0000-00-00 00:00:00', '2013-02-02 08:03:58', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"0","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"0","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 5, 0, 17, '', '', 1, 1107, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(2, 39, 'Аукцион', 'auction-antique', '', '<p> </p>\r\n<div style="text-align: center;"><strong>Уважаемые дамы и господа!</strong></div>\r\n<p>     В последние годы неуклонно растет интерес к антиквариату, к старинным  редким вещам, которые могут не просто доставлять удовольствие его владельцам, но и занять достойное место в личных коллекциях.</p>\r\n<p>     Ценность  предметов антиквариата постоянно  увеличивается, что делает их приобретение не только приятной покупкой, но и одним из самых выгодных способов вложения средств на долгосрочный период.</p>\r\n<p>     Аукционные  торги являются наиболее динамично развивающейся формой торговли и постепенно занимают лидирующее положение на антикварном рынке. Аукцион – это игра, азарт и удовольствие, позволяющие украсить дом и инвестировать средства.</p>\r\n<p>     Мы  надеемся, что проект Аукцион Русские  Сезоны привлечет внимание, как искушенных знатоков и коллекционеров, так и простых любителей предметов старины. Надеемся порадовать наших клиентов, заинтересовать новых покупателей и дизайнеров, постараемся предоставить интересные предложения для дилеров и коллекционеров.</p>\r\n<p>     Купля-продажа антиквариата требует безусловного взаимного доверия, поэтому основными принципами нашей деятельности является максимальная открытость и официальность. Аукцион Русские Сезоны гарантирует своим клиентам подлинность каждого выставляемого предмета и его профессиональную экспертную оценку.</p>\r\n<p>     Кроме того, мы находимся в России, что  избавляет покупателей от сложностей с оплатой, таможенных платежей и доставкой через границу.</p>\r\n<p>     Проект  предусматривает проведение, как  ОЧНЫХ аукционных торгов, на которых будут представлены достойные произведения искусства и редкие раритеты для ценителей и коллекционеров, так и ИНТЕРНЕТ (ОНЛАЙН) аукционы для реализации более широкого спектра разнообразных антикварных предметов в различных ценовых диапазонах. Желающие могут принимать участие в ОЧНЫХ торгах, как лично, так и конфиденциально – либо через своего представителя, либо оставив заочный бид, либо по телефону. ОНЛАЙН аукционы дают возможность любому пользователю сети интернет стать участником торгов. В случае невозможности лично следить за ходом торгов, при открытии аукциона возможно вписать свою максимальную ставку, что будет являться Вашим заочным бидом. Система автоматически будет пошагово торговаться за Вас. Более подробную информацию о правилах участия в аукционах можно получить в разделах <a href="index.php?a=28&amp;b=148" title="Правила онлайн торгов антиквариатом.">ПРАВИЛА ОНЛАЙН АУКЦИОНОВ</a> и <a href="index.php?a=28&amp;b=149" title="Правила очных аукционов.">ПРАВИЛА ОЧНЫХ АУКЦИОНОВ</a>.</p>\r\n<p>     Аукционы  будут проводиться на регулярной основе. Как для очных, так и  для интернет аукционов вашему вниманию будут заблаговременно предоставлены  соответствующие каталоги, в которых  наглядно, с подробными описаниями, будут представлены все лоты, выставленные на торги. На главной странице можно подписаться на уведомление о появлении каталога на нашем сайте. Печатный каталог на очный аукцион можно заказать заранее.</p>\r\n<p>     Основными разделами аукционных торгов будут: раздел русской и западноевропейской живописи, раздел декоративно-прикладного искусства и раздел предметов интерьера.</p>\r\n<p>     Мы  надеемся, что многолетняя работа на антикварном рынке, авторитет  фирмы Русские Сезоны, опытный  коллектив профессионалов, наша доступность, информативность проекта, дадут нам возможность взаимовыгодного сотрудничества и плодотворной совместной работы.</p>\r\n<p>     Если  у Вас возникли любые вопросы  по участию в проекте Аукцион  Русские Сезоны, наши сотрудники всегда к Вашим услугам. Телефоны и E-mail адреса можно найти в разделе <a href="index.php?a=28&amp;b=139" title="Контакты антикварного аукциона">КОНТАКТЫ</a>.</p>', '', 1, 0, 0, 2, '2013-02-02 10:47:03', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 10:47:03', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 16, '', '', 1, 69, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(3, 40, 'О нас', 'o-kompanii', '', '<p>Фирма «Русские сезоны» была основана в <strong>1999</strong> году. В антикварной среде  известна двумя представителями, располагающимися в историческом центре Санкт-Петербурга: <a href="index.php?a=28&amp;b=137" title="Антикварная галерея">галереей</a> на <strong>Литейном проспекте дом </strong><strong>15</strong> и <a href="index.php?a=28&amp;b=138" title="Антикварный салон">салоном</a> на <strong>набережной реки Фонтанки дом 24</strong>. Более чем за десятилетний период своего существования Фирма зарекомендовала себя как активный, пользующийся доверием участник антикварного бизнеса, сотрудничающий со многими музеями, коллекционерами, дилерами и  дизайнерами.</p>\r\n<p>Галерея «Русские Сезоны» открылась  в <strong>2002</strong> году <strong>Литейном проспекте в доме</strong><strong> 15</strong>, основная специализация - русская живопись дореволюционного периода и предметы антиквариата высшего уровня.<br /> В залах галереи представлены работы таких выдающихся  мастеров живописи как И. Айвазовский, К. Маковский, Н. Дубовской, Б. Кустодиев, И. Шишкин, А. Головин и др.<br /> Также здесь можно увидеть образцы  продукции выпущенной  знаменитой фирмой Карла Фаберже, предметы, созданные на других известных фабриках по производству серебряных изделий, имевших звания придворных поставщиков императорского двора: Братья Грачёвы, Сазиковъ, Морозовъ и т.д.</p>\r\n<p>На  <strong>набережной реки Фонтанки дом </strong><strong>24</strong> работает антикварный Салон подарков «Русские Сезоны». В салоне представлен более широкий спектр антикварных изделий, включающий в себя как предметы русского искусства, так и западного. В экспозиции представлены живописные произведения, предметы интерьера, продукция фарфоровых фабрик и заводов России, Германии, Франции, Дании, Англии, Австрии, Испании, Японии. Обширно представлен раздел стеклянной продукции, в частности предметы Императорского стеклянного завода, заводов Богемии. Коллекционеры и любители художественной бронзы так же смогут найти интересующие их предметы в нашем салоне среди венской бронзы, авторских работ русских мастеров таких как: Е. Напс, М. Антокольский, Е. Лансере, а так же работ западных мастеров. Также, в большом ассортименте,  представлена восточная тематика: мебель, нэцкэ, графика, бронза, фарфор, предметы интерьера.</p>\r\n<p>Многогранен и живописный раздел: портреты, натюрморты, пейзажи, камерные произведения, мифологическая, анималистическая живопись, марины, полотна на религиозные сюжеты русских и западных мастеров XVIII, XIX, ХХ веков. <br /> Коллекционер Вы или любитель, или просто ищите оригинальный подарок, в залах Салона «Русские Сезоны» Вы  сможете найти предмет старины абсолютно на любой вкус.</p>\r\n<p>Салон «Русские Сезоны» сотрудничает с дизайнерами, помогает коллекционерам антикварных раритетов пополнять свои собрания.</p>', '', 1, 0, 0, 2, '2013-02-02 10:51:31', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 10:51:31', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 15, '', '', 1, 23, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(4, 42, 'Правила регистрации участников торгов Аукциона "Русские Сезоны"', 'pravila-registraciji-uchastnikov-torgov', '', '<p style="text-align: center;"><strong>Правила регистрации участников торгов</strong></p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Для участия&nbsp;в&nbsp;аукционах&nbsp;необходимо пройти процедуру&nbsp;регистрации&nbsp;покупателя в&nbsp;качестве потенциального участника&nbsp; торгов. Участниками&nbsp;аукциона могут&nbsp; быть дееспособные лица, достигшие 18 лет. Необходимо пройти по ссылке «Регистрация» и заполнить регистрационную форму, где правильно указать ФИО, полный почтовый адрес и контактную информацию, которая будет доступна только Вам и администратору аукциона. После проверки регистрационных данных, по указанным телефонам, с Вами свяжется администратор Аукциона, который может запросить у Вас дополнительные сведения. После этого, на Ваш e-mail будет отправлен присвоенный Вам клиентский номер, с помощью которого Вы сможете воспользоваться разделом «Ваш кабинет», который даёт его владельцу возможности более удобной работы на аукционных торгах. Пользователь может переносить (копировать) интересующие его лоты из каталогов в свой «кабинет», принимать участие в торгах непосредственно из своего «кабинета» или просто отслеживать процесс торгов по данным предметам. Также, в личном «кабинете» будет представлен архив Ваших покупок на наших аукционах.</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Для предотвращения срыва&nbsp;торгов и&nbsp;недопущения&nbsp; к&nbsp;аукционам&nbsp;недобросовестных участников, администрация&nbsp;Аукциона вправе затребовать у участников – физических лиц – ксерокопию паспорта, гарантийное письмо банка или надёжные рекомендации; для клиентов – юридических лиц – гарантийное письмо банка, нотариально заверенную доверенность, документ, подтверждающий полномочия руководителя и, также, надёжное поручительство.</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Аукцион «Русские Сезоны»&nbsp;оставляет&nbsp;за собой&nbsp; право&nbsp;отказать в&nbsp;регистрации&nbsp; без&nbsp;объяснения причин.</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Мы&nbsp; надеемся на то, что&nbsp;наши клиенты&nbsp; отнесутся&nbsp;с&nbsp;пониманием к&nbsp;необходимости&nbsp; предоставления дополнительных сведений и&nbsp;гарантий, так как все эти меры направлены на то, чтобы наше сотрудничество было взаимовыгодным, надёжным и развивалось на постоянной основе.</p>\r\n<div style="float: left;">\r\n<h3><a href="index.php?option=com_auction2013&amp;view=auction2013&amp;layout=register&amp;Itemid=151">Регистрация</a></h3>\r\n</div>', '', 1, 0, 0, 8, '2013-02-02 11:16:15', 107, '', '2013-02-09 14:50:13', 107, 0, '0000-00-00 00:00:00', '2013-02-02 11:16:15', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 4, 0, 1, '', '', 1, 38, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(5, 43, 'Правила проведения онлайн торгов Аукциона "Русские Сезоны"', 'pravila-provedenija-online-torgov', '', '<p><strong>Правила участия в торгах онлайн аукциона «Русские Сезоны»</strong></p>\r\n<p><strong>1. Порядок работы</strong></p>\r\n<p>1.1. Аукцион «Русские Сезоны» осуществляет свою деятельность по реализации антиквариата, предметов искусства и коллекционирования в соответствии с законодательством РФ и собственным Уставом.</p>\r\n<p>1.2. Настоящие правила определяют условия проведения онлайн (интернет) торгов, условия участия в них, регламент определения победителей и порядок расчетов.</p>\r\n<p>1.3. Торги проводятся на сайте Аукциона <a href="http://www.auction-ruseasons.ru/">www.auction-ruseasons.ru</a>. За 10 дней до начала аукциона на сайте размещается каталог лотов для предварительного ознакомления. Наряду с изображениями и описаниями в каталоге указывается стартовая цена предметов. Аукцион открывается в 15.00 по московскому времени заранее объявленного числа и заканчивает свою работу ровно через 10 суток в 15.00. В случае, если ставка на лот сделана в последние 5 минут до закрытия аукционных торгов, торги на данный лот автоматически продлеваются на 5 минут.</p>\r\n<p>1.4. Все лоты, выставляемые на аукцион, подробно описываются, основываясь на мнении наших экспертов, указывается фактическое состояние с приложениями в виде высококачественных фотографий в различных ракурсах с отображением марок, клейм, подписей, возможных дефектов и недостатков.</p>\r\n<p><strong>2. Участие в торгах</strong></p>\r\n<p>2.1. Участниками торгов могут быть только зарегистрированные на сайте Аукциона пользователи.</p>\r\n<p>2.2. Администрация Аукциона оставляет за собой право отказать в участии в торгах без объяснения причин.</p>\r\n<p>2.3. После прохождения процедуры регистрации в качестве участника торгов  (см. Правила Регистрации) покупатель может пройти авторизацию, введя в свободном поле раздела «Ваш кабинет» свой клиентский номер и пароль для входа в систему. Покупатель становится полноправным участником торгов.</p>\r\n<p>2.4. Чтобы начать торг за интересующий лот, надо нажать кнопку «Сделать ставку». На экране появится окно, где будет указана сумма ставки, за которую можно купить лот в данный момент. Ставку надо подтвердить, либо вернуться к лоту. Участник имеет возможность сделать заочный бид, вписав вместо предлагаемой ставки свою максимальную цену (данная цена не включает комиссионный сбор). И в этом случае система автоматически будет делать ставки за покупателя пошагово до указанной им суммы. При одинаковых ставках выигрывает тот, кто сделал ставку раньше.  Заочный бид можно поставить только с момента начала аукциона. Делать ставки возможно как напрямую из каталога (после ставки данный предмет автоматически переносится в «Ваш кабинет»), так и из «кабинета», предварительно отсортировав туда интересующие лоты. Информация обо всех совершенных сделках хранится в «кабинете» и при необходимости может быть удалена.</p>\r\n<p>2.5. Шаг на аукционе – диапазон цены в рублях, на который увеличивается цена лота в процессе торгов.</p>\r\n<table style="width: 350px;" border="0">\r\n<tbody>\r\n<tr>\r\n<td width="249"><strong>Диапазон цены (в рублях)</strong>;</td>\r\n<td width="91"><strong>Шаг</strong></td>\r\n</tr>\r\n<tr>\r\n<td>1-5</td>\r\n<td>1</td>\r\n</tr>\r\n<tr>\r\n<td width="249">5 - 50</td>\r\n<td>5</td>\r\n</tr>\r\n<tr>\r\n<td>50 - 200</td>\r\n<td>10</td>\r\n</tr>\r\n<tr>\r\n<td>200 - 500</td>\r\n<td>20</td>\r\n</tr>\r\n<tr>\r\n<td>500 - 1 000 </td>\r\n<td>50</td>\r\n</tr>\r\n<tr>\r\n<td>1 000 - 2 000</td>\r\n<td>100</td>\r\n</tr>\r\n<tr>\r\n<td>2 000 - 5 000</td>\r\n<td>200</td>\r\n</tr>\r\n<tr>\r\n<td>5 000 - 10 000</td>\r\n<td>500</td>\r\n</tr>\r\n<tr>\r\n<td>10 000 - 20 000</td>\r\n<td>1000</td>\r\n</tr>\r\n<tr>\r\n<td>20 000 - 50 000</td>\r\n<td>2000</td>\r\n</tr>\r\n<tr>\r\n<td>50 000 - 100 000</td>\r\n<td>5000</td>\r\n</tr>\r\n<tr>\r\n<td>100 000 - 200 000</td>\r\n<td>10 000</td>\r\n</tr>\r\n<tr>\r\n<td>200 000 - 500 000</td>\r\n<td>20 000</td>\r\n</tr>\r\n<tr>\r\n<td>500 000 - 2 000 000</td>\r\n<td>50 000</td>\r\n</tr>\r\n<tr>\r\n<td>2 000 000 и более</td>\r\n<td>100 000</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>2.6. При значительном превышении суммы заочного бида участника над стартовой ценой, а также при существенном увеличении цены на лот в процессе торгов, администрация Аукциона вправе потребовать от участников внесения залога.</p>\r\n<p>2.7. После окончания аукциона участникам-победителям автоматически рассылаются письма по электронной почте с оповещением о выигранных лотах.</p>\r\n<p><strong>3. Оплата и доставка.</strong></p>\r\n<p>3.1. Сумма оплаты состоит из стоимости лотов плюс комиссионный сбор Аукциона 10%.</p>\r\n<p>3.2. Оплата приобретённых лотов производится в течение 7 календарных дней с момента покупки (данный срок может быть изменён по взаимной договорённости). В противном случае факт продажи считается недействительным, клиентский номер недобросовестного участника аннулируется, и администрация Аукциона вправе приступить к дальнейшей реализации предмета. Аукцион «Русские Сезоны», в лице ООО «Нева-Антик», оставляет за собой право подать иск в суд о возмещении морального и материального ущерба за причинённый урон имиджу фирмы, недополученную прибыль, мошенничество и прочее в соответствии с действующим законодательством РФ.</p>\r\n<p>3.3. Цены на лоты указываются в рублях Российской Федерации. Оплата приобретённых лотов производится в рублях. Оплатить приобретённые лоты возможно наличным и безналичным платежом. Оплата наличными, а также пластиковыми картами VISA, VISA Electron, Mastercard, Mastercard Electronic, Maestro принимается в Галерее фирмы по адресу Литейный пр., дом 15. При оплате банковскими картами покупатель оплачивает дополнительно 1,9% от суммы оплаты в качестве возмещения расходов обслуживающего банка. Оплата по безналичному расчёту осуществляется через различные платёжные системы и банки. В разделе «Доставка и оплата» указаны банковские реквизиты ООО «Нева-Антик».</p>\r\n<p>3.4. Доставка лота осуществляется по желанию покупателя на выбор одной из курьерских служб и оплачивается дополнительно. Доставка осуществляется только после полной оплаты его стоимости, включая сумму доставки. За доставку лота и все риски с этим связанные Аукцион ответственности не несёт. Рекомендуется страховать все пересылаемые предметы.</p>\r\n<div> </div>\r\n<p>3.5. Покупатель выбирает способ оплаты и доставки, о чём сообщает, заполнив специальную форму на сайте в разделе «Оплата и доставка», либо по телефонам +7(812)2751749, +7(812)5795357.</p>\r\n<div> </div>\r\n<p>3.6. Покупатель обязан забрать предмет в течение месяца после оплаты предмета. Если не существует иной договорённости, Аукцион вправе сдать товар на хранение третьему лицу за счет Покупателя.</p>\r\n<div> </div>\r\n<p><strong>4. Условия и гарантии.</strong></p>\r\n<div> </div>\r\n<p>4.1. Аукцион «Русские Сезоны» не выдаёт лицензий на вывоз предметов антиквариата за пределы РФ.</p>\r\n<p>4.2. Аукцион «Русские Сезоны» в своей деятельности руководствуется законодательством РФ – Гражданским Кодексом РФ, Правилами комиссионной торговли непродовольственными товарами, Законом РФ «О защите прав потребителей», Правилами продажи отдельных видов товаров.</p>\r\n<p>4.3. Покупателям предоставляется полное описание и состояние лота в соответствии с пунктом 1.4., поэтому претензии после окончания аукциона по качеству и состоянию предметов не принимаются. </p>\r\n<p>4.3. Аукцион «Русские Сезоны» гарантирует подлинность предметов, выставляемых на торги, и несёт за это ответственность в течение 3-х лет. Покупатель, усомнившийся в подлинности предмета, должен проинформировать об этом руководство Аукциона и привести убедительные доказательства данного факта, основанные на объективном мнении экспертов, признанных на антикварном рынке. В случае, если было установлено, что предмет, проданный на торгах, является подделкой, он должен быть предоставлен администрации Аукциона в том состоянии, в каком он был на момент продажи. Аукцион, в свою очередь, полностью возмещает покупателю стоимость, за которую предмет был приобретен на аукционе, за исключением случаев, когда на предмет на момент продажи имелось заключение сотрудников государственных музейных учреждений.</p>\r\n<p>4.4. Покупатель не вправе требовать возмещения ущерба в сумме, превышающей заплаченную им цену, дополнительных компенсаций и возмещения морального ущерба.</p>\r\n<p>4.5. Данные гарантии распространяются только на постоянного собственника предмета, т.е. человека, непосредственно купившего предмет на торгах и обладающего соответствующим документом на право собственности. Данный предмет должен быть освобождён от имущественных обязательств, что должно быть также подтверждено владельцем.</p>\r\n<p> </p>\r\n<p> </p>', '', 1, 0, 0, 8, '2013-02-02 11:17:29', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 11:17:29', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 0, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(6, 44, 'Правила проведения очных торгов Аукциона "Русские Сезоны"', 'pravila-provedenija-ochnyh-torgov', '', '<p style="text-align: center;"><strong>Правила проведения очных  торгов Аукциона «Русские Сезоны»</strong></p>\r\n<p><strong>1. Порядок работы</strong></p>\r\n<p>1.1. ООО «Нева-Антик», именуемое в дальнейшем Аукцион «Русские Сезоны», осуществляет свою деятельность по реализации антиквариата, предметов искусства и коллекционирования в соответствии с законодательством РФ и собственным Уставом.</p>\r\n<p>1.2. Настоящие  правила определяют условия проведения очных аукционных торгов, условия участия в них, регламент определения покупателя, порядок расчетов, гарантии и ответственность. В правила могут вноситься изменения, которые публикуются в каталоге (официальном источнике информации) или объявляются устно перед началом торгов.</p>\r\n<p>1.3. Дата, время и место проведения торгов объявляются организаторами заранее, указываются на сайте и в каталоге.</p>\r\n<p>1.4. Печатный каталог издается за месяц до назначенной даты аукциона. Каталог содержит в себе иллюстрации всех лотов, предлагаемых к продаже, и необходимую информацию о них. Все описания состояния предметов (реставрация, повреждения) сделаны в форме сопроводительных статей каталога, являются выражением мнения сотрудников Аукциона, и на них не следует полагаться, как на констатацию факта. Ссылки на реставрацию и повреждения в статье каталога, либо сделанные в устной или письменной форме в других источниках сотрудниками Аукциона, приведены только для общей информации и должны оцениваться покупателем или обладающим соответствующими знаниями представителем в ходе личного осмотра. Отсутствие такой ссылки не означает, что объект не имеет дефектов или не был реставрирован, а также ссылка на конкретные дефекты не означает отсутствие каких-либо других дефектов. Потенциальным покупателям рекомендуется лично осмотреть интересующие их предметы перед проведением аукциона.</p>\r\n<p>1.5. Предварительная оценка лотов, указанная в каталоге, является приблизительной и носит условный характер. Стартовая цена во время торгов может быть как ниже, так и выше указанной в каталоге.</p>\r\n<p>1.6. Предварительный просмотр лотов будет длиться около 10 дней до начала аукциона в помещении Салона “Русские Сезоны” по адресу набережная реки Фонтанки, д. 24. Также лоты будут демонстрироваться непосредственно во время торгов, исключая крупногабаритные, хрупкие и особо ценные предметы.</p>\r\n<p><strong>2. Участие в торгах</strong></p>\r\n<p>2.1. Участниками торгов могут быть юридические, а также совершеннолетние и полностью дееспособные физические лица.</p>\r\n<p>2.2. Администрация Аукциона оставляет за собой право отказать в участии в торгах без объяснения причин.</p>\r\n<p>2.3. Очное участие</p>\r\n<p>2.3.1. Потенциальные покупатели, которые хотели бы принять участие в торгах в аукционном зале, имеют возможность зарегистрироваться заранее, связавшись с сотрудниками Аукциона по телефону: 8(812)273-36-49. Можно зарегистрироваться у секретаря за полчаса до начала торгов. Потенциальные покупатели обязаны заполнить регистрационный бланк, предъявить паспорт. Ксерокопия паспорта прилагается к регистрационному бланку. Аукцион оставляет за собой право попросить предоставить банковские гарантии или надежные рекомендации. Юридическим лицам требуется предоставить гарантийное письмо банка; нотариально заверенную доверенность; документ, подтверждающий полномочия руководителя; надежное поручительство. В случае, если потенциальный покупатель, ранее не сотрудничавший с фирмой “Русские Сезоны”, собирается участвовать в торгах за лоты стоимостью более 3 млн. рублей, ему необходимо до начала аукциона сообщить организаторам о своих намерениях и предоставить надежные рекомендации или финансовые гарантии платежеспособности. Если участники представляют свои интересы через представителей, те, в свою очередь, должны предоставить нотариально заверенную доверенность на право участия в торгах. Если не соблюдены следующие условия, аукцион “Русские Сезоны” оставляет за собой право не допустить клиента до торгов по данным лотам.</p>\r\n<p>2.3.2. Пройдя процедуру регистрации, потенциальный покупатель получает табличку с номером, которая является единственным свидетельством, подтверждающим право на очное участие в торгах. В случае, если участник допустил использование своей таблички третьим лицом, он несет ответственность за действие этого лица, как за свои собственные. Заполняя регистрационный бланк с получением номерной таблички, участник подтверждает свое безотзывное обязательство оплатить приобретенные им лоты.</p>\r\n<p>2.4. Заочное участие </p>\r\n<p>2.4.1. При невозможности личного присутствия на очных торгах потенциальный покупатель имеет возможность оставить заявку на заочное участие и участие в торгах по телефону. Для этого заполняется специальная форма - <span style="text-decoration: underline;"><a href="bid.doc" title="Форма заочного бида.">ЗАОЧНЫЙ БИД</a></span>. Бланк заочного бида напечатан в каталоге. Заполненную заявку вместе с ксерокопией паспорта (1-я стр. + регистрация) следует направить сотрудникам Аукциона «Русские Сезоны» по факсу 8(812)2733649, либо принести лично в офис Аукциона не позднее, чем за 24 часа до начала аукциона. Заявка считается принятой, если на ней имеется информация о дате и времени её принятия. Заявки на торги по телефону принимаются на лоты с предварительной оценкой не ниже 15000 рублей. Проведение торгов на других языках (не на русском) необходимо согласовать не позднее 3-х дней до начала торгов. Аукцион «Русские Сезоны» не несёт ответственности за качество телефонной связи. Телефонные переговоры осуществляются за счёт Аукциона.</p>\r\n<p>2.4.2. Аукцион «Русские Сезоны» гарантирует конфиденциальность полученной информации и обязуется попытаться приобрести каждый лот за минимально возможную цену с учётом других заявок и предложений из зала. При поступлении равнозначных ставок на один и тот же лот приоритетом обладает тот, чья заявка зарегистрирована раньше.</p>\r\n<p>2.4.3. В тех случаях, когда потенциальный покупатель не является клиентом Аукциона «Русские сезоны», его личность неизвестна организаторам, он не имеет надёжных рекомендаций, а сумма его заочных бидов велика, администрация Аукциона вправе потребовать внесение задатка. Задаток составляет 10% от суммы лидирующих ставок данного участника. В случае, если ставки будут перекрыты, задаток незамедлительно возвращается, если же клиент не пожелает оплатить купленные им лоты, задаток переходит Аукциону «Русские Сезоны» в полном объеме.</p>\r\n<p>2.4.4. Для удобства своих клиентов Аукцион «Русские Сезоны» предлагает все услуги в отношении заявок отсутствующих участников и заявок, осуществляемых по телефону, но не несёт ответственность за ошибки в исполнении.</p>\r\n<p><strong>3. Порядок торгов.</strong></p>\r\n<p>3.1. Ведение торгов  осуществляет аукционист, действующий по поручению и от имени ООО «Нева-Антик». Все спорные ситуации, которые могут возникнуть в ходе торгов, разрешаются им и секретарём. Секретарь является высшей инстанцией для принятия решений, касающихся процедуры торгов. В случае возникновения какого-либо спора после торгов, результат, зафиксированный в протоколе торгов, является окончательным.</p>\r\n<p>3.2. Лоты выставляются  на торги в порядке следования номеров, с которыми они представлены в каталоге.</p>\r\n<p>3.3. Аукцион «Русские  Сезоны» оставляет за собой право до начала торгов снять любой лот без объяснения причин. В ходе торгов это право предоставляется секретарю.</p>\r\n<p>3.4. Если аукционистом не объявлено иное, шаг, на который увеличивается цена лота в ходе торгов, составляет примерно 10%. </p>\r\n<p>3.5. После объявления аукционистом цены лота поднятие номерной карточки участником означает безусловное и безотзывное согласие купить выставленный на торги лот по объявленной цене. Каждое последующее поднятие карточек участниками означает согласие приобрести лот по цене, превышающей предыдущую на один шаг.</p>\r\n<p>3.6. Любой участник  в ходе торгов может сделать  предложение произвольной цены  за лот, превышающей предыдущее  предложение более, чем на один  шаг. В данном случае, последующий отсчёт ведётся от предложенной участником цены.</p>\r\n<p>3.7. С ударом  молотка, участник, определённый аукционистом,  как сделавший наивысшую ставку, считается покупателем данного лота. С этого момента лот является проданным и претензии других участников на него считаются недействительными.</p>\r\n<p>3.8. Если по выставленному лоту не поднята ни одна номерная карточка и отсутствуют заочные биды, он снимается с торгов и может быть продан в порядке постаукционной продажи.</p>\r\n<p><strong>4. Оплата и доставка</strong></p>\r\n<p>4.1. Цены на лоты указываются в рублях Российской Федерации. Оплата приобретенных на аукционе предметов принимается в российских рублях наличными, банковским переводом, кредитными картами VISA, VISA Electron, Mastercard, Mastercard Electronic, Maestro. При оплате банковскими картами покупатель оплачивает дополнительно 1,9% от суммы оплаты в качестве возмещения расходов обслуживающего банка.</p>\r\n<p>4.2. По окончании торгов покупатель сдает номерную табличку секретарю, взамен получая счет на приобретенные лоты. Сумма оплаты состоит из стоимости лотов плюс комиссионный сбор Аукциона 10%. Покупателям предоставляется возможность оплатить и забрать лоты в день проведения аукциона. В этом случае комиссионный сбор Аукциона составляет 8%.</p>\r\n<p>4.3. Оплата приобретённых лотов производится в течение 14 календарных дней с момента покупки (данный срок может быть изменён по взаимной договорённости). В противном случае факт продажи считается недействительным, клиентский номер недобросовестного участника аннулируется, и администрация Аукциона вправе приступить к дальнейшей реализации предмета. ООО “Нева-Антик” оставляет за собой право прибегнуть к средствам правовой защиты и привлечь не осуществившего платеж покупателя к ответственности в размере причитающейся суммы и начать судебный процесс в отношении ее взыскания, взыскания судебных издержек и расходов в той мере, в какой это разрешено действующим законодательством РФ. Также Аукцион “Русские Сезоны” оставляет за собой право произвести зачет любых сумм, которые могут причитаться покупателю от ООО “Нева-Антик” в счет остатка или погашения неуплаченной суммы.</p>\r\n<p>4.4. Оплата наличными, а также пластиковыми картами принимается в офисе фирмы по адресу Литейный пр., д. 15. Оплата по безналичному расчёту осуществляется через различные платёжные системы и банки.</p>\r\n<p>4.5. Доставка лота осуществляется по желанию покупателя на выбор одной из курьерских служб и оплачивается дополнительно. Доставка осуществляется только после полной оплаты его стоимости, включая сумму доставки. Хотя сотрудники Аукциона принимают все возможные меры предосторожности при упаковке и отгрузке лота, за его доставку и все риски с этим связанные Аукцион ответственности не несёт. Рекомендуется страховать все пересылаемые предметы.</p>\r\n<p>4.6. Покупатель обязан забрать предмет в течение месяца после оплаты предмета. Если не существует иной договорённости, Аукцион вправе сдать товар на хранение третьему лицу за счет Покупателя.</p>\r\n<p><strong>5. Условия и гарантии</strong></p>\r\n<p>5.1. Аукцион «Русские Сезоны» не выдаёт лицензий на вывоз предметов антиквариата за пределы РФ и не может гарантировать, что уполномоченные государственные структуры выдадут такие документы.</p>\r\n<p>5.2. Приобретение  предмета коллекционирования не  означает, что покупатель становится  обладателем авторских прав на  его изображение и тиражирование.</p>\r\n<p>5.3. Покупателям предоставляется право предварительного просмотра лотов, а также издается иллюстрированный каталог аукциона в соответствии с пунктом 1.4., поэтому претензии после окончания аукциона по качеству и состоянию предметов не принимаются.</p>\r\n<p>5.4. Аукцион «Русские Сезоны» гарантирует подлинность предметов, выставляемых на торги, и несёт за это ответственность в течение 3-х лет. Покупатель, усомнившийся в подлинности предмета, должен проинформировать об этом руководство Аукциона и привести убедительные доказательства данного факта, основанные на объективном мнении экспертов, признанных на антикварном рынке. В случае, если было установлено, что предмет, проданный на торгах, является подделкой, он должен быть предоставлен администрации Аукциона в том состоянии, в каком он был на момент продажи. Аукцион, в свою очередь, полностью возмещает покупателю стоимость, за которую предмет был приобретен на аукционе, за исключением случаев, когда на предмет на момент продажи имелось заключение сотрудников государственных музейных учреждений.</p>\r\n<p>5.5. Покупатель не вправе требовать возмещения ущерба в сумме, превышающей заплаченную им цену, дополнительных компенсаций и возмещения морального ущерба.</p>\r\n<p>5.6. Данные гарантии распространяются только на постоянного собственника предмета, т.е. человека, непосредственно купившего предмет на торгах и обладающего соответствующим документом на право собственности. Данный предмет должен быть освобождён от имущественных обязательств, что должно быть также подтверждено владельцем.</p>', '', 1, 0, 0, 8, '2013-02-02 11:30:34', 107, '', '2013-02-02 12:03:55', 107, 0, '0000-00-00 00:00:00', '2013-02-02 11:30:34', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 2, 0, 2, '', '', 1, 7, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(7, 45, 'Партнёры', 'partnery', '', '<p class="brown" style="text-align: center;"><strong>Благодарим наших партнеров за сотрудничество и содействие в проведении мероприятия!</strong></p>\r\n<p style="text-align: center;">Для участников аукциона действует специальное предложение по размещению!</p>\r\n<p style="text-align: center;">Отдел бронирования: +7(812)329-68-48, +7(812)329-60-00. Не забудьте указать, что вы участник аукциона!</p>', '', 1, 0, 0, 2, '2013-02-02 11:35:32', 107, '', '2013-02-02 12:40:38', 107, 0, '0000-00-00 00:00:00', '2013-02-02 11:35:32', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 5, 0, 14, '', '', 1, 18, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(8, 46, 'Контакты', 'kontakty', '', '<p><strong>Ворожбина Светлана Александровна</strong> – ответит на Ваши вопросы о продаже предметов  через аукционные торги<br /><strong><a href="mailto:prodaza@auction-ruseasons.ru">prodaza@auction-ruseasons.ru</a></strong></p>\r\n<p><strong>Павлов Сергей Николаевич</strong> – ответит на Ваши вопросы  о покупке предметов на аукционе<br /><strong><a href="mailto:pokupka@auction-ruseasons.ru">pokupka@auction-ruseasons.ru</a></strong></p>\r\n<p><strong>Румянцева Екатерина Анатольевна</strong> – ответит на общие  организационные вопросы по аукциону<br /><strong><a href="mailto:vopros@auction-ruseasons.ru">vopros@auction-ruseasons.ru</a></strong></p>\r\n<p><strong>Лебедева Анна Александровна</strong> примет Ваши заявки (заочные  биды) на торги<br /><strong><a href="mailto:bid@auction-ruseasons.ru">bid@auction-ruseasons.ru</a></strong></p>\r\n<p><strong>Шорина Инна Борисовна</strong> – бухгалтер<br /><strong><a href="mailto:buhgalter@auction-ruseasons.ru">buhgalter@auction-ruseasons.ru</a></strong></p>\r\n<p><strong>Вергунова Юлия Леонидовна</strong> – администратор<br /><strong><a href="mailto:admin@auction-ruseasons.ru">admin@auction-ruseasons.ru</a></strong></p>\r\n<p><strong>Наш почтовый адрес:</strong></p>\r\n<p>191187 г. Санкт-Петербург, Литейный проспект, дом 15, антикварная галерея «Русские сезоны»</p>\r\n<p><strong>Наши телефоны:</strong></p>\r\n<p>+7 (812) 275 17 49</p>\r\n<p>+7 (812) 273 99 45</p>\r\n<p>+7 (812) 579 53 57</p>\r\n<p>+7 (812) 273 91 61</p>\r\n<p><strong>Наши факсы:</strong></p>\r\n<p>+7 (812) 273 36 49</p>\r\n<p>+7 (812) 579 56 45</p>\r\n<p> </p>', '', 1, 0, 0, 2, '2013-02-02 11:37:19', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 11:37:19', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 13, '', '', 1, 16, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(9, 47, 'Вопросы', 'voprosy', '', '<h3>Как с нами связаться?</h3>\r\n<h4>1. Отправить письмо с интересующим Вас вопросом по e-mail адресам:</h4>\r\n<table width="490" border="0">\r\n<tbody>\r\n<tr>\r\n<td width="225">По вопросам продажи:</td>\r\n<td width="304"><a href="mailto:prodaza@auction-ruseasons.ru">prodaza@auction-ruseasons.ru</a></td>\r\n</tr>\r\n<tr>\r\n<td>По вопросам покупки:</td>\r\n<td><a href="mailto:prodaza@auction-ruseasons.ru">pokupka@auction-ruseasons.ru</a></td>\r\n</tr>\r\n<tr>\r\n<td>По общим вопросам:</td>\r\n<td><a href="mailto:vopros@auction-ruseasons.ru">vopros@auction-ruseasons.ru</a></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h4>2. Приехать к нам в Салон «Русские сезоны» на наб. реки. Фонтанки д. 24</h4>\r\n<div>Режим работы:   Пн-пт: с 11:00 до 20:00</div>\r\n<div>Сб. с 11:00 до 19:00</div>\r\n<div>Вс – выходной</div>\r\n<div>Наши телефоны:</div>\r\n<div>+7(812) 579 53 57;</div>\r\n<div>т/ф +7 (812) 579 56 45</div>\r\n<h4>3. Приехать к нам в Галерею «Русские сезоны» на Литейный пр. д. 15.</h4>\r\n<div>В Галерею можно приехать только по предварительному согласованию.</div>\r\n<div>Наши телефоны:  +7 (812) 275 17 49; т/ф +7 (812) 273 36 49</div>\r\n<h3>Покупка на онлайн аукционе.</h3>\r\n<h4>1. Как проходит предварительный просмотр лотов аукциона?</h4>\r\n<div>За 10 дней до начала онлайн аукциона на сайте размещается каталог с предметами, которые будут выставлены на торги, Вы можете с ними ознакомиться. И если Вы решите участвовать в торгах, зарегистрироваться.</div>\r\n<h4>2. Каким образом можно стать участником аукциона?</h4>\r\n<div>Незарегистрированные пользователи имеют возможность просматривать каталоги, а участвовать в торгах можно только после регистрации.</div>\r\n<h4>3. Для чего нужен «Кабинет»?</h4>\r\n<div>Каждый зарегистрировавшийся пользователь получает доступ в свой «Кабинет», куда отсортировывает заинтересовавшие его предметы и имеет возможность торговаться за них или просто наблюдать за ходом торгов.</div>\r\n<div>Надеемся, что «Ваш кабинет» будет для Вас удобен и сэкономит Ваше время.</div>\r\n<h4>4. Можно ли оставить бид (заявку на заочное участие), чтобы не следить за аукционом?</h4>\r\n<div>Да, заочное участие возможно. Система позволяет оставить бид и автоматически будет участвовать за Вас.</div>\r\n<h4>5. Сколько дней длится онлайн аукцион</h4>\r\n<div>Аукционные торги открываются в 15.00, закрытие происходит через 10 суток, также в 15.00. Ценой продажи лота считается последняя ставка.</div>\r\n<h4>6. Как получить информацию о купленных Вами лотах?</h4>\r\n<div>После завершения онлайн аукциона, в течение трех дней  Вы получите извещение с информацией о купленных Вами лотах на Ваш e-mail адрес, указанный при регистрации. Также Вы можете позвонить нам по нашим телефонам и мы ответим на все интересующие Вас вопросы.</div>\r\n<h4>7. Как проходит постаукционная продажа?</h4>\r\n<div>Предметы, не проданные на онлайн аукционе, при согласии сдатчика, в течение 10 дней поступают в раздел сайта «Постаукционная продажа» и Вы можете их приобрести  по фиксированной цене.</div>\r\n<h4>8. Как осуществляется доставка?</h4>\r\n<div>Доставка приобретённого Вами предмета осуществляется за Ваш счет. Мы можем помочь Вам с организацией перевозки.</div>\r\n<h3>Как выставить предмет на аукционные торги?</h3>\r\n<h4>1.     Как предложить предмет на аукцион?</h4>\r\n<div>Если Вы хотите предложить нам свои предметы на аукционные торги, возможно предварительно выслать фотографии, заполнив форму, а также привезти предметы к нам в салон или вызвать эксперта на дом (для жителей Санкт-Петербурга), услуга является бесплатной и осуществляется в удобное для Вас время. Оценка и консультация по фотографиям не производится, мы можем высказать по ним лишь свою заинтересованность.</div>\r\n<h4>2.     Сколько стоит участие?</h4>\r\n<div>Участие Вашего предмета на аукционе является бесплатным. Публикация предмета в каталоге очного аукциона также не оплачивается.</div>\r\n<div>В случае продажи предмета, Вам выплачивается сумма, за которую был продан предмет, за вычетом комиссионного вознаграждения, составляющего 10%. В любом случае, при продаже предмета, Вы получаете сумму, не ниже резервной цены, оговорённой в Договоре комиссии.</div>', '', 1, 0, 0, 2, '2013-02-02 17:34:35', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 17:34:35', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 12, '', '', 1, 2, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(10, 48, 'Доставка и оплата', 'dostavka-i-oplata', '', '<div class="form_item">\r\n<div class="form_element cf_textbox">\r\n<p align="center"><strong>ОПЛАТА</strong></p>\r\n<p><strong>- наличными (в кассу устроителя аукциона)</strong><br /> <strong>   </strong>по адресу: Санкт-Петербург, Литейный проспект, «Русские Сезоны».<br /> Пн.-Сб. с 11.00 до 20.00. Телефон +7 (812) 273 17 49</p>\r\n<p><strong>- </strong><strong>банковской</strong><strong>картой</strong><br /> <strong>   (VISA, VISA Electron, Mastercard, Mastercard Electronic, Maestro)</strong><br /> <strong>   </strong>по адресу: Санкт-Петербург, Литейный проспект, дом 15, «Русские Сезоны».<br /> Пн.-Сб. с 11.00 до 20.00. Телефон +7 (812) 273 17 49<br /> При оплате банковскими картами покупатель оплачивает <strong>дополнительно 1,9%</strong> от суммы оплаты в качестве возмещения расходов обслуживающего банка.</p>\r\n<p><strong>- оплата с использованием реквизитов Банковских карт (оформляется по факсу без личного присутствия владельца карты). Договор эквайринга. </strong><br /> <strong>    </strong>условия и требования можно посмотреть <span style="text-decoration: underline;"><a href="index.php?a=28&amp;b=154">здесь</a></span><br /> При оплате банковскими картами покупатель оплачивает <strong>дополнительно 1,9%</strong> от суммы оплаты в качестве возмещения расходов обслуживающего банка.</p>\r\n<p><strong>- банковским переводом на расчетный счет устроителя аукциона </strong><br /> <strong>   (счет по требованию)</strong><br /> <strong>   </strong>чтобы получить счет, пожалуйста, заполните Анкету покупателя, расположенную ниже или обратитесь по электронному адресу бухгалтера <a href="mailto:buhgalter@auction-ruseasons.ru">buhgalter@auction-ruseasons.ru</a> , телефон +7 (812) 273 17 49.</p>\r\n<p><strong>- оплатить через Сбербанк или любой коммерческий банк</strong><br /> <strong>  </strong>Бланк на оплату лотов: <a href="izveshenie_kvitancia.doc">КВИТАНЦИЯ</a><br /> При оплате, каждый банк взимает комиссию. Например, Сбербанк берет 3%.</p>\r\n<p>Уважаемые клиенты! Пожалуйста, перед оплатой выигранных лотов, уточните у сотрудников Аукциона конечную сумму оплаты, включающую в себя комиссионный сбор Аукциона и доставку.</p>\r\n<p><strong>БАНКОВСКИЕ РЕКВИЗИТЫ:</strong></p>\r\n<p><strong>ООО «Нева-Антик»</strong><br /> ИНН 7825425712<br /> КПП 784101001<br /> Санкт-Петербургский филиал «ТКБ» (ЗАО)<br /> р/с 40702810000300003247<br /> к/с 30101810600000000715<br /> БИК 044030715<br /> в графе "назначение платежа" обязательно указать – «ФИО, Оплата лота №___»</p>\r\n<p align="center"><strong>ДОСТАВКА</strong></p>\r\n<p>Лоты,  выставляемые на аукционе, находятся в Санкт-Петербурге. Доставка лота осуществляется по желанию покупателя на выбор одной из курьерских служб и оплачивается дополнительно. Доставка осуществляется только после полной оплаты его стоимости, включая сумму доставки.</p>\r\n<p><strong>Доставка выигранных лотов осуществляется следующими способами:</strong></p>\r\n<p>- возможно забрать лоты после оплаты предмета, по адресу Литейный пр., дом 15, «Русские Сезоны».  В случае, если Вы сразу после оплаты хотите забрать предмет, дату визита необходимо дополнительно согласовать с нашими сотрудниками по телефону +7 (812) 279-53-57.</p>\r\n<p>- доставка лотов в другие регионы осуществляется курьерскими компаниями:<br /> - компания СПСР (<a href="http://www.spsr.ru">www.spsr.ru</a>);<br /> - компания DHL (<a href="http://www.dhl.ru/">www.dhl.ru</a>)<br /> За Вами остается полное право в выборе перевозчика. Если Вы решили воспользоваться услугами персонального курьера или другой фирмой, необходимо уведомить об этом наших сотрудников и прислать доверенность на имя данного лица или фирму. <br /> Предварительную стоимость доставки Вы можете рассчитать, воспользовавшись Калькулятором на сайте компании-перевозчика или уточнить у наших сотрудников по телефону   +7 (812) 579 53 57 до покупки или после. Стоимость доставки рассчитывается отдельно для каждого лота, исходя из тарифов курьерских и почтовых служб, веса, габаритов товара и адреса доставки.</p>\r\n<p>За доставку лота и все риски с этим связанные Аукцион «Русские сезоны» ответственности не несёт. Все риски ложатся на покупателя и перевозчика.  Рекомендуется страховать все пересылаемые предметы.</p>\r\n<p><strong>Заполните, пожалуйста, форму для обработки заказа на доставку:</strong></p>\r\n</div>\r\n<div class="cfclear"> </div>\r\n</div>', '', 1, 0, 0, 2, '2013-02-02 17:40:46', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 17:40:46', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 11, '', '', 1, 2, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(11, 49, 'Черный список', 'chernyj-spisok', '', '<p>Список в состоянии перманентного пополнения...</p>', '', 1, 0, 0, 2, '2013-02-02 17:41:43', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 17:41:43', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 10, '', '', 1, 1, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(12, 50, 'Расписание аукционов', 'raspisanije-aukzionov', '', '<h3 style="text-align: center;"><span style="color: #851719;"><strong>Расписание</strong></span></h3>\r\n<p><span style="color: #841113;"><strong><span style="color: #000000;">Антикварный очный аукцион №1  – 14 ноября 2010 г.</span></strong></span></p>\r\n<p><span style="color: #841113;"><strong><span style="color: #000000;">Антикварный онлайн аукцион № 02 – с 4 по 14 декабря 2010 г.</span></strong></span></p>\r\n<p>Начало торгов 04.12.2010 в 15-00. Окончание торгов 14.12.2010 в 15-00</p>\r\n<p><span style="color: #841113;"><strong> <span style="color: #000000;">  </span></strong></span></p>', '', 1, 0, 0, 2, '2013-02-02 18:08:34', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 18:08:34', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 9, '', '', 1, 14, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(13, 51, 'Предложить предмет', 'predlozhit-predmet', '', '<div class="form_item">\r\n<div class="form_element cf_textbox">\r\n<h4>АУКЦИОН «РУССКИЕ СЕЗОНЫ» ПРИНИМАЕТ НА ТОРГИ ПРЕДМЕТЫ АНТИКВАРИАТА, ИМЕЮЩИЕ ХУДОЖЕСТВЕННУЮ И КОЛЛЕКЦИОННУЮ ЦЕННОСТЬ.&nbsp;ПРОВОДЯТСЯ ОЧНЫЕ ТОРГИ И ТОРГИ ОНЛАЙН.</h4>\r\n<p>Все продажи осуществляются официально.</p>\r\n<p>Если Вы хотите предложить нам свои предметы на аукционные торги, возможно предварительно выслать фотографии, заполнив нижеприведённую форму, а также привезти предметы к нам в салон или вызвать эксперта на дом (в пределах Санкт-Петербурга). Услуга является бесплатной и осуществляется в удобное для Вас время. Оценка и консультация по фотографиям не производится, мы можем высказать по ним лишь свою заинтересованность. Консультация и участие бесплатны.</p>\r\n<p>В случае, если предмет нас заинтересовал, мы оформляем договор хранения. Экспертный совет аукциона «Русские сезоны» проводит экспертную оценку, принимает решение о принятии предметов на торги, в т.ч. определяет вид торгов, согласовывает с Вами резервную цену, гарантированную для Вас в случае продажи, и мы заключаем с Вами комиссионный договор. Экспертный совет вправе отказать в приёме предметов на торги без объяснения причин. В отдельных случаях, при взаимной договорённости, возможна закупка за наличный расчёт.</p>\r\n<p>Аукцион «Русские сезоны» взимает комиссионный сбор в размере 10% от цены продажи, при этом при продаже не может быть выплачена сумма ниже резервной цены, указанной в договоре. В отдельных случаях, возможен договорной процент.</p>\r\n<p>Для предметов, не проданных на аукционе, Вам будет предложена постаукционная продажа.</p>\r\n<p>Соблюдаем конфиденциальность сведений о предметах и их владельцах.</p>\r\n<p>На все Ваши вопросы по аукциону ответят наши сотрудники по телефонам:</p>\r\n<p>+7 (812) 579 53 57</p>\r\n<p>+7 (812) 579 56 45</p>\r\n<p>+7 (812) 273 91 61</p>\r\n<p>Во всех ситуациях мы найдём индивидуальное решение.</p>\r\n<p>Уважаемые дамы и господа! В случае, если вы предлагаете больше одного предмета или количество фотографий больше 3, вы можете отправить письмо с описанием предметов и любым количеством фотографий по адресу <a href="mailto:prodaza@auction-ruseasons.ru">prodaza@auction-ruseasons.ru</a><a href="mailto:vopros@auction-ruseasons.ru"></a></p>\r\n</div>\r\n<div class="cfclear">&nbsp;</div>\r\n</div>', '', 1, 0, 0, 2, '2013-02-02 18:10:43', 107, '', '2013-03-01 16:24:53', 107, 0, '0000-00-00 00:00:00', '2013-02-02 18:10:43', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 3, 0, 8, '', '', 1, 6, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(14, 52, 'Результаты торгов', 'rezultaty-torgov', '', '<h1>Результаты торгов</h1>\r\n<p><span style="float: left; width: 105px;"><a href="documents/Russians_seasones_auction_01.jpg"></a><a href="images/illustrations/Russians_seasones_auction_01.jpg"><img src="documents/preview_Russians_seasones_auction_01.jpg" border="0" alt="Антиквариат Каталог №1" width="100" height="142" /></a></span></p>\r\n<p>Аукцион №1<br />14.11.2010<br /><a href="documents/Russians_seasones_auction_01.pdf">Скачать КАТАЛОГ в PDF формате</a></p>\r\n<p><a href="documents/russians_seasones_auction_01.doc">Результаты торгов</a></p>\r\n<div style="min-height: 32px; border-bottom: 1px solid; padding-top: 10px;"><a href="../index.php?a=5&amp;b=234&amp;search=1&amp;num_auction=%B91">Проданные лоты - Аукцион №1</a></div>', '', 1, 0, 0, 2, '2013-02-02 18:16:12', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-02 18:16:12', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 7, '', '', 1, 1, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(15, 53, 'Антикварная галерея', 'antikvarnaja-galereja', '', '<table style="width: 100%;" border="0">\r\n\t<tbody>\r\n\t\t<tr valign="top">\r\n\t\t\t<td width="450">\r\n\t\t\t  <br/>{module Яндекс карта: Антикварная галерея}</td>\r\n\t\t\t<td width="15"></td>\r\n\t\t\t<td>\r\n\t\t\t\t<p>Литейный пр., д. 15<br />т. +7(812) 275 17 49<br /> т/ф &nbsp;+7(812) 273 36 49<br /> Часы работы:<br /> Пн.-Сб. с 11:00 до 20:00<br /> Воскресенье - выходной<br /><br /><a href="HTTP://www.ruseasons.ru" title="Антикварная галерея &quot;Русские сезоны&quot;">www.ruseasons.ru</a>\r\n\t\t\t\t</p>\r\n\t\t\t\t<p>Галерея «Русские сезоны» находится на Литейном проспекте дом 15. Основная специализация - русская живопись конца XIX – начала ХХ веков &nbsp;и предметы &nbsp;антиквариата высшего уровня.</p>\r\n\t\t\t\t<p>В залах галереи представлены работы выдающихся &nbsp;мастеров живописи: И. Айвазовского, К. Маковского, Н. Дубовского, Б. Кустодиева, И. Шишкина, А. Головина &nbsp;и других художников.</p>\r\n\t\t\t\t<p>Также здесь можно увидеть предметы искусства, выпущенные &nbsp;знаменитой фирмой Карла Фаберже, и предметы, созданные на других фабриках по производству серебряных изделий, имевших звания придворных поставщиков Императорского двора: Братья Грачёвы, Сазиковъ, Морозовъ и т.д.</p>\r\n\t\t\t\t<p>&nbsp;</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>', '', 1, 0, 0, 2, '2013-02-02 18:25:03', 107, '', '2013-02-10 16:29:44', 107, 0, '0000-00-00 00:00:00', '2013-02-02 18:25:03', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 8, 0, 6, '', '', 1, 32, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(16, 54, 'Антикварный салон', 'antikvarnyji-salon', '', '<table style="width: 100%;" border="0">\r\n<tbody>\r\n<tr valign="top">\r\n<td width="450"><br /> {module Яндекс карта: Антикварный салон}</td>\r\n<td width="15"></td>\r\n<td>\r\n<p>Набережная реки Фонтанки, д.24&nbsp; <br /> т.&nbsp; +7 (812) 579 53 57<br /> т.&nbsp; +7 (812) 273 91 61<br /> т/ф +7 (812) 579 56 45 <br /> Часы работы: <br /> Пн.-Пт. с 11:00 до 20:00 <br /> Сб. с 11:00 до 19:00 <br /> Вс. - выходной<br /><a href="http://www.antik.su/">www.antik.su</a></p>\r\n<p>Салон «Русские сезоны» находится на&nbsp; набережной реки Фонтанки д. 24.<br />В салоне представлен широкий спектр антикварных изделий, включающий в себя как предметы русского искусства, так и западноевропейского. В экспозиции представлены живописные произведения, предметы интерьера, продукция фарфоровых фабрик и заводов России, Германии, Франции, Дании, Англии, Австрии, Испании, Японии. Обширно представлен раздел стеклянной продукции, в частности предметы Императорского стеклянного завода, заводов Богемии. Коллекционеры и любители художественной бронзы также смогут найти интересующие их предметы в нашем салоне среди экспонируемой венской бронзы, авторских работ русских мастеров, таких как: Е. Напс, М. Антокольский, Е. Лансере, а также работ западных мастеров. <br /> Многогранен и живописный раздел: портреты, пейзажи, натюрморты, камерные произведения, мифологическая, анималистическая живопись, марины, полотна на религиозные сюжеты, живопись русских и западных мастеров XVIII, XIX, ХХ веков.</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>', '', 1, 0, 0, 2, '2013-02-02 18:26:25', 107, '', '2013-02-10 16:28:05', 107, 0, '0000-00-00 00:00:00', '2013-02-02 18:26:25', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 8, 0, 5, '', '', 1, 32, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(17, 56, 'Заказ каталогов', 'zakaz-katalogov', '', '<h2 style="text-align: center;">Заказ каталогов</h2>\r\n<div>Заявку на приобретение каталога можно оставить по телефонам  в Санкт-Петербурге: </div>\r\n<div>8(812)579-53-57</div>\r\n<div>8(812)273-91-61</div>\r\n<div>или прислать на электронный адрес <a href="mailto:vopros@auction-ruseasons.ru">vopros@auction-ruseasons.ru</a> с указанием ваших контактных данных.</div>\r\n<p> </p>\r\n<div>Без предварительной  заявки каталог можно будет приобрести в Санкт-Петербурге по адресам:</div>\r\n<p> </p>\r\n<div>-наб. р.Фонтанки, д. 24, антикварный Салон «Русские Сезоны»;</div>\r\n<p> </p>\r\n<div>-Литейный пр., д. 15 , антикварная Галерея «Русские Сезоны».</div>\r\n<div> </div>\r\n<p> </p>\r\n<div>Стоимость каталога - 500 руб.</div>\r\n<p> </p>\r\n<div>Для оплаты безналичным  способом  Вы можете распечатать <span style="text-decoration: underline;"><a href="IZVESENIE_kvit_Katalog.doc">БЛАНК КВИТАНЦИИ</a></span>.<br /><br />После оплаты просьба выслать  копию квитанции по адресу <a href="mailto:vopros@auction-ruseasons.ru">vopros@auction-ruseasons.ru</a> или по факсу 8(812)579-56-45.</div>\r\n<p> </p>\r\n<div>Указывайте, пожалуйста, как можно более полные и правильные данные.</div>\r\n<h2>КАТАЛОГИ АУКЦИОНОВ</h2>\r\n<div style="width: 105px; float: left;"><a href="documents/Russians_seasones_auction_01.jpg"><img src="documents/preview_Russians_seasones_auction_01.jpg" border="0" alt="Каталог очного аукциона №1" width="100" height="142" /></a></div>\r\n<div style="width: 300px; float: left;">\r\n<p>Аукцион №1<br /> 14.11.2010<br /> <a href="documents/Russians_seasones_auction_01.pdf">Скачать КАТАЛОГ в PDF формате</a></p>\r\n<p> </p>\r\n</div>', '', 1, 0, 0, 2, '2013-02-03 09:03:48', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-03 09:03:48', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 4, '', '', 1, 15, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(18, 58, 'Приём антиквариата на торги ', 'prijom-antikvariata-na-torgi', '', '<div class="form_item">\r\n<div class="form_element cf_textbox"><b>АУКЦИОН «РУССКИЕ СЕЗОНЫ» ПРИНИМАЕТ НА ТОРГИ ПРЕДМЕТЫ АНТИКВАРИАТА, ИМЕЮЩИЕ ХУДОЖЕСТВЕННУЮ И КОЛЛЕКЦИОННУЮ ЦЕННОСТЬ.&nbsp;ПРОВОДЯТСЯ ОЧНЫЕ ТОРГИ И ТОРГИ ОНЛАЙН.</b>\r\n<p>Все продажи осуществляются официально.</p>\r\n<p>Если Вы хотите предложить нам свои предметы на аукционные торги, возможно предварительно выслать фотографии, заполнив нижеприведённую форму, а также привезти предметы к нам в салон или вызвать эксперта на дом (в пределах Санкт-Петербурга). Услуга является бесплатной и осуществляется в удобное для Вас время. Оценка и консультация по фотографиям не производится, мы можем высказать по ним лишь свою заинтересованность. Консультация и участие бесплатны.</p>\r\n<p>В случае, если предмет нас заинтересовал, мы оформляем договор хранения. Экспертный совет аукциона «Русские сезоны» проводит экспертную оценку, принимает решение о принятии предметов на торги, в т.ч. определяет вид торгов, согласовывает с Вами резервную цену, гарантированную для Вас в случае продажи, и мы заключаем с Вами комиссионный договор. Экспертный совет вправе отказать в приёме предметов на торги без объяснения причин. В отдельных случаях, при взаимной договорённости, возможна закупка за наличный расчёт.</p>\r\n<p>Аукцион «Русские сезоны» взимает комиссионный сбор в размере 10% от цены продажи, при этом при продаже не может быть выплачена сумма ниже резервной цены, указанной в договоре. В отдельных случаях, возможен договорной процент.</p>\r\n<p>Для предметов, не проданных на аукционе, Вам будет предложена постаукционная продажа.</p>\r\n<p>Соблюдаем конфиденциальность сведений о предметах и их владельцах.</p>\r\n<p>На все Ваши вопросы по аукциону ответят наши сотрудники по телефонам:</p>\r\n<p>+7 (812) 579 53 57</p>\r\n<p>+7 (812) 579 56 45</p>\r\n<p>+7 (812) 273 91 61</p>\r\n<p>Во всех ситуациях мы найдём индивидуальное решение.</p>\r\n<p>Уважаемые дамы и господа! В случае, если вы предлагаете больше одного предмета или количество фотографий больше 3, вы можете отправить письмо с описанием предметов и любым количеством фотографий по адресу <a href="mailto:prodaza@auction-ruseasons.ru">prodaza@auction-ruseasons.ru</a><a href="mailto:vopros@auction-ruseasons.ru"></a></p>\r\n</div>\r\n<div class="cfclear">&nbsp;</div>\r\n</div>\r\n<div>&nbsp;</div>', '', 1, 0, 0, 2, '2013-02-03 14:16:39', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-03 14:16:39', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 3, '', '', 1, 2, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(22, 66, 'Задать вопрос по лоту', 'zadat-vopros-po-lotu', '', '<p>Возникли вопросы по лоту? Заполните приведенную ниже форму и сотрудники аукциона обязательно ответят на Ваш вопрос отправив ответ по электронной почте.</p>', '', 1, 0, 0, 2, '2013-02-26 07:40:22', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-26 07:40:22', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 1, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(19, 61, 'Регистрация', 'registratsija', '', '<p>Добро пожаловать! Чтобы стать участником аукционных торгов и иметь доступ в «Ваш кабинет», заполните, пожалуйста, регистрационную форму. Все сведения конфиденциальны, разглашению и публикации не подлежат. Подробней узнать о порядке регистрации и пользовании Вашим кабинетом можно в разделе <a href="index.php?option=com_content&amp;view=article&amp;id=4:pravila-registraciji-uchastnikov-torgov&amp;catid=8:pravila&amp;Itemid=131">Правила регистрации участников торгов</a></p>\r\n<p class="page_instructions">( * ) поля, обязательные для заполнения" красным болдом без кавычек "Если у Вас возникли проблемы с регистрацией, свяжитесь пожалуйста с нашим сотрудником по электронной почте <a href="mailto:admin@auction-ruseasons.ru">admin@auction-ruseasons.ru</a>, мы обязательно поможем Вам!</p>', '', 1, 0, 0, 2, '2013-02-07 19:58:25', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-07 19:58:25', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 2, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(20, 62, 'Спасибо за регистрацию', 'thanx', '', '<center>\r\n<h2>Спасибо за регистрацию!</h2>\r\n<h4>Мы проверим ваши данные в ближайшее время.</h4>\r\n<a href="index.php">На главную</a></center>', '', 1, 0, 0, 9, '2013-02-10 11:34:33', 107, '', '2013-02-10 18:48:26', 107, 0, '0000-00-00 00:00:00', '2013-02-10 11:34:33', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 3, 0, 0, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(21, 64, 'Спасибо за предложение предмета', 'thanx-for-lot', '', '<center>\r\n\t<h2>Спасибо за предложение предмета!</h2>\r\n\t<h4>Мы рассмотрим вашу заявку в ближайшее время.</h4><a href="index.php">На главную</a>\r\n</center>\r\n<p>&nbsp;</p>', '', 1, 0, 0, 9, '2013-02-10 18:49:03', 107, '', '2013-02-10 18:49:47', 107, 0, '0000-00-00 00:00:00', '2013-02-10 18:49:03', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 2, 0, 0, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(23, 67, 'Поставить заочный бид', 'postavit-zaochnyj-bid', '', '<p>&nbsp;</p>\r\n<p>Уважаемые клиенты, для участия в очных аукционных торгах по телефону или для заочного участия в аукционе необходимо заполнить следующую форму <a href="bid.doc">ЗАОЧНЫЙ БИД</a>. Заполненную заявку вместе с ксерокопией паспорта (1-я стр.+регистрация), не позднее чем за 24 часа до начала аукциона, следует направить сотрудникам Аукциона «Русские Сезоны» по факсу: 8(812)2733649 или 8(812)5795645, либо принести лично в Галерею «Русские Сезоны» по адресу: Санкт-Петербург, Литейный пр., дом 15 или Салон «Русские Сезоны» по адресу: Санкт-Петербург, набережная реки Фонтанки, дом 24. Заявка считается принятой, если Вы получили обратно ксерокопию с пометкой о дате и времени её принятия.</p>\r\n<p>Аукцион «Русские Сезоны» гарантирует конфиденциальность полученной информации и обязуется попытаться приобрести каждый лот за минимально возможную цену. При поступлении равнозначных ставок на один и тот же лот, приоритетом обладает тот, чья бидовая форма зарегистрирована раньше.</p>\r\n<p>Обратите внимание, в тех случаях, когда Вы не являетесь клиентом Аукциона «Русские сезоны», Ваша личность неизвестна его организаторам, Вы не имеете надёжных рекомендаций, а сумма Ваших заочных бидов велика, администрация Аукциона вправе потребовать внесение задатка. Задаток составляет 10% от суммы лидирующих ставок данного клиента. В случае если ставки будут перекрыты, задаток незамедлительно возвращается, если же клиент не пожелает оплатить купленные им лоты — задаток переходит Аукциону «Русские Сезоны» в полном объеме.</p>', '', 1, 0, 0, 2, '2013-02-26 18:42:52', 107, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-02-26 18:42:52', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 0, '', '', 1, 6, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', '');

-- 
-- Вывод данных для таблицы auc13_content_frontpage
--

-- Таблица auctionru_2013.auc13_content_frontpage не содержит данных

-- 
-- Вывод данных для таблицы auc13_content_rating
--

-- Таблица auctionru_2013.auc13_content_rating не содержит данных

-- 
-- Вывод данных для таблицы auc13_core_log_searches
--

-- Таблица auctionru_2013.auc13_core_log_searches не содержит данных

-- 
-- Вывод данных для таблицы auc13_extensions
--
INSERT INTO auc13_extensions VALUES
(1, 'com_mailto', 'component', 'com_mailto', '', 0, 1, 1, 1, '{"legacy":false,"name":"com_mailto","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MAILTO_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(2, 'com_wrapper', 'component', 'com_wrapper', '', 0, 1, 1, 1, '{"legacy":false,"name":"com_wrapper","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_WRAPPER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(3, 'com_admin', 'component', 'com_admin', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_admin","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_ADMIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(4, 'com_banners', 'component', 'com_banners', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_banners","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_BANNERS_XML_DESCRIPTION","group":""}', '{"purchase_type":"3","track_impressions":"0","track_clicks":"0","metakey_prefix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(5, 'com_cache', 'component', 'com_cache', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_cache","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CACHE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(6, 'com_categories', 'component', 'com_categories', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_categories","type":"component","creationDate":"December 2007","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CATEGORIES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(7, 'com_checkin', 'component', 'com_checkin', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_checkin","type":"component","creationDate":"Unknown","author":"Joomla! Project","copyright":"(C) 2005 - 2008 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CHECKIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(8, 'com_contact', 'component', 'com_contact', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_contact","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONTACT_XML_DESCRIPTION","group":""}', '{"show_contact_category":"hide","show_contact_list":"0","presentation_style":"sliders","show_name":"1","show_position":"1","show_email":"0","show_street_address":"1","show_suburb":"1","show_state":"1","show_postcode":"1","show_country":"1","show_telephone":"1","show_mobile":"1","show_fax":"1","show_webpage":"1","show_misc":"1","show_image":"1","image":"","allow_vcard":"0","show_articles":"0","show_profile":"0","show_links":"0","linka_name":"","linkb_name":"","linkc_name":"","linkd_name":"","linke_name":"","contact_icons":"0","icon_address":"","icon_email":"","icon_telephone":"","icon_mobile":"","icon_fax":"","icon_misc":"","show_headings":"1","show_position_headings":"1","show_email_headings":"0","show_telephone_headings":"1","show_mobile_headings":"0","show_fax_headings":"0","allow_vcard_headings":"0","show_suburb_headings":"1","show_state_headings":"1","show_country_headings":"1","show_email_form":"1","show_email_copy":"1","banned_email":"","banned_subject":"","banned_text":"","validate_session":"1","custom_reply":"0","redirect":"","show_category_crumb":"0","metakey":"","metadesc":"","robots":"","author":"","rights":"","xreference":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(9, 'com_cpanel', 'component', 'com_cpanel', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_cpanel","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CPANEL_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10, 'com_installer', 'component', 'com_installer', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_installer","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_INSTALLER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(11, 'com_languages', 'component', 'com_languages', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_languages","type":"component","creationDate":"2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_LANGUAGES_XML_DESCRIPTION","group":""}', '{"administrator":"ru-RU","site":"ru-RU"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(12, 'com_login', 'component', 'com_login', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_login","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(13, 'com_media', 'component', 'com_media', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_media","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MEDIA_XML_DESCRIPTION","group":""}', '{"upload_extensions":"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS","upload_maxsize":"10","file_path":"images","image_path":"images","restrict_uploads":"1","allowed_media_usergroup":"3","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip","upload_mime_illegal":"text\\/html","enable_flash":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(14, 'com_menus', 'component', 'com_menus', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_menus","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MENUS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(15, 'com_messages', 'component', 'com_messages', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_messages","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MESSAGES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(16, 'com_modules', 'component', 'com_modules', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_modules","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MODULES_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(17, 'com_newsfeeds', 'component', 'com_newsfeeds', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_newsfeeds","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_NEWSFEEDS_XML_DESCRIPTION","group":""}', '{"show_feed_image":"1","show_feed_description":"1","show_item_description":"1","feed_word_count":"0","show_headings":"1","show_name":"1","show_articles":"0","show_link":"1","show_description":"1","show_description_image":"1","display_num":"","show_pagination_limit":"1","show_pagination":"1","show_pagination_results":"1","show_cat_items":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(18, 'com_plugins', 'component', 'com_plugins', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_plugins","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_PLUGINS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(19, 'com_search', 'component', 'com_search', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_search","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_SEARCH_XML_DESCRIPTION","group":""}', '{"enabled":"0","show_date":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(20, 'com_templates', 'component', 'com_templates', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_templates","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_TEMPLATES_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(21, 'com_weblinks', 'component', 'com_weblinks', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_weblinks","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_WEBLINKS_XML_DESCRIPTION","group":""}', '{"show_comp_description":"1","comp_description":"","show_link_hits":"1","show_link_description":"1","show_other_cats":"0","show_headings":"0","show_numbers":"0","show_report":"1","count_clicks":"1","target":"0","link_icons":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(22, 'com_content', 'component', 'com_content', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_content","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONTENT_XML_DESCRIPTION","group":""}', '{"article_layout":"_:default","show_title":"0","link_titles":"1","show_intro":"1","show_category":"0","link_category":"1","show_parent_category":"0","link_parent_category":"0","show_author":"0","link_author":"0","show_create_date":"0","show_modify_date":"0","show_publish_date":"0","show_item_navigation":"0","show_vote":"0","show_readmore":"0","show_readmore_title":"0","readmore_limit":"100","show_icons":"0","show_print_icon":"0","show_email_icon":"0","show_hits":"0","show_noauth":"0","urls_position":"0","show_publishing_options":"1","show_article_options":"1","show_urls_images_frontend":"0","show_urls_images_backend":"1","targeta":0,"targetb":0,"targetc":0,"float_intro":"left","float_fulltext":"left","category_layout":"_:blog","show_category_title":"0","show_description":"0","show_description_image":"0","maxLevel":"1","show_empty_categories":"0","show_no_articles":"1","show_subcat_desc":"1","show_cat_num_articles":"0","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_num_articles_cat":"1","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","multi_column_order":"0","show_subcategory_content":"0","show_pagination_limit":"1","filter_field":"hide","show_headings":"1","list_show_date":"0","date_format":"","list_show_hits":"1","list_show_author":"1","orderby_pri":"order","orderby_sec":"rdate","order_date":"published","show_pagination":"2","show_pagination_results":"1","show_feed_link":"1","feed_summary":"0","feed_show_readmore":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(23, 'com_config', 'component', 'com_config', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_config","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONFIG_XML_DESCRIPTION","group":""}', '{"filters":{"1":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"6":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"7":{"filter_type":"NONE","filter_tags":"","filter_attributes":""},"2":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"3":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"4":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"5":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"8":{"filter_type":"NONE","filter_tags":"","filter_attributes":""}}}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(24, 'com_redirect', 'component', 'com_redirect', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_redirect","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_REDIRECT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(25, 'com_users', 'component', 'com_users', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_users","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_USERS_XML_DESCRIPTION","group":""}', '{"allowUserRegistration":"1","new_usertype":"2","guest_usergroup":"1","sendpassword":"1","useractivation":"1","mail_to_admin":"0","captcha":"recaptcha","frontend_userparams":"1","site_language":"0","change_login_name":"0","reset_count":"10","reset_time":"1","mailSubjectPrefix":"","mailBodySuffix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(27, 'com_finder', 'component', 'com_finder', '', 1, 1, 0, 0, '{"legacy":false,"name":"com_finder","type":"component","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_FINDER_XML_DESCRIPTION","group":""}', '{"show_description":"1","description_length":255,"allow_empty_query":"0","show_url":"1","show_advanced":"1","expand_advanced":"0","show_date_filters":"0","highlight_terms":"1","opensearch_name":"","opensearch_description":"","batch_size":"50","memory_table_limit":30000,"title_multiplier":"1.7","text_multiplier":"0.7","meta_multiplier":"1.2","path_multiplier":"2.0","misc_multiplier":"0.3","stemmer":"snowball"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(28, 'com_joomlaupdate', 'component', 'com_joomlaupdate', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_joomlaupdate","type":"component","creationDate":"February 2012","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_JOOMLAUPDATE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(100, 'PHPMailer', 'library', 'phpmailer', '', 0, 1, 1, 1, '{"legacy":false,"name":"PHPMailer","type":"library","creationDate":"2001","author":"PHPMailer","copyright":"(c) 2001-2003, Brent R. Matzelle, (c) 2004-2009, Andy Prevost. All Rights Reserved., (c) 2010-2011, Jim Jagielski. All Rights Reserved.","authorEmail":"jimjag@gmail.com","authorUrl":"https:\\/\\/code.google.com\\/a\\/apache-extras.org\\/p\\/phpmailer\\/","version":"5.2","description":"LIB_PHPMAILER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(101, 'SimplePie', 'library', 'simplepie', '', 0, 1, 1, 1, '{"legacy":false,"name":"SimplePie","type":"library","creationDate":"2004","author":"SimplePie","copyright":"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon","authorEmail":"","authorUrl":"http:\\/\\/simplepie.org\\/","version":"1.2","description":"LIB_SIMPLEPIE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(102, 'phputf8', 'library', 'phputf8', '', 0, 1, 1, 1, '{"legacy":false,"name":"phputf8","type":"library","creationDate":"2006","author":"Harry Fuecks","copyright":"Copyright various authors","authorEmail":"hfuecks@gmail.com","authorUrl":"http:\\/\\/sourceforge.net\\/projects\\/phputf8","version":"0.5","description":"LIB_PHPUTF8_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(103, 'Joomla! Platform', 'library', 'joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"Joomla! Platform","type":"library","creationDate":"2008","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"11.4","description":"LIB_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(200, 'mod_articles_archive', 'module', 'mod_articles_archive', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_archive","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters.\\n\\t\\tAll rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(201, 'mod_articles_latest', 'module', 'mod_articles_latest', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_latest","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LATEST_NEWS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(202, 'mod_articles_popular', 'module', 'mod_articles_popular', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_articles_popular","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_POPULAR_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(203, 'mod_banners', 'module', 'mod_banners', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_banners","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_BANNERS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(204, 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_breadcrumbs","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_BREADCRUMBS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(205, 'mod_custom', 'module', 'mod_custom', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_custom","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_CUSTOM_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(206, 'mod_feed', 'module', 'mod_feed', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_feed","type":"module","creationDate":"July 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FEED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(207, 'mod_footer', 'module', 'mod_footer', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_footer","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FOOTER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(208, 'mod_login', 'module', 'mod_login', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_login","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(209, 'mod_menu', 'module', 'mod_menu', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_menu","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_MENU_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(210, 'mod_articles_news', 'module', 'mod_articles_news', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_articles_news","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_NEWS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(211, 'mod_random_image', 'module', 'mod_random_image', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_random_image","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_RANDOM_IMAGE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(212, 'mod_related_items', 'module', 'mod_related_items', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_related_items","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_RELATED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(213, 'mod_search', 'module', 'mod_search', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_search","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_SEARCH_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(214, 'mod_stats', 'module', 'mod_stats', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_stats","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_STATS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(215, 'mod_syndicate', 'module', 'mod_syndicate', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_syndicate","type":"module","creationDate":"May 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_SYNDICATE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(216, 'mod_users_latest', 'module', 'mod_users_latest', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_users_latest","type":"module","creationDate":"December 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_USERS_LATEST_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(217, 'mod_weblinks', 'module', 'mod_weblinks', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_weblinks","type":"module","creationDate":"July 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_WEBLINKS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(218, 'mod_whosonline', 'module', 'mod_whosonline', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_whosonline","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_WHOSONLINE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(219, 'mod_wrapper', 'module', 'mod_wrapper', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_wrapper","type":"module","creationDate":"October 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_WRAPPER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(220, 'mod_articles_category', 'module', 'mod_articles_category', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_category","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(221, 'mod_articles_categories', 'module', 'mod_articles_categories', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_categories","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(222, 'mod_languages', 'module', 'mod_languages', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_languages","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LANGUAGES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(223, 'mod_finder', 'module', 'mod_finder', '', 0, 1, 0, 0, '{"legacy":false,"name":"mod_finder","type":"module","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FINDER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(300, 'mod_custom', 'module', 'mod_custom', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_custom","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_CUSTOM_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(301, 'mod_feed', 'module', 'mod_feed', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_feed","type":"module","creationDate":"July 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FEED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(302, 'mod_latest', 'module', 'mod_latest', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_latest","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LATEST_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(303, 'mod_logged', 'module', 'mod_logged', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_logged","type":"module","creationDate":"January 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LOGGED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(304, 'mod_login', 'module', 'mod_login', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_login","type":"module","creationDate":"March 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(305, 'mod_menu', 'module', 'mod_menu', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_menu","type":"module","creationDate":"March 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_MENU_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(307, 'mod_popular', 'module', 'mod_popular', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_popular","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_POPULAR_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(308, 'mod_quickicon', 'module', 'mod_quickicon', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_quickicon","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_QUICKICON_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(309, 'mod_status', 'module', 'mod_status', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_status","type":"module","creationDate":"Feb 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_STATUS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(310, 'mod_submenu', 'module', 'mod_submenu', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_submenu","type":"module","creationDate":"Feb 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_SUBMENU_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(311, 'mod_title', 'module', 'mod_title', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_title","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_TITLE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(312, 'mod_toolbar', 'module', 'mod_toolbar', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_toolbar","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_TOOLBAR_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(313, 'mod_multilangstatus', 'module', 'mod_multilangstatus', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_multilangstatus","type":"module","creationDate":"September 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_MULTILANGSTATUS_XML_DESCRIPTION","group":""}', '{"cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(314, 'mod_version', 'module', 'mod_version', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_version","type":"module","creationDate":"January 2012","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_VERSION_XML_DESCRIPTION","group":""}', '{"format":"short","product":"1","cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(400, 'plg_authentication_gmail', 'plugin', 'gmail', 'authentication', 0, 0, 1, 0, '{"legacy":false,"name":"plg_authentication_gmail","type":"plugin","creationDate":"February 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_GMAIL_XML_DESCRIPTION","group":""}', '{"applysuffix":"0","suffix":"","verifypeer":"1","user_blacklist":""}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(401, 'plg_authentication_joomla', 'plugin', 'joomla', 'authentication', 0, 1, 1, 1, '{"legacy":false,"name":"plg_authentication_joomla","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_AUTH_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(402, 'plg_authentication_ldap', 'plugin', 'ldap', 'authentication', 0, 0, 1, 0, '{"legacy":false,"name":"plg_authentication_ldap","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_LDAP_XML_DESCRIPTION","group":""}', '{"host":"","port":"389","use_ldapV3":"0","negotiate_tls":"0","no_referrals":"0","auth_method":"bind","base_dn":"","search_string":"","users_dn":"","username":"admin","password":"bobby7","ldap_fullname":"fullName","ldap_email":"mail","ldap_uid":"uid"}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(404, 'plg_content_emailcloak', 'plugin', 'emailcloak', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_emailcloak","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION","group":""}', '{"mode":"1"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(405, 'plg_content_geshi', 'plugin', 'geshi', 'content', 0, 0, 1, 0, '{"legacy":false,"name":"plg_content_geshi","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"","authorUrl":"qbnz.com\\/highlighter","version":"2.5.0","description":"PLG_CONTENT_GESHI_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(406, 'plg_content_loadmodule', 'plugin', 'loadmodule', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_loadmodule","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_LOADMODULE_XML_DESCRIPTION","group":""}', '{"style":"xhtml"}', '', '', 0, '2011-09-18 15:22:50', 0, 0),
(407, 'plg_content_pagebreak', 'plugin', 'pagebreak', 'content', 0, 1, 1, 1, '{"legacy":false,"name":"plg_content_pagebreak","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION","group":""}', '{"title":"1","multipage_toc":"1","showall":"1"}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(408, 'plg_content_pagenavigation', 'plugin', 'pagenavigation', 'content', 0, 1, 1, 1, '{"legacy":false,"name":"plg_content_pagenavigation","type":"plugin","creationDate":"January 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_PAGENAVIGATION_XML_DESCRIPTION","group":""}', '{"position":"1"}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(409, 'plg_content_vote', 'plugin', 'vote', 'content', 0, 1, 1, 1, '{"legacy":false,"name":"plg_content_vote","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_VOTE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(410, 'plg_editors_codemirror', 'plugin', 'codemirror', 'editors', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors_codemirror","type":"plugin","creationDate":"28 March 2011","author":"Marijn Haverbeke","copyright":"","authorEmail":"N\\/A","authorUrl":"","version":"1.0","description":"PLG_CODEMIRROR_XML_DESCRIPTION","group":""}', '{"linenumbers":"0","tabmode":"indent"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(411, 'plg_editors_none', 'plugin', 'none', 'editors', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors_none","type":"plugin","creationDate":"August 2004","author":"Unknown","copyright":"","authorEmail":"N\\/A","authorUrl":"","version":"2.5.0","description":"PLG_NONE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(412, 'plg_editors_tinymce', 'plugin', 'tinymce', 'editors', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors_tinymce","type":"plugin","creationDate":"2005-2012","author":"Moxiecode Systems AB","copyright":"Moxiecode Systems AB","authorEmail":"N\\/A","authorUrl":"tinymce.moxiecode.com\\/","version":"3.5.4.1","description":"PLG_TINY_XML_DESCRIPTION","group":""}', '{"mode":"1","skin":"0","entity_encoding":"raw","lang_mode":"0","lang_code":"en","text_direction":"ltr","content_css":"1","content_css_custom":"","relative_urls":"1","newlines":"0","invalid_elements":"script,applet,iframe","extended_elements":"","toolbar":"top","toolbar_align":"left","html_height":"550","html_width":"750","resizing":"true","resize_horizontal":"false","element_path":"1","fonts":"1","paste":"1","searchreplace":"1","insertdate":"1","format_date":"%Y-%m-%d","inserttime":"1","format_time":"%H:%M:%S","colors":"1","table":"1","smilies":"1","media":"1","hr":"1","directionality":"1","fullscreen":"1","style":"1","layer":"1","xhtmlxtras":"1","visualchars":"1","nonbreaking":"1","template":"1","blockquote":"1","wordcount":"1","advimage":"1","advlink":"1","advlist":"1","autosave":"1","contextmenu":"1","inlinepopups":"1","custom_plugin":"","custom_button":""}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(413, 'plg_editors-xtd_article', 'plugin', 'article', 'editors-xtd', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors-xtd_article","type":"plugin","creationDate":"October 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_ARTICLE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(414, 'plg_editors-xtd_image', 'plugin', 'image', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_image","type":"plugin","creationDate":"August 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_IMAGE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(415, 'plg_editors-xtd_pagebreak', 'plugin', 'pagebreak', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_pagebreak","type":"plugin","creationDate":"August 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(416, 'plg_editors-xtd_readmore', 'plugin', 'readmore', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_readmore","type":"plugin","creationDate":"March 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_READMORE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(417, 'plg_search_categories', 'plugin', 'categories', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_categories","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(418, 'plg_search_contacts', 'plugin', 'contacts', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_contacts","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_CONTACTS_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(419, 'plg_search_content', 'plugin', 'content', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_content","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_CONTENT_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(420, 'plg_search_newsfeeds', 'plugin', 'newsfeeds', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_newsfeeds","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(421, 'plg_search_weblinks', 'plugin', 'weblinks', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_weblinks","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_WEBLINKS_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(422, 'plg_system_languagefilter', 'plugin', 'languagefilter', 'system', 0, 0, 1, 1, '{"legacy":false,"name":"plg_system_languagefilter","type":"plugin","creationDate":"July 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(423, 'plg_system_p3p', 'plugin', 'p3p', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_p3p","type":"plugin","creationDate":"September 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_P3P_XML_DESCRIPTION","group":""}', '{"headers":"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(424, 'plg_system_cache', 'plugin', 'cache', 'system', 0, 0, 1, 1, '{"legacy":false,"name":"plg_system_cache","type":"plugin","creationDate":"February 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CACHE_XML_DESCRIPTION","group":""}', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '0000-00-00 00:00:00', 9, 0),
(425, 'plg_system_debug', 'plugin', 'debug', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_debug","type":"plugin","creationDate":"December 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_DEBUG_XML_DESCRIPTION","group":""}', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"1","strip-first":"1","strip-prefix":"","strip-suffix":""}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(426, 'plg_system_log', 'plugin', 'log', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_log","type":"plugin","creationDate":"April 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_LOG_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(427, 'plg_system_redirect', 'plugin', 'redirect', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_redirect","type":"plugin","creationDate":"April 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_REDIRECT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(428, 'plg_system_remember', 'plugin', 'remember', 'system', 0, 0, 1, 1, '{"legacy":false,"name":"plg_system_remember","type":"plugin","creationDate":"April 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_REMEMBER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(429, 'plg_system_sef', 'plugin', 'sef', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_sef","type":"plugin","creationDate":"December 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEF_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 8, 0),
(430, 'plg_system_logout', 'plugin', 'logout', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_logout","type":"plugin","creationDate":"April 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(431, 'plg_user_contactcreator', 'plugin', 'contactcreator', 'user', 0, 0, 1, 1, '{"legacy":false,"name":"plg_user_contactcreator","type":"plugin","creationDate":"August 2009","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTACTCREATOR_XML_DESCRIPTION","group":""}', '{"autowebpage":"","category":"34","autopublish":"0"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(432, 'plg_user_joomla', 'plugin', 'joomla', 'user', 0, 1, 1, 0, '{"legacy":false,"name":"plg_user_joomla","type":"plugin","creationDate":"December 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2009 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_USER_JOOMLA_XML_DESCRIPTION","group":""}', '{"autoregister":"1"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(433, 'plg_user_profile', 'plugin', 'profile', 'user', 0, 1, 1, 1, '{"legacy":false,"name":"plg_user_profile","type":"plugin","creationDate":"January 2008","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_USER_PROFILE_XML_DESCRIPTION","group":""}', '{"register-require_address1":"1","register-require_address2":"1","register-require_city":"1","register-require_region":"1","register-require_country":"1","register-require_postal_code":"1","register-require_phone":"1","register-require_website":"1","register-require_favoritebook":"1","register-require_aboutme":"1","register-require_tos":"1","register-require_dob":"1","profile-require_address1":"1","profile-require_address2":"1","profile-require_city":"1","profile-require_region":"1","profile-require_country":"1","profile-require_postal_code":"1","profile-require_phone":"1","profile-require_website":"1","profile-require_favoritebook":"1","profile-require_aboutme":"1","profile-require_tos":"1","profile-require_dob":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(434, 'plg_extension_joomla', 'plugin', 'joomla', 'extension', 0, 1, 1, 1, '{"legacy":false,"name":"plg_extension_joomla","type":"plugin","creationDate":"May 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(435, 'plg_content_joomla', 'plugin', 'joomla', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_joomla","type":"plugin","creationDate":"November 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(436, 'plg_system_languagecode', 'plugin', 'languagecode', 'system', 0, 0, 1, 0, '{"legacy":false,"name":"plg_system_languagecode","type":"plugin","creationDate":"November 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 10, 0),
(437, 'plg_quickicon_joomlaupdate', 'plugin', 'joomlaupdate', 'quickicon', 0, 1, 1, 1, '{"legacy":false,"name":"plg_quickicon_joomlaupdate","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(438, 'plg_quickicon_extensionupdate', 'plugin', 'extensionupdate', 'quickicon', 0, 1, 1, 1, '{"legacy":false,"name":"plg_quickicon_extensionupdate","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(439, 'plg_captcha_recaptcha', 'plugin', 'recaptcha', 'captcha', 0, 1, 1, 0, '{"legacy":false,"name":"plg_captcha_recaptcha","type":"plugin","creationDate":"December 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION","group":""}', '{"public_key":"6Lest90SAAAAAA8qVb_-_ShDWrEjq433w9-egFbA","private_key":"6Lest90SAAAAAFbotT7ODJo3LALbvsJMHpfkN7AG","theme":"white"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(440, 'plg_system_highlight', 'plugin', 'highlight', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_highlight","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(441, 'plg_content_finder', 'plugin', 'finder', 'content', 0, 0, 1, 0, '{"legacy":false,"name":"plg_content_finder","type":"plugin","creationDate":"December 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_FINDER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(442, 'plg_finder_categories', 'plugin', 'categories', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_categories","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_CATEGORIES_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(443, 'plg_finder_contacts', 'plugin', 'contacts', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_contacts","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_CONTACTS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(444, 'plg_finder_content', 'plugin', 'content', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_content","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_CONTENT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(445, 'plg_finder_newsfeeds', 'plugin', 'newsfeeds', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_newsfeeds","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(446, 'plg_finder_weblinks', 'plugin', 'weblinks', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_weblinks","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_WEBLINKS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(502, 'bluestork', 'template', 'bluestork', '', 1, 1, 1, 0, '{"legacy":false,"name":"bluestork","type":"template","creationDate":"07\\/02\\/09","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"TPL_BLUESTORK_XML_DESCRIPTION","group":""}', '{"useRoundedCorners":"1","showSiteName":"0","textBig":"0","highContrast":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(600, 'English (United Kingdom)', 'language', 'en-GB', '', 0, 1, 1, 1, '{"legacy":false,"name":"English (United Kingdom)","type":"language","creationDate":"2008-03-15","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.5","description":"en-GB site language","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(601, 'English (United Kingdom)', 'language', 'en-GB', '', 1, 1, 1, 1, '{"legacy":false,"name":"English (United Kingdom)","type":"language","creationDate":"2008-03-15","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.5","description":"en-GB administrator language","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(700, 'files_joomla', 'file', 'joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"files_joomla","type":"file","creationDate":"November 2012","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.8","description":"FILES_JOOMLA_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(800, 'PKG_JOOMLA', 'package', 'pkg_joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"PKG_JOOMLA","type":"package","creationDate":"2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"2.5.0","description":"PKG_JOOMLA_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10000, 'Russian', 'language', 'ru-RU', '', 0, 1, 0, 0, '{"legacy":true,"name":"Russian","type":"language","creationDate":"2012-11-14","author":"Russian Translation Team","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved","authorEmail":"smart@joomlaportal.ru","authorUrl":"www.joomlaportal.ru","version":"2.5.8.4","description":"Russian language pack (site) for Joomla! 2.5","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10001, 'Russian', 'language', 'ru-RU', '', 1, 1, 0, 0, '{"legacy":true,"name":"Russian","type":"language","creationDate":"2012-11-14","author":"Russian Translation Team","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved","authorEmail":"smart@joomlaportal.ru","authorUrl":"www.joomlaportal.ru","version":"2.5.8.4","description":"Russian language pack (administrator) for Joomla! 2.5","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10002, 'TinyMCE ru-RU', 'file', 'tinymce_ru-ru', '', 0, 1, 0, 0, '{"legacy":false,"name":"TinyMCE ru-RU","type":"file","creationDate":"2012-06-19","author":"Russian Translation Team","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved","authorEmail":"smart@joomlaportal.ru","authorUrl":"www.joomlaportal.ru","version":"3.5.2.1","description":"Russian Language Package for TinyMCE 3.5.2.1 in Joomla 2.5","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10003, 'ru-RU', 'package', 'pkg_ru-RU', '', 0, 1, 1, 0, '{"legacy":false,"name":"Russian Language Pack","type":"package","creationDate":"Unknown","author":"Unknown","copyright":"","authorEmail":"","authorUrl":"","version":"2.5.8.4","description":"Joomla 2.5 Russian Language Package","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10004, 'virtuemart', 'component', 'com_virtuemart', '', 1, 1, 0, 0, '{"legacy":true,"name":"VIRTUEMART","type":"component","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"max|at|virtuemart.net","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10005, 'virtuemart_allinone', 'component', 'com_virtuemart_allinone', '', 1, 1, 0, 0, '{"legacy":true,"name":"VirtueMart_allinone","type":"component","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10006, 'Standard', 'plugin', 'standard', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"VMPAYMENT_STANDARD","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"Standard payment plugin","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10007, 'Paypal', 'plugin', 'paypal', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"VMPAYMENT_PAYPAL","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"<a href=\\"http:\\/\\/paypal.com\\" target=\\"_blank\\">PayPal<\\/a> is a popular\\n\\tpayment provider and available in many countries. \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10008, 'PayZen', 'plugin', 'payzen', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"VM - Payment, PayZen","type":"plugin","creationDate":"July 04 2012","author":"Lyra Network","copyright":"Copyright Lyra Network.","authorEmail":"support@payzen.eu","authorUrl":"http:\\/\\/www.lyra-network.com","version":"2.0.8c","description":"\\n    \\t<a href=\\"http:\\/\\/www.lyra-network.com\\" target=\\"_blank\\">PayZen<\\/a> is a multi bank payment provider. \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10009, 'SystemPay', 'plugin', 'systempay', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"VM - Payment, Systempay","type":"plugin","creationDate":"July 04 2012","author":"Lyra Network","copyright":"Copyright Lyra Network.","authorEmail":"supportvad@lyra-network.com","authorUrl":"http:\\/\\/www.lyra-network.com","version":"2.0.8c","description":"\\n    \\t<a href=\\"http:\\/\\/www.lyra-network.com\\" target=\\"_blank\\">Systempay<\\/a> is a multi bank payment provider. \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10010, 'Moneybookers Credit Cards', 'plugin', 'moneybookers_acc', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Credit Cards","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10011, 'Moneybookers Lastschrift', 'plugin', 'moneybookers_did', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Lastschrift","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10012, 'Moneybookers iDeal', 'plugin', 'moneybookers_idl', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers iDeal","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10013, 'Moneybookers Giropay', 'plugin', 'moneybookers_gir', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Giropay","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10014, 'Moneybookers Sofortueberweisung', 'plugin', 'moneybookers_sft', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Sofortueberweisung","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10015, 'Moneybookers Przelewy24', 'plugin', 'moneybookers_pwy', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Przelewy24","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10016, 'Moneybookers Online Bank Transfer', 'plugin', 'moneybookers_obt', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Bank Transfer","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10017, 'Moneybookers Skrill Digital Wallet', 'plugin', 'moneybookers_wlt', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"Vm Payment plugin Moneybookers Digital Wallet","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10018, 'Authorize.net', 'plugin', 'authorizenet', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"VM Payment - authorize.net AIM","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2011 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10019, 'Klarna', 'plugin', 'klarna', 'vmpayment', 0, 1, 1, 0, '{"legacy":true,"name":"VM - Payment, Klarna","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"VMPAYMENT_KLARNA_CONF_PLUGIN_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10020, 'Heidelpay', 'plugin', 'heidelpay', 'vmpayment', 0, 1, 1, 0, '{"legacy":false,"name":"VMPAYMENT_HEIDELPAY","type":"plugin","creationDate":"12-Sep-2012","author":"Heidelberger Payment GmbH","copyright":"Copyright Heidelberger Payment GmbH","authorEmail":"info@heidelpay.de","authorUrl":"http:\\/\\/www.heidelpay.de","version":"12.09","description":"<h2>Virtuemart Plugin von:<\\/h2><p><a href=\\"http:\\/\\/www.Heidelpay.de\\" target=\\"_blank\\"><img src=\\"http:\\/\\/www.heidelpay.de\\/gfx\\/logo.gif\\" style=\\"margin-right:20px;\\"\\/><\\/a><\\/p> ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10021, 'By weight, ZIP and countries', 'plugin', 'weight_countries', 'vmshipment', 0, 1, 1, 0, '{"legacy":true,"name":"VMSHIPMENT_WEIGHT_COUNTRIES","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"VMSHIPMENT_WEIGHT_COUNTRIES_PLUGIN_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10022, 'Customer text input', 'plugin', 'textinput', 'vmcustom', 0, 1, 1, 0, '{"legacy":true,"name":"VMCustom - textinput","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"text input plugin for product","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10023, 'Product specification', 'plugin', 'specification', 'vmcustom', 0, 1, 1, 0, '{"legacy":true,"name":"VMCustom - specification","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"text input plugin for product","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10024, 'Stockable variants', 'plugin', 'stockable', 'vmcustom', 0, 1, 1, 0, '{"legacy":true,"name":"VMCUSTOM_STOCKABLE","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"VMCUSTOM_STOCKABLE_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10025, 'Avalara Tax', 'plugin', 'avalara', 'vmcalculation', 0, 0, 1, 0, '{"legacy":true,"name":"VM - Calculation Avalara Tax","type":"plugin","creationDate":"April 2012","author":"Max Milbers","copyright":"Copyright (C) 2012 iStraxx UG. All rights reserved","authorEmail":"","authorUrl":"http:\\/\\/virtuemart.net","version":"2.0.10","description":"On demand tax calculation for whole U.S.A.","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10026, 'Virtuemart Product', 'plugin', 'virtuemart', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_virtuemart","type":"plugin","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"Allows Searching of VirtueMart Component","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10027, 'mod_virtuemart_currencies', 'module', 'mod_virtuemart_currencies', '', 0, 1, 1, 0, '{"legacy":true,"name":"mod_virtuemart_currencies","type":"module","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"MOD_VIRTUEMART_CURRENCIES_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(10028, 'mod_virtuemart_product', 'module', 'mod_virtuemart_product', '', 0, 1, 1, 0, '{"legacy":true,"name":"mod_virtuemart_product","type":"module","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"MOD_VIRTUEMART_PRODUCT_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(10029, 'mod_virtuemart_search', 'module', 'mod_virtuemart_search', '', 0, 1, 1, 0, '{"legacy":true,"name":"mod_virtuemart_search","type":"module","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"MOD_VIRTUEMART_SEARCH_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(10030, 'mod_virtuemart_manufacturer', 'module', 'mod_virtuemart_manufacturer', '', 0, 1, 1, 0, '{"legacy":true,"name":"mod_virtuemart_manufacturer","type":"module","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"MOD_VIRTUEMART_MANUFACTURER_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(10031, 'mod_virtuemart_cart', 'module', 'mod_virtuemart_cart', '', 0, 1, 1, 0, '{"legacy":true,"name":"VirtueMart Shopping Cart","type":"module","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"MOD_VIRTUEMART_CART_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10032, 'mod_virtuemart_category', 'module', 'mod_virtuemart_category', '', 0, 1, 1, 0, '{"legacy":true,"name":"mod_virtuemart_category","type":"module","creationDate":"January 09 2013","author":"The VirtueMart Development Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.18a","description":"MOD_VIRTUEMART_CATEGORY_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(10033, 'com_virtuemart_ru-RU', 'file', 'com_virtuemart_ru-RU', '', 0, 1, 0, 0, '{"legacy":false,"name":"com_virtuemart_ru-RU","type":"file","creationDate":"December 21 2012","author":"The VirtueMart Development and Translation Team","copyright":"Copyright (C) 2004-2012 Virtuemart Team. All rights reserved.","authorEmail":"max|at|virtuemart.net","authorUrl":"http:\\/\\/www.virtuemart.net","version":"2.0.16","description":"This ru-RU language pack for VirtueMart has been installed successfully. It includes files for the component.ini, modules, and plugins. Some languages may not have all the files.\\n    ","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10036, 'Auction', 'template', 'auction', '', 0, 1, 1, 0, '{"legacy":true,"name":"Auction","type":"template","creationDate":"16 May 2010","author":"Igor","copyright":"","authorEmail":"","authorUrl":"lemon007@yandex.ru","version":"1.5","description":"Auction","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10038, 'VMPAYMENT_MONEYBOOKERS', 'plugin', 'moneybookers', 'vmpayment', 0, 0, 1, 0, '{"legacy":true,"name":"VMPAYMENT_MONEYBOOKERS","type":"plugin","creationDate":"April 2012","author":"Skrill Holdings Limited","copyright":"Copyright (C) 2012 Skrill.","authorEmail":"","authorUrl":"http:\\/\\/www.skrill.com","version":"2.0.6","description":"<a href=\\"http:\\/\\/www.skrill.com\\" target=\\"_blank\\">Moneybookers<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    ","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10039, 'acymailing', 'component', 'com_acymailing', '', 1, 1, 0, 0, '{"legacy":true,"name":"AcyMailing","type":"component","creationDate":"f\\u00e9vrier 2013","author":"Acyba","copyright":"Copyright (C) 2009-2013 ACYBA SARL - All rights reserved.","authorEmail":"dev@acyba.com","authorUrl":"http:\\/\\/www.acyba.com","version":"4.1.0","description":"Manage your Mailing lists, Newsletters, e-mail marketing campaigns","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10040, 'AcyMailing : trigger Joomla Content plugins', 'plugin', 'contentplugin', 'acymailing', 0, 0, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 15, 0),
(10041, 'AcyMailing Manage text', 'plugin', 'managetext', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 10, 0),
(10042, 'AcyMailing Tag : Website links', 'plugin', 'online', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(10043, 'AcyMailing : share on social networks', 'plugin', 'share', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 20, 0),
(10044, 'AcyMailing : Statistics Plugin', 'plugin', 'stats', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 50, 0),
(10045, 'AcyMailing table of contents generator', 'plugin', 'tablecontents', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(10046, 'AcyMailing Tag : CB User information', 'plugin', 'tagcbuser', 'acymailing', 0, 0, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(10047, 'AcyMailing Tag : content insertion', 'plugin', 'tagcontent', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 11, 0),
(10048, 'AcyMailing Tag : Subscriber information', 'plugin', 'tagsubscriber', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(10049, 'AcyMailing Tag : Manage the Subscription', 'plugin', 'tagsubscription', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(10050, 'AcyMailing Tag : Date / Time', 'plugin', 'tagtime', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(10051, 'AcyMailing Tag : Joomla User Information', 'plugin', 'taguser', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(10052, 'AcyMailing Template Class Replacer', 'plugin', 'template', 'acymailing', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 25, 0),
(10053, 'AcyMailing : (auto)Subscribe during Joomla registration', 'plugin', 'regacymailing', 'system', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10054, 'AcyMailing Module', 'module', 'mod_acymailing', '', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10055, 'Editor - JCE', 'plugin', 'jce', 'editors', 0, 1, 1, 0, '{"legacy":false,"name":"Editor - JCE","type":"plugin","creationDate":"10 December 2012","author":"Ryan Demmer","copyright":"2006-2010 Ryan Demmer","authorEmail":"info@joomlacontenteditor.net","authorUrl":"http:\\/\\/www.joomlacontenteditor.net","version":"2.3.1","description":"WF_EDITOR_PLUGIN_DESC","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10056, 'plg_quickicon_jcefilebrowser', 'plugin', 'jcefilebrowser', 'quickicon', 0, 1, 1, 0, '{"legacy":false,"name":"plg_quickicon_jcefilebrowser","type":"plugin","creationDate":"April 2012","author":"Ryan Demmer","copyright":"Copyright (C) 2012 Ryan Demmer. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_QUICKICON_JCEFILEBROWSER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10057, 'jce', 'component', 'com_jce', '', 1, 1, 0, 0, '{"legacy":false,"name":"JCE","type":"component","creationDate":"10 December 2012","author":"Ryan Demmer","copyright":"Copyright (C) 2006 - 2012 Ryan Demmer. All rights reserved","authorEmail":"info@joomlacontenteditor.net","authorUrl":"www.joomlacontenteditor.net","version":"2.3.1","description":"WF_ADMIN_DESC","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10058, 'Категории лотов', 'module', 'mod_vlotscats', '', 0, 1, 0, 0, '{"legacy":false,"name":"\\u041a\\u0430\\u0442\\u0435\\u0433\\u043e\\u0440\\u0438\\u0438 \\u043b\\u043e\\u0442\\u043e\\u0432","type":"module","creationDate":"05.02.2012","author":"srgg6701","copyright":"Copyright (C) srgg6701","authorEmail":"srgg67@gmail.com","authorUrl":"http:\\/\\/www.facebook.com\\/srgg67","version":"2.5.0","description":"MOD_vlotscats_XML_DESCRIPTION","group":""}', '{"cache":"1","cache_time":"900","cachemode":"static"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10059, 'auction2013', 'component', 'com_auction2013', '', 1, 1, 0, 0, '{"legacy":false,"name":"AUCTION2013","type":"component","creationDate":"\\u0424\\u0435\\u0432\\u0440\\u0430\\u043b\\u044c 2013","author":"srgg01","copyright":"","authorEmail":"","authorUrl":"","version":"0.0.1","description":"","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10060, 'dwsync', 'plugin', 'dwsync', 'acymailing', 0, 1, 1, 0, 'false', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(10061, 'dwsync', 'plugin', 'dwsync', 'vmpayment', 0, 1, 1, 0, 'false', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(10062, 'dwsync', 'plugin', 'dwsync', 'vmshipment', 0, 1, 1, 0, 'false', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(10064, 'PLG_SYSTEM_MODULESANYWHERE', 'plugin', 'modulesanywhere', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"PLG_SYSTEM_MODULESANYWHERE","type":"plugin","creationDate":"February 2013","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2012 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"http:\\/\\/www.nonumber.nl","version":"3.2.2FREE","description":"PLG_SYSTEM_MODULESANYWHERE_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10065, 'PLG_EDITORS-XTD_MODULESANYWHERE', 'plugin', 'modulesanywhere', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"PLG_EDITORS-XTD_MODULESANYWHERE","type":"plugin","creationDate":"February 2013","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2012 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"http:\\/\\/www.nonumber.nl","version":"3.2.2FREE","description":"PLG_EDITORS-XTD_MODULESANYWHERE_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10066, 'PLG_SYSTEM_NNFRAMEWORK', 'plugin', 'nnframework', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"PLG_SYSTEM_NNFRAMEWORK","type":"plugin","creationDate":"February 2013","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2012 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"http:\\/\\/www.nonumber.nl","version":"13.2.2","description":"PLG_SYSTEM_NNFRAMEWORK_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10067, 'Конструктор Яндекс карты FlyLeaf', 'module', 'mod_flyleaf_ymap', '', 0, 1, 0, 0, '{"legacy":false,"name":"\\u041a\\u043e\\u043d\\u0441\\u0442\\u0440\\u0443\\u043a\\u0442\\u043e\\u0440 \\u042f\\u043d\\u0434\\u0435\\u043a\\u0441 \\u043a\\u0430\\u0440\\u0442\\u044b FlyLeaf","type":"module","creationDate":"June 2012","author":"Evgeny Zakirov","copyright":"(c) flyleaf.su","authorEmail":"worstinme@ya.ru","authorUrl":"http:\\/\\/flyleaf.su","version":"2.0.14","description":"<div style=''background:#fff;padding:10px;border: solid 1px #CCC;margin-left:68px;''>\\u041f\\u0435\\u0440\\u0435\\u0442\\u0430\\u0449\\u0438\\u0442\\u0435 \\u043c\\u0435\\u0442\\u043a\\u0443 \\u0432 \\u043d\\u0443\\u0436\\u043d\\u043e\\u0435 \\u043c\\u0435\\u0441\\u0442\\u043e, \\u0437\\u0430\\u0434\\u0430\\u0439\\u0442\\u0435 \\u043a\\u043e\\u043e\\u0440\\u0434\\u0438\\u043d\\u0430\\u0442\\u044b \\u0438 \\u043c\\u0430\\u0441\\u0448\\u0442\\u0430\\u0431 \\u043a\\u0430\\u0440\\u0442\\u044b, \\u043d\\u0430\\u0436\\u043c\\u0438\\u0442\\u0435 \\u043f\\u0440\\u0430\\u0432\\u043e\\u0439 \\u043a\\u043d\\u043e\\u043f\\u043a\\u043e\\u0439 \\u043d\\u0430 \\u043c\\u0435\\u0442\\u043a\\u0435 \\u0434\\u043b\\u044f \\u0435\\u0435 \\u0440\\u0435\\u0434\\u0430\\u043a\\u0442\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u0438\\u044f. \\u0412\\u043e\\u0437\\u043c\\u043e\\u0436\\u043d\\u043e \\u0438\\u0441\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435 html \\u0442\\u0435\\u0433\\u043e\\u0432. \\u041c\\u043e\\u0436\\u0435\\u0442\\u0435 \\u043e\\u0441\\u0442\\u0430\\u0432\\u043b\\u044f\\u0442\\u044c \\u043f\\u043e\\u043b\\u044f \\u043f\\u0443\\u0441\\u0442\\u044b\\u043c\\u0438 \\u0435\\u0441\\u043b\\u0438 \\u043e\\u043d\\u0438 \\u043d\\u0435 \\u043d\\u0443\\u0436\\u043d\\u044b. \\u041d\\u0435 \\u0437\\u0430\\u0431\\u0443\\u0434\\u044c\\u0442\\u0435 \\u0443\\u043a\\u0430\\u0437\\u0430\\u0442\\u044c \\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u044f \\u0448\\u0438\\u0440\\u0438\\u043d\\u044b \\u0438 \\u0432\\u044b\\u0441\\u043e\\u0442\\u044b \\u043a\\u0430\\u0440\\u0442\\u044b.<br>\\u0418\\u0441\\u043f\\u043e\\u043b\\u044c\\u0437\\u0443\\u0435\\u0442\\u0441\\u044f API 2.0, \\u043c\\u043e\\u0436\\u0435\\u0442\\u0435 \\u0432\\u0441\\u0442\\u0430\\u0432\\u0438\\u0442\\u044c \\u0432 \\u0444\\u0443\\u043d\\u043a\\u0446\\u0438\\u044e \\u0432\\u044b\\u0437\\u043e\\u0432\\u0430 \\u043a\\u0430\\u0440\\u0442\\u044b \\u0441\\u0432\\u043e\\u0438 \\u0441\\u043a\\u0440\\u0438\\u043f\\u0442\\u044b.<\\/div>\\n<p style=''margin-left:68px;margin-top:10px''>\\u041f\\u043e\\u0434\\u0440\\u043e\\u0431\\u043d\\u0430\\u044f \\u0438\\u043d\\u0444\\u043e\\u0440\\u043c\\u0430\\u0446\\u0438\\u044f \\u043d\\u0430 \\u0441\\u0442\\u0440\\u0430\\u043d\\u0438\\u0446\\u0435 \\u0440\\u0430\\u0437\\u0440\\u0430\\u0431\\u043e\\u0442\\u0447\\u0438\\u043a\\u0430 <a href=\\"http:\\/\\/flyleaf.su\\/blog\\/joomla\\/modul-yandeks-kart-s-rasshirennymi-nastroykami-dlya-joomla-2.5.html\\" target=\\"_blank\\">\\u00ab\\u0444\\u043e\\u0440\\u0437\\u0430\\u0301\\u0446\\u00bb<\\/a>. WMR R138753723227, \\u042f\\u0414 410011409102401<\\/p>\\n\\t\\t  \\n\\t\\t  \\n<script src=\\"http:\\/\\/api-maps.yandex.ru\\/2.0\\/?coordorder=longlat&load=package.full&mode=debug&wizard=mod_flyleaf_ymap&lang=ru-RU&onload=init\\" type=\\"text\\/javascript\\"><\\/script>\\n<script src=\\"http:\\/\\/yandex.st\\/jquery\\/1.7.2\\/jquery.min.js\\" type=\\"text\\/javascript\\"><\\/script>\\n\\n<script type=\\"text\\/javascript\\">\\n\\n\\t\\t\\n\\t\\t\\nfunction init () {\\n\\t$(\\"<div id=''search_map''><form method=''post''><input style=''width:80%;font-size:14px;'' type=''text'' name=''search_map'' placeholder=''\\u043f\\u043e\\u0438\\u0441\\u043a \\u043f\\u043e \\u0430\\u0434\\u0440\\u0435\\u0441\\u0443''\\/><input type=''submit'' style=''width:12%;float:right;font-size:14px;'' value=''\\u041d\\u0430\\u0439\\u0442\\u0438''><\\/form><div id=''result_map'' style=''width:100%;margin-bottom:10px;font-size:14px;''><\\/div><\\/div><div id=''ymaps'' style=''width:100%;height:300px;''><\\/div>\\").prependTo($(\\"#module-sliders\\"));\\n\\t\\n\\t$(\\"#jform_params_selfscript-lbl\\").attr(\\"style\\",\\"max-width:inherit;width:auto;\\");\\n\\tif ($(\\"#jform_params_center\\").val() == '''') {\\n\\t\\tvar ymc = [ymaps.geolocation.longitude,ymaps.geolocation.latitude];\\n\\t\\tif (ymc[0] == '''' && ymc[1] == '''')\\n\\t\\tymc = [54.23021568749796,56.071896198720616];\\n\\t\\t$(\\"#jform_params_center\\").val(ymc[0]+'',''+ymc[1]) \\n\\t}\\n\\telse \\n\\tvar ymc = $(\\"#jform_params_center\\").val().split('','');\\n\\tif ($(\\"#jform_params_location\\").val() == '''') {\\n\\t\\tvar mpc = ymc;\\n\\t\\t$(\\"#jform_params_location\\").val(mpc[0]+'',''+mpc[1]) \\n\\t}\\n\\telse \\n\\tvar mpc = $(\\"#jform_params_location\\").val().split('','');\\n\\tvar myMap = new ymaps.Map(\\"ymaps\\", {center:ymc,zoom: $(\\"#jform_params_zoom\\").val(),type: $(\\"#jform_params_map_type\\").val()});\\n\\t\\n\\tmyMap.controls.add(''zoomControl'').add(new ymaps.control.TypeSelector([''yandex#map'', ''yandex#satellite'', ''yandex#hybrid'', ''yandex#publicMap'',''yandex#publicMapHybrid'']));\\n\\t\\n\\tmyPlacemark = new ymaps.Placemark(mpc, \\n\\t\\t{ iconContent: $(\\"#jform_params_icon\\").val(),hintContent: $(\\"#jform_params_hint\\").val(),balloonContent: $(\\"#jform_params_balloon\\").val() }, \\n\\t\\t {\\tpreset: $(\\"#jform_params_iconstyle\\").val(),\\n\\t\\t\\t\\tdraggable: true,\\n\\t\\t\\t}\\n\\t\\t\\t);\\n\\tmyPlacemark.events.add(''contextmenu'', function (e) {\\n                e.get(''domEvent'').callMethod(''preventDefault'');\\n                if ($(''#menu-mark'').css(''display'') == ''block'') {\\n                    $(''#menu-mark'').remove();\\n                } else {\\n                    \\/\\/ HTML-\\u0441\\u043e\\u0434\\u0435\\u0440\\u0436\\u0438\\u043c\\u043e\\u0435 \\u043a\\u043e\\u043d\\u0442\\u0435\\u043a\\u0441\\u0442\\u043d\\u043e\\u0433\\u043e \\u043c\\u0435\\u043d\\u044e.\\n                    var menuContent =\\n                        ''<div id=\\"menu-mark\\">\\\\\\n                             <ul id=\\"menu_list\\">\\\\\\n                                 <li>\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435: <br \\/> <input type=\\"text\\" style=\\"width:200px;\\" name=\\"icon_text\\" \\/><\\/li>\\\\\\n                                 <li>\\u041f\\u043e\\u0434\\u0441\\u043a\\u0430\\u0437\\u043a\\u0430: <br \\/> <input type=\\"text\\" style=\\"width:200px;\\"  name=\\"hint_text\\" \\/><\\/li>\\\\\\n                                 <li>\\u0411\\u0430\\u043b\\u0443\\u043d: <br \\/> <textarea style=\\"width:200px;height:30px;\\"  name=\\"balloon_text\\"><\\/textarea><\\/li>\\\\\\n\\t\\t\\t\\t\\t\\t\\t\\t <li>\\u0421\\u0442\\u0438\\u043b\\u044c: <select name=\\"icon_style\\">\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#lightblueStretchyIcon\\">lightblue<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#whiteStretchyIcon\\">white<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#greenStretchyIcon\\">green<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#redStretchyIcon\\">red<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#yellowStretchyIcon\\">yellow<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#nightStretchyIcon\\">night<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#greyStretchyIcon\\">grey<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#darkblueStretchyIcon\\">darkblue<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#blueStretchyIcon\\" selected=\\"selected\\">blue<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#orangeStretchyIcon\\">orange<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#darkorangeStretchyIcon\\">darkorange<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#pinkStretchyIcon\\">pink<\\/option>\\\\\\n\\t\\t\\t\\t\\t<option value=\\"twirl#violetStretchyIcon\\">violet<\\/option>\\\\\\n\\t\\t\\t\\t\\t\\t\\t\\t \\t\\t\\t\\t\\t<\\/select><\\/li>\\\\\\n                             <\\/ul>\\\\\\n                         <div align=\\"center\\"><input type=\\"submit\\" value=\\"\\u0421\\u043e\\u0445\\u0440\\u0430\\u043d\\u0438\\u0442\\u044c\\" \\/><\\/div>\\\\\\n                         <\\/div>'';\\n\\t\\t\\t\\t\\t\\t \\n                    $(''body'').append(menuContent);\\n\\n                    $(''#menu-mark'').css({\\n                        position: ''absolute'',\\n                        left: e.get(''position'')[0],\\n                        top: e.get(''position'')[1],\\n                        background: ''#FFFFCC'',\\n                        border: ''3px solid #1E9CFE'',\\n                        ''border-radius'': ''12px'',\\n                        width: ''240px'',\\n                        ''padding-bottom'': ''10px'',\\n                        ''z-index'': 2\\n                    });\\n\\n                    $(''#menu-mark ul'').css({\\n                        ''list-style-type'': ''none'',\\n                        padding: ''20px'',\\n                        margin: 0\\n                    });\\n\\n                    $(''#menu-mark input[name=\\"icon_text\\"]'').val($(\\"#jform_params_icon\\").val());\\n                    $(''#menu-mark input[name=\\"hint_text\\"]'').val($(\\"#jform_params_hint\\").val());\\n                    $(''#menu-mark textarea[name=\\"balloon_text\\"]'').val($(\\"#jform_params_balloon\\").val());\\n\\t\\t\\t\\t\\t$(''#menu-mark select[name=\\"icon_style\\"]'').val($(\\"#jform_params_iconstyle\\").val());\\n\\n                    $(''#menu-mark input[type=\\"submit\\"]'').click(function () {\\n                        var iconText = $(''input[name=\\"icon_text\\"]'').val(),\\n                            hintText = $(''input[name=\\"hint_text\\"]'').val(),\\n                            balloonText = $(''textarea[name=\\"balloon_text\\"]'').val();\\n\\t\\t\\t\\t\\t\\n\\t\\t\\t\\t\\t\\n                        myPlacemark.properties.set({\\n                            iconContent: iconText,\\n                            hintContent: hintText,\\n                            balloonContent: balloonText\\n                        });\\n\\t\\t\\t\\t\\t\\t$(\\"#jform_params_icon\\").val(iconText),\\n\\t\\t\\t\\t\\t\\t$(\\"#jform_params_hint\\").val(hintText),\\n\\t\\t\\t\\t\\t\\t$(\\"#jform_params_balloon\\").val(balloonText)\\n                        \\/\\/ \\u0423\\u0434\\u0430\\u043b\\u044f\\u0435\\u043c \\u043a\\u043e\\u043d\\u0442\\u0435\\u043a\\u0441\\u0442\\u043d\\u043e\\u0435 \\u043c\\u0435\\u043d\\u044e.\\n                        $(''#menu-mark'').remove();\\n                    });\\n\\t\\t\\t\\t\\t\\n\\t\\t\\t\\t\\t$(''#menu-mark select[name=\\"icon_style\\"]'').click(function(){\\n\\t\\t\\t\\t\\t\\tvar iconStyle = $(''#menu-mark select[name=\\"icon_style\\"]'').val();\\n\\t\\t\\t\\t\\t\\tmyPlacemark.options.set({preset:iconStyle});\\n\\t\\t\\t\\t\\t\\t$(\\"#jform_params_iconstyle\\").val(iconStyle)\\n\\t\\t\\t\\t\\t});\\t\\n                }\\n            });\\n\\t\\t\\tmyPlacemark.events.add(\\"dragend\\", function (e) {\\n              coords = this.geometry.getCoordinates(),\\n\\t\\t\\t\\t$(\\"#jform_params_location\\").val(coords)\\n\\t\\t\\t},myPlacemark);\\n\\t\\t\\t\\t\\t\\t\\n\\t\\t\\tmyMap.events.add([''boundschange'', ''typechange''], function() {\\n\\t\\t\\t\\t$(\\"#jform_params_center\\").val(myMap.getCenter()),\\n\\t\\t\\t\\t$(\\"#jform_params_zoom\\").val(myMap.getZoom()),\\n\\t\\t\\t\\t$(\\"#jform_params_map_type\\").val(myMap.getType())\\n\\t\\t\\t});\\n\\t\\t\\t\\n\\t\\t\\t$(\\"#jform_params_map_type\\").click(function(){\\n\\t\\t\\t\\tmyMap.setType($(this).val())\\n\\t\\t\\t});\\n\\t\\t\\t$(\\"#jform_params_iconstyle\\").click(function(){\\n\\t\\t\\t\\tvar icStyle = $(this).val();\\n\\t\\t\\t\\tmyPlacemark.options.set({preset:icStyle});\\n\\t\\t\\t});\\n\\t\\t\\t$(\\"#jform_params_icon\\").keyup(function(){\\n\\t\\t\\t\\tvar iconC = $(this).val();\\n\\t\\t\\t\\tmyPlacemark.properties.set({iconContent:iconC});\\n\\t\\t\\t});\\n\\t\\t\\t$(\\"#jform_params_hint\\").keyup(function(){\\n\\t\\t\\t\\tvar hintC = $(this).val();\\n\\t\\t\\t\\tmyPlacemark.properties.set({hintContent:hintC});\\n\\t\\t\\t});\\n\\t\\t\\t$(\\"#jform_params_balloon\\").keyup(function(){\\n\\t\\t\\t\\tvar balloonC = $(this).val();\\n\\t\\t\\t\\tmyPlacemark.properties.set({balloonContent:balloonC});\\n\\t\\t\\t});\\n\\t\\t\\t$(\\"#jform_params_zoom\\").keyup(function(){\\n\\t\\t\\t\\tmyMap.setZoom($(this).val())\\n\\t\\t\\t});\\n\\t\\t\\tmyMap.geoObjects.add(myPlacemark);\\n\\t\\n\\t$(''#search_map form'').submit(function () {\\n        var search_query = $(''#search_map input'').val();\\n\\t\\tymaps.geocode(search_query, {results: 10}).then(function (res) {\\n\\t\\t\\tvar names = []; var coords = [];\\n\\t\\t\\t$(\\"#result_map\\").html(\\"\\");\\n            res.geoObjects.each(function (obj) {\\t\\t\\t\\n\\t\\t\\t$(\\"<a href=''#'' rel=''\\"+obj.geometry.getCoordinates()+\\"''>\\"+obj.properties.get(''name'')+\\"<\\/a><br>\\").prependTo($(\\"#result_map\\"));\\n            });\\t\\t\\t\\n        }); \\n        return false;\\n     });\\n\\t \\n\\t $(\\"#result_map a\\").live(\\"click\\",function(){\\n\\t \\tvar rmc = $(this).attr(\\"rel\\").split('','');\\n\\t \\tmyMap.setCenter([rmc[0],rmc[1]]);\\n\\t\\t$(\\"#result_map a\\").attr(\\"style\\",\\"\\");\\n\\t\\t$(this).attr(\\"style\\",\\"background:#ddd;color:#d50\\");\\n\\t\\tmyPlacemark.geometry.setCoordinates([rmc[0],rmc[1]]);\\n\\t\\t$(\\"#jform_params_location\\").val(rmc[0]+\\",\\"+rmc[1])\\n\\t });\\n\\t\\t\\n\\t}\\n<\\/script>","group":""}', '{"location":"","center":"","zoom":"6","map_type":"yandex#map","width":"100%","height":"300px","icon":"\\u042f.\\u041c\\u0435\\u0442\\u043a\\u0430","iconstyle":"twirl#blueIcon","balloon_on":"0","control1":"1","control2":"0","control3":"1","control4":"0","selfscript":"\\/* \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440 \\u043a\\u043e\\u0434\\u0430 \\u0434\\u043e\\u0431\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f \\u0435\\u0449\\u0435 \\u043e\\u0434\\u043d\\u043e\\u0439 \\u043c\\u0435\\u0442\\u043a\\u0438 myMap.geoObjects.add(new ymaps.Placemark([54.274161,56.096468], { iconContent: ''\\u0422\\u0435\\u043a\\u0441\\u0442 \\u043c\\u0435\\u0442\\u043a\\u0438'',hintContent: '''', balloonContent: ''\\u041e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435, \\u0431\\u0430\\u043b\\u0443\\u043d'' },   {   preset: ''twirl#blueStretchyIcon''} )); *\\/","cache":"1","cache_time":"900","bklnk":"PGRpdiBpZD0iYmxuayI+PGEgaHJlZj0iaHR0cDovL2ZseWxlYWYuc3UvYmxvZy8iIHRhcmdldD0iX2JsYW5rIj7QnNC+0LTRg9C70Ywg0K\\/QvdC00LXQutGBINCa0LDRgNGCIEpvb21sYTwvYT48L2Rpdj4=","cachemode":"static"}', '', '', 0, '0000-00-00 00:00:00', 0, 0);

-- 
-- Вывод данных для таблицы auc13_finder_taxonomy
--
INSERT INTO auc13_finder_taxonomy VALUES
(1, 0, 'ROOT', 0, 0, 0);

-- 
-- Вывод данных для таблицы auc13_finder_taxonomy_map
--

-- Таблица auctionru_2013.auc13_finder_taxonomy_map не содержит данных

-- 
-- Вывод данных для таблицы auc13_finder_terms
--

-- Таблица auctionru_2013.auc13_finder_terms не содержит данных

-- 
-- Вывод данных для таблицы auc13_finder_terms_common
--
INSERT INTO auc13_finder_terms_common VALUES
('a', 'en'),
('about', 'en'),
('after', 'en'),
('ago', 'en'),
('all', 'en'),
('am', 'en'),
('an', 'en'),
('and', 'en'),
('ani', 'en'),
('any', 'en'),
('are', 'en'),
('aren''t', 'en'),
('as', 'en'),
('at', 'en'),
('be', 'en'),
('but', 'en'),
('by', 'en'),
('for', 'en'),
('from', 'en'),
('get', 'en'),
('go', 'en'),
('how', 'en'),
('if', 'en'),
('in', 'en'),
('into', 'en'),
('is', 'en'),
('isn''t', 'en'),
('it', 'en'),
('its', 'en'),
('me', 'en'),
('more', 'en'),
('most', 'en'),
('must', 'en'),
('my', 'en'),
('new', 'en'),
('no', 'en'),
('none', 'en'),
('not', 'en'),
('noth', 'en'),
('nothing', 'en'),
('of', 'en'),
('off', 'en'),
('often', 'en'),
('old', 'en'),
('on', 'en'),
('onc', 'en'),
('once', 'en'),
('onli', 'en'),
('only', 'en'),
('or', 'en'),
('other', 'en'),
('our', 'en'),
('ours', 'en'),
('out', 'en'),
('over', 'en'),
('page', 'en'),
('she', 'en'),
('should', 'en'),
('small', 'en'),
('so', 'en'),
('some', 'en'),
('than', 'en'),
('thank', 'en'),
('that', 'en'),
('the', 'en'),
('their', 'en'),
('theirs', 'en'),
('them', 'en'),
('then', 'en'),
('there', 'en'),
('these', 'en'),
('they', 'en'),
('this', 'en'),
('those', 'en'),
('thus', 'en'),
('time', 'en'),
('times', 'en'),
('to', 'en'),
('too', 'en'),
('true', 'en'),
('under', 'en'),
('until', 'en'),
('up', 'en'),
('upon', 'en'),
('use', 'en'),
('user', 'en'),
('users', 'en'),
('veri', 'en'),
('version', 'en'),
('very', 'en'),
('via', 'en'),
('want', 'en'),
('was', 'en'),
('way', 'en'),
('were', 'en'),
('what', 'en'),
('when', 'en'),
('where', 'en'),
('whi', 'en'),
('which', 'en'),
('who', 'en'),
('whom', 'en'),
('whose', 'en'),
('why', 'en'),
('wide', 'en'),
('will', 'en'),
('with', 'en'),
('within', 'en'),
('without', 'en'),
('would', 'en'),
('yes', 'en'),
('yet', 'en'),
('you', 'en'),
('your', 'en'),
('yours', 'en');

-- 
-- Вывод данных для таблицы auc13_finder_tokens
--

-- Таблица auctionru_2013.auc13_finder_tokens не содержит данных

-- 
-- Вывод данных для таблицы auc13_finder_tokens_aggregate
--

-- Таблица auctionru_2013.auc13_finder_tokens_aggregate не содержит данных

-- 
-- Вывод данных для таблицы auc13_finder_types
--

-- Таблица auctionru_2013.auc13_finder_types не содержит данных

-- 
-- Вывод данных для таблицы auc13_languages
--
INSERT INTO auc13_languages VALUES
(1, 'en-GB', 'English (UK)', 'English (UK)', 'en', 'en', '', '', '', '', 1, 0, 1);

-- 
-- Вывод данных для таблицы auc13_menu
--
INSERT INTO auc13_menu VALUES
(1, '', 'Menu_Item_Root', 'root', '', '', '', '', 1, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, '', 0, '', 0, 137, 0, '*', 0),
(2, 'menu', 'com_banners', 'Banners', '', 'Banners', 'index.php?option=com_banners', 'component', 0, 1, 1, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 1, 10, 0, '*', 1),
(3, 'menu', 'com_banners', 'Banners', '', 'Banners/Banners', 'index.php?option=com_banners', 'component', 0, 2, 2, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 2, 3, 0, '*', 1),
(4, 'menu', 'com_banners_categories', 'Categories', '', 'Banners/Categories', 'index.php?option=com_categories&extension=com_banners', 'component', 0, 2, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-cat', 0, '', 4, 5, 0, '*', 1),
(5, 'menu', 'com_banners_clients', 'Clients', '', 'Banners/Clients', 'index.php?option=com_banners&view=clients', 'component', 0, 2, 2, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-clients', 0, '', 6, 7, 0, '*', 1),
(6, 'menu', 'com_banners_tracks', 'Tracks', '', 'Banners/Tracks', 'index.php?option=com_banners&view=tracks', 'component', 0, 2, 2, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-tracks', 0, '', 8, 9, 0, '*', 1),
(7, 'menu', 'com_contact', 'Contacts', '', 'Contacts', 'index.php?option=com_contact', 'component', 0, 1, 1, 8, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 11, 16, 0, '*', 1),
(8, 'menu', 'com_contact', 'Contacts', '', 'Contacts/Contacts', 'index.php?option=com_contact', 'component', 0, 7, 2, 8, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 12, 13, 0, '*', 1),
(9, 'menu', 'com_contact_categories', 'Categories', '', 'Contacts/Categories', 'index.php?option=com_categories&extension=com_contact', 'component', 0, 7, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact-cat', 0, '', 14, 15, 0, '*', 1),
(10, 'menu', 'com_messages', 'Messaging', '', 'Messaging', 'index.php?option=com_messages', 'component', 0, 1, 1, 15, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages', 0, '', 17, 22, 0, '*', 1),
(11, 'menu', 'com_messages_add', 'New Private Message', '', 'Messaging/New Private Message', 'index.php?option=com_messages&task=message.add', 'component', 0, 10, 2, 15, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-add', 0, '', 18, 19, 0, '*', 1),
(12, 'menu', 'com_messages_read', 'Read Private Message', '', 'Messaging/Read Private Message', 'index.php?option=com_messages', 'component', 0, 10, 2, 15, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-read', 0, '', 20, 21, 0, '*', 1),
(13, 'menu', 'com_newsfeeds', 'News Feeds', '', 'News Feeds', 'index.php?option=com_newsfeeds', 'component', 0, 1, 1, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 23, 28, 0, '*', 1),
(14, 'menu', 'com_newsfeeds_feeds', 'Feeds', '', 'News Feeds/Feeds', 'index.php?option=com_newsfeeds', 'component', 0, 13, 2, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 24, 25, 0, '*', 1),
(15, 'menu', 'com_newsfeeds_categories', 'Categories', '', 'News Feeds/Categories', 'index.php?option=com_categories&extension=com_newsfeeds', 'component', 0, 13, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds-cat', 0, '', 26, 27, 0, '*', 1),
(16, 'menu', 'com_redirect', 'Redirect', '', 'Redirect', 'index.php?option=com_redirect', 'component', 0, 1, 1, 24, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:redirect', 0, '', 43, 44, 0, '*', 1),
(17, 'menu', 'com_search', 'Basic Search', '', 'Basic Search', 'index.php?option=com_search', 'component', 0, 1, 1, 19, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:search', 0, '', 33, 34, 0, '*', 1),
(18, 'menu', 'com_weblinks', 'Weblinks', '', 'Weblinks', 'index.php?option=com_weblinks', 'component', 0, 1, 1, 21, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks', 0, '', 35, 40, 0, '*', 1),
(19, 'menu', 'com_weblinks_links', 'Links', '', 'Weblinks/Links', 'index.php?option=com_weblinks', 'component', 0, 18, 2, 21, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks', 0, '', 36, 37, 0, '*', 1),
(20, 'menu', 'com_weblinks_categories', 'Categories', '', 'Weblinks/Categories', 'index.php?option=com_categories&extension=com_weblinks', 'component', 0, 18, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks-cat', 0, '', 38, 39, 0, '*', 1),
(21, 'menu', 'com_finder', 'Smart Search', '', 'Smart Search', 'index.php?option=com_finder', 'component', 0, 1, 1, 27, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:finder', 0, '', 31, 32, 0, '*', 1),
(22, 'menu', 'com_joomlaupdate', 'Joomla! Update', '', 'Joomla! Update', 'index.php?option=com_joomlaupdate', 'component', 0, 1, 1, 28, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:joomlaupdate', 0, '', 41, 42, 0, '*', 1),
(101, 'mainmenu', 'Главная', 'home', '', 'home', 'index.php?option=com_content&view=article&id=1', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":0,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 29, 30, 1, '*', 0),
(113, 'mainmenu', 'Аукцион', 'аукцион', '', 'аукцион', 'index.php?option=com_content&view=article&id=2', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 49, 60, 0, '*', 0),
(102, 'main', 'COM_VIRTUEMART', 'com-virtuemart', '', 'com-virtuemart', 'index.php?option=com_virtuemart', 'component', 0, 1, 1, 10004, 0, 0, '0000-00-00 00:00:00', 0, 1, '../components/com_virtuemart/assets/images/vmgeneral/menu_icon.png', 0, '', 45, 46, 0, '', 1),
(103, 'main', 'VirtueMart AIO', 'virtuemart-aio', '', 'virtuemart-aio', 'index.php?option=com_virtuemart_allinone', 'component', 0, 1, 1, 10005, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:component', 0, '', 47, 48, 0, '', 1),
(169, 'pseudomenu', 'Поставить заочный бид', 'postavit-zaochnyj-bid', '', 'postavit-zaochnyj-bid', 'index.php?option=com_content&view=article&id=23', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 135, 136, 0, '*', 0),
(114, 'mainmenu', 'О нас', 'o-nas', '', 'o-nas', 'index.php?option=com_content&view=article&id=3', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 61, 66, 0, '*', 0),
(117, 'mainmenu', 'Партнеры', 'nashi-partners', '', 'nashi-partners', 'index.php?option=com_content&view=article&id=7', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 79, 80, 0, '*', 0),
(115, 'mainmenu', 'Магазин', 'магазин-антиквариата', 'необходимо вмешательство для адаптации URL с уже проиндексированными', 'магазин-антиквариата', 'index.php?option=com_virtuemart&view=category&layout=shop&virtuemart_category_id=0', 'component', 1, 1, 1, 10004, 0, 107, '2013-02-26 20:21:49', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"-shop","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 67, 68, 0, '*', 0),
(116, 'mainmenu', 'Правила', 'pravila', '', 'pravila', 'index.php?option=com_content&view=category&id=8', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_category_title":"","show_description":"","show_description_image":"","maxLevel":"","show_empty_categories":"","show_no_articles":"","show_subcat_desc":"","show_cat_num_articles":"","page_subheading":"","show_pagination_limit":"0","filter_field":"hide","show_headings":"0","list_show_date":"0","date_format":"","list_show_hits":"0","list_show_author":"0","orderby_pri":"order","orderby_sec":"date","order_date":"","show_pagination":"","show_pagination_results":"","display_num":"10","show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_readmore":"","show_readmore_title":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","show_feed_link":"","feed_summary":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 69, 78, 0, '*', 0),
(118, 'mainmenu', 'Контакты', 'obratnaya-svjaz', '', 'obratnaya-svjaz', 'index.php?option=com_content&view=article&id=8', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 81, 82, 0, '*', 0),
(119, 'bottom-menu', 'Контакты', 'kontakty', '', 'kontakty', 'index.php?option=com_content&view=article&id=8', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 83, 84, 0, '*', 0),
(120, 'bottom-menu', 'Вопросы', 'voprosy', '', 'voprosy', 'index.php?option=com_content&view=article&id=9', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 85, 86, 0, '*', 0),
(121, 'bottom-menu', 'Доставка и оплата', 'dostavka-i-oplata', '', 'dostavka-i-oplata', 'index.php?option=com_content&view=article&id=10', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 87, 88, 0, '*', 0),
(122, 'bottom-menu', 'Черный список', 'chernyj-spisok', '', 'chernyj-spisok', 'index.php?option=com_content&view=article&id=11', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 89, 90, 0, '*', 0),
(123, 'bottom-menu', 'Проданные лоты', 'prodannyje-loty', '', 'prodannyje-loty', 'index.php?option=com_virtuemart&view=category&virtuemart_category_id=0', 'component', 1, 1, 1, 10004, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 91, 92, 0, '*', 0),
(124, 'mainmenu', 'Расписание', 'raspisanije-aukzionov', '', 'аукцион/raspisanije-aukzionov', 'index.php?option=com_content&view=article&id=12', 'component', 1, 113, 2, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 50, 51, 0, '*', 0),
(125, 'mainmenu', 'Онлайн торги', 'online-torgi', 'не факт, что virtuemart однако', 'аукцион/online-torgi', 'index.php?option=com_virtuemart&view=category&virtuemart_category_id=21', 'component', 1, 113, 2, 10004, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 52, 53, 0, '*', 0),
(126, 'mainmenu', 'Очные торги', 'очные-торги', '', 'аукцион/очные-торги', 'index.php?option=com_virtuemart&view=category&layout=fulltime&virtuemart_category_id=0', 'component', 1, 113, 2, 10004, 0, 107, '2013-02-20 22:59:07', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 56, 57, 0, '*', 0),
(127, 'mainmenu', 'Предложить предмет', 'predlozhit-predmet', '', 'аукцион/predlozhit-predmet', 'index.php?option=com_auction2013&view=auction2013&layout=proposal', 'component', 1, 113, 2, 10059, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"-proposal","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 54, 55, 0, '*', 0),
(153, 'usermenu', 'Мои ставки', 'bids', '', 'bids', 'index.php?option=com_users&view=profile&layout=bids', 'component', 1, 1, 1, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 129, 130, 0, '*', 0),
(128, 'mainmenu', 'Результаты торгов', 'rezultaty-torgov', '', 'аукцион/rezultaty-torgov', 'index.php?option=com_auction2013&view=auction2013&layout=results', 'component', 1, 113, 2, 10059, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"-results","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 58, 59, 0, '*', 0),
(152, 'usermenu', 'Избранное', 'favorites', '', 'favorites', 'index.php?option=com_users&view=profile&layout=favorites', 'component', 1, 1, 1, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"first-point","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 127, 128, 0, '*', 0),
(129, 'mainmenu', 'Антикварная галерея', 'antikvarnaja-galereja', '', 'o-nas/antikvarnaja-galereja', 'index.php?option=com_content&view=article&id=15', 'component', 1, 114, 2, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 62, 63, 0, '*', 0),
(130, 'mainmenu', 'Антикварный салон', 'antikvarnyji-salon', '', 'o-nas/antikvarnyji-salon', 'index.php?option=com_content&view=article&id=16', 'component', 1, 114, 2, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 64, 65, 0, '*', 0),
(131, 'mainmenu', 'Правила регистрации участников торгов', 'pravila-registraciji-uchastnikov-torgov', '', 'pravila/pravila-registraciji-uchastnikov-torgov', 'index.php?option=com_content&view=article&id=4', 'component', 1, 116, 2, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"-rules","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 70, 73, 0, '*', 0),
(132, 'mainmenu', 'Правила онлайн-аукционов', 'pravila-provedenija-online-torgov', '', 'pravila/pravila-provedenija-online-torgov', 'index.php?option=com_content&view=article&id=5', 'component', 0, 116, 2, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 74, 75, 0, '*', 0),
(133, 'mainmenu', 'Правила очных аукционов', 'pravila-provedenija-ochnyh-torgov', '', 'pravila/pravila-provedenija-ochnyh-torgov', 'index.php?option=com_content&view=article&id=6', 'component', 1, 116, 2, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 76, 77, 0, '*', 0),
(134, 'main', 'AcyMailing', 'acymailing', '', 'acymailing', 'index.php?option=com_acymailing', 'component', 0, 1, 1, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-acymailing.png', 0, '', 93, 110, 0, '', 1),
(135, 'main', 'Users', 'users', '', 'acymailing/users', 'index.php?option=com_acymailing&ctrl=subscriber', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-users.png', 0, '', 94, 95, 0, '', 1),
(136, 'main', 'Lists', 'lists', '', 'acymailing/lists', 'index.php?option=com_acymailing&ctrl=list', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-acylist.png', 0, '', 96, 97, 0, '', 1),
(137, 'main', 'Newsletters', 'newsletters', '', 'acymailing/newsletters', 'index.php?option=com_acymailing&ctrl=newsletter', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-newsletter.png', 0, '', 98, 99, 0, '', 1),
(138, 'main', 'Templates', 'templates', '', 'acymailing/templates', 'index.php?option=com_acymailing&ctrl=template', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-acytemplate.png', 0, '', 100, 101, 0, '', 1),
(139, 'main', 'Queue', 'queue', '', 'acymailing/queue', 'index.php?option=com_acymailing&ctrl=queue', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-process.png', 0, '', 102, 103, 0, '', 1),
(140, 'main', 'Statistics', 'statistics', '', 'acymailing/statistics', 'index.php?option=com_acymailing&ctrl=stats', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-stats.png', 0, '', 104, 105, 0, '', 1),
(141, 'main', 'Configuration', 'configuration', '', 'acymailing/configuration', 'index.php?option=com_acymailing&ctrl=cpanel', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-acyconfig.png', 0, '', 106, 107, 0, '', 1),
(142, 'main', 'Update_About', 'update-about', '', 'acymailing/update-about', 'index.php?option=com_acymailing&ctrl=update', 'component', 0, 134, 2, 10039, 0, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_acymailing/images/icons/icon-16-update.png', 0, '', 108, 109, 0, '', 1),
(143, 'bottom-menu', 'Каталоги', 'zakaz-katalogov', '', 'zakaz-katalogov', 'index.php?option=com_content&view=article&id=17', 'component', 0, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 111, 112, 0, '*', 0),
(144, 'main', 'JCE', 'jce', '', 'jce', 'index.php?option=com_jce', 'component', 0, 1, 1, 10057, 0, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_jce/media/img/menu/logo.png', 0, '', 113, 122, 0, '', 1),
(145, 'main', 'WF_MENU_CPANEL', 'wf-menu-cpanel', '', 'jce/wf-menu-cpanel', 'index.php?option=com_jce', 'component', 0, 144, 2, 10057, 0, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_jce/media/img/menu/jce-cpanel.png', 0, '', 114, 115, 0, '', 1),
(146, 'main', 'WF_MENU_CONFIG', 'wf-menu-config', '', 'jce/wf-menu-config', 'index.php?option=com_jce&view=config', 'component', 0, 144, 2, 10057, 0, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_jce/media/img/menu/jce-config.png', 0, '', 116, 117, 0, '', 1),
(147, 'main', 'WF_MENU_PROFILES', 'wf-menu-profiles', '', 'jce/wf-menu-profiles', 'index.php?option=com_jce&view=profiles', 'component', 0, 144, 2, 10057, 0, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_jce/media/img/menu/jce-profiles.png', 0, '', 118, 119, 0, '', 1),
(148, 'main', 'WF_MENU_INSTALL', 'wf-menu-install', '', 'jce/wf-menu-install', 'index.php?option=com_jce&view=installer', 'component', 0, 144, 2, 10057, 0, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_jce/media/img/menu/jce-install.png', 0, '', 120, 121, 0, '', 1),
(149, 'main', 'COM_AUCTION2013', 'auction-stuff', '', 'auction-stuff', 'index.php?option=com_auction2013', 'component', 0, 1, 1, 10059, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:component', 0, '', 123, 124, 0, '', 1),
(151, 'mainmenu', 'Форма регистрации', 'zaregistrirovatsja', '', 'pravila/pravila-registraciji-uchastnikov-torgov/zaregistrirovatsja', 'index.php?option=com_auction2013&view=auction2013&layout=register', 'component', 0, 131, 3, 10059, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"-special","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"-register-form","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 71, 72, 0, '*', 0),
(154, 'usermenu', 'Настройки аккаунта', 'data', '', 'data', 'index.php?option=com_users&view=profile&layout=data', 'component', 1, 1, 1, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 131, 132, 0, '*', 0),
(155, 'usermenu', 'Ваш кабинет', 'lots', '', 'lots', 'index.php?option=com_users&view=profile&layout=lots', 'component', 1, 1, 1, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"H2","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 125, 126, 0, '*', 0),
(168, 'pseudomenu', 'Задать вопрос по лоту', 'задать-вопрос-по-лоту', 'В выпадающем меню нет. только во внутреннем', 'задать-вопрос-по-лоту', 'index.php?option=com_auction2013&view=auction2013&layout=askaboutlot', 'component', 0, 1, 1, 10059, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 133, 134, 0, '*', 0),
(167, '', '', '', '', '', '', '', 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, '', 0, '', 0, 0, 0, '', 1);

-- 
-- Вывод данных для таблицы auc13_menu_types
--
INSERT INTO auc13_menu_types VALUES
(1, 'mainmenu', 'Главное меню', 'The main menu for the site'),
(2, 'bottom-menu', 'Нижнее меню', 'нижнее меню'),
(3, 'usermenu', 'Меню пользователя', 'Доступно только после авторизации'),
(4, 'pseudomenu', 'Псевдоменю', 'Нужны только для того, чтобы корректно проставлять ссылки в текстах, т.к. для этого требуется id меню. Не публиковать!');

-- 
-- Вывод данных для таблицы auc13_messages
--

-- Таблица auctionru_2013.auc13_messages не содержит данных

-- 
-- Вывод данных для таблицы auc13_messages_cfg
--

-- Таблица auctionru_2013.auc13_messages_cfg не содержит данных

-- 
-- Вывод данных для таблицы auc13_modules
--
INSERT INTO auc13_modules VALUES
(1, 'Главное меню', '', '', 1, 'user3', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 1, 0, '{"menutype":"mainmenu","startLevel":"1","endLevel":"0","showAllChildren":"1","tag_id":"","class_sfx":"","window_open":"","layout":"_:default","moduleclass_sfx":"_menu","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(2, 'Login', '', '', 1, 'login', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_login', 1, 1, '', 1, '*'),
(3, 'Popular Articles', '', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_popular', 3, 1, '{"count":"5","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(4, 'Recently Added Articles', '', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_latest', 3, 1, '{"count":"5","ordering":"c_dsc","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(8, 'Toolbar', '', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_toolbar', 3, 1, '', 1, '*'),
(9, 'Quick Icons', '', '', 1, 'icon', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_quickicon', 3, 1, '', 1, '*'),
(10, 'Logged-in Users', '', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_logged', 3, 1, '{"count":"5","name":"1","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(12, 'Admin Menu', '', '', 1, 'menu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 3, 1, '{"layout":"","moduleclass_sfx":"","shownew":"1","showhelp":"1","cache":"0"}', 1, '*'),
(13, 'Admin Submenu', '', '', 1, 'submenu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_submenu', 3, 1, '', 1, '*'),
(14, 'User Status', '', '', 2, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_status', 3, 1, '', 1, '*'),
(15, 'Title', '', '', 1, 'title', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_title', 3, 1, '', 1, '*'),
(16, 'КАБИНЕТ', '', '', 1, 'right', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_login', 1, 0, '{"pretext":"","posttext":"","login":"","logout":"101","greeting":"1","name":"0","usesecure":"0","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 0, '*'),
(17, 'Breadcrumbs', '', '', 1, 'position-2', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_breadcrumbs', 1, 1, '{"moduleclass_sfx":"","showHome":"1","homeText":"Home","showComponent":"1","separator":"","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(79, 'Multilanguage status', '', '', 1, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_multilangstatus', 3, 1, '{"layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(86, 'Joomla Version', '', '', 1, 'footer', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_version', 3, 1, '{"format":"short","product":"1","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(87, 'VM - Currencies Selector', '', '', 4, 'position-4', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_virtuemart_currencies', 1, 1, '', 0, ''),
(88, 'VM - Featured products', '', '', 3, 'position-4', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_virtuemart_product', 1, 1, '', 0, ''),
(89, 'VM - Search in Shop', '', '', 2, 'position-4', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_virtuemart_search', 1, 1, '', 0, ''),
(90, 'VM - Manufacturer', '', '', 5, 'position-4', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_virtuemart_manufacturer', 1, 1, '', 0, ''),
(91, 'VM - Shopping cart', '', '', 0, 'position-4', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_virtuemart_cart', 1, 1, '', 0, ''),
(92, 'VM - Category', '', '', 6, 'position-4', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_virtuemart_category', 1, 1, '', 0, ''),
(93, 'Типы лотов', '', '<div id="left_part">\r\n<div id="left_menu">\r\n<ul id="main_categoriesS">\r\n<li class="element" style="margin-bottom: 10px;"><a href="category/248/Онлайн-торги.html">Онлайн торги</a> <span class="main_navigation_1_count">(2)</span>\r\n<ul class="subcat">\r\n<li><a class="main_navigation_1_sub_category_name" href="category/270/Русская-живопись.html"><span class="cl_tx_it">Русская живопись</span></a> (2)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/272/Советская-живопись.html"><span class="cl_tx_it">Советская живопись</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/273/Миниатюры.html"><span class="cl_tx_it">Миниатюры</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/328/Иконы.html"><span class="cl_tx_it">Иконы</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/274/Фарфор,-керамика.html"><span class="cl_tx_it">Фарфор, керамика</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/331/Фарфор,керамика-после-1917-г.html"><span class="cl_tx_it">Фарфор,керамика после 1917 г.</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/275/Стекло,-хрусталь.html"><span class="cl_tx_it">Стекло, хрусталь</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/276/Художественная-бронза,-чугун,-шпиатр-и-пр.html"><span class="cl_tx_it">Художественная бронза, чугун, шпиатр и пр.</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/277/Часы.html"><span class="cl_tx_it">Часы</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/278/Предметы-интерьера.html"><span class="cl_tx_it">Предметы интерьера</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/281/Серебро.html"><span class="cl_tx_it">Серебро</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/282/Ювелирные-изделия.html"><span class="cl_tx_it">Ювелирные изделия</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/283/Восточное-искусство.html"><span class="cl_tx_it">Восточное искусство</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/284/Мебель.html"><span class="cl_tx_it">Мебель</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/292/Карты,-гравюры,-литографии.html"><span class="cl_tx_it">Карты, гравюры, литографии</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/279/Книги,-разное.html"><span class="cl_tx_it">Книги, разное</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/291/Марки,-открытки.html"><span class="cl_tx_it">Марки, открытки</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/330/Ткани,-прочее.html"><span class="cl_tx_it">Ткани, прочее...</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/285/Разное.html"><span class="cl_tx_it">Разное</span></a> (0)</li>\r\n</ul>\r\n</li>\r\n<li class="clr"></li>\r\n<li class="element" style="margin-bottom: 10px;"><a href="category/234/Очные-торги.html">Очные торги</a> <span class="main_navigation_1_count">(245)</span>\r\n<ul class="subcat">\r\n<li><a class="main_navigation_1_sub_category_name" href="category/269/Живопись,-графика.html"><span class="cl_tx_it">Живопись, графика</span></a> (105)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/266/Иконы.html"><span class="cl_tx_it">Иконы</span></a> (12)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/261/Декоративно-прикладное-искусство.html"><span class="cl_tx_it">Декоративно-прикладное искусство</span></a> (72)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/286/Ювелирные-изделия.html"><span class="cl_tx_it">Ювелирные изделия</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/287/Предметы-интерьера.html"><span class="cl_tx_it">Предметы интерьера</span></a> (28)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/289/Мебель.html"><span class="cl_tx_it">Мебель</span></a> (10)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/290/Предметы-коллекционирования.html"><span class="cl_tx_it">Предметы коллекционирования</span></a> (18)</li>\r\n</ul>\r\n</li>\r\n<li class="clr"></li>\r\n<li class="element" style="margin-bottom: 10px;"><a href="category/310/Магазин.html">Магазин</a> <span class="main_navigation_1_count">(294)</span>\r\n<ul class="subcat">\r\n<li><a class="main_navigation_1_sub_category_name" href="category/312/Русская-живопись.html"><span class="cl_tx_it">Русская живопись</span></a> (22)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/311/Западноевропейская-живопись.html"><span class="cl_tx_it">Западноевропейская живопись</span></a> (25)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/317/Советская-живопись.html"><span class="cl_tx_it">Советская живопись</span></a> (36)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/313/Миниатюры.html"><span class="cl_tx_it">Миниатюры</span></a> (1)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/329/Иконы.html"><span class="cl_tx_it">Иконы</span></a> (15)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/314/Фарфор,-керамика.html"><span class="cl_tx_it">Фарфор, керамика</span></a> (48)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/333/Фарфор,керамика-после-1917-г.html"><span class="cl_tx_it">Фарфор,керамика после 1917 г.</span></a> (37)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/318/Стекло,-хрусталь.html"><span class="cl_tx_it">Стекло, хрусталь</span></a> (11)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/319/Художественная-бронза,-чугун,-шпиатр-и-пр.html"><span class="cl_tx_it">Художественная бронза, чугун, шпиатр и пр.</span></a> (26)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/320/Часы.html"><span class="cl_tx_it">Часы</span></a> (5)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/321/Предметы-интерьера.html"><span class="cl_tx_it">Предметы интерьера</span></a> (4)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/323/Серебро.html"><span class="cl_tx_it">Серебро</span></a> (8)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/324/Ювелирные-изделия.html"><span class="cl_tx_it">Ювелирные изделия</span></a> (1)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/325/Восточное-искусство.html"><span class="cl_tx_it">Восточное искусство</span></a> (6)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/326/Мебель.html"><span class="cl_tx_it">Мебель</span></a> (4)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/315/Карты,-гравюры,-литографии.html"><span class="cl_tx_it">Карты, гравюры, литографии</span></a> (13)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/322/Книги,-разное.html"><span class="cl_tx_it">Книги, разное</span></a> (3)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/316/Марки,-открытки.html"><span class="cl_tx_it">Марки, открытки</span></a> (0)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/332/Ткани,-прочее.html"><span class="cl_tx_it">Ткани, прочее...</span></a> (6)</li>\r\n<li><a class="main_navigation_1_sub_category_name" href="category/327/Разное.html"><span class="cl_tx_it">Разное</span></a> (23)</li>\r\n</ul>\r\n</li>\r\n<li class="clr"></li>\r\n</ul>\r\n</div>\r\n</div>', 1, 'left', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_custom', 1, 0, '{"prepare_content":"1","backgroundimage":"","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","cachemode":"static"}', 0, '*'),
(94, 'Нижнее меню', '', '', 1, 'footer', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 1, 0, '{"menutype":"bottom-menu","startLevel":"1","endLevel":"0","showAllChildren":"0","tag_id":"","class_sfx":"","window_open":"","layout":"_:default","moduleclass_sfx":"_menu","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(95, 'ВАШ КАБИНЕТ и РЕГИСТРАЦИЯ', '', '<div style="height: 42px;">\r\n<div style="float: left;">\r\n<h3><a href="index.php?option=com_users&view=login">Ваш Кабинет</a></h3>\r\n</div>\r\n<div style="float: left; margin-left: 20px;">\r\n<h3><a href="index.php?option=com_auction2013&amp;layout=register">Регистрация</a></h3>\r\n</div>\r\n</div>', 1, 'right_over', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_custom', 1, 0, '{"prepare_content":"1","backgroundimage":"","layout":"_:default","moduleclass_sfx":"-over_login","cache":"1","cache_time":"900","cachemode":"static"}', 0, '*'),
(96, 'AcyMailing Module', '', '', 0, 'position-7', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_acymailing', 1, 1, '', 0, '*'),
(97, 'Вам сообщить о появлении каталога?', '', '', 0, 'right_under', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_acymailing', 1, 1, '{"effect":"normal","lists":"None","hiddenlists":"All","displaymode":"vertical","listschecked":"All","checkmode":"0","dropdown":"0","overlay":"0","link":"0","customfields":"name,email","nametext":"","emailtext":"","fieldsize":"80%","displayfields":"0","introtext":"","finaltext":"","showsubscribe":"1","subscribetext":"","subscribetextreg":"","showunsubscribe":"0","unsubscribetext":"","redirectmode":"0","redirectlink":"","redirectlinkunsub":"","showterms":"0","showtermspopup":"1","termscontent":"0","mootoolsintro":"","mootoolsbutton":"","boxwidth":"250","boxheight":"200","moduleclass_sfx":"-acy_subscribe","textalign":"none","loggedin":"1","cache":"0","includejs":"header","itemid":""}', 0, '*'),
(98, 'Каталоги', '', '<h3><a href="index.php?option=com_content&amp;view=article&amp;id=17:zakaz-katalogov&amp;catid=2:uncategorised">Каталоги</a></h3>', 1, 'right_bottom', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_custom', 1, 0, '{"prepare_content":"1","backgroundimage":"","layout":"_:default","moduleclass_sfx":"-go_catalogues","cache":"1","cache_time":"900","cachemode":"static"}', 0, '*'),
(99, 'Категории лотов', '', '', 1, 'left_panel', 107, '2013-02-28 16:25:07', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_vlotscats', 1, 0, '{"moduleclass_sfx":"","cache":"1","cache_time":"900","cachemode":"static"}', 0, '*'),
(100, 'Найти', '', '', 0, 'search', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_finder', 1, 0, '{"searchfilter":"","show_autosuggest":"1","show_advanced":"0","layout":"_:default","moduleclass_sfx":"","field_size":19,"alt_label":"","show_label":"0","label_pos":"top","show_button":"0","button_pos":"right","opensearch":"1","opensearch_title":""}', 0, '*'),
(101, 'Поиск', '', '', 1, 'search', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_search', 1, 0, '{"label":"","width":"19","text":"\\u043f\\u043e\\u0438\\u0441\\u043a...","button":"","button_pos":"right","imagebutton":"","button_text":"","opensearch":"1","opensearch_title":"","set_itemid":"","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(102, 'Меню пользователя', '', '', 1, 'usermenu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 1, 0, '{"menutype":"usermenu","startLevel":"1","endLevel":"0","showAllChildren":"0","tag_id":"","class_sfx":"","window_open":"","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(103, 'Яндекс карта: Антикварный салон', '', '', 1, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_flyleaf_ymap', 1, 1, '{"location":"30.342226,59.939808","center":"30.342310820068338,59.940074704147875","zoom":"14","map_type":"yandex#map","width":"100%","height":"300px","icon":"\\u042f.\\u041c\\u0435\\u0442\\u043a\\u0430","hint":"","iconstyle":"twirl#lightblueStretchyIcon","balloon":"","balloon_on":"0","control1":"1","control2":"0","control3":"1","control4":"0","selfscript":"\\/* \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440 \\u043a\\u043e\\u0434\\u0430 \\u0434\\u043e\\u0431\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f \\u0435\\u0449\\u0435 \\u043e\\u0434\\u043d\\u043e\\u0439 \\u043c\\u0435\\u0442\\u043a\\u0438 myMap.geoObjects.add(new ymaps.Placemark([54.274161,56.096468], { iconContent: ''\\u0422\\u0435\\u043a\\u0441\\u0442 \\u043c\\u0435\\u0442\\u043a\\u0438'',hintContent: '''', balloonContent: ''\\u041e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435, \\u0431\\u0430\\u043b\\u0443\\u043d'' },   {   preset: ''twirl#blueStretchyIcon''} )); *\\/","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","bklnk":"PGRpdiBpZD0iYmxuayI+PGEgaHJlZj0iaHR0cDovL2ZseWxlYWYuc3UvYmxvZy8iIHRhcmdldD0iX2JsYW5rIj7QnNC+0LTRg9C70Ywg0K\\/QvdC00LXQutGBINCa0LDRgNGCIEpvb21sYTwvYT48L2Rpdj4=","cachemode":"static"}', 0, '*'),
(104, 'Яндекс карта: Антикварная галерея', '', '', 2, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_flyleaf_ymap', 1, 1, '{"location":"30.347289,59.944381","center":"30.347289,59.944381","zoom":"14","map_type":"yandex#map","width":"100%","height":"300px","icon":"\\u042f.\\u041c\\u0435\\u0442\\u043a\\u0430","hint":"","iconstyle":"twirl#lightblueStretchyIcon","balloon":"","balloon_on":"0","control1":"1","control2":"0","control3":"1","control4":"0","selfscript":"\\/* \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440 \\u043a\\u043e\\u0434\\u0430 \\u0434\\u043e\\u0431\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f \\u0435\\u0449\\u0435 \\u043e\\u0434\\u043d\\u043e\\u0439 \\u043c\\u0435\\u0442\\u043a\\u0438 myMap.geoObjects.add(new ymaps.Placemark([54.274161,56.096468], { iconContent: ''\\u0422\\u0435\\u043a\\u0441\\u0442 \\u043c\\u0435\\u0442\\u043a\\u0438'',hintContent: '''', balloonContent: ''\\u041e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435, \\u0431\\u0430\\u043b\\u0443\\u043d'' },   {   preset: ''twirl#blueStretchyIcon''} )); *\\/","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","bklnk":"PGRpdiBpZD0iYmxuayI+PGEgaHJlZj0iaHR0cDovL2ZseWxlYWYuc3UvYmxvZy8iIHRhcmdldD0iX2JsYW5rIj7QnNC+0LTRg9C70Ywg0K\\/QvdC00LXQutGBINCa0LDRgNGCIEpvb21sYTwvYT48L2Rpdj4=","cachemode":"static"}', 0, '*');

-- 
-- Вывод данных для таблицы auc13_modules_menu
--
INSERT INTO auc13_modules_menu VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0),
(16, 101),
(17, 0),
(79, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(94, 0),
(95, 0),
(96, 0),
(97, 101),
(98, 0),
(99, 0),
(100, 0),
(101, 0),
(102, -151),
(102, -143),
(102, -133),
(102, -132),
(102, -131),
(102, -130),
(102, -129),
(102, -128),
(102, -127),
(102, -126),
(102, -125),
(102, -124),
(102, -123),
(102, -122),
(102, -121),
(102, -120),
(102, -119),
(102, -118),
(102, -117),
(102, -116),
(102, -115),
(102, -114),
(102, -113),
(102, -101),
(103, 130),
(104, 129);

-- 
-- Вывод данных для таблицы auc13_newsfeeds
--

-- Таблица auctionru_2013.auc13_newsfeeds не содержит данных

-- 
-- Вывод данных для таблицы auc13_overrider
--

-- Таблица auctionru_2013.auc13_overrider не содержит данных

-- 
-- Вывод данных для таблицы auc13_product_favorites
--
INSERT INTO auc13_product_favorites VALUES
(2, 584, 204, '2013-03-01 18:26:27'),
(11, 1, 232, '2013-03-01 18:57:28'),
(12, 596, 232, '2013-03-01 19:00:43'),
(6, 521, 204, '2013-03-01 18:37:25'),
(7, 552, 204, '2013-03-01 18:48:27'),
(8, 495, 204, '2013-03-01 18:50:13'),
(9, 587, 204, '2013-03-01 18:52:31'),
(13, 585, 232, '2013-03-01 19:02:48'),
(14, 507, 232, '2013-03-01 19:03:01');

-- 
-- Вывод данных для таблицы auc13_redirect_links
--
INSERT INTO auc13_redirect_links VALUES
(1, 'http://localhost/~auction.test/index.php/component/user/?view=remind', '', 'http://localhost/~auction.test/', '', 5, 0, '2013-02-03 08:11:02', '0000-00-00 00:00:00'),
(2, 'http://localhost/~auction.test/index.php/component/user/?view=reset', '', 'http://localhost/~auction.test/', '', 1, 0, '2013-02-03 08:13:35', '0000-00-00 00:00:00'),
(3, 'http://localhost/~auction.test/index.php/zakaz-katalogov', '', 'http://localhost/~auction.test/', '', 3, 0, '2013-02-03 09:10:08', '0000-00-00 00:00:00'),
(4, 'http://localhost/~auction.test/index.php', '', 'http://localhost/~auction.test/', '', 2, 0, '2013-02-04 13:39:34', '0000-00-00 00:00:00'),
(5, 'http://localhost/~auction.test/index.php/component/users/?task=user.logout', '', 'http://localhost/~auction.test/', '', 6, 0, '2013-02-04 17:29:13', '0000-00-00 00:00:00'),
(6, 'http://localhost/~auction.test/index.php/component/content/article/', '', '', '', 1, 0, '2013-02-04 17:52:17', '0000-00-00 00:00:00'),
(7, 'http://localhost/~auction.test/index.php/component/content/article', '', '', '', 1, 0, '2013-02-04 17:52:21', '0000-00-00 00:00:00'),
(8, 'http://localhost/~auction.test/index.php?option=com_content&view=article', '', '', '', 1, 0, '2013-02-04 17:52:39', '0000-00-00 00:00:00'),
(9, 'http://localhost/~auction.test/?option=com_auction', '', '', '', 1, 0, '2013-02-06 21:28:31', '0000-00-00 00:00:00'),
(10, 'http://localhost/~auction.test/index.php?option=com_content&view=article&layout=register', '', '', '', 1, 0, '2013-02-07 20:02:52', '0000-00-00 00:00:00'),
(11, 'http://localhost/~auction.test/index.php/component/auction2013s/?layout=register', '', 'http://localhost/~auction.test/index.php/home', '', 1, 0, '2013-02-08 10:56:27', '0000-00-00 00:00:00'),
(12, 'http://localhost/~auction.test/index.php/zaregistrirovatsja', '', '', '', 1, 0, '2013-02-08 11:19:15', '0000-00-00 00:00:00'),
(13, 'http://localhost/~auction.test/index.php/auction/zaregistrirovatsja', '', '', '', 3, 0, '2013-02-08 11:19:28', '0000-00-00 00:00:00'),
(14, 'http://localhost/~auction.test/index.php/auction/register', '', '', '', 2, 0, '2013-02-08 11:20:27', '0000-00-00 00:00:00'),
(15, 'http://localhost/~auction.test/index.php/auction2013/register', '', '', '', 1, 0, '2013-02-09 14:41:27', '0000-00-00 00:00:00'),
(16, 'http://localhost/~auction.test/index.php/users/login', '', 'http://localhost/~auction.test/', '', 1, 0, '2013-02-10 09:56:43', '0000-00-00 00:00:00'),
(17, 'http://localhost/~auction.test/index.php/component/ion2013/?layout=thanx', '', 'http://localhost/~auction.test/index.php/component/auction2013/?layout=register&test=1', '', 1, 0, '2013-02-10 11:38:19', '0000-00-00 00:00:00'),
(18, 'http://localhost/~auction.test/index.php/magazin', '', '', '', 5, 0, '2013-02-13 08:02:43', '0000-00-00 00:00:00'),
(19, 'http://localhost/~auction.test/component/', '', 'http://localhost/~auction.test/magazin', '', 2, 0, '2013-02-17 12:31:26', '0000-00-00 00:00:00'),
(20, 'http://localhost/~auction.test/index.php/auction/магазин/ikony/vtoroe-prishestvie-predsedatelya-detail', '', '', '', 1, 0, '2013-02-17 21:45:18', '0000-00-00 00:00:00'),
(21, 'http://localhost/~auction.test/auction/магазин/ikony/vtoroe-prishestvie-predsedatelya-detail', '', '', '', 1, 0, '2013-02-17 23:33:10', '0000-00-00 00:00:00'),
(22, 'http://localhost/~auction.test/index.php?option=com_', '', 'http://localhost/~auction.test/index.php?option=com_virtuemart&view=productdetails&virtuemart_product_id=1&virtuemart_category_id=1&Itemid=115', '', 1, 0, '2013-02-18 17:10:02', '0000-00-00 00:00:00'),
(23, 'http://localhost/~auction.test/магазин', '', 'http://localhost/~auction.test/', '', 1, 0, '2013-02-19 16:50:01', '0000-00-00 00:00:00'),
(24, 'http://localhost/~auction.test/торги-на-месте', '', '', '', 2, 0, '2013-02-19 18:10:11', '0000-00-00 00:00:00'),
(25, 'http://localhost/~auction.test/index.php/магазин/русская-живопись', '', 'http://localhost/~auction.test/%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD-%D0%B0%D0%BD%D1%82%D0%B8%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D1%82%D0%B0/%D1', '', 1, 0, '2013-02-20 22:30:35', '0000-00-00 00:00:00'),
(26, 'http://localhost/~auction.test/очные-торги/yuvelirnye-izdeliya-torgi', '', 'http://localhost/~auction.test/%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD-%D0%B0%D0%BD%D1%82%D0%B8%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D1%82%D0%B0/%D1', '', 1, 0, '2013-02-20 22:51:06', '0000-00-00 00:00:00'),
(27, 'http://localhost/~auction.test//khudozhestvennaya-bronza-chugun-shpiatr-i-pr2013-02-12-08-52-04_', '', 'http://localhost/~auction.test/%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD-%D0%B0%D0%BD%D1%82%D0%B8%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D1%82%D0%B0/ste', '', 1, 0, '2013-02-20 23:21:42', '0000-00-00 00:00:00'),
(28, 'http://localhost/~auction.test/components/com_virtuemart/assets/images/availability/навсегда', '', 'http://localhost/~auction.test/administrator/index.php?option=com_virtuemart&view=product&task=edit&virtuemart_product_id[]=137', '', 4, 0, '2013-02-22 14:17:40', '0000-00-00 00:00:00'),
(29, 'http://localhost/~auction.test/магазин/farfor-keramika-posle-1917-g/results,1-30', '', '', '', 1, 0, '2013-02-25 11:56:59', '0000-00-00 00:00:00'),
(30, 'http://localhost/~auction.test/&layout=shop/result1,15', '', 'http://localhost/~auction.test/%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD-%D0%B0%D0%BD%D1%82%D0%B8%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D1%82%D0%B0/', '', 1, 0, '2013-02-25 13:15:47', '0000-00-00 00:00:00'),
(31, 'http://localhost/~auction.test/магазин-антиквариата&layout=shop/result1,15', '', 'http://localhost/~auction.test/%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD-%D0%B0%D0%BD%D1%82%D0%B8%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D1%82%D0%B0/', '', 1, 0, '2013-02-25 13:25:18', '0000-00-00 00:00:00'),
(32, 'http://localhost/~auction.test/очные-торги/?limit=30', '', 'http://localhost/~auction.test/%D0%B0%D1%83%D0%BA%D1%86%D0%B8%D0%BE%D0%BD/%D0%BE%D1%87%D0%BD%D1%8B%D0%B5-%D1%82%D0%BE%D1%80%D0%B3%D0%B8', '', 3, 0, '2013-02-25 17:46:42', '0000-00-00 00:00:00'),
(33, 'http://localhost/~auction.test/очные-торги/?limit=15', '', 'http://localhost/~auction.test/%D0%B0%D1%83%D0%BA%D1%86%D0%B8%D0%BE%D0%BD/%D0%BE%D1%87%D0%BD%D1%8B%D0%B5-%D1%82%D0%BE%D1%80%D0%B3%D0%B8/?limit=30', '', 1, 0, '2013-02-25 17:52:54', '0000-00-00 00:00:00'),
(34, 'http://localhost/~auction.test/магазин/русская-живопись/kartina-repina-pro-rep-detail', '', '', '', 1, 0, '2013-02-25 19:06:04', '0000-00-00 00:00:00'),
(35, 'http://localhost/~auction.test/component/content/article?id=169', '', 'http://localhost/~auction.test/%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD-%D0%B0%D0%BD%D1%82%D0%B8%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D1%82%D0%B0/%D0', '', 1, 0, '2013-02-26 18:49:59', '0000-00-00 00:00:00'),
(36, 'http://localhost/~auction.test/_temp/cron.php?action=cron', '', 'http://localhost/~auction.test/_temp/thumbs.htm', '', 11, 0, '2013-02-27 17:38:01', '0000-00-00 00:00:00'),
(37, 'http://localhost/~auction.test/_temp/thumbs2.php', '', '', '', 1, 0, '2013-02-27 22:12:39', '0000-00-00 00:00:00'),
(38, 'http://localhost/~auction.test/_temp/thumbs2.html', '', '', '', 1, 0, '2013-02-27 22:12:57', '0000-00-00 00:00:00'),
(39, 'http://localhost/~auction.test/index.php?option=com_user&view=profile&layout=favorites', '', 'http://localhost/~auction.test/favorites', '', 1, 0, '2013-03-01 07:56:41', '0000-00-00 00:00:00');

-- 
-- Вывод данных для таблицы auc13_schemas
--
INSERT INTO auc13_schemas VALUES
(700, '2.5.8'),
(10059, '0.0.1');

-- 
-- Вывод данных для таблицы auc13_session
--
INSERT INTO auc13_session VALUES
('8e4eb6a5ab9d52bf6b6917f676308976', 1, 0, '1362407214', '__default|a:8:{s:15:"session.counter";i:41;s:19:"session.timer.start";i:1362406185;s:18:"session.timer.last";i:1362407211;s:17:"session.timer.now";i:1362407212;s:22:"session.client.browser";s:130:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1106.241 YaBrowser/1.5.1106.241 Safari/537.4";s:8:"registry";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":6:{s:11:"application";O:8:"stdClass":1:{s:4:"lang";s:0:"";}s:13:"com_installer";O:8:"stdClass":2:{s:7:"message";s:0:"";s:17:"extension_message";s:0:"";}s:9:"com_users";O:8:"stdClass":2:{s:5:"users";O:8:"stdClass":1:{s:7:"default";O:8:"stdClass":4:{s:6:"filter";O:8:"stdClass":5:{s:6:"search";s:0:"";s:6:"active";s:1:"*";s:5:"state";s:1:"*";s:5:"group";i:0;s:5:"range";s:0:"";}s:10:"limitstart";i:0;s:8:"ordercol";s:4:"a.id";s:9:"orderdirn";s:4:"desc";}}s:4:"edit";O:8:"stdClass":1:{s:4:"user";O:8:"stdClass":2:{s:2:"id";a:0:{}s:4:"data";N;}}}s:6:"global";O:8:"stdClass":1:{s:4:"list";O:8:"stdClass":1:{s:5:"limit";i:20;}}s:14:"com_categories";O:8:"stdClass":1:{s:10:"categories";O:8:"stdClass":1:{s:6:"filter";O:8:"stdClass":1:{s:9:"extension";s:9:"com_users";}}}s:11:"com_modules";O:8:"stdClass":3:{s:7:"modules";O:8:"stdClass":1:{s:6:"filter";O:8:"stdClass":1:{s:18:"client_id_previous";i:0;}}s:4:"edit";O:8:"stdClass":1:{s:6:"module";O:8:"stdClass":2:{s:2:"id";a:0:{}s:4:"data";N;}}s:3:"add";O:8:"stdClass":1:{s:6:"module";O:8:"stdClass":2:{s:12:"extension_id";N;s:6:"params";N;}}}}}s:4:"user";O:5:"JUser":37:{s:9:"\0*\0isRoot";b:1;s:2:"id";s:3:"107";s:4:"name";s:10:"Super User";s:8:"username";s:5:"admin";s:5:"email";s:20:"srgg140201@yandex.ru";s:8:"password";s:65:"49f2083d29533d56ddfae7475b70433f:v4cwrQxhvvgB7dgsn95VF7Hj8UmlIKqq";s:14:"password_clear";s:0:"";s:8:"usertype";s:10:"deprecated";s:5:"block";s:1:"0";s:9:"sendEmail";s:1:"1";s:12:"registerDate";s:19:"2013-02-01 08:41:18";s:13:"lastvisitDate";s:19:"2013-03-02 05:52:20";s:10:"activation";s:1:"0";s:6:"params";s:2:"{}";s:6:"groups";a:1:{i:8;s:1:"8";}s:5:"guest";i:0;s:13:"lastResetTime";s:19:"0000-00-00 00:00:00";s:10:"resetCount";s:1:"0";s:10:"\0*\0_params";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":0:{}}s:14:"\0*\0_authGroups";a:2:{i:0;i:1;i:1;i:8;}s:14:"\0*\0_authLevels";a:4:{i:0;i:1;i:1;i:1;i:2;i:2;i:3;i:3;}s:15:"\0*\0_authActions";N;s:12:"\0*\0_errorMsg";N;s:10:"\0*\0_errors";a:0:{}s:3:"aid";i:0;s:10:"middlename";s:0:"";s:8:"lastname";s:0:"";s:12:"company_name";s:0:"";s:10:"country_id";s:1:"0";s:3:"zip";s:0:"";s:4:"city";s:0:"";s:6:"street";s:0:"";s:12:"house_number";s:0:"";s:13:"corpus_number";s:0:"";s:18:"flat_office_number";s:0:"";s:12:"phone_number";s:0:"";s:13:"phone2_number";s:0:"";}s:13:"session.token";s:32:"4189b666689886d223332fd8c94ba9ce";}__wf|a:1:{s:13:"session.token";s:32:"cd688c7d97bcf3b4178894a25d865fb1";}', 107, 'admin', ''),
('0174c0384c6bd0724d3f0e4c4d5a1509', 0, 0, '1362406675', '__default|a:10:{s:15:"session.counter";i:9;s:19:"session.timer.start";i:1362406012;s:18:"session.timer.last";i:1362406669;s:17:"session.timer.now";i:1362406675;s:22:"session.client.browser";s:108:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.97 Safari/537.22";s:8:"registry";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":1:{s:5:"users";O:8:"stdClass":1:{s:5:"login";O:8:"stdClass":1:{s:4:"form";O:8:"stdClass":2:{s:6:"return";s:57:"index.php?option=com_content&view=article&id=1&Itemid=101";s:4:"data";a:0:{}}}}}}s:4:"user";O:5:"JUser":37:{s:9:"\0*\0isRoot";b:0;s:2:"id";s:3:"368";s:4:"name";s:17:"Джулcомэн";s:8:"username";s:6:"200321";s:5:"email";s:21:"sonja888888@email.com";s:8:"password";s:65:"320f1329daf3e274aa97ebe78745a3f7:eKlsKdzcPYjOjZTyEXmLxmdX4Uk5qwT0";s:14:"password_clear";s:0:"";s:8:"usertype";s:0:"";s:5:"block";s:1:"0";s:9:"sendEmail";s:1:"0";s:12:"registerDate";s:19:"2013-03-02 08:32:07";s:13:"lastvisitDate";s:19:"0000-00-00 00:00:00";s:10:"activation";s:0:"";s:6:"params";s:92:"{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":""}";s:6:"groups";a:1:{i:2;s:1:"2";}s:5:"guest";i:0;s:13:"lastResetTime";s:19:"0000-00-00 00:00:00";s:10:"resetCount";s:1:"0";s:10:"\0*\0_params";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":6:{s:11:"admin_style";s:0:"";s:14:"admin_language";s:0:"";s:8:"language";s:0:"";s:6:"editor";s:0:"";s:8:"helpsite";s:0:"";s:8:"timezone";s:0:"";}}s:14:"\0*\0_authGroups";a:2:{i:0;i:1;i:1;i:2;}s:14:"\0*\0_authLevels";a:3:{i:0;i:1;i:1;i:1;i:2;i:2;}s:15:"\0*\0_authActions";N;s:12:"\0*\0_errorMsg";N;s:10:"\0*\0_errors";a:0:{}s:3:"aid";i:0;s:10:"middlename";s:16:"Джудович";s:8:"lastname";s:22:"Большеротый";s:12:"company_name";s:35:"Наименование фирмы";s:10:"country_id";s:3:"380";s:3:"zip";s:6:"318318";s:4:"city";s:8:"Кийв";s:6:"street";s:16:"Хрешатиг";s:12:"house_number";s:6:"118/55";s:13:"corpus_number";s:37:"железный на этот раз";s:18:"flat_office_number";s:1:"0";s:12:"phone_number";s:11:"+3185154284";s:13:"phone2_number";s:1:"0";}s:13:"session.token";s:32:"4092382da09ae265302a5bc091c1768e";s:13:"products_data";a:3:{s:6:"online";a:17:{s:10:"prod_count";i:0;s:25:"живопись-руси";a:4:{s:22:"virtuemart_category_id";s:2:"31";s:13:"category_name";s:31:"Русская живопись";s:5:"alias";s:25:"живопись-руси";s:13:"product_count";s:1:"0";}s:39:"sovetskaya-zhivopis2013-02-12-08-49-59_";a:4:{s:22:"virtuemart_category_id";s:2:"32";s:13:"category_name";s:35:"Советская живопись";s:5:"alias";s:39:"sovetskaya-zhivopis2013-02-12-08-49-59_";s:13:"product_count";s:1:"0";}s:30:"miniatyury2013-02-12-08-50-22_";a:4:{s:22:"virtuemart_category_id";s:2:"33";s:13:"category_name";s:18:"Миниатюры";s:5:"alias";s:30:"miniatyury2013-02-12-08-50-22_";s:13:"product_count";s:1:"0";}s:25:"ikony2013-02-12-08-50-47_";a:4:{s:22:"virtuemart_category_id";s:2:"34";s:13:"category_name";s:10:"Иконы";s:5:"alias";s:25:"ikony2013-02-12-08-50-47_";s:13:"product_count";s:1:"0";}s:35:"steklo-khrustal2013-02-12-08-51-14_";a:4:{s:22:"virtuemart_category_id";s:2:"35";s:13:"category_name";s:30:"Стекло, хрусталь";s:5:"alias";s:35:"steklo-khrustal2013-02-12-08-51-14_";s:13:"product_count";s:1:"0";}s:48:"farfor-keramika-posle-1917-g2013-02-12-08-51-36_";a:4:{s:22:"virtuemart_category_id";s:2:"36";s:13:"category_name";s:50:"Фарфор, керамика после 1917 г.";s:5:"alias";s:48:"farfor-keramika-posle-1917-g2013-02-12-08-51-36_";s:13:"product_count";s:1:"0";}s:64:"khudozhestvennaya-bronza-chugun-shpiatr-i-pr2013-02-12-08-52-04_";a:4:{s:22:"virtuemart_category_id";s:2:"37";s:13:"category_name";s:76:"Художественная бронза, чугун, шпиатр и пр.";s:5:"alias";s:64:"khudozhestvennaya-bronza-chugun-shpiatr-i-pr2013-02-12-08-52-04_";s:13:"product_count";s:1:"0";}s:26:"raznoe2013-02-12-08-52-29_";a:4:{s:22:"virtuemart_category_id";s:2:"38";s:13:"category_name";s:12:"Разное";s:5:"alias";s:26:"raznoe2013-02-12-08-52-29_";s:13:"product_count";s:1:"0";}s:37:"predmety-interera2013-02-12-08-52-52_";a:4:{s:22:"virtuemart_category_id";s:2:"39";s:13:"category_name";s:35:"Предметы интерьера";s:5:"alias";s:37:"predmety-interera2013-02-12-08-52-52_";s:13:"product_count";s:1:"0";}s:27:"serebro2013-02-12-08-53-14_";a:4:{s:22:"virtuemart_category_id";s:2:"40";s:13:"category_name";s:14:"Серебро";s:5:"alias";s:27:"serebro2013-02-12-08-53-14_";s:13:"product_count";s:1:"0";}s:39:"yuvelirnye-izdeliya2013-02-17-21-17-20_";a:4:{s:22:"virtuemart_category_id";s:2:"42";s:13:"category_name";s:33:"Ювелирные изделия";s:5:"alias";s:39:"yuvelirnye-izdeliya2013-02-17-21-17-20_";s:13:"product_count";s:1:"0";}s:40:"vostochnoe-iskusstvo2013-02-12-08-54-22_";a:4:{s:22:"virtuemart_category_id";s:2:"43";s:13:"category_name";s:37:"Восточное искусство";s:5:"alias";s:40:"vostochnoe-iskusstvo2013-02-12-08-54-22_";s:13:"product_count";s:1:"0";}s:33:"karty-gravyury2013-02-12-08-54-54";a:4:{s:22:"virtuemart_category_id";s:2:"44";s:13:"category_name";s:48:"Карты, гравюры, литографии";s:5:"alias";s:33:"karty-gravyury2013-02-12-08-54-54";s:13:"product_count";s:1:"0";}s:32:"knigi-raznoe2013-02-12-08-56-07_";a:4:{s:22:"virtuemart_category_id";s:2:"45";s:13:"category_name";s:24:"Книги, разное";s:5:"alias";s:32:"knigi-raznoe2013-02-12-08-56-07_";s:13:"product_count";s:1:"0";}s:34:"marki-otkrytki2013-02-12-08-56-29_";a:4:{s:22:"virtuemart_category_id";s:2:"46";s:13:"category_name";s:28:"Марки, открытки";s:5:"alias";s:34:"marki-otkrytki2013-02-12-08-56-29_";s:13:"product_count";s:1:"0";}s:33:"tkani-prochee2013-02-12-08-56-53_";a:4:{s:22:"virtuemart_category_id";s:2:"47";s:13:"category_name";s:27:"Ткани, прочее...";s:5:"alias";s:33:"tkani-prochee2013-02-12-08-56-53_";s:13:"product_count";s:1:"0";}}s:8:"fulltime";a:8:{s:10:"prod_count";i:20;s:16:"zhivopis-grafika";a:4:{s:22:"virtuemart_category_id";s:2:"24";s:13:"category_name";s:32:"Живопись, графика";s:5:"alias";s:16:"zhivopis-grafika";s:13:"product_count";s:1:"0";}s:25:"ikony2013-02-12-08-46-42_";a:4:{s:22:"virtuemart_category_id";s:2:"25";s:13:"category_name";s:10:"Иконы";s:5:"alias";s:25:"ikony2013-02-12-08-46-42_";s:13:"product_count";s:1:"4";}s:32:"dekorativno-prikladnoe-iskusstvo";a:4:{s:22:"virtuemart_category_id";s:2:"26";s:13:"category_name";s:62:"Декоративно-прикладное искусство";s:5:"alias";s:32:"dekorativno-prikladnoe-iskusstvo";s:13:"product_count";s:1:"0";}s:25:"yuvelirnye-izdeliya-torgi";a:4:{s:22:"virtuemart_category_id";s:2:"27";s:13:"category_name";s:33:"Ювелирные изделия";s:5:"alias";s:25:"yuvelirnye-izdeliya-torgi";s:13:"product_count";s:2:"16";}s:37:"predmety-interera2013-02-12-08-48-07_";a:4:{s:22:"virtuemart_category_id";s:2:"28";s:13:"category_name";s:35:"Предметы интерьера";s:5:"alias";s:37:"predmety-interera2013-02-12-08-48-07_";s:13:"product_count";s:1:"0";}s:25:"mebel2013-02-12-08-48-30_";a:4:{s:22:"virtuemart_category_id";s:2:"29";s:13:"category_name";s:12:"Мебель";s:5:"alias";s:25:"mebel2013-02-12-08-48-30_";s:13:"product_count";s:1:"0";}s:29:"predmety-kollektsionirovaniya";a:4:{s:22:"virtuemart_category_id";s:2:"30";s:13:"category_name";s:53:"Предметы коллекционирования";s:5:"alias";s:29:"predmety-kollektsionirovaniya";s:13:"product_count";s:1:"0";}}s:4:"shop";a:21:{s:10:"prod_count";i:99;s:31:"русская-живопись";a:4:{s:22:"virtuemart_category_id";s:1:"1";s:13:"category_name";s:31:"Русская живопись";s:5:"alias";s:31:"русская-живопись";s:13:"product_count";s:1:"1";}s:28:"zapadnoevropejskaya-zhivopis";a:4:{s:22:"virtuemart_category_id";s:1:"2";s:13:"category_name";s:53:"Западноевропейская живопись";s:5:"alias";s:28:"zapadnoevropejskaya-zhivopis";s:13:"product_count";s:1:"0";}s:12:"knigi-raznoe";a:4:{s:22:"virtuemart_category_id";s:2:"50";s:13:"category_name";s:24:"Книги, разное";s:5:"alias";s:12:"knigi-raznoe";s:13:"product_count";s:1:"0";}s:14:"marki-otkrytki";a:4:{s:22:"virtuemart_category_id";s:2:"51";s:13:"category_name";s:28:"Марки, открытки";s:5:"alias";s:14:"marki-otkrytki";s:13:"product_count";s:1:"0";}s:19:"sovetskaya-zhivopis";a:4:{s:22:"virtuemart_category_id";s:1:"3";s:13:"category_name";s:35:"Советская живопись";s:5:"alias";s:19:"sovetskaya-zhivopis";s:13:"product_count";s:1:"0";}s:10:"miniatyury";a:4:{s:22:"virtuemart_category_id";s:1:"4";s:13:"category_name";s:18:"Миниатюры";s:5:"alias";s:10:"miniatyury";s:13:"product_count";s:1:"0";}s:5:"ikony";a:4:{s:22:"virtuemart_category_id";s:1:"5";s:13:"category_name";s:10:"Иконы";s:5:"alias";s:5:"ikony";s:13:"product_count";s:1:"2";}s:15:"farfor-keramika";a:4:{s:22:"virtuemart_category_id";s:1:"6";s:13:"category_name";s:30:"Фарфор, керамика";s:5:"alias";s:15:"farfor-keramika";s:13:"product_count";s:2:"45";}s:28:"farfor-keramika-posle-1917-g";a:4:{s:22:"virtuemart_category_id";s:1:"7";s:13:"category_name";s:50:"Фарфор, керамика после 1917 г.";s:5:"alias";s:28:"farfor-keramika-posle-1917-g";s:13:"product_count";s:2:"30";}s:15:"steklo-khrustal";a:4:{s:22:"virtuemart_category_id";s:1:"8";s:13:"category_name";s:30:"Стекло, хрусталь";s:5:"alias";s:15:"steklo-khrustal";s:13:"product_count";s:1:"0";}s:44:"khudozhestvennaya-bronza-chugun-shpiatr-i-pr";a:4:{s:22:"virtuemart_category_id";s:1:"9";s:13:"category_name";s:76:"Художественная бронза, чугун, шпиатр и пр.";s:5:"alias";s:44:"khudozhestvennaya-bronza-chugun-shpiatr-i-pr";s:13:"product_count";s:2:"16";}s:5:"chasy";a:4:{s:22:"virtuemart_category_id";s:2:"10";s:13:"category_name";s:8:"Часы";s:5:"alias";s:5:"chasy";s:13:"product_count";s:1:"5";}s:17:"predmety-interera";a:4:{s:22:"virtuemart_category_id";s:2:"11";s:13:"category_name";s:35:"Предметы интерьера";s:5:"alias";s:17:"predmety-interera";s:13:"product_count";s:1:"0";}s:7:"serebro";a:4:{s:22:"virtuemart_category_id";s:2:"12";s:13:"category_name";s:14:"Серебро";s:5:"alias";s:7:"serebro";s:13:"product_count";s:1:"0";}s:33:"ювелирные-изделия";a:4:{s:22:"virtuemart_category_id";s:2:"13";s:13:"category_name";s:33:"Ювелирные изделия";s:5:"alias";s:33:"ювелирные-изделия";s:13:"product_count";s:1:"0";}s:20:"vostochnoe-iskusstvo";a:4:{s:22:"virtuemart_category_id";s:2:"14";s:13:"category_name";s:37:"Восточное искусство";s:5:"alias";s:20:"vostochnoe-iskusstvo";s:13:"product_count";s:1:"0";}s:14:"karty-gravyury";a:4:{s:22:"virtuemart_category_id";s:2:"16";s:13:"category_name";s:48:"Карты, гравюры, литографии";s:5:"alias";s:14:"karty-gravyury";s:13:"product_count";s:1:"0";}s:5:"mebel";a:4:{s:22:"virtuemart_category_id";s:2:"15";s:13:"category_name";s:12:"Мебель";s:5:"alias";s:5:"mebel";s:13:"product_count";s:1:"0";}s:13:"tkani-prochee";a:4:{s:22:"virtuemart_category_id";s:2:"19";s:13:"category_name";s:27:"Ткани, прочее...";s:5:"alias";s:13:"tkani-prochee";s:13:"product_count";s:1:"0";}s:6:"raznoe";a:4:{s:22:"virtuemart_category_id";s:2:"20";s:13:"category_name";s:12:"Разное";s:5:"alias";s:6:"raznoe";s:13:"product_count";s:1:"0";}}}s:13:"section_links";a:3:{s:6:"online";a:0:{}s:8:"fulltime";a:7:{i:24;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=24&Itemid=126";i:25;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=25&Itemid=126";i:26;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=26&Itemid=126";i:27;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=27&Itemid=126";i:28;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=28&Itemid=126";i:29;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=29&Itemid=126";i:30;s:82:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=30&Itemid=126";}s:4:"shop";a:20:{i:1;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=1&Itemid=115&layout=shop";i:2;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=2&Itemid=115&layout=shop";i:50;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=50&Itemid=115&layout=shop";i:51;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=51&Itemid=115&layout=shop";i:3;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=3&Itemid=115&layout=shop";i:4;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=4&Itemid=115&layout=shop";i:5;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=5&Itemid=115&layout=shop";i:6;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=6&Itemid=115&layout=shop";i:7;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=7&Itemid=115&layout=shop";i:8;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=8&Itemid=115&layout=shop";i:9;s:93:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=9&Itemid=115&layout=shop";i:10;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=10&Itemid=115&layout=shop";i:11;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=11&Itemid=115&layout=shop";i:12;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=12&Itemid=115&layout=shop";i:13;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=13&Itemid=115&layout=shop";i:14;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=14&Itemid=115&layout=shop";i:16;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=16&Itemid=115&layout=shop";i:15;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=15&Itemid=115&layout=shop";i:19;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=19&Itemid=115&layout=shop";i:20;s:94:"index.php?option=com_virtuemart&view=category&virtuemart_category_id=20&Itemid=115&layout=shop";}}}', 368, '200321', '');

-- 
-- Вывод данных для таблицы auc13_template_styles
--
INSERT INTO auc13_template_styles VALUES
(2, 'bluestork', 1, '1', 'Bluestork - Default', '{"useRoundedCorners":"1","showSiteName":"0"}'),
(7, 'auction', 0, '1', 'Auction - По умолчанию', '{}');

-- 
-- Вывод данных для таблицы auc13_update_categories
--

-- Таблица auctionru_2013.auc13_update_categories не содержит данных

-- 
-- Вывод данных для таблицы auc13_update_sites
--
INSERT INTO auc13_update_sites VALUES
(1, 'Joomla Core', 'collection', 'http://update.joomla.org/core/list.xml', 0, 1361134936),
(2, 'Joomla Extension Directory', 'collection', 'http://update.joomla.org/jed/list.xml', 0, 1361134936),
(3, 'Accredited Joomla! Translations', 'collection', 'http://update.joomla.org/language/translationlist.xml', 0, 1361967441),
(5, 'AcyMailing', 'extension', 'http://www.acyba.com/component/updateme/updatexml/component-acymailing/level-Starter/file-extension.xml', 0, 1361810703),
(6, 'JCE Editor Updates', 'extension', 'https://www.joomlacontenteditor.net/index.php?option=com_updates&view=update&format=xml&id=1\n        ', 0, 1360909711),
(7, 'Modules Anywhere', 'extension', 'http://download.nonumber.nl/updates.php?e=modulesanywhere&', 1, 1362406197);

-- 
-- Вывод данных для таблицы auc13_update_sites_extensions
--
INSERT INTO auc13_update_sites_extensions VALUES
(1, 700),
(2, 700),
(3, 600),
(3, 10003),
(5, 10039),
(6, 10057),
(7, 10064),
(7, 10065);

-- 
-- Вывод данных для таблицы auc13_updates
--
INSERT INTO auc13_updates VALUES
(1, 1, 700, 0, 'Joomla', '', 'joomla', 'file', '', 0, '2.5.9', '', 'http://update.joomla.org/core/extension.xml', ''),
(2, 3, 0, 0, 'Armenian', '', 'pkg_hy-AM', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/hy-AM_details.xml', ''),
(3, 3, 0, 0, 'Bahasa Indonesia', '', 'pkg_id-ID', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/id-ID_details.xml', ''),
(4, 3, 0, 0, 'Danish', '', 'pkg_da-DK', 'package', '', 0, '2.5.9.2', '', 'http://update.joomla.org/language/details/da-DK_details.xml', ''),
(5, 3, 0, 0, 'Khmer', '', 'pkg_km-KH', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/km-KH_details.xml', ''),
(6, 3, 0, 0, 'Swedish', '', 'pkg_sv-SE', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/sv-SE_details.xml', ''),
(7, 3, 0, 0, 'Hungarian', '', 'pkg_hu-HU', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/hu-HU_details.xml', ''),
(8, 3, 0, 0, 'Bulgarian', '', 'pkg_bg-BG', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/bg-BG_details.xml', ''),
(9, 3, 0, 0, 'French', '', 'pkg_fr-FR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/fr-FR_details.xml', ''),
(10, 3, 0, 0, 'Italian', '', 'pkg_it-IT', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/it-IT_details.xml', ''),
(11, 3, 0, 0, 'Spanish', '', 'pkg_es-ES', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/es-ES_details.xml', ''),
(12, 3, 0, 0, 'Dutch', '', 'pkg_nl-NL', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/nl-NL_details.xml', ''),
(13, 3, 0, 0, 'Turkish', '', 'pkg_tr-TR', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/tr-TR_details.xml', ''),
(14, 3, 0, 0, 'Ukrainian', '', 'pkg_uk-UA', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/uk-UA_details.xml', ''),
(15, 3, 0, 0, 'Slovak', '', 'pkg_sk-SK', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/sk-SK_details.xml', ''),
(16, 3, 0, 0, 'Belarusian', '', 'pkg_be-BY', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/be-BY_details.xml', ''),
(17, 3, 0, 0, 'Latvian', '', 'pkg_lv-LV', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/lv-LV_details.xml', ''),
(18, 3, 0, 0, 'Estonian', '', 'pkg_et-EE', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/et-EE_details.xml', ''),
(19, 3, 0, 0, 'Romanian', '', 'pkg_ro-RO', 'package', '', 0, '2.5.5.3', '', 'http://update.joomla.org/language/details/ro-RO_details.xml', ''),
(20, 3, 0, 0, 'Flemish', '', 'pkg_nl-BE', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/nl-BE_details.xml', ''),
(21, 3, 0, 0, 'Macedonian', '', 'pkg_mk-MK', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/mk-MK_details.xml', ''),
(22, 3, 0, 0, 'Japanese', '', 'pkg_ja-JP', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/ja-JP_details.xml', ''),
(23, 3, 0, 0, 'Serbian Latin', '', 'pkg_sr-YU', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/sr-YU_details.xml', ''),
(24, 3, 0, 0, 'Arabic Unitag', '', 'pkg_ar-AA', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/ar-AA_details.xml', ''),
(25, 3, 0, 0, 'German', '', 'pkg_de-DE', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/de-DE_details.xml', ''),
(26, 3, 0, 0, 'Norwegian Bokmal', '', 'pkg_nb-NO', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/nb-NO_details.xml', ''),
(27, 3, 0, 0, 'English AU', '', 'pkg_en-AU', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/en-AU_details.xml', ''),
(28, 3, 0, 0, 'English US', '', 'pkg_en-US', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/en-US_details.xml', ''),
(29, 3, 0, 0, 'Serbian Cyrillic', '', 'pkg_sr-RS', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/sr-RS_details.xml', ''),
(30, 3, 0, 0, 'Lithuanian', '', 'pkg_lt-LT', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/lt-LT_details.xml', ''),
(31, 3, 0, 0, 'Albanian', '', 'pkg_sq-AL', 'package', '', 0, '2.5.1.5', '', 'http://update.joomla.org/language/details/sq-AL_details.xml', ''),
(32, 3, 0, 0, 'Persian', '', 'pkg_fa-IR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/fa-IR_details.xml', ''),
(33, 3, 0, 0, 'Galician', '', 'pkg_gl-ES', 'package', '', 0, '2.5.7.4', '', 'http://update.joomla.org/language/details/gl-ES_details.xml', ''),
(34, 3, 0, 0, 'Polish', '', 'pkg_pl-PL', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/pl-PL_details.xml', ''),
(35, 3, 0, 0, 'Syriac', '', 'pkg_sy-IQ', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/sy-IQ_details.xml', ''),
(36, 3, 0, 0, 'Portuguese', '', 'pkg_pt-PT', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/pt-PT_details.xml', ''),
(37, 3, 0, 0, 'Hebrew', '', 'pkg_he-IL', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/he-IL_details.xml', ''),
(38, 3, 0, 0, 'Catalan', '', 'pkg_ca-ES', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/ca-ES_details.xml', ''),
(39, 3, 0, 0, 'Laotian', '', 'pkg_lo-LA', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/lo-LA_details.xml', ''),
(40, 3, 0, 0, 'Afrikaans', '', 'pkg_af-ZA', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/af-ZA_details.xml', ''),
(41, 3, 0, 0, 'Chinese Simplified', '', 'pkg_zh-CN', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/zh-CN_details.xml', ''),
(42, 3, 0, 0, 'Greek', '', 'pkg_el-GR', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/el-GR_details.xml', ''),
(43, 3, 0, 0, 'Esperanto', '', 'pkg_eo-XX', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/eo-XX_details.xml', ''),
(44, 3, 0, 0, 'Finnish', '', 'pkg_fi-FI', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/fi-FI_details.xml', ''),
(45, 3, 0, 0, 'Portuguese Brazil', '', 'pkg_pt-BR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/pt-BR_details.xml', ''),
(46, 3, 0, 0, 'Chinese Traditional', '', 'pkg_zh-TW', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/zh-TW_details.xml', ''),
(47, 3, 0, 0, 'Vietnamese', '', 'pkg_vi-VN', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/vi-VN_details.xml', ''),
(48, 3, 0, 0, 'Kurdish Sorani', '', 'pkg_ckb-IQ', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/ckb-IQ_details.xml', ''),
(49, 3, 0, 0, 'Bosnian', '', 'pkg_bs-BA', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/bs-BA_details.xml', ''),
(50, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(51, 3, 0, 0, 'Azeri', '', 'pkg_az-AZ', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/az-AZ_details.xml', ''),
(52, 3, 0, 0, 'Norwegian Nynorsk', '', 'pkg_nn-NO', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/nn-NO_details.xml', ''),
(53, 3, 0, 0, 'Tamil India', '', 'pkg_ta-IN', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/ta-IN_details.xml', ''),
(54, 3, 0, 0, 'Scottish Gaelic', '', 'pkg_gd-GB', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/gd-GB_details.xml', ''),
(55, 3, 0, 0, 'Thai', '', 'pkg_th-TH', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/th-TH_details.xml', ''),
(56, 3, 0, 0, 'Basque', '', 'pkg_eu-ES', 'package', '', 0, '1.7.0.1', '', 'http://update.joomla.org/language/details/eu-ES_details.xml', ''),
(57, 3, 0, 0, 'Uyghur', '', 'pkg_ug-CN', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/ug-CN_details.xml', ''),
(58, 3, 0, 0, 'Korean', '', 'pkg_ko-KR', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/ko-KR_details.xml', ''),
(59, 3, 0, 0, 'Hindi', '', 'pkg_hi-IN', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/hi-IN_details.xml', ''),
(60, 3, 0, 0, 'Welsh', '', 'pkg_cy-GB', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/cy-GB_details.xml', ''),
(61, 3, 0, 0, 'Swahili', '', 'pkg_sw-KE', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/sw-KE_details.xml', ''),
(62, 7, 0, 0, 'Modules Anywhere', '', 'modulesanywhere', 'plugin', 'system', 1, '3.2.2FREE', '', 'http://download.nonumber.nl/updates.php?e=modulesanywhere&/extension.xml', 'http://www.nonumber.nl/extensions/modulesanywhere#download'),
(63, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(64, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(65, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(66, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(67, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(68, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(69, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(70, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(71, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(72, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(73, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(74, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(75, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(76, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(77, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(78, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(79, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(80, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(81, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.9.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', '');

-- 
-- Вывод данных для таблицы auc13_user_notes
--

-- Таблица auctionru_2013.auc13_user_notes не содержит данных

-- 
-- Вывод данных для таблицы auc13_user_profiles
--
INSERT INTO auc13_user_profiles VALUES
(368, 'profile.favoritebook', '""', 9),
(368, 'profile.website', '""', 8),
(368, 'profile.phone', '""', 7),
(368, 'profile.postal_code', '""', 6),
(368, 'profile.country', '""', 5),
(368, 'profile.region', '""', 4),
(368, 'profile.city', '""', 3),
(368, 'profile.address2', '""', 2),
(368, 'profile.address1', '""', 1),
(368, 'profile.aboutme', '""', 10),
(368, 'profile.dob', '""', 11);

-- 
-- Вывод данных для таблицы auc13_user_usergroup_map
--
INSERT INTO auc13_user_usergroup_map VALUES
(107, 8),
(108, 2),
(109, 2),
(110, 2),
(111, 2),
(112, 2),
(113, 2),
(114, 2),
(115, 2),
(116, 2),
(117, 2),
(118, 2),
(119, 2),
(120, 2),
(121, 2),
(122, 2),
(123, 2),
(124, 2),
(125, 2),
(126, 2),
(127, 2),
(128, 2),
(129, 2),
(130, 2),
(131, 2),
(132, 2),
(133, 2),
(134, 2),
(135, 2),
(136, 2),
(137, 2),
(138, 2),
(139, 2),
(140, 2),
(141, 2),
(142, 2),
(143, 2),
(144, 2),
(145, 2),
(146, 2),
(147, 2),
(148, 2),
(149, 2),
(150, 2),
(151, 2),
(152, 2),
(153, 2),
(154, 2),
(155, 2),
(156, 2),
(157, 2),
(158, 2),
(159, 2),
(160, 2),
(161, 2),
(162, 2),
(163, 2),
(164, 2),
(165, 2),
(166, 2),
(167, 2),
(168, 2),
(169, 2),
(170, 2),
(171, 2),
(172, 2),
(173, 2),
(174, 2),
(175, 2),
(176, 2),
(177, 2),
(178, 2),
(179, 2),
(180, 2),
(181, 2),
(182, 2),
(183, 2),
(184, 2),
(185, 2),
(186, 2),
(187, 2),
(188, 2),
(189, 2),
(190, 2),
(191, 2),
(192, 2),
(193, 2),
(194, 2),
(195, 2),
(196, 2),
(197, 2),
(198, 2),
(199, 2),
(200, 2),
(201, 2),
(202, 2),
(203, 2),
(204, 2),
(205, 2),
(206, 2),
(207, 2),
(208, 2),
(209, 2),
(210, 2),
(211, 2),
(212, 2),
(213, 2),
(214, 2),
(215, 2),
(216, 2),
(217, 2),
(218, 2),
(219, 2),
(220, 2),
(221, 2),
(222, 2),
(223, 2),
(224, 2),
(225, 2),
(226, 2),
(227, 2),
(228, 2),
(229, 2),
(230, 2),
(231, 2),
(232, 2),
(233, 2),
(234, 2),
(235, 2),
(236, 2),
(237, 2),
(238, 2),
(239, 2),
(240, 2),
(241, 2),
(242, 2),
(243, 2),
(244, 2),
(245, 2),
(246, 2),
(247, 2),
(248, 2),
(249, 2),
(250, 2),
(251, 2),
(252, 2),
(253, 2),
(254, 2),
(255, 2),
(256, 2),
(257, 2),
(258, 2),
(259, 2),
(260, 2),
(261, 2),
(262, 2),
(263, 2),
(264, 2),
(265, 2),
(266, 2),
(267, 2),
(268, 2),
(269, 2),
(270, 2),
(271, 2),
(272, 2),
(273, 2),
(274, 2),
(275, 2),
(276, 2),
(277, 2),
(278, 2),
(279, 2),
(280, 2),
(281, 2),
(282, 2),
(283, 2),
(284, 2),
(285, 2),
(286, 2),
(287, 2),
(288, 2),
(289, 2),
(290, 2),
(291, 2),
(292, 2),
(293, 2),
(294, 2),
(295, 2),
(296, 2),
(297, 2),
(298, 2),
(299, 2),
(300, 2),
(301, 2),
(302, 2),
(303, 2),
(304, 2),
(305, 2),
(306, 2),
(307, 2),
(308, 2),
(309, 2),
(310, 2),
(311, 2),
(312, 2),
(313, 2),
(314, 2),
(315, 2),
(316, 2),
(317, 2),
(318, 2),
(319, 2),
(320, 2),
(321, 2),
(322, 2),
(323, 2),
(324, 2),
(325, 2),
(326, 2),
(327, 2),
(328, 2),
(329, 2),
(330, 2),
(331, 2),
(332, 2),
(333, 2),
(334, 2),
(335, 2),
(336, 2),
(337, 2),
(338, 2),
(339, 2),
(340, 2),
(341, 2),
(342, 2),
(343, 2),
(344, 2),
(345, 2),
(346, 2),
(347, 2),
(348, 2),
(349, 2),
(350, 2),
(351, 2),
(352, 2),
(353, 2),
(354, 2),
(355, 2),
(356, 2),
(357, 2),
(358, 2),
(359, 2),
(360, 2),
(366, 2),
(367, 2),
(368, 2);

-- 
-- Вывод данных для таблицы auc13_usergroups
--
INSERT INTO auc13_usergroups VALUES
(1, 0, 1, 20, 'Public'),
(2, 1, 6, 17, 'Registered'),
(3, 2, 7, 14, 'Author'),
(4, 3, 8, 11, 'Editor'),
(5, 4, 9, 10, 'Publisher'),
(6, 1, 2, 5, 'Manager'),
(7, 6, 3, 4, 'Administrator'),
(8, 1, 18, 19, 'Super Users');

-- 
-- Вывод данных для таблицы auc13_users
--
INSERT INTO auc13_users VALUES
(107, 'Super User', '', '', 'admin', 'srgg140201@yandex.ru', '49f2083d29533d56ddfae7475b70433f:v4cwrQxhvvgB7dgsn95VF7Hj8UmlIKqq', 'deprecated', 0, 1, '2013-02-01 08:41:18', '2013-03-04 14:09:51', '', 0, '', '', '', '', '', '', '', '', '0', '{}', '0000-00-00 00:00:00', 0),
(246, 'Анна', 'Георгиевна', 'Колесникова', '100129', 'kolesnikova_a@sumail.ru', '374b3184e2cffb5fed25c811fbc2ce55:mND07eq9Gfkr2XMp7dgPSLGPlXjxTQdq', '', 0, 1, '2010-09-30 10:54:30', '0000-00-00 00:00:00', '', 0, '119285', 'Москва', 'Пырьева', '2', '', '3', '89067984004', '', '', '{}', '0000-00-00 00:00:00', 0),
(245, 'Максим', 'Александрович', 'Аверин', '100128', 'averin88@mail.ru', 'e070ef36144b51a6513831d913d42466:prFRCu11a5yLmOlQVu20oLTCE8UvWZWS', '', 0, 1, '2010-09-30 10:50:28', '0000-00-00 00:00:00', '-', 0, '109472', 'Москва', 'Чугунные ворота', '21', '4', '80', '8-916-515-01-88', '-', '', '{}', '0000-00-00 00:00:00', 0),
(244, 'Ирина', 'Юрьевна', 'Пушкова', '100127', 'irpush@mail.ru', '11d7f5a10d4bb97be27229250b336c02:4x5FyXi8WdAz9dnY0Vl6OkWnqoacGqsu', '', 0, 1, '2010-09-29 21:43:48', '0000-00-00 00:00:00', '', 0, '403686', 'Камышин', '6 микрорайон', '3', '', '70', '+7 927 5245915', '', '', '{}', '0000-00-00 00:00:00', 0),
(243, 'Геннадий', 'Николаевич', 'Корабельников', '100126', 'korger@mail.ru', 'c3ca6661cb441647764adb6dd99a53d3:pakgjsBsliScV6MSPJWZuB8eRysLdtRZ', '', 0, 1, '2010-09-29 18:36:44', '0000-00-00 00:00:00', '', 0, '199397', 'Санкт-Петербург', 'Беринга', '256', '', '543', '+79507414022', '+92127734042', '', '{}', '0000-00-00 00:00:00', 0),
(242, 'Олег', 'Владимирович', 'Панкратьев', '100125', 'opank@mail.ru', 'fbf3511b9d9f3ce3f9c9590b67768499:9LOOSa113e1syrJSMEnyJ0nUkUW5JVYt', '', 0, 1, '2010-09-29 16:40:35', '0000-00-00 00:00:00', '', 0, '105094', 'Москва', 'Госпитальный вал', '5', '7а', '51', '+7 926 229 73 23', '', '', '{}', '0000-00-00 00:00:00', 0),
(241, 'Александр', 'Александрович', 'Бакланов', '100124', 'agasfer1967@yandex.ru', 'e7f588fa5c418d563aeaf564feca0238:OhRd3dYOrtR9yj29honj66q35ocGsXZR', '', 0, 1, '2010-09-29 13:26:54', '0000-00-00 00:00:00', '', 0, '454020', 'Челябинск', 'Воровского', '26А', '', '37', '7 951 4738967', '', '', '{}', '0000-00-00 00:00:00', 0),
(240, 'Геннадий', 'Леонидович', 'Бабич', '100123', 'queen3006@yandex.ru', '491a42e62a0e9d2c4fa87476a5fd1c56:AEoNJKRUHVHXPEm0AL2FHjdxTDsxDqmb', '', 0, 1, '2010-09-29 11:49:42', '0000-00-00 00:00:00', '', 0, '111524', 'Mосква', 'Мастеровая', '11', 'а', '20', '8926330009', '6190686', '', '{}', '0000-00-00 00:00:00', 0),
(239, 'Анна', '', 'Орлова', '100122', 'delo11@rambler.ru', '593759047d4e25d7ce8eb44799eb37ae:GxCxe01c9snnIfqtT5titaI5MkcoulHO', '', 0, 1, '2010-09-29 01:19:39', '0000-00-00 00:00:00', '', 0, '191104', 'Санкт-Петербург', 'Марата', '77', '', '40', '+7 921 000 00 00', '', '', '{}', '0000-00-00 00:00:00', 0),
(238, 'Никита', 'Владимирович', 'Костригин', '100121', 'nikita-kostrigin@mail.ru', '269f7514ebdd76bac5cc8f73bf97ca9a:2BY3JxRJseKOreuuKsBSjnJI3bEBkmTT', '', 0, 1, '2010-09-28 23:44:41', '0000-00-00 00:00:00', '', 0, '123576', 'Санкт-Петербург', 'Стремянная', '2', '', '7', '89219636407', '89219636407', '', '{}', '0000-00-00 00:00:00', 0),
(237, 'Андрей', 'Юрьевич', 'Симоненко', '100119', 'boss555@land.ru', 'b23e35f7c8f9b6aa15f7a1f73877f8bf:JGQUoxF1TIW82rBxtrhjVvNchoNIZVrR', '', 0, 1, '2010-09-28 12:21:08', '0000-00-00 00:00:00', '', 0, '192286', 'Санкт-Петербург', 'Будапештская', '62', '', '74', '8 812 701-29-37', '', '', '{}', '0000-00-00 00:00:00', 0),
(236, 'Наталия', 'Михайловна', 'Дагич', '100117', 'iedvin@yandex.ru', 'fa1a381844b4de4943d7bb704ed1e84f:49RINbxPQos2uZUmRtMcqdH6EPGTdsos', '', 0, 1, '2010-09-28 12:04:14', '0000-00-00 00:00:00', '', 0, '109117', 'Москва', 'Окская', '2\\15', '1', '43', '7 916 182 45 47', '', '', '{}', '0000-00-00 00:00:00', 0),
(235, 'Светлана ', '', 'Попова ', '100118', 'svetlana-p20@yandex.ru', '189543c8b9e74878065ae0a62bb6164e:0t7OZKlzx8Xy56iIOr51gju3yUTB3dHe', '', 0, 1, '2010-09-27 15:56:57', '0000-00-00 00:00:00', '', 0, '190000', 'Санкт-Петербург, Сестрорецк, пос.Горская ', 'Алексеевская', '7', '', '0', '+7 921 9134805', '', '', '{}', '0000-00-00 00:00:00', 0),
(234, 'Сергей', '', 'Кожухарь', '100115', 'k-c-c@bk.ru', 'c64d156ac53f0655e692940e5fdf97be:nj2BVqxTJbQZcPAhPSwwqXSeCoCdxODY', '', 0, 1, '2010-09-26 20:23:33', '0000-00-00 00:00:00', '', 0, '127410', 'Москва', 'Инженерная', '8', 'а', '44', '+7 499 9016625', '+7 495 7652025', '', '{}', '0000-00-00 00:00:00', 0),
(233, 'Дмитрий', '', 'Кожемякин', '100114', 'dmitryko83@rambler.ru', '87f2fa9abfca1d83c56e20e44589d5a1:o7F9jo6yoJ1kdwxqc2jIJxKKoSzJJoKR', '', 0, 1, '2010-09-26 17:24:09', '0000-00-00 00:00:00', '', 0, '117624', 'Москва', 'Скобелевская', '40', '', '75', '+7 915 1820462', '', '', '{}', '0000-00-00 00:00:00', 0),
(232, 'Иван', 'Николаевич', 'Твердюков', '100113', 'ivantvspb@mail.ru', '6556117397639bb3c1a0f99b959f865f:Wl6akTsAAUrpZlYxwqvhpNcEhLTeZELR', '', 0, 1, '2010-09-25 22:26:04', '2013-03-01 17:58:17', '', 0, '196128', 'Санкт-Петербург', 'Кузнецовская', '30', '', '71', '+7 921 9365128', '', '', '{}', '0000-00-00 00:00:00', 0),
(231, 'Сергей', 'Георгиевич', 'Мамай', '100112', 'mahagon2001@mail.ru', '9d6294fb9e840c1eaa265e6e60c204b1:ZD7cjKWGrXxkDg7ayCln0Jb5FbBnFejI', '', 0, 1, '2010-09-25 14:51:30', '0000-00-00 00:00:00', '', 0, '191028', 'Санкт-Петербург', 'наб. Фонтанки', '24', '', '1', '+79219337762', '', '', '{}', '0000-00-00 00:00:00', 0),
(230, 'Александр', '', 'Рогава', '100110', 'alexro66@mail.ru', '941bf3358cc2bcd1c0ef183c173c0fa8:IeWiM75oCe5j2BLoSH0xPaV2c8CK97d5', '', 0, 1, '2010-09-25 11:20:54', '0000-00-00 00:00:00', '', 0, '107370', 'Москва', 'Маршала  Рокосовского', '3', '', '26', '+7 985 2336167', '', '', '{}', '0000-00-00 00:00:00', 0),
(229, 'Николай', 'Викторович', 'Коншин', '100111', 'n_konshin@mail.ru', '23fe4ab607b04557799953b4f8be03cd:pZzQmMu9AOQR7ZzElfPfuU8ojh7LEqJ5', '', 0, 1, '2010-09-25 10:53:33', '0000-00-00 00:00:00', '', 0, '199178', 'Петербург', '15 линия', '38', '', '27', '+7 921 9400092', '', '', '{}', '0000-00-00 00:00:00', 0),
(228, 'Юлия', '', 'Вергунова', '100109', 'rozzet@mail.ru', 'cf2eb3ffdf77377f6e526f65070d8849:QyeAvUOgDcxBrbIvci2W2APZTpDCHfd5', '', 0, 1, '2010-09-24 16:39:54', '0000-00-00 00:00:00', '', 0, '188540', 'Сосновый Бор', 'Парковая', '40', '', '9', '+7 921 7416674', '', '', '{}', '0000-00-00 00:00:00', 0),
(227, 'Наталия', 'Евгеньевна', 'Алхазян', '100108', 'andalh@yandex.ru', 'c9b7f6b848350c83d9a7fd163aeb16f0:4Qc7Kpp4C545Q5H0Q01xIqs5q475gRqf', '', 0, 1, '2010-09-23 19:54:35', '0000-00-00 00:00:00', '', 0, '117042', 'Москва', 'Чечерский проезд', '88', '-', '109', '89099136222', '89261949159', '', '{}', '0000-00-00 00:00:00', 0),
(226, 'Елена', 'Викторовна', 'Варапаева', '100107', 'varlena79@mail.ru', '391f10d8a38b05bceecac7cdb2ec9e48:nOicAJ3GKJYwrM3KX4tMJPuuhBLg1XrV', '', 0, 1, '2010-09-23 11:34:04', '0000-00-00 00:00:00', 'ООО', 0, '630099', 'Новосибирск', 'Максима Горького', '12', '', '45', '7 383 2103762', '7 913 9295533', '', '{}', '0000-00-00 00:00:00', 0),
(225, 'Екатерина', 'Анатольевна', 'Румянцева', '100106', 'ksin@yandex.ru', '07061306c7b0ba9e88904809a74bf547:wuSOdznJviz6CQz5W8lr6hRTAt9cv5TB', '', 0, 1, '2010-09-22 19:14:24', '0000-00-00 00:00:00', 'Русские сезоны', 0, '197101', 'Санкт-Петербург', 'Б. Монетная', '10', '', '1', '+79217782354', '', '', '{}', '0000-00-00 00:00:00', 0),
(223, 'Владимир ', '', 'Ким', '100101', 'kimvol@mail.ru', '0b692d2ca4b2caaab7290770e5ba9a64:qMfTdKNmQVYW9UYJIW4ePimFQBISOeN5', '', 0, 1, '2010-09-22 15:10:10', '0000-00-00 00:00:00', '', 0, '190068', 'Санкт-Петербург', 'Вознесенский пр.', '34', '', '15', '7 812 3102937', '', '', '{}', '0000-00-00 00:00:00', 0),
(224, 'Светлана', '', 'Ворожбина', '100105', 'Senya-66@mail.ru', 'ea7854c39f8206ad62e6957118a1b041:DQY6LWIiVEjLP3lo6NnJMTKIXTm2g3aX', '', 0, 1, '2010-09-22 16:42:04', '0000-00-00 00:00:00', '', 0, '198305', 'Санкт-Петербург', 'Композиторов', '10', '', '121', '+79219150137', '', '', '{}', '0000-00-00 00:00:00', 0),
(222, 'Юрий', 'Михайлович', 'Васин', '100102', 'ivan6732@yandex.ru', '378e895ac54c219f98b1ca263ebe8a95:pGY2hwbf0PCMsF7kMwdFGMqeMWPrr8eg', '', 0, 1, '2010-09-22 12:32:07', '0000-00-00 00:00:00', 'ИП', 0, '141078', 'Королев', 'пр. Королева', '3г', '', '9', '+79265744028', '', '', '{}', '0000-00-00 00:00:00', 0),
(221, 'Сергей', 'Александрович', 'Губарев', '100103', 'russtil@bk.ru', '7d4d586176708fa2e630956e3811632d:GEsV1vxyoE3HHbtnROaNsHtmOm4MA8Pb', '', 0, 1, '2010-09-22 12:19:20', '0000-00-00 00:00:00', '', 0, '191011', 'Санкт-Петербург', 'Итальянская', '29', '', 'пом. 8-Н', ' 7 921 9672626', '', '', '{}', '0000-00-00 00:00:00', 0),
(220, 'Борис', '', 'Горбунов', '100100', 'borisgba@mail.ru', '183ef3e0ddf314ab2bc3a63f8dbefbb0:L32vEaGppsiXfUc4iRUadks9AdXp42qk', '', 0, 1, '2010-09-21 23:37:11', '0000-00-00 00:00:00', '', 0, '196066', 'СПб', 'Авиационная', '11', '', '181', '943-38-88', '', '', '{}', '0000-00-00 00:00:00', 0),
(219, 'Антон', 'Константинович', 'Круглов', '100099', 'cru555ader@mail.ru', '13f52f99041b695264a2225f3a6e35c0:W0bqw87GYag2RWN1dVqBYCszmGuNUPT3', '', 0, 1, '2010-09-21 23:21:29', '0000-00-00 00:00:00', '', 0, '197136', 'С-Петербург', 'Подрезова', '21', '', '32', '+79219640335', '', '', '{}', '0000-00-00 00:00:00', 0),
(218, 'Андрей', 'Игоревич', 'Козицкий', '100098', 'aksenia2006@yandex.ru', '520c3159022be7727545902d1f365d6b:L4D7WS0IKJsu4WaZR7iwck1CpJRikCRE', '', 0, 1, '2010-09-21 17:46:11', '0000-00-00 00:00:00', '', 0, '194100', 'Санкт-Петербург', 'Лесной пр.', '37', '3', '153', '+79013701155', '', '', '{}', '0000-00-00 00:00:00', 0),
(217, 'Кира', '', 'Ф', '100097', 'kira-fomina@yandex.ru', 'df8b938cf7ec9687da7f31359672c0f4:SDqUjp0mRN2uNLyzYYFQuomvaaJZ1ypK', '', 0, 1, '2010-09-21 16:20:28', '0000-00-00 00:00:00', '', 0, '117036', 'Москва', 'ул. Дм. Ульянова', '24', '', '25', '+7 903 291 79 39', '', '', '{}', '0000-00-00 00:00:00', 0),
(216, 'Елена', 'Вадимовна', 'Кельнер', '100096', 'elenakelner@yandex.ru', 'd98f2c15ec99d1e7a452f335c6901b12:YGYDCGm6UmypIGcebMnO1X52KFmZy7fi', '', 0, 1, '2010-09-21 16:15:13', '0000-00-00 00:00:00', '', 0, '195232', 'Санкт-Петербург', 'Стахановцев', '4', 'А', '54', '+7 921 9958806', '', '', '{}', '0000-00-00 00:00:00', 0),
(215, 'Екатерина', '', 'Савчук', '100095', 'katerinas_k@mail.ru', '2e1baf00e1dc69f302383b5a43116452:QyAwvwC2KAGyBh5eAHi5Cnaak4iCsdOb', '', 0, 1, '2010-09-20 17:28:13', '0000-00-00 00:00:00', '', 0, '121596', 'Москва', 'Толбухина', '7', '', '95', '+7 916 2657660', '', '', '{}', '0000-00-00 00:00:00', 0),
(214, 'Иван', 'Сергеевич', 'Павлов', '100094', 'ispav@rambler.ru', '4a83c215dad390cd9b555c2024eec472:l3LnO2UmXhU1bcRq4vPHJ0LHy6Fr4BRl', '', 0, 1, '2010-09-20 15:04:46', '0000-00-00 00:00:00', '', 0, '127572', 'Москва', 'Новгородская', '36', '', '86', '+79859914377', '+79055155045', '', '{}', '0000-00-00 00:00:00', 0),
(213, 'Дина', '', 'Беркут', '100093', 'Blanche-Dubois@yandex.ru', '4d538179b117d769300d38dbe95c8f9f:QsTvPWReqtXYe9hcf4kpiFxfNNlAWHHV', '', 0, 1, '2010-09-18 16:37:04', '0000-00-00 00:00:00', '', 0, '129515', 'Москва', '000000000000000000000000000000000', '00000000000000000000000', '', '000000000000000000000000000', '8-915-247-86-92', '', '', '{}', '0000-00-00 00:00:00', 0),
(212, 'Алексей', 'Игоревич', 'Пакин', '100091', 'potrer@tumen.ru', '0dfdc197bdc0bb7acd99f3263582eca8:JJmauCWYzzxWmW4VopcrRaRTuEGxTH3F', '', 0, 1, '2010-09-16 11:28:50', '0000-00-00 00:00:00', '', 0, '644001', 'Тюмень', 'Болотникова', '12', '', '55', '+7 3452 464309', '+7 9077 758587', '', '{}', '0000-00-00 00:00:00', 0),
(211, 'Михаил', 'Владимирович', 'Шмелькин', '100090', 'antikvarmebel@mail.ru', '03dd6bc4bb51dd0e721a8c88997ce460:21pjIprrdVpztJYR4kkuOODO8FVnXMLk', '', 0, 1, '2010-09-16 00:53:05', '0000-00-00 00:00:00', 'АнтикварМебель', 0, '123001', 'Москва', 'Трехпрудный переулок', '11/13', '', '66', '+7(926)021-07-42', '+7(926)859-84-05', '', '{}', '0000-00-00 00:00:00', 0),
(210, 'Андрей', 'Юрьевич', 'Баглаев', '100089', 'baglaj@mail.ru', '482cb4af5bdb0f2f843f712408c7cf75:64X5eBg8Zsxn5pKReUzDtRAAyiWFKL32', '', 0, 1, '2010-09-15 17:36:39', '0000-00-00 00:00:00', 'ООО,Уфахимтрейд', 0, '450061', 'Уфа', 'Свободы', '6', '', '19', '79174007848', '', '', '{}', '0000-00-00 00:00:00', 0),
(209, 'Александр', 'Владимирович', 'Игонин', '100088', 'sshhenn@yandex.ru', '510ddb39ef90ce3d7d00e15f259d0308:9C9ReRJoaykUpuytnzsc6x1onbulXE4F', '', 0, 1, '2010-09-15 14:52:12', '2013-02-28 16:27:56', '', 0, '603045', 'Нижний Новгород', 'Белинского', '11/2', '', '3', '+7 921 0145121', '+7 821 4323470', '', '{}', '0000-00-00 00:00:00', 0),
(208, 'Екатерина', 'Робертовна', 'Рождественская', '100087', '7535611@mail.ru', 'a0aba386bbcebd7cc475bea867f00596:GzCbtUC9pK78y97A14nF4LvihKk4ahZF', '', 0, 1, '2010-09-14 12:18:11', '0000-00-00 00:00:00', '', 0, '555555', 'Москва', 'Московский пр.', '1н', '', '0', '+7 982 7656932', '', '', '{}', '0000-00-00 00:00:00', 0),
(207, 'Илья', '', 'Разумовский', '100086', 'demak-antik@yandex.ru', '1ccb258530eb6f22a325af1b30bf9d82:qwBU1PAiN0hLRY5FmLI1eXzK66QVnEEb', '', 0, 1, '2010-09-14 12:10:24', '0000-00-00 00:00:00', 'ооо"демак"', 0, '191028', 'Санкт-петербург', 'Моховая', '31', '', '11', '+7 921 9481330', '', '', '{}', '0000-00-00 00:00:00', 0),
(206, 'Алексей', 'Александрович', 'Сапцов', '100083', 'sapt@mail.ru', '4dfdfb8233e5e27fbf044bba78ce83ed:TEhRSU7FfTloDomjpUK7DWqq3KHx2xKI', '', 0, 1, '2010-09-13 19:33:01', '0000-00-00 00:00:00', '', 0, '127273', 'Москва', 'Березовая аллея', '5', '', '96', '+7 916 5501000', '', '', '{}', '0000-00-00 00:00:00', 0),
(205, 'Евгений', 'Николаевич', 'Золотарев', '100085', 'zolotarevkras@mail.ru', 'e2cbbe187328e0a9bacf619d9fd62532:GZlHfIxYhq2WjjaXeFi1TWzBFwLkp1nJ', '', 0, 1, '2010-09-13 18:47:55', '0000-00-00 00:00:00', '', 0, '660049', 'Красноярск', 'К. Маркса', '49', '', '124', '2 400 444', '', '', '{}', '0000-00-00 00:00:00', 0),
(204, 'Денис', 'Николаевич', 'Малахов', '100084', 'Gutenberg-2@yandex.ru', 'fbf81ad753705cbcd77147d4e43ab994:Y5wwLioWTtq72a2qa3b5lvVFaC7CCNrc', '', 0, 1, '2010-09-13 16:35:44', '2013-03-01 15:55:11', '', 0, '194223', 'Санкт-Петербург', 'Светлановский пр.', '43', '', '3', '8 921 8566897', '', '', '{}', '0000-00-00 00:00:00', 0),
(203, 'Александр', '', 'Губанов', '100081', 'flypiter@yandex.ru', '7b6669cc8933191bb8599d83bcb010bd:deLs2q8m36QQDUT0nDhrZ7W381vkZmHI', '', 0, 1, '2010-09-13 16:06:05', '0000-00-00 00:00:00', '', 0, '199106', 'Санкт-Петербург', 'Наличная', '3', '', '55', '+7 921 3040086', '', '', '{}', '0000-00-00 00:00:00', 0),
(202, 'Казанцев', 'Гаврилович', 'Станислав', '100082', 'bookseller@yandex.ru', '61baff5768b1ff4cc7ffa13e32a1fcc6:68I1wU9Q3aKqARs1kYz5OjvJo4MuC0yN', '', 0, 1, '2010-09-13 11:39:46', '0000-00-00 00:00:00', 'КовчегЪ', 0, '121059', 'Москва', 'Набережная Тараса Шевченко', '3', '1', '1', '8 916 4454190', '8 981 8107992', '', '{}', '0000-00-00 00:00:00', 0),
(247, 'Андрей', 'Николаевич', 'Кокарев', '100130', 'akvip@mail.ru', '6e01b9c18f631d7e519cf2a5e480eab9:9NdRzE2iIYTFsweX9JwAKgPcBDMDtqR8', '', 0, 1, '2010-09-30 14:20:14', '0000-00-00 00:00:00', '', 0, '127522', 'Москва', 'Ленинградский проспект', '11', '', 'офис', '+7 962 2302121', '', '', '{}', '0000-00-00 00:00:00', 0),
(248, 'Александр', 'Витальевич', 'Новиков', '100131', 'lexx-sib@mail.ru', '2d43095afe847231ba86763f513ce520:genuNvXyC0H8KjlSAC791vYrwWu7uksH', '', 0, 1, '2010-10-01 16:06:40', '0000-00-00 00:00:00', '', 0, '630004', 'Новосибирск', 'Вокзальная магистраль', '3', '', '112', '+7 913 9118306', '', '', '{}', '0000-00-00 00:00:00', 0),
(249, 'Ирина', '', 'Кудряшова', '100132', 'Antic.07@mail.ru', 'b249f1ef5d8068b2abee320567264182:kxNgAdUzLNd53q02ZnVkOYiYmuBhf4UJ', '', 0, 1, '2010-10-06 12:46:25', '0000-00-00 00:00:00', '', 0, '197136', 'Петербург', 'ул.Ленина', 'д.18', '', 'кв.54', '+7 921 4246981', '', '', '{}', '0000-00-00 00:00:00', 0),
(250, 'Илья', '', 'Назмутдинов', '100134', 'vexmail@mail.com', 'c29fc62d9880c41bf2e369554dfc8bcc:Fxq8BEI6fgfC1ICDgax3afssH7yI9my1', '', 0, 1, '2010-10-15 19:59:23', '0000-00-00 00:00:00', '', 0, '195257', 'Санкт-Петербург', 'Вавиловых', '7', '2', '1', '+7 921 7530371', '', '', '{}', '0000-00-00 00:00:00', 0),
(251, 'Нелля', 'Борисовна', 'Субботина', '100135', 'vesatt@aaa.net', '6c9895524b551c89fb8f5005e109f023:deuofaKkUFHAW0TEFSaZUxmIQiiLReVq', '', 0, 1, '2010-11-03 16:26:41', '0000-00-00 00:00:00', '', 0, '344022', 'Ростов-на-дону', 'Пушкинская', '241/72', '', '14', '+7 918 5555235', '', '', '{}', '0000-00-00 00:00:00', 0),
(252, 'Сергей', 'Юрьевич', 'Кононенко', '100136', 'kononenko_sochi@mail.ru', 'a0f465a824da73ae5bbb59ec16aaf85b:dFOTp4hbU3756UH1VA641t89J62wgE55', '', 0, 1, '2010-11-03 16:37:10', '0000-00-00 00:00:00', '', 0, '354000', 'Сочи', 'Роз', '14', '', '58', '+7 988 2373635', '', '', '{}', '0000-00-00 00:00:00', 0),
(253, 'Иван', 'Сергеевич', 'Бутаков', '100137', 'olgin-hussar@yandex.ru', 'a64656d86c9937c72f823f56fd270ed4:qJSXN58exllFcNyAvIxs1jHybkRZmbzs', '', 0, 1, '2010-11-16 13:04:51', '0000-00-00 00:00:00', '', 0, '664047', 'Иркутск', 'Партизанская', '67', '', '9', '+79501416331', '', '', '{}', '0000-00-00 00:00:00', 0),
(254, 'Максим', '', 'Бедарев', '100138', 'mbedarev@gmail.com', '53eb7c05ed3f1a8678bd799d252a4209:8e5E6xTtm7qMTUbgKy3hOGIPyBnnDLyQ', '', 0, 1, '2010-11-16 13:09:39', '0000-00-00 00:00:00', '', 0, '630009', 'Новосибирск', 'Никитина', '2/1', '', '67', '+7 923 2279141', '', '', '{}', '0000-00-00 00:00:00', 0),
(255, 'Павел', '', 'Беленко', '100141', 'pavelwhite.71@mail.ru', '7b54f65fb1559f9bfd5501d0d6b2409a:VGCbUAzbWH1ifYWmaIz9w5YPCmbfe8EM', '', 0, 1, '2010-11-22 12:10:04', '0000-00-00 00:00:00', '', 0, '117278', 'Москва', 'Голубинская', '25', '', '116', '+79166975184', '', '', '{}', '0000-00-00 00:00:00', 0),
(256, 'Мария', '', 'Мартьянова', '100139', 'progetto@mail.ru', '6ee29894de9232f73d01db43d153e850:6bArNcHqHBWE9sHDlkOkpakmHMDRm93Q', '', 0, 1, '2010-11-22 13:08:29', '0000-00-00 00:00:00', '', 0, '143041', 'Московская область, Голицыно', 'Южный квартал', '81', '', '-', '+7 909 1611163', '', '', '{}', '0000-00-00 00:00:00', 0),
(257, 'Вадим', '', 'Ермилов', '100142', 'vadimelk@mail.ru', '44a3561a84848a41be81cea2229c628c:ipO948arUXb2UYz38tu3MAEuWMxTW77F', '', 0, 1, '2010-11-25 13:57:46', '0000-00-00 00:00:00', '', 0, '196211', 'Санкт Петербург', 'пр.Ю.Гагарина', '18', '4', '172', '+7 921 7528149', '', '', '{}', '0000-00-00 00:00:00', 0),
(258, 'ilia', '', 'nazmutdinov', '100143', 'igor.lemon.kozlovsky@gmail.com', '306e38109dbc82789ca27f0229c24628:n8g4Gyc7HQarHycChhBrkxXKQZ9e6CyL', '', 0, 1, '2010-11-25 21:18:29', '0000-00-00 00:00:00', '', 0, '222222', 'spb', 'vav', '7', '', '47', '+7 921 753 03 74', '', '', '{}', '0000-00-00 00:00:00', 0),
(259, 'Вячеслав', 'Владимирович', 'Лебедев', '100147', 'Lebedeff.viach@yandex.ru', '0e8a0ca36cc89b4ffabacc476ed0e762:d4XpDuanr5Q7Z8UqsJHGj97vAM7GLBqG', '', 0, 1, '2010-11-29 12:26:40', '0000-00-00 00:00:00', '', 0, '248016', 'Калуга', 'ул. Ленина', '53', '2', '41', '4842 77-40-39', '', '', '{}', '0000-00-00 00:00:00', 0),
(260, 'Николай', 'Игоревич', 'Краев', '100149', 'kraev88@gmail.com', 'c02a884b6dc3db701630b75212be815c:rKchs1wNNjogZtTmeqkOiamHDsa67NvL', '', 0, 1, '2010-12-06 12:47:07', '0000-00-00 00:00:00', '', 0, '50997', ' Кёлн', '1', '1', '', '1', '+49 1772742420', '', '', '{}', '0000-00-00 00:00:00', 0),
(261, 'Владимир', '', 'Малинин', '100150', 'vladimir.malinin@mail.ru', 'b3086edf6ac1033fd90caf1f55ada3e6:249YQ7NIltQ6noW9A9N7CLsq9OYUuSXJ', '', 0, 1, '2010-12-06 20:07:35', '0000-00-00 00:00:00', '', 0, '170042', 'Тверь', 'Афанасия Никитина', '86', '', '93', '+7 9157130000', '', '', '{}', '0000-00-00 00:00:00', 0),
(262, 'Виктор', '', 'Сутугин', '100151', 'tver5@bk.ru', 'ff99b83e0440d996b2bef8e3f41dade6:AIHMkqbt2vzBvEHYFI2nv6qPdl1884XY', '', 0, 1, '2010-12-06 20:13:23', '0000-00-00 00:00:00', '', 0, '170032', 'Тверь', 'пос. Химинститута', '10', '', '6', '+7-915-735-91-31', '', '', '{}', '0000-00-00 00:00:00', 0),
(263, 'Сергей', 'Михайлович', 'Чернецкий', '100152', 'geos2005@mail.ru', '87618ae902f5b5f83180bac1e3a8be6b:K36nHMSAXPl14OB2L2ggKM2UsoY4DHSY', '', 0, 1, '2010-12-07 13:41:22', '0000-00-00 00:00:00', '', 0, '65011', 'Одесса', 'Багрицкого', '71-А', '', '+38 048 715 21 25', '+38 050 395 05 83', '', '', '{}', '0000-00-00 00:00:00', 0),
(264, 'Светлана', 'Александровна', 'Солдатова', '100153', 'Elana_soldatova@gmail.com', '23860330b8eb16c40c79b308a1ea989c:BA6vQd6VkP5f6BXExaGNLfWlMelvf2Py', '', 0, 1, '2010-12-07 20:11:24', '0000-00-00 00:00:00', '', 0, '345322', 'Москва', 'Ленинградское шоссе', '67', '', 'п/я 3', '+7 985 7262487', '', '', '{}', '0000-00-00 00:00:00', 0),
(265, 'Дмитрий', 'аркадьевич', 'Захаров', '100154', 'dmitriy_zacharov@mail.ru', 'e589c06893ee59a21633f2a017695754:6nVvSX5Cw6lWdtM2nUXToEtLC17fPd1l', '', 0, 1, '2010-12-08 13:43:39', '0000-00-00 00:00:00', '', 0, '199178', 'Петербург', '10 линия', '13', '', '23', '+7 911 083 11 17', '', '', '{}', '0000-00-00 00:00:00', 0),
(266, 'Наталья ', 'Юрьевна', 'Рожкова', '100155', 'officespb@deruijterinternational.ru', '6afff61cc1a24c590bafb9348ae19af4:G35bgm9rF5dsGtwZk9hr05WvDcxPvkLb', '', 0, 1, '2010-12-08 16:58:43', '0000-00-00 00:00:00', '', 0, '197136', 'Санкт-Петербург', 'Ординарная', '10', '', '8', '+7 921 9385284', '', '', '{}', '0000-00-00 00:00:00', 0),
(267, 'Дмитрий', '', 'Горелов', '100156', 'dm_gorelov@mail.ru', '5fe2b43132f6c68e564fd8cbe8e2e9f4:rYQxDsDAO6RFgxvL6Yty2TDiGd89G6my', '', 0, 1, '2010-12-09 17:24:45', '0000-00-00 00:00:00', '', 0, '192765', 'Петербург', 'Фонтанка', '22', '', '56', '+7 911 769 74 11', '', '', '{}', '0000-00-00 00:00:00', 0),
(268, 'Андрей', '', 'Иосс', '100157', 'ioss_andrey@hotmail.com', 'dae24093c96f5937129eab9ef9b6728d:bli38mtKdnZ2exFglaTAubc5PnvBiBoJ', '', 0, 1, '2010-12-10 10:06:13', '0000-00-00 00:00:00', '', 0, '107076', 'Москва', 'Преображенская', '5/7', '', '133', '+7 965 2049192', '', '', '{}', '0000-00-00 00:00:00', 0),
(269, 'Алексей', '', 'Вавилов', '100159', 'a-vav@yandex.ru', '965f74e41fb96e8cc56062438bb43005:TCgXp2QkKHA5hbnzuepIbtHui2q3BviW', '', 0, 1, '2010-12-10 17:39:17', '0000-00-00 00:00:00', '', 0, '190000', 'Санкт-Петербург', 'Б. Морская', '33', '', '20', '+7 950 0195902', '', '', '{}', '0000-00-00 00:00:00', 0),
(270, 'Юлия', '', 'Денисенко', '100158', 'searche@yandex.ru', '8c055a8ac1285a158e30a42cdfe22fe3:pwCShzm2H1gmOAabUl6fIeRn9ueRGhWx', '', 0, 1, '2010-12-10 17:50:21', '0000-00-00 00:00:00', '', 0, '194156', 'Санкт-Петербург', 'Энгельса', '21', '', '18', '+7 812 294 28 00', '', '', '{}', '0000-00-00 00:00:00', 0),
(271, 'Виктор', '', 'Лебедев', '100160', 'victor@ru-seasons.com', '990f4746542398a31fabee937487631e:sqMNwQjwAgQAQfsFJpPkkQ7D8mwkTPcd', '', 0, 1, '2010-12-11 17:18:32', '0000-00-00 00:00:00', '', 0, '191187', 'Санкт-петербург', 'Литейный пр.', '15', '', '0', '+79219652658', '', '', '{}', '0000-00-00 00:00:00', 0),
(272, 'Максим', '', 'Жуйков', '100161', 'maxzhuikov@mail.ru', '430ac3c0316515aea894317e7233215a:EXV6Hst3JbpI3VUJeujJVlIXAzCnvVCX', '', 0, 1, '2010-12-12 14:10:07', '0000-00-00 00:00:00', '', 0, '400094', 'Волгоград', '51 гвардейская', '63', '', '34', '+7 902 3100299', '', '', '{}', '0000-00-00 00:00:00', 0),
(273, 'Виктор', '', 'Ушаков', '100162', 'texnofarm@mail.ru', '8cb65fabc4e7f8f797c467aa967b5238:nnGxi7DsAHJYWclrxYtqmEYkAr4UKLp1', '', 0, 1, '2010-12-13 12:11:18', '0000-00-00 00:00:00', '', 0, '141400', 'Москва', 'Сергеева', '5', '', '35', '+74955050343', '0674058664', '', '{}', '0000-00-00 00:00:00', 0),
(274, 'Стригин', '', 'Михаил', '100163', 'strigin76@rambler.ru', 'de28cddc157d92df11acf9aa03719d52:0koCg2YsFzL6pIVhspW3VqkydCUvC0bF', '', 0, 1, '2010-12-18 12:51:38', '0000-00-00 00:00:00', '', 0, '196066', 'САНКТ-ПЕТЕРБУРГ', 'МОСКОВСКИЙ ПРОСПЕКТ', '216', '', '36', '+73713879', '', '', '{}', '0000-00-00 00:00:00', 0),
(275, 'Анна', 'Владимировна', 'Азарова', '100164', 'azarova81@yandex.ru', '7e5c71177994efcaf1beb9f94c22f171:CFYbXMdP6Sv4426CCTu3wuAGn93MZlqX', '', 0, 1, '2010-12-23 18:28:53', '0000-00-00 00:00:00', '', 0, '1111111', 'Москва', 'Ярославское ш', '26', '', '1102', '+7 926 393 42 06', '', '', '{}', '0000-00-00 00:00:00', 0),
(276, 'Татьяна', '', 'Яламова', '200202', 'unknownonlineuser@gmail.com', 'b1b329fce5bcc58ec7392904c2546509:URrSQ6ABocAQjlpzwSqRjtpmwzE17aVG', '', 0, 1, '2011-01-18 17:53:29', '0000-00-00 00:00:00', '', 0, '125040', 'Москва', 'Ленинградский проспект', '9', '', '133', '+7 926 3200435', '', '', '{}', '0000-00-00 00:00:00', 0),
(277, 'Виктор', 'Георгиевич', 'Карцев', '200203', 'vkartsev@ibscreen.chg.ru', 'abaddc9b13e39e72a067bd9edf4e2efe:EGxVfafEQka5mtgEMIGxVB9FAJtTsZhB', '', 0, 1, '2011-02-14 12:12:44', '0000-00-00 00:00:00', 'Фонд &quot;Культурное достояние&quot;', 0, '142432', 'Черноголовка, Московская обл.', 'Институтский проспект', '7-А', '', '10', '+7 903 7148694', '+7 496 5240091', '', '{}', '0000-00-00 00:00:00', 0),
(278, 'Хатуна', '', 'Хидашели', '200204', 'first-class@yandex.ru', '18630ee90031914408ee9dedfe3d7c60:hJ2EmW44MNS4MwWf2bIdXzxfCZY3aJ21', '', 0, 1, '2011-02-21 17:28:36', '0000-00-00 00:00:00', '', 0, '119607', 'Москва', 'Раменки', '25', '1', '241', '+7 495 9215886', '', '', '{}', '0000-00-00 00:00:00', 0),
(279, 'Дмитрий', '', 'Журавлёв', '200205', 'cranehill1@ya.ru', 'aa948950d6074cf367b9cf67314de940:2kls638RKXWEYISQ8ekrY1rRNPq4wED8', '', 0, 1, '2011-02-21 18:38:31', '0000-00-00 00:00:00', '', 0, '107553', 'Москва', 'Б.Черкизовская', '30', '3', '96', '+7 985 2332297', '', '', '{}', '0000-00-00 00:00:00', 0),
(280, 'Дмитрий', '', 'Зима', '200206', 'dazima@mail.ru', '17dd5d96e30c97966f18f8231d66df3b:oKjxMgqg95xjn56Zy2HzofDtWmA7kKG8', '', 0, 1, '2011-03-01 19:01:51', '0000-00-00 00:00:00', '', 0, '350011', 'Краснодар', '1 Проезд Стасова', '18', '', '30', '+7 918 3892286', '', '', '{}', '0000-00-00 00:00:00', 0),
(281, 'Юлия', '', 'Пащеня', '200207', 'julija1@list.ru', '536e986967dbfe7c3635dd6493bb8659:mZCzF6LUVZwIBywzgHLjGvT2sIh4furN', '', 0, 1, '2011-03-04 16:44:29', '0000-00-00 00:00:00', '', 0, '188655', 'Сертолово', 'Ветеранов', '4', '', '9', '89111798199', '', '', '{}', '0000-00-00 00:00:00', 0),
(282, 'Владимир', 'Николаевич', 'Осипков', '200208', 'vladimir.1091@hotmail.com', 'b8f618cac2edf9cc1b187ccc20666b89:xplrVeSNfj9uJEYWA37ec4NDbgVmb9p0', '', 0, 1, '2011-03-12 17:53:36', '0000-00-00 00:00:00', '', 0, '198261', 'Санкт-Петербург', 'пр. Ветеранов', '109', '1', '95', '+7 950 0309589', '', '', '{}', '0000-00-00 00:00:00', 0),
(283, 'Константин', 'Геннадьевич', 'Гоглев', '200210', 'kgoglev@mail.ru', '77d59180f4a7df12e86c5944079a96e8:1YTgAp1GhTixalumEOQ7BLxfMKdELThe', '', 0, 1, '2011-03-17 20:20:11', '0000-00-00 00:00:00', '', 0, '620028', 'Екатеринбург', 'Фролова', '25', '', '40', '8922-1-300-300', '', '', '{}', '0000-00-00 00:00:00', 0),
(284, 'Екатерина', '', 'Демченко', '200212', 'dem_e@mail.ru', '9f1261c17d705280c94f3e6e5b985637:99SAAS4ceFxS6d6sWODHttDBLFt2q2th', '', 0, 1, '2011-03-21 12:06:22', '0000-00-00 00:00:00', '', 0, '125212', 'Москва', 'Лениниградское ш', '36', '1', '6', '89857607749', '', '', '{}', '0000-00-00 00:00:00', 0),
(285, 'Аркадий', 'Викторович', 'Соколов', '200214', 'sok003@yandex.ru', '25b946f1b55f8d26d847473c69ac5029:Xhm450dIA56yiSfqos6t5B4nAyZ8IcT6', '', 0, 1, '2011-03-22 16:54:52', '0000-00-00 00:00:00', '', 0, '194214', 'Санкт-Петербург', 'Костромской пр.', '31', '', '21', '89219300695', '', '', '{}', '0000-00-00 00:00:00', 0),
(286, 'Алексей', 'Романович', 'Зубаков', '200213', 'arz-wien@rambler.ru', 'dea50cd522ff5247c1bb7cf9d3986e85:95Y2DIxqke0WdFJ4OLQ7jKUP9XHLZHtO', '', 0, 1, '2011-03-22 17:00:31', '0000-00-00 00:00:00', '', 0, '199053', 'Санкт-Петербург', '1-я линия', '24', '', '21', '+7 911 2192620', '+7 812 328 3156', '', '{}', '0000-00-00 00:00:00', 0),
(287, 'Роман', 'Дмитриевич', 'Шарамко', '200215', 'sharamko@mail.ru', 'cbdd1f5b24597528d294d049e95fe68a:yggGEpKTRab1gj05V5Ra4izBNokDqT7v', '', 0, 1, '2011-03-24 12:03:18', '0000-00-00 00:00:00', '', 0, '195279', 'С-Петербург', 'Передовиков', '25', '', '78', '+ 812 903 11 32', '', '', '{}', '0000-00-00 00:00:00', 0),
(288, 'Петр', '', 'Петров', '200218', 'empire-antiques@mail.ru', '2a90a36c3217a19069a57b84e3a30027:T2ZntDjhVOS87FgbVZfxhCqprm6EqtFb', '', 0, 1, '2011-03-24 15:10:27', '0000-00-00 00:00:00', '', 0, '3467845', 'Москва', 'Воронежская', '29', '4', '7', '+7 926 837 43 05', '', '', '{}', '0000-00-00 00:00:00', 0),
(289, 'Евгения', 'Георгиевна', 'Татурян', '200219', 'nebarbi@rambler.ru', '708d927ad6ed12c3b6d9b8e05933e53d:Z3TPP0IL7Lu9cXAAWrzxQ6JwYIPDgyN9', '', 0, 1, '2011-03-24 17:24:36', '0000-00-00 00:00:00', '', 0, '14275', 'Москва', 'Василия Петушкова', '23', '', '88', '+7 916 090 5834', '', '', '{}', '0000-00-00 00:00:00', 0),
(290, 'Василий', '', 'Жуковский ', '200220', 'xolding-ws@rambler.ru', '7f21084a4f1249f854d1eeb07b7c1814:pZAZ928oJZJX0u6QiIOdImLWBrAsw20j', '', 0, 1, '2011-03-24 20:02:40', '0000-00-00 00:00:00', '', 0, '191000', 'Санкт-петербург', 'Северный пр-т', '91', '', '55', '8 950 04 18 003', '', '', '{}', '0000-00-00 00:00:00', 0),
(291, 'Олег', '', 'Кузин', '200222', 'kuzin@tribuna.ru', 'd5c15cd20416fbf686acfde50291d60e:msT6zpkL88HejTsnUp3NfjB7J6jRV9f6', '', 0, 1, '2011-03-25 18:04:37', '0000-00-00 00:00:00', '', 0, '127137', 'Москва', 'Бумажный проезд', '14', '1', '614', '+7 499 2575913', '+7 495 9256506', '', '{}', '0000-00-00 00:00:00', 0),
(292, 'Инесса', '', 'Шакхвердиева', '200228', 'nusik11@gmail.com', '8aa78bf2f8c406be8742aa854a698a65:u6HRzzlXOJvJnOD6slvHiztLWzR53KT3', '', 0, 1, '2011-03-30 11:15:20', '0000-00-00 00:00:00', '', 0, '119003', 'Москва', 'Оружейный переулок', '25', '', '144', '9202429', '', '', '{}', '0000-00-00 00:00:00', 0),
(293, 'АМИРИЗ', 'ХАМЗИЕВИЧ', 'БИКБАЕВ', '200229', 'OLEGBAH@MAIL.RU', '2b401fc34985ee28f5205e34fd6b6f7a:iqDi5A1LQzWqZhL9HKR9Gk48pwaNnWwo', '', 0, 1, '2011-03-30 14:30:59', '0000-00-00 00:00:00', '', 0, '125008', 'МОСКВА', 'ПРОЕЗД ЧЕРЕПАНОВЫХ', '38', '1', '196', '8-965-218-00-41', '', '', '{}', '0000-00-00 00:00:00', 0),
(294, 'Сергей', '', 'Матвиенко', '200230', 'okline@ukr.net', '8cb086e87e1e123900ca9b424372cdc2:96BcIAecoaEWm86te0FJZ2d4lk546GRK', '', 0, 1, '2011-03-31 13:21:24', '0000-00-00 00:00:00', '', 0, '01133', 'Киев', 'бульвар Лихачева', '8', '', '72', '+38 098 275 64 41', '', '', '{}', '0000-00-00 00:00:00', 0),
(295, 'Юлия', '', 'Поздышева', '200231', 'jpek@ya.ru', '0b18df2f8cfcc7598d0aa9ad3be0c9b7:fkOTfX4dbhYz5z0C0K1vBIGPfPgmATjl', '', 0, 1, '2011-03-31 14:36:38', '0000-00-00 00:00:00', '', 0, '190121', 'Санкт-Петербург', 'наб. реки Мойки', '112', '', '11', '+7 921 5946425', '', '', '{}', '0000-00-00 00:00:00', 0),
(296, 'Ася', '', 'Гейликман', '200233', 'Arozina@rambler.ru', '8477a916b2d557cec327e88ae5eaf848:Vpc9cxcdpR881T05h6zz5mYX4B9mvI1c', '', 0, 1, '2011-04-04 14:22:19', '0000-00-00 00:00:00', '', 0, '199053', 'Санкт-Петербург', '2 линия', '39', '16', '5', '+7 921 966 33 49', '', '', '{}', '0000-00-00 00:00:00', 0),
(297, 'Ольга', '', 'Усманова', '200235', 'usmanovaon@mail.ru', '24204e8a216bfae3d6f7351b73fab702:dDFMcQFVr6q3ImxVN33vsswBnHlQBvgt', '', 0, 1, '2011-04-29 19:58:28', '0000-00-00 00:00:00', '', 0, '119049', 'Москва', 'Шаболовка', '10', '2', '2 этаж, компания Регион', '+7 916 177 16 48', '', '', '{}', '0000-00-00 00:00:00', 0),
(298, 'Павел ', 'Георгиевич', 'Корниенко', '200236', 'kornienkopavel2011@mail.ru', '2fb5ac2f0835a320632c2bc327b5a0c2:sFlZCk1M78BKn2ibAwyPvxtGUxxzrMD9', '', 0, 1, '2011-05-07 21:25:28', '0000-00-00 00:00:00', '', 0, '603093', 'Н.Новгород', 'Гордеевская', '58', '', '60', '+7-831-413-82-69', '+7-908-168-55-44', '', '{}', '0000-00-00 00:00:00', 0),
(299, 'Александр', 'Борисович', 'Кузнецов', '200237', 'calendar_museum@mail.ru', '690389c8b8709c962be119ab99e91f49:bdSt372fhyRsqYFyggmjgBKGSEyb12wy', '', 0, 1, '2011-05-08 11:24:54', '0000-00-00 00:00:00', '', 0, '127434', 'Москва', 'Дмитровское шоссе', '13А', '', '129', '+7 985 2332217', '', '', '{}', '0000-00-00 00:00:00', 0),
(300, 'Сергей', 'Леонидович', 'Шкурко', '200238', 'baikonurskm234@mail.ru', 'ea984c3ece319f202e0c0eb28c87a0f2:mW9Nidm5okIZu9ezRXu8GMQ2m4fWvrbb', '', 0, 1, '2011-05-09 14:07:39', '0000-00-00 00:00:00', '', 0, '117292', 'Москва', 'Новочеремушкинская', '21', '1', '23', '+7 495 7189472', '+7 916 2940985', '', '{}', '0000-00-00 00:00:00', 0),
(301, 'Роман Русский стиль', '', 'Вуколов', '200239', 'rainman4@yandex.ru', 'e3d48ea00f65df150493ea9c4a544c98:JtjmYQWdf5I3TwaBuX55IHo57DqL4DrM', '', 0, 1, '2011-05-11 11:36:01', '0000-00-00 00:00:00', '', 0, '105077', 'Москва', 'Первомайская', '47', '', '85', '8(909) 673-48-09', '8(499)177-62-92', '', '{}', '0000-00-00 00:00:00', 0),
(302, 'Андрей', 'Алексеевич', 'Деренков', '200240', 'msplushka@mail.ru', '0f51dfa5df7aeebf071680df1f832d08:H4c01qjruivfMO9UFVDApBqAK9GtYYNg', '', 0, 1, '2011-05-12 20:22:13', '0000-00-00 00:00:00', '', 0, '125464', 'Москва', 'Пятницкое шоссе', '12', '2', '105', '+7 916 6360549', '', '', '{}', '0000-00-00 00:00:00', 0),
(303, 'Юлия', 'Викторовна', 'Новикова', '200242', 'juli1977new@mail.ru', 'f7761f039e7638aaa95302179e01539b:nKXMvHrLCnI0D4j61h1uc6IxlKyezrEt', '', 0, 1, '2011-06-09 13:34:53', '0000-00-00 00:00:00', 'частное лицо', 0, '109559', 'Москва', 'Верхние Поля', '45', '2', '217', '+7 916 500 03 59', '', '', '{}', '0000-00-00 00:00:00', 0),
(304, 'Марьяна', 'Александровна', 'Ранкова', '200243', 'r.mariana@gmx.net', '31e77c06d95ee93ed393cd13132640bd:RHY1sPffhRafHJOekCTYNLjj7ubBUwtU', '', 0, 1, '2011-06-29 12:53:46', '0000-00-00 00:00:00', '', 0, '10785', 'Берлин', 'Лютцовуфер', '2', '', '2', '00491776290206', '', '', '{}', '0000-00-00 00:00:00', 0),
(305, 'Виктор', 'Вячеславович', 'Сульдин', '200244', 'BITEK89@spaces.ru', 'b3cc33354222e6535e12616b7f259435:kF6sp4q7U0IVC2j1yO7R1kD6YTmtY6X1', '', 0, 1, '2011-07-08 17:30:23', '0000-00-00 00:00:00', '', 0, '568344', 'Санкт-Петербург', 'Пограничника Горькавого', '5', '1', '19', '+7 965 0307461', '', '', '{}', '0000-00-00 00:00:00', 0),
(306, 'Эдуард', 'Вараздатович', 'Балиашвили', '200246', 'edobali@mail.ru', 'ba18bc3c80610e81833125b47b01faa3:uGNAMeQLKZitV3KuvcYj7k6hUQ9NqV64', '', 0, 1, '2011-07-11 17:32:53', '0000-00-00 00:00:00', 'частное лицо1', 0, '105064', 'Москва', 'Воронтсово поле', '15', '1', '100', '+7 495 9164633', '+7 985 2907905', '', '{}', '0000-00-00 00:00:00', 0),
(307, 'Хачатур', 'Михайлович', 'Гукасян', '200247', 'xach2008@mail.ru', 'f43ff55c58affbd6161f77dea1157d1e:YfsJZU1Tn3o9x76QOcS4zVMdZBTgDBhC', '', 0, 1, '2011-08-09 11:07:00', '0000-00-00 00:00:00', '', 0, '60', '60', '60', '60', '60', '60', '+995555907790', '+995555907790', '', '{}', '0000-00-00 00:00:00', 0),
(308, 'Александр', 'Владимирович', 'Игонин', '200248', 'stafmen@rambler.ru', '945c9d4a8e9b6471e4e453292b059851:pc3S9K3fHToyIS1nGdMdkqVmwTAUvvM8', '', 0, 1, '2011-11-09 11:23:05', '0000-00-00 00:00:00', 'ооо Былина', 0, '601255', 'Великий Новгород', 'Студеная', '3', 'а', '56', '+79210133121', '', '', '{}', '0000-00-00 00:00:00', 0),
(309, 'Евгения', '', 'Тихомирова', '200249', 'etual2007@mail.ru', 'f61ff74e130ebf10c15dc5c624c25c2b:1spobYib95rFdkvGTHKOoOGrgbj9GGjw', '', 0, 1, '2011-11-11 11:41:00', '0000-00-00 00:00:00', '', 0, '101000', 'Москва', 'Покровский бульвар', '4/17', '1', '21', '+7 903 729 08 25', '', '', '{}', '0000-00-00 00:00:00', 0),
(310, 'Евгений', 'Валентинович', 'Казьмин', '200250', 'expertantik@yandex.ru', 'ebb461651837cedb56791023e62a30f1:CvxE2JwcbNRMFDyu2sIaEulO4CRjyABN', '', 0, 1, '2011-11-11 13:25:54', '0000-00-00 00:00:00', '', 0, '150025', 'Ярославль', 'Сельская', '4', '', '1', '+79036469870', '', '', '{}', '0000-00-00 00:00:00', 0),
(311, 'Юрий', 'Николаевич', 'Торгунаков', '200251', 'tyn1964@bk.ru', 'bfb66cd4b5357036379d55411484368d:pSw7Ox07CEndR6aNHMsnSS6ropzpj3YX', '', 0, 1, '2011-12-05 16:00:10', '0000-00-00 00:00:00', '', 0, '630007', 'Новосибирск', 'Урицкого', '1', '', '18', '+7 913 4515121', '', '', '{}', '0000-00-00 00:00:00', 0),
(312, 'Андрей', 'Анатольевич', 'Афонин', '200252', 'afonin64@mail.ru', 'aa5463abfe1ff3e7e9215dfafb34740b:10ua9VLeFvf30MDE0Ehen0Y5UZ3h31Sb', '', 0, 1, '2011-12-07 11:00:21', '0000-00-00 00:00:00', '', 0, '454112', 'Челябинск', 'Красного Урала', '4', '', '96', '8-9124024288', '8(351)741-96-20', '', '{}', '0000-00-00 00:00:00', 0),
(313, 'Евгений', 'Владимирович', 'Глызин', '200253', 'evgengl@rambler.ru', '9156122eea83faec48aa0d8edf7b1abd:8BAftXa4kxc6BWqxSpkfbYsRD68lmSEf', '', 0, 1, '2011-12-07 11:01:36', '0000-00-00 00:00:00', '', 0, '664078', 'Новошахтинск', 'Харьковская', '123', '', '28', '89149144475', '', '', '{}', '0000-00-00 00:00:00', 0),
(314, 'Александр', 'Георгиевич', 'Порядин', '200254', 'Alexandrporyadin@gmail.com', '058f0b9de9f1fdd69e2a4d35bde7c89a:BX7CMtZivp5sqj9xfNJ9ITuivdpqizOS', '', 0, 1, '2011-12-13 11:50:05', '0000-00-00 00:00:00', '', 0, '191126', 'Санкт-Петербург', 'Захарьевская', '27', '', '38', '+7(921)9111164', '', '', '{}', '0000-00-00 00:00:00', 0),
(315, 'Анна', '', 'Петрова', '200257', 'annanpetrova@mail.ru', '14b789b4925925fe09dfdf8c0f8489b0:DbGIBeHqLofI0F7zY4zmgeNqqxm34okx', '', 0, 1, '2011-12-26 11:41:08', '0000-00-00 00:00:00', '', 0, '119261', 'Москва', 'Ленинский проспкт', '81', '', '181', '+7 919 7799611', '', '', '{}', '0000-00-00 00:00:00', 0),
(316, 'Фатима', 'Руслановна', 'Джанкезова', '200256', 'kishtik.kuchik@mail.ru', 'c99de8dce401fce2510a6efdcc472dac:yoXtrY8SRZHcpJowA7YvjiAdJZYV9spM', '', 0, 1, '2011-12-26 14:44:51', '0000-00-00 00:00:00', '', 0, '369200', 'карачаевск', 'ленина', '31', '', '18', '+79283828272', '', '', '{}', '0000-00-00 00:00:00', 0),
(317, 'Виталий', 'фконстантинович', 'Бардовский', '200259', 'vital.bardowhisky@yandex.ru', '63956c28c68ba972f627174542dea0d8:7j6aHMwZTZznOzeiIv0pLmLO8QCjHCtq', '', 0, 1, '2012-01-05 14:07:33', '0000-00-00 00:00:00', '', 0, '184653', 'Полярный', 'Гагарина', '5', '', '59', '9212810332', '8155172589', '', '{}', '0000-00-00 00:00:00', 0),
(318, 'Марина', 'Валерьевна', 'Селиверстова', '200260', 'vargusha@yandex.ru', '35cfb36c84399354fec0d33a9514d161:3HE5s3nhX1CmMAuaUmblsee3aYs4HGKT', '', 0, 1, '2012-01-19 11:28:17', '0000-00-00 00:00:00', '', 0, '119607', 'Москва', 'Раменки', '6', '2', '319', '+79296062140', '', '', '{}', '0000-00-00 00:00:00', 0),
(319, 'Владимир', 'Тимурович', 'Кипиани', '200262', 'Araikbc@mail.ru', '0d36dfe0279d7cfe8a806b49fb29c583:cmEpugG5GN12EKihEVWMbQ3cj7884zAC', '', 0, 1, '2012-01-25 12:21:54', '0000-00-00 00:00:00', '', 0, '105009', 'Москва', 'Газетный пер', '13', '', '25', '+7 925 5009596', '+7 9255075864', '', '{}', '0000-00-00 00:00:00', 0),
(320, 'Юлия', '', 'Зотова', '200263', 'ZYuliya09@yandex.ru', '0c6cfeef850e403131f188d12b0f1253:yqvQTCE8DunP5hs9ZZgWwOyog3RfPJ3e', '', 0, 1, '2012-01-31 15:43:39', '0000-00-00 00:00:00', '', 0, '117042', 'Москва', 'Адм.Лазарева', '11', '', '100', '8-916-109-91-98', '', '', '{}', '0000-00-00 00:00:00', 0),
(321, 'galina', '', 'rodina', '200264', 'krendelek3@yandex.ru', 'bbbf8a1140e7213a9a2f63be8f5f6c31:DfDwwlw9z1nPfrmM96NUNAw1JZqqxpFi', '', 0, 1, '2012-02-09 14:13:42', '0000-00-00 00:00:00', '', 0, '105064', 'moscow', 'zemlyanoj val', '9', '', '12', '+79037601532', '', '', '{}', '0000-00-00 00:00:00', 0),
(322, 'Иван', '', 'Богданов', '200265', 'agvan56@yandex.ru', 'd8666288544a865936f4935bbf057123:qwBTMhmuEt7M5Y4OYxfmDKAO0Dty4XrI', '', 0, 1, '2012-02-12 00:26:22', '0000-00-00 00:00:00', '', 0, '354053', 'Сочи', 'Виноградная', '195', '', '25', '+7 918 1711732', '', '', '{}', '0000-00-00 00:00:00', 0),
(323, 'Алексей', 'Александрович', 'Родионов', '200266', 'simeon25@mail.ru', 'c36417ec8865f5816fd08bdb2f1a8ff9:RzqBUL0syM6pTo3qRPHtcCymifGxGWEu', '', 0, 1, '2012-02-14 12:41:50', '0000-00-00 00:00:00', '', 0, '141820', 'Дмитров', 'Центральная', '37', '', '5', '+7 915 3331271', '', '', '{}', '0000-00-00 00:00:00', 0),
(324, 'Светлана', 'Игоревна', 'Скорых', '200267', 'turne2007@bk.ru', 'e391c077aa1dd957b192cca1f624cd79:WrfMbGSUMFyqljiLhW9w9JdZL0Ok1VXK', '', 0, 1, '2012-02-15 15:32:50', '0000-00-00 00:00:00', '', 0, '194354', 'Санкт-Петербург', 'Купчинская', '16', '1', '41', '89052571993', '79643764520', '', '{}', '0000-00-00 00:00:00', 0),
(325, 'Vitalij', '', 'Kuzmin', '200268', 'mersedes133@inbox.lv', '08bdf7f01271e5e7a8439398f9b4cb67:9qylMrQb2m7IYbZBDW8BbhgFPI5iBsn5', '', 0, 1, '2012-02-20 16:16:47', '0000-00-00 00:00:00', '', 0, '33011', 'Oviedo', 'C/Puerto Leitariegos', '3', '', 'B1', '+34668561711', '', '', '{}', '0000-00-00 00:00:00', 0),
(326, 'Георгий', 'Константинович', 'Четверкин', '200269', 'chetverkin_gk@mail.ru', 'c60b210751c94e87dc0b3a38e454969b:M0UKb2XXCmhoigCbFZPYE6ajmraO63Y0', '', 0, 1, '2012-03-05 12:25:29', '0000-00-00 00:00:00', '', 0, '170000', 'Тверь', 'Вагжанова', '21', '', '1', '+7 920 1718509', '+7 4822 323494', '', '{}', '0000-00-00 00:00:00', 0),
(327, 'Александр', '', 'Маркушин', '200270', 'escogido@pochta.ru', 'dd522d11efe4a8233ca2ebefb32c61ef:Gm5J2k7wkROzJdXmMqoyY91WEhFfyPZt', '', 0, 1, '2012-03-08 15:43:53', '0000-00-00 00:00:00', '', 0, '350072', 'Краснодар', 'Аксайская', '40/3', '', '11', '+79673108595', '', '', '{}', '0000-00-00 00:00:00', 0),
(328, 'Дмитрий', 'Александрович', 'Орловский', '200271', 'lexus66@list.ru', 'c4dfc6f521bf7a5e6af3d2f68503be65:jxJMKM6enMcThm59ELyCc02MCd2rVgrj', '', 0, 1, '2012-04-04 20:16:07', '0000-00-00 00:00:00', '', 0, '620039', 'Екатеринбург', 'Орловская', '67', '', '1', '+79120477777', '', '', '{}', '0000-00-00 00:00:00', 0),
(329, 'Надежда', 'Валентиновна', 'Игнатенко', '200274', 'ignatenko.nadya@stingray.ru', '5c11dd09b163e2b7d84d06da5032172e:Qwuy3nfaXYWWLjDcIlpwzBzhD87zv4H7', '', 0, 1, '2012-04-19 13:02:27', '0000-00-00 00:00:00', '', 0, '195220', 'Санкт-Петербург', 'Гражданский пр.', '25', '', '8', '+7 921 3788553', '', '', '{}', '0000-00-00 00:00:00', 0),
(330, 'александр', '', 'Савченко', '200276', 'leppo@yandex.ru', '04c8c2d76ae744d2d231eb71b1e5e3d9:MS79GSQkeqLUinpaEhGJ0CpfX4p0B9cW', '', 0, 1, '2012-05-02 11:48:48', '0000-00-00 00:00:00', '', 0, '197758', 'Санкт-Петербург', 'п.Песочный ул.центральная', '3', '', '1', '+7 921 996 01 40', '', '', '{}', '0000-00-00 00:00:00', 0),
(331, 'Виктор', 'Александрович', 'Новиков', '200278', 'n1viktor@mail.ru', '72173c97ef26a9a859edafeec6b69faf:estETOph5r1bW0vWLgLumqyDmAGc6kDV', '', 0, 1, '2012-05-09 14:21:31', '0000-00-00 00:00:00', 'коллекционер', 0, '109028', 'Москва', 'Казарменный переулок', '10 стр. 4', '', '24', '+7 903 7292711', '', '', '{}', '0000-00-00 00:00:00', 0),
(332, 'борис', 'владимирович', 'ведерников', '200279', 'kapital@usp.ru', 'f86b46278d183ca76816e5b3ae162237:wDE8ztR8N7BgmXaC81pPW8HMjXS5dRxf', '', 0, 1, '2012-05-09 14:34:18', '0000-00-00 00:00:00', 'капитал', 0, '620014', 'екатеринбург', 'малышева', '24', '', 'салон КАПИТАЛ', '+7 912 2410595', '', '', '{}', '0000-00-00 00:00:00', 0),
(333, 'Юлия ', 'Юрьевна ', 'Цуканова', '200280', 'podvorie1@yandex.ru', 'a5694a6a065ad67c965e30c0fa5fdf76:pc8TyRHB1mv6Z5YjM9IPHO3lK7NiOAYd', '', 0, 1, '2012-05-17 12:08:25', '0000-00-00 00:00:00', 'Алексеевское подворье', 0, '281203', 'Москва', 'п. Менделеево, ул. Пионерская ', '10А', '', '+7 916 3907317', '+7 926 0906378', '', '', '{}', '0000-00-00 00:00:00', 0),
(334, 'натали', '', 'бронникова', '200281', 'natbr@list.ru', 'a47c19d27afcf07bed20bd829c0a66d3:ASTUD0dk4zkFuxQwkr4PhUFbjDcexs7P', '', 0, 1, '2012-05-28 18:24:55', '0000-00-00 00:00:00', '', 0, '117574', 'москва', 'голубинская', '7', '5', '280', '+79267085793', '', '', '{}', '0000-00-00 00:00:00', 0),
(335, 'Сергей', '', 'Барков', '200285', 'barkov.sa@gmail.com', '1e039266010cceaf89dc062d4eeeddcf:mB7BYWX69oR1gQEq5L6e3IUNBAIpCeM9', '', 0, 1, '2012-08-06 14:49:43', '0000-00-00 00:00:00', '', 0, '125581', 'Москва', 'Енисейская', '7', '3', '20', '+79035497733', '', '', '{}', '0000-00-00 00:00:00', 0),
(336, 'Ольга', '', 'Ярцева', '200286', 'olyartseva@me.com', '96a119d557dcc90e85dc013d98e6305e:mCMgm7tr6y0FkjDxR8G4w1GXDIqMipS6', '', 0, 1, '2012-08-08 12:51:03', '0000-00-00 00:00:00', '', 0, '125581', 'Москва', 'Енисейская', '7', '3', '20', '+79859706556', '', '', '{}', '0000-00-00 00:00:00', 0),
(337, 'Пётр', 'Артурович', 'Тихонов', '200287', 'Petih@yandex.ru', '25f7f1644c3ebfc5ad0169c53453d69a:Fs0faHkpyEuQ6sukD4UUAFvaVSkQmYBP', '', 0, 1, '2012-08-09 17:35:32', '0000-00-00 00:00:00', '', 0, '450001', 'Уфа', 'Октября', '11', '', '39', '9196141422', '3472509428', '', '{}', '0000-00-00 00:00:00', 0),
(338, 'Саргылана', 'Николаевна', 'Яковлева', '200288', 'ya_lana73@mail.ru', 'da31df80f5718740b87848c6ff867508:6pE2hmq7Wnp7jRmK1avxjeHTOdCvuQUO', '', 0, 1, '2012-08-28 11:15:18', '0000-00-00 00:00:00', '', 0, '677000', 'Якутск', 'Б.Марлинского', '10', '', '33', '89142735240', '', '', '{}', '0000-00-00 00:00:00', 0),
(339, 'Владимир', 'Сергеевич', 'Стеблев', '200291', 'steblev0330@mail.ru', 'e7642a3568e1cea932edb13e0863475c:JCMhsZtepinEt7MjMQ6oCE5pAye28GwV', '', 0, 1, '2012-09-21 15:02:53', '0000-00-00 00:00:00', 'ИП Стеблев', 0, '410069', 'Саратов', 'Ипподромная', '11', '', '41', '+7 963 1120330', '', '', '{}', '0000-00-00 00:00:00', 0),
(340, 'Ольга', 'Владимировна', 'Шалыгина', '200292', 'shalygina@stfond.ru', '8af303a64b6263c956b72f78aa5dcada:VBT0MpyH9AgA3OTvut0cz9U4FjXbsWDU', '', 0, 1, '2012-09-27 16:36:38', '0000-00-00 00:00:00', 'Национальный Фонд Святого Трифона', 0, '109028', 'Москва', 'Солянка', '4,  стр. 1-1а', '', '211', '+7 495 6262206', '+7 964 7803977', '', '{}', '0000-00-00 00:00:00', 0),
(341, 'Ирина', 'Александровна', 'Солощева', '200293', 'irinasol.sii@gmail.com', '4e627952231b8451a672a0721bba21b4:LDkvxo9JyB0bBPQoVPh0lNnkkAfOGME2', '', 0, 1, '2012-10-15 11:29:38', '0000-00-00 00:00:00', 'Era-Art', 0, '125252', 'Москва', 'Гризодубовой', '4', '4', '10', '+79153616671', '', '', '{}', '0000-00-00 00:00:00', 0),
(342, 'Андрей', 'Михайлович', 'Лебедев', '200294', 'an.lebedew.pskow@list.ru', '3be2ca205ca7f6050fa64fc7a5c25515:jdFwioy0DpOQDO7ADPBaAJYFu1cIXH4u', '', 0, 1, '2012-10-22 12:45:04', '0000-00-00 00:00:00', '', 0, '180016', 'Псков', 'Чехова', '6а', ' -', '61', '+7 960 2216448', '', '', '{}', '0000-00-00 00:00:00', 0),
(343, 'Сергей', '', 'Барков', '200295', 'yartseva@polytrade.ru', 'e31ca867bfc919892d7ba405a11fb2cb:wrGApO4zVuCpZiom6RLtA8SJrgQPtbCB', '', 0, 1, '2012-10-29 09:09:33', '0000-00-00 00:00:00', '', 0, '107370', 'Москва', 'Открытое шоссе', '3', '12', '22', '+79035497733', '+79859706556', '', '{}', '0000-00-00 00:00:00', 0),
(344, 'Иван', '', 'Бендусов', '200296', 'iziikil@mail.ru', '2cf175b1395815718df06cfac23f4b1d:MIV2cQfmk0rrrtte6QX3InllQpp2tgO3', '', 0, 1, '2012-11-08 12:52:36', '0000-00-00 00:00:00', '', 0, '125222', 'москва', 'дубравная', '41', '2', '60', '+79160331616', '', '', '{}', '0000-00-00 00:00:00', 0),
(345, 'михаил', 'васильевич', 'костюченко', '200297', 'mihail24689@mail.ru', 'c988e6b4bfb4ac685ff53e046380b380:R0itCby4GfMPwhuDVJiEr82jYVeWwZMD', '', 0, 1, '2012-11-08 18:47:52', '0000-00-00 00:00:00', 'Michurin&#039;s 20 street, apartment 17', 0, '347916', 'таганрог', 'мичурина', '20', '', '17', '+79185197001', '', '', '{}', '0000-00-00 00:00:00', 0),
(346, 'Олег', 'Викторович', 'Ковалевский', '200298', '6846739@mail.ru', 'fad025f88c220eaba009c7329994702e:u6tZfKYSp6aMnelM12jNQd4eCQ5H6dei', '', 0, 1, '2012-11-12 11:26:30', '0000-00-00 00:00:00', 'нет', 0, '127240', 'Москва', 'Дмитровское шоссе', '165Д', '6', '51', '+ 7 9036846739', 'нет', '', '{}', '0000-00-00 00:00:00', 0),
(347, 'Oleksandr ', '', 'Sakovskyi', '200299', 'murariart@gmail.com', '8f2335c4282f62c16e2a36dded6dcc17:y6a8uKQoECwIAxw8pac9BPpImEkuAABT', '', 0, 1, '2012-11-19 11:38:01', '0000-00-00 00:00:00', '', 0, 'LT-11113', 'Vilnus', 'Birzisku', '136', '', '0', '+37068236564', '', '', '{}', '0000-00-00 00:00:00', 0),
(348, 'Ирина', 'Петровна', 'Кондратьева', '200300', '5423598@mail.ru', '8cf746077252fb4228bd7ccd4f1697cc:6FSa2UgzUm9dQrVZVn1w4b5JPcLXNpud', '', 0, 1, '2012-11-19 12:58:33', '0000-00-00 00:00:00', 'ИТЕРА', 0, '117209', 'Москва', 'Севастопольский проспект', '28', '1', 'офис', '+79255423598', '', '', '{}', '0000-00-00 00:00:00', 0),
(349, 'Михаил', 'Юрьевич', 'Михайлов', '200301', 'rik777@bk.ru', '6357a3bb921041776b86e54da359111c:AwThGjgd7JhgWOb66uXb3yzG4YIcDBDN', '', 0, 1, '2012-11-20 11:19:14', '0000-00-00 00:00:00', '', 0, '190068', 'Санкт-Петербург', 'Ср.подьяческая', '10', '', '6', '7921 958  1539', '921 958 1539', '', '{}', '0000-00-00 00:00:00', 0),
(350, 'Вениамин', 'Григорьевич', 'Гельман', '200303', '7845142@mail.ru', 'c19f621985adddd7d55ee889e6432261:iR6y2CH4jjggCwj0Piafov5DITfzDLtU', '', 0, 1, '2012-11-21 15:40:22', '0000-00-00 00:00:00', '', 0, '129366', 'Москва', 'Пр Мира', '182', '2', '34', '+79857845142', '', '', '{}', '0000-00-00 00:00:00', 0),
(351, 'Олег', 'Викторович', 'Ковалевский', '200305', '6846739@mal.ru', 'c68cc47ceaca8e4767feb1fff74ee64d:BV6FjJWZZmLWsti6WZ3rDs13r0LccbTe', '', 0, 1, '2012-11-25 12:07:52', '0000-00-00 00:00:00', 'нет', 0, '127204', 'Москва', 'Дмитровское шоссе ', '165Д', '6', '51', '89036846739', '84996612393', '', '{}', '0000-00-00 00:00:00', 0),
(352, 'Евгения', 'Владимировна', 'Осокина', '200307', 'osokinaeva@gmail.com', '4db9b7582047e0e3f43d34611839e730:n04eJbgCWKH21ZuOuONccO2PUiC8xRpY', '', 0, 1, '2012-11-26 18:07:10', '0000-00-00 00:00:00', '', 0, '197022', 'Санкт-Петербург', 'Песочная наб.', '40', '', '31', '+79219494889', '', '', '{}', '0000-00-00 00:00:00', 0),
(353, 'Дениза', 'Саид-Ахмедовна', 'Бакриева', '200308', 'b.denizaaa@gmail.com', 'a168e51264602118d0e03323ac6e1281:VAMb8fFoquapeGruiwBjk6hrrgAkOOwG', '', 0, 1, '2012-12-03 14:58:50', '0000-00-00 00:00:00', '', 0, '125047', 'Москва', 'Фадеева', '1', '5', '103', '+79035982929', '', '', '{}', '0000-00-00 00:00:00', 0),
(354, 'Владимир', 'Николаевич', 'Борисенко', '200310', 'GLAVNYii@yandex.ru', 'bab497c0053852fb485a6f5a2c5f7211:q9U32ORARFlR8gzdXJD8die9Zf8PVunL', '', 0, 1, '2012-12-07 12:35:07', '0000-00-00 00:00:00', '', 0, '355042', 'Ставрополь', 'Черниговская', '4', '', '56', '+7 928 0056007', '', '', '{}', '0000-00-00 00:00:00', 0),
(355, 'елена', 'владимировна', 'константинова', '200314', 'konstantin.ova@live.ru', 'f24b523089e85ddf759aef0c5ca58393:qzzar1b1coGlY8HhGUBbxdb3KbxtsljH', '', 0, 1, '2012-12-17 12:57:41', '0000-00-00 00:00:00', '', 0, '455001', 'магнитогорск', 'герцена', '2', '', '52', '89068545756', '', '', '{}', '0000-00-00 00:00:00', 0),
(356, 'Сергей', '', 'Власов', '200315', 'muzminakariana@yahoo.com', '1591dfcea05829f5c1a5d55710bf2b2d:QBW73WjtmimslEQzpLKQZKyXEk4hhhhC', '', 0, 1, '2012-12-17 13:00:35', '0000-00-00 00:00:00', '', 0, '680054', 'Хабаровск', 'Даниловского', '20', '', '26', '+79242099255', '', '', '{}', '0000-00-00 00:00:00', 0),
(357, 'михаил', 'иванович', 'фирсов', '200316', 'f3647771@yandex.ru', '543ba1f8801875761a6809452d9ca45f:rIWEkoG0EFRkuhXvsTBW8I2S539yRHYb', '', 0, 1, '2012-12-21 11:06:14', '0000-00-00 00:00:00', '', 0, '119602', 'москва', 'олимпийская деревня', '15', '', '183', '+7 495 3647771', '', '', '{}', '0000-00-00 00:00:00', 0),
(358, 'Ирина', 'Игоревна', 'Емельянова', '200317', 'turleika@mail.ru', '7c49defc72e9bf295a71b3d7e8229d47:LaA4JL3WpxV91QLu4TOwEfGOxM2VQsQk', '', 0, 1, '2012-12-25 14:05:54', '0000-00-00 00:00:00', '', 0, '129343', 'Москва', 'Нансена', '6', '', '48', '+79162652652', '+79166258477', '', '{}', '0000-00-00 00:00:00', 0),
(359, 'Олег', '', 'Халинбеков', '200318', 'oleg230876@yandex.ru', '45aa2f6e876fb7eabe537aeb53b4e123:X2oEdAMQ03IyDekoouhkHHIsikhH2HOO', '', 0, 1, '2013-01-21 11:14:07', '0000-00-00 00:00:00', '', 0, '140054', 'Котельники', 'Новая', '15', '', '43', '+7 905 5873200', '', '', '{}', '0000-00-00 00:00:00', 0),
(360, 'Администратор', '', 'аукциона', 'manager', 'admin@auction-ruseasons.ru', '682ee260aae4cc2a63d7c08c0e088c2a:ejrx4CigcUkgH95DRWg0NUqeFshgnPyB', '', 0, 1, '1970-01-01 04:00:00', '0000-00-00 00:00:00', 'Антикварный аукцион &quot;Русские сезоны&quot;', 0, 'zipcode', 'Санкт-Петербург', 'Набережная фонтанки', '24', '', '1', 'phone', '', '', '{}', '0000-00-00 00:00:00', 0),
(366, 'Сергунчик', 'Григоричь', 'Фамильнов', '200319', 'test22@email.com', '276a551ad09ce44444f8791690fcce89:o0u6EbibIt1OiavapaSv3KoTQtHWC1UN', '', 0, 0, '2013-03-02 08:00:02', '0000-00-00 00:00:00', 'Без фирмы я', 7, '347900', 'Урюпинск', 'Сезам', '25', 'Металлическый', '0', '+79044428447', '', '', '{}', '0000-00-00 00:00:00', 0),
(367, 'Имя', 'Отчество', 'Фамилия', '200320', 'test@email.com', '1686327acbb9403636484aa8e5196077:lff7cEmPaOjIDLsK4f0EH706B81oOAEt', '', 0, 0, '2013-03-02 08:23:57', '0000-00-00 00:00:00', 'Наименование фирмы', 7, 'Индекс', 'Город', 'Улица', 'Дом', 'Корпус', 'Квартира (офис)', 'Телефон 1', 'Телефон 2', '', '{}', '0000-00-00 00:00:00', 0),
(368, 'Джулcомэн', 'Джудович', 'Большеротый', '200321', 'sonja888888@email.com', '320f1329daf3e274aa97ebe78745a3f7:eKlsKdzcPYjOjZTyEXmLxmdX4Uk5qwT0', '', 0, 0, '2013-03-02 08:32:07', '2013-03-04 14:15:01', 'Наименование фирмы', 380, '318318', 'Кийв', 'Хрешатиг', '118/55', 'железный на этот раз', '0', '+3185154284', '0', '', '{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":""}', '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_viewlevels
--
INSERT INTO auc13_viewlevels VALUES
(1, 'Public', 0, '[1]'),
(2, 'Registered', 1, '[6,2,8]'),
(3, 'Special', 2, '[6,3,8]');

-- 
-- Вывод данных для таблицы auc13_virtuemart_adminmenuentries
--
INSERT INTO auc13_virtuemart_adminmenuentries VALUES
(1, 1, 0, 'COM_VIRTUEMART_CATEGORY_S', '', '', 'vmicon vmicon-16-folder_camera', 1, 1, '', 'category', ''),
(2, 1, 0, 'COM_VIRTUEMART_PRODUCT_S', '', '', 'vmicon vmicon-16-camera', 2, 1, '', 'product', ''),
(3, 1, 0, 'COM_VIRTUEMART_PRODUCT_CUSTOM_FIELD_S', '', '', 'vmicon vmicon-16-document_move', 5, 1, '', 'custom', ''),
(4, 1, 0, 'COM_VIRTUEMART_PRODUCT_INVENTORY', '', '', 'vmicon vmicon-16-price_watch', 7, 1, '', 'inventory', ''),
(5, 1, 0, 'COM_VIRTUEMART_CALC_S', '', '', 'vmicon vmicon-16-calculator', 8, 1, '', 'calc', ''),
(6, 1, 0, 'COM_VIRTUEMART_REVIEW_RATE_S', '', '', 'vmicon vmicon-16-comments', 9, 1, '', 'ratings', ''),
(7, 2, 0, 'COM_VIRTUEMART_ORDER_S', '', '', 'vmicon vmicon-16-page_white_stack', 1, 1, '', 'orders', ''),
(8, 2, 0, 'COM_VIRTUEMART_COUPON_S', '', '', 'vmicon vmicon-16-shopping', 10, 1, '', 'coupon', ''),
(9, 2, 0, 'COM_VIRTUEMART_REPORT', '', '', 'vmicon vmicon-16-to_do_list_cheked_1', 3, 1, '', 'report', ''),
(10, 2, 0, 'COM_VIRTUEMART_USER_S', '', '', 'vmicon vmicon-16-user', 4, 1, '', 'user', ''),
(11, 2, 0, 'COM_VIRTUEMART_SHOPPERGROUP_S', '', '', 'vmicon vmicon-16-user-group', 5, 1, '', 'shoppergroup', ''),
(12, 3, 0, 'COM_VIRTUEMART_MANUFACTURER_S', '', '', 'vmicon vmicon-16-wrench_orange', 1, 1, '', 'manufacturer', ''),
(13, 3, 0, 'COM_VIRTUEMART_MANUFACTURER_CATEGORY_S', '', '', 'vmicon vmicon-16-folder_wrench', 2, 1, '', 'manufacturercategories', ''),
(14, 4, 0, 'COM_VIRTUEMART_STORE', '', '', 'vmicon vmicon-16-reseller_account_template', 1, 1, '', 'user', 'editshop'),
(15, 4, 0, 'COM_VIRTUEMART_MEDIA_S', '', '', 'vmicon vmicon-16-pictures', 2, 1, '', 'media', ''),
(16, 4, 0, 'COM_VIRTUEMART_SHIPMENTMETHOD_S', '', '', 'vmicon vmicon-16-lorry', 3, 1, '', 'shipmentmethod', ''),
(17, 4, 0, 'COM_VIRTUEMART_PAYMENTMETHOD_S', '', '', 'vmicon vmicon-16-creditcards', 4, 1, '', 'paymentmethod', ''),
(18, 5, 0, 'COM_VIRTUEMART_CONFIGURATION', '', '', 'vmicon vmicon-16-config', 1, 1, '', 'config', ''),
(19, 5, 0, 'COM_VIRTUEMART_USERFIELD_S', '', '', 'vmicon vmicon-16-participation_rate', 2, 1, '', 'userfields', ''),
(20, 5, 0, 'COM_VIRTUEMART_ORDERSTATUS_S', '', '', 'vmicon vmicon-16-orderstatus', 3, 1, '', 'orderstatus', ''),
(21, 5, 0, 'COM_VIRTUEMART_CURRENCY_S', '', '', 'vmicon vmicon-16-coins', 5, 1, '', 'currency', ''),
(22, 5, 0, 'COM_VIRTUEMART_COUNTRY_S', '', '', 'vmicon vmicon-16-globe', 6, 1, '', 'country', ''),
(23, 11, 0, 'COM_VIRTUEMART_MIGRATION_UPDATE', '', '', 'vmicon vmicon-16-installer_box', 1, 1, '', 'updatesmigration', ''),
(24, 11, 0, 'COM_VIRTUEMART_ABOUT', '', '', 'vmicon vmicon-16-info', 2, 1, '', 'about', ''),
(25, 11, 0, 'COM_VIRTUEMART_HELP_TOPICS', 'http://virtuemart.net/', '', 'vmicon vmicon-16-help', 4, 1, '', '', ''),
(26, 11, 0, 'COM_VIRTUEMART_COMMUNITY_FORUM', 'http://forum.virtuemart.net/', '', 'vmicon vmicon-16-reseller_programm', 6, 1, '', '', ''),
(27, 11, 0, 'COM_VIRTUEMART_STATISTIC_SUMMARY', '', '', 'vmicon vmicon-16-info', 1, 1, '', 'virtuemart', ''),
(28, 77, 0, 'COM_VIRTUEMART_USER_GROUP_S', '', '', 'vmicon vmicon-16-user', 2, 1, '', 'usergroups', '');

-- 
-- Вывод данных для таблицы auc13_virtuemart_calc_categories
--

-- Таблица auctionru_2013.auc13_virtuemart_calc_categories не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_calc_countries
--

-- Таблица auctionru_2013.auc13_virtuemart_calc_countries не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_calc_shoppergroups
--

-- Таблица auctionru_2013.auc13_virtuemart_calc_shoppergroups не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_calc_states
--

-- Таблица auctionru_2013.auc13_virtuemart_calc_states не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_calcs
--

-- Таблица auctionru_2013.auc13_virtuemart_calcs не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_categories
--
INSERT INTO auc13_virtuemart_categories VALUES
(1, 1, '0', 'shop', '0', 15, 0, 10, 0, 10, 0, '', '', 1, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-20 09:55:28', 107, '0000-00-00 00:00:00', 0),
(2, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 2, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:50:55', 107, '0000-00-00 00:00:00', 0),
(3, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 3, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:51:13', 107, '0000-00-00 00:00:00', 0),
(4, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 4, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:51:35', 107, '0000-00-00 00:00:00', 0),
(5, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 5, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:52:07', 107, '0000-00-00 00:00:00', 0),
(6, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 6, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-26 18:10:34', 107, '0000-00-00 00:00:00', 0),
(7, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 7, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:52:45', 107, '0000-00-00 00:00:00', 0),
(8, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 8, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:53:00', 107, '0000-00-00 00:00:00', 0),
(9, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 9, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:54:07', 107, '0000-00-00 00:00:00', 0),
(10, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 10, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:54:21', 107, '0000-00-00 00:00:00', 0),
(11, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 11, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:54:34', 107, '0000-00-00 00:00:00', 0),
(12, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 12, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:54:49', 107, '0000-00-00 00:00:00', 0),
(13, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 13, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-17 21:36:08', 107, '0000-00-00 00:00:00', 0),
(14, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 14, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:55:20', 107, '0000-00-00 00:00:00', 0),
(15, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 16, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:55:39', 107, '0000-00-00 00:00:00', 0),
(16, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 15, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:57:21', 107, '0000-00-00 00:00:00', 0),
(51, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 3, 0, 1, '2013-02-17 08:31:33', 107, '2013-02-17 08:31:33', 107, '0000-00-00 00:00:00', 0),
(19, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 19, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:57:03', 107, '0000-00-00 00:00:00', 0),
(20, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 20, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-11 18:57:42', 107, '0000-00-00 00:00:00', 0),
(21, 1, '0', '0', '0', 1, 0, 10, 0, 10, 0, '', '', 1, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-25 16:46:37', 107, '0000-00-00 00:00:00', 0),
(22, 1, 'auction', 'fulltime', '0', 15, 0, 10, 0, 10, 0, '', '', 2, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-19 18:14:57', 107, '0000-00-00 00:00:00', 0),
(23, 1, 'auction', '0', '0', 15, 0, 10, 0, 10, 0, '', '', 3, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-20 22:10:36', 107, '0000-00-00 00:00:00', 0),
(24, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 1, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-20 15:15:55', 107, '0000-00-00 00:00:00', 0),
(25, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 2, 0, 1, '2013-02-12 08:46:42', 107, '2013-02-12 08:46:42', 107, '0000-00-00 00:00:00', 0),
(26, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 3, 0, 1, '2013-02-12 08:47:20', 107, '2013-02-12 08:47:20', 107, '0000-00-00 00:00:00', 0),
(27, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 4, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-20 15:25:40', 107, '0000-00-00 00:00:00', 0),
(28, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 5, 0, 1, '2013-02-12 08:48:07', 107, '2013-02-12 08:48:07', 107, '0000-00-00 00:00:00', 0),
(29, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 6, 0, 1, '2013-02-12 08:48:30', 107, '2013-02-12 08:48:30', 107, '0000-00-00 00:00:00', 0),
(30, 1, '0', 'fulltime', '0', 0, 0, 10, 0, 10, 0, '', '', 7, 0, 1, '2013-02-12 08:49:01', 107, '2013-02-12 08:49:01', 107, '0000-00-00 00:00:00', 0),
(31, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 1, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-17 23:02:33', 107, '0000-00-00 00:00:00', 0),
(32, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 2, 0, 1, '2013-02-12 08:49:59', 107, '2013-02-12 08:49:59', 107, '0000-00-00 00:00:00', 0),
(33, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 3, 0, 1, '2013-02-12 08:50:22', 107, '2013-02-12 08:50:22', 107, '0000-00-00 00:00:00', 0),
(34, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 4, 0, 1, '2013-02-12 08:50:47', 107, '2013-02-12 08:50:47', 107, '0000-00-00 00:00:00', 0),
(35, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 5, 0, 1, '2013-02-12 08:51:14', 107, '2013-02-12 08:51:14', 107, '0000-00-00 00:00:00', 0),
(36, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 6, 0, 1, '2013-02-12 08:51:36', 107, '2013-02-12 08:51:36', 107, '0000-00-00 00:00:00', 0),
(37, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 7, 0, 1, '2013-02-12 08:52:04', 107, '2013-02-12 08:52:04', 107, '0000-00-00 00:00:00', 0),
(38, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 8, 0, 1, '2013-02-12 08:52:29', 107, '2013-02-12 08:52:29', 107, '0000-00-00 00:00:00', 0),
(39, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 9, 0, 1, '2013-02-12 08:52:52', 107, '2013-02-12 08:52:52', 107, '0000-00-00 00:00:00', 0),
(40, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 10, 0, 1, '2013-02-12 08:53:14', 107, '2013-02-12 08:53:14', 107, '0000-00-00 00:00:00', 0),
(50, 1, '0', 'shop', '0', 0, 0, 10, 0, 10, 0, '', '', 3, 0, 1, '2013-02-17 08:31:02', 107, '2013-02-17 08:31:02', 107, '0000-00-00 00:00:00', 0),
(42, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 11, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-17 21:17:20', 107, '0000-00-00 00:00:00', 0),
(43, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 12, 0, 1, '2013-02-12 08:54:22', 107, '2013-02-12 08:54:22', 107, '0000-00-00 00:00:00', 0),
(44, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 13, 0, 1, '0000-00-00 00:00:00', 0, '2013-02-12 08:55:15', 107, '0000-00-00 00:00:00', 0),
(45, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 14, 0, 1, '2013-02-12 08:56:07', 107, '2013-02-12 08:56:07', 107, '0000-00-00 00:00:00', 0),
(46, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 15, 0, 1, '2013-02-12 08:56:29', 107, '2013-02-12 08:56:29', 107, '0000-00-00 00:00:00', 0),
(47, 1, '0', 'online', '0', 0, 0, 10, 0, 10, 0, '', '', 16, 0, 1, '2013-02-12 08:56:53', 107, '2013-02-12 08:56:53', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_categories_ru_ru
--
INSERT INTO auc13_virtuemart_categories_ru_ru VALUES
(1, 'Русская живопись', '', '', '', '', 'русская-живопись'),
(2, 'Западноевропейская живопись', '', '', '', '', 'zapadnoevropejskaya-zhivopis'),
(3, 'Советская живопись', '', '', '', '', 'sovetskaya-zhivopis'),
(4, 'Миниатюры', '', '', '', '', 'miniatyury'),
(5, 'Иконы', '', '', '', '', 'ikony'),
(6, 'Фарфор, керамика', '', '', '', '', 'farfor-keramika'),
(7, 'Фарфор, керамика после 1917 г.', '', '', '', '', 'farfor-keramika-posle-1917-g'),
(8, 'Стекло, хрусталь', '', '', '', '', 'steklo-khrustal'),
(9, 'Художественная бронза, чугун, шпиатр и пр.', '', '', '', '', 'khudozhestvennaya-bronza-chugun-shpiatr-i-pr'),
(10, 'Часы', '', '', '', '', 'chasy'),
(11, 'Предметы интерьера', '', '', '', '', 'predmety-interera'),
(12, 'Серебро', '', '', '', '', 'serebro'),
(13, 'Ювелирные изделия', '', '', '', '', 'ювелирные-изделия'),
(14, 'Восточное искусство', '', '', '', '', 'vostochnoe-iskusstvo'),
(15, 'Мебель', '', '', '', '', 'mebel'),
(16, 'Карты, гравюры, литографии', '', '', '', '', 'karty-gravyury'),
(19, 'Ткани, прочее...', '', '', '', '', 'tkani-prochee'),
(20, 'Разное', '', '', '', '', 'raznoe'),
(21, 'Онлайн торги', '', '', '', '', 'onlajn-torgi'),
(22, 'Очные торги', '', '', '', '', 'торги-в-помещении'),
(23, 'Магазин', '', '', '', '', 'магазин'),
(24, 'Живопись, графика', '', '', '', '', 'zhivopis-grafika'),
(25, 'Иконы', '', '', '', '', 'ikony2013-02-12-08-46-42_'),
(26, 'Декоративно-прикладное искусство', '', '', '', '', 'dekorativno-prikladnoe-iskusstvo'),
(27, 'Ювелирные изделия', '', '', '', '', 'yuvelirnye-izdeliya-torgi'),
(28, 'Предметы интерьера', '', '', '', '', 'predmety-interera2013-02-12-08-48-07_'),
(29, 'Мебель', '', '', '', '', 'mebel2013-02-12-08-48-30_'),
(30, 'Предметы коллекционирования', '', '', '', '', 'predmety-kollektsionirovaniya'),
(31, 'Русская живопись', '', '', '', '', 'живопись-руси'),
(32, 'Советская живопись', '', '', '', '', 'sovetskaya-zhivopis2013-02-12-08-49-59_'),
(33, 'Миниатюры', '', '', '', '', 'miniatyury2013-02-12-08-50-22_'),
(34, 'Иконы', '', '', '', '', 'ikony2013-02-12-08-50-47_'),
(35, 'Стекло, хрусталь', '', '', '', '', 'steklo-khrustal2013-02-12-08-51-14_'),
(36, 'Фарфор, керамика после 1917 г.', '', '', '', '', 'farfor-keramika-posle-1917-g2013-02-12-08-51-36_'),
(37, 'Художественная бронза, чугун, шпиатр и пр.', '', '', '', '', 'khudozhestvennaya-bronza-chugun-shpiatr-i-pr2013-02-12-08-52-04_'),
(38, 'Разное', '', '', '', '', 'raznoe2013-02-12-08-52-29_'),
(39, 'Предметы интерьера', '', '', '', '', 'predmety-interera2013-02-12-08-52-52_'),
(40, 'Серебро', '', '', '', '', 'serebro2013-02-12-08-53-14_'),
(42, 'Ювелирные изделия', '', '', '', '', 'yuvelirnye-izdeliya2013-02-17-21-17-20_'),
(43, 'Восточное искусство', '', '', '', '', 'vostochnoe-iskusstvo2013-02-12-08-54-22_'),
(44, 'Карты, гравюры, литографии', '', '', '', '', 'karty-gravyury2013-02-12-08-54-54'),
(45, 'Книги, разное', '', '', '', '', 'knigi-raznoe2013-02-12-08-56-07_'),
(46, 'Марки, открытки', '', '', '', '', 'marki-otkrytki2013-02-12-08-56-29_'),
(47, 'Ткани, прочее...', '', '', '', '', 'tkani-prochee2013-02-12-08-56-53_'),
(51, 'Марки, открытки', '', '', '', '', 'marki-otkrytki'),
(50, 'Книги, разное', '', '', '', '', 'knigi-raznoe');

-- 
-- Вывод данных для таблицы auc13_virtuemart_category_categories
--
INSERT INTO auc13_virtuemart_category_categories VALUES
(1, 23, 1, 1),
(2, 23, 2, 2),
(3, 23, 3, 3),
(4, 23, 4, 4),
(5, 23, 5, 5),
(6, 23, 6, 6),
(7, 23, 7, 7),
(8, 23, 8, 8),
(9, 23, 9, 9),
(10, 23, 10, 10),
(11, 23, 11, 11),
(12, 23, 12, 12),
(13, 23, 13, 13),
(14, 23, 14, 14),
(15, 23, 15, 15),
(16, 23, 16, 14),
(17, 23, 17, 17),
(18, 23, 18, 18),
(19, 23, 19, 19),
(20, 23, 20, 20),
(21, 0, 21, 1),
(22, 0, 22, 2),
(23, 0, 23, 3),
(24, 22, 24, 1),
(25, 22, 25, 3),
(26, 22, 26, 3),
(27, 22, 27, 4),
(28, 22, 28, 3),
(29, 22, 29, 3),
(30, 22, 30, 3),
(31, 21, 31, 1),
(32, 21, 32, 3),
(33, 21, 33, 3),
(34, 21, 34, 3),
(35, 21, 35, 3),
(36, 21, 36, 3),
(37, 21, 37, 3),
(38, 21, 38, 3),
(39, 21, 39, 3),
(40, 21, 40, 3),
(41, 21, 41, 3),
(42, 21, 42, 11),
(43, 21, 43, 3),
(44, 21, 44, 3),
(45, 21, 45, 3),
(46, 21, 46, 3),
(47, 21, 47, 3),
(48, 23, 48, 3),
(49, 23, 49, 3),
(50, 23, 50, 3),
(51, 23, 51, 3);

-- 
-- Вывод данных для таблицы auc13_virtuemart_category_medias
--
INSERT INTO auc13_virtuemart_category_medias VALUES
(1, 6, 2267, 1);

-- 
-- Вывод данных для таблицы auc13_virtuemart_configs
--
INSERT INTO auc13_virtuemart_configs VALUES
(1, 'shop_is_offline=s:1:"0";|offline_message=czo5Njoi0JzQsNCz0LDQt9C40L0g0LLRgNC10LzQtdC90L3QviDQvdC1INGA0LDQsdC+0YLQsNC10YIuINCX0LDQudC00LjRgtC1INC90LXQvNC90L7Qs9C+INC/0L7Qt9C20LUuIjs=|use_as_catalog=s:1:"0";|currency_converter_module=s:14:"convertECB.php";|order_mail_html=s:1:"1";|useSSL=s:1:"0";|dangeroustools=s:1:"0";|debug_enable=s:5:"admin";|google_jquery=s:1:"1";|multix=s:4:"none";|pdf_button_enable=s:1:"1";|show_emailfriend=s:1:"0";|show_printicon=s:1:"0";|show_out_of_stock_products=s:1:"1";|coupons_enable=s:1:"0";|show_uncat_child_products=s:1:"0";|coupons_default_expire=s:3:"1,D";|weight_unit_default=s:2:"KG";|lwh_unit_default=s:1:"M";|list_limit=s:2:"15";|showReviewFor=s:4:"none";|reviewMode=s:4:"none";|showRatingFor=s:4:"none";|ratingMode=s:4:"none";|reviews_autopublish=s:1:"0";|reviews_minimum_comment_length=s:3:"100";|reviews_maximum_comment_length=s:4:"2000";|vmtemplate=s:7:"default";|categorytemplate=s:7:"default";|showCategory=s:1:"1";|categorylayout=s:1:"0";|categories_per_row=s:2:"20";|productlayout=s:1:"0";|products_per_row=s:2:"20";|vmlayout=s:1:"0";|show_featured=s:1:"0";|featured_products_per_row=s:1:"3";|show_topTen=s:1:"0";|topten_products_per_row=s:1:"3";|show_recent=s:1:"0";|show_latest=s:1:"0";|assets_general_path=s:33:"components/com_virtuemart/assets/";|media_category_path=s:35:"images/stories/virtuemart/category/";|media_product_path=s:34:"images/stories/virtuemart/product/";|media_manufacturer_path=s:39:"images/stories/virtuemart/manufacturer/";|media_vendor_path=s:33:"images/stories/virtuemart/vendor/";|forSale_path_thumb=s:42:"images/stories/virtuemart/forSale/resized/";|img_resize_enable=s:1:"1";|img_width=s:3:"226";|img_height=s:3:"226";|no_image_set=s:11:"noimage.gif";|no_image_found=s:11:"warning.png";|browse_orderby_field=s:12:"product_name";|browse_orderby_fields=a:3:{i:0;s:12:"product_name";i:1;s:13:"category_name";i:2;s:13:"product_price";}|browse_search_fields=a:8:{i:0;s:12:"product_name";i:1;s:14:"`p`.created_on";i:2;s:14:"product_s_desc";i:3;s:12:"product_desc";i:4;s:13:"category_name";i:5;s:20:"category_description";i:6;s:7:"mf_name";i:7;s:13:"product_price";}|show_prices=s:1:"1";|price_show_packaging_pricelabel=s:1:"0";|show_tax=s:1:"0";|basePrice=s:1:"1";|basePriceText=s:1:"1";|basePriceRounding=s:2:"-1";|variantModification=s:1:"0";|variantModificationText=s:1:"0";|variantModificationRounding=s:2:"-1";|basePriceVariant=s:1:"0";|basePriceVariantText=s:1:"0";|basePriceVariantRounding=s:2:"-1";|basePriceWithTax=s:1:"0";|basePriceWithTaxText=s:1:"0";|basePriceWithTaxRounding=s:2:"-1";|discountedPriceWithoutTax=s:1:"0";|discountedPriceWithoutTaxText=s:1:"0";|discountedPriceWithoutTaxRounding=s:2:"-1";|salesPriceWithDiscount=s:1:"0";|salesPriceWithDiscountText=s:1:"0";|salesPriceWithDiscountRounding=s:2:"-1";|salesPrice=s:1:"1";|salesPriceText=s:1:"1";|salesPriceRounding=s:2:"-1";|priceWithoutTax=s:1:"0";|priceWithoutTaxText=s:1:"0";|priceWithoutTaxRounding=s:2:"-1";|discountAmount=s:1:"0";|discountAmountText=s:1:"0";|discountAmountRounding=s:2:"-1";|taxAmount=s:1:"0";|taxAmountText=s:1:"0";|taxAmountRounding=s:2:"-1";|addtocart_popup=s:1:"0";|check_stock=s:1:"0";|automatic_payment=s:1:"0";|automatic_shipment=s:1:"0";|agree_to_tos_onorder=s:1:"0";|oncheckout_show_legal_info=s:1:"0";|oncheckout_show_register=s:1:"0";|oncheckout_show_steps=s:1:"0";|oncheckout_show_register_text=s:47:"COM_VIRTUEMART_ONCHECKOUT_DEFAULT_TEXT_REGISTER";|seo_disabled=s:1:"0";|seo_translate=s:1:"0";|seo_use_id=s:1:"0";|sctime=d:1361967552.435306072235107421875;|vmlang=s:5:"ru_ru";|virtuemart_config_id=i:1;|enable_content_plugin=s:1:"1";|enableEnglish=s:1:"1";|pdf_icon=s:1:"0";|ask_question=s:1:"0";|asks_minimum_comment_length=s:2:"50";|asks_maximum_comment_length=s:4:"2000";|product_navigation=s:1:"0";|recommend_unauth=s:1:"0";|display_stock=s:1:"0";|latest_products_days=s:1:"7";|latest_products_orderBy=s:10:"created_on";|lstockmail=s:1:"0";|stockhandle=s:9:"disableit";|rised_availability=s:0:"";|image=s:0:"";|show_manufacturers=s:1:"0";|manufacturer_per_row=s:1:"3";|pagination_sequence=s:0:"";|forSale_path=s:48:"Z:\\home\\localhost\\www\\~auction.test\\logs\\vmsafe\\";|show_store_desc=s:1:"0";|show_categories=s:1:"1";|homepage_categories_per_row=s:1:"3";|homepage_products_per_row=s:1:"3";|featured_products_rows=s:1:"1";|topTen_products_rows=s:1:"1";|recent_products_rows=s:1:"1";|latest_products_rows=s:1:"1";|css=s:1:"1";|jquery=s:1:"1";|jprice=s:1:"1";|jsite=s:1:"1";|askprice=s:1:"0";|rappenrundung=s:1:"0";|roundindig=s:1:"0";|cVarswT=s:1:"0";|unitPrice=s:1:"0";|unitPriceText=s:1:"0";|unitPriceRounding=s:1:"2";|vmlang_js=s:1:"0";|oncheckout_only_registered=s:1:"0";|oncheckout_show_images=s:1:"1";|browse_cat_orderby_field=s:12:"product_name";|seo_sufix=s:7:"-detail";|task=s:5:"apply";|option=s:14:"com_virtuemart";|view=s:6:"config";|2d8a8d918774b4f9e50e21ca60d29a5a=s:1:"1";|active_languages=a:1:{i:0;s:5:"ru-RU";}|0d1ddec930e52247deef9728f3258f2d=s:1:"1";|b6a09fbc832846a69576b245a4d7c667=s:1:"1";|f97bb6b0f612e3d7c6f77728fe7307b2=s:1:"1";|6ec5d084bd924704e48725c893277eef=s:1:"1";|e25d8b7e8e6900e0f285b9834a89695d=s:1:"1";|290d918c9210914b0c7c518114c3b4d8=s:1:"1";|4587c4f3eb565c0c439cdd1ffc3cf32f=s:1:"1";|d79310fc9d2bbaf3835d7eff94f77cb3=s:1:"1";', '0000-00-00 00:00:00', 0, '2013-02-27 12:19:12', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_countries
--
INSERT INTO auc13_virtuemart_countries VALUES
(1, 1, 'Afghanistan', 'AFG', 'AF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 1, 'Albania', 'ALB', 'AL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 1, 'Algeria', 'DZA', 'DZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 1, 'American Samoa', 'ASM', 'AS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(5, 1, 'Andorra', 'AND', 'AD', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(6, 1, 'Angola', 'AGO', 'AO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(7, 1, 'Anguilla', 'AIA', 'AI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(8, 1, 'Antarctica', 'ATA', 'AQ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(9, 1, 'Antigua and Barbuda', 'ATG', 'AG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(10, 1, 'Argentina', 'ARG', 'AR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(11, 1, 'Armenia', 'ARM', 'AM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(12, 1, 'Aruba', 'ABW', 'AW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(13, 1, 'Australia', 'AUS', 'AU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(14, 1, 'Austria', 'AUT', 'AT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(15, 1, 'Azerbaijan', 'AZE', 'AZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(16, 1, 'Bahamas', 'BHS', 'BS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(17, 1, 'Bahrain', 'BHR', 'BH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(18, 1, 'Bangladesh', 'BGD', 'BD', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(19, 1, 'Barbados', 'BRB', 'BB', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(20, 1, 'Belarus', 'BLR', 'BY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(21, 1, 'Belgium', 'BEL', 'BE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(22, 1, 'Belize', 'BLZ', 'BZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(23, 1, 'Benin', 'BEN', 'BJ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(24, 1, 'Bermuda', 'BMU', 'BM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(25, 1, 'Bhutan', 'BTN', 'BT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(26, 1, 'Bolivia', 'BOL', 'BO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(27, 1, 'Bosnia and Herzegowina', 'BIH', 'BA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(28, 1, 'Botswana', 'BWA', 'BW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(29, 1, 'Bouvet Island', 'BVT', 'BV', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(30, 1, 'Brazil', 'BRA', 'BR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(31, 1, 'British Indian Ocean Territory', 'IOT', 'IO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(32, 1, 'Brunei Darussalam', 'BRN', 'BN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(33, 1, 'Bulgaria', 'BGR', 'BG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(34, 1, 'Burkina Faso', 'BFA', 'BF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(35, 1, 'Burundi', 'BDI', 'BI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(36, 1, 'Cambodia', 'KHM', 'KH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(37, 1, 'Cameroon', 'CMR', 'CM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(38, 1, 'Canada', 'CAN', 'CA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(39, 1, 'Cape Verde', 'CPV', 'CV', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(40, 1, 'Cayman Islands', 'CYM', 'KY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(41, 1, 'Central African Republic', 'CAF', 'CF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(42, 1, 'Chad', 'TCD', 'TD', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(43, 1, 'Chile', 'CHL', 'CL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(44, 1, 'China', 'CHN', 'CN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(45, 1, 'Christmas Island', 'CXR', 'CX', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(46, 1, 'Cocos (Keeling) Islands', 'CCK', 'CC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(47, 1, 'Colombia', 'COL', 'CO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(48, 1, 'Comoros', 'COM', 'KM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(49, 1, 'Congo', 'COG', 'CG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(50, 1, 'Cook Islands', 'COK', 'CK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(51, 1, 'Costa Rica', 'CRI', 'CR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(52, 1, 'Cote D''Ivoire', 'CIV', 'CI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(53, 1, 'Croatia', 'HRV', 'HR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(54, 1, 'Cuba', 'CUB', 'CU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(55, 1, 'Cyprus', 'CYP', 'CY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(56, 1, 'Czech Republic', 'CZE', 'CZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(57, 1, 'Denmark', 'DNK', 'DK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(58, 1, 'Djibouti', 'DJI', 'DJ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(59, 1, 'Dominica', 'DMA', 'DM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(60, 1, 'Dominican Republic', 'DOM', 'DO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(61, 1, 'East Timor', 'TMP', 'TP', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(62, 1, 'Ecuador', 'ECU', 'EC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(63, 1, 'Egypt', 'EGY', 'EG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(64, 1, 'El Salvador', 'SLV', 'SV', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(65, 1, 'Equatorial Guinea', 'GNQ', 'GQ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(66, 1, 'Eritrea', 'ERI', 'ER', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(67, 1, 'Estonia', 'EST', 'EE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(68, 1, 'Ethiopia', 'ETH', 'ET', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(69, 1, 'Falkland Islands (Malvinas)', 'FLK', 'FK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(70, 1, 'Faroe Islands', 'FRO', 'FO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(71, 1, 'Fiji', 'FJI', 'FJ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(72, 1, 'Finland', 'FIN', 'FI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(73, 1, 'France', 'FRA', 'FR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(75, 1, 'French Guiana', 'GUF', 'GF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(76, 1, 'French Polynesia', 'PYF', 'PF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(77, 1, 'French Southern Territories', 'ATF', 'TF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(78, 1, 'Gabon', 'GAB', 'GA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(79, 1, 'Gambia', 'GMB', 'GM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(80, 1, 'Georgia', 'GEO', 'GE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(81, 1, 'Germany', 'DEU', 'DE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(82, 1, 'Ghana', 'GHA', 'GH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(83, 1, 'Gibraltar', 'GIB', 'GI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(84, 1, 'Greece', 'GRC', 'GR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(85, 1, 'Greenland', 'GRL', 'GL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(86, 1, 'Grenada', 'GRD', 'GD', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(87, 1, 'Guadeloupe', 'GLP', 'GP', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(88, 1, 'Guam', 'GUM', 'GU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(89, 1, 'Guatemala', 'GTM', 'GT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(90, 1, 'Guinea', 'GIN', 'GN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(91, 1, 'Guinea-bissau', 'GNB', 'GW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(92, 1, 'Guyana', 'GUY', 'GY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(93, 1, 'Haiti', 'HTI', 'HT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(94, 1, 'Heard and Mc Donald Islands', 'HMD', 'HM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(95, 1, 'Honduras', 'HND', 'HN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(96, 1, 'Hong Kong', 'HKG', 'HK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(97, 1, 'Hungary', 'HUN', 'HU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(98, 1, 'Iceland', 'ISL', 'IS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(99, 1, 'India', 'IND', 'IN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(100, 1, 'Indonesia', 'IDN', 'ID', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(101, 1, 'Iran (Islamic Republic of)', 'IRN', 'IR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(102, 1, 'Iraq', 'IRQ', 'IQ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(103, 1, 'Ireland', 'IRL', 'IE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(104, 1, 'Israel', 'ISR', 'IL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(105, 1, 'Italy', 'ITA', 'IT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(106, 1, 'Jamaica', 'JAM', 'JM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(107, 1, 'Japan', 'JPN', 'JP', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(108, 1, 'Jordan', 'JOR', 'JO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(109, 1, 'Kazakhstan', 'KAZ', 'KZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(110, 1, 'Kenya', 'KEN', 'KE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(111, 1, 'Kiribati', 'KIR', 'KI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(112, 1, 'Korea, Democratic People''s Republic of', 'PRK', 'KP', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(113, 1, 'Korea, Republic of', 'KOR', 'KR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(114, 1, 'Kuwait', 'KWT', 'KW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(115, 1, 'Kyrgyzstan', 'KGZ', 'KG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(116, 1, 'Lao People''s Democratic Republic', 'LAO', 'LA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(117, 1, 'Latvia', 'LVA', 'LV', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(118, 1, 'Lebanon', 'LBN', 'LB', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(119, 1, 'Lesotho', 'LSO', 'LS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(120, 1, 'Liberia', 'LBR', 'LR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(121, 1, 'Libyan Arab Jamahiriya', 'LBY', 'LY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(122, 1, 'Liechtenstein', 'LIE', 'LI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(123, 1, 'Lithuania', 'LTU', 'LT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(124, 1, 'Luxembourg', 'LUX', 'LU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(125, 1, 'Macau', 'MAC', 'MO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(126, 1, 'Macedonia, The Former Yugoslav Republic of', 'MKD', 'MK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(127, 1, 'Madagascar', 'MDG', 'MG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(128, 1, 'Malawi', 'MWI', 'MW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(129, 1, 'Malaysia', 'MYS', 'MY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(130, 1, 'Maldives', 'MDV', 'MV', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(131, 1, 'Mali', 'MLI', 'ML', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(132, 1, 'Malta', 'MLT', 'MT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(133, 1, 'Marshall Islands', 'MHL', 'MH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(134, 1, 'Martinique', 'MTQ', 'MQ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(135, 1, 'Mauritania', 'MRT', 'MR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(136, 1, 'Mauritius', 'MUS', 'MU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(137, 1, 'Mayotte', 'MYT', 'YT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(138, 1, 'Mexico', 'MEX', 'MX', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(139, 1, 'Micronesia, Federated States of', 'FSM', 'FM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(140, 1, 'Moldova, Republic of', 'MDA', 'MD', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(141, 1, 'Monaco', 'MCO', 'MC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(142, 1, 'Mongolia', 'MNG', 'MN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(143, 1, 'Montserrat', 'MSR', 'MS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(144, 1, 'Morocco', 'MAR', 'MA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(145, 1, 'Mozambique', 'MOZ', 'MZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(146, 1, 'Myanmar', 'MMR', 'MM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(147, 1, 'Namibia', 'NAM', 'NA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(148, 1, 'Nauru', 'NRU', 'NR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(149, 1, 'Nepal', 'NPL', 'NP', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(150, 1, 'Netherlands', 'NLD', 'NL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(151, 1, 'Netherlands Antilles', 'ANT', 'AN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(152, 1, 'New Caledonia', 'NCL', 'NC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(153, 1, 'New Zealand', 'NZL', 'NZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(154, 1, 'Nicaragua', 'NIC', 'NI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(155, 1, 'Niger', 'NER', 'NE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(156, 1, 'Nigeria', 'NGA', 'NG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(157, 1, 'Niue', 'NIU', 'NU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(158, 1, 'Norfolk Island', 'NFK', 'NF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(159, 1, 'Northern Mariana Islands', 'MNP', 'MP', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(160, 1, 'Norway', 'NOR', 'NO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(161, 1, 'Oman', 'OMN', 'OM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(162, 1, 'Pakistan', 'PAK', 'PK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(163, 1, 'Palau', 'PLW', 'PW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(164, 1, 'Panama', 'PAN', 'PA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(165, 1, 'Papua New Guinea', 'PNG', 'PG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(166, 1, 'Paraguay', 'PRY', 'PY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(167, 1, 'Peru', 'PER', 'PE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(168, 1, 'Philippines', 'PHL', 'PH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(169, 1, 'Pitcairn', 'PCN', 'PN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(170, 1, 'Poland', 'POL', 'PL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(171, 1, 'Portugal', 'PRT', 'PT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(172, 1, 'Puerto Rico', 'PRI', 'PR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(173, 1, 'Qatar', 'QAT', 'QA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(174, 1, 'Reunion', 'REU', 'RE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(175, 1, 'Romania', 'ROM', 'RO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(176, 1, 'Russian Federation', 'RUS', 'RU', 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(177, 1, 'Rwanda', 'RWA', 'RW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(178, 1, 'Saint Kitts and Nevis', 'KNA', 'KN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(179, 1, 'Saint Lucia', 'LCA', 'LC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(180, 1, 'Saint Vincent and the Grenadines', 'VCT', 'VC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(181, 1, 'Samoa', 'WSM', 'WS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(182, 1, 'San Marino', 'SMR', 'SM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(183, 1, 'Sao Tome and Principe', 'STP', 'ST', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(184, 1, 'Saudi Arabia', 'SAU', 'SA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(185, 1, 'Senegal', 'SEN', 'SN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(186, 1, 'Seychelles', 'SYC', 'SC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(187, 1, 'Sierra Leone', 'SLE', 'SL', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(188, 1, 'Singapore', 'SGP', 'SG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(189, 1, 'Slovakia', 'SVK', 'SK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(190, 1, 'Slovenia', 'SVN', 'SI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(191, 1, 'Solomon Islands', 'SLB', 'SB', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(192, 1, 'Somalia', 'SOM', 'SO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(193, 1, 'South Africa', 'ZAF', 'ZA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(194, 1, 'South Georgia and the South Sandwich Islands', 'SGS', 'GS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(195, 1, 'Spain', 'ESP', 'ES', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(196, 1, 'Sri Lanka', 'LKA', 'LK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(197, 1, 'St. Helena', 'SHN', 'SH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(198, 1, 'St. Pierre and Miquelon', 'SPM', 'PM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(199, 1, 'Sudan', 'SDN', 'SD', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(200, 1, 'Suriname', 'SUR', 'SR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(201, 1, 'Svalbard and Jan Mayen Islands', 'SJM', 'SJ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(202, 1, 'Swaziland', 'SWZ', 'SZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(203, 1, 'Sweden', 'SWE', 'SE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(204, 1, 'Switzerland', 'CHE', 'CH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(205, 1, 'Syrian Arab Republic', 'SYR', 'SY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(206, 1, 'Taiwan', 'TWN', 'TW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(207, 1, 'Tajikistan', 'TJK', 'TJ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(208, 1, 'Tanzania, United Republic of', 'TZA', 'TZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(209, 1, 'Thailand', 'THA', 'TH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(210, 1, 'Togo', 'TGO', 'TG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(211, 1, 'Tokelau', 'TKL', 'TK', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(212, 1, 'Tonga', 'TON', 'TO', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(213, 1, 'Trinidad and Tobago', 'TTO', 'TT', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(214, 1, 'Tunisia', 'TUN', 'TN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(215, 1, 'Turkey', 'TUR', 'TR', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(216, 1, 'Turkmenistan', 'TKM', 'TM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(217, 1, 'Turks and Caicos Islands', 'TCA', 'TC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(218, 1, 'Tuvalu', 'TUV', 'TV', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(219, 1, 'Uganda', 'UGA', 'UG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(220, 1, 'Ukraine', 'UKR', 'UA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(221, 1, 'United Arab Emirates', 'ARE', 'AE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(222, 1, 'United Kingdom', 'GBR', 'GB', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(223, 1, 'United States', 'USA', 'US', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(224, 1, 'United States Minor Outlying Islands', 'UMI', 'UM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(225, 1, 'Uruguay', 'URY', 'UY', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(226, 1, 'Uzbekistan', 'UZB', 'UZ', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(227, 1, 'Vanuatu', 'VUT', 'VU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(228, 1, 'Vatican City State (Holy See)', 'VAT', 'VA', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(229, 1, 'Venezuela', 'VEN', 'VE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(230, 1, 'Viet Nam', 'VNM', 'VN', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(231, 1, 'Virgin Islands (British)', 'VGB', 'VG', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(232, 1, 'Virgin Islands (U.S.)', 'VIR', 'VI', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(233, 1, 'Wallis and Futuna Islands', 'WLF', 'WF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(234, 1, 'Western Sahara', 'ESH', 'EH', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(235, 1, 'Yemen', 'YEM', 'YE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(237, 1, 'The Democratic Republic of Congo', 'DRC', 'DC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(238, 1, 'Zambia', 'ZMB', 'ZM', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(239, 1, 'Zimbabwe', 'ZWE', 'ZW', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(240, 1, 'East Timor', 'XET', 'XE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(241, 1, 'Jersey', 'JEY', 'JE', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(242, 1, 'St. Barthelemy', 'XSB', 'XB', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(243, 1, 'St. Eustatius', 'XSE', 'XU', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(244, 1, 'Canary Islands', 'XCA', 'XC', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(245, 1, 'Serbia', 'SRB', 'RS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(246, 1, 'Sint Maarten (French Antilles)', 'MAF', 'MF', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(247, 1, 'Sint Maarten (Netherlands Antilles)', 'SXM', 'SX', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(248, 1, 'Palestinian Territory, occupied', 'PSE', 'PS', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_coupons
--

-- Таблица auctionru_2013.auc13_virtuemart_coupons не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_currencies
--
INSERT INTO auc13_virtuemart_currencies VALUES
(2, 1, 'United Arab Emirates dirham', '', 'AED', 784, 0.00000, 'د.إ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 1, 'Albanian lek', '', 'ALL', 8, 0.00000, 'Lek', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(5, 1, 'Netherlands Antillean gulden', '', 'ANG', 532, 0.00000, 'ƒ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(7, 1, 'Argentine peso', '', 'ARS', 32, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(9, 1, 'Australian dollar', '', 'AUD', 36, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(10, 1, 'Aruban florin', '', 'AWG', 533, 0.00000, 'ƒ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(11, 1, 'Barbadian dollar', '', 'BBD', 52, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(12, 1, 'Bangladeshi taka', '', 'BDT', 50, 0.00000, '৳', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(15, 1, 'Bahraini dinar', '', 'BHD', 48, 0.00000, 'ب.د', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(16, 1, 'Burundian franc', '', 'BIF', 108, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(17, 1, 'Bermudian dollar', '', 'BMD', 60, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(18, 1, 'Brunei dollar', '', 'BND', 96, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(19, 1, 'Bolivian boliviano', '', 'BOB', 68, 0.00000, '$b', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(20, 1, 'Brazilian real', '', 'BRL', 986, 0.00000, 'R$', '2', '.', ',', '{symbol} {number}', '{symbol} {sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(21, 1, 'Bahamian dollar', '', 'BSD', 44, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(22, 1, 'Bhutanese ngultrum', '', 'BTN', 64, 0.00000, 'BTN', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(24, 1, 'Botswana pula', '', 'BWP', 72, 0.00000, 'P', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(25, 1, 'Belize dollar', '', 'BZD', 84, 0.00000, 'BZ$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(26, 1, 'Canadian dollar', '', 'CAD', 124, 0.00000, '$', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(27, 1, 'Swiss franc', '', 'CHF', 756, 0.00000, 'CHF', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(28, 1, 'Unidad de Fomento', '', 'CLF', 990, 0.00000, 'CLF', '0', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(29, 1, 'Chilean peso', '', 'CLP', 152, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(30, 1, 'Chinese renminbi yuan', '', 'CNY', 156, 0.00000, '元', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(31, 1, 'Colombian peso', '', 'COP', 170, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(32, 1, 'Costa Rican colón', '', 'CRC', 188, 0.00000, '₡', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(33, 1, 'Czech koruna', '', 'CZK', 203, 0.00000, 'Kč', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(34, 1, 'Cuban peso', '', 'CUP', 192, 0.00000, '₱', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(35, 1, 'Cape Verdean escudo', '', 'CVE', 132, 0.00000, '$', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(40, 1, 'Danish krone', '', 'DKK', 208, 0.00000, 'kr', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(41, 1, 'Dominican peso', '', 'DOP', 214, 0.00000, 'RD$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(42, 1, 'Algerian dinar', '', 'DZD', 12, 0.00000, 'د.ج', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(44, 1, 'Egyptian pound', '', 'EGP', 818, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(46, 1, 'Ethiopian birr', '', 'ETB', 230, 0.00000, 'ETB', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(47, 1, 'Euro', '', 'EUR', 978, 0.00000, '€', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(49, 1, 'Fijian dollar', '', 'FJD', 242, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(50, 1, 'Falkland pound', '', 'FKP', 238, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(52, 1, 'British pound', '', 'GBP', 826, 0.00000, '£', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(54, 1, 'Gibraltar pound', '', 'GIP', 292, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(55, 1, 'Gambian dalasi', '', 'GMD', 270, 0.00000, 'D', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(56, 1, 'Guinean franc', '', 'GNF', 324, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(58, 1, 'Guatemalan quetzal', '', 'GTQ', 320, 0.00000, 'Q', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(60, 1, 'Guyanese dollar', '', 'GYD', 328, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(61, 1, 'Hong Kong dollar', '', 'HKD', 344, 0.00000, '元', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(62, 1, 'Honduran lempira', '', 'HNL', 340, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(63, 1, 'Haitian gourde', '', 'HTG', 332, 0.00000, 'G', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(64, 1, 'Hungarian forint', '', 'HUF', 348, 0.00000, 'Ft', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(65, 1, 'Indonesian rupiah', '', 'IDR', 360, 0.00000, 'Rp', '0', '', '', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(67, 1, 'Israeli new sheqel', '', 'ILS', 376, 0.00000, '₪', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(68, 1, 'Indian rupee', '', 'INR', 356, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(69, 1, 'Iraqi dinar', '', 'IQD', 368, 0.00000, 'ع.د', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(70, 1, 'Iranian rial', '', 'IRR', 364, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number}{symb0l}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(73, 1, 'Jamaican dollar', '', 'JMD', 388, 0.00000, 'J$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(74, 1, 'Jordanian dinar', '', 'JOD', 400, 0.00000, 'د.ا', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(75, 1, 'Japanese yen', '', 'JPY', 392, 0.00000, '¥', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(76, 1, 'Kenyan shilling', '', 'KES', 404, 0.00000, 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(77, 1, 'Cambodian riel', '', 'KHR', 116, 0.00000, '៛', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(78, 1, 'Comorian franc', '', 'KMF', 174, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(79, 1, 'North Korean won', '', 'KPW', 408, 0.00000, '₩', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(80, 1, 'South Korean won', '', 'KRW', 410, 0.00000, '₩', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(81, 1, 'Kuwaiti dinar', '', 'KWD', 414, 0.00000, 'د.ك', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(82, 1, 'Cayman Islands dollar', '', 'KYD', 136, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(83, 1, 'Lao kip', '', 'LAK', 418, 0.00000, '₭', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(84, 1, 'Lebanese pound', '', 'LBP', 422, 0.00000, '£', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(85, 1, 'Sri Lankan rupee', '', 'LKR', 144, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(86, 1, 'Liberian dollar', '', 'LRD', 430, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(87, 1, 'Lesotho loti', '', 'LSL', 426, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(89, 1, 'Libyan dinar', '', 'LYD', 434, 0.00000, 'ل.د', '3', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(90, 1, 'Moroccan dirham', '', 'MAD', 504, 0.00000, 'د.م.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(92, 1, 'Mongolian tögrög', '', 'MNT', 496, 0.00000, '₮', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(93, 1, 'Macanese pataca', '', 'MOP', 446, 0.00000, 'P', '1', ',', '', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(94, 1, 'Mauritanian ouguiya', '', 'MRO', 478, 0.00000, 'UM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(96, 1, 'Mauritian rupee', '', 'MUR', 480, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(97, 1, 'Maldivian rufiyaa', '', 'MVR', 462, 0.00000, 'ރ.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(98, 1, 'Malawian kwacha', '', 'MWK', 454, 0.00000, 'MK', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(100, 1, 'Malaysian ringgit', '', 'MYR', 458, 0.00000, 'RM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(102, 1, 'Nigerian naira', '', 'NGN', 566, 0.00000, '₦', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(105, 1, 'Norwegian krone', '', 'NOK', 578, 0.00000, 'kr', '2', ',', '', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(106, 1, 'Nepalese rupee', '', 'NPR', 524, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(107, 1, 'New Zealand dollar', '', 'NZD', 554, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(108, 1, 'Omani rial', '', 'OMR', 512, 0.00000, '﷼', '3', '.', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(109, 1, 'Panamanian balboa', '', 'PAB', 590, 0.00000, 'B/.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(110, 1, 'Peruvian nuevo sol', '', 'PEN', 604, 0.00000, 'S/.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(111, 1, 'Papua New Guinean kina', '', 'PGK', 598, 0.00000, 'K', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(112, 1, 'Philippine peso', '', 'PHP', 608, 0.00000, '₱', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(113, 1, 'Pakistani rupee', '', 'PKR', 586, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(114, 1, 'Polish Złoty', '', 'PLN', 985, 0.00000, 'zł', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(116, 1, 'Paraguayan guaraní', '', 'PYG', 600, 0.00000, '₲', '0', '', '.', '{symbol} {number}', '{symbol} {sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(117, 1, 'Qatari riyal', '', 'QAR', 634, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(118, 1, 'Romanian leu', '', 'RON', 946, 0.00000, 'lei', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(119, 1, 'Rwandan franc', '', 'RWF', 646, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(120, 1, 'Saudi riyal', '', 'SAR', 682, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(121, 1, 'Solomon Islands dollar', '', 'SBD', 90, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(122, 1, 'Seychellois rupee', '', 'SCR', 690, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(124, 1, 'Swedish krona', '', 'SEK', 752, 0.00000, 'kr', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(125, 1, 'Singapore dollar', '', 'SGD', 702, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(126, 1, 'Saint Helenian pound', '', 'SHP', 654, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(127, 1, 'Sierra Leonean leone', '', 'SLL', 694, 0.00000, 'Le', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(128, 1, 'Somali shilling', '', 'SOS', 706, 0.00000, 'S', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(130, 1, 'São Tomé and Príncipe dobra', '', 'STD', 678, 0.00000, 'Db', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(131, 1, 'Russian ruble', '', 'RUB', 643, 0.00000, 'руб', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(132, 1, 'Salvadoran colón', '', 'SVC', 222, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(133, 1, 'Syrian pound', '', 'SYP', 760, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(134, 1, 'Swazi lilangeni', '', 'SZL', 748, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(135, 1, 'Thai baht', '', 'THB', 764, 0.00000, '฿', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(136, 1, 'Tunisian dinar', '', 'TND', 788, 0.00000, 'د.ت', '3', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(137, 1, 'Tongan paʻanga', '', 'TOP', 776, 0.00000, 'T$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(139, 1, 'Turkish new lira', '', 'TRY', 949, 0.00000, 'YTL', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(140, 1, 'Trinidad and Tobago dollar', '', 'TTD', 780, 0.00000, 'TT$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(141, 1, 'New Taiwan dollar', '', 'TWD', 901, 0.00000, 'NT$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(142, 1, 'Tanzanian shilling', '', 'TZS', 834, 0.00000, 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(144, 1, 'United States dollar', '', 'USD', 840, 0.00000, '$', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(147, 1, 'Vietnamese Dong', '', 'VND', 704, 0.00000, '₫', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(148, 1, 'Vanuatu vatu', '', 'VUV', 548, 0.00000, 'Vt', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(149, 1, 'Samoan tala', '', 'WST', 882, 0.00000, 'T', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(151, 1, 'Yemeni rial', '', 'YER', 886, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(152, 1, 'Serbian dinar', '', 'RSD', 941, 0.00000, 'Дин.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(153, 1, 'South African rand', '', 'ZAR', 710, 0.00000, 'R', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(154, 1, 'Zambian kwacha', '', 'ZMK', 894, 0.00000, 'ZK', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(156, 1, 'Zimbabwean dollar', '', 'ZWD', 932, 0.00000, 'Z$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(158, 1, 'Armenian dram', '', 'AMD', 51, 0.00000, 'դր.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(159, 1, 'Myanmar kyat', '', 'MMK', 104, 0.00000, 'K', '2', ',', '', '{number} {symbol}', '{symbol} {sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(160, 1, 'Croatian kuna', '', 'HRK', 191, 0.00000, 'kn', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(161, 1, 'Eritrean nakfa', '', 'ERN', 232, 0.00000, 'Nfk', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(162, 1, 'Djiboutian franc', '', 'DJF', 262, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(163, 1, 'Icelandic króna', '', 'ISK', 352, 0.00000, 'kr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(164, 1, 'Kazakhstani tenge', '', 'KZT', 398, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(165, 1, 'Kyrgyzstani som', '', 'KGS', 417, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(166, 1, 'Latvian lats', '', 'LVL', 428, 0.00000, 'Ls', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(167, 1, 'Lithuanian litas', '', 'LTL', 440, 0.00000, 'Lt', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(168, 1, 'Mexican peso', '', 'MXN', 484, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(169, 1, 'Moldovan leu', '', 'MDL', 498, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(170, 1, 'Namibian dollar', '', 'NAD', 516, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(171, 1, 'Nicaraguan córdoba', '', 'NIO', 558, 0.00000, 'C$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(172, 1, 'Ugandan shilling', '', 'UGX', 800, 0.00000, 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(173, 1, 'Macedonian denar', '', 'MKD', 807, 0.00000, 'ден', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(174, 1, 'Uruguayan peso', '', 'UYU', 858, 0.00000, '$', '0', '', '', '{symbol}number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(175, 1, 'Uzbekistani som', '', 'UZS', 860, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(176, 1, 'Azerbaijani manat', '', 'AZN', 934, 0.00000, 'ман', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(177, 1, 'Ghanaian cedi', '', 'GHS', 936, 0.00000, '₵', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(178, 1, 'Venezuelan bolívar', '', 'VEF', 937, 0.00000, 'Bs', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(179, 1, 'Sudanese pound', '', 'SDG', 938, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(180, 1, 'Uruguay Peso', '', 'UYI', 940, 0.00000, 'UYI', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(181, 1, 'Mozambican metical', '', 'MZN', 943, 0.00000, 'MT', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(182, 1, 'WIR Euro', '', 'CHE', 947, 0.00000, '€', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(183, 1, 'WIR Franc', '', 'CHW', 948, 0.00000, 'CHW', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(184, 1, 'Central African CFA franc', '', 'XAF', 950, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(185, 1, 'East Caribbean dollar', '', 'XCD', 951, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(186, 1, 'West African CFA franc', '', 'XOF', 952, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(187, 1, 'CFP franc', '', 'XPF', 953, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(188, 1, 'Surinamese dollar', '', 'SRD', 968, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(189, 1, 'Malagasy ariary', '', 'MGA', 969, 0.00000, 'MGA', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(190, 1, 'Unidad de Valor Real', '', 'COU', 970, 0.00000, 'COU', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(191, 1, 'Afghan afghani', '', 'AFN', 971, 0.00000, '؋', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(192, 1, 'Tajikistani somoni', '', 'TJS', 972, 0.00000, 'ЅМ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(193, 1, 'Angolan kwanza', '', 'AOA', 973, 0.00000, 'Kz', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(194, 1, 'Belarusian ruble', '', 'BYR', 974, 0.00000, 'p.', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(195, 1, 'Bulgarian lev', '', 'BGN', 975, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(196, 1, 'Congolese franc', '', 'CDF', 976, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(197, 1, 'Bosnia and Herzegovina convert', '', 'BAM', 977, 0.00000, 'KM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(198, 1, 'Mexican Unid', '', 'MXV', 979, 0.00000, 'MXV', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(199, 1, 'Ukrainian hryvnia', '', 'UAH', 980, 0.00000, '₴', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(200, 1, 'Georgian lari', '', 'GEL', 981, 0.00000, 'ლ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(201, 1, 'Mvdol', '', 'BOV', 984, 0.00000, 'BOV', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_customs
--
INSERT INTO auc13_virtuemart_customs VALUES
(1, 0, 1, 0, '', 0, 'COM_VIRTUEMART_RELATED_PRODUCTS', 'COM_VIRTUEMART_RELATED_PRODUCTS_TIP', '', 'COM_VIRTUEMART_RELATED_PRODUCTS_DESC', 'R', 0, 0, 0, NULL, NULL, 0, 1, '2011-05-25 21:52:43', 62, 0, '2011-05-25 21:52:43', 62, '0000-00-00 00:00:00', 0),
(2, 0, 1, 0, '', 0, 'COM_VIRTUEMART_RELATED_CATEGORIES', 'COM_VIRTUEMART_RELATED_CATEGORIES_TIP', NULL, 'COM_VIRTUEMART_RELATED_CATEGORIES_DESC', 'Z', 0, 0, 0, NULL, NULL, 0, 1, '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 0, 1, 0, '0', 1, 'Порядковый номер', '', '', '', 'I', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:26:42', 107, 0, '2013-02-11 19:26:42', 107, '0000-00-00 00:00:00', 0),
(4, 0, 1, 0, '0', 0, 'Base image URL', '', '', 'Путь к главной картинке категории', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:27:28', 107, 0, '2013-02-11 19:27:28', 107, '0000-00-00 00:00:00', 0),
(7, 0, 1, 0, '0', 0, 'Номер аукциона', '', '', '', 'I', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:29:36', 107, 0, '2013-02-11 19:29:36', 107, '0000-00-00 00:00:00', 0),
(8, 0, 1, 0, '0', 0, 'Номер договора', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:30:05', 107, 0, '2013-02-11 19:30:05', 107, '0000-00-00 00:00:00', 0),
(10, 0, 1, 0, '0', 0, 'Start', '', '', 'Стартовая цена', 'I', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:31:14', 107, 0, '2013-02-11 19:31:14', 107, '0000-00-00 00:00:00', 0),
(11, 0, 1, 0, '0', 0, 'Stop', '', '', 'Последняя цена', 'I', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:31:38', 107, 0, '2013-02-11 19:31:38', 107, '0000-00-00 00:00:00', 0),
(12, 0, 1, 0, '0', 0, 'Base Image URL 1', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:31:55', 107, 0, '2013-02-11 19:31:55', 107, '0000-00-00 00:00:00', 0),
(13, 0, 1, 0, '0', 0, 'Base Image URL 2', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:32:13', 107, 0, '2013-02-11 19:32:13', 107, '0000-00-00 00:00:00', 0),
(14, 0, 1, 0, '0', 0, 'Base Image URL 3', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:32:33', 107, 0, '2013-02-11 19:32:33', 107, '0000-00-00 00:00:00', 0),
(15, 0, 1, 0, '0', 0, 'Base Image URL 4', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:32:55', 107, 0, '2013-02-11 19:32:55', 107, '0000-00-00 00:00:00', 0),
(16, 0, 1, 0, '0', 0, 'Base Image URL 5', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:33:08', 107, 0, '2013-02-11 19:33:08', 107, '0000-00-00 00:00:00', 0),
(17, 0, 1, 0, '0', 0, 'Base Image URL 6', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:33:21', 107, 0, '2013-02-11 19:33:21', 107, '0000-00-00 00:00:00', 0),
(18, 0, 1, 0, '0', 0, 'Base Image URL 7', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:33:35', 107, 0, '2013-02-11 19:33:35', 107, '0000-00-00 00:00:00', 0),
(19, 0, 1, 0, '0', 0, 'Base Image URL 8', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:33:50', 107, 0, '2013-02-11 19:33:50', 107, '0000-00-00 00:00:00', 0),
(20, 0, 1, 0, '0', 0, 'Base Image URL 9', '', '', '', 'S', 0, 0, 0, '', '0', 0, 1, '2013-02-11 19:34:03', 107, 0, '2013-02-11 19:34:03', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_invoices
--

-- Таблица auctionru_2013.auc13_virtuemart_invoices не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_manufacturer_medias
--

-- Таблица auctionru_2013.auc13_virtuemart_manufacturer_medias не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_manufacturercategories
--
INSERT INTO auc13_virtuemart_manufacturercategories VALUES
(1, 0, '0000-00-00 00:00:00', 0, '2013-02-12 08:35:34', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_manufacturercategories_ru_ru
--
INSERT INTO auc13_virtuemart_manufacturercategories_ru_ru VALUES
(1, 'Владельцы предметов аукциона', 'Владельцы предметов аукциона.', 'vladeltsy-predmetov-auktsiona');

-- 
-- Вывод данных для таблицы auc13_virtuemart_manufacturers
--
INSERT INTO auc13_virtuemart_manufacturers VALUES
(1, 1, 0, 0, '2013-02-12 08:36:22', 107, '2013-02-12 08:36:22', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_manufacturers_ru_ru
--
INSERT INTO auc13_virtuemart_manufacturers_ru_ru VALUES
(1, 'Частное лицо', '', '<p>Владелец предмета.</p>', '', 'chastnoe-litso');

-- 
-- Вывод данных для таблицы auc13_virtuemart_medias
--
INSERT INTO auc13_virtuemart_medias VALUES
(1, 1, '400233_302009606572052_1336194996_n.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/400233_302009606572052_1336194996_n.jpg', 'images/stories/virtuemart/product/resized/400233_302009606572052_1336194996_n_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-13 16:33:54', 107, '2013-02-13 16:33:54', 107, '0000-00-00 00:00:00', 0),
(1991, 1, '02_214_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_03_3.jpg', 'images/stories/virtuemart/product/resized/02_214_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1992, 1, '02_215_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1935, 1, '02_210_03.1_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_7.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1936, 1, '02_210_03.1_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_8.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1937, 1, '02_210_03.1_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_9.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1938, 1, '02_210_03.2_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1939, 1, '02_210_03.2_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_2.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1940, 1, '02_210_03.2_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_3.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1941, 1, '02_210_03.2_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_4.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1942, 1, '02_210_03.2_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_5.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1943, 1, '02_210_03.2_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_6.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1944, 1, '02_210_03.2_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_7.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1945, 1, '02_210_03.2_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.2_8.jpg', 'images/stories/virtuemart/product/resized/02_210_03.2_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1946, 1, '02_210_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1947, 1, '02_210_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_2.jpg', 'images/stories/virtuemart/product/resized/02_210_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1948, 1, '02_210_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_3.jpg', 'images/stories/virtuemart/product/resized/02_210_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1949, 1, '02_210_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_4.jpg', 'images/stories/virtuemart/product/resized/02_210_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1950, 1, '02_210_06_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_5.jpg', 'images/stories/virtuemart/product/resized/02_210_06_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1951, 1, '02_210_06_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_6.jpg', 'images/stories/virtuemart/product/resized/02_210_06_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1952, 1, '02_210_06_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_7.jpg', 'images/stories/virtuemart/product/resized/02_210_06_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1953, 1, '02_210_06_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_8.jpg', 'images/stories/virtuemart/product/resized/02_210_06_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1954, 1, '02_210_06_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_06_9.jpg', 'images/stories/virtuemart/product/resized/02_210_06_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1955, 1, '02_210_07_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1956, 1, '02_210_07_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_2.jpg', 'images/stories/virtuemart/product/resized/02_210_07_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1957, 1, '02_210_07_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_3.jpg', 'images/stories/virtuemart/product/resized/02_210_07_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1958, 1, '02_210_07_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_4.jpg', 'images/stories/virtuemart/product/resized/02_210_07_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1959, 1, '02_210_07_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_5.jpg', 'images/stories/virtuemart/product/resized/02_210_07_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1960, 1, '02_210_07_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_6.jpg', 'images/stories/virtuemart/product/resized/02_210_07_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1961, 1, '02_210_07_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_7.jpg', 'images/stories/virtuemart/product/resized/02_210_07_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1962, 1, '02_210_07_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_8.jpg', 'images/stories/virtuemart/product/resized/02_210_07_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1963, 1, '02_210_07_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_07_9.jpg', 'images/stories/virtuemart/product/resized/02_210_07_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1964, 1, '02_212_08_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_212_08_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1965, 1, '02_212_08_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_212_08_2.jpg', 'images/stories/virtuemart/product/resized/02_212_08_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1966, 1, '02_213_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1967, 1, '02_213_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_02_2.jpg', 'images/stories/virtuemart/product/resized/02_213_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1968, 1, '02_213_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_02_3.jpg', 'images/stories/virtuemart/product/resized/02_213_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1969, 1, '02_213_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_02_4.jpg', 'images/stories/virtuemart/product/resized/02_213_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1970, 1, '02_213_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1971, 1, '02_213_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_05_2.jpg', 'images/stories/virtuemart/product/resized/02_213_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1972, 1, '02_213_05_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_05_3.jpg', 'images/stories/virtuemart/product/resized/02_213_05_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1973, 1, '02_213_05_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_05_4.jpg', 'images/stories/virtuemart/product/resized/02_213_05_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1974, 1, '02_213_05_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_05_5.jpg', 'images/stories/virtuemart/product/resized/02_213_05_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1975, 1, '02_213_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1976, 1, '02_213_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_06_2.jpg', 'images/stories/virtuemart/product/resized/02_213_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1977, 1, '02_213_07_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_07_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1978, 1, '02_213_07_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_07_2.jpg', 'images/stories/virtuemart/product/resized/02_213_07_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1979, 1, '02_214_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1980, 1, '02_214_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_2.jpg', 'images/stories/virtuemart/product/resized/02_214_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1981, 1, '02_214_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_3.jpg', 'images/stories/virtuemart/product/resized/02_214_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1982, 1, '02_214_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_4.jpg', 'images/stories/virtuemart/product/resized/02_214_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1983, 1, '02_214_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_5.jpg', 'images/stories/virtuemart/product/resized/02_214_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1984, 1, '02_214_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_6.jpg', 'images/stories/virtuemart/product/resized/02_214_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1985, 1, '02_214_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_01_7.jpg', 'images/stories/virtuemart/product/resized/02_214_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1986, 1, '02_214_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1987, 1, '02_214_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_02_2.jpg', 'images/stories/virtuemart/product/resized/02_214_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1988, 1, '02_214_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_02_3.jpg', 'images/stories/virtuemart/product/resized/02_214_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1989, 1, '02_214_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1990, 1, '02_214_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_03_2.jpg', 'images/stories/virtuemart/product/resized/02_214_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1921, 1, '02_210_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1922, 1, '02_210_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_2.jpg', 'images/stories/virtuemart/product/resized/02_210_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1923, 1, '02_210_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_3.jpg', 'images/stories/virtuemart/product/resized/02_210_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1924, 1, '02_210_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_4.jpg', 'images/stories/virtuemart/product/resized/02_210_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1925, 1, '02_210_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_5.jpg', 'images/stories/virtuemart/product/resized/02_210_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1926, 1, '02_210_02_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_6.jpg', 'images/stories/virtuemart/product/resized/02_210_02_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1927, 1, '02_210_02_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_7.jpg', 'images/stories/virtuemart/product/resized/02_210_02_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1928, 1, '02_210_02_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_02_8.jpg', 'images/stories/virtuemart/product/resized/02_210_02_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1929, 1, '02_210_03.1_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1930, 1, '02_210_03.1_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_2.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1931, 1, '02_210_03.1_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_3.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1932, 1, '02_210_03.1_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_4.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1933, 1, '02_210_03.1_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_5.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1934, 1, '02_210_03.1_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_03.1_6.jpg', 'images/stories/virtuemart/product/resized/02_210_03.1_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1608, 1, '02_188_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1609, 1, '02_188_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_2.jpg', 'images/stories/virtuemart/product/resized/02_188_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1610, 1, '02_188_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_3.jpg', 'images/stories/virtuemart/product/resized/02_188_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1611, 1, '02_188_03_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_4.jpg', 'images/stories/virtuemart/product/resized/02_188_03_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1612, 1, '02_188_03_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_5.jpg', 'images/stories/virtuemart/product/resized/02_188_03_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1613, 1, '02_188_03_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_6.jpg', 'images/stories/virtuemart/product/resized/02_188_03_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1614, 1, '02_188_03_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_7.jpg', 'images/stories/virtuemart/product/resized/02_188_03_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1615, 1, '02_188_03_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_8.jpg', 'images/stories/virtuemart/product/resized/02_188_03_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1616, 1, '02_200_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1617, 1, '02_200_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_2.jpg', 'images/stories/virtuemart/product/resized/02_200_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1618, 1, '02_200_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_3.jpg', 'images/stories/virtuemart/product/resized/02_200_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1619, 1, '02_200_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_4.jpg', 'images/stories/virtuemart/product/resized/02_200_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1620, 1, '02_200_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_5.jpg', 'images/stories/virtuemart/product/resized/02_200_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1621, 1, '02_202_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_202_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(2267, 1, '104357.jpg', '', '', 'image/jpeg', 'category', 'images/stories/virtuemart/category/104357.jpg', 'images/stories/virtuemart/category/resized/104357_226x226.jpg', 0, 0, 0, '', 0, 1, '2013-02-26 18:10:34', 107, '2013-02-26 18:10:34', 107, '0000-00-00 00:00:00', 0),
(1622, 1, '02_202_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_202_04_2.jpg', 'images/stories/virtuemart/product/resized/02_202_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1623, 1, '02_202_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_202_04_3.jpg', 'images/stories/virtuemart/product/resized/02_202_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1624, 1, '02_204_17_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1625, 1, '02_204_17_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_2.jpg', 'images/stories/virtuemart/product/resized/02_204_17_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1626, 1, '02_204_17_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_3.jpg', 'images/stories/virtuemart/product/resized/02_204_17_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1627, 1, '02_204_17_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_4.jpg', 'images/stories/virtuemart/product/resized/02_204_17_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1628, 1, '02_204_17_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_5.jpg', 'images/stories/virtuemart/product/resized/02_204_17_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1629, 1, '02_204_17_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_6.jpg', 'images/stories/virtuemart/product/resized/02_204_17_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1630, 1, '02_204_17_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_7.jpg', 'images/stories/virtuemart/product/resized/02_204_17_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1631, 1, '02_204_17_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_8.jpg', 'images/stories/virtuemart/product/resized/02_204_17_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1632, 1, '02_204_17_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_9.jpg', 'images/stories/virtuemart/product/resized/02_204_17_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1633, 1, '02_204_17_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_10.jpg', 'images/stories/virtuemart/product/resized/02_204_17_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1634, 1, '02_204_17_11.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_11.jpg', 'images/stories/virtuemart/product/resized/02_204_17_11.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1635, 1, '02_204_17_12.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_12.jpg', 'images/stories/virtuemart/product/resized/02_204_17_12.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1636, 1, '02_205_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1637, 1, '02_205_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_2.jpg', 'images/stories/virtuemart/product/resized/02_205_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1638, 1, '02_205_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_3.jpg', 'images/stories/virtuemart/product/resized/02_205_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1639, 1, '02_205_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_4.jpg', 'images/stories/virtuemart/product/resized/02_205_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1640, 1, '02_205_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_5.jpg', 'images/stories/virtuemart/product/resized/02_205_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1641, 1, '02_205_02_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_6.jpg', 'images/stories/virtuemart/product/resized/02_205_02_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1642, 1, '02_205_02_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_7.jpg', 'images/stories/virtuemart/product/resized/02_205_02_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1643, 1, '02_206_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1644, 1, '02_206_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_2.jpg', 'images/stories/virtuemart/product/resized/02_206_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1645, 1, '02_206_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_3.jpg', 'images/stories/virtuemart/product/resized/02_206_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1646, 1, '02_206_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_4.jpg', 'images/stories/virtuemart/product/resized/02_206_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1647, 1, '02_206_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_5.jpg', 'images/stories/virtuemart/product/resized/02_206_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1648, 1, '02_206_02_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_6.jpg', 'images/stories/virtuemart/product/resized/02_206_02_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1649, 1, '02_206_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(2174, 1, 'icon_02_213_09_1.jpg_product', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/icon_02_213_09_2.jpg', 'images/stories/virtuemart/product/resized/icon_02_213_09_2_226x226.jpg', 0, 0, 0, '', 0, 1, '0000-00-00 00:00:00', 0, '2013-02-24 19:17:18', 107, '0000-00-00 00:00:00', 0),
(1650, 1, '02_206_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_2.jpg', 'images/stories/virtuemart/product/resized/02_206_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1651, 1, '02_206_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_3.jpg', 'images/stories/virtuemart/product/resized/02_206_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1652, 1, '02_206_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_4.jpg', 'images/stories/virtuemart/product/resized/02_206_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1653, 1, '02_206_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_5.jpg', 'images/stories/virtuemart/product/resized/02_206_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1654, 1, '02_206_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_6.jpg', 'images/stories/virtuemart/product/resized/02_206_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1655, 1, '02_206_21_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(2175, 1, 'icon_02_213_09_1.jpg_product', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/icon_02_213_09_24.jpg', 'images/stories/virtuemart/product/resized/icon_02_213_09_24_226x226.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:19:47', 107, '2013-02-24 19:19:47', 107, '0000-00-00 00:00:00', 0),
(1656, 1, '02_206_21_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_2.jpg', 'images/stories/virtuemart/product/resized/02_206_21_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1657, 1, '02_206_21_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_3.jpg', 'images/stories/virtuemart/product/resized/02_206_21_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1658, 1, '02_206_21_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_4.jpg', 'images/stories/virtuemart/product/resized/02_206_21_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1659, 1, '02_206_21_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_5.jpg', 'images/stories/virtuemart/product/resized/02_206_21_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1660, 1, '02_207_08_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1661, 1, '02_207_08_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_2.jpg', 'images/stories/virtuemart/product/resized/02_207_08_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1662, 1, '02_207_08_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_3.jpg', 'images/stories/virtuemart/product/resized/02_207_08_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1663, 1, '02_207_08_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_4.jpg', 'images/stories/virtuemart/product/resized/02_207_08_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1664, 1, '02_207_08_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_5.jpg', 'images/stories/virtuemart/product/resized/02_207_08_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1665, 1, '02_208_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1666, 1, '02_208_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_2.jpg', 'images/stories/virtuemart/product/resized/02_208_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1667, 1, '02_208_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_3.jpg', 'images/stories/virtuemart/product/resized/02_208_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1668, 1, '02_208_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_4.jpg', 'images/stories/virtuemart/product/resized/02_208_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1669, 1, '02_208_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_5.jpg', 'images/stories/virtuemart/product/resized/02_208_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1670, 1, '02_208_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_6.jpg', 'images/stories/virtuemart/product/resized/02_208_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1671, 1, '02_208_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_7.jpg', 'images/stories/virtuemart/product/resized/02_208_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1672, 1, '02_208_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(2173, 1, 'icon_02_213_09_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/icon_02_213_09_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:11:31', 107, '2013-02-24 19:11:31', 107, '0000-00-00 00:00:00', 0),
(1673, 1, '02_208_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_2.jpg', 'images/stories/virtuemart/product/resized/02_208_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1674, 1, '02_208_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_3.jpg', 'images/stories/virtuemart/product/resized/02_208_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1675, 1, '02_208_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_4.jpg', 'images/stories/virtuemart/product/resized/02_208_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1676, 1, '02_208_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_5.jpg', 'images/stories/virtuemart/product/resized/02_208_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1677, 1, '02_208_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_6.jpg', 'images/stories/virtuemart/product/resized/02_208_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1678, 1, '02_208_04_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_7.jpg', 'images/stories/virtuemart/product/resized/02_208_04_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1679, 1, '02_208_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(2172, 1, 'icon_02_199_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/icon_02_199_02_2.jpg', 'images/stories/virtuemart/product/resized/icon_02_199_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:11:31', 107, '2013-02-24 19:11:31', 107, '0000-00-00 00:00:00', 0),
(1680, 1, '02_208_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_2.jpg', 'images/stories/virtuemart/product/resized/02_208_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1681, 1, '02_208_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_3.jpg', 'images/stories/virtuemart/product/resized/02_208_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1682, 1, '02_208_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_4.jpg', 'images/stories/virtuemart/product/resized/02_208_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1683, 1, '02_212_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_212_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1684, 1, '02_212_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_212_05_2.jpg', 'images/stories/virtuemart/product/resized/02_212_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1685, 1, '02_213_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1686, 1, '02_213_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_2.jpg', 'images/stories/virtuemart/product/resized/02_213_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1687, 1, '02_213_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_3.jpg', 'images/stories/virtuemart/product/resized/02_213_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1688, 1, '02_213_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_4.jpg', 'images/stories/virtuemart/product/resized/02_213_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1689, 1, '02_213_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_5.jpg', 'images/stories/virtuemart/product/resized/02_213_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1690, 1, '02_213_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_6.jpg', 'images/stories/virtuemart/product/resized/02_213_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1691, 1, '02_213_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_7.jpg', 'images/stories/virtuemart/product/resized/02_213_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1692, 1, '02_214_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1693, 1, '02_214_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_2.jpg', 'images/stories/virtuemart/product/resized/02_214_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1694, 1, '02_214_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_3.jpg', 'images/stories/virtuemart/product/resized/02_214_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1695, 1, '02_214_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_4.jpg', 'images/stories/virtuemart/product/resized/02_214_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1696, 1, '02_215_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1697, 1, '02_215_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_01_2.jpg', 'images/stories/virtuemart/product/resized/02_215_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1698, 1, '02_215_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_01_3.jpg', 'images/stories/virtuemart/product/resized/02_215_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:52:01', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(1699, 1, '02_198_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(2268, 1, '02_215_03_4.jpg_product', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/4463922.jpg', 'images/stories/virtuemart/product/resized/4463922_226x226.jpg', 0, 0, 0, '', 0, 1, '2013-02-27 17:28:59', 107, '2013-02-27 17:28:59', 107, '0000-00-00 00:00:00', 0),
(1700, 1, '02_198_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_2.jpg', 'images/stories/virtuemart/product/resized/02_198_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1701, 1, '02_198_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_3.jpg', 'images/stories/virtuemart/product/resized/02_198_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1702, 1, '02_198_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_4.jpg', 'images/stories/virtuemart/product/resized/02_198_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1703, 1, '02_198_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_5.jpg', 'images/stories/virtuemart/product/resized/02_198_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1704, 1, '02_198_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_6.jpg', 'images/stories/virtuemart/product/resized/02_198_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1705, 1, '02_198_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_01_7.jpg', 'images/stories/virtuemart/product/resized/02_198_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1706, 1, '02_198_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1707, 1, '02_198_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_2.jpg', 'images/stories/virtuemart/product/resized/02_198_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1708, 1, '02_198_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_3.jpg', 'images/stories/virtuemart/product/resized/02_198_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1709, 1, '02_198_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_4.jpg', 'images/stories/virtuemart/product/resized/02_198_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1710, 1, '02_198_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_5.jpg', 'images/stories/virtuemart/product/resized/02_198_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1711, 1, '02_198_02_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_6.jpg', 'images/stories/virtuemart/product/resized/02_198_02_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1712, 1, '02_198_02_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_7.jpg', 'images/stories/virtuemart/product/resized/02_198_02_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1713, 1, '02_198_02_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_198_02_8.jpg', 'images/stories/virtuemart/product/resized/02_198_02_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1714, 1, '02_201_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1715, 1, '02_201_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_2.jpg', 'images/stories/virtuemart/product/resized/02_201_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1716, 1, '02_201_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_3.jpg', 'images/stories/virtuemart/product/resized/02_201_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1717, 1, '02_201_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_4.jpg', 'images/stories/virtuemart/product/resized/02_201_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1718, 1, '02_201_06_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_5.jpg', 'images/stories/virtuemart/product/resized/02_201_06_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1719, 1, '02_201_06_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_6.jpg', 'images/stories/virtuemart/product/resized/02_201_06_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1720, 1, '02_201_06_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_7.jpg', 'images/stories/virtuemart/product/resized/02_201_06_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1721, 1, '02_201_06_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_8.jpg', 'images/stories/virtuemart/product/resized/02_201_06_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1722, 1, '02_201_06_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_06_9.jpg', 'images/stories/virtuemart/product/resized/02_201_06_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1723, 1, '02_209_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_209_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1724, 1, '02_209_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_209_03_2.jpg', 'images/stories/virtuemart/product/resized/02_209_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1725, 1, '02_209_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_209_03_3.jpg', 'images/stories/virtuemart/product/resized/02_209_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1726, 1, '02_209_03_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_209_03_4.jpg', 'images/stories/virtuemart/product/resized/02_209_03_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1727, 1, '02_209_03_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_209_03_5.jpg', 'images/stories/virtuemart/product/resized/02_209_03_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1728, 1, '02_209_03_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_209_03_6.jpg', 'images/stories/virtuemart/product/resized/02_209_03_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1729, 1, '02_217_10_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_10_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1730, 1, '02_217_10_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_10_2.jpg', 'images/stories/virtuemart/product/resized/02_217_10_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(1731, 1, '02_188_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1732, 1, '02_188_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_01_2.jpg', 'images/stories/virtuemart/product/resized/02_188_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1733, 1, '02_188_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_01_3.jpg', 'images/stories/virtuemart/product/resized/02_188_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1734, 1, '02_188_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_01_4.jpg', 'images/stories/virtuemart/product/resized/02_188_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1735, 1, '02_188_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_01_5.jpg', 'images/stories/virtuemart/product/resized/02_188_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1736, 1, '02_188_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1737, 1, '02_188_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_02_2.jpg', 'images/stories/virtuemart/product/resized/02_188_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1738, 1, '02_188_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_02_3.jpg', 'images/stories/virtuemart/product/resized/02_188_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1739, 1, '02_188_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_02_4.jpg', 'images/stories/virtuemart/product/resized/02_188_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1740, 1, '02_188_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_02_5.jpg', 'images/stories/virtuemart/product/resized/02_188_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1741, 1, '02_188_02_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_02_6.jpg', 'images/stories/virtuemart/product/resized/02_188_02_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1742, 1, '02_188_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1743, 1, '02_188_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_05_2.jpg', 'images/stories/virtuemart/product/resized/02_188_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1744, 1, '02_188_05_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_05_3.jpg', 'images/stories/virtuemart/product/resized/02_188_05_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1745, 1, '02_188_05_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_05_4.jpg', 'images/stories/virtuemart/product/resized/02_188_05_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1746, 1, '02_199_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1747, 1, '02_199_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_04_2.jpg', 'images/stories/virtuemart/product/resized/02_199_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1748, 1, '02_199_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_04_3.jpg', 'images/stories/virtuemart/product/resized/02_199_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1749, 1, '02_199_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_04_4.jpg', 'images/stories/virtuemart/product/resized/02_199_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1750, 1, '02_199_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_04_5.jpg', 'images/stories/virtuemart/product/resized/02_199_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1751, 1, '02_199_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_04_6.jpg', 'images/stories/virtuemart/product/resized/02_199_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1752, 1, '02_201_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1753, 1, '02_201_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_2.jpg', 'images/stories/virtuemart/product/resized/02_201_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1754, 1, '02_201_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_3.jpg', 'images/stories/virtuemart/product/resized/02_201_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1755, 1, '02_201_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_4.jpg', 'images/stories/virtuemart/product/resized/02_201_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1756, 1, '02_201_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_5.jpg', 'images/stories/virtuemart/product/resized/02_201_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1757, 1, '02_201_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_6.jpg', 'images/stories/virtuemart/product/resized/02_201_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1758, 1, '02_201_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_7.jpg', 'images/stories/virtuemart/product/resized/02_201_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1759, 1, '02_201_01_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_8.jpg', 'images/stories/virtuemart/product/resized/02_201_01_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1760, 1, '02_201_01_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_9.jpg', 'images/stories/virtuemart/product/resized/02_201_01_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1761, 1, '02_201_01_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_01_10.jpg', 'images/stories/virtuemart/product/resized/02_201_01_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1762, 1, '02_201_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1763, 1, '02_201_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_02_2.jpg', 'images/stories/virtuemart/product/resized/02_201_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1764, 1, '02_201_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_02_3.jpg', 'images/stories/virtuemart/product/resized/02_201_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1765, 1, '02_201_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1766, 1, '02_201_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_2.jpg', 'images/stories/virtuemart/product/resized/02_201_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1767, 1, '02_201_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_3.jpg', 'images/stories/virtuemart/product/resized/02_201_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1768, 1, '02_201_03_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_4.jpg', 'images/stories/virtuemart/product/resized/02_201_03_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1769, 1, '02_201_03_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_5.jpg', 'images/stories/virtuemart/product/resized/02_201_03_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1770, 1, '02_201_03_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_6.jpg', 'images/stories/virtuemart/product/resized/02_201_03_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1771, 1, '02_201_03_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_7.jpg', 'images/stories/virtuemart/product/resized/02_201_03_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1772, 1, '02_201_03_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_8.jpg', 'images/stories/virtuemart/product/resized/02_201_03_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1773, 1, '02_201_03_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_9.jpg', 'images/stories/virtuemart/product/resized/02_201_03_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1774, 1, '02_201_03_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_03_10.jpg', 'images/stories/virtuemart/product/resized/02_201_03_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1775, 1, '02_201_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1776, 1, '02_201_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_04_2.jpg', 'images/stories/virtuemart/product/resized/02_201_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1777, 1, '02_201_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_04_3.jpg', 'images/stories/virtuemart/product/resized/02_201_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1778, 1, '02_201_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_04_4.jpg', 'images/stories/virtuemart/product/resized/02_201_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1779, 1, '02_201_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_201_04_5.jpg', 'images/stories/virtuemart/product/resized/02_201_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1780, 1, '02_203_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1781, 1, '02_203_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_2.jpg', 'images/stories/virtuemart/product/resized/02_203_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1782, 1, '02_203_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_3.jpg', 'images/stories/virtuemart/product/resized/02_203_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1783, 1, '02_203_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_4.jpg', 'images/stories/virtuemart/product/resized/02_203_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1784, 1, '02_203_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_5.jpg', 'images/stories/virtuemart/product/resized/02_203_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1785, 1, '02_203_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_6.jpg', 'images/stories/virtuemart/product/resized/02_203_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1786, 1, '02_203_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_7.jpg', 'images/stories/virtuemart/product/resized/02_203_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1787, 1, '02_203_01_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_8.jpg', 'images/stories/virtuemart/product/resized/02_203_01_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1788, 1, '02_203_01_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_9.jpg', 'images/stories/virtuemart/product/resized/02_203_01_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1789, 1, '02_203_01_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_01_10.jpg', 'images/stories/virtuemart/product/resized/02_203_01_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1790, 1, '02_203_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1791, 1, '02_203_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_2.jpg', 'images/stories/virtuemart/product/resized/02_203_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1792, 1, '02_203_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_3.jpg', 'images/stories/virtuemart/product/resized/02_203_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1793, 1, '02_203_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_4.jpg', 'images/stories/virtuemart/product/resized/02_203_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1794, 1, '02_203_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_5.jpg', 'images/stories/virtuemart/product/resized/02_203_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1795, 1, '02_203_02_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_6.jpg', 'images/stories/virtuemart/product/resized/02_203_02_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1796, 1, '02_203_02_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_02_7.jpg', 'images/stories/virtuemart/product/resized/02_203_02_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1797, 1, '02_203_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1798, 1, '02_203_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_04_2.jpg', 'images/stories/virtuemart/product/resized/02_203_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1799, 1, '02_203_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_04_3.jpg', 'images/stories/virtuemart/product/resized/02_203_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1800, 1, '02_203_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_04_4.jpg', 'images/stories/virtuemart/product/resized/02_203_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1801, 1, '02_203_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_04_5.jpg', 'images/stories/virtuemart/product/resized/02_203_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1802, 1, '02_203_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_04_6.jpg', 'images/stories/virtuemart/product/resized/02_203_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1803, 1, '02_203_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1804, 1, '02_203_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_2.jpg', 'images/stories/virtuemart/product/resized/02_203_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1805, 1, '02_203_05_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_3.jpg', 'images/stories/virtuemart/product/resized/02_203_05_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1806, 1, '02_203_05_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_4.jpg', 'images/stories/virtuemart/product/resized/02_203_05_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1807, 1, '02_203_05_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_5.jpg', 'images/stories/virtuemart/product/resized/02_203_05_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1808, 1, '02_203_05_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_6.jpg', 'images/stories/virtuemart/product/resized/02_203_05_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1809, 1, '02_203_05_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_05_7.jpg', 'images/stories/virtuemart/product/resized/02_203_05_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1810, 1, '02_203_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1811, 1, '02_203_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_2.jpg', 'images/stories/virtuemart/product/resized/02_203_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1812, 1, '02_203_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_3.jpg', 'images/stories/virtuemart/product/resized/02_203_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1813, 1, '02_203_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_4.jpg', 'images/stories/virtuemart/product/resized/02_203_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1814, 1, '02_203_06_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_5.jpg', 'images/stories/virtuemart/product/resized/02_203_06_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1815, 1, '02_203_06_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_6.jpg', 'images/stories/virtuemart/product/resized/02_203_06_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1816, 1, '02_203_06_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_7.jpg', 'images/stories/virtuemart/product/resized/02_203_06_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1817, 1, '02_203_06_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_8.jpg', 'images/stories/virtuemart/product/resized/02_203_06_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1818, 1, '02_203_06_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_9.jpg', 'images/stories/virtuemart/product/resized/02_203_06_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1819, 1, '02_203_06_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_06_10.jpg', 'images/stories/virtuemart/product/resized/02_203_06_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1820, 1, '02_204_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1821, 1, '02_204_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_2.jpg', 'images/stories/virtuemart/product/resized/02_204_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1822, 1, '02_204_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_3.jpg', 'images/stories/virtuemart/product/resized/02_204_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1823, 1, '02_204_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_4.jpg', 'images/stories/virtuemart/product/resized/02_204_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1824, 1, '02_204_06_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_5.jpg', 'images/stories/virtuemart/product/resized/02_204_06_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1825, 1, '02_204_06_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_6.jpg', 'images/stories/virtuemart/product/resized/02_204_06_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1826, 1, '02_204_06_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_7.jpg', 'images/stories/virtuemart/product/resized/02_204_06_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1827, 1, '02_204_06_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_8.jpg', 'images/stories/virtuemart/product/resized/02_204_06_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1828, 1, '02_204_06_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_9.jpg', 'images/stories/virtuemart/product/resized/02_204_06_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1829, 1, '02_204_06_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_06_10.jpg', 'images/stories/virtuemart/product/resized/02_204_06_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1830, 1, '02_204_10_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1831, 1, '02_204_10_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_2.jpg', 'images/stories/virtuemart/product/resized/02_204_10_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1832, 1, '02_204_10_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_3.jpg', 'images/stories/virtuemart/product/resized/02_204_10_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1833, 1, '02_204_10_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_4.jpg', 'images/stories/virtuemart/product/resized/02_204_10_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1834, 1, '02_204_10_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_5.jpg', 'images/stories/virtuemart/product/resized/02_204_10_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1835, 1, '02_204_10_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_6.jpg', 'images/stories/virtuemart/product/resized/02_204_10_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1836, 1, '02_204_10_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_7.jpg', 'images/stories/virtuemart/product/resized/02_204_10_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1837, 1, '02_204_10_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_8.jpg', 'images/stories/virtuemart/product/resized/02_204_10_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1838, 1, '02_204_10_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_10_9.jpg', 'images/stories/virtuemart/product/resized/02_204_10_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1839, 1, '02_204_14_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1840, 1, '02_204_14_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_2.jpg', 'images/stories/virtuemart/product/resized/02_204_14_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1841, 1, '02_204_14_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_3.jpg', 'images/stories/virtuemart/product/resized/02_204_14_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1842, 1, '02_204_14_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_4.jpg', 'images/stories/virtuemart/product/resized/02_204_14_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1843, 1, '02_204_14_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_5.jpg', 'images/stories/virtuemart/product/resized/02_204_14_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1844, 1, '02_204_14_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_6.jpg', 'images/stories/virtuemart/product/resized/02_204_14_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1845, 1, '02_204_14_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_7.jpg', 'images/stories/virtuemart/product/resized/02_204_14_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1846, 1, '02_204_14_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_8.jpg', 'images/stories/virtuemart/product/resized/02_204_14_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1847, 1, '02_204_14_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_9.jpg', 'images/stories/virtuemart/product/resized/02_204_14_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1848, 1, '02_204_14_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_14_10.jpg', 'images/stories/virtuemart/product/resized/02_204_14_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1849, 1, '02_206_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1850, 1, '02_206_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_01_2.jpg', 'images/stories/virtuemart/product/resized/02_206_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1851, 1, '02_206_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_01_3.jpg', 'images/stories/virtuemart/product/resized/02_206_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1852, 1, '02_206_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_01_4.jpg', 'images/stories/virtuemart/product/resized/02_206_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1853, 1, '02_206_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_01_5.jpg', 'images/stories/virtuemart/product/resized/02_206_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1854, 1, '02_206_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1855, 1, '02_206_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_06_2.jpg', 'images/stories/virtuemart/product/resized/02_206_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1856, 1, '02_206_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_06_3.jpg', 'images/stories/virtuemart/product/resized/02_206_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1857, 1, '02_206_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_06_4.jpg', 'images/stories/virtuemart/product/resized/02_206_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1858, 1, '02_206_06_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_06_5.jpg', 'images/stories/virtuemart/product/resized/02_206_06_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1859, 1, '02_206_06_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_06_6.jpg', 'images/stories/virtuemart/product/resized/02_206_06_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1860, 1, '02_206_09_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_09_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1861, 1, '02_206_09_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_09_2.jpg', 'images/stories/virtuemart/product/resized/02_206_09_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1862, 1, '02_206_10_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2272, 1, '02_215_03_4.jpg_product', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/green-flash-1.jpg', 'images/stories/virtuemart/product/resized/green-flash-1_226x226.jpg', 0, 0, 0, '', 0, 1, '2013-02-27 17:31:01', 107, '2013-02-27 17:31:01', 107, '0000-00-00 00:00:00', 0),
(1863, 1, '02_206_10_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_2.jpg', 'images/stories/virtuemart/product/resized/02_206_10_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1864, 1, '02_206_10_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_3.jpg', 'images/stories/virtuemart/product/resized/02_206_10_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1865, 1, '02_206_10_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_4.jpg', 'images/stories/virtuemart/product/resized/02_206_10_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1866, 1, '02_206_10_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_5.jpg', 'images/stories/virtuemart/product/resized/02_206_10_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1867, 1, '02_206_10_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_6.jpg', 'images/stories/virtuemart/product/resized/02_206_10_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1868, 1, '02_206_10_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_10_7.jpg', 'images/stories/virtuemart/product/resized/02_206_10_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1869, 1, '02_206_11_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_11_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1870, 1, '02_206_11_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_11_2.jpg', 'images/stories/virtuemart/product/resized/02_206_11_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1871, 1, '02_206_11_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_11_3.jpg', 'images/stories/virtuemart/product/resized/02_206_11_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1872, 1, '02_206_11_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_11_4.jpg', 'images/stories/virtuemart/product/resized/02_206_11_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1873, 1, '02_206_11_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_11_5.jpg', 'images/stories/virtuemart/product/resized/02_206_11_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1874, 1, '02_206_20_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_20_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1875, 1, '02_206_20_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_20_2.jpg', 'images/stories/virtuemart/product/resized/02_206_20_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1876, 1, '02_206_20_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_20_3.jpg', 'images/stories/virtuemart/product/resized/02_206_20_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1877, 1, '02_206_20_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_20_4.jpg', 'images/stories/virtuemart/product/resized/02_206_20_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1878, 1, '02_206_29_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_29_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1879, 1, '02_206_29_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_29_2.jpg', 'images/stories/virtuemart/product/resized/02_206_29_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1880, 1, '02_206_29_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_29_3.jpg', 'images/stories/virtuemart/product/resized/02_206_29_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1881, 1, '02_206_29_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_29_4.jpg', 'images/stories/virtuemart/product/resized/02_206_29_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1882, 1, '02_206_29_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_29_5.jpg', 'images/stories/virtuemart/product/resized/02_206_29_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1883, 1, '02_207_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1884, 1, '02_207_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_2.jpg', 'images/stories/virtuemart/product/resized/02_207_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1885, 1, '02_207_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_3.jpg', 'images/stories/virtuemart/product/resized/02_207_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1886, 1, '02_207_01_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_4.jpg', 'images/stories/virtuemart/product/resized/02_207_01_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1887, 1, '02_207_01_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_5.jpg', 'images/stories/virtuemart/product/resized/02_207_01_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1888, 1, '02_207_01_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_6.jpg', 'images/stories/virtuemart/product/resized/02_207_01_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1889, 1, '02_207_01_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_7.jpg', 'images/stories/virtuemart/product/resized/02_207_01_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1890, 1, '02_207_01_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_8.jpg', 'images/stories/virtuemart/product/resized/02_207_01_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1891, 1, '02_207_01_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_9.jpg', 'images/stories/virtuemart/product/resized/02_207_01_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1892, 1, '02_207_01_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_01_10.jpg', 'images/stories/virtuemart/product/resized/02_207_01_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1893, 1, '02_208_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1894, 1, '02_208_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_02_2.jpg', 'images/stories/virtuemart/product/resized/02_208_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1895, 1, '02_208_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_02_3.jpg', 'images/stories/virtuemart/product/resized/02_208_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1896, 1, '02_208_02_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_02_4.jpg', 'images/stories/virtuemart/product/resized/02_208_02_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1897, 1, '02_208_02_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_02_5.jpg', 'images/stories/virtuemart/product/resized/02_208_02_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1898, 1, '02_208_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1899, 1, '02_208_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_2.jpg', 'images/stories/virtuemart/product/resized/02_208_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1900, 1, '02_208_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_3.jpg', 'images/stories/virtuemart/product/resized/02_208_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1901, 1, '02_208_03_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_4.jpg', 'images/stories/virtuemart/product/resized/02_208_03_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1902, 1, '02_208_03_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_5.jpg', 'images/stories/virtuemart/product/resized/02_208_03_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1903, 1, '02_208_03_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_6.jpg', 'images/stories/virtuemart/product/resized/02_208_03_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1904, 1, '02_208_03_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_03_7.jpg', 'images/stories/virtuemart/product/resized/02_208_03_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1905, 1, '02_208_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1906, 1, '02_208_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_05_2.jpg', 'images/stories/virtuemart/product/resized/02_208_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1907, 1, '02_208_05_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_05_3.jpg', 'images/stories/virtuemart/product/resized/02_208_05_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1908, 1, '02_208_05_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_05_4.jpg', 'images/stories/virtuemart/product/resized/02_208_05_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1909, 1, '02_208_07_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_07_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1910, 1, '02_208_07_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_07_2.jpg', 'images/stories/virtuemart/product/resized/02_208_07_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1911, 1, '02_208_07_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_07_3.jpg', 'images/stories/virtuemart/product/resized/02_208_07_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1912, 1, '02_208_07_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_07_4.jpg', 'images/stories/virtuemart/product/resized/02_208_07_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1913, 1, '02_208_08_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1914, 1, '02_208_08_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_2.jpg', 'images/stories/virtuemart/product/resized/02_208_08_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1915, 1, '02_208_08_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_3.jpg', 'images/stories/virtuemart/product/resized/02_208_08_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1916, 1, '02_208_08_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_4.jpg', 'images/stories/virtuemart/product/resized/02_208_08_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1917, 1, '02_208_08_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_5.jpg', 'images/stories/virtuemart/product/resized/02_208_08_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1918, 1, '02_208_08_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_6.jpg', 'images/stories/virtuemart/product/resized/02_208_08_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1919, 1, '02_208_08_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_7.jpg', 'images/stories/virtuemart/product/resized/02_208_08_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1920, 1, '02_208_08_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_08_8.jpg', 'images/stories/virtuemart/product/resized/02_208_08_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1993, 1, '02_215_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_02_2.jpg', 'images/stories/virtuemart/product/resized/02_215_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1994, 1, '02_215_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_02_3.jpg', 'images/stories/virtuemart/product/resized/02_215_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1995, 1, '02_215_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_1.jpg', 'images/stories/virtuemart/product/resized/02_215_03_1_226x226.jpg', 0, 0, 0, '', 0, 1, '0000-00-00 00:00:00', 0, '2013-02-27 17:31:26', 107, '0000-00-00 00:00:00', 0),
(1996, 1, '02_215_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/green-flash-over-setting-sun-111103.jpg', 'images/stories/virtuemart/product/resized/green-flash-over-setting-sun-111103.jpg', 0, 0, 0, '', 0, 1, '0000-00-00 00:00:00', 0, '2013-02-27 17:25:01', 107, '0000-00-00 00:00:00', 0),
(1997, 1, '02_215_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_3.jpg', 'images/stories/virtuemart/product/resized/mongolian-basin-1600.jpg', 0, 0, 0, '', 0, 1, '0000-00-00 00:00:00', 0, '2013-02-27 17:24:40', 107, '0000-00-00 00:00:00', 0),
(1998, 1, '02_215_03_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_4.jpg', 'images/stories/virtuemart/product/resized/02_215_03_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(1999, 1, '02_215_03_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_5.jpg', 'images/stories/virtuemart/product/resized/02_215_03_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2000, 1, '02_215_03_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_6.jpg', 'images/stories/virtuemart/product/resized/02_215_03_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2001, 1, '02_215_03_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_7.jpg', 'images/stories/virtuemart/product/resized/02_215_03_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2002, 1, '02_215_03_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_8.jpg', 'images/stories/virtuemart/product/resized/02_215_03_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2003, 1, '02_215_03_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_9.jpg', 'images/stories/virtuemart/product/resized/02_215_03_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2004, 1, '02_215_03_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_03_10.jpg', 'images/stories/virtuemart/product/resized/02_215_03_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2005, 1, '02_217_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2006, 1, '02_217_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_2.jpg', 'images/stories/virtuemart/product/resized/02_217_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2007, 1, '02_217_06_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_3.jpg', 'images/stories/virtuemart/product/resized/02_217_06_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2008, 1, '02_217_06_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_4.jpg', 'images/stories/virtuemart/product/resized/02_217_06_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2009, 1, '02_217_06_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_5.jpg', 'images/stories/virtuemart/product/resized/02_217_06_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2010, 1, '02_217_06_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_6.jpg', 'images/stories/virtuemart/product/resized/02_217_06_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2011, 1, '02_217_06_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_06_7.jpg', 'images/stories/virtuemart/product/resized/02_217_06_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:54:25', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(2012, 1, '02_191_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2013, 1, '02_191_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_01_2.jpg', 'images/stories/virtuemart/product/resized/02_191_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2014, 1, '02_191_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2015, 1, '02_191_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_02_2.jpg', 'images/stories/virtuemart/product/resized/02_191_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2016, 1, '02_191_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2017, 1, '02_191_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_03_2.jpg', 'images/stories/virtuemart/product/resized/02_191_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2018, 1, '02_191_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2019, 1, '02_191_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_04_2.jpg', 'images/stories/virtuemart/product/resized/02_191_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2020, 1, '02_191_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2021, 1, '02_191_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_05_2.jpg', 'images/stories/virtuemart/product/resized/02_191_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2022, 1, '02_191_06_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_06_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2023, 1, '02_191_06_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_06_2.jpg', 'images/stories/virtuemart/product/resized/02_191_06_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2024, 1, '02_191_07_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_07_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2025, 1, '02_191_07_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_07_2.jpg', 'images/stories/virtuemart/product/resized/02_191_07_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2026, 1, '02_191_08_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_08_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2027, 1, '02_191_08_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_08_2.jpg', 'images/stories/virtuemart/product/resized/02_191_08_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2028, 1, '02_191_09_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_09_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2029, 1, '02_191_09_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_191_09_2.jpg', 'images/stories/virtuemart/product/resized/02_191_09_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2030, 1, '02_195_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2031, 1, '02_195_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_2.jpg', 'images/stories/virtuemart/product/resized/02_195_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2032, 1, '02_195_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_3.jpg', 'images/stories/virtuemart/product/resized/02_195_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2033, 1, '02_195_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_4.jpg', 'images/stories/virtuemart/product/resized/02_195_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2034, 1, '02_195_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_5.jpg', 'images/stories/virtuemart/product/resized/02_195_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2035, 1, '02_195_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_6.jpg', 'images/stories/virtuemart/product/resized/02_195_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2036, 1, '02_195_04_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_7.jpg', 'images/stories/virtuemart/product/resized/02_195_04_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2037, 1, '02_195_04_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_8.jpg', 'images/stories/virtuemart/product/resized/02_195_04_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2038, 1, '02_195_04_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_9.jpg', 'images/stories/virtuemart/product/resized/02_195_04_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2039, 1, '02_195_04_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_195_04_10.jpg', 'images/stories/virtuemart/product/resized/02_195_04_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2040, 1, '02_203_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2041, 1, '02_203_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_03_2.jpg', 'images/stories/virtuemart/product/resized/02_203_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2042, 1, '02_203_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_03_3.jpg', 'images/stories/virtuemart/product/resized/02_203_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2043, 1, '02_203_03_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_03_4.jpg', 'images/stories/virtuemart/product/resized/02_203_03_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2044, 1, '02_203_03_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_03_5.jpg', 'images/stories/virtuemart/product/resized/02_203_03_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2045, 1, '02_203_03_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_203_03_6.jpg', 'images/stories/virtuemart/product/resized/02_203_03_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2046, 1, '02_204_11_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2047, 1, '02_204_11_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_2.jpg', 'images/stories/virtuemart/product/resized/02_204_11_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2048, 1, '02_204_11_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_3.jpg', 'images/stories/virtuemart/product/resized/02_204_11_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2049, 1, '02_204_11_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_4.jpg', 'images/stories/virtuemart/product/resized/02_204_11_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2050, 1, '02_204_11_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_5.jpg', 'images/stories/virtuemart/product/resized/02_204_11_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2051, 1, '02_204_11_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_6.jpg', 'images/stories/virtuemart/product/resized/02_204_11_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2052, 1, '02_204_11_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_7.jpg', 'images/stories/virtuemart/product/resized/02_204_11_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2053, 1, '02_204_11_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_11_8.jpg', 'images/stories/virtuemart/product/resized/02_204_11_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2054, 1, '02_205_09_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2055, 1, '02_205_09_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_2.jpg', 'images/stories/virtuemart/product/resized/02_205_09_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2056, 1, '02_205_09_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_3.jpg', 'images/stories/virtuemart/product/resized/02_205_09_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2057, 1, '02_205_09_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_4.jpg', 'images/stories/virtuemart/product/resized/02_205_09_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2058, 1, '02_205_09_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_5.jpg', 'images/stories/virtuemart/product/resized/02_205_09_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2059, 1, '02_205_09_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_6.jpg', 'images/stories/virtuemart/product/resized/02_205_09_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2060, 1, '02_205_09_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_09_7.jpg', 'images/stories/virtuemart/product/resized/02_205_09_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2061, 1, '02_205_10_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_10_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2062, 1, '02_205_10_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_10_2.jpg', 'images/stories/virtuemart/product/resized/02_205_10_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2063, 1, '02_205_10_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_10_3.jpg', 'images/stories/virtuemart/product/resized/02_205_10_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2064, 1, '02_205_10_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_10_4.jpg', 'images/stories/virtuemart/product/resized/02_205_10_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2065, 1, '02_205_10_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_10_5.jpg', 'images/stories/virtuemart/product/resized/02_205_10_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2066, 1, '02_205_11_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_11_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2067, 1, '02_205_11_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_11_2.jpg', 'images/stories/virtuemart/product/resized/02_205_11_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2068, 1, '02_205_11_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_11_3.jpg', 'images/stories/virtuemart/product/resized/02_205_11_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2069, 1, '02_205_11_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_11_4.jpg', 'images/stories/virtuemart/product/resized/02_205_11_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2070, 1, '02_205_11_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_11_5.jpg', 'images/stories/virtuemart/product/resized/02_205_11_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2071, 1, '02_206_07_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_07_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2072, 1, '02_206_07_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_07_2.jpg', 'images/stories/virtuemart/product/resized/02_206_07_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2073, 1, '02_206_07_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_07_3.jpg', 'images/stories/virtuemart/product/resized/02_206_07_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2074, 1, '02_206_07_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_07_4.jpg', 'images/stories/virtuemart/product/resized/02_206_07_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2075, 1, '02_206_07_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_07_5.jpg', 'images/stories/virtuemart/product/resized/02_206_07_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2076, 1, '02_206_07_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_07_6.jpg', 'images/stories/virtuemart/product/resized/02_206_07_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2077, 1, '02_207_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2078, 1, '02_207_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_2.jpg', 'images/stories/virtuemart/product/resized/02_207_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2079, 1, '02_207_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_3.jpg', 'images/stories/virtuemart/product/resized/02_207_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2080, 1, '02_207_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_4.jpg', 'images/stories/virtuemart/product/resized/02_207_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2081, 1, '02_207_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_5.jpg', 'images/stories/virtuemart/product/resized/02_207_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2082, 1, '02_207_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_6.jpg', 'images/stories/virtuemart/product/resized/02_207_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2083, 1, '02_207_04_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_7.jpg', 'images/stories/virtuemart/product/resized/02_207_04_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2084, 1, '02_207_04_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_8.jpg', 'images/stories/virtuemart/product/resized/02_207_04_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2085, 1, '02_207_04_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_9.jpg', 'images/stories/virtuemart/product/resized/02_207_04_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2086, 1, '02_207_04_10.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_04_10.jpg', 'images/stories/virtuemart/product/resized/02_207_04_10.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2087, 1, '02_210_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2088, 1, '02_210_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_2.jpg', 'images/stories/virtuemart/product/resized/02_210_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2089, 1, '02_210_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_3.jpg', 'images/stories/virtuemart/product/resized/02_210_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2090, 1, '02_210_04_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_4.jpg', 'images/stories/virtuemart/product/resized/02_210_04_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2091, 1, '02_210_04_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_5.jpg', 'images/stories/virtuemart/product/resized/02_210_04_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2092, 1, '02_210_04_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_6.jpg', 'images/stories/virtuemart/product/resized/02_210_04_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2093, 1, '02_210_04_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_7.jpg', 'images/stories/virtuemart/product/resized/02_210_04_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2094, 1, '02_210_04_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_8.jpg', 'images/stories/virtuemart/product/resized/02_210_04_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2095, 1, '02_210_04_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_04_9.jpg', 'images/stories/virtuemart/product/resized/02_210_04_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2096, 1, '02_210_08_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_08_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2270, 1, '02_215_03_4.jpg_product', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/robotnaut-open-switch-cover6.jpg', 'images/stories/virtuemart/product/resized/robotnaut-open-switch-cover6_226x226.jpg', 0, 0, 0, '', 0, 1, '2013-02-27 17:30:09', 107, '2013-02-27 17:30:09', 107, '0000-00-00 00:00:00', 0),
(2097, 1, '02_210_08_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_08_2.jpg', 'images/stories/virtuemart/product/resized/02_210_08_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2098, 1, '02_210_08_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_08_3.jpg', 'images/stories/virtuemart/product/resized/02_210_08_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2099, 1, '02_210_08_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_08_4.jpg', 'images/stories/virtuemart/product/resized/02_210_08_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2100, 1, '02_210_08_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_08_5.jpg', 'images/stories/virtuemart/product/resized/02_210_08_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2101, 1, '02_210_08_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_08_6.jpg', 'images/stories/virtuemart/product/resized/02_210_08_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2102, 1, '02_210_09_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2269, 1, '02_215_03_4.jpg_product', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/rudolfensis.jpg', 'images/stories/virtuemart/product/resized/rudolfensis_226x226.jpg', 0, 0, 0, '', 0, 1, '2013-02-27 17:29:43', 107, '2013-02-27 17:29:43', 107, '0000-00-00 00:00:00', 0),
(2103, 1, '02_210_09_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_2.jpg', 'images/stories/virtuemart/product/resized/02_210_09_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2104, 1, '02_210_09_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_3.jpg', 'images/stories/virtuemart/product/resized/02_210_09_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2105, 1, '02_210_09_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_4.jpg', 'images/stories/virtuemart/product/resized/02_210_09_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2106, 1, '02_210_09_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_5.jpg', 'images/stories/virtuemart/product/resized/02_210_09_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2107, 1, '02_210_09_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_6.jpg', 'images/stories/virtuemart/product/resized/02_210_09_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2108, 1, '02_210_09_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_09_7.jpg', 'images/stories/virtuemart/product/resized/02_210_09_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2109, 1, '02_210_10_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2110, 1, '02_210_10_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_2.jpg', 'images/stories/virtuemart/product/resized/02_210_10_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2111, 1, '02_210_10_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_3.jpg', 'images/stories/virtuemart/product/resized/02_210_10_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2112, 1, '02_210_10_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_4.jpg', 'images/stories/virtuemart/product/resized/02_210_10_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2113, 1, '02_210_10_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_5.jpg', 'images/stories/virtuemart/product/resized/02_210_10_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2114, 1, '02_210_10_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_6.jpg', 'images/stories/virtuemart/product/resized/02_210_10_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2115, 1, '02_210_10_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_10_7.jpg', 'images/stories/virtuemart/product/resized/02_210_10_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2116, 1, '02_210_11_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2117, 1, '02_210_11_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_2.jpg', 'images/stories/virtuemart/product/resized/02_210_11_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2118, 1, '02_210_11_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_3.jpg', 'images/stories/virtuemart/product/resized/02_210_11_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2119, 1, '02_210_11_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_4.jpg', 'images/stories/virtuemart/product/resized/02_210_11_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2120, 1, '02_210_11_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_5.jpg', 'images/stories/virtuemart/product/resized/02_210_11_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2121, 1, '02_210_11_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_6.jpg', 'images/stories/virtuemart/product/resized/02_210_11_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2122, 1, '02_210_11_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_7.jpg', 'images/stories/virtuemart/product/resized/02_210_11_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2123, 1, '02_210_11_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_8.jpg', 'images/stories/virtuemart/product/resized/02_210_11_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2124, 1, '02_210_11_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_11_9.jpg', 'images/stories/virtuemart/product/resized/02_210_11_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2125, 1, '02_210_12_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2126, 1, '02_210_12_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_2.jpg', 'images/stories/virtuemart/product/resized/02_210_12_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2127, 1, '02_210_12_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_3.jpg', 'images/stories/virtuemart/product/resized/02_210_12_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2128, 1, '02_210_12_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_4.jpg', 'images/stories/virtuemart/product/resized/02_210_12_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2129, 1, '02_210_12_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_5.jpg', 'images/stories/virtuemart/product/resized/02_210_12_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2130, 1, '02_210_12_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_6.jpg', 'images/stories/virtuemart/product/resized/02_210_12_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2131, 1, '02_210_12_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_210_12_7.jpg', 'images/stories/virtuemart/product/resized/02_210_12_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2132, 1, '02_211_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_211_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2133, 1, '02_211_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_211_03_2.jpg', 'images/stories/virtuemart/product/resized/02_211_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2134, 1, '02_211_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_211_03_3.jpg', 'images/stories/virtuemart/product/resized/02_211_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2135, 1, '02_217_01_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_01_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2136, 1, '02_217_01_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_01_2.jpg', 'images/stories/virtuemart/product/resized/02_217_01_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2137, 1, '02_217_01_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_01_3.jpg', 'images/stories/virtuemart/product/resized/02_217_01_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2138, 1, '02_217_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2139, 1, '02_217_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_02_2.jpg', 'images/stories/virtuemart/product/resized/02_217_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2140, 1, '02_217_02_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_02_3.jpg', 'images/stories/virtuemart/product/resized/02_217_02_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2141, 1, '02_217_03_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_03_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2142, 1, '02_217_03_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_03_2.jpg', 'images/stories/virtuemart/product/resized/02_217_03_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2143, 1, '02_217_03_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_03_3.jpg', 'images/stories/virtuemart/product/resized/02_217_03_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2144, 1, '02_217_04_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_04_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2145, 1, '02_217_04_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_04_2.jpg', 'images/stories/virtuemart/product/resized/02_217_04_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2146, 1, '02_217_04_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_04_3.jpg', 'images/stories/virtuemart/product/resized/02_217_04_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2147, 1, '02_217_05_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2271, 1, '02_215_03_4.jpg_product', '', '', 'image/png', 'product', 'images/stories/virtuemart/product/the_material_around_sn_1987a_900.png', 'images/stories/virtuemart/product/resized/the_material_around_sn_1987a_900_226x226.png', 0, 0, 0, '', 0, 1, '2013-02-27 17:30:36', 107, '2013-02-27 17:30:36', 107, '0000-00-00 00:00:00', 0),
(2148, 1, '02_217_05_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_2.jpg', 'images/stories/virtuemart/product/resized/02_217_05_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2149, 1, '02_217_05_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_3.jpg', 'images/stories/virtuemart/product/resized/02_217_05_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2150, 1, '02_217_05_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_4.jpg', 'images/stories/virtuemart/product/resized/02_217_05_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2151, 1, '02_217_05_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_5.jpg', 'images/stories/virtuemart/product/resized/02_217_05_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2152, 1, '02_217_05_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_6.jpg', 'images/stories/virtuemart/product/resized/02_217_05_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2153, 1, '02_217_05_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_7.jpg', 'images/stories/virtuemart/product/resized/02_217_05_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2154, 1, '02_217_05_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_8.jpg', 'images/stories/virtuemart/product/resized/02_217_05_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2155, 1, '02_217_05_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_05_9.jpg', 'images/stories/virtuemart/product/resized/02_217_05_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2156, 1, '02_217_07_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2157, 1, '02_217_07_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_2.jpg', 'images/stories/virtuemart/product/resized/02_217_07_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2158, 1, '02_217_07_3.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_3.jpg', 'images/stories/virtuemart/product/resized/02_217_07_3.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2159, 1, '02_217_07_4.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_4.jpg', 'images/stories/virtuemart/product/resized/02_217_07_4.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2160, 1, '02_217_07_5.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_5.jpg', 'images/stories/virtuemart/product/resized/02_217_07_5.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2161, 1, '02_217_07_6.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_6.jpg', 'images/stories/virtuemart/product/resized/02_217_07_6.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2162, 1, '02_217_07_7.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_7.jpg', 'images/stories/virtuemart/product/resized/02_217_07_7.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2163, 1, '02_217_07_8.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_8.jpg', 'images/stories/virtuemart/product/resized/02_217_07_8.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2164, 1, '02_217_07_9.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_217_07_9.jpg', 'images/stories/virtuemart/product/resized/02_217_07_9.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(2165, 1, '02_199_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 20:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0),
(2166, 1, '02_199_02_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_199_02_2.jpg', 'images/stories/virtuemart/product/resized/02_199_02_2.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 20:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0),
(2167, 1, '02_213_09_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_09_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 20:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0),
(2168, 1, '02_213_09_2.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_09_2.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 20:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0),
(2171, 1, 'icon_02_199_02_1.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/icon_02_199_02_1.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:11:31', 107, '2013-02-24 19:11:31', 107, '0000-00-00 00:00:00', 0),
(2176, 1, '02_188_03_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2177, 1, '02_188_03_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2178, 1, '02_188_03_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2179, 1, '02_188_03_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2180, 1, '02_188_03_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2181, 1, '02_188_03_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2182, 1, '02_188_03_7_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_7_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_7_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2183, 1, '02_188_03_8_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_188_03_8_xyz.jpg', 'images/stories/virtuemart/product/resized/02_188_03_8_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2184, 1, '02_200_01_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2185, 1, '02_200_01_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_200_01_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2186, 1, '02_200_01_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_200_01_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2187, 1, '02_200_01_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_200_01_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2188, 1, '02_200_01_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_200_01_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_200_01_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2189, 1, '02_202_04_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_202_04_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2190, 1, '02_202_04_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_202_04_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_202_04_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2191, 1, '02_202_04_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_202_04_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_202_04_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2192, 1, '02_204_17_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2193, 1, '02_204_17_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2194, 1, '02_204_17_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2195, 1, '02_204_17_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2196, 1, '02_204_17_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2197, 1, '02_204_17_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2198, 1, '02_204_17_7_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_7_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_7_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2199, 1, '02_204_17_8_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_8_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_8_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2200, 1, '02_204_17_9_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_9_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_9_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2201, 1, '02_204_17_10_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_10_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_10_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2202, 1, '02_204_17_11_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_11_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_11_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2203, 1, '02_204_17_12_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_204_17_12_xyz.jpg', 'images/stories/virtuemart/product/resized/02_204_17_12_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2204, 1, '02_205_02_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2205, 1, '02_205_02_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_205_02_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2206, 1, '02_205_02_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_205_02_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2207, 1, '02_205_02_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_205_02_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2208, 1, '02_205_02_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_205_02_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2209, 1, '02_205_02_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_205_02_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2210, 1, '02_205_02_7_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_205_02_7_xyz.jpg', 'images/stories/virtuemart/product/resized/02_205_02_7_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2211, 1, '02_206_02_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2212, 1, '02_206_02_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_02_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2213, 1, '02_206_02_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_02_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2214, 1, '02_206_02_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_02_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2215, 1, '02_206_02_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_02_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2216, 1, '02_206_02_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_02_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_02_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2217, 1, '02_206_04_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2218, 1, '02_206_04_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_04_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2219, 1, '02_206_04_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_04_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2220, 1, '02_206_04_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_04_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2221, 1, '02_206_04_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_04_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2222, 1, '02_206_04_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_04_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_04_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2223, 1, '02_206_21_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2224, 1, '02_206_21_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_21_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2225, 1, '02_206_21_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_21_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2226, 1, '02_206_21_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_21_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2227, 1, '02_206_21_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_206_21_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_206_21_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2228, 1, '02_207_08_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2229, 1, '02_207_08_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_207_08_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2230, 1, '02_207_08_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_207_08_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2231, 1, '02_207_08_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_207_08_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2232, 1, '02_207_08_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_207_08_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_207_08_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2233, 1, '02_208_01_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2234, 1, '02_208_01_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_01_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2235, 1, '02_208_01_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_01_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2236, 1, '02_208_01_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_01_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2237, 1, '02_208_01_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_01_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2238, 1, '02_208_01_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_01_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2239, 1, '02_208_01_7_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_01_7_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_01_7_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2240, 1, '02_208_04_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2241, 1, '02_208_04_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_04_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2242, 1, '02_208_04_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_04_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2243, 1, '02_208_04_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_04_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2244, 1, '02_208_04_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_04_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2245, 1, '02_208_04_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_04_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2246, 1, '02_208_04_7_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_04_7_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_04_7_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2247, 1, '02_208_06_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2248, 1, '02_208_06_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_06_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2249, 1, '02_208_06_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_06_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2250, 1, '02_208_06_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_208_06_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_208_06_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2251, 1, '02_212_05_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_212_05_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2252, 1, '02_212_05_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_212_05_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_212_05_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2253, 1, '02_213_01_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2254, 1, '02_213_01_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_213_01_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2255, 1, '02_213_01_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_213_01_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2256, 1, '02_213_01_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_213_01_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2257, 1, '02_213_01_5_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_5_xyz.jpg', 'images/stories/virtuemart/product/resized/02_213_01_5_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2258, 1, '02_213_01_6_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_6_xyz.jpg', 'images/stories/virtuemart/product/resized/02_213_01_6_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2259, 1, '02_213_01_7_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_213_01_7_xyz.jpg', 'images/stories/virtuemart/product/resized/02_213_01_7_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2260, 1, '02_214_06_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2261, 1, '02_214_06_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_214_06_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2262, 1, '02_214_06_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_214_06_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2263, 1, '02_214_06_4_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_214_06_4_xyz.jpg', 'images/stories/virtuemart/product/resized/02_214_06_4_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2264, 1, '02_215_01_1_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_01_1_xyz.jpg', '0', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2265, 1, '02_215_01_2_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_01_2_xyz.jpg', 'images/stories/virtuemart/product/resized/02_215_01_2_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(2266, 1, '02_215_01_3_xyz.jpg', '', '', 'image/jpeg', 'product', 'images/stories/virtuemart/product/02_215_01_3_xyz.jpg', 'images/stories/virtuemart/product/resized/02_215_01_3_xyz.jpg_90x90.jpg', 0, 0, 0, '', 0, 1, '2013-02-24 22:32:18', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_migration_oldtonew_ids
--

-- Таблица auctionru_2013.auc13_virtuemart_migration_oldtonew_ids не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_modules
--
INSERT INTO auc13_virtuemart_modules VALUES
(1, 'product', 'Here you can administer your online catalog of products.  Categories , Products (view=product), Attributes  ,Product Types      Product Files (view=media), Inventory  , Calculation Rules ,Customer Reviews  ', 'storeadmin,admin', 1, '1', 1),
(2, 'order', 'View Order and Update Order Status:    Orders , Coupons , Revenue Report ,Shopper , Shopper Groups ', 'admin,storeadmin', 1, '1', 2),
(3, 'manufacturer', 'Manage the manufacturers of products in your store.', 'storeadmin,admin', 1, '1', 3),
(4, 'store', 'Store Configuration: Store Information, Payment Methods , Shipment, Shipment Rates', 'storeadmin,admin', 1, '1', 4),
(5, 'configuration', 'Configuration: shop configuration , currencies (view=currency), Credit Card List, Countries, userfields, order status  ', 'admin,storeadmin', 1, '1', 5),
(6, 'msgs', 'This module is unprotected an used for displaying system messages to users.  We need to have an area that does not require authorization when things go wrong.', 'none', 0, '0', 99),
(7, 'shop', 'This is the Washupito store module.  This is the demo store included with the VirtueMart distribution.', 'none', 1, '0', 99),
(8, 'store', 'Store Configuration: Store Information, Payment Methods , Shipment, Shipment Rates', 'storeadmin,admin', 1, '1', 4),
(9, 'account', 'This module allows shoppers to update their account information and view previously placed orders.', 'shopper,storeadmin,admin,demo', 1, '0', 99),
(10, 'checkout', '', 'none', 0, '0', 99),
(11, 'tools', 'Tools', 'admin', 1, '1', 8),
(13, 'zone', 'This is the zone-shipment module. Here you can manage your shipment costs according to Zones.', 'admin,storeadmin', 0, '1', 11);

-- 
-- Вывод данных для таблицы auc13_virtuemart_order_calc_rules
--

-- Таблица auctionru_2013.auc13_virtuemart_order_calc_rules не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_order_histories
--

-- Таблица auctionru_2013.auc13_virtuemart_order_histories не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_order_items
--

-- Таблица auctionru_2013.auc13_virtuemart_order_items не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_order_userinfos
--

-- Таблица auctionru_2013.auc13_virtuemart_order_userinfos не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_orders
--

-- Таблица auctionru_2013.auc13_virtuemart_orders не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_orderstates
--
INSERT INTO auc13_virtuemart_orderstates VALUES
(1, 1, 'P', 'Pending', '', 'R', 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 1, 'U', 'Confirmed by shopper', '', 'R', 2, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 1, 'C', 'Confirmed', '', 'R', 3, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 1, 'X', 'Cancelled', '', 'A', 4, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(5, 1, 'R', 'Refunded', '', 'A', 5, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(6, 1, 'S', 'Shipped', '', 'O', 6, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(7, 1, '9', 'Продано', 'Предмет продан', 'O', 0, 1, '2013-02-11 18:12:56', 107, '2013-02-11 18:12:56', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_paymentmethod_shoppergroups
--

-- Таблица auctionru_2013.auc13_virtuemart_paymentmethod_shoppergroups не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_paymentmethods
--

-- Таблица auctionru_2013.auc13_virtuemart_paymentmethods не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_paymentmethods_ru_ru
--

-- Таблица auctionru_2013.auc13_virtuemart_paymentmethods_ru_ru не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_permgroups
--
INSERT INTO auc13_virtuemart_permgroups VALUES
(1, 1, 'admin', 0, 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 1, 'storeadmin', 250, 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 1, 'shopper', 500, 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 1, 'demo', 750, 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_categories
--
INSERT INTO auc13_virtuemart_product_categories VALUES
(1, 1, 1, 0),
(358, 487, 9, 0),
(359, 488, 9, 0),
(360, 489, 9, 0),
(361, 490, 9, 0),
(362, 491, 9, 0),
(363, 492, 9, 0),
(364, 493, 9, 0),
(365, 494, 9, 0),
(366, 495, 9, 0),
(367, 496, 9, 0),
(368, 497, 9, 0),
(369, 498, 9, 0),
(370, 499, 9, 0),
(371, 500, 9, 0),
(372, 501, 9, 0),
(373, 502, 9, 0),
(374, 503, 10, 0),
(375, 504, 10, 0),
(376, 505, 10, 0),
(377, 506, 10, 0),
(378, 507, 10, 0),
(379, 508, 6, 0),
(380, 509, 6, 0),
(381, 510, 6, 0),
(382, 511, 6, 0),
(383, 512, 6, 0),
(384, 513, 6, 0),
(385, 514, 6, 0),
(386, 515, 6, 0),
(387, 516, 6, 0),
(388, 517, 6, 0),
(389, 518, 6, 0),
(390, 519, 6, 0),
(391, 520, 6, 0),
(392, 521, 6, 0),
(393, 522, 6, 0),
(394, 523, 6, 0),
(395, 524, 6, 0),
(396, 525, 6, 0),
(397, 526, 6, 0),
(398, 527, 6, 0),
(399, 528, 6, 0),
(400, 529, 6, 0),
(401, 530, 6, 0),
(402, 531, 6, 0),
(403, 532, 6, 0),
(404, 533, 6, 0),
(405, 534, 6, 0),
(406, 535, 6, 0),
(407, 536, 6, 0),
(408, 537, 6, 0),
(409, 538, 6, 0),
(410, 539, 6, 0),
(411, 540, 6, 0),
(412, 541, 6, 0),
(413, 542, 6, 0),
(414, 543, 6, 0),
(415, 544, 6, 0),
(416, 545, 6, 0),
(417, 546, 6, 0),
(418, 547, 6, 0),
(419, 548, 6, 0),
(420, 549, 6, 0),
(421, 550, 6, 0),
(422, 551, 6, 0),
(423, 552, 6, 0),
(424, 553, 7, 0),
(425, 554, 7, 0),
(426, 555, 7, 0),
(427, 556, 7, 0),
(428, 557, 7, 0),
(429, 558, 7, 0),
(430, 559, 7, 0),
(431, 560, 7, 0),
(432, 561, 7, 0),
(433, 562, 7, 0),
(434, 563, 7, 0),
(435, 564, 7, 0),
(436, 565, 7, 0),
(437, 566, 7, 0),
(438, 567, 7, 0),
(439, 568, 7, 0),
(440, 569, 7, 0),
(441, 570, 7, 0),
(442, 571, 7, 0),
(443, 572, 7, 0),
(444, 573, 7, 0),
(445, 574, 7, 0),
(446, 575, 7, 0),
(447, 576, 7, 0),
(448, 577, 7, 0),
(449, 578, 7, 0),
(450, 579, 7, 0),
(451, 580, 7, 0),
(452, 581, 7, 0),
(453, 582, 7, 0),
(454, 583, 5, 0),
(455, 584, 5, 0),
(456, 585, 25, 0),
(457, 586, 25, 0),
(458, 587, 25, 0),
(459, 588, 25, 0),
(460, 589, 27, 0),
(461, 590, 27, 0),
(462, 591, 27, 0),
(463, 592, 27, 0),
(464, 593, 27, 0),
(465, 594, 27, 0),
(466, 595, 27, 0),
(467, 596, 27, 0),
(468, 597, 27, 0),
(469, 598, 27, 0),
(470, 599, 27, 0),
(471, 600, 27, 0),
(472, 601, 27, 0),
(473, 602, 27, 0),
(474, 603, 27, 0),
(475, 604, 27, 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_customfields
--
INSERT INTO auc13_virtuemart_product_customfields VALUES
(2, 1, 4, 'image is here', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0, 0),
(5, 1, 7, 'а куда ж без номера-то', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0, 3),
(6, 1, 8, 'это тожа надоть', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0, 4),
(8, 1, 10, '10.04.2013', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0, 6),
(9, 1, 11, '12.04.2013', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0, 7),
(12, 2, 7, '1', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:46:48', 107, '0000-00-00 00:00:00', 0, 2),
(13, 2, 8, 'nt 800-66', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:46:48', 107, '0000-00-00 00:00:00', 0, 3),
(15, 2, 10, '', NULL, '', 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:46:48', 107, '0000-00-00 00:00:00', 0, 5);

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_manufacturers
--
INSERT INTO auc13_virtuemart_product_manufacturers VALUES
(1, 1, 1),
(2, 2, 1);

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_medias
--
INSERT INTO auc13_virtuemart_product_medias VALUES
(1, 1, 1, 1),
(1672, 531, 1889, 7),
(1673, 531, 1890, 8),
(1674, 531, 1891, 9),
(1675, 531, 1892, 10),
(1676, 532, 1893, 1),
(1677, 532, 1894, 2),
(1678, 532, 1895, 3),
(1679, 532, 1896, 4),
(1680, 532, 1897, 5),
(1681, 533, 1898, 1),
(1682, 533, 1899, 2),
(1683, 533, 1900, 3),
(1684, 533, 1901, 4),
(1685, 533, 1902, 5),
(1686, 533, 1903, 6),
(1687, 533, 1904, 7),
(1688, 534, 1905, 1),
(1689, 534, 1906, 2),
(1690, 534, 1907, 3),
(1691, 534, 1908, 4),
(1692, 535, 1909, 1),
(1693, 535, 1910, 2),
(1694, 535, 1911, 3),
(1695, 535, 1912, 4),
(1696, 536, 1913, 1),
(1697, 536, 1914, 2),
(1698, 536, 1915, 3),
(1699, 536, 1916, 4),
(1700, 536, 1917, 5),
(1701, 536, 1918, 6),
(1702, 536, 1919, 7),
(1703, 536, 1920, 8),
(1704, 537, 1921, 1),
(1705, 537, 1922, 2),
(1706, 537, 1923, 3),
(1707, 537, 1924, 4),
(1708, 537, 1925, 5),
(1709, 537, 1926, 6),
(1710, 537, 1927, 7),
(1711, 537, 1928, 8),
(1712, 538, 1929, 1),
(1713, 538, 1930, 2),
(1714, 538, 1931, 3),
(1715, 538, 1932, 4),
(1716, 538, 1933, 5),
(1717, 538, 1934, 6),
(1718, 538, 1935, 7),
(1719, 538, 1936, 8),
(1720, 538, 1937, 9),
(1721, 539, 1938, 1),
(1722, 539, 1939, 2),
(1723, 539, 1940, 3),
(1724, 539, 1941, 4),
(1725, 539, 1942, 5),
(1726, 539, 1943, 6),
(1727, 539, 1944, 7),
(1728, 539, 1945, 8),
(1729, 540, 1946, 1),
(1730, 540, 1947, 2),
(1731, 540, 1948, 3),
(1732, 540, 1949, 4),
(1733, 540, 1950, 5),
(1734, 540, 1951, 6),
(1735, 540, 1952, 7),
(1736, 540, 1953, 8),
(1737, 540, 1954, 9),
(1738, 541, 1955, 1),
(1739, 541, 1956, 2),
(1740, 541, 1957, 3),
(1741, 541, 1958, 4),
(1742, 541, 1959, 5),
(1743, 541, 1960, 6),
(1744, 541, 1961, 7),
(1745, 541, 1962, 8),
(1746, 541, 1963, 9),
(1747, 542, 1964, 1),
(1748, 542, 1965, 2),
(1749, 543, 1966, 1),
(1750, 543, 1967, 2),
(1751, 543, 1968, 3),
(1752, 543, 1969, 4),
(1753, 544, 1970, 1),
(1754, 544, 1971, 2),
(1755, 544, 1972, 3),
(1756, 544, 1973, 4),
(1757, 544, 1974, 5),
(1758, 545, 1975, 1),
(1759, 545, 1976, 2),
(1760, 546, 1977, 1),
(1761, 546, 1978, 2),
(1762, 547, 1979, 1),
(1763, 547, 1980, 2),
(1764, 547, 1981, 3),
(1765, 547, 1982, 4),
(1766, 547, 1983, 5),
(1767, 547, 1984, 6),
(1768, 547, 1985, 7),
(1391, 487, 1608, 1),
(1392, 487, 1609, 2),
(1393, 487, 1610, 3),
(1394, 487, 1611, 4),
(1395, 487, 1612, 5),
(1396, 487, 1613, 6),
(1397, 487, 1614, 7),
(1398, 487, 1615, 8),
(1769, 548, 1986, 1),
(1770, 548, 1987, 2),
(1771, 548, 1988, 3),
(1772, 549, 1989, 1),
(1773, 549, 1990, 2),
(1774, 549, 1991, 3),
(1775, 550, 1992, 1),
(1776, 550, 1993, 2),
(1777, 550, 1994, 3),
(1778, 551, 1995, 1),
(1779, 551, 1996, 2),
(1780, 551, 1997, 3),
(1788, 552, 2005, 1),
(1789, 552, 2006, 2),
(1790, 552, 2007, 3),
(1791, 552, 2008, 4),
(1792, 552, 2009, 5),
(1793, 552, 2010, 6),
(1794, 552, 2011, 7),
(1399, 488, 1616, 1),
(1400, 488, 1617, 2),
(1401, 488, 1618, 3),
(1402, 488, 1619, 4),
(1403, 488, 1620, 5),
(1404, 489, 1621, 1),
(1405, 489, 1622, 2),
(1406, 489, 1623, 3),
(1407, 490, 1624, 1),
(1408, 490, 1625, 2),
(1409, 490, 1626, 3),
(1410, 490, 1627, 4),
(1411, 490, 1628, 5),
(1412, 490, 1629, 6),
(1413, 490, 1630, 7),
(1414, 490, 1631, 8),
(1415, 490, 1632, 9),
(1416, 490, 1633, 10),
(1417, 490, 1634, 11),
(1418, 490, 1635, 12),
(1419, 491, 1636, 1),
(1420, 491, 1637, 2),
(1421, 491, 1638, 3),
(1422, 491, 1639, 4),
(1423, 491, 1640, 5),
(1424, 491, 1641, 6),
(1425, 491, 1642, 7),
(1426, 492, 1643, 1),
(1427, 492, 1644, 2),
(1428, 492, 1645, 3),
(1429, 492, 1646, 4),
(1430, 492, 1647, 5),
(1431, 492, 1648, 6),
(1432, 493, 1649, 1),
(1433, 493, 1650, 2),
(1434, 493, 1651, 3),
(1435, 493, 1652, 4),
(1436, 493, 1653, 5),
(1437, 493, 1654, 6),
(1438, 494, 1655, 1),
(1439, 494, 1656, 2),
(1440, 494, 1657, 3),
(1441, 494, 1658, 4),
(1442, 494, 1659, 5),
(1443, 495, 1660, 1),
(1444, 495, 1661, 2),
(1445, 495, 1662, 3),
(1446, 495, 1663, 4),
(1447, 495, 1664, 5),
(1448, 496, 1665, 1),
(1449, 496, 1666, 2),
(1450, 496, 1667, 3),
(1451, 496, 1668, 4),
(1452, 496, 1669, 5),
(1453, 496, 1670, 6),
(1454, 496, 1671, 7),
(1455, 497, 1672, 1),
(1456, 497, 1673, 2),
(1457, 497, 1674, 3),
(1458, 497, 1675, 4),
(1459, 497, 1676, 5),
(1460, 497, 1677, 6),
(1461, 497, 1678, 7),
(1462, 498, 1679, 1),
(1463, 498, 1680, 2),
(1464, 498, 1681, 3),
(1465, 498, 1682, 4),
(1466, 499, 1683, 1),
(1467, 499, 1684, 2),
(1468, 500, 1685, 1),
(1469, 500, 1686, 2),
(1470, 500, 1687, 3),
(1471, 500, 1688, 4),
(1472, 500, 1689, 5),
(1473, 500, 1690, 6),
(1474, 500, 1691, 7),
(1475, 501, 1692, 1),
(1476, 501, 1693, 2),
(1477, 501, 1694, 3),
(1478, 501, 1695, 4),
(1479, 502, 1696, 1),
(1480, 502, 1697, 2),
(1481, 502, 1698, 3),
(1482, 503, 1699, 1),
(1483, 503, 1700, 2),
(1484, 503, 1701, 3),
(1485, 503, 1702, 4),
(1486, 503, 1703, 5),
(1487, 503, 1704, 6),
(1488, 503, 1705, 7),
(1489, 504, 1706, 1),
(1490, 504, 1707, 2),
(1491, 504, 1708, 3),
(1492, 504, 1709, 4),
(1493, 504, 1710, 5),
(1494, 504, 1711, 6),
(1495, 504, 1712, 7),
(1496, 504, 1713, 8),
(1497, 505, 1714, 1),
(1498, 505, 1715, 2),
(1499, 505, 1716, 3),
(1500, 505, 1717, 4),
(1501, 505, 1718, 5),
(1502, 505, 1719, 6),
(1503, 505, 1720, 7),
(1504, 505, 1721, 8),
(1505, 505, 1722, 9),
(1506, 506, 1723, 1),
(1507, 506, 1724, 2),
(1508, 506, 1725, 3),
(1509, 506, 1726, 4),
(1510, 506, 1727, 5),
(1511, 506, 1728, 6),
(1512, 507, 1729, 1),
(1513, 507, 1730, 2),
(1514, 508, 1731, 1),
(1515, 508, 1732, 2),
(1516, 508, 1733, 3),
(1517, 508, 1734, 4),
(1518, 508, 1735, 5),
(1519, 509, 1736, 1),
(1520, 509, 1737, 2),
(1521, 509, 1738, 3),
(1522, 509, 1739, 4),
(1523, 509, 1740, 5),
(1524, 509, 1741, 6),
(1525, 510, 1742, 1),
(1526, 510, 1743, 2),
(1527, 510, 1744, 3),
(1528, 510, 1745, 4),
(1529, 511, 1746, 1),
(1530, 511, 1747, 2),
(1531, 511, 1748, 3),
(1532, 511, 1749, 4),
(1533, 511, 1750, 5),
(1534, 511, 1751, 6),
(1535, 512, 1752, 1),
(1536, 512, 1753, 2),
(1537, 512, 1754, 3),
(1538, 512, 1755, 4),
(1539, 512, 1756, 5),
(1540, 512, 1757, 6),
(1541, 512, 1758, 7),
(1542, 512, 1759, 8),
(1543, 512, 1760, 9),
(1544, 512, 1761, 10),
(1545, 513, 1762, 1),
(1546, 513, 1763, 2),
(1547, 513, 1764, 3),
(1548, 514, 1765, 1),
(1549, 514, 1766, 2),
(1550, 514, 1767, 3),
(1551, 514, 1768, 4),
(1552, 514, 1769, 5),
(1553, 514, 1770, 6),
(1554, 514, 1771, 7),
(1555, 514, 1772, 8),
(1556, 514, 1773, 9),
(1557, 514, 1774, 10),
(1558, 515, 1775, 1),
(1559, 515, 1776, 2),
(1560, 515, 1777, 3),
(1561, 515, 1778, 4),
(1562, 515, 1779, 5),
(1563, 516, 1780, 1),
(1564, 516, 1781, 2),
(1565, 516, 1782, 3),
(1566, 516, 1783, 4),
(1567, 516, 1784, 5),
(1568, 516, 1785, 6),
(1569, 516, 1786, 7),
(1570, 516, 1787, 8),
(1571, 516, 1788, 9),
(1572, 516, 1789, 10),
(1573, 517, 1790, 1),
(1574, 517, 1791, 2),
(1575, 517, 1792, 3),
(1576, 517, 1793, 4),
(1577, 517, 1794, 5),
(1578, 517, 1795, 6),
(1579, 517, 1796, 7),
(1580, 518, 1797, 1),
(1581, 518, 1798, 2),
(1582, 518, 1799, 3),
(1583, 518, 1800, 4),
(1584, 518, 1801, 5),
(1585, 518, 1802, 6),
(1586, 519, 1803, 1),
(1587, 519, 1804, 2),
(1588, 519, 1805, 3),
(1589, 519, 1806, 4),
(1590, 519, 1807, 5),
(1591, 519, 1808, 6),
(1592, 519, 1809, 7),
(1593, 520, 1810, 1),
(1594, 520, 1811, 2),
(1595, 520, 1812, 3),
(1596, 520, 1813, 4),
(1597, 520, 1814, 5),
(1598, 520, 1815, 6),
(1599, 520, 1816, 7),
(1600, 520, 1817, 8),
(1601, 520, 1818, 9),
(1602, 520, 1819, 10),
(1603, 521, 1820, 1),
(1604, 521, 1821, 2),
(1605, 521, 1822, 3),
(1606, 521, 1823, 4),
(1607, 521, 1824, 5),
(1608, 521, 1825, 6),
(1609, 521, 1826, 7),
(1610, 521, 1827, 8),
(1611, 521, 1828, 9),
(1612, 521, 1829, 10),
(1613, 522, 1830, 1),
(1614, 522, 1831, 2),
(1615, 522, 1832, 3),
(1616, 522, 1833, 4),
(1617, 522, 1834, 5),
(1618, 522, 1835, 6),
(1619, 522, 1836, 7),
(1620, 522, 1837, 8),
(1621, 522, 1838, 9),
(1622, 523, 1839, 1),
(1623, 523, 1840, 2),
(1624, 523, 1841, 3),
(1625, 523, 1842, 4),
(1626, 523, 1843, 5),
(1627, 523, 1844, 6),
(1628, 523, 1845, 7),
(1629, 523, 1846, 8),
(1630, 523, 1847, 9),
(1631, 523, 1848, 10),
(1632, 524, 1849, 1),
(1633, 524, 1850, 2),
(1634, 524, 1851, 3),
(1635, 524, 1852, 4),
(1636, 524, 1853, 5),
(1637, 525, 1854, 1),
(1638, 525, 1855, 2),
(1639, 525, 1856, 3),
(1640, 525, 1857, 4),
(1641, 525, 1858, 5),
(1642, 525, 1859, 6),
(1643, 526, 1860, 1),
(1644, 526, 1861, 2),
(1645, 527, 1862, 1),
(1646, 527, 1863, 2),
(1647, 527, 1864, 3),
(1648, 527, 1865, 4),
(1649, 527, 1866, 5),
(1650, 527, 1867, 6),
(1651, 527, 1868, 7),
(1652, 528, 1869, 1),
(1653, 528, 1870, 2),
(1654, 528, 1871, 3),
(1655, 528, 1872, 4),
(1656, 528, 1873, 5),
(1657, 529, 1874, 1),
(1658, 529, 1875, 2),
(1659, 529, 1876, 3),
(1660, 529, 1877, 4),
(1661, 530, 1878, 1),
(1662, 530, 1879, 2),
(1663, 530, 1880, 3),
(1664, 530, 1881, 4),
(1665, 530, 1882, 5),
(1666, 531, 1883, 1),
(1667, 531, 1884, 2),
(1668, 531, 1885, 3),
(1669, 531, 1886, 4),
(1670, 531, 1887, 5),
(1671, 531, 1888, 6),
(1795, 553, 2012, 1),
(1796, 553, 2013, 2),
(1797, 554, 2014, 1),
(1798, 554, 2015, 2),
(1799, 555, 2016, 1),
(1800, 555, 2017, 2),
(1801, 556, 2018, 1),
(1802, 556, 2019, 2),
(1803, 557, 2020, 1),
(1804, 557, 2021, 2),
(1805, 558, 2022, 1),
(1806, 558, 2023, 2),
(1807, 559, 2024, 1),
(1808, 559, 2025, 2),
(1809, 560, 2026, 1),
(1810, 560, 2027, 2),
(1811, 561, 2028, 1),
(1812, 561, 2029, 2),
(1813, 562, 2030, 1),
(1814, 562, 2031, 2),
(1815, 562, 2032, 3),
(1816, 562, 2033, 4),
(1817, 562, 2034, 5),
(1818, 562, 2035, 6),
(1819, 562, 2036, 7),
(1820, 562, 2037, 8),
(1821, 562, 2038, 9),
(1822, 562, 2039, 10),
(1823, 563, 2040, 1),
(1824, 563, 2041, 2),
(1825, 563, 2042, 3),
(1826, 563, 2043, 4),
(1827, 563, 2044, 5),
(1828, 563, 2045, 6),
(1829, 564, 2046, 1),
(1830, 564, 2047, 2),
(1831, 564, 2048, 3),
(1832, 564, 2049, 4),
(1833, 564, 2050, 5),
(1834, 564, 2051, 6),
(1835, 564, 2052, 7),
(1836, 564, 2053, 8),
(1837, 565, 2054, 1),
(1838, 565, 2055, 2),
(1839, 565, 2056, 3),
(1840, 565, 2057, 4),
(1841, 565, 2058, 5),
(1842, 565, 2059, 6),
(1843, 565, 2060, 7),
(1844, 566, 2061, 1),
(1845, 566, 2062, 2),
(1846, 566, 2063, 3),
(1847, 566, 2064, 4),
(1848, 566, 2065, 5),
(1849, 567, 2066, 1),
(1850, 567, 2067, 2),
(1851, 567, 2068, 3),
(1852, 567, 2069, 4),
(1853, 567, 2070, 5),
(1854, 568, 2071, 1),
(1855, 568, 2072, 2),
(1856, 568, 2073, 3),
(1857, 568, 2074, 4),
(1858, 568, 2075, 5),
(1859, 568, 2076, 6),
(1860, 569, 2077, 1),
(1861, 569, 2078, 2),
(1862, 569, 2079, 3),
(1863, 569, 2080, 4),
(1864, 569, 2081, 5),
(1865, 569, 2082, 6),
(1866, 569, 2083, 7),
(1867, 569, 2084, 8),
(1868, 569, 2085, 9),
(1869, 569, 2086, 10),
(1870, 570, 2087, 1),
(1871, 570, 2088, 2),
(1872, 570, 2089, 3),
(1873, 570, 2090, 4),
(1874, 570, 2091, 5),
(1875, 570, 2092, 6),
(1876, 570, 2093, 7),
(1877, 570, 2094, 8),
(1878, 570, 2095, 9),
(1879, 571, 2096, 1),
(1880, 571, 2097, 2),
(1881, 571, 2098, 3),
(1882, 571, 2099, 4),
(1883, 571, 2100, 5),
(1884, 571, 2101, 6),
(1885, 572, 2102, 1),
(1886, 572, 2103, 2),
(1887, 572, 2104, 3),
(1888, 572, 2105, 4),
(1889, 572, 2106, 5),
(1890, 572, 2107, 6),
(1891, 572, 2108, 7),
(1892, 573, 2109, 1),
(1893, 573, 2110, 2),
(1894, 573, 2111, 3),
(1895, 573, 2112, 4),
(1896, 573, 2113, 5),
(1897, 573, 2114, 6),
(1898, 573, 2115, 7),
(1899, 574, 2116, 1),
(1900, 574, 2117, 2),
(1901, 574, 2118, 3),
(1902, 574, 2119, 4),
(1903, 574, 2120, 5),
(1904, 574, 2121, 6),
(1905, 574, 2122, 7),
(1906, 574, 2123, 8),
(1907, 574, 2124, 9),
(1908, 575, 2125, 1),
(1909, 575, 2126, 2),
(1910, 575, 2127, 3),
(1911, 575, 2128, 4),
(1912, 575, 2129, 5),
(1913, 575, 2130, 6),
(1914, 575, 2131, 7),
(1915, 576, 2132, 1),
(1916, 576, 2133, 2),
(1917, 576, 2134, 3),
(1918, 577, 2135, 1),
(1919, 577, 2136, 2),
(1920, 577, 2137, 3),
(1921, 578, 2138, 1),
(1922, 578, 2139, 2),
(1923, 578, 2140, 3),
(1924, 579, 2141, 1),
(1925, 579, 2142, 2),
(1926, 579, 2143, 3),
(1927, 580, 2144, 1),
(1928, 580, 2145, 2),
(1929, 580, 2146, 3),
(1930, 581, 2147, 1),
(1931, 581, 2148, 2),
(1932, 581, 2149, 3),
(1933, 581, 2150, 4),
(1934, 581, 2151, 5),
(1935, 581, 2152, 6),
(1936, 581, 2153, 7),
(1937, 581, 2154, 8),
(1938, 581, 2155, 9),
(1939, 582, 2156, 1),
(1940, 582, 2157, 2),
(1941, 582, 2158, 3),
(1942, 582, 2159, 4),
(1943, 582, 2160, 5),
(1944, 582, 2161, 6),
(1945, 582, 2162, 7),
(1946, 582, 2163, 8),
(1947, 582, 2164, 9),
(1948, 583, 2165, 1),
(1949, 583, 2166, 2),
(1950, 584, 2167, 1),
(1951, 584, 2168, 2),
(1952, 585, 2168, 1),
(1953, 586, 2168, 1),
(1954, 587, 2171, 1),
(1955, 587, 2172, 2),
(1956, 588, 2173, 1),
(1957, 588, 2174, 2),
(1958, 588, 2175, 3),
(1959, 589, 2176, 1),
(1960, 589, 2177, 2),
(1961, 589, 2178, 3),
(1962, 589, 2179, 4),
(1963, 589, 2180, 5),
(1964, 589, 2181, 6),
(1965, 589, 2182, 7),
(1966, 589, 2183, 8),
(1967, 590, 2184, 1),
(1968, 590, 2185, 2),
(1969, 590, 2186, 3),
(1970, 590, 2187, 4),
(1971, 590, 2188, 5),
(1972, 591, 2189, 1),
(1973, 591, 2190, 2),
(1974, 591, 2191, 3),
(1975, 592, 2192, 1),
(1976, 592, 2193, 2),
(1977, 592, 2194, 3),
(1978, 592, 2195, 4),
(1979, 592, 2196, 5),
(1980, 592, 2197, 6),
(1981, 592, 2198, 7),
(1982, 592, 2199, 8),
(1983, 592, 2200, 9),
(1984, 592, 2201, 10),
(1985, 592, 2202, 11),
(1986, 592, 2203, 12),
(1987, 593, 2204, 1),
(1988, 593, 2205, 2),
(1989, 593, 2206, 3),
(1990, 593, 2207, 4),
(1991, 593, 2208, 5),
(1992, 593, 2209, 6),
(1993, 593, 2210, 7),
(1994, 594, 2211, 1),
(1995, 594, 2212, 2),
(1996, 594, 2213, 3),
(1997, 594, 2214, 4),
(1998, 594, 2215, 5),
(1999, 594, 2216, 6),
(2000, 595, 2217, 1),
(2001, 595, 2218, 2),
(2002, 595, 2219, 3),
(2003, 595, 2220, 4),
(2004, 595, 2221, 5),
(2005, 595, 2222, 6),
(2006, 596, 2223, 1),
(2007, 596, 2224, 2),
(2008, 596, 2225, 3),
(2009, 596, 2226, 4),
(2010, 596, 2227, 5),
(2011, 597, 2228, 1),
(2012, 597, 2229, 2),
(2013, 597, 2230, 3),
(2014, 597, 2231, 4),
(2015, 597, 2232, 5),
(2016, 598, 2233, 1),
(2017, 598, 2234, 2),
(2018, 598, 2235, 3),
(2019, 598, 2236, 4),
(2020, 598, 2237, 5),
(2021, 598, 2238, 6),
(2022, 598, 2239, 7),
(2023, 599, 2240, 1),
(2024, 599, 2241, 2),
(2025, 599, 2242, 3),
(2026, 599, 2243, 4),
(2027, 599, 2244, 5),
(2028, 599, 2245, 6),
(2029, 599, 2246, 7),
(2030, 600, 2247, 1),
(2031, 600, 2248, 2),
(2032, 600, 2249, 3),
(2033, 600, 2250, 4),
(2034, 601, 2251, 1),
(2035, 601, 2252, 2),
(2036, 602, 2253, 1),
(2037, 602, 2254, 2),
(2038, 602, 2255, 3),
(2039, 602, 2256, 4),
(2040, 602, 2257, 5),
(2041, 602, 2258, 6),
(2042, 602, 2259, 7),
(2043, 603, 2260, 1),
(2044, 603, 2261, 2),
(2045, 603, 2262, 3),
(2046, 603, 2263, 4),
(2047, 604, 2264, 1),
(2048, 604, 2265, 2),
(2049, 604, 2266, 3),
(2050, 551, 2268, 4),
(2051, 551, 2269, 5),
(2052, 551, 2270, 6),
(2053, 551, 2271, 7),
(2054, 551, 2272, 8);

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_prices
--
INSERT INTO auc13_virtuemart_product_prices VALUES
(1, 1, 0, 525000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', 0, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0),
(414, 487, 0, 21000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(415, 488, 0, 120000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(416, 489, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(417, 490, 0, 25000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(418, 491, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(419, 492, 0, 800.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(420, 493, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(421, 494, 0, 22000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(422, 495, 0, 20000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(423, 496, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(424, 497, 0, 6000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(425, 498, 0, 12000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(426, 499, 0, 4500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(427, 500, 0, 45000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(428, 501, 0, 4000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(429, 502, 0, 16000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0),
(430, 503, 0, 10500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(431, 504, 0, 6200.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(432, 505, 0, 120000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(433, 506, 0, 60000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(434, 507, 0, 12000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0),
(435, 508, 0, 6000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(436, 509, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(437, 510, 0, 7000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(438, 511, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(439, 512, 0, 15000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(440, 513, 0, 9800.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(441, 514, 0, 8000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(442, 515, 0, 50000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(443, 516, 0, 60000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(444, 517, 0, 4000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(445, 518, 0, 18500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(446, 519, 0, 18500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(447, 520, 0, 20000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(448, 521, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(449, 522, 0, 3500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(450, 523, 0, 15000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(451, 524, 0, 1100.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(452, 525, 0, 48000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(453, 526, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(454, 527, 0, 25000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(455, 528, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(456, 529, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(457, 530, 0, 600.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(458, 531, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(459, 532, 0, 10000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(460, 533, 0, 6000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(461, 534, 0, 10000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(462, 535, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(463, 536, 0, 20000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(464, 537, 0, 50000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(465, 538, 0, 8000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(466, 539, 0, 8000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(467, 540, 0, 3500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(468, 541, 0, 3500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(469, 542, 0, 10000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(470, 543, 0, 25000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(471, 544, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(472, 545, 0, 35000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(473, 546, 0, 55000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(474, 547, 0, 11000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(475, 548, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(476, 549, 0, 60000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(477, 550, 0, 4500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(478, 551, 0, 13500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', 0, '2013-02-27 17:31:26', 107, '0000-00-00 00:00:00', 0),
(479, 552, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0),
(480, 553, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(481, 554, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(482, 555, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(483, 556, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(484, 557, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(485, 558, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(486, 559, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(487, 560, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(488, 561, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(489, 562, 0, 10000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(490, 563, 0, 1000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(491, 564, 0, 8000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(492, 565, 0, 3000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(493, 566, 0, 2000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(494, 567, 0, 2000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(495, 568, 0, 2800.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(496, 569, 0, 8000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(497, 570, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(498, 571, 0, 3000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(499, 572, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(500, 573, 0, 3000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(501, 574, 0, 17000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(502, 575, 0, 3000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(503, 576, 0, 25000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(504, 577, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(505, 578, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(506, 579, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(507, 580, 0, 1000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(508, 581, 0, 20000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(509, 582, 0, 800.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 16:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0),
(510, 583, 0, 12000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 17:02:05', 107, '2013-02-24 17:02:05', 107, '0000-00-00 00:00:00', 0),
(511, 584, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 17:02:05', 107, '2013-02-24 17:02:05', 107, '0000-00-00 00:00:00', 0),
(512, 585, 0, 12000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 17:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0),
(513, 586, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 17:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0),
(514, 587, 0, 12000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:11:31', 107, '2013-02-24 19:11:31', 107, '0000-00-00 00:00:00', 0),
(515, 588, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', 0, '2013-02-24 19:19:47', 107, '0000-00-00 00:00:00', 0),
(516, 589, 0, 21000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(517, 590, 0, 120000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(518, 591, 0, 5000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(519, 592, 0, 25000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(520, 593, 0, 9000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(521, 594, 0, 800.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(522, 595, 0, 1500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(523, 596, 0, 22000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(524, 597, 0, 20000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(525, 598, 0, 14000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(526, 599, 0, 6000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(527, 600, 0, 12000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(528, 601, 0, 4500.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(529, 602, 0, 45000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(530, 603, 0, 4000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0),
(531, 604, 0, 16000.00000, 0, 0.00000, 0, 0, 131, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '2013-02-24 19:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_relations
--

-- Таблица auctionru_2013.auc13_virtuemart_product_relations не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_product_shoppergroups
--
INSERT INTO auc13_virtuemart_product_shoppergroups VALUES
(1, 1, 1),
(2, 1, 2);

-- 
-- Вывод данных для таблицы auc13_virtuemart_products
--
INSERT INTO auc13_virtuemart_products VALUES
(1, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2013-02-12 00:00:00', '0000-00-00 00:00:00', '', 0, '', '', 0, NULL, NULL, 0, 0.0000, 'min_order_level=""|max_order_level=""|product_box=""|', NULL, 'Примечание о предмете, надо полагать?', '', '', '0', 1, '2013-02-12 15:38:43', 107, '2013-02-13 20:50:53', 107, '0000-00-00 00:00:00', 0, 'KG'),
(487, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/188/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(488, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/200/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(489, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/202/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(490, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/204/17', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(491, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/205/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(492, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(493, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(494, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/21', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(495, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/207/08', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(496, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(497, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(498, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(499, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/212/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(500, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(501, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/214/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(502, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/215/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:52:00', 107, '2013-02-24 16:52:00', 107, '0000-00-00 00:00:00', 0, 'KG'),
(503, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/198/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0, 'KG'),
(504, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/198/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0, 'KG'),
(505, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/201/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0, 'KG'),
(506, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/209/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0, 'KG'),
(507, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/10', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:53:25', 107, '2013-02-24 16:53:25', 107, '0000-00-00 00:00:00', 0, 'KG'),
(508, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/188/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(509, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/188/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(510, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/188/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(511, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/199/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(512, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/201/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(513, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/201/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(514, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/201/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(515, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/201/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(516, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/203/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(517, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/203/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(518, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/203/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(519, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/203/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(520, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/203/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(521, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/204/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(522, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/204/10', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(523, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/204/14', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(524, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(525, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(526, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(527, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/10', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(528, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/11', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(529, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/20', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(530, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/29', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(531, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/207/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(532, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(533, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(534, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(535, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/07', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(536, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/08', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(537, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(538, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/03.1', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(539, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/03.2', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(540, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(541, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/07', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(542, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/212/08', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(543, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(544, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(545, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(546, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/07', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(547, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/214/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(548, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/214/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(549, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/214/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(550, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/215/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(551, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/215/03', 118, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=""|max_order_level=""|product_box=""|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-27 17:31:26', 107, '0000-00-00 00:00:00', 0, 'KG'),
(552, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:54:24', 107, '2013-02-24 16:54:24', 107, '0000-00-00 00:00:00', 0, 'KG'),
(553, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(554, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(555, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(556, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(557, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(558, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(559, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/07', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(560, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/08', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(561, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/191/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(562, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/195/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(563, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/203/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(564, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/204/11', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(565, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/205/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(566, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/205/10', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(567, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/205/11', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(568, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/07', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(569, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/207/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(570, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(571, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/08', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(572, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(573, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/10', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(574, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/11', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(575, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/210/12', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(576, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/211/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(577, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(578, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(579, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(580, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(581, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(582, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/217/07', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 19:59:11', 107, '2013-02-24 16:59:11', 107, '0000-00-00 00:00:00', 0, 'KG'),
(583, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/199/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 20:02:05', 107, '2013-02-24 17:02:05', 107, '0000-00-00 00:00:00', 0, 'KG'),
(584, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 20:02:05', 107, '2013-02-24 17:02:05', 107, '0000-00-00 00:00:00', 0, 'KG'),
(585, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/199/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 20:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0, 'KG'),
(586, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 20:06:46', 107, '2013-02-24 17:06:46', 107, '0000-00-00 00:00:00', 0, 'KG'),
(587, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/199/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:11:31', 107, '2013-02-24 19:11:31', 107, '0000-00-00 00:00:00', 0, 'KG'),
(588, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/09', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=""|max_order_level=""|product_box=""|', NULL, '', '', '', '0', 1, '2013-02-24 22:11:31', 107, '2013-02-24 19:19:47', 107, '0000-00-00 00:00:00', 0, 'KG'),
(589, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/188/03', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(590, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/200/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(591, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/202/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(592, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/204/17', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(593, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/205/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(594, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/02', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(595, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(596, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/206/21', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(597, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/207/08', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(598, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(599, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/04', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(600, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/208/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(601, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/212/05', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(602, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/213/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(603, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/214/06', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG'),
(604, 1, 0, '', 0.0000, 'KG', 0.0000, 0.0000, 0.0000, 'M', '', 1, 0, 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', '', 0, '№02', '02/215/01', 0, '2012-12-04 00:00:00', '2012-12-14 00:00:00', 0, 0.0000, 'min_order_level=null|max_order_level=null|product_box=null|', NULL, '', '', '', '0', 1, '2013-02-24 22:32:17', 107, '2013-02-24 19:32:17', 107, '0000-00-00 00:00:00', 0, 'KG');

-- 
-- Вывод данных для таблицы auc13_virtuemart_products_ru_ru
--
INSERT INTO auc13_virtuemart_products_ru_ru VALUES
(1, 'Ну это типо краткое, да. Щаз чото и в полное впихнём!', '<p>Вот тут-то типо полное... ну и хрен с ним. Меня более беспокоит - чо там за настраиваемые поля?</p>', 'Картина Репина "Про рэп"', '', '', '', 'kartina-repina-pro-rep'),
(551, 'Фарфор, бордовое крытье, роспись золотом, деколь, Западная Европа, Австрия(?), к. XIX - н. ХХ вв., диаметр 19,5 см.', '<p>Фарфор, бордовое крытье, роспись золотом, деколь, Западная Европа, Австрия(?), к. XIX - н. ХХ вв., диаметр 19,5 см.</p>', '6 десертных тарелок «Мифологические сцены».', '', '', '', '6-десертных-тарелок-«мифологические-сцены»'),
(487, 'Венская бронза. Бронза, литье, раскраска. Вена, Австрия, н. ХХ в. Размер высота 7.5 см., длина 14 см. ( небольшие потертости красочного слоя)', 'Венская бронза. Бронза, литье, раскраска. Вена, Австрия, н. ХХ в. Размер высота 7.5 см., длина 14 см. ( небольшие потертости красочного слоя)', 'Фигурка «Гордон сеттер с уткой».', '', '', '', 'фигурка-«гордон-сеттер-с-уткой»'),
(488, 'Чугун, литье, рельеф, полировка, Россия, к. XIX в., завод Э. Ферстера (Санкт-Петербург) и Кусинский завод (Урал), клейма на обороте «Кус.З» и «Завод Э.Ферстер СПетербург», диаметр 53,7 см.', 'Чугун, литье, рельеф, полировка, Россия, к. XIX в., завод Э. Ферстера (Санкт-Петербург) и Кусинский завод (Урал), клейма на обороте «Кус.З» и «Завод Э.Ферстер СПетербург», диаметр 53,7 см.', 'Блюдо декоративное «Медуза Горгона» в стиле Ренессанс.', '', '', '', 'блюдо-декоративное-«медуза-горгона»-в-стиле-ренессанс'),
(489, 'Чугун, литье, СССР, Каслинский завод, 1989 г., Клейма: Касли, 1989 г. Высота 21 см.', 'Чугун, литье, СССР, Каслинский завод, 1989 г., Клейма: Касли, 1989 г. Высота 21 см.', 'Фигурка «Дон Кихот».', '', '', '', 'фигурка-«дон-кихот»'),
(490, 'Металл, серебрение, Россия (?), н. ХХ в., на книге в руках Музы дарственная надпись «На память от Паши и Бориса» 19 IX/XII 16, высота 44,5 см, диаметр 33,5 см.', 'Металл, серебрение, Россия (?), н. ХХ в., на книге в руках Музы дарственная надпись «На память от Паши и Бориса» 19 IX/XII 16, высота 44,5 см, диаметр 33,5 см.', 'Ваза для фруктов с фигурой Музы.', '', '', '', 'ваза-для-фруктов-с-фигурой-музы'),
(491, 'Бронза, золочение, патина, к. ХIХ в., высота 26 см (на одном утрачена деталь, очевидно, фигурка птички)', 'Бронза, золочение, патина, к. ХIХ в., высота 26 см (на одном утрачена деталь, очевидно, фигурка птички)', 'Парные подсвечники «Змея и лягушка», «Змея и птичье гнездо».', '', '', '', 'парные-подсвечники-«змея-и-лягушка»,-«змея-и-птичье-гнездо»'),
(492, 'Металл, серебрение, Западная Европа, н. ХХ в., высота 6 см.', 'Металл, серебрение, Западная Европа, н. ХХ в., высота 6 см.', 'Настольное украшение «Ботинок с дырой».', '', '', '', 'настольное-украшение-«ботинок-с-дырой»'),
(493, 'Бронза, литьё, золочение, Западная Европа, ХХ в., высота 6 см.', 'Бронза, литьё, золочение, Западная Европа, ХХ в., высота 6 см.', 'Композиция «Птичка над гнездом».', '', '', '', 'композиция-«птичка-над-гнездом»'),
(494, 'Бронза, литье, чеканка, Россия, к. XIX - н. ХХ вв., длина 12.5 см, высота 3.5 см', 'Бронза, литье, чеканка, Россия, к. XIX - н. ХХ вв., длина 12.5 см, высота 3.5 см', 'Лапоть.', '', '', '', 'лапоть'),
(495, 'Бронза, литье, золочение, Россия(?), 2-я пол. XIX в., высота 11 см', 'Бронза, литье, золочение, Россия(?), 2-я пол. XIX в., высота 11 см', 'Колокольчик.', '', '', '', 'колокольчик'),
(496, 'Бронза, патинирование, подпись в литье «C.Cardet», Западная Европа, к. XIX в., высота 32,8 см, длина 20,5 см. (утрачены 2 крепежных винта и 1 гайка)', 'Бронза, патинирование, подпись в литье «C.Cardet», Западная Европа, к. XIX в., высота 32,8 см, длина 20,5 см. (утрачены 2 крепежных винта и 1 гайка)', 'Скульптура «Олень».', '', '', '', 'скульптура-«олень»'),
(497, 'Бронза, патинирование, Западная Европа, к. XIX в. - н. ХХ вв., высота 6,5 см, длина 20,5 см. (крепежный винт сломан)', 'Бронза, патинирование, Западная Европа, к. XIX в. - н. ХХ вв., высота 6,5 см, длина 20,5 см. (крепежный винт сломан)', 'Настольное украшение «Рак на камне».', '', '', '', 'настольное-украшение-«рак-на-камне»'),
(498, 'Металл, смальта, мозаика, Западная Европа, к. XIX - н. ХХ вв., размер 12,5х10 см', 'Металл, смальта, мозаика, Западная Европа, к. XIX - н. ХХ вв., размер 12,5х10 см', 'Рамка для фотографии.', '', '', '', 'рамка-для-фотографии'),
(499, 'Бронза, золочение, бархат, 2-я пол. XIX в., утраты на передних ножках, высота 15 см.', 'Бронза, золочение, бархат, 2-я пол. XIX в., утраты на передних ножках, высота 15 см.', 'Подчасник.', '', '', '', 'подчасник'),
(500, 'Бронза, патинирование, Россия, Санкт-Петербург, фабрика К. Верфеля, клеймо: «C.F. Woerffel.» к. XIX - н. ХХ вв., высота 10 см, длина 17,5 см.', 'Бронза, патинирование, Россия, Санкт-Петербург, фабрика К. Верфеля, клеймо: «C.F. Woerffel.» к. XIX - н. ХХ вв., высота 10 см, длина 17,5 см.', 'Настольное украшение «Медведь».', '', '', '', 'настольное-украшение-«медведь»'),
(501, 'Бронза, Западная Европа, к. XIX - н. ХХ вв., длина 13,5 см.', 'Бронза, Западная Европа, к. XIX - н. ХХ вв., длина 13,5 см.', 'Орехокол в виде дамских ножек.', '', '', '', 'орехокол-в-виде-дамских-ножек'),
(502, 'Бронза, золочение, стекло, к. XIX - н. ХХ вв., размер 27х15,7 см.', 'Бронза, золочение, стекло, к. XIX - н. ХХ вв., размер 27х15,7 см.', 'Рамка для фотографии.', '', '', '', 'рамка-для-фотографии2013-02-24-16-52-00_'),
(503, 'Серебро 875 пробы. Клейма: «0,875  84», швейцарское пробирное клеймо «медведь», номер 3461413. Диаметр 5 см (механизм в рабочем состоянии)', 'Серебро 875 пробы. Клейма: «0,875  84», швейцарское пробирное клеймо «медведь», номер 3461413. Диаметр 5 см (механизм в рабочем состоянии)', 'Часы карманные, мужские «луковица» фирма «LONGINES».', '', '', '', 'часы-карманные,-мужские-«луковица»-фирма-«longines»'),
(504, 'Часы: серебро 800 пробы. Клейма: немецкое пробирное клеймо «корона с полумесяцем», 0,800 silver. Диаметр 4.5 см. Шатлен: тесьма, серебро 800 пробы. (механизм часов в рабочем состоянии, несколько деформаций на задней крышке часов)', 'Часы: серебро 800 пробы. Клейма: немецкое пробирное клеймо «корона с полумесяцем», 0,800 silver. Диаметр 4.5 см. Шатлен: тесьма, серебро 800 пробы. (механизм часов в рабочем состоянии, несколько деформаций на задней крышке часов)', 'Часы карманные, мужские «луковица» с шатленом.', '', '', '', 'часы-карманные,-мужские-«луковица»-с-шатленом'),
(505, 'Золото 750, 583, эмаль, бриллианты. Франция, Lоuis Grisel, к. XIX-н.ХХ вв., клейма: 72,18 К. 28 бриллиантов - 3,32 ct, средние характеристики 3-4-5.5. Вес: общий - 37,39 гр, часы - 24,85 гр, цепь - 12,52 гр., размер: длина цепи 86 см, диаметр часов 2,5 см.', 'Золото 750, 583, эмаль, бриллианты. Франция, Lоuis Grisel, к. XIX-н.ХХ вв., клейма: 72,18 К. 28 бриллиантов - 3,32 ct, средние характеристики 3-4-5.5. Вес: общий - 37,39 гр, часы - 24,85 гр, цепь - 12,52 гр., размер: длина цепи 86 см, диаметр часов 2,5 см.', 'Дамские часы-подвеска, три крышки, цепь якорного плетения.', '', '', '', 'дамские-часы-подвеска,-три-крышки,-цепь-якорного-плетения'),
(506, 'Золото 585, синтетические рубины, Щвейцария, Женева, н. ХХ в., клейма: 56/14К, вес 85,33 гр., диаметр 5,3 см.', 'Золото 585, синтетические рубины, Щвейцария, Женева, н. ХХ в., клейма: 56/14К, вес 85,33 гр., диаметр 5,3 см.', 'Часы карманные мужские фирмы «J.Barth & Fils» трехкрышечные с минутным репетиром.', '', '', '', 'часы-карманные-мужские-фирмы-«j-barth-fils»-трехкрышечные-с-минутным-репетиром'),
(507, 'Красное дерево, бронза, н. ХХ в., высота 67 см, ширина 30 см. (подставки под свечи и навершие - более поздние, отсутствует 1 стрелка, не на ходу)', 'Красное дерево, бронза, н. ХХ в., высота 67 см, ширина 30 см. (подставки под свечи и навершие - более поздние, отсутствует 1 стрелка, не на ходу)', 'Часы настенные с 2-мя подсвечниками.', '', '', '', 'часы-настенные-с-2-мя-подсвечниками'),
(508, 'Фаянс, зеленое крытье, роспись, Фабрика Гарднера, Россия, марка красная «Фабрик . Гарднеръ в Москве», к. XIX - н. ХХ вв., 13х33.5х33.5 см', 'Фаянс, зеленое крытье, роспись, Фабрика Гарднера, Россия, марка красная «Фабрик . Гарднеръ в Москве», к. XIX - н. ХХ вв., 13х33.5х33.5 см', 'Менажница «Цветы яблони».', '', '', '', 'менажница-«цветы-яблони»'),
(509, 'Фарфор, кобальт, золочение, деколь, Германия, Зуль, фабрика Erdmann Schlegelmilch, 1910-е гг., высота 13 см, длина 6.5 см (реставрация ручки)', 'Фарфор, кобальт, золочение, деколь, Германия, Зуль, фабрика Erdmann Schlegelmilch, 1910-е гг., высота 13 см, длина 6.5 см (реставрация ручки)', 'Конфетница «Девушка с лютней».', '', '', '', 'конфетница-«девушка-с-лютней»'),
(510, 'Фарфор, деколь с подрисовкой, золочение. Марка: в тесте изображение восьмерки или знака «бесконечность» (неизвестная марка). Западная Европа, н. ХХ в. Диаметр 34 см (небольшие потертости по деколи и потертости позолоты)', 'Фарфор, деколь с подрисовкой, золочение. Марка: в тесте изображение восьмерки или знака «бесконечность» (неизвестная марка). Западная Европа, н. ХХ в. Диаметр 34 см (небольшие потертости по деколи и потертости позолоты)', 'Тарелка декоративная «Семейная прогулка».', '', '', '', 'тарелка-декоративная-«семейная-прогулка»'),
(511, 'Фарфор, роспись, золочение, Россия, реставрация живописи,  потертости золочения , высота 8 см', 'Фарфор, роспись, золочение, Россия, реставрация живописи,  потертости золочения , высота 8 см', 'Яйцо пасхальное «Св. Николай Чудотворец»', '', '', '', 'яйцо-пасхальное-«св-николай-чудотворец»'),
(512, 'Фарфор, розовое крытье, роспись, золочение, Франция, Севр, н. XIX в., диаметр 23,5 см (потертости)', 'Фарфор, розовое крытье, роспись, золочение, Франция, Севр, н. XIX в., диаметр 23,5 см (потертости)', 'Тарелки парные «Ампирный орнамент».', '', '', '', 'тарелки-парные-«ампирный-орнамент»'),
(513, 'Фарфор, роспись, золочение, марка НI под короной, Россия, ИФЗ, период Николая I (1825-1855), диаметр 17 см (потертости)', 'Фарфор, роспись, золочение, марка НI под короной, Россия, ИФЗ, период Николая I (1825-1855), диаметр 17 см (потертости)', 'Блюдце «Орнамент».', '', '', '', 'блюдце-«орнамент»'),
(514, 'Фарфор, роспись, золочение, Франция, Севр, 1853 г., марка зеленая печатная S 53, в тесте - «D», высота чашки 6,3 см, диаметр блюдца 12 см.', 'Фарфор, роспись, золочение, Франция, Севр, 1853 г., марка зеленая печатная S 53, в тесте - «D», высота чашки 6,3 см, диаметр блюдца 12 см.', 'Чашка с блюдцем «Цветы и птицы».', '', '', '', 'чашка-с-блюдцем-«цветы-и-птицы»'),
(515, 'Фарфор, роспись, на обороте надпись «Аморъ», «38», G-синяя подглазурная, рамка - латунь, золочение, кожа, Россия (?), 1-я пол. XIX в., завод Гарднера (?), на коже «Dooken Meyer Helmstedt», овал 16х11 см.', 'Фарфор, роспись, на обороте надпись «Аморъ», «38», G-синяя подглазурная, рамка - латунь, золочение, кожа, Россия (?), 1-я пол. XIX в., завод Гарднера (?), на коже «Dooken Meyer Helmstedt», овал 16х11 см.', 'Плакетка «Амур, вырезающий лук».', '', '', '', 'плакетка-«амур,-вырезающий-лук»'),
(516, 'Фарфор, роспись, золочение, Россия, марка ВС, синяя надглазурная, коричневым N3, завод В. Сабянина, 1845-1875 гг., высота чашки - 5 см, диаметр блюдца - 13 см.', 'Фарфор, роспись, золочение, Россия, марка ВС, синяя надглазурная, коричневым N3, завод В. Сабянина, 1845-1875 гг., высота чашки - 5 см, диаметр блюдца - 13 см.', '6 чашек с блюдцами «Розы».', '', '', '', '6-чашек-с-блюдцами-«розы»'),
(517, 'Фарфор, роспись «Цветы», золочение, Россия, фабрика М.С. Кузнецова в Дулево, н. ХХ в., высота чашки - 7 см, диаметр блюдца - 13,5 см.', 'Фарфор, роспись «Цветы», золочение, Россия, фабрика М.С. Кузнецова в Дулево, н. ХХ в., высота чашки - 7 см, диаметр блюдца - 13,5 см.', 'Чашка с блюдцем.', '', '', '', 'чашка-с-блюдцем'),
(518, 'Фарфор, роспись, Россия, н. ХХ в., высота 11 см.', 'Фарфор, роспись, Россия, н. ХХ в., высота 11 см.', 'Яйцо пасхальное «Колокольчики».', '', '', '', 'яйцо-пасхальное-«колокольчики»'),
(519, 'Фарфор, роспись, Россия, н. ХХ в., высота 11 см.', 'Фарфор, роспись, Россия, н. ХХ в., высота 11 см.', 'Яйцо пасхальное «Цветы и гирлянды».', '', '', '', 'яйцо-пасхальное-«цветы-и-гирлянды»'),
(520, 'Фарфор, зеленое крытье, роспись, золочение, Россия, завод братьев Корниловых, 1850-60-е гг., без марки, высота чашки - 6,5 см, диаметр блюдца - 15 см.', 'Фарфор, зеленое крытье, роспись, золочение, Россия, завод братьев Корниловых, 1850-60-е гг., без марки, высота чашки - 6,5 см, диаметр блюдца - 15 см.', 'Чашка с блюдцем «Цветы».', '', '', '', 'чашка-с-блюдцем-«цветы»'),
(521, 'Фарфор, роспись, муар, Россия, н. ХХ в., размер 19,2х15,2 см и 19,5х15,2 см', 'Фарфор, роспись, муар, Россия, н. ХХ в., размер 19,2х15,2 см и 19,5х15,2 см', '2 рамки для фотографий «Зимние пейзажи».', '', '', '', '2-рамки-для-фотографий-«зимние-пейзажи»'),
(522, 'Фарфор, кобальт, роспись золотом, фабрика М.С. Кузнецова в Дулево, н . ХХ в., высота чашки  5,5 см, диаметр блюдца 15,5 см.', 'Фарфор, кобальт, роспись золотом, фабрика М.С. Кузнецова в Дулево, н . ХХ в., высота чашки  5,5 см, диаметр блюдца 15,5 см.', 'Чашка с блюдцем.', '', '', '', 'чашка-с-блюдцем2013-02-24-16-54-24_'),
(523, 'Фарфор, роспись, подпись «Л. Добровольская», Россия, н. ХХ в., диаметр 20 см. Сколы.', 'Фарфор, роспись, подпись «Л. Добровольская», Россия, н. ХХ в., диаметр 20 см. Сколы.', 'Три декоративные тарелки «Девочка с лукошком».', '', '', '', 'три-декоративные-тарелки-«девочка-с-лукошком»'),
(524, 'Фарфор, роспись полихромная, лепка, н. ХХ в., без марки, высота 16 см.', 'Фарфор, роспись полихромная, лепка, н. ХХ в., без марки, высота 16 см.', 'Конфетница «Корзинка».', '', '', '', 'конфетница-«корзинка»'),
(525, 'Фарфор, голубое крытье, роспись под-надглазурная, золочение, Западная Европа, к. XIX - ХХ вв., высота 47 см.', 'Фарфор, голубое крытье, роспись под-надглазурная, золочение, Западная Европа, к. XIX - ХХ вв., высота 47 см.', 'Вазы парные в стиле рококо.', '', '', '', 'вазы-парные-в-стиле-рококо'),
(526, 'Фарфор, крытье, живопись надглазурная полихромная, н. ХХ в., диаметр 17,5 см.', 'Фарфор, крытье, живопись надглазурная полихромная, н. ХХ в., диаметр 17,5 см.', 'Тарелка декоративная «Портрет цыганки».', '', '', '', 'тарелка-декоративная-«портрет-цыганки»'),
(527, 'Бисквит, полихромная роспись, к. XIX в., высота 23 см, длина 27 см.', 'Бисквит, полихромная роспись, к. XIX в., высота 23 см, длина 27 см.', 'Шкатулка «Курица».', '', '', '', 'шкатулка-«курица»'),
(528, 'Фарфор, подглазурная полихромная роспись, Копенгаген, Дания, Bing & Grondal, 1-я пол. ХХ в., высота 16,5 см.', 'Фарфор, подглазурная полихромная роспись, Копенгаген, Дания, Bing & Grondal, 1-я пол. ХХ в., высота 16,5 см.', 'Парные вазочки «Ландыши».', '', '', '', 'парные-вазочки-«ландыши»'),
(529, 'Фарфор, деколь, Западная Европа, к. XIX - н. ХХ вв., диаметр 30 см.', 'Фарфор, деколь, Западная Европа, к. XIX - н. ХХ вв., диаметр 30 см.', 'Блюдо «Мифологический сюжет».', '', '', '', 'блюдо-«мифологический-сюжет»'),
(530, 'Фаянс, лепка, раскраска, Западная Европа, н. ХХ в., высота 15,5 см, длина 28 см.', 'Фаянс, лепка, раскраска, Западная Европа, н. ХХ в., высота 15,5 см, длина 28 см.', 'Ваза в стиле модерн «Маки».', '', '', '', 'ваза-в-стиле-модерн-«маки»'),
(531, 'Фарфор, роспись , золочение, Германия, Розенталь, н. ХХ в. (до 1924 г.), марка зеленая подглазурная «Rosenthal», серия «Rhododendron»  Handgemalt, 5216 (красным), размер 16х11х11 см.', 'Фарфор, роспись , золочение, Германия, Розенталь, н. ХХ в. (до 1924 г.), марка зеленая подглазурная «Rosenthal», серия «Rhododendron»  Handgemalt, 5216 (красным), размер 16х11х11 см.', 'Шкатулка «На катке».', '', '', '', 'шкатулка-«на-катке»'),
(532, 'Фарфор, деколь, золочение, без марки, Западная Европа, к. XIX - н. ХХ вв., диаметр 28,5 см.', 'Фарфор, деколь, золочение, без марки, Западная Европа, к. XIX - н. ХХ вв., диаметр 28,5 см.', 'Парные настенные тарелки «Галантные сцены».', '', '', '', 'парные-настенные-тарелки-«галантные-сцены»'),
(533, 'Фарфор, роспись, Дания, Копенгаген, Королевская мануфактура, н. ХХ в., высота 8 см.', 'Фарфор, роспись, Дания, Копенгаген, Королевская мануфактура, н. ХХ в., высота 8 см.', 'Фигурка «Играющие кошки».', '', '', '', 'фигурка-«играющие-кошки»'),
(534, 'Фарфор, роспись, золочение, Франция, Лимож, н. ХХ в., подпись «Pierre», марка «Limoges, France», диаметр 34 см.', 'Фарфор, роспись, золочение, Франция, Лимож, н. ХХ в., подпись «Pierre», марка «Limoges, France», диаметр 34 см.', 'Настенное декоративное блюдо «Рыба, цветы и фрукты» .', '', '', '', 'настенное-декоративное-блюдо-«рыба,-цветы-и-фрукты»'),
(535, 'Фарфор, роспись, золочение, Франция, Лимож, н. ХХ в., подпись «Pierre», марка «Limoges, France», диаметр 34 см.', 'Фарфор, роспись, золочение, Франция, Лимож, н. ХХ в., подпись «Pierre», марка «Limoges, France», диаметр 34 см.', 'Настенное декоративное блюдо «Розы» .', '', '', '', 'настенное-декоративное-блюдо-«розы»'),
(536, 'Бисквит, лепка, золочение, Западная Европа, к. XIX в., без марки, размер 21,5х12х15 см.', 'Бисквит, лепка, золочение, Западная Европа, к. XIX в., без марки, размер 21,5х12х15 см.', 'Кашпо «В парке».', '', '', '', 'кашпо-«в-парке»'),
(537, 'Фарфор, роспись, золочение, лепные маскароны, Франция, 2-я пол. XIX в., высота 37 см. (на крышке скол и склейка)', 'Фарфор, роспись, золочение, лепные маскароны, Франция, 2-я пол. XIX в., высота 37 см. (на крышке скол и склейка)', 'Ваза с крышкой в стиле Севр.', '', '', '', 'ваза-с-крышкой-в-стиле-севр'),
(538, 'Фарфор, роспись, золочение, без марки, Западная Европа, 2-я пол. XIX в., высота чашки 8,5 см, диаметр блюдца 17 см (потертости золочения)', 'Фарфор, роспись, золочение, без марки, Западная Европа, 2-я пол. XIX в., высота чашки 8,5 см, диаметр блюдца 17 см (потертости золочения)', 'Чашка с блюдцем «Цветы».', '', '', '', 'чашка-с-блюдцем-«цветы»2013-02-24-16-54-24_'),
(539, 'Фарфор, роспись, золочение, без марки, Западная Европа, 2-я пол. XIX в., высота чашки 8,5 см, диаметр блюдца 17 см (потертости золочения)', 'Фарфор, роспись, золочение, без марки, Западная Европа, 2-я пол. XIX в., высота чашки 8,5 см, диаметр блюдца 17 см (потертости золочения)', 'Чашка с блюдцем «Цветы».', '', '', '', 'чашка-с-блюдцем-«цветы»2013-02-24-16-54-24_4'),
(540, 'Фарфор, роспись, золочение, Япония, н. ХХ в., высота чашки 5 см, диаметр блюдца 14 см.', 'Фарфор, роспись, золочение, Япония, н. ХХ в., высота чашки 5 см, диаметр блюдца 14 см.', 'Чашка с блюдцем «Самураи».', '', '', '', 'чашка-с-блюдцем-«самураи»'),
(541, 'Фарфор, розовое крытье, роспись, золочение, Россия, завод Кузнецова на Волхове, н. ХХ в., высота чашки 8 см, диаметр блюдца 14 см (небольшой скол на основании чашки)', 'Фарфор, розовое крытье, роспись, золочение, Россия, завод Кузнецова на Волхове, н. ХХ в., высота чашки 8 см, диаметр блюдца 14 см (небольшой скол на основании чашки)', 'Чашка с блюдцем.', '', '', '', 'чашка-с-блюдцем2013-02-24-16-54-24_3'),
(542, 'Фаянс, роспись, золочение. На обороте дарственная надпись «На память от Е.П. 19 16/11 08», Россия, н. ХХ в., диаметр 20 см.', 'Фаянс, роспись, золочение. На обороте дарственная надпись «На память от Е.П. 19 16/11 08», Россия, н. ХХ в., диаметр 20 см.', 'Пласт «Нарциссы».', '', '', '', 'пласт-«нарциссы»'),
(543, 'Фарфор, роспись, золочение, Германия, Берлин, КРМ, марка синий скипетр (1875-1944), нач. ХХ в., диаметр 34 см.', 'Фарфор, роспись, золочение, Германия, Берлин, КРМ, марка синий скипетр (1875-1944), нач. ХХ в., диаметр 34 см.', 'Настенное декоративное блюдо «Розы».', '', '', '', 'настенное-декоративное-блюдо-«розы»2013-02-24-16-54-24_'),
(544, 'Фарфор, монохромная надглазурная роспись, орнаментальное золочение, КРМ, Берлин, Германия, марка голубая скипетр и красная держава, красным КРМ, н. ХХ в., диаметр 21,5 см.', 'Фарфор, монохромная надглазурная роспись, орнаментальное золочение, КРМ, Берлин, Германия, марка голубая скипетр и красная держава, красным КРМ, н. ХХ в., диаметр 21,5 см.', 'Тарелка «Цветы».', '', '', '', 'тарелка-«цветы»'),
(545, 'Фарфор, роспись полихромная, подглазурная, Мейсен Германия, марка синие скрещенные мечи, н. ХХ в., высота 11,5 см.', 'Фарфор, роспись полихромная, подглазурная, Мейсен Германия, марка синие скрещенные мечи, н. ХХ в., высота 11,5 см.', 'Фигура «Львенок».', '', '', '', 'фигура-«львенок»'),
(546, 'Фарфор, роспись надглазурная, полихромная, золотое и серебряное крытье, рельеф, орнаментальное золочение, Австрия (?), марка венский щиток, к. XIX -  н. ХХ вв., высота чашки 6,5 см, диаметр блюдца 13,5 см.', 'Фарфор, роспись надглазурная, полихромная, золотое и серебряное крытье, рельеф, орнаментальное золочение, Австрия (?), марка венский щиток, к. XIX -  н. ХХ вв., высота чашки 6,5 см, диаметр блюдца 13,5 см.', 'Чашка с блюдцем.', '', '', '', 'чашка-с-блюдцем2013-02-24-16-54-24_1'),
(547, 'Фарфор, роспись, золочение, Силезия, Тифенфурт, марка под орлом ТРМ (Tiefenfurt Porzellan Manufaktur), к. XIX в., размер 34х22х10 см.', 'Фарфор, роспись, золочение, Силезия, Тифенфурт, марка под орлом ТРМ (Tiefenfurt Porzellan Manufaktur), к. XIX в., размер 34х22х10 см.', 'Менажница «Цветы».', '', '', '', 'менажница-«цветы»'),
(548, 'Фарфор, кобальт, золочение, роспись, Франция, Лимож, фарфоровая фабрика Mavaleix & Granger, марка - сплетенные M и G, France deposee, 1920-1938 гг., диаметр 20,8 см.', 'Фарфор, кобальт, золочение, роспись, Франция, Лимож, фарфоровая фабрика Mavaleix & Granger, марка - сплетенные M и G, France deposee, 1920-1938 гг., диаметр 20,8 см.', 'Тарелка «Орел и журавль».', '', '', '', 'тарелка-«орел-и-журавль»'),
(549, 'Фарфор, живопись, Западная Европа, к. XIX - н. ХХ вв., подпись в правом нижнем углу неразборчиво, без марки, на обороте карандашом номера, рамка: дерево, золочение, бархат, размер 20х15 см.', 'Фарфор, живопись, Западная Европа, к. XIX - н. ХХ вв., подпись в правом нижнем углу неразборчиво, без марки, на обороте карандашом номера, рамка: дерево, золочение, бархат, размер 20х15 см.', 'Фарфоровый пласт «Проснись, дорогая».', '', '', '', 'фарфоровый-пласт-«проснись,-дорогая»'),
(550, 'Фарфор, роспись, золочение, Франция, н. ХХ в., диаметр 24 см.', 'Фарфор, роспись, золочение, Франция, н. ХХ в., диаметр 24 см.', 'Тарелка «Цветы».', '', '', '', 'тарелка-«цветы»2013-02-24-16-54-24_'),
(552, 'Фарфор, роспись, Дания, Копенгаген, Королевская мануфактура, н. ХХ в., высота 17 см', 'Фарфор, роспись, Дания, Копенгаген, Королевская мануфактура, н. ХХ в., высота 17 см', 'Ваза «Колокольчики».', '', '', '', 'ваза-«колокольчики»'),
(553, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см. (скол на лицевой стороне, сколы на задней стороне)', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см. (скол на лицевой стороне, сколы на задней стороне)', 'Настенное декоративное блюдо «Московский университет».', '', '', '', 'настенное-декоративное-блюдо-«московский-университет»'),
(554, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «Большой театр».', '', '', '', 'настенное-декоративное-блюдо-«большой-театр»'),
(555, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см. (небольшая технологическая трещина)', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см. (небольшая технологическая трещина)', 'Настенное декоративное блюдо «Дворец съездов».', '', '', '', 'настенное-декоративное-блюдо-«дворец-съездов»'),
(556, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «СЭВ» (Здание «Совета экономической взаимопомощи»).', '', '', '', 'настенное-декоративное-блюдо-«сэв»-здание-«совета-экономической-взаимопомощи»'),
(557, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «Третьяковская галерея».', '', '', '', 'настенное-декоративное-блюдо-«третьяковская-галерея»'),
(558, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «Башни Кремля».', '', '', '', 'настенное-декоративное-блюдо-«башни-кремля»'),
(559, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «Исторический музей».', '', '', '', 'настенное-декоративное-блюдо-«исторический-музей»'),
(560, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «Храм Василия Блаженного».', '', '', '', 'настенное-декоративное-блюдо-«храм-василия-блаженного»'),
(561, 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Керамика, глазурь, роспись, СССР, 1970-е гг., диаметр 50 см.', 'Настенное декоративное блюдо «Кремлёвские соборы».', '', '', '', 'настенное-декоративное-блюдо-«кремлёвские-соборы»'),
(562, 'Фарфор, роспись полихромная, золочение, ЛЗФИ, 1950-60 гг. Высота 8 и 11,5 см', 'Фарфор, роспись полихромная, золочение, ЛЗФИ, 1950-60 гг. Высота 8 и 11,5 см', 'Композиция из двух фигур «Золушка и Принц», «Принц».', '', '', '', 'композиция-из-двух-фигур-«золушка-и-принц»,-«принц»'),
(563, 'Фарфор, роспись, Западная Европа, 1-я пол. ХХ в., высота 4 см., диаметр 6,5 см.', 'Фарфор, роспись, Западная Европа, 1-я пол. ХХ в., высота 4 см., диаметр 6,5 см.', 'Горчичница «Подсолнух».', '', '', '', 'горчичница-«подсолнух»'),
(564, 'Фарфор, подпись «Кошки и мышки», В.Ф. Афоничев, авторская роспись, предмет поступил из семьи художника,СССР, 1970-80-е гг., высота 10 см.', 'Фарфор, подпись «Кошки и мышки», В.Ф. Афоничев, авторская роспись, предмет поступил из семьи художника,СССР, 1970-80-е гг., высота 10 см.', 'Сливочник.', '', '', '', 'сливочник'),
(565, 'Фарфор, роспись ЛФЗ, 1950-е гг., высота 13,5см', 'Фарфор, роспись ЛФЗ, 1950-е гг., высота 13,5см', 'Фигурка «Медведь из квартета».', '', '', '', 'фигурка-«медведь-из-квартета»'),
(566, 'Фарфор, золочение, ЛФЗ, 1950-е гг., высота15,5см', 'Фарфор, золочение, ЛФЗ, 1950-е гг., высота15,5см', 'Фигурка «Юный Пушкин».', '', '', '', 'фигурка-«юный-пушкин»'),
(567, 'Фарфор, золочение, ЛФЗ, 1960-е гг., высота 13см', 'Фарфор, золочение, ЛФЗ, 1960-е гг., высота 13см', 'Фигурка «Юная балерина».', '', '', '', 'фигурка-«юная-балерина»'),
(568, 'Фарфор, подглазурная полихромная роспись, Западная Европа, 3-я четв. ХХ в., высота 23,5 см.', 'Фарфор, подглазурная полихромная роспись, Западная Европа, 3-я четв. ХХ в., высота 23,5 см.', 'Фигурка «Девочка с мишкой».', '', '', '', 'фигурка-«девочка-с-мишкой»'),
(569, 'Керамика, цветная глазурь, Россия(?), сер. ХХ в., высота 20,5 см, диаметр 19 см', 'Керамика, цветная глазурь, Россия(?), сер. ХХ в., высота 20,5 см, диаметр 19 см', 'Кашпо «Яблоки».', '', '', '', 'кашпо-«яблоки»'),
(570, 'Фарфор, роспись, золочение, СССР, Дулевский фарфоровый завод, 1954 г., высота 18,5 см.', 'Фарфор, роспись, золочение, СССР, Дулевский фарфоровый завод, 1954 г., высота 18,5 см.', 'Фигурка «Девочка, кормящая птиц».', '', '', '', 'фигурка-«девочка,-кормящая-птиц»'),
(571, 'Фарфор, роспись, люстр, Германия, 1950-е гг., без марки, в тесте «8728», высота 21,5 см.', 'Фарфор, роспись, люстр, Германия, 1950-е гг., без марки, в тесте «8728», высота 21,5 см.', 'Фигурка «Восточный танец».', '', '', '', 'фигурка-«восточный-танец»'),
(572, 'Фарфор, роспись, золочение, СССР, Чудово, 1958 г., высота 27,5 см.', 'Фарфор, роспись, золочение, СССР, Чудово, 1958 г., высота 27,5 см.', 'Фигурка «Русский танец».', '', '', '', 'фигурка-«русский-танец»'),
(573, 'Фарфор, роспись, СССР, г. Новгород, завод «Пролетарий», без марки, 1950-е гг., высота 16,5 см.', 'Фарфор, роспись, СССР, г. Новгород, завод «Пролетарий», без марки, 1950-е гг., высота 16,5 см.', 'Фигурка «Ребенок в зимней одежде» .', '', '', '', 'фигурка-«ребенок-в-зимней-одежде»'),
(574, 'Фарфор, роспись, СССР, ЛФЗ, 1930-е гг., высота 10,5 см, диаметр 14,5 см.', 'Фарфор, роспись, СССР, ЛФЗ, 1930-е гг., высота 10,5 см, диаметр 14,5 см.', 'Пепельница «Белый медведь».', '', '', '', 'пепельница-«белый-медведь»'),
(575, 'Фарфор, роспись, люстр, СССР, Киевский экспериментальный керамико-художественный завод, г. Вишневый, 1960-70-е гг., высота 27,5 см.', 'Фарфор, роспись, люстр, СССР, Киевский экспериментальный керамико-художественный завод, г. Вишневый, 1960-70-е гг., высота 27,5 см.', 'Фигурка «Эстрадная певица».', '', '', '', 'фигурка-«эстрадная-певица»'),
(576, 'Обливная керамика, СССР, 1967 г.(?), размер 38х44 см.', 'Обливная керамика, СССР, 1967 г.(?), размер 38х44 см.', 'Блюдо декоративное «50 лет Октябрьской Революции».', '', '', '', 'блюдо-декоративное-«50-лет-октябрьской-революции»'),
(577, 'Фаянс, печать, золочение, завод им. М.И. Калинина, Конаково, 1930-е гг., диаметр 21,7 см', 'Фаянс, печать, золочение, завод им. М.И. Калинина, Конаково, 1930-е гг., диаметр 21,7 см', 'Тарелка настенная «Портрет А.С.Грибоедова».', '', '', '', 'тарелка-настенная-«портрет-а-с-грибоедова»'),
(578, 'Фаянс, печать, золочение, завод им. М.И.Калинина, Конаково, 1930-е гг., диаметр 21,7 см (сколы на тыльной стороне)', 'Фаянс, печать, золочение, завод им. М.И.Калинина, Конаково, 1930-е гг., диаметр 21,7 см (сколы на тыльной стороне)', 'Тарелка настенная «Портрет Т.Г Шевченко».', '', '', '', 'тарелка-настенная-«портрет-т-г-шевченко»'),
(579, 'Фаянс, печать, золочение, завод им. М.И.Калинина, Конаково, 1930-е гг., диаметр 21,7 см', 'Фаянс, печать, золочение, завод им. М.И.Калинина, Конаково, 1930-е гг., диаметр 21,7 см', 'Тарелка настенная «Портрет И.А.Крылова».', '', '', '', 'тарелка-настенная-«портрет-и-а-крылова»'),
(580, 'Фарфор, роспись, Дулево, 1930-е гг., диаметр 31 см', 'Фарфор, роспись, Дулево, 1930-е гг., диаметр 31 см', 'Блюдо настенное «Цветы».', '', '', '', 'блюдо-настенное-«цветы»'),
(581, 'Фарфор, роспись, ск. Н.Я.Данько и Е.Я.Данько, ЛФЗ, 1930-е гг., 8х20,3х10,8 см', 'Фарфор, роспись, ск. Н.Я.Данько и Е.Я.Данько, ЛФЗ, 1930-е гг., 8х20,3х10,8 см', 'Пепельница из чернильного прибора «Обсуждение Сталинской конституции»', '', '', '', 'пепельница-из-чернильного-прибора-«обсуждение-сталинской-конституции»'),
(582, 'Фарфор, роспись, ЛФЗ, 1970-е гг., высота 11,5 см', 'Фарфор, роспись, ЛФЗ, 1970-е гг., высота 11,5 см', 'Скульптура «Белый медвежонок».', '', '', '', 'скульптура-«белый-медвежонок»'),
(583, 'Дерево, масло, к. ХIХ в., 26,7х22,3 см. (сколы по углам, потертости)', 'Дерево, масло, к. ХIХ в., 26,7х22,3 см. (сколы по углам, потертости)', 'Икона «Св.Николай Чудотворец».', '', '', '', 'икона-«св-николай-чудотворец»'),
(584, 'Дерево, масло, сусальное золочение, Россия, к. XIX в., размер 31х26,5 см. (сколы, потертости)', 'Дерево, масло, сусальное золочение, Россия, к. XIX в., размер 31х26,5 см. (сколы, потертости)', 'Икона «Сретение Господне».', '', '', '', 'икона-«сретение-господне»'),
(585, 'Дерево, масло, к. ХIХ в., 26,7х22,3 см. (сколы по углам, потертости)', 'Дерево, масло, к. ХIХ в., 26,7х22,3 см. (сколы по углам, потертости)', 'Икона «Св.Николай Чудотворец».', '', '', '', 'икона-«св-николай-чудотворец»2013-02-24-17-06-46_'),
(586, 'Дерево, масло, сусальное золочение, Россия, к. XIX в., размер 31х26,5 см. (сколы, потертости)', 'Дерево, масло, сусальное золочение, Россия, к. XIX в., размер 31х26,5 см. (сколы, потертости)', 'Икона «Сретение Господне».', '', '', '', 'икона-«сретение-господне»2013-02-24-17-06-46_'),
(587, 'Дерево, масло, к. ХIХ в., 26,7х22,3 см. (сколы по углам, потертости)', 'Дерево, масло, к. ХIХ в., 26,7х22,3 см. (сколы по углам, потертости)', 'Икона «Св.Николай Чудотворец».', '', '', '', 'икона-«св-николай-чудотворец»2013-02-24-19-11-31_'),
(588, 'Дерево, масло, сусальное золочение, Россия, к. XIX в., размер 31х26,5 см. (сколы, потертости)', '<p>Дерево, масло, сусальное золочение, Россия, к. XIX в., размер 31х26,5 см. (сколы, потертости)</p>', 'Икона «Сретение Господне».', '', '', '', 'икона-«сретение-господне»2013-02-24-19-11-31_'),
(589, 'Венская бронза. Бронза, литье, раскраска. Вена, Австрия, н. ХХ в. Размер высота 7.5 см., длина 14 см. ( небольшие потертости красочного слоя)', 'Венская бронза. Бронза, литье, раскраска. Вена, Австрия, н. ХХ в. Размер высота 7.5 см., длина 14 см. ( небольшие потертости красочного слоя)', 'Фигурка «Гордон сеттер с уткой».', '', '', '', 'фигурка-«гордон-сеттер-с-уткой»2013-02-24-19-32-17_'),
(590, 'Чугун, литье, рельеф, полировка, Россия, к. XIX в., завод Э. Ферстера (Санкт-Петербург) и Кусинский завод (Урал), клейма на обороте «Кус.З» и «Завод Э.Ферстер СПетербург», диаметр 53,7 см.', 'Чугун, литье, рельеф, полировка, Россия, к. XIX в., завод Э. Ферстера (Санкт-Петербург) и Кусинский завод (Урал), клейма на обороте «Кус.З» и «Завод Э.Ферстер СПетербург», диаметр 53,7 см.', 'Блюдо декоративное «Медуза Горгона» в стиле Ренессанс.', '', '', '', 'блюдо-декоративное-«медуза-горгона»-в-стиле-ренессанс2013-02-24-19-32-17_'),
(591, 'Чугун, литье, СССР, Каслинский завод, 1989 г., Клейма: Касли, 1989 г. Высота 21 см.', 'Чугун, литье, СССР, Каслинский завод, 1989 г., Клейма: Касли, 1989 г. Высота 21 см.', 'Фигурка «Дон Кихот».', '', '', '', 'фигурка-«дон-кихот»2013-02-24-19-32-17_'),
(592, 'Металл, серебрение, Россия (?), н. ХХ в., на книге в руках Музы дарственная надпись «На память от Паши и Бориса» 19 IX/XII 16, высота 44,5 см, диаметр 33,5 см.', 'Металл, серебрение, Россия (?), н. ХХ в., на книге в руках Музы дарственная надпись «На память от Паши и Бориса» 19 IX/XII 16, высота 44,5 см, диаметр 33,5 см.', 'Ваза для фруктов с фигурой Музы.', '', '', '', 'ваза-для-фруктов-с-фигурой-музы2013-02-24-19-32-17_'),
(593, 'Бронза, золочение, патина, к. ХIХ в., высота 26 см (на одном утрачена деталь, очевидно, фигурка птички)', 'Бронза, золочение, патина, к. ХIХ в., высота 26 см (на одном утрачена деталь, очевидно, фигурка птички)', 'Парные подсвечники «Змея и лягушка», «Змея и птичье гнездо».', '', '', '', 'парные-подсвечники-«змея-и-лягушка»,-«змея-и-птичье-гнездо»2013-02-24-19-32-17_'),
(594, 'Металл, серебрение, Западная Европа, н. ХХ в., высота 6 см.', 'Металл, серебрение, Западная Европа, н. ХХ в., высота 6 см.', 'Настольное украшение «Ботинок с дырой».', '', '', '', 'настольное-украшение-«ботинок-с-дырой»2013-02-24-19-32-17_'),
(595, 'Бронза, литьё, золочение, Западная Европа, ХХ в., высота 6 см.', 'Бронза, литьё, золочение, Западная Европа, ХХ в., высота 6 см.', 'Композиция «Птичка над гнездом».', '', '', '', 'композиция-«птичка-над-гнездом»2013-02-24-19-32-17_'),
(596, 'Бронза, литье, чеканка, Россия, к. XIX - н. ХХ вв., длина 12.5 см, высота 3.5 см', 'Бронза, литье, чеканка, Россия, к. XIX - н. ХХ вв., длина 12.5 см, высота 3.5 см', 'Лапоть.', '', '', '', 'лапоть2013-02-24-19-32-17_'),
(597, 'Бронза, литье, золочение, Россия(?), 2-я пол. XIX в., высота 11 см', 'Бронза, литье, золочение, Россия(?), 2-я пол. XIX в., высота 11 см', 'Колокольчик.', '', '', '', 'колокольчик2013-02-24-19-32-17_'),
(598, 'Бронза, патинирование, подпись в литье «C.Cardet», Западная Европа, к. XIX в., высота 32,8 см, длина 20,5 см. (утрачены 2 крепежных винта и 1 гайка)', 'Бронза, патинирование, подпись в литье «C.Cardet», Западная Европа, к. XIX в., высота 32,8 см, длина 20,5 см. (утрачены 2 крепежных винта и 1 гайка)', 'Скульптура «Олень».', '', '', '', 'скульптура-«олень»2013-02-24-19-32-17_'),
(599, 'Бронза, патинирование, Западная Европа, к. XIX в. - н. ХХ вв., высота 6,5 см, длина 20,5 см. (крепежный винт сломан)', 'Бронза, патинирование, Западная Европа, к. XIX в. - н. ХХ вв., высота 6,5 см, длина 20,5 см. (крепежный винт сломан)', 'Настольное украшение «Рак на камне».', '', '', '', 'настольное-украшение-«рак-на-камне»2013-02-24-19-32-17_'),
(600, 'Металл, смальта, мозаика, Западная Европа, к. XIX - н. ХХ вв., размер 12,5х10 см', 'Металл, смальта, мозаика, Западная Европа, к. XIX - н. ХХ вв., размер 12,5х10 см', 'Рамка для фотографии.', '', '', '', 'рамка-для-фотографии2013-02-24-19-32-17_'),
(601, 'Бронза, золочение, бархат, 2-я пол. XIX в., утраты на передних ножках, высота 15 см.', 'Бронза, золочение, бархат, 2-я пол. XIX в., утраты на передних ножках, высота 15 см.', 'Подчасник.', '', '', '', 'подчасник2013-02-24-19-32-17_'),
(602, 'Бронза, патинирование, Россия, Санкт-Петербург, фабрика К. Верфеля, клеймо: «C.F. Woerffel.» к. XIX - н. ХХ вв., высота 10 см, длина 17,5 см.', 'Бронза, патинирование, Россия, Санкт-Петербург, фабрика К. Верфеля, клеймо: «C.F. Woerffel.» к. XIX - н. ХХ вв., высота 10 см, длина 17,5 см.', 'Настольное украшение «Медведь».', '', '', '', 'настольное-украшение-«медведь»2013-02-24-19-32-17_'),
(603, 'Бронза, Западная Европа, к. XIX - н. ХХ вв., длина 13,5 см.', 'Бронза, Западная Европа, к. XIX - н. ХХ вв., длина 13,5 см.', 'Орехокол в виде дамских ножек.', '', '', '', 'орехокол-в-виде-дамских-ножек2013-02-24-19-32-17_'),
(604, 'Бронза, золочение, стекло, к. XIX - н. ХХ вв., размер 27х15,7 см.', 'Бронза, золочение, стекло, к. XIX - н. ХХ вв., размер 27х15,7 см.', 'Рамка для фотографии.', '', '', '', 'рамка-для-фотографии2013-02-24-19-32-17_7');

-- 
-- Вывод данных для таблицы auc13_virtuemart_rating_reviews
--

-- Таблица auctionru_2013.auc13_virtuemart_rating_reviews не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_rating_votes
--

-- Таблица auctionru_2013.auc13_virtuemart_rating_votes не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_ratings
--

-- Таблица auctionru_2013.auc13_virtuemart_ratings не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_shipmentmethod_shoppergroups
--

-- Таблица auctionru_2013.auc13_virtuemart_shipmentmethod_shoppergroups не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_shipmentmethods
--

-- Таблица auctionru_2013.auc13_virtuemart_shipmentmethods не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_shipmentmethods_ru_ru
--

-- Таблица auctionru_2013.auc13_virtuemart_shipmentmethods_ru_ru не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_shoppergroups
--
INSERT INTO auc13_virtuemart_shoppergroups VALUES
(2, 1, '-default-', 'This is the default shopper group.', 0, NULL, 1, 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(1, 1, '-anonymous-', 'Shopper group for anonymous shoppers', 0, NULL, 2, 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_states
--
INSERT INTO auc13_virtuemart_states VALUES
(1, 1, 223, 0, 'Alabama', 'ALA', 'AL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 1, 223, 0, 'Alaska', 'ALK', 'AK', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 1, 223, 0, 'Arizona', 'ARZ', 'AZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 1, 223, 0, 'Arkansas', 'ARK', 'AR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(5, 1, 223, 0, 'California', 'CAL', 'CA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(6, 1, 223, 0, 'Colorado', 'COL', 'CO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(7, 1, 223, 0, 'Connecticut', 'CCT', 'CT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(8, 1, 223, 0, 'Delaware', 'DEL', 'DE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(9, 1, 223, 0, 'District Of Columbia', 'DOC', 'DC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(10, 1, 223, 0, 'Florida', 'FLO', 'FL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(11, 1, 223, 0, 'Georgia', 'GEA', 'GA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(12, 1, 223, 0, 'Hawaii', 'HWI', 'HI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(13, 1, 223, 0, 'Idaho', 'IDA', 'ID', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(14, 1, 223, 0, 'Illinois', 'ILL', 'IL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(15, 1, 223, 0, 'Indiana', 'IND', 'IN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(16, 1, 223, 0, 'Iowa', 'IOA', 'IA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(17, 1, 223, 0, 'Kansas', 'KAS', 'KS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(18, 1, 223, 0, 'Kentucky', 'KTY', 'KY', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(19, 1, 223, 0, 'Louisiana', 'LOA', 'LA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(20, 1, 223, 0, 'Maine', 'MAI', 'ME', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(21, 1, 223, 0, 'Maryland', 'MLD', 'MD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(22, 1, 223, 0, 'Massachusetts', 'MSA', 'MA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(23, 1, 223, 0, 'Michigan', 'MIC', 'MI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(24, 1, 223, 0, 'Minnesota', 'MIN', 'MN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(25, 1, 223, 0, 'Mississippi', 'MIS', 'MS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(26, 1, 223, 0, 'Missouri', 'MIO', 'MO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(27, 1, 223, 0, 'Montana', 'MOT', 'MT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(28, 1, 223, 0, 'Nebraska', 'NEB', 'NE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(29, 1, 223, 0, 'Nevada', 'NEV', 'NV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(30, 1, 223, 0, 'New Hampshire', 'NEH', 'NH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(31, 1, 223, 0, 'New Jersey', 'NEJ', 'NJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(32, 1, 223, 0, 'New Mexico', 'NEM', 'NM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(33, 1, 223, 0, 'New York', 'NEY', 'NY', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(34, 1, 223, 0, 'North Carolina', 'NOC', 'NC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(35, 1, 223, 0, 'North Dakota', 'NOD', 'ND', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(36, 1, 223, 0, 'Ohio', 'OHI', 'OH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(37, 1, 223, 0, 'Oklahoma', 'OKL', 'OK', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(38, 1, 223, 0, 'Oregon', 'ORN', 'OR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(39, 1, 223, 0, 'Pennsylvania', 'PEA', 'PA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(40, 1, 223, 0, 'Rhode Island', 'RHI', 'RI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(41, 1, 223, 0, 'South Carolina', 'SOC', 'SC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(42, 1, 223, 0, 'South Dakota', 'SOD', 'SD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(43, 1, 223, 0, 'Tennessee', 'TEN', 'TN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(44, 1, 223, 0, 'Texas', 'TXS', 'TX', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(45, 1, 223, 0, 'Utah', 'UTA', 'UT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(46, 1, 223, 0, 'Vermont', 'VMT', 'VT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(47, 1, 223, 0, 'Virginia', 'VIA', 'VA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(48, 1, 223, 0, 'Washington', 'WAS', 'WA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(49, 1, 223, 0, 'West Virginia', 'WEV', 'WV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(50, 1, 223, 0, 'Wisconsin', 'WIS', 'WI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(51, 1, 223, 0, 'Wyoming', 'WYO', 'WY', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(52, 1, 38, 0, 'Alberta', 'ALB', 'AB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(53, 1, 38, 0, 'British Columbia', 'BRC', 'BC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(54, 1, 38, 0, 'Manitoba', 'MAB', 'MB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(55, 1, 38, 0, 'New Brunswick', 'NEB', 'NB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(56, 1, 38, 0, 'Newfoundland and Labrador', 'NFL', 'NL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(57, 1, 38, 0, 'Northwest Territories', 'NWT', 'NT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(58, 1, 38, 0, 'Nova Scotia', 'NOS', 'NS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(59, 1, 38, 0, 'Nunavut', 'NUT', 'NU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(60, 1, 38, 0, 'Ontario', 'ONT', 'ON', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(61, 1, 38, 0, 'Prince Edward Island', 'PEI', 'PE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(62, 1, 38, 0, 'Quebec', 'QEC', 'QC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(63, 1, 38, 0, 'Saskatchewan', 'SAK', 'SK', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(64, 1, 38, 0, 'Yukon', 'YUT', 'YT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(65, 1, 222, 0, 'England', 'ENG', 'EN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(66, 1, 222, 0, 'Northern Ireland', 'NOI', 'NI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(67, 1, 222, 0, 'Scotland', 'SCO', 'SD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(68, 1, 222, 0, 'Wales', 'WLS', 'WS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(69, 1, 13, 0, 'Australian Capital Territory', 'ACT', 'AC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(70, 1, 13, 0, 'New South Wales', 'NSW', 'NS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(71, 1, 13, 0, 'Northern Territory', 'NOT', 'NT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(72, 1, 13, 0, 'Queensland', 'QLD', 'QL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(73, 1, 13, 0, 'South Australia', 'SOA', 'SA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(74, 1, 13, 0, 'Tasmania', 'TAS', 'TS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(75, 1, 13, 0, 'Victoria', 'VIC', 'VI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(76, 1, 13, 0, 'Western Australia', 'WEA', 'WA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(77, 1, 138, 0, 'Aguascalientes', 'AGS', 'AG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(78, 1, 138, 0, 'Baja California Norte', 'BCN', 'BN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(79, 1, 138, 0, 'Baja California Sur', 'BCS', 'BS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(80, 1, 138, 0, 'Campeche', 'CAM', 'CA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(81, 1, 138, 0, 'Chiapas', 'CHI', 'CS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(82, 1, 138, 0, 'Chihuahua', 'CHA', 'CH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(83, 1, 138, 0, 'Coahuila', 'COA', 'CO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(84, 1, 138, 0, 'Colima', 'COL', 'CM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(85, 1, 138, 0, 'Distrito Federal', 'DFM', 'DF', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(86, 1, 138, 0, 'Durango', 'DGO', 'DO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(87, 1, 138, 0, 'Guanajuato', 'GTO', 'GO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(88, 1, 138, 0, 'Guerrero', 'GRO', 'GU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(89, 1, 138, 0, 'Hidalgo', 'HGO', 'HI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(90, 1, 138, 0, 'Jalisco', 'JAL', 'JA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(91, 1, 138, 0, 'M', 'EDM', 'EM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(92, 1, 138, 0, 'Michoac', 'MCN', 'MI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(93, 1, 138, 0, 'Morelos', 'MOR', 'MO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(94, 1, 138, 0, 'Nayarit', 'NAY', 'NY', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(95, 1, 138, 0, 'Nuevo Le', 'NUL', 'NL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(96, 1, 138, 0, 'Oaxaca', 'OAX', 'OA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(97, 1, 138, 0, 'Puebla', 'PUE', 'PU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(98, 1, 138, 0, 'Quer', 'QRO', 'QU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(99, 1, 138, 0, 'Quintana Roo', 'QUR', 'QR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(100, 1, 138, 0, 'San Luis Potos', 'SLP', 'SP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(101, 1, 138, 0, 'Sinaloa', 'SIN', 'SI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(102, 1, 138, 0, 'Sonora', 'SON', 'SO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(103, 1, 138, 0, 'Tabasco', 'TAB', 'TA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(104, 1, 138, 0, 'Tamaulipas', 'TAM', 'TM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(105, 1, 138, 0, 'Tlaxcala', 'TLX', 'TX', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(106, 1, 138, 0, 'Veracruz', 'VER', 'VZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(107, 1, 138, 0, 'Yucat', 'YUC', 'YU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(108, 1, 138, 0, 'Zacatecas', 'ZAC', 'ZA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(109, 1, 30, 0, 'Acre', 'ACR', 'AC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(110, 1, 30, 0, 'Alagoas', 'ALG', 'AL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(111, 1, 30, 0, 'Amapá', 'AMP', 'AP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(112, 1, 30, 0, 'Amazonas', 'AMZ', 'AM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(113, 1, 30, 0, 'Bahía', 'BAH', 'BA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(114, 1, 30, 0, 'Ceará', 'CEA', 'CE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(115, 1, 30, 0, 'Distrito Federal', 'DFB', 'DF', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(116, 1, 30, 0, 'Espírito Santo', 'ESS', 'ES', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(117, 1, 30, 0, 'Goiás', 'GOI', 'GO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(118, 1, 30, 0, 'Maranhão', 'MAR', 'MA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(119, 1, 30, 0, 'Mato Grosso', 'MAT', 'MT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(120, 1, 30, 0, 'Mato Grosso do Sul', 'MGS', 'MS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(121, 1, 30, 0, 'Minas Gerais', 'MIG', 'MG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(122, 1, 30, 0, 'Paraná', 'PAR', 'PR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(123, 1, 30, 0, 'Paraíba', 'PRB', 'PB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(124, 1, 30, 0, 'Pará', 'PAB', 'PA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(125, 1, 30, 0, 'Pernambuco', 'PER', 'PE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(126, 1, 30, 0, 'Piauí', 'PIA', 'PI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(127, 1, 30, 0, 'Rio Grande do Norte', 'RGN', 'RN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(128, 1, 30, 0, 'Rio Grande do Sul', 'RGS', 'RS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(129, 1, 30, 0, 'Rio de Janeiro', 'RDJ', 'RJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(130, 1, 30, 0, 'Rondônia', 'RON', 'RO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(131, 1, 30, 0, 'Roraima', 'ROR', 'RR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(132, 1, 30, 0, 'Santa Catarina', 'SAC', 'SC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(133, 1, 30, 0, 'Sergipe', 'SER', 'SE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(134, 1, 30, 0, 'São Paulo', 'SAP', 'SP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(135, 1, 30, 0, 'Tocantins', 'TOC', 'TO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(136, 1, 44, 0, 'Anhui', 'ANH', '34', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(137, 1, 44, 0, 'Beijing', 'BEI', '11', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(138, 1, 44, 0, 'Chongqing', 'CHO', '50', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(139, 1, 44, 0, 'Fujian', 'FUJ', '35', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(140, 1, 44, 0, 'Gansu', 'GAN', '62', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(141, 1, 44, 0, 'Guangdong', 'GUA', '44', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(142, 1, 44, 0, 'Guangxi Zhuang', 'GUZ', '45', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(143, 1, 44, 0, 'Guizhou', 'GUI', '52', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(144, 1, 44, 0, 'Hainan', 'HAI', '46', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(145, 1, 44, 0, 'Hebei', 'HEB', '13', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(146, 1, 44, 0, 'Heilongjiang', 'HEI', '23', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(147, 1, 44, 0, 'Henan', 'HEN', '41', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(148, 1, 44, 0, 'Hubei', 'HUB', '42', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(149, 1, 44, 0, 'Hunan', 'HUN', '43', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(150, 1, 44, 0, 'Jiangsu', 'JIA', '32', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(151, 1, 44, 0, 'Jiangxi', 'JIX', '36', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(152, 1, 44, 0, 'Jilin', 'JIL', '22', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(153, 1, 44, 0, 'Liaoning', 'LIA', '21', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(154, 1, 44, 0, 'Nei Mongol', 'NML', '15', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(155, 1, 44, 0, 'Ningxia Hui', 'NIH', '64', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(156, 1, 44, 0, 'Qinghai', 'QIN', '63', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(157, 1, 44, 0, 'Shandong', 'SNG', '37', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(158, 1, 44, 0, 'Shanghai', 'SHH', '31', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(159, 1, 44, 0, 'Shaanxi', 'SHX', '61', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(160, 1, 44, 0, 'Sichuan', 'SIC', '51', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(161, 1, 44, 0, 'Tianjin', 'TIA', '12', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(162, 1, 44, 0, 'Xinjiang Uygur', 'XIU', '65', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(163, 1, 44, 0, 'Xizang', 'XIZ', '54', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(164, 1, 44, 0, 'Yunnan', 'YUN', '53', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(165, 1, 44, 0, 'Zhejiang', 'ZHE', '33', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(166, 1, 104, 0, 'Israel', 'ISL', 'IL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(167, 1, 104, 0, 'Gaza Strip', 'GZS', 'GZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(168, 1, 104, 0, 'West Bank', 'WBK', 'WB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(169, 1, 151, 0, 'St. Maarten', 'STM', 'SM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(170, 1, 151, 0, 'Bonaire', 'BNR', 'BN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(171, 1, 151, 0, 'Curacao', 'CUR', 'CR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(172, 1, 175, 0, 'Alba', 'ABA', 'AB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(173, 1, 175, 0, 'Arad', 'ARD', 'AR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(174, 1, 175, 0, 'Arges', 'ARG', 'AG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(175, 1, 175, 0, 'Bacau', 'BAC', 'BC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(176, 1, 175, 0, 'Bihor', 'BIH', 'BH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(177, 1, 175, 0, 'Bistrita-Nasaud', 'BIS', 'BN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(178, 1, 175, 0, 'Botosani', 'BOT', 'BT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(179, 1, 175, 0, 'Braila', 'BRL', 'BR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(180, 1, 175, 0, 'Brasov', 'BRA', 'BV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(181, 1, 175, 0, 'Bucuresti', 'BUC', 'B', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(182, 1, 175, 0, 'Buzau', 'BUZ', 'BZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(183, 1, 175, 0, 'Calarasi', 'CAL', 'CL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(184, 1, 175, 0, 'Caras Severin', 'CRS', 'CS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(185, 1, 175, 0, 'Cluj', 'CLJ', 'CJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(186, 1, 175, 0, 'Constanta', 'CST', 'CT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(187, 1, 175, 0, 'Covasna', 'COV', 'CV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(188, 1, 175, 0, 'Dambovita', 'DAM', 'DB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(189, 1, 175, 0, 'Dolj', 'DLJ', 'DJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(190, 1, 175, 0, 'Galati', 'GAL', 'GL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(191, 1, 175, 0, 'Giurgiu', 'GIU', 'GR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(192, 1, 175, 0, 'Gorj', 'GOR', 'GJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(193, 1, 175, 0, 'Hargita', 'HRG', 'HR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(194, 1, 175, 0, 'Hunedoara', 'HUN', 'HD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(195, 1, 175, 0, 'Ialomita', 'IAL', 'IL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(196, 1, 175, 0, 'Iasi', 'IAS', 'IS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(197, 1, 175, 0, 'Ilfov', 'ILF', 'IF', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(198, 1, 175, 0, 'Maramures', 'MAR', 'MM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(199, 1, 175, 0, 'Mehedinti', 'MEH', 'MH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(200, 1, 175, 0, 'Mures', 'MUR', 'MS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(201, 1, 175, 0, 'Neamt', 'NEM', 'NT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(202, 1, 175, 0, 'Olt', 'OLT', 'OT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(203, 1, 175, 0, 'Prahova', 'PRA', 'PH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(204, 1, 175, 0, 'Salaj', 'SAL', 'SJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(205, 1, 175, 0, 'Satu Mare', 'SAT', 'SM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(206, 1, 175, 0, 'Sibiu', 'SIB', 'SB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(207, 1, 175, 0, 'Suceava', 'SUC', 'SV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(208, 1, 175, 0, 'Teleorman', 'TEL', 'TR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(209, 1, 175, 0, 'Timis', 'TIM', 'TM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(210, 1, 175, 0, 'Tulcea', 'TUL', 'TL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(211, 1, 175, 0, 'Valcea', 'VAL', 'VL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(212, 1, 175, 0, 'Vaslui', 'VAS', 'VS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(213, 1, 175, 0, 'Vrancea', 'VRA', 'VN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(214, 1, 105, 0, 'Agrigento', 'AGR', 'AG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(215, 1, 105, 0, 'Alessandria', 'ALE', 'AL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(216, 1, 105, 0, 'Ancona', 'ANC', 'AN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(217, 1, 105, 0, 'Aosta', 'AOS', 'AO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(218, 1, 105, 0, 'Arezzo', 'ARE', 'AR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(219, 1, 105, 0, 'Ascoli Piceno', 'API', 'AP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(220, 1, 105, 0, 'Asti', 'AST', 'AT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(221, 1, 105, 0, 'Avellino', 'AVE', 'AV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(222, 1, 105, 0, 'Bari', 'BAR', 'BA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(223, 1, 105, 0, 'Belluno', 'BEL', 'BL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(224, 1, 105, 0, 'Benevento', 'BEN', 'BN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(225, 1, 105, 0, 'Bergamo', 'BEG', 'BG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(226, 1, 105, 0, 'Biella', 'BIE', 'BI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(227, 1, 105, 0, 'Bologna', 'BOL', 'BO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(228, 1, 105, 0, 'Bolzano', 'BOZ', 'BZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(229, 1, 105, 0, 'Brescia', 'BRE', 'BS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(230, 1, 105, 0, 'Brindisi', 'BRI', 'BR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(231, 1, 105, 0, 'Cagliari', 'CAG', 'CA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(232, 1, 105, 0, 'Caltanissetta', 'CAL', 'CL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(233, 1, 105, 0, 'Campobasso', 'CBO', 'CB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(234, 1, 105, 0, 'Carbonia-Iglesias', 'CAR', 'CI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(235, 1, 105, 0, 'Caserta', 'CAS', 'CE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(236, 1, 105, 0, 'Catania', 'CAT', 'CT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(237, 1, 105, 0, 'Catanzaro', 'CTZ', 'CZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(238, 1, 105, 0, 'Chieti', 'CHI', 'CH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(239, 1, 105, 0, 'Como', 'COM', 'CO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(240, 1, 105, 0, 'Cosenza', 'COS', 'CS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(241, 1, 105, 0, 'Cremona', 'CRE', 'CR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(242, 1, 105, 0, 'Crotone', 'CRO', 'KR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(243, 1, 105, 0, 'Cuneo', 'CUN', 'CN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(244, 1, 105, 0, 'Enna', 'ENN', 'EN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(245, 1, 105, 0, 'Ferrara', 'FER', 'FE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(246, 1, 105, 0, 'Firenze', 'FIR', 'FI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(247, 1, 105, 0, 'Foggia', 'FOG', 'FG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(248, 1, 105, 0, 'Forli-Cesena', 'FOC', 'FC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(249, 1, 105, 0, 'Frosinone', 'FRO', 'FR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(250, 1, 105, 0, 'Genova', 'GEN', 'GE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(251, 1, 105, 0, 'Gorizia', 'GOR', 'GO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(252, 1, 105, 0, 'Grosseto', 'GRO', 'GR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(253, 1, 105, 0, 'Imperia', 'IMP', 'IM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(254, 1, 105, 0, 'Isernia', 'ISE', 'IS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(255, 1, 105, 0, 'L''Aquila', 'AQU', 'AQ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(256, 1, 105, 0, 'La Spezia', 'LAS', 'SP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(257, 1, 105, 0, 'Latina', 'LAT', 'LT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(258, 1, 105, 0, 'Lecce', 'LEC', 'LE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(259, 1, 105, 0, 'Lecco', 'LCC', 'LC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(260, 1, 105, 0, 'Livorno', 'LIV', 'LI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(261, 1, 105, 0, 'Lodi', 'LOD', 'LO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(262, 1, 105, 0, 'Lucca', 'LUC', 'LU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(263, 1, 105, 0, 'Macerata', 'MAC', 'MC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(264, 1, 105, 0, 'Mantova', 'MAN', 'MN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(265, 1, 105, 0, 'Massa-Carrara', 'MAS', 'MS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(266, 1, 105, 0, 'Matera', 'MAA', 'MT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(267, 1, 105, 0, 'Medio Campidano', 'MED', 'VS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(268, 1, 105, 0, 'Messina', 'MES', 'ME', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(269, 1, 105, 0, 'Milano', 'MIL', 'MI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(270, 1, 105, 0, 'Modena', 'MOD', 'MO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(271, 1, 105, 0, 'Napoli', 'NAP', 'NA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(272, 1, 105, 0, 'Novara', 'NOV', 'NO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(273, 1, 105, 0, 'Nuoro', 'NUR', 'NU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(274, 1, 105, 0, 'Ogliastra', 'OGL', 'OG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(275, 1, 105, 0, 'Olbia-Tempio', 'OLB', 'OT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(276, 1, 105, 0, 'Oristano', 'ORI', 'OR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(277, 1, 105, 0, 'Padova', 'PDA', 'PD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(278, 1, 105, 0, 'Palermo', 'PAL', 'PA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(279, 1, 105, 0, 'Parma', 'PAA', 'PR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(280, 1, 105, 0, 'Pavia', 'PAV', 'PV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(281, 1, 105, 0, 'Perugia', 'PER', 'PG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(282, 1, 105, 0, 'Pesaro e Urbino', 'PES', 'PU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(283, 1, 105, 0, 'Pescara', 'PSC', 'PE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(284, 1, 105, 0, 'Piacenza', 'PIA', 'PC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(285, 1, 105, 0, 'Pisa', 'PIS', 'PI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(286, 1, 105, 0, 'Pistoia', 'PIT', 'PT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(287, 1, 105, 0, 'Pordenone', 'POR', 'PN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(288, 1, 105, 0, 'Potenza', 'PTZ', 'PZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(289, 1, 105, 0, 'Prato', 'PRA', 'PO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(290, 1, 105, 0, 'Ragusa', 'RAG', 'RG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(291, 1, 105, 0, 'Ravenna', 'RAV', 'RA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(292, 1, 105, 0, 'Reggio Calabria', 'REG', 'RC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(293, 1, 105, 0, 'Reggio Emilia', 'REE', 'RE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(294, 1, 105, 0, 'Rieti', 'RIE', 'RI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(295, 1, 105, 0, 'Rimini', 'RIM', 'RN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(296, 1, 105, 0, 'Roma', 'ROM', 'RM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(297, 1, 105, 0, 'Rovigo', 'ROV', 'RO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(298, 1, 105, 0, 'Salerno', 'SAL', 'SA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(299, 1, 105, 0, 'Sassari', 'SAS', 'SS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(300, 1, 105, 0, 'Savona', 'SAV', 'SV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(301, 1, 105, 0, 'Siena', 'SIE', 'SI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(302, 1, 105, 0, 'Siracusa', 'SIR', 'SR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(303, 1, 105, 0, 'Sondrio', 'SOO', 'SO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(304, 1, 105, 0, 'Taranto', 'TAR', 'TA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(305, 1, 105, 0, 'Teramo', 'TER', 'TE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(306, 1, 105, 0, 'Terni', 'TRN', 'TR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(307, 1, 105, 0, 'Torino', 'TOR', 'TO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(308, 1, 105, 0, 'Trapani', 'TRA', 'TP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(309, 1, 105, 0, 'Trento', 'TRE', 'TN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(310, 1, 105, 0, 'Treviso', 'TRV', 'TV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(311, 1, 105, 0, 'Trieste', 'TRI', 'TS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(312, 1, 105, 0, 'Udine', 'UDI', 'UD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(313, 1, 105, 0, 'Varese', 'VAR', 'VA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(314, 1, 105, 0, 'Venezia', 'VEN', 'VE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(315, 1, 105, 0, 'Verbano Cusio Ossola', 'VCO', 'VB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(316, 1, 105, 0, 'Vercelli', 'VER', 'VC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(317, 1, 105, 0, 'Verona', 'VRN', 'VR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(318, 1, 105, 0, 'Vibo Valenzia', 'VIV', 'VV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(319, 1, 105, 0, 'Vicenza', 'VII', 'VI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(320, 1, 105, 0, 'Viterbo', 'VIT', 'VT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(321, 1, 195, 0, 'A Coru', 'ACO', '15', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(322, 1, 195, 0, 'Alava', 'ALA', '01', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(323, 1, 195, 0, 'Albacete', 'ALB', '02', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(324, 1, 195, 0, 'Alicante', 'ALI', '03', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(325, 1, 195, 0, 'Almeria', 'ALM', '04', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(326, 1, 195, 0, 'Asturias', 'AST', '33', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(327, 1, 195, 0, 'Avila', 'AVI', '05', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(328, 1, 195, 0, 'Badajoz', 'BAD', '06', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(329, 1, 195, 0, 'Baleares', 'BAL', '07', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(330, 1, 195, 0, 'Barcelona', 'BAR', '08', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(331, 1, 195, 0, 'Burgos', 'BUR', '09', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(332, 1, 195, 0, 'Caceres', 'CAC', '10', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(333, 1, 195, 0, 'Cadiz', 'CAD', '11', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(334, 1, 195, 0, 'Cantabria', 'CAN', '39', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(335, 1, 195, 0, 'Castellon', 'CAS', '12', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(336, 1, 195, 0, 'Ceuta', 'CEU', '51', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(337, 1, 195, 0, 'Ciudad Real', 'CIU', '13', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(338, 1, 195, 0, 'Cordoba', 'COR', '14', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(339, 1, 195, 0, 'Cuenca', 'CUE', '16', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(340, 1, 195, 0, 'Girona', 'GIR', '17', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(341, 1, 195, 0, 'Granada', 'GRA', '18', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(342, 1, 195, 0, 'Guadalajara', 'GUA', '19', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(343, 1, 195, 0, 'Guipuzcoa', 'GUI', '20', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(344, 1, 195, 0, 'Huelva', 'HUL', '21', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(345, 1, 195, 0, 'Huesca', 'HUS', '22', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(346, 1, 195, 0, 'Jaen', 'JAE', '23', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(347, 1, 195, 0, 'La Rioja', 'LRI', '26', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(348, 1, 195, 0, 'Las Palmas', 'LPA', '35', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(349, 1, 195, 0, 'Leon', 'LEO', '24', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(350, 1, 195, 0, 'Lleida', 'LLE', '25', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(351, 1, 195, 0, 'Lugo', 'LUG', '27', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(352, 1, 195, 0, 'Madrid', 'MAD', '28', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(353, 1, 195, 0, 'Malaga', 'MAL', '29', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(354, 1, 195, 0, 'Melilla', 'MEL', '52', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(355, 1, 195, 0, 'Murcia', 'MUR', '30', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(356, 1, 195, 0, 'Navarra', 'NAV', '31', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(357, 1, 195, 0, 'Ourense', 'OUR', '32', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(358, 1, 195, 0, 'Palencia', 'PAL', '34', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(359, 1, 195, 0, 'Pontevedra', 'PON', '36', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(360, 1, 195, 0, 'Salamanca', 'SAL', '37', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(361, 1, 195, 0, 'Santa Cruz de Tenerife', 'SCT', '38', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(362, 1, 195, 0, 'Segovia', 'SEG', '40', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(363, 1, 195, 0, 'Sevilla', 'SEV', '41', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(364, 1, 195, 0, 'Soria', 'SOR', '42', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(365, 1, 195, 0, 'Tarragona', 'TAR', '43', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(366, 1, 195, 0, 'Teruel', 'TER', '44', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(367, 1, 195, 0, 'Toledo', 'TOL', '45', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(368, 1, 195, 0, 'Valencia', 'VAL', '46', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(369, 1, 195, 0, 'Valladolid', 'VLL', '47', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(370, 1, 195, 0, 'Vizcaya', 'VIZ', '48', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(371, 1, 195, 0, 'Zamora', 'ZAM', '49', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(372, 1, 195, 0, 'Zaragoza', 'ZAR', '50', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(373, 1, 10, 0, 'Buenos Aires', 'BAS', 'BA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(374, 1, 10, 0, 'Ciudad Autonoma De Buenos Aires', 'CBA', 'CB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(375, 1, 10, 0, 'Catamarca', 'CAT', 'CA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(376, 1, 10, 0, 'Chaco', 'CHO', 'CH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(377, 1, 10, 0, 'Chubut', 'CTT', 'CT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(378, 1, 10, 0, 'Cordoba', 'COD', 'CO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(379, 1, 10, 0, 'Corrientes', 'CRI', 'CR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(380, 1, 10, 0, 'Entre Rios', 'ERS', 'ER', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(381, 1, 10, 0, 'Formosa', 'FRM', 'FR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(382, 1, 10, 0, 'Jujuy', 'JUJ', 'JU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(383, 1, 10, 0, 'La Pampa', 'LPM', 'LP', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(384, 1, 10, 0, 'La Rioja', 'LRI', 'LR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(385, 1, 10, 0, 'Mendoza', 'MED', 'ME', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(386, 1, 10, 0, 'Misiones', 'MIS', 'MI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(387, 1, 10, 0, 'Neuquen', 'NQU', 'NQ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(388, 1, 10, 0, 'Rio Negro', 'RNG', 'RN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(389, 1, 10, 0, 'Salta', 'SAL', 'SA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(390, 1, 10, 0, 'San Juan', 'SJN', 'SJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(391, 1, 10, 0, 'San Luis', 'SLU', 'SL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(392, 1, 10, 0, 'Santa Cruz', 'SCZ', 'SC', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(393, 1, 10, 0, 'Santa Fe', 'SFE', 'SF', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(394, 1, 10, 0, 'Santiago Del Estero', 'SEN', 'SE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(395, 1, 10, 0, 'Tierra Del Fuego', 'TFE', 'TF', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(396, 1, 10, 0, 'Tucuman', 'TUC', 'TU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(397, 1, 11, 0, 'Aragatsotn', 'ARG', 'AG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(398, 1, 11, 0, 'Ararat', 'ARR', 'AR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(399, 1, 11, 0, 'Armavir', 'ARM', 'AV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(400, 1, 11, 0, 'Gegharkunik', 'GEG', 'GR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(401, 1, 11, 0, 'Kotayk', 'KOT', 'KT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(402, 1, 11, 0, 'Lori', 'LOR', 'LO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(403, 1, 11, 0, 'Shirak', 'SHI', 'SH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(404, 1, 11, 0, 'Syunik', 'SYU', 'SU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(405, 1, 11, 0, 'Tavush', 'TAV', 'TV', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(406, 1, 11, 0, 'Vayots-Dzor', 'VAD', 'VD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(407, 1, 11, 0, 'Yerevan', 'YER', 'ER', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(408, 1, 99, 0, 'Andaman & Nicobar Islands', 'ANI', 'AI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(409, 1, 99, 0, 'Andhra Pradesh', 'AND', 'AN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(410, 1, 99, 0, 'Arunachal Pradesh', 'ARU', 'AR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(411, 1, 99, 0, 'Assam', 'ASS', 'AS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(412, 1, 99, 0, 'Bihar', 'BIH', 'BI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(413, 1, 99, 0, 'Chandigarh', 'CHA', 'CA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(414, 1, 99, 0, 'Chhatisgarh', 'CHH', 'CH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(415, 1, 99, 0, 'Dadra & Nagar Haveli', 'DAD', 'DD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(416, 1, 99, 0, 'Daman & Diu', 'DAM', 'DA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(417, 1, 99, 0, 'Delhi', 'DEL', 'DE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(418, 1, 99, 0, 'Goa', 'GOA', 'GO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(419, 1, 99, 0, 'Gujarat', 'GUJ', 'GU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(420, 1, 99, 0, 'Haryana', 'HAR', 'HA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(421, 1, 99, 0, 'Himachal Pradesh', 'HIM', 'HI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(422, 1, 99, 0, 'Jammu & Kashmir', 'JAM', 'JA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(423, 1, 99, 0, 'Jharkhand', 'JHA', 'JH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(424, 1, 99, 0, 'Karnataka', 'KAR', 'KA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(425, 1, 99, 0, 'Kerala', 'KER', 'KE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(426, 1, 99, 0, 'Lakshadweep', 'LAK', 'LA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(427, 1, 99, 0, 'Madhya Pradesh', 'MAD', 'MD', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(428, 1, 99, 0, 'Maharashtra', 'MAH', 'MH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(429, 1, 99, 0, 'Manipur', 'MAN', 'MN', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(430, 1, 99, 0, 'Meghalaya', 'MEG', 'ME', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(431, 1, 99, 0, 'Mizoram', 'MIZ', 'MI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(432, 1, 99, 0, 'Nagaland', 'NAG', 'NA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(433, 1, 99, 0, 'Orissa', 'ORI', 'OR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(434, 1, 99, 0, 'Pondicherry', 'PON', 'PO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(435, 1, 99, 0, 'Punjab', 'PUN', 'PU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(436, 1, 99, 0, 'Rajasthan', 'RAJ', 'RA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(437, 1, 99, 0, 'Sikkim', 'SIK', 'SI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(438, 1, 99, 0, 'Tamil Nadu', 'TAM', 'TA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(439, 1, 99, 0, 'Tripura', 'TRI', 'TR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(440, 1, 99, 0, 'Uttaranchal', 'UAR', 'UA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(441, 1, 99, 0, 'Uttar Pradesh', 'UTT', 'UT', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(442, 1, 99, 0, 'West Bengal', 'WES', 'WE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(443, 1, 101, 0, 'Ahmadi va Kohkiluyeh', 'BOK', 'BO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(444, 1, 101, 0, 'Ardabil', 'ARD', 'AR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(445, 1, 101, 0, 'Azarbayjan-e Gharbi', 'AZG', 'AG', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(446, 1, 101, 0, 'Azarbayjan-e Sharqi', 'AZS', 'AS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(447, 1, 101, 0, 'Bushehr', 'BUS', 'BU', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(448, 1, 101, 0, 'Chaharmahal va Bakhtiari', 'CMB', 'CM', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(449, 1, 101, 0, 'Esfahan', 'ESF', 'ES', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(450, 1, 101, 0, 'Fars', 'FAR', 'FA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(451, 1, 101, 0, 'Gilan', 'GIL', 'GI', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(452, 1, 101, 0, 'Gorgan', 'GOR', 'GO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(453, 1, 101, 0, 'Hamadan', 'HAM', 'HA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(454, 1, 101, 0, 'Hormozgan', 'HOR', 'HO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(455, 1, 101, 0, 'Ilam', 'ILA', 'IL', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(456, 1, 101, 0, 'Kerman', 'KER', 'KE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(457, 1, 101, 0, 'Kermanshah', 'BAK', 'BA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(458, 1, 101, 0, 'Khorasan-e Junoubi', 'KHJ', 'KJ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(459, 1, 101, 0, 'Khorasan-e Razavi', 'KHR', 'KR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(460, 1, 101, 0, 'Khorasan-e Shomali', 'KHS', 'KS', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(461, 1, 101, 0, 'Khuzestan', 'KHU', 'KH', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(462, 1, 101, 0, 'Kordestan', 'KOR', 'KO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(463, 1, 101, 0, 'Lorestan', 'LOR', 'LO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(464, 1, 101, 0, 'Markazi', 'MAR', 'MR', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(465, 1, 101, 0, 'Mazandaran', 'MAZ', 'MZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(466, 1, 101, 0, 'Qazvin', 'QAS', 'QA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(467, 1, 101, 0, 'Qom', 'QOM', 'QO', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(468, 1, 101, 0, 'Semnan', 'SEM', 'SE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(469, 1, 101, 0, 'Sistan va Baluchestan', 'SBA', 'SB', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(470, 1, 101, 0, 'Tehran', 'TEH', 'TE', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(471, 1, 101, 0, 'Yazd', 'YAZ', 'YA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(472, 1, 101, 0, 'Zanjan', 'ZAN', 'ZA', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(535, 1, 84, 0, 'ΛΕΥΚΑΔΑΣ', 'ΛΕΥ', 'ΛΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(532, 1, 84, 0, 'ΛΑΡΙΣΑΣ', 'ΛΑΡ', 'ΛΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(504, 1, 84, 0, 'ΑΡΚΑΔΙΑΣ', 'ΑΡΚ', 'ΑΚ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(503, 1, 84, 0, 'ΑΡΓΟΛΙΔΑΣ', 'ΑΡΓ', 'ΑΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(533, 1, 84, 0, 'ΛΑΣΙΘΙΟΥ', 'ΛΑΣ', 'ΛΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(534, 1, 84, 0, 'ΛΕΣΒΟΥ', 'ΛΕΣ', 'ΛΣ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(530, 1, 84, 0, 'ΚΥΚΛΑΔΩΝ', 'ΚΥΚ', 'ΚΥ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(553, 1, 84, 0, 'ΑΙΤΩΛΟΑΚΑΡΝΑΝΙΑΣ', 'ΑΙΤ', 'ΑΙ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(529, 1, 84, 0, 'ΚΟΡΙΝΘΙΑΣ', 'ΚΟΡ', 'ΚΟ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(531, 1, 84, 0, 'ΛΑΚΩΝΙΑΣ', 'ΛΑΚ', 'ΛK', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(517, 1, 84, 0, 'ΗΜΑΘΙΑΣ', 'ΗΜΑ', 'ΗΜ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(518, 1, 84, 0, 'ΗΡΑΚΛΕΙΟΥ', 'ΗΡΑ', 'ΗΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(519, 1, 84, 0, 'ΘΕΣΠΡΩΤΙΑΣ', 'ΘΕΠ', 'ΘΠ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(520, 1, 84, 0, 'ΘΕΣΣΑΛΟΝΙΚΗΣ', 'ΘΕΣ', 'ΘΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(521, 1, 84, 0, 'ΙΩΑΝΝΙΝΩΝ', 'ΙΩΑ', 'ΙΩ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(522, 1, 84, 0, 'ΚΑΒΑΛΑΣ', 'ΚΑΒ', 'ΚΒ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(523, 1, 84, 0, 'ΚΑΡΔΙΤΣΑΣ', 'ΚΑΡ', 'ΚΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(524, 1, 84, 0, 'ΚΑΣΤΟΡΙΑΣ', 'ΚΑΣ', 'ΚΣ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(525, 1, 84, 0, 'ΚΕΡΚΥΡΑΣ', 'ΚΕΡ', 'ΚΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(526, 1, 84, 0, 'ΚΕΦΑΛΛΗΝΙΑΣ', 'ΚΕΦ', 'ΚΦ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(527, 1, 84, 0, 'ΚΙΛΚΙΣ', 'ΚΙΛ', 'ΚΙ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(528, 1, 84, 0, 'ΚΟΖΑΝΗΣ', 'ΚΟΖ', 'ΚZ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(507, 1, 84, 0, 'ΑΧΑΪΑΣ', 'ΑΧΑ', 'ΑΧ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(508, 1, 84, 0, 'ΒΟΙΩΤΙΑΣ', 'ΒΟΙ', 'ΒΟ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(509, 1, 84, 0, 'ΓΡΕΒΕΝΩΝ', 'ΓΡΕ', 'ΓΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(510, 1, 84, 0, 'ΔΡΑΜΑΣ', 'ΔΡΑ', 'ΔΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(511, 1, 84, 0, 'ΔΩΔΕΚΑΝΗΣΟΥ', 'ΔΩΔ', 'ΔΩ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(512, 1, 84, 0, 'ΕΒΡΟΥ', 'ΕΒΡ', 'ΕΒ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(513, 1, 84, 0, 'ΕΥΒΟΙΑΣ', 'ΕΥΒ', 'ΕΥ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(514, 1, 84, 0, 'ΕΥΡΥΤΑΝΙΑΣ', 'ΕΥΡ', 'ΕΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(515, 1, 84, 0, 'ΖΑΚΥΝΘΟΥ', 'ΖΑΚ', 'ΖΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(516, 1, 84, 0, 'ΗΛΕΙΑΣ', 'ΗΛΕ', 'ΗΛ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(505, 1, 84, 0, 'ΑΡΤΑΣ', 'ΑΡΤ', 'ΑΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(506, 1, 84, 0, 'ΑΤΤΙΚΗΣ', 'ΑΤΤ', 'ΑΤ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(536, 1, 84, 0, 'ΜΑΓΝΗΣΙΑΣ', 'ΜΑΓ', 'ΜΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(537, 1, 84, 0, 'ΜΕΣΣΗΝΙΑΣ', 'ΜΕΣ', 'ΜΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(538, 1, 84, 0, 'ΞΑΝΘΗΣ', 'ΞΑΝ', 'ΞΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(539, 1, 84, 0, 'ΠΕΛΛΗΣ', 'ΠΕΛ', 'ΠΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(540, 1, 84, 0, 'ΠΙΕΡΙΑΣ', 'ΠΙΕ', 'ΠΙ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(541, 1, 84, 0, 'ΠΡΕΒΕΖΑΣ', 'ΠΡΕ', 'ΠΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(542, 1, 84, 0, 'ΡΕΘΥΜΝΗΣ', 'ΡΕΘ', 'ΡΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(543, 1, 84, 0, 'ΡΟΔΟΠΗΣ', 'ΡΟΔ', 'ΡΟ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(544, 1, 84, 0, 'ΣΑΜΟΥ', 'ΣΑΜ', 'ΣΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(545, 1, 84, 0, 'ΣΕΡΡΩΝ', 'ΣΕΡ', 'ΣΕ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(546, 1, 84, 0, 'ΤΡΙΚΑΛΩΝ', 'ΤΡΙ', 'ΤΡ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(547, 1, 84, 0, 'ΦΘΙΩΤΙΔΑΣ', 'ΦΘΙ', 'ΦΘ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(548, 1, 84, 0, 'ΦΛΩΡΙΝΑΣ', 'ΦΛΩ', 'ΦΛ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(549, 1, 84, 0, 'ΦΩΚΙΔΑΣ', 'ΦΩΚ', 'ΦΩ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(550, 1, 84, 0, 'ΧΑΛΚΙΔΙΚΗΣ', 'ΧΑΛ', 'ΧΑ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(551, 1, 84, 0, 'ΧΑΝΙΩΝ', 'ΧΑΝ', 'ΧΝ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(552, 1, 84, 0, 'ΧΙΟΥ', 'ΧΙΟ', 'ΧΙ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(569, 1, 81, 0, 'Schleswig-Holstein', 'SHO', 'SH', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(554, 1, 81, 0, 'Freie und Hansestadt Hamburg', 'HAM', 'HH', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(555, 1, 81, 0, 'Niedersachsen', 'NIS', 'NI', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(556, 1, 81, 0, 'Freie Hansestadt Bremen', 'HBR', 'HB', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(557, 1, 81, 0, 'Nordrhein-Westfalen', 'NRW', 'NW', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(558, 1, 81, 0, 'Hessen', 'HES', 'HE', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(559, 1, 81, 0, 'Rheinland-Pfalz', 'RLP', 'RP', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(560, 1, 81, 0, 'Baden-Württemberg', 'BWÜ', 'BW', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(561, 1, 81, 0, 'Freistaat Bayern', 'BAV', 'BY', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(562, 1, 81, 0, 'Saarland', 'SLA', 'SL', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(563, 1, 81, 0, 'Berlin', 'BER', 'BE', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(564, 1, 81, 0, 'Brandenburg', 'BRB', 'BB', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(565, 1, 81, 0, 'Mecklenburg-Vorpommern', 'MVO', 'MV', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(566, 1, 81, 0, 'Freistaat Sachsen', 'SAC', 'SN', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(567, 1, 81, 0, 'Sachsen-Anhalt', 'SAA', 'ST', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(568, 1, 81, 0, 'Freistaat Thüringen', 'THÜ', 'TH', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(570, 1, 176, 0, 'Адыгея Республика', 'AD', '01', 1, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(571, 1, 176, 0, 'Алтай Республика', 'AL', '04', 2, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(572, 1, 176, 0, 'Алтайский край', 'ALT', '22', 3, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(573, 1, 176, 0, 'Амурская область', 'AMU', '28', 4, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(574, 1, 176, 0, 'Архангельская область', 'ARK', '29', 5, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(575, 1, 176, 0, 'Астраханская область', 'AST', '30', 6, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(576, 1, 176, 0, 'Башкортостан Республика', 'BA', '02', 7, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(577, 1, 176, 0, 'Белгородская область', 'BEL', '31', 8, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(578, 1, 176, 0, 'Брянская область', 'BRY', '32', 9, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(579, 1, 176, 0, 'Бурятия Республика', 'BU', '03', 10, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(580, 1, 176, 0, 'Владимирская область', 'VLA', '33', 11, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(581, 1, 176, 0, 'Волгоградская область', 'VGG', '34', 12, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(582, 1, 176, 0, 'Вологодская область', 'VLG', '35', 13, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(583, 1, 176, 0, 'Воронежская область', 'VOR', '36', 14, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(584, 1, 176, 0, 'Дагестан Республика', 'DA', '05', 15, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(585, 1, 176, 0, 'Еврейская автономная область', 'YEV', '79', 16, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(586, 1, 176, 0, 'Забайкальский край', 'ZAB', '75', 17, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(587, 1, 176, 0, 'Ивановская область', 'IVA', '37', 18, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(588, 1, 176, 0, 'Ингушетия Республика', 'IN', '06', 19, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(589, 1, 176, 0, 'Иркутская область', 'IRK', '38', 20, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(590, 1, 176, 0, 'Кабардино-Балкарская Республика', 'KB', '07', 21, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(591, 1, 176, 0, 'Калининградская область', 'KGD', '39', 22, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(592, 1, 176, 0, 'Калмыкия Республика', 'KL', '08', 23, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(593, 1, 176, 0, 'Калужская область', 'KLU', '40', 24, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(594, 1, 176, 0, 'Камчатский край', 'KAM', '41', 25, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(595, 1, 176, 0, 'Карачаево-Черкесская Республика', 'KC', '09', 26, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(596, 1, 176, 0, 'Карелия Республика', 'KR', '10', 27, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(597, 1, 176, 0, 'Кемеровская область', 'KEM', '42', 28, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(598, 1, 176, 0, 'Кировская область', 'KIR', '43', 29, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(599, 1, 176, 0, 'Коми Республика', 'KO', '11', 30, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(600, 1, 176, 0, 'Костромская область', 'KOS', '44', 31, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(601, 1, 176, 0, 'Краснодарский край', 'KDA', '23', 32, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(602, 1, 176, 0, 'Красноярский край', 'KIA', '24', 33, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(603, 1, 176, 0, 'Курганская область', 'KGN', '45', 34, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(604, 1, 176, 0, 'Курская область', 'KRS', '46', 35, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(605, 1, 176, 0, 'Ленинградская область', 'LEN', '47', 36, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(606, 1, 176, 0, 'Липецкая область', 'LIP', '48', 37, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(607, 1, 176, 0, 'Магаданская область', 'MAG', '49', 38, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(608, 1, 176, 0, 'Марий Эл Республика', 'ME', '12', 39, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(609, 1, 176, 0, 'Мордовия Республика', 'MO', '13', 40, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(610, 1, 176, 0, 'Москва', 'MOW', '77', 41, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(611, 1, 176, 0, 'Московская область', 'MOS', '50', 42, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(612, 1, 176, 0, 'Мурманская область', 'MUR', '51', 43, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(613, 1, 176, 0, 'Ненецкий автономный округ', 'NEN', '83', 44, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(614, 1, 176, 0, 'Нижегородская область', 'NIZ', '52', 45, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(615, 1, 176, 0, 'Новгородская область', 'NGR', '53', 46, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(616, 1, 176, 0, 'Новосибирская область', 'NVS', '54', 47, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(617, 1, 176, 0, 'Омская область', 'OMS', '55', 48, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(618, 1, 176, 0, 'Оренбургская область', 'ORE', '56', 49, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(619, 1, 176, 0, 'Орловская область', 'ORL', '57', 50, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(620, 1, 176, 0, 'Пензенская область', 'PNZ', '58', 51, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(621, 1, 176, 0, 'Пермский край', 'PER', '59', 52, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(622, 1, 176, 0, 'Приморский край', 'PRI', '25', 53, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(623, 1, 176, 0, 'Псковская область', 'PSK', '60', 54, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(624, 1, 176, 0, 'Ростовская область', 'ROS', '61', 55, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(625, 1, 176, 0, 'Рязанская область', 'RYA', '62', 56, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(626, 1, 176, 0, 'Самарская область', 'SAM', '63', 57, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(627, 1, 176, 0, 'Санкт-Петербург', 'SPE', '78', 58, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(628, 1, 176, 0, 'Саратовская область', 'SAR', '64', 59, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(629, 1, 176, 0, 'Саха (Якутия) Республика', 'SA', '14', 60, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(630, 1, 176, 0, 'Сахалинская область', 'SAK', '65', 61, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(631, 1, 176, 0, 'Свердловская область', 'SVE', '66', 62, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(632, 1, 176, 0, 'Северная Осетия-Алания Республика', 'SE', '15', 63, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(633, 1, 176, 0, 'Смоленская область', 'SMO', '67', 64, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(634, 1, 176, 0, 'Ставропольский край', 'STA', '26', 65, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(635, 1, 176, 0, 'Тамбовская область', 'TAM', '68', 66, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(636, 1, 176, 0, 'Татарстан Республика', 'TA', '16', 67, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(637, 1, 176, 0, 'Тверская область', 'TVE', '69', 68, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(638, 1, 176, 0, 'Томская область', 'TOM', '70', 69, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(639, 1, 176, 0, 'Тульская область', 'TUL', '71', 70, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(640, 1, 176, 0, 'Тыва Республика', 'TY', '17', 71, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(641, 1, 176, 0, 'Тюменская область', 'TYU', '72', 72, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(642, 1, 176, 0, 'Удмуртская Республика', 'UD', '18', 73, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(643, 1, 176, 0, 'Ульяновская область', 'ULY', '73', 74, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(644, 1, 176, 0, 'Хакасия Республика', 'KK', '19', 75, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(645, 1, 176, 0, 'Челябинская область', 'CHE', '74', 76, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(646, 1, 176, 0, 'Чеченская Республика', 'CE', '20', 77, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(647, 1, 176, 0, 'Чувашская Республика', 'CU', '21', 78, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(648, 1, 176, 0, 'Чукотский автономный округ', 'CHU', '87', 79, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(649, 1, 176, 0, 'Хабаровский край', 'KHA', '27', 80, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(650, 1, 176, 0, 'Ханты-Мансийский автономный округ', 'KHM', '86', 81, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(651, 1, 176, 0, 'Ямало-Ненецкий автономный округ', 'YAN', '89', 82, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(652, 1, 176, 0, 'Ярославская область', 'YAR', '76', 83, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(653, 1, 209, 0, 'กระบี่', 'กบ', 'กบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(654, 1, 209, 0, 'กรุงเทพมหานคร', 'กทม', 'กท', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(655, 1, 209, 0, 'กาญจนบุรี', 'กจ', 'กจ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(656, 1, 209, 0, 'กาฬสินธุ์', 'กส', 'กส', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(657, 1, 209, 0, 'กำแพงเพชร', 'กพ', 'กพ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(658, 1, 209, 0, 'ขอนแก่น', 'ขก', 'ขก', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(659, 1, 209, 0, 'จันทบุรี', 'จบ', 'จบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(660, 1, 209, 0, 'ฉะเชิงเทรา', 'ฉช', 'ฉช', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(661, 1, 209, 0, 'ชลบุรี', 'ชบ', 'ชบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(662, 1, 209, 0, 'ชัยนาท', 'ชน', 'ชน', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(663, 1, 209, 0, 'ชัยภูมิ', 'ชย', 'ชย', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(664, 1, 209, 0, 'ชุมพร', 'ชพ', 'ชพ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(665, 1, 209, 0, 'เชียงราย', 'ชร', 'ชร', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(666, 1, 209, 0, 'เชียงใหม่', 'ชม', 'ชม', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(667, 1, 209, 0, 'ตรัง', 'ตง', 'ตง', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(668, 1, 209, 0, 'ตราด', 'ตร', 'ตร', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(669, 1, 209, 0, 'ตาก', 'ตก', 'ตก', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(670, 1, 209, 0, 'นครนายก', 'นย', 'นย', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(671, 1, 209, 0, 'นครปฐม', 'นฐ', 'นฐ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(672, 1, 209, 0, 'นครพนม', 'นพ', 'นพ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(673, 1, 209, 0, 'นครราชสีมา', 'นม', 'นม', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(674, 1, 209, 0, 'นครศรีธรรมราช', 'นศ', 'นศ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(675, 1, 209, 0, 'นครสวรรค์', 'นว', 'นว', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(676, 1, 209, 0, 'นนทบุรี', 'นบ', 'นบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(677, 1, 209, 0, 'นราธิวาส', 'นธ', 'นธ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(678, 1, 209, 0, 'น่าน', 'นน', 'นน', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(679, 1, 209, 0, 'บุรีรัมย์', 'บร', 'บร', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(680, 1, 209, 0, 'บึงกาฬ', 'บก', 'บก', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(681, 1, 209, 0, 'ปทุมธานี', 'ปท', 'ปท', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(682, 1, 209, 0, 'ประจวบคีรีขันธ์', 'ปข', 'ปข', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(683, 1, 209, 0, 'ปราจีนบุรี', 'ปจ', 'ปจ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(684, 1, 209, 0, 'ปัตตานี', 'ปน', 'ปน', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(685, 1, 209, 0, 'พระนครศรีอยุธยา', 'อย', 'อย', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(686, 1, 209, 0, 'พังงา', 'พง', 'พง', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(687, 1, 209, 0, 'พัทลุง', 'พท', 'พท', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(688, 1, 209, 0, 'พิจิตร', 'พจ', 'พจ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(689, 1, 209, 0, 'พิษณุโลก', 'พล', 'พล', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(690, 1, 209, 0, 'เพชรบุรี', 'พบ', 'พบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(691, 1, 209, 0, 'เพชรบูรณ์', 'พช', 'พช', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(692, 1, 209, 0, 'แพร่', 'พร', 'พร', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(693, 1, 209, 0, 'พะเยา', 'พย', 'พย', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(694, 1, 209, 0, 'ภูเก็ต', 'ภก', 'ภก', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(695, 1, 209, 0, 'มหาสารคาม', 'มค', 'มค', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(696, 1, 209, 0, 'แม่ฮ่องสอน', 'มส', 'มส', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(697, 1, 209, 0, 'มุกดาหาร', 'มห', 'มห', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(698, 1, 209, 0, 'ยะลา', 'ยล', 'ยล', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(699, 1, 209, 0, 'ยโสธร', 'ยส', 'ยส', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(700, 1, 209, 0, 'ร้อยเอ็ด', 'รอ', 'รอ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(701, 1, 209, 0, 'ระนอง', 'รน', 'รน', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(702, 1, 209, 0, 'ระยอง', 'รย', 'รย', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(703, 1, 209, 0, 'ราชบุรี', 'รบ', 'รบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(704, 1, 209, 0, 'ลพบุรี', 'ลบ', 'ลบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(705, 1, 209, 0, 'ลำปาง', 'ลป', 'ลป', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(706, 1, 209, 0, 'ลำพูน', 'ลพ', 'ลพ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(707, 1, 209, 0, 'เลย', 'ลย', 'ลย', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(708, 1, 209, 0, 'ศรีสะเกษ', 'ศก', 'ศก', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(709, 1, 209, 0, 'สกลนคร', 'สน', 'สน', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(710, 1, 209, 0, 'สงขลา', 'สข', 'สข', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(711, 1, 209, 0, 'สตูล', 'สต', 'สต', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(712, 1, 209, 0, 'สมุทรปราการ', 'สป', 'สป', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(713, 1, 209, 0, 'สมุทรสงคราม', 'สส', 'สส', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(714, 1, 209, 0, 'สมุทรสาคร', 'สค', 'สค', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(715, 1, 209, 0, 'สระบุรี', 'สบ', 'สบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(716, 1, 209, 0, 'สระแก้ว', 'สก', 'สก', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(717, 1, 209, 0, 'สิงห์บุรี', 'สห', 'สห', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(718, 1, 209, 0, 'สุโขทัย', 'สท', 'สท', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(719, 1, 209, 0, 'สุพรรณบุรี', 'สพ', 'สพ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(720, 1, 209, 0, 'สุราษฎร์ธานี', 'สฎ', 'สฎ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(721, 1, 209, 0, 'สุรินทร์', 'สร', 'สร', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(722, 1, 209, 0, 'หนองคาย', 'นค', 'นค', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(723, 1, 209, 0, 'หนองบัวลำภู', 'นภ', 'นภ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(724, 1, 209, 0, 'อ่างทอง', 'อท', 'อท', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(725, 1, 209, 0, 'อุดรธานี', 'อด', 'อด', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(726, 1, 209, 0, 'อุตรดิตถ์', 'อต', 'อต', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(727, 1, 209, 0, 'อุทัยธานี', 'อน', 'อน', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(728, 1, 209, 0, 'อุบลราชธานี', 'อบ', 'อบ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(729, 1, 209, 0, 'อำนาจเจริญ', 'อจ', 'อจ', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_userfield_values
--
INSERT INTO auc13_virtuemart_userfield_values VALUES
(1, 10, 'Mr', 'Mr', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 10, 'Mrs', 'Mrs', 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 26, 'None', '0', 0, 16, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 26, 'Non-resident (Canada)', 'R', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(5, 26, 'Federal government (United States)', 'A', 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(6, 26, 'State government (United States)', 'B', 0, 2, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(7, 26, 'Tribe / Status Indian / Indian Band (both)', 'C', 0, 3, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(8, 26, 'Foreign diplomat (both)', 'D', 0, 4, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(9, 26, 'Charitable or benevolent org (both)', 'E', 0, 5, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(10, 26, 'Religious or educational org (both)', 'F', 0, 6, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(11, 26, 'Resale (both)', 'G', 0, 7, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(12, 26, 'Commercial agricultural production (both)', 'H', 0, 8, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(13, 26, 'Industrial production / manufacturer (both)', 'I', 0, 9, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(14, 26, 'Direct pay permit (United States)', 'J', 0, 10, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(15, 26, 'Direct mail (United States)', 'K', 0, 11, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(16, 26, 'Other (both)', 'L', 0, 12, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(17, 26, 'Local government (United States)', 'N', 0, 13, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(18, 26, 'Commercial aquaculture (Canada)', 'P', 0, 14, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(19, 26, 'Commercial Fishery (Canada)', 'Q', 0, 15, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_userfields
--
INSERT INTO auc13_virtuemart_userfields VALUES
(1, 0, 0, 'email', 'COM_VIRTUEMART_REGISTER_EMAIL', '', 'emailaddress', 100, 30, 1, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 1, NULL, 4, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 0, 0, 'password', 'COM_VIRTUEMART_SHOPPER_FORM_PASSWORD_1', '', 'password', 25, 30, 1, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 1, NULL, 10, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(3, 0, 0, 'password2', 'COM_VIRTUEMART_SHOPPER_FORM_PASSWORD_2', '', 'password', 25, 30, 1, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 1, NULL, 12, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(4, 0, 0, 'agreed', 'COM_VIRTUEMART_I_AGREE_TO_TOS', '', 'checkbox', NULL, NULL, 1, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 1, NULL, 13, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(5, 0, 0, 'name', 'COM_VIRTUEMART_USER_DISPLAYED_NAME', '', 'text', 25, 30, 1, 0, 0, '', NULL, 1, 0, 1, 0, 0, 1, '', 8, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(6, 0, 0, 'username', 'COM_VIRTUEMART_USERNAME', '', 'text', 25, 30, 1, 0, 0, '', NULL, 1, 0, 1, 0, 0, 1, '', 6, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(7, 0, 0, 'address_type_name', 'COM_VIRTUEMART_USER_FORM_ADDRESS_LABEL', '', 'text', 32, 30, 1, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 0, 1, NULL, 16, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(8, 0, 0, 'delimiter_billto', 'COM_VIRTUEMART_USER_FORM_BILLTO_LBL', '', 'delimiter', 25, 30, 0, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, NULL, 18, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(9, 0, 0, 'company', 'COM_VIRTUEMART_SHOPPER_FORM_COMPANY_NAME', '', 'text', 64, 30, 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 20, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(10, 0, 0, 'title', 'COM_VIRTUEMART_SHOPPER_FORM_TITLE', '', 'select', 0, 0, 0, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 1, NULL, 22, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(11, 0, 0, 'first_name', 'COM_VIRTUEMART_SHOPPER_FORM_FIRST_NAME', '', 'text', 32, 30, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 24, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(12, 0, 0, 'middle_name', 'COM_VIRTUEMART_SHOPPER_FORM_MIDDLE_NAME', '', 'text', 32, 30, 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 26, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(13, 0, 0, 'last_name', 'COM_VIRTUEMART_SHOPPER_FORM_LAST_NAME', '', 'text', 32, 30, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 28, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(14, 0, 0, 'address_1', 'COM_VIRTUEMART_SHOPPER_FORM_ADDRESS_1', '', 'text', 64, 30, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 30, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(15, 0, 0, 'address_2', 'COM_VIRTUEMART_SHOPPER_FORM_ADDRESS_2', '', 'text', 64, 30, 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 32, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(16, 0, 0, 'zip', 'COM_VIRTUEMART_SHOPPER_FORM_ZIP', '', 'text', 32, 30, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 34, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(17, 0, 0, 'city', 'COM_VIRTUEMART_SHOPPER_FORM_CITY', '', 'text', 32, 30, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 36, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(18, 0, 0, 'virtuemart_country_id', 'COM_VIRTUEMART_SHOPPER_FORM_COUNTRY', '', 'select', 0, 0, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 38, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(19, 0, 0, 'virtuemart_state_id', 'COM_VIRTUEMART_SHOPPER_FORM_STATE', '', 'select', 0, 0, 1, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 40, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(20, 0, 0, 'phone_1', 'COM_VIRTUEMART_SHOPPER_FORM_PHONE', '', 'text', 32, 30, 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 42, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(21, 0, 0, 'phone_2', 'COM_VIRTUEMART_SHOPPER_FORM_PHONE2', '', 'text', 32, 30, 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 44, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(22, 0, 0, 'fax', 'COM_VIRTUEMART_SHOPPER_FORM_FAX', '', 'text', 32, 30, 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 46, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(23, 0, 0, 'delimiter_sendregistration', 'COM_VIRTUEMART_BUTTON_SEND_REG', '', 'delimiter', 25, 30, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, NULL, 2, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(24, 0, 0, 'delimiter_userinfo', 'COM_VIRTUEMART_ORDER_PRINT_CUST_INFO_LBL', '', 'delimiter', NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, NULL, 14, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(25, 1, 0, 'tax_exemption_number', 'COM_VIRTUEMART_SHOPPER_FORM_TAXEXEMPTION_NBR', 'Vendors can set here a tax exemption number for a shopper. This field is only changeable by administrators.', 'text', 10, 0, 0, 0, 0, NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, 48, 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(26, 1, 0, 'tax_usage_type', 'COM_VIRTUEMART_SHOPPER_FORM_TAX_USAGE', 'Federal, national, educational, public, or similar often get a special tax. This field is only writable by administrators.', 'select', 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, 50, 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_userinfos
--

-- Таблица auctionru_2013.auc13_virtuemart_userinfos не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_vendor_medias
--

-- Таблица auctionru_2013.auc13_virtuemart_vendor_medias не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_vendors
--
INSERT INTO auc13_virtuemart_vendors VALUES
(1, 'Русские сезоны', 131, '', 'vendor_min_pov="1"|vendor_min_poq=1|vendor_freeshipment=0|vendor_address_format=""|vendor_date_format=""|', '0000-00-00 00:00:00', 0, '2013-02-01 12:37:10', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_vendors_ru_ru
--
INSERT INTO auc13_virtuemart_vendors_ru_ru VALUES
(1, '<p style="margin: 15px 0px; color: #301f07; font-family: Verdana, ''Times New Roman'', Times, serif; font-size: 14px; line-height: 17px;">Фирма «Русские сезоны» была основана в <strong>1999</strong> году. В антикварной среде  известна двумя представителями, располагающимися в историческом центре Санкт-Петербурга: <a href="http://auction.auction-ruseasons.ru/index.php?a=28&b=137" title="Антикварная галерея" style="outline: none; color: #851719; text-decoration: underline; font-family: Verdana;">галереей</a> на<strong>Литейном проспекте дом </strong><strong>15</strong> и <a href="http://auction.auction-ruseasons.ru/index.php?a=28&b=138" title="Антикварный салон" style="outline: none; color: #851719; text-decoration: underline; font-family: Verdana;">салоном</a> на <strong>набережной реки Фонтанки дом 24</strong>. Более чем за десятилетний период своего существования Фирма зарекомендовала себя как активный, пользующийся доверием участник антикварного бизнеса, сотрудничающий со многими музеями, коллекционерами, дилерами и  дизайнерами.</p>\r\n<p style="margin: 15px 0px; color: #301f07; font-family: Verdana, ''Times New Roman'', Times, serif; font-size: 14px; line-height: 17px;">Галерея «Русские Сезоны» открылась  в <strong>2002</strong> году <strong>Литейном проспекте в доме</strong><strong> 15</strong>, основная специализация - русская живопись дореволюционного периода и предметы антиквариата высшего уровня.<br />В залах галереи представлены работы таких выдающихся  мастеров живописи как И. Айвазовский, К. Маковский, Н. Дубовской, Б. Кустодиев, И. Шишкин, А. Головин и др.<br />Также здесь можно увидеть образцы  продукции выпущенной  знаменитой фирмой Карла Фаберже, предметы, созданные на других известных фабриках по производству серебряных изделий, имевших звания придворных поставщиков императорского двора: Братья Грачёвы, Сазиковъ, Морозовъ и т.д.</p>\r\n<p style="margin: 15px 0px; color: #301f07; font-family: Verdana, ''Times New Roman'', Times, serif; font-size: 14px; line-height: 17px;">На  <strong>набережной реки Фонтанки дом </strong><strong>24</strong> работает антикварный Салон подарков «Русские Сезоны». В салоне представлен более широкий спектр антикварных изделий, включающий в себя как предметы русского искусства, так и западного. В экспозиции представлены живописные произведения, предметы интерьера, продукция фарфоровых фабрик и заводов России, Германии, Франции, Дании, Англии, Австрии, Испании, Японии. Обширно представлен раздел стеклянной продукции, в частности предметы Императорского стеклянного завода, заводов Богемии. Коллекционеры и любители художественной бронзы так же смогут найти интересующие их предметы в нашем салоне среди венской бронзы, авторских работ русских мастеров таких как: Е. Напс, М. Антокольский, Е. Лансере, а так же работ западных мастеров. Также, в большом ассортименте,  представлена восточная тематика: мебель, нэцкэ, графика, бронза, фарфор, предметы интерьера.</p>\r\n<p style="margin: 15px 0px; color: #301f07; font-family: Verdana, ''Times New Roman'', Times, serif; font-size: 14px; line-height: 17px;">Многогранен и живописный раздел: портреты, натюрморты, пейзажи, камерные произведения, мифологическая, анималистическая живопись, марины, полотна на религиозные сюжеты русских и западных мастеров XVIII, XIX, ХХ веков. <br />Коллекционер Вы или любитель, или просто ищите оригинальный подарок, в залах Салона «Русские Сезоны» Вы  сможете найти предмет старины абсолютно на любой вкус.</p>\r\n<p style="margin: 15px 0px; color: #301f07; font-family: Verdana, ''Times New Roman'', Times, serif; font-size: 14px; line-height: 17px;">Салон «Русские Сезоны» сотрудничает с дизайнерами, помогает коллекционерам антикварных раритетов пополнять свои собрания.</p>', '', '', 'Аукцион Русские Сезоны', '', 'http://localhost/~auction.test/category/310/Магазин.html', 'auktsion-russkie-sezony');

-- 
-- Вывод данных для таблицы auc13_virtuemart_vmuser_shoppergroups
--
INSERT INTO auc13_virtuemart_vmuser_shoppergroups VALUES
(1, 107, 2);

-- 
-- Вывод данных для таблицы auc13_virtuemart_vmusers
--
INSERT INTO auc13_virtuemart_vmusers VALUES
(107, 1, 1, '21232f297a57a5a743894a0e4a801fc3', 'admin', 0, 0, 0, '0000-00-00 00:00:00', 0, '2013-02-01 12:37:10', 107, '0000-00-00 00:00:00', 0);

-- 
-- Вывод данных для таблицы auc13_virtuemart_waitingusers
--

-- Таблица auctionru_2013.auc13_virtuemart_waitingusers не содержит данных

-- 
-- Вывод данных для таблицы auc13_virtuemart_worldzones
--

-- Таблица auctionru_2013.auc13_virtuemart_worldzones не содержит данных

-- 
-- Вывод данных для таблицы auc13_weblinks
--

-- Таблица auctionru_2013.auc13_weblinks не содержит данных

-- 
-- Вывод данных для таблицы auc13_wf_profiles
--
INSERT INTO auc13_wf_profiles VALUES
(1, 'Default', 'Default Profile for all users', '', '3,4,5,6,7,8', '', 0, 'desktop,tablet,phone', 'help,newdocument,undo,redo,spacer,bold,italic,underline,strikethrough,justifyfull,justifycenter,justifyleft,justifyright,spacer,blockquote,formatselect,styleselect,removeformat,cleanup;fontselect,fontsizeselect,forecolor,backcolor,spacer,clipboard,indent,outdent,lists,sub,sup,textcase,charmap,hr;directionality,fullscreen,preview,source,print,searchreplace,spacer,table;visualaid,visualchars,visualblocks,nonbreaking,style,xhtmlxtras,anchor,unlink,link,imgmanager,spellchecker,article', 'contextmenu,browser,inlinepopups,media,help,clipboard,searchreplace,directionality,fullscreen,preview,source,table,textcase,print,style,nonbreaking,visualchars,visualblocks,xhtmlxtras,imgmanager,anchor,link,spellchecker,article,lists', 1, 1, 0, '0000-00-00 00:00:00', ''),
(2, 'Front End', 'Sample Front-end Profile', '', '3,4,5', '', 1, 'desktop,tablet,phone', 'help,newdocument,undo,redo,spacer,bold,italic,underline,strikethrough,justifyfull,justifycenter,justifyleft,justifyright,spacer,formatselect,styleselect;clipboard,searchreplace,indent,outdent,lists,cleanup,charmap,removeformat,hr,sub,sup,textcase,nonbreaking,visualchars,visualblocks;fullscreen,preview,print,visualaid,style,xhtmlxtras,anchor,unlink,link,imgmanager,spellchecker,article', 'contextmenu,inlinepopups,help,clipboard,searchreplace,fullscreen,preview,print,style,textcase,nonbreaking,visualchars,visualblocks,xhtmlxtras,imgmanager,anchor,link,spellchecker,article,lists', 0, 2, 0, '0000-00-00 00:00:00', ''),
(3, 'Blogger', 'Simple Blogging Profile', '', '3,4,5,6,7,8', '', 0, 'desktop,tablet,phone', 'bold,italic,strikethrough,lists,blockquote,spacer,justifyleft,justifycenter,justifyright,spacer,link,unlink,imgmanager,article,spellchecker,fullscreen,kitchensink;formatselect,underline,justifyfull,forecolor,clipboard,removeformat,charmap,indent,outdent,undo,redo,help', 'link,imgmanager,article,spellchecker,fullscreen,kitchensink,clipboard,contextmenu,inlinepopups,lists', 0, 3, 0, '0000-00-00 00:00:00', '{"editor":{"toggle":"0"}}'),
(4, 'Mobile', 'Sample Mobile Profile', '', '3,4,5,6,7,8', '', 0, 'tablet,phone', 'undo,redo,spacer,bold,italic,underline,formatselect,spacer,justifyleft,justifycenter,justifyfull,justifyright,spacer,fullscreen,kitchensink;styleselect,lists,spellchecker,article,link,unlink', 'fullscreen,kitchensink,spellchecker,article,link,inlinepopups,lists', 0, 4, 0, '0000-00-00 00:00:00', '{"editor":{"toolbar_theme":"mobile","resizing":"0","resize_horizontal":"0","resizing_use_cookie":"0","toggle":"0","links":{"popups":{"default":"","jcemediabox":{"enable":"0"},"window":{"enable":"0"}}}}}');

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;