<?php
	header('Content-Type: text/html; charset=ISO-8859-1');
	header('Content-language: fr');
	header("Cache-Control: no-cache, must-revalidate");
	header("Pragma: no-cache");


/* querystring*/

$text_link=$_GET["text_link"];
$date_now = date("YmdHis");

	@$xslDoc = new DOMDocument();
	$xslDoc->load("admin_user.xsl");

	@$xmlDoc = new DOMDocument();
	$xmlDoc->load("data_xml/pages.xml");

	@$proc = new XSLTProcessor();
	$proc->registerPHPFunctions();
	$proc->importStylesheet($xslDoc);

/* querystring et passage de parametre*/


   	$proc->setParameter('', 'text_link', $text_link);
	$proc->setParameter('', 'date_now', $date_now);
	echo $proc->transformToXML($xmlDoc);
?>