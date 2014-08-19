<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
<xsl:output
    indent="yes"
    method="xml" 
    omit-xml-declaration="no"
    encoding="utf-8"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>



<xsl:param name="site" />
<xsl:template match="/"> 

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Liste des articles publiés</title>


	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>

	<script type="text/javascript" src="ckfinder/ckfinder.js"></script>

    <link href="css/css_admin_page.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="container">
<div id="header"><img src="skins/logo_admin.png" width="340" height="108" align="left" /><h1>Liste des articles publiés</h1></div>
<div id="toolbar"><a href="admin_console.php">Accueil console</a>
 | <a href="index.php" target="site">Voir le site</a>
 | <a href="javascript:history.go(-1);">Annuler</a></div>

<div id="main">
<h2><span class="inscription" >Il y a actuellement <xsl:value-of select="count(//article)"/> articles</span> Ils sont classées par date  | <a href="article_form_add.php">Ajouter un article</a></h2>
<ul style="list-style-type:none;margin:0;padding:0;">

<xsl:for-each select="document('data_xml/articles.xml')/Articles/article">
<xsl:sort select="date" order="descending"/>
<li class="vue" style="border-radius:5px;">
<!--<h3 style="border-radius:4px;"><xsl:if test="visible='on'"><img src="skins/yes_pub_32.png" width="22" height="16" align="left" alt="Cet élément est publié"/></xsl:if><xsl:if test="visible='off'"><img src="skins/no_pub_32.png" width="22" height="16" align="left"  alt="Cet élément n'est pas publié"/></xsl:if>
<xsl:value-of select="title"/> | Ecrit le : <span><xsl:value-of select="concat(substring(date,7,2), '/', substring(date,5,2), '/', substring(date,1,4))"/></span> | <xsl:if test="page_dest!=''">Page : <span><xsl:value-of select="page_dest"/> </span></xsl:if><xsl:if test="page_dest=''">Mot clé : <span><xsl:value-of select="select_Word_King"/> </span></xsl:if> </h3>-->

<div style="display:block; float:right; width:180px; ">
<form class="bt_liste" id="supp" name="supp" method="post" action="article_remove.php">
<input name="item" type="hidden" value="{count(preceding::title)}" />
<input type="submit" name="envoyer" id="envoyer" value="Supprimer" onclick="return(confirm('Etes-vous sûr de vouloir supprimer cette entrée?'));" />
</form>
<form class="bt_liste" id="modifier" name="modifier" method="post" action="article_replace.php">
<input name="id" type="hidden" value="{id}" />
<input name="page_dest" type="hidden" value="{page_dest}" />
<input name="select_Word_King" type="hidden" value="{select_Word_King}" />
<input name="select_Word_King_02" type="hidden" value="{select_Word_King_02}" />
<input name="select_Word_King_03" type="hidden" value="{select_Word_King_03}" />
<input name="item" type="hidden" value="{count(preceding::title)}" />
<input type="submit" name="modifier" id="modifier" value="Voir / Modifier" />
</form>
</div>


<p style="font-size:1.1em; margin:5px 0; display:block; width:740px; float:left;">
<xsl:if test="visible='on'"><img src="skins/yes_pub_32.png" width="22" height="16" align="left" alt="Cet élément est publié"/></xsl:if><xsl:if test="visible='off'"><img src="skins/no_pub_32.png" width="22" height="16" align="left"  alt="Cet élément n'est pas publié"/></xsl:if>
<strong><xsl:value-of select="title"/></strong>
</p>
<p style="display:block; width:500px; clear:both; float:left; margin:5px 0 0 24px;">Ecrit le : <span><xsl:value-of select="concat(substring(date,7,2), '/', substring(date,5,2), '/', substring(date,1,4))"/></span> | <xsl:if test="page_dest!=''">Page : <span><xsl:value-of select="page_dest"/> </span></xsl:if><xsl:if test="page_dest=''">Mot clé : <span><xsl:value-of select="select_Word_King"/> </span></xsl:if>
</p>

<xsl:if test="galerie='on'">
<p style="display:block; width:750px; clear:both; float:left; margin:5px 0 2px 5px;">
<a href="galerie_add_art.php?text_link=images/{text_link}" class="btsubmit_03 btblue2" target="gal">Créer / Gérer Galerie</a> <!--| <a href="images/miniatures.php?gal={text_link}" target="gal">Générer /Maj. miniatures</a> | --><a href="images/galerie-600.php?gal={text_link}" class="btsubmit_03 btbrown" target="gal">Générer /Maj. slides</a>
</p>
</xsl:if>
</li>


</xsl:for-each>
</ul>

</div>

<div id="footer">Tous droits réservés 2010 Johan Puisais</div>
</div>
</body>
</html>


</xsl:template> 
</xsl:stylesheet>