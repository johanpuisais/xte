<?php
   header("Cache-Control: no-cache, must-revalidate");
   header("Pragma: no-cache");
?>
<?php 
$id = (rand(10,1000000)); 
$date = date("YmdHis");
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
$nodeStart = "<Articles>\n"; 
$nodeEnd = "</Articles>\n"; 



?> 
<?php 
    function ecrire_xml($filename, $header, $nodeStart, $data, $nodeEnd) 
    { 
//Imports old data 
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

    //Sets up new data 
    $final_content = $header.$nodeStart.$data.$old_content.$nodeEnd; 

    //Writes new data 
    $handle2 = fopen($filename, "w"); 
    $finalwrite = fwrite($handle2, $final_content); 
    fclose($handle2); 
    } 
?> 
  
<?php 
$filename = "data_xml/articles.xml"; // File which holds all data 
$data = "<article>\n
<id><![CDATA[$id]]></id>\n
<date><![CDATA[$date]]></date>\n
<title><![CDATA[$title]]></title>\n
<text_link><![CDATA[$text_link]]></text_link>\n
<meta_title><![CDATA[$meta_title]]></meta_title>\n
<meta_description><![CDATA[$meta_description]]></meta_description>\n
<meta_keywords><![CDATA[$meta_keywords]]></meta_keywords>\n
<headline><![CDATA[$headline]]></headline>\n
<youtube_embed><![CDATA[$youtube_embed]]></youtube_embed>\n
<media_embed><![CDATA[$media_embed]]></media_embed>\n
<image_embed><![CDATA[$image_embed]]></image_embed>\n
<image_caption><![CDATA[$image_caption]]></image_caption>\n
<body><![CDATA[$body]]></body>\n
<sel_auteur><![CDATA[$sel_auteur]]></sel_auteur>\n
<select_Word_King><![CDATA[$select_Word_King]]></select_Word_King>\n
<select_Word_King_02><![CDATA[$select_Word_King_02]]></select_Word_King_02>\n
<select_Word_King_03><![CDATA[$select_Word_King_03]]></select_Word_King_03>\n
<page_dest><![CDATA[$page_dest]]></page_dest>\n
<zone_dest><![CDATA[$zone_dest]]></zone_dest>\n
<galerie><![CDATA[$galerie]]></galerie>\n
<rss><![CDATA[$rss]]></rss>\n
<top_news><![CDATA[$top_news]]></top_news>\n
<visible><![CDATA[$visible]]></visible>\n
</article>\n"; 
ecrire_xml($filename, $header, $nodeStart, $data, $nodeEnd); 


//création du fichier compteur pour les contenus
$base_page = 'base_xml/_count.xml';
$user_page = 'data_modif_count/'.'art_'.$id."_count" .'.xml';
copy($base_page, $user_page) or die("Impossible de copier $base_page en $user_page.")


?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="Refresh" CONTENT="0; URL=article_liste.php"> 
<title>Le contact est ajouté</title>
<style type="text/css">
<!--

-->
</style>
</head>

<body>

</body>
</html>