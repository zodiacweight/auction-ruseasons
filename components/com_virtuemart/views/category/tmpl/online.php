<?php	
/**
 *
 * Show the products in a category
 *
 * @package    VirtueMart
 * @subpackage
 * @author RolandD 
 * @author srgg6701
 */
/** 
 * this: VirtuemartViewCategory
 */
// Check to ensure this file is included in Joomla!
defined ('_JEXEC') or die('Restricted access');
// commonDebug(__FILE__,__LINE__,JRequest::get('get'), true);
//commonDebug(__FILE__,__LINE__, JRequest::get('get'));
$Itemid = JRequest::getVar('Itemid');
HTML::pageHead('online');
if(JRequest::getVar('spag'))
	var_dump($this->vmPagination); ?>
<div class="item-page-shop">
<br>
<?php if (empty($this->keyword)):
        if($this->category->category_description):?>
	<div class="category_description"><?=$this->category->category_description; 
	// проверить, включено ли отображение категории (для теста):
	//echo 'showCategory: '.VmConfig::get ('showCategory', 1);?>
	</div>
<?php   endif;
      endif;

if ( VmConfig::get ('showCategory', 1) && 
	 empty($this->keyword)
   ) :
	
	$show_children=false;
	if($show_children){
		if ($this->category->haschildren) :
			echo '<h1>Has children! Do something, Dude...</h1>';?>
		<div>
		<?php foreach ($this->category->children as $category) :
				// Category Link
                // $url, $xhtml = true, $ssl = null, $show = false, $test=false
                echo "<div>url: ".JRoute::_('index.php?option=com_virtuemart&view=category&virtuemart_category_id=' .
                        $category->virtuemart_category_id, true, null, false, true)."</div>";

                $caturl = JRoute::_('index.php?option=com_virtuemart&view=category&virtuemart_category_id=' . $category->virtuemart_category_id);
				// Show Category?>
				<h2><a href="<?=$caturl?>" title="<?=$category->category_name?>"><?=$category->category_name?></a>
					<div class="img" title="<?=$category->category_name?>">
						<a href="<?=$caturl?>"><?=$category->images[0]->displayMediaThumb ("", FALSE)?></a>
					</div>
				</h2>
		<?php endforeach;?>
		</div>
	<?php endif;
	} // /show_children
endif;
	
if ($this->search !== NULL):?>
<form action="<?=JRoute::_('index.php?option=com_virtuemart&view=category&limitstart=0&virtuemart_category_id=' . $this->category->virtuemart_category_id); ?>" method="get">
	<!--BEGIN Search Box -->
	<div class="virtuemart_search">
		<?=$this->searchcustom?>
		<br/>
		<?=$this->searchcustomvalues?>
		<input name="keyword" class="inputbox" type="text" size="20" value="<?=$this->keyword ?>"/>
		<input type="submit" value="<?=JText::_ ('COM_VIRTUEMART_SEARCH')?>" class="button" onclick="this.form.keyword.focus();"/>
	</div>
	<input type="hidden" name="search" value="true"/>
	<input type="hidden" name="view" value="category"/>
</form>
<!-- End Search Box -->
<?php endif;

// here all rock & roll begins! Yo.
if (!empty($this->products)) {
        //echo "<h3>this->products:</h3><pre>";var_dump($this->products);echo "</pre>"; // die();
	// array => object
	foreach($this->products as $i=>$product){
	    //commonDebug(__FILE__,__LINE__,$product);?>
<div class="box">
  <div class="img">	
    <a title="<?=$product->link?>" rel="vm-additional-images" href="<?=$product->link?>"><?php 
	
	if(isset($test)){
		?>PRODUCT image<?php 
	}
	
	?><?=$product->images[0]->displayMediaThumb('class="browseProductImage"', false)?></a>
  </div>
	<h2><?php
        // наименование продукта
        echo JHTML::link ($product->link, $product->product_name);
        ?></h2>
	<?php if (!empty($product->product_s_desc)):?>
	<p class="product_s_desc"><?=shopFunctionsF::limitStringByWord ($product->product_s_desc, 40, '...')?></p>
<?php 	endif; 

		if ($this->show_prices == '1') {

			if ($product->prices['salesPrice']<=0 and VmConfig::get ('askprice', 1) and  !$product->images[0]->file_is_downloadable):
				echo JText::_ ('COM_VIRTUEMART_PRODUCT_ASKPRICE');
			endif;
			
			if ($this->showBasePrice):
				echo $this->currency->createPriceDiv ('basePrice', 'COM_VIRTUEMART_PRODUCT_BASEPRICE', $product->prices);
				echo $this->currency->createPriceDiv ('basePriceVariant', 'COM_VIRTUEMART_PRODUCT_BASEPRICE_VARIANT', $product->prices);
			endif;
			
			echo $this->currency->createPriceDiv ('variantModification', 'COM_VIRTUEMART_PRODUCT_VARIANT_MOD', $product->prices);
			
			if (round($product->prices['basePriceWithTax'],$this->currency->_priceConfig['salesPrice'][1]) != $product->prices['salesPrice']) :
				echo '<span class="price-crossed" >' . $this->currency->createPriceDiv ('basePriceWithTax', 'COM_VIRTUEMART_PRODUCT_BASEPRICE_WITHTAX', $product->prices) . "</span>";
			endif;
			
			if (round($product->prices['salesPriceWithDiscount'],$this->currency->_priceConfig['salesPrice'][1]) != $product->prices['salesPrice']) :
				echo $this->currency->createPriceDiv ('salesPriceWithDiscount', 'COM_VIRTUEMART_PRODUCT_SALESPRICE_WITH_DISCOUNT', $product->prices);
			endif;
			
			echo $this->currency->createPriceDiv ('salesPrice', 'COM_VIRTUEMART_PRODUCT_SALESPRICE', $product->prices, false, false, '1.0', 'online');
			
			echo $this->currency->createPriceDiv ('priceWithoutTax', 'COM_VIRTUEMART_PRODUCT_SALESPRICE_WITHOUT_TAX', $product->prices);
			
			echo $this->currency->createPriceDiv ('discountAmount', 'COM_VIRTUEMART_PRODUCT_DISCOUNT_AMOUNT', $product->prices);
			
			echo $this->currency->createPriceDiv ('taxAmount', 'COM_VIRTUEMART_PRODUCT_TAX_AMOUNT', $product->prices);
			
			$unitPriceDescription = JText::sprintf ('COM_VIRTUEMART_PRODUCT_UNITPRICE', $product->product_unit);
			
			echo $this->currency->createPriceDiv ('unitPrice', $unitPriceDescription, $product->prices);
		
		}
		
		$show_button=false;
		if ($show_button):// Product Details Button?>
	<p><?=JHTML::link ($product->link, JText::_ ('COM_VIRTUEMART_PRODUCT_DETAILS'), array('title' => $product->product_name, 'class' => 'product-details'))?></p>
	<?php endif;?>
</div>
<?php }

}elseif ($this->search !== NULL) {
	echo JText::_ ('COM_VIRTUEMART_NO_RESULT') . ($this->keyword ? ' : (' . $this->keyword . ')' : '');
}?>
</div>
<?php HTML::setVmPagination();
 // todo: убрать закомментированный код
 /*?>
<script>
(function($){
    $('span.lot').on({
        'mouseenter': function(){
            this.title = "Сделать ставку";
        },
        'click':function(){
<?php   if(JFactory::getUser()->guest!=1):
?>
            location.href="?option=com_virtuemart&view=productdetails&virtuemart_category_id=<?php
                    echo $this->category->parents[0]->virtuemart_category_id;
                    ?>&Itemid=<?php
                    echo $Itemid;
                    ?>&virtuemart_product_id="+$(this).attr('data-product_id')+"&do=bid";
<?php   else:
?>
            alert('Чтобы сделать ставку, вам необходимо заавторизоваться.');
<?php   endif;
?>
        }
    });
})(jQuery);
</script><?php */ ?>