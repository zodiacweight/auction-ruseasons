<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	Templates.bluestork
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access.
defined('_JEXEC') or die;

jimport('joomla.filesystem.file');

$app = JFactory::getApplication();
$doc = JFactory::getDocument();

$doc->addStyleSheet('templates/system/css/system.css');
$doc->addStyleSheet('templates/'.$this->template.'/css/template.css');

if ($this->direction == 'rtl') {
	$doc->addStyleSheet('templates/'.$this->template.'/css/template_rtl.css');
}
/** Load specific language related css */
$lang = JFactory::getLanguage();
$file = 'language/'.$lang->getTag().'/'.$lang->getTag().'.css';
if (JFile::exists($file)) {
	$doc->addStyleSheet($file);
}

if ($this->params->get('textBig')) {
	$doc->addStyleSheet('templates/'.$this->template.'/css/textbig.css');
}

if ($this->params->get('highContrast')) {
	$doc->addStyleSheet('templates/'.$this->template.'/css/highcontrast.css');
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo  $this->language; ?>" lang="<?php echo  $this->language; ?>" dir="<?php echo  $this->direction; ?>" >
<head>
<link href="templates/<?php echo $this->template; ?>/less/styles.less" rel="stylesheet/less" type="text/css">

<?php if(JRequest::getVar('option')=='com_virtuemart'):?>
<link href="templates/<?php echo $this->template; ?>/less/virtuemart.less" rel="stylesheet/less" type="text/css">
<?php endif;?>
<?php if(JRequest::getVar('option')=='com_auction2013'):?>
<link href="templates/<?php echo $this->template; ?>/less/import_export.less" rel="stylesheet/less" type="text/css">
<?php endif;?>
<link href="components/com_auction2013/system-xtra.css" rel="stylesheet" type="text/css">
<script src="templates/<?php echo $this->template; ?>/less/less.js" type="text/javascript"></script>
<script src="templates/<?php echo $this->template; ?>/js/jquery-1.7.1.min.js"></script>
<script src="templates/<?php echo $this->template; ?>/js/jquery-ui-1.8.18.custom.min.js"></script>

<!--<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>--> 

<jdoc:include type="head" />

<!--[if IE 7]>
<link href="templates/<?php echo  $this->template ?>/css/ie7.css" rel="stylesheet" type="text/css" />
<![endif]-->

<!--[if gte IE 8]>
<link href="templates/<?php echo  $this->template ?>/css/ie8.css" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body id="minwidth-body">
	<div id="border-top" class="h_blue">
		<span class="logo"><a href="http://www.joomla.org" target="_blank"><img src="templates/<?php echo  $this->template ?>/images/logo.png" alt="Joomla!" /></a></span>
		<span class="title"><a href="index.php"><?php echo $this->params->get('showSiteName') ? $app->getCfg('sitename'). " " . JText::_('JADMINISTRATION') : JText::_('JADMINISTRATION') ; ?></a></span>
	</div>
	<div id="header-box">
		<div id="module-menu">
			<jdoc:include type="modules" name="menu" />
		</div>
		<div id="module-status">
			<jdoc:include type="modules" name="status" />
			<?php
				//Display an harcoded logout
				$task = JRequest::getCmd('task');
				if ($task == 'edit' || $task == 'editA' || JRequest::getInt('hidemainmenu')) {
					$logoutLink = '';
				} else {
					$logoutLink = JRoute::_('index.php?option=com_login&task=logout&'. JSession::getFormToken() .'=1');
				}
				$hideLinks	= JRequest::getBool('hidemainmenu');
				$output = array();
				// Print the Preview link to Main site.
				$output[] = '<span class="viewsite"><a href="'.JURI::root().'" target="_blank">'.JText::_('JGLOBAL_VIEW_SITE').'</a></span>';
				// Print the logout link.
				$output[] = '<span class="logout">' .($hideLinks ? '' : '<a href="'.$logoutLink.'">').JText::_('JLOGOUT').($hideLinks ? '' : '</a>').'</span>';
				// Output the items.
				foreach ($output as $item) :
				echo $item;
				endforeach;
			?>
		</div>
		<div class="clr"></div>
	</div>

	<div id="content-box">
		<div id="toolbar-box">
			<div class="m">
				<jdoc:include type="modules" name="toolbar" />
				<jdoc:include type="modules" name="title" />
			</div>
		</div>
		<?php if (!JRequest::getInt('hidemainmenu')): ?>
		<jdoc:include type="modules" name="submenu" style="rounded" id="submenu-box" />
		<?php endif; ?>
		<jdoc:include type="message" />
		<div id="element-box">
			<div class="m">
				<jdoc:include type="component" />
				<div class="clr"></div>
			</div>
		</div>
		<noscript>
			<?php echo  JText::_('JGLOBAL_WARNJAVASCRIPT') ?>
		</noscript>
	</div>

	<jdoc:include type="modules" name="footer" style="none"  />
	<div id="footer">
		<p class="copyright">
			<?php $joomla= '<a href="http://www.joomla.org">Joomla!&#174;</a>';
				echo JText::sprintf('JGLOBAL_ISFREESOFTWARE', $joomla) ?>
		</p>
	</div>
</body>
</html>
