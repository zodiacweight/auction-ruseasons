<?php
//showTestMessage("Auction<hr>", __FILE__, __LINE__, false);
// no direct access
defined('_JEXEC') or die;
//commonDebug(__FILE__,__LINE__,array('count'=>count($this->results),$this->results), false);
/*
  array(1) {
    [0]=>
    object(stdClass)#243 (5) {
      ["virtuemart_product_id"]=>
      string(4) "4194"
      ["title"]=>
      string(27) "Жывопысный Пук"
      ["product_s_desc"]=>
      string(28) "Чудова картина!"
      ["href"]=>
      string(104) "http://localhost/auction-ruseasons/аукцион/очные-торги/zhivopis-grafika/zhivopiz-detail"
      ["image"]=>
      string(87) "images/stories/virtuemart/product/resized/akvarelnye-goroda-maji-vronskoj-2_226x226.jpg"
    }
  } */
//commonDebug(__FILE__,__LINE__,$this->results, false);
?>
<div class="top_list">
    <h2 id="auction-header"><?=$this->section_header?></h2>
<?php   HTML::setCommonInnerMenu(array('user','take_lot'));?>
</div>
<?php
$all_results=' &nbsp; <a href="'.JRoute::_('index.php?option=com_auction2013&'.AuctionStuff::$auction_list_common_link . $this->auction_number).'">Все предметы аукциона...</a>';
//commonDebug(__FILE__,__LINE__,$this->getLayout(), true);
HTML::setVmPagination($this->getLayout(), true);
if(!count($this->results)):?>
    <h4 class="thin">Ничего не найдено...<?=$all_results?></h4>
<?php
endif;?>
<form action="?<?=AuctionStuff::$auction_list_common_link . $this->auction_number?>&action=search" method="post">
    <input type="search" value="" placeholder="Поиск" name="product_name" class="field keyword" style="width:300px;margin:5px 0">
    <input type="hidden" name="Itemid" value="<?=JRequest::getVar('Itemid')?>"/>
    <input type="submit" value="Искать"/>
</form>
<div class="clearfix" id="auction-catalogue">
    <div class="floatLeft">
        <a href="documents/Russians_seasones_auction_<?=$this->auction_number?>.jpg">
            <img width="100" height="142" alt="Антиквариат Каталог <?=$this->auction_number?>" src="documents/preview_Russians_seasones_auction_<?=$this->auction_number?>.jpg">
        </a>
    </div>
    <div class="floatLeft">
        <div id="auction-number" class="vertically-aligned">Аукцион № <?=$this->auction_number?><br>
        <?=$this->auction_date?>
        <br>
        <a href="documents/Russians_seasones_auction_<?=$this->auction_number?>.pdf">Скачать КАТАЛОГ в PDF формате</a>
        </div>
    </div>
</div>
<?php
if(count($this->results)):
    if(JRequest::getVar('action')=='search'):?>
    <h4>Результаты поиска<span class="thin"><?=$all_results?></span></h4>
        <?php
    endif;
        ?>
    <script>
        var imgs_src={};
    </script>
<dl class="search-results auction" id="search-results-block">
    <?php foreach($this->results as $product_id=>$product_data) : ?>
        <dt class="result-title">
            <?php
            // построить маркеры для пролистывания картинок
            HTML::buildProductImagesQueue(count($product_data['image']),$product_id);
            if ($product_data['href']) :
                if($product_data['image'][0]):?>
                    <script>
                        imgs_src['<?=$product_id?>']=[];
                <?php   foreach ($product_data['image'] as $i=>$src):?>
                            imgs_src[<?=$product_id?>][<?=$i?>]='<?=$src?>';
                <?php   endforeach;
                /*  Object4194: Array[2]
                        0: "akvarelnye-goroda-maji-vronskoj-2_226x226.jpg"
                        1: "edros_226x226.jpg"*/?>
                    </script>
            <?php
                endif;?>
                <a href="<?php
                /**
                ВНИМАНИЕ! В $product_data['href'] жёстко вшита ссылка на дир.
                /аукцион/очные-торги/ - исключительно для очных торгов! */
                echo JRoute::_($product_data['href']);?>">
            <?php   if($product_data['image']):
                        ?><img src="<?php
                        echo $product_data['image'][0];?>"><?php
                    else:
                        ?><img src="<?=JURI::base() .'images/no-image.gif'?>" width="226" height="226"><?php
                    endif;
                    $link_text = str_replace("&laquo;","«",$product_data['title']);
                    $link_text = str_replace("&raquo;","»",$link_text);?>
                    <div class="name">
                    <span>
                        <b><?=$this->escape($link_text)?></b>
                        <p><?=$product_data['product_s_desc']?></p>
                        <section><?php
                        echo $product_data['prices']." ";
                        echo($product_data['currency_symbol']=='$')?
                            "у.е":$product_data['currency_symbol']; ?>.</section>
                    </span>
                    </div>
            <?php else:?>
                <?=$this->escape($product_data['title'])?>
            <?php endif;?>
                </a>
        </dt>
    <?php endforeach; ?>
</dl>
<?php   HTML::setVmPagination();
        // добавить обработчика предпросмотра картинок предмета
        HTML::setProductImagesQueueHandler('dl [data-img-index]','dl','data-img-index');
endif;