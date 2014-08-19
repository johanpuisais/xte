<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:gr="http://www.google.com/schemas/reader/atom/"
	xmlns:atom="http://www.w3.org/2005/Atom"
    version="1.0">
<xsl:output
    indent="no"
    method="xml" 
    omit-xml-declaration="yes"
    encoding="utf-8"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>



<xsl:param name="page" />

<xsl:template match="/"> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Console d'administration</title>


	<link href="css/css_admin_form.css" rel="stylesheet" type="text/css" />
    <link href="css/css_admin_page.css" rel="stylesheet" type="text/css" />
    <link href="css/css_admin_console.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="container">
<div id="header"><img src="skins/logo_admin.png" width="340" height="108" align="left" /><h1>Accueil de l'administration du site<br /><xsl:value-of select="Sites/site/name" /></h1>
 </div>
<div id="toolbar">
<!-- Infos du site : -->
Pages en ligne : <span class="nb"><xsl:value-of select="count(document('data_xml/pages.xml')/Pages/page[visible='on']/title)+1" /></span> | 
Articles en ligne : <span class="nb"><xsl:value-of select="count(document('data_xml/articles.xml')/Articles/article[visible='on']/title)" /></span> | 
Galeries en ligne : <span class="nb"><xsl:value-of select="count(document('data_xml/galeries.xml')/Galeries/galerie[visible='on']/title)" /></span> | 
Contacts : <span class="nb"><xsl:value-of select="count(document('data_xml/contacts.xml')/Contacts/contact/id)" /></span> | 
Commentaires à modérer : <span class="nb"><xsl:value-of select="count(document('data_users/commentaires.xml')/Commentaires/commentaire[publication='']/id)" /></span> | 
<a href="{document('data_xml/config.xml')/Sites/site/url}index.php" target="site">Voir le site</a></div>
<div id="main"><br />
	<div id="col1">

    <ul>
    	<!-- <li>
    	  <a href="#">Configuration du site</a> </li>-->
    	<li>
    	  <a href="page_liste.php">Pages du site</a> </li>
    	<li>
    	  <a href="article_liste.php">Articles</a> </li>
    	<li>
    	  <a href="word_king_liste.php">Mots clés &amp; catégories</a> </li>
        <li>
    	  <a href="agenda_liste.php">Agenda</a> </li>
    </ul>
  </div>


  <div id="col2">
  	<ul>
	<li>
	  <a href="config_mod.php" class="config">Configuration du site</a> </li>
    <li>
      <a href="sauvegarde_bds_full.php" target="_blank">Sauvegarde des données</a> </li>
    <li>
      <a href="mise-en-zip-sauvergarde.php" target="_blank">Télécharger la sauvegarde</a> </li>
    <li>
      <a href="ckfinder/ckfinder.html" target="ckf">Gestionnaire de fichiers</a> </li>
    <!--<li>
      <a href="rss-blog-wp-xml-save.php" target="ckf">Re-générer le cache RSS du blog</a> </li>
    <li>
      <a href="iso_liste.php" target="ckf">Dénominations pays ISO et internes</a> </li>-->
    </ul>
  </div>

	<!--  <div id="col3">
  	<ul>
	<li style="color:#fff;font-weight:normal;">Aide en ligne</li>
	
	<xsl:for-each select="document('http://www.izr.fr/data_xml/didacticiels.xml')/Didacticiels/didacticiel[visible='on' and (membre='mu2s' or membre='mu2c' or membre='all')]">
	<xsl:sort select="title" order="ascending"/>
	<li><a href="{url}" target="didac"><img src="skins/help.png" width="24" height="24" alt="Pages du site : Guide d'utilisation " /></a><a href="{url}" title="{meta_description}" target="didac"><xsl:value-of select="title" /></a></li>
	</xsl:for-each>
	</ul>
  </div>
<div id="bloc1"></div>-->

  <div id="col4">
  	<ul>

        <li>
    	  <a href="galerie_liste.php">Galeries de photographies (Slide accueil)</a> </li>
        <li>
    	  <a href="photo_liste.php">Gestion des photographies (Slide accueil)</a> </li>
    	<li>
    	  <a href="contacts_liste.php">Gestion des contacts</a> </li>
    	<li>
    	  <a href="newsletters_liste.php">Inscriptions newsletter</a> </li>
	<li>
	  <a href="commentaires_liste.php" title="Modération des commentaires postés par les visiteurs">Modération commentaires</a></li>
    </ul>
  </div>

</div>
<div id="footer">Tous droits réservés 2010 Johan Puisais</div></div>
</body>
</html>



</xsl:template> 
</xsl:stylesheet>