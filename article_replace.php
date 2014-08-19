<?php
   header("Cache-Control: no-cache, must-revalidate");
   header("Pragma: no-cache");
?>

<?php
/* querystring
$MonParametre=$_POST["name"];
*/
$id=$_POST["id"];
$page_dest=$_POST["page_dest"];
$select_Word_King=$_POST["select_Word_King"];
$select_Word_King_02=$_POST["select_Word_King_02"];
$select_Word_King_03=$_POST["select_Word_King_03"];
$item=$_POST["item"];

   @$xslDoc = new DOMDocument();
   $xslDoc->load("article_replace.xsl");

   @$xmlDoc = new DOMDocument();
   $xmlDoc->load("data_xml/articles.xml");

   @$proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);

/* querystring et passage de parametre
$proc->setParameter('', 'MonParametre', $MonParametre);
*/

$proc->setParameter('', 'id', $id);
$proc->setParameter('', 'page_dest', $page_dest);
$proc->setParameter('', 'select_Word_King', $select_Word_King);
$proc->setParameter('', 'select_Word_King_02', $select_Word_King_02);
$proc->setParameter('', 'select_Word_King_03', $select_Word_King_03);
$proc->setParameter('', 'item', $item);

   echo $proc->transformToXML($xmlDoc);

?>
