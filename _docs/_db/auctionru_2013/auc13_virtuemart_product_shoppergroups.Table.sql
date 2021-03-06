﻿--
-- Описание для таблицы auc13_virtuemart_product_shoppergroups
--
CREATE TABLE IF NOT EXISTS auc13_virtuemart_product_shoppergroups (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  virtuemart_product_id int(1) UNSIGNED NOT NULL DEFAULT 0,
  virtuemart_shoppergroup_id smallint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX i_virtuemart_product_id (virtuemart_product_id, virtuemart_shoppergroup_id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 11
character SET utf8
COLLATE utf8_general_ci
COMMENT = 'Maps Products to Categories';