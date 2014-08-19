<?php
   header("Cache-Control: no-cache, must-revalidate");
   header("Pragma: no-cache");
?>
<?php 
$item = $_POST['item']; 
$articles = new DOMDocument; 
$articles ->preserveWhiteSpace = false;
$articles->formatOutput = true;
$articles->Load("data_xml/articles.xml"); 
$articleList=$articles->getElementsByTagName("Articles")->item(0); // accès à l'enfant <articles> 
// Rechercher dans les articles tous les enfants avec le tag <article>, choisissez l'un avec $item. 
$articleToRemove=$articleList->getElementsByTagName("article")->item($item);  
//Nous voulons supprimer les enfants de <articles> alors j'ai utilisé $ articlelist qui pointe vers <articles> et enlevé les enfants appropriés. 
$articleList->removeChild($articleToRemove); 
$articles->save("data_xml/articles.xml"); 
header('Location: article_liste.php');exit
?>







<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Supprimer un contact</title>
<style type="text/css">
<!--
body {
	font-family: Arial, Helvetica, sans-serif;
	color: #333333;
}
h1 {
	font-size: 1.2em;
	color: #3D3934;
}
p {
	color: #698C00;
}
-->
</style>
</head>

<body>
<h1>Les donn&eacute;es sont &eacute;ffac&eacute;es</h1>
<p>Vous pouvez fermer cette fen&ecirc;tre<br />
</p>
</body>
</html>