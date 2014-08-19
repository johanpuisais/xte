<?php
   header("Cache-Control: no-cache, must-revalidate");
   header("Pragma: no-cache");

/* querystring */
/* $site=$_GET["site"];*/

   @$xslDoc = new DOMDocument();
   $xslDoc->load("admin_console.xsl");

   @$xmlDoc = new DOMDocument();
   $xmlDoc->load("data_xml/config.xml");

   @$proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);

/* querystring et passage de parametre
$proc->setParameter('', 'MonParametre', $MonParametre);
*/

   echo $proc->transformToXML($xmlDoc);

?>
