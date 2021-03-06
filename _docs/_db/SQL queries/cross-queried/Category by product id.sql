SELECT
  auc13_virtuemart_products_ru_ru.virtuemart_product_id, 
  auc13_virtuemart_products_ru_ru.product_name,
  auc13_virtuemart_product_prices.product_price,
  
  CONCAT(cats.virtuemart_category_id, ':', cats_ruru.virtuemart_category_id, ':', prod_cats.virtuemart_category_id, ':', cat_cats.category_child_id) AS 'category_id',
  cats_ruru.category_name,
  
  CONCAT(cat_cats.category_parent_id, ':', (SELECT
    auc13_virtuemart_categories_ru_ru.category_name
  FROM auc13_virtuemart_categories_ru_ru
  WHERE auc13_virtuemart_categories_ru_ru.virtuemart_category_id = cat_cats.category_parent_id)) AS 'parent_name'
FROM auc13_virtuemart_categories cats
  INNER JOIN auc13_virtuemart_category_categories cat_cats
    ON cats.virtuemart_category_id = cat_cats.category_child_id
  INNER JOIN auc13_virtuemart_product_categories prod_cats
    ON cats.virtuemart_category_id = prod_cats.virtuemart_category_id AND prod_cats.virtuemart_category_id = cat_cats.category_child_id
  INNER JOIN auc13_virtuemart_categories_ru_ru cats_ruru
    ON cats.virtuemart_category_id = cats_ruru.virtuemart_category_id
  INNER JOIN auc13_virtuemart_products_ru_ru
    ON auc13_virtuemart_products_ru_ru.virtuemart_product_id = prod_cats.virtuemart_product_id
  INNER JOIN auc13_virtuemart_product_prices
    ON auc13_virtuemart_product_prices.virtuemart_product_id = auc13_virtuemart_products_ru_ru.virtuemart_product_id