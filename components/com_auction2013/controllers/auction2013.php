<?php	
/**
 * @package		Joomla.Site
 * @subpackage	com_users
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

require_once JPATH_COMPONENT.'/controller.php';

/**
 * Registration controller class for Users.
 *
 * @package		Joomla.Site
 * @subpackage	com_users
 * @since		1.6
 */
class Auction2013ControllerAuction2013 extends JControllerLegacy
{
	public function sendApplication(){
		// Check for request forgeries.
		JSession::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
		$requestData = JRequest::getVar('jform', array(), 'post', 'array');		
		
		/*	'name' => string 'dfdsfsd' (length=7)
			'city' => string 'sdfsdf' (length=6)
			'email1' => string 'sdfsdf' (length=6)
			'phone_number' => string '' (length=0)
			'short_description' => string 'sdfsdf' (length=6)
			'price_wiches' => string 'ssdfsdf' (length=7)
		*/
		$subject = "Предложение предмета для аукциона";
		$body = 'Имя клиента: 
<p>'.$requestData['name'].'</p>
Город проживания: 
<p>'.$requestData['city'].'</p>
Емэйл: 
<p>'.$requestData['email1'].'</p>
Контактный телефон: 
<p>'.$requestData['phone_number'].'</p>
Описание предмета: 
<p>'.$requestData['short_description'].'</p>
Пожелания по цене: 
<p>'.$requestData['price_wiches'].'</p>';

		// $cc = false;
		// $bcc[] = false;

		$mail = JFactory::getMailer();
		$mail->setSender(array($requestData['email1'],$requestData['name']));
		$config =& JFactory::getConfig();
		$recipient = array( 
				$config->getValue( 'config.mailfrom' ),
				$config->getValue( 'config.fromname' ) 
			);
		
		$mail->addRecipient($recipient);		
		$mail->setSubject($subject);
		$mail->isHTML(true);
		$mail->Encoding = 'base64';
		$mail->setBody($body);
		$i=1;
		foreach($_FILES as $file){
			if($file['name']!='')
				$mail->AddEmbeddedImage($file['tmp_name'], 'image_'.$i, $file['name']);
			
			$i++;
		}
		$send =& $mail->Send();
		if ($send !== true) 
			die("Сообщение не было отправлено из-за возникшей ошибки.<hr>".$send->message);
		else
			$this->setRedirect(JRoute::_('index.php?option=com_auction2013&layout=thanx_for_lot', false));
		//http://docs.joomla.org/Sending_email_from_extensions			//http://api.joomla.org/__filesource/fsource_Joomla-Platform_Mail_librariesjoomlamailmail.php.html#a290
	}
}