<?php
	header('Content-Type: text/html; charset=utf-8');
	header('Content-language: fr');

   $article=$_GET["article"];
   $datenow= date('Ymd');

   @$xslDoc = new DOMDocument();
   $xslDoc->load("article.xsl");

   @$xmlDoc = new DOMDocument();
   $xmlDoc->load("data_xml/articles.xml");

   @$proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);

   $proc->setParameter('', 'article', $article);
   $proc->setParameter('', 'datenow', $datenow);
   echo $proc->transformToXML($xmlDoc);

   /*echo $article;*/

?>
