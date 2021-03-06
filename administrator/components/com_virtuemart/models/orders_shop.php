<?php
/**
 *
 * Description
 *
 * @package	VirtueMart
 * @subpackage
 * @author RolandD
 * @author Oscar van Eijk
 * @author Max Milbers
 * @author Patrick Kohl
 * @author Valerie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: orders.php 6468 2012-09-18 22:00:43Z Milbo $
 */

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

if(!class_exists('VmModel'))require(JPATH_VM_ADMINISTRATOR.DS.'helpers'.DS.'vmmodel.php');

/**
 * Model for VirtueMart Orders
 * WHY $this->db is never used in the model ?
 * @package VirtueMart
 * @author RolandD
 */
class VirtueMartModelOrders_shop extends VmModel
{

    /**
     * constructs a VmModel
     * setMainTable defines the maintable of the model
     * @author Max Milbers
     */
    function __construct()
    {
        parent::__construct();
        //$this->setMainTable('orders');
        //$this->addvalidOrderingFieldName(array('order_name', 'order_email', 'payment_method', 'virtuemart_order_id'));
    }

    /**
     * Переключить статус заказа
     */
    function toggleOrderStatus($virtuemart_product_id){
        $table_name = '#__dev_shop_orders';
        $db = JFactory::getDbo();
        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('id', 'status')));
        $query->from($db->quoteName($table_name));
        $query->where($db->quoteName('virtuemart_product_id') . ' = ' .
            $db->quote($virtuemart_product_id));
        $db->setQuery($query);
        $results = $db->loadAssoc(); // Result, loadAssoc, ArrayList, Column, Row, RowList
        $status_to_set = ($results['status'])? '0':'1';
        $record_id = $results['id'];
        $object = new stdClass();
        $object->id = $record_id;
        $object->status = $status_to_set;
        try{
            $db->updateObject($table_name, $object, 'id');
            return $virtuemart_product_id;
        }catch(Exception $e){
            echo "<div>".$e->getMessage()."</div>";
        }
    }
}