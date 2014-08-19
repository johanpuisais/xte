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
//Nous voulons supprimer les enfants de <Articles> alors j'ai utilisé $ articlelist qui pointe vers <articles> et enlevé les enfants appropriés. 
$articleList->removeChild($articleToRemove); 
$articles->save("data_xml/articles.xml"); 
?>


<?php
// stoppe pour 5 secondes
sleep(5);
?>



<?php 
$id = $_POST['id']; 
$date = $_POST['date'];
$title = $_POST['title']; 
$text_link = $_POST['text_link']; 
$meta_title = $_POST['meta_title']; 
$meta_description = $_POST['meta_description']; 
$meta_keywords = $_POST['meta_keywords']; 
$headline = $_POST['headline']; 
$youtube_embed = $_POST['youtube_embed']; 
$media_embed = $_POST['media_embed']; 
$image_embed = $_POST['image_embed']; 
$image_caption = $_POST['image_caption']; 
$body = $_POST['body']; 
$sel_auteur = $_POST['sel_auteur']; 
$select_Word_King = $_POST['select_Word_King']; 
$select_Word_King_02 = $_POST['select_Word_King_02']; 
$select_Word_King_03 = $_POST['select_Word_King_03']; 
$page_dest = $_POST['page_dest'];
$zone_dest = $_POST['zone_dest'];
$galerie = $_POST['galerie'];
$rss = $_POST['rss'];
$top_news = $_POST['top_news'];
$visible = $_POST['visible'];
$header = "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>"; 
$nodeStart = "<Articles>"; 
$nodeEnd = "</Articles>"; 
?>
<?php 
    function ecrire_xml($filename, $header, $nodeStart, $data, $nodeEnd) 
    { 
//Importations des anciennes données 
$handle = fopen($filename, "r"); 
$old_content = fread($handle, filesize ($filename)); 
$f[] = "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>"; 
$f[] = "<Articles>"; 
$f[] = "</Articles>"; 
foreach($f as $key => $value) 
{ 
   $old_content = trim(str_replace($value, "", $old_content)); 
} 
fclose($handle); 
    //Mise en place des nouvelles données 
    $final_content = $header.$nodeStart.$data.$old_content.$nodeEnd; 
    //Écrit des données nouvelles 
    $handle2 = fopen($filename, "w"); 
    $finalwrite = fwrite($handle2, $final_content); 
    fclose($handle2); 
    } 
?>
  
<?php 
$filename = "data_xml/articles.xml"; // File which holds all data 
$data = "<article>
<id><![CDATA[$id]]></id>
<date><![CDATA[$date]]></date>
<title><![CDATA[$title]]></title>
<text_link><![CDATA[$text_link]]></text_link>
<meta_title><![CDATA[$meta_title]]></meta_title>
<meta_description><![CDATA[$meta_description]]></meta_description>
<meta_keywords><![CDATA[$meta_keywords]]></meta_keywords>
<headline><![CDATA[$headline]]></headline>
<youtube_embed><![CDATA[$youtube_embed]]></youtube_embed>\n
<media_embed><![CDATA[$media_embed]]></media_embed>
<image_embed><![CDATA[$image_embed]]></image_embed>
<image_caption><![CDATA[$image_caption]]></image_caption>
<body><![CDATA[$body]]></body>
<sel_auteur><![CDATA[$sel_auteur]]></sel_auteur>\n
<select_Word_King><![CDATA[$select_Word_King]]></select_Word_King>
<select_Word_King_02><![CDATA[$select_Word_King_02]]></select_Word_King_02>
<select_Word_King_03><![CDATA[$select_Word_King_03]]></select_Word_King_03>
<page_dest><![CDATA[$page_dest]]></page_dest>
<zone_dest><![CDATA[$zone_dest]]></zone_dest>
<galerie><![CDATA[$galerie]]></galerie>
<rss><![CDATA[$rss]]></rss>
<top_news><![CDATA[$top_news]]></top_news>
<visible><![CDATA[$visible]]></visible>
</article>"; 
ecrire_xml($filename, $header, $nodeStart, $data, $nodeEnd); 
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="Refresh" CONTENT="0; URL=article_liste.php"> 
<title>L'article est ajouté</title>
<style type="text/css">
<!--

-->
</style>
</head>

<body>

</body>
</html>