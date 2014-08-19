<?php
   header("Cache-Control: no-cache, must-revalidate");
   header("Pragma: no-cache");
?>
<?php
   @$xslDoc = new DOMDocument();
   $xslDoc->load("article_form_add.xsl");
   @$xmlDoc = new DOMDocument();
   $xmlDoc->load("data_xml/articles.xml");
   @$proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);

/* querystring et passage de parametre
$proc->setParameter('', 'MonParametre', $MonParametre);
*/

/* $proc->setParameter('', 'site', $site);*/

   echo $proc->transformToXML($xmlDoc);

?>
