<?php
// No direct access
defined('_JEXEC') or die('Restricted access'); 
/**
 * получим методы основного класса:
 */
require_once JPATH_SITE.DS.'components'.DS.'com_auction2013'.DS.'helpers'.DS.'stuff.php';
require_once JPATH_SITE.DS.'tests.php';

class modVlotscatsHelper extends JModuleHelper
{	

 private static $categories_data=NULL;
 /**
 * Извлечь данные категорий верхнего уровня
 * @package
 * @subpackage
 */
	function getTopCategories($published=false,$db=false){
		$query='SELECT cats.virtuemart_category_id, 
        cats_ru.category_name,
		cats_ru.slug AS "alias"
FROM #__virtuemart_categories AS cats
LEFT JOIN #__virtuemart_categories_ru_ru AS cats_ru 
    ON  cats_ru.virtuemart_category_id = cats.virtuemart_category_id
LEFT JOIN #__virtuemart_category_categories AS cat_cats 
    ON  cat_cats.id = cats.virtuemart_category_id
WHERE cat_cats.category_parent_id = 0';
		if($published)
			$query.=' AND cats.`published` = "1"';
		$query.='
ORDER BY cats.ordering'; 
		if(!$db) 
			$db=JFactory::getDBO();
		$db->setQuery($query); //testSQL($query, __FILE__, __LINE__);
		return $db->loadAssocList(); 
	}
/**
 * Извлечь данные всех или только опубликованных предметов в категориях
 * @published - если передан - извлечь данные только опубликованных предметов
 * @package
 * @subpackage
 */
	public static function getCategoriesData($published=false,$db=false/*,$inStockOnly=true*/){
        if(!self::$categories_data){
            //commonDebug(__FILE__,__LINE__,debug_print_backtrace(), true);
            if (!$db)
                $db=JFactory::getDBO();

            $session =& JFactory::getSession();
            $prods=array();
            $session->set('products_data',$prods);
            $top_cats=modVlotscatsHelper::getTopCategories($db);
            $topLayouts=AuctionStuff::getTopCatsLayouts(true);
            //commonDebug(__FILE__,__LINE__,$topLayouts);
            /**
            [23]=> "shop"
            [21]=> "online"
            [22]=> "fulltime"
             */
            /* 0 =>
                array
                  'virtuemart_category_id' => string '21' (length=2)
                  'category_name' => string 'Онлайн торги' (length=23)
              1 =>
                array
                  'virtuemart_category_id' => string '22' (length=2)
                  'category_name' => string 'Очные торги' (length=21)
              2 =>
                array
                  'virtuemart_category_id' => string '23' (length=2)
                  'category_name' => string 'Магазин' (length=14)
              */
            // добавить подзапрос извлечения предметов с подходящим периодом публикации:
            $table = '';
            /*$subquery = '';
            if($published){
                $subquery = "
               AND prices.product_price_publish_up < NOW() ";
            }*/
            // исключить предметы магазина, на покупку которых были поданы заявки
            $subquery= "
               AND p.`virtuemart_product_id` NOT IN (
                   SELECT virtuemart_product_id
                     FROM #__dev_";

            $query='SELECT cats.virtuemart_category_id,
        cats_ru.category_name,
        cats_ru.slug AS "alias",
        (   SELECT count(p.virtuemart_product_id)
              FROM `#__virtuemart_products` AS p
        INNER JOIN `#__virtuemart_product_categories` AS pc
                   ON p.`virtuemart_product_id` = pc.`virtuemart_product_id` ';
            if($published)
                $query.='
        INNER JOIN `#__virtuemart_product_prices`      AS prices
                   ON prices.virtuemart_product_id = pc.virtuemart_product_id ';

             $query.='
             WHERE pc.`virtuemart_category_id` = cats.virtuemart_category_id ';
            /*if($published){
                $query.='
               AND p.`published` = "1"';
                $pub='
               AND cats.`published` = "1"';
            }else{
                $pub='';
            }
            if($inStockOnly)
                $query.='
               AND p.`product_in_stock` > 0';*/
            $queryEnd = '
        ) AS "product_count"
   FROM #__virtuemart_categories AS cats
   LEFT JOIN #__virtuemart_categories_ru_ru AS cats_ru
     ON cats_ru.virtuemart_category_id = cats.virtuemart_category_id
   LEFT JOIN #__virtuemart_category_categories AS cat_cats
     ON cat_cats.id = cats.virtuemart_category_id
  WHERE cat_cats.category_parent_id = ';

            $order='
  ORDER BY cat_cats.category_parent_id,cats.ordering';
            //commonDebug(__FILE__,__LINE__,$top_cats);
            foreach($top_cats as $i=>$top_cat){
                /**
                $top_cat:
                ["virtuemart_category_id"]=> "21"
                ["category_name"]=> "Онлайн торги"
                ["alias"]=> "онлайн-торги"
                 */
                $layout = $topLayouts[$top_cat['virtuemart_category_id']];
                $prods[$layout]=array();
                $q = $query;
                if($published)// $query передаётся по ссылке
                    AuctionStuff::getPeriodLimits($layout,$q,$published);
                // $q передаётся по ссылке
                AuctionStuff::excludeSold($layout,$q);
                $q.=$queryEnd .
                $top_cat['virtuemart_category_id'] .
                //$pub .
                $order;
                //showTestMessage('layout: '.$layout,__FILE__, __LINE__);
                //testSQL($q,__FILE__,__LINE__);
                /*if($layout=='shop') {
                    commonDebugBacktrace(__FILE__,__LINE__);
                    //die('line: '.__LINE__);
                }*/

                $db->setQuery($q);
                $children=$db->loadAssocList();
                $records[$top_cat['virtuemart_category_id']]=array(
                    'top_category_alias'    => $top_cat['alias'],
                    'top_category_name'     => $top_cat['category_name'],
                    'top_category_layout'   => $layout,
                    'children'              => $children
                );
                $prods[$layout]['prod_count']=0;
                foreach ($children as $c=>$child){
                    if ($child['alias']){
                        $prods[$layout]['prod_count']+=(int)$child['product_count'];
                        $prods[$layout][$child['alias']]=$child;
                    }
                }
            }
            self::$categories_data=$records;
            $session->set('products_data',$prods);
        }
		return self::$categories_data;
	}
}
