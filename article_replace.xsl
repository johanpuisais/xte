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



<xsl:param name="id" />
<xsl:param name="page_dest" />
<xsl:param name="select_Word_King" />
<xsl:param name="select_Word_King_02" />
<xsl:param name="select_Word_King_03" />
<xsl:param name="item" />
<xsl:template match="/"> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
     <title>Modification des articles</title>
    <meta name="description" content="Modification des articles" />
    <meta name="keywords" content="Modification des articles" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/css_admin_form.css" rel="stylesheet" type="text/css" />
    <link href="css/css_admin_page.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="ckfinder/ckfinder.js"></script>


	<script type="text/javascript">

<![CDATA[function BrowseServer( startupPath, functionData )
{
	// You can use the "CKFinder" class to render CKFinder in a page:
	var finder = new CKFinder() ;
	
	// The path for the installation of CKFinder (default = "/ckfinder/").
	finder.BasePath = '' ;
	
	//Startup path in a form: "Type:/path/to/directory/"
	finder.StartupPath = startupPath ;
	
	// Name of a function which is called when a file is selected in CKFinder.
	finder.SelectFunction = SetFileField ;
	
	// Additional data to be passed to the SelectFunction in a second argument.
	// We'll use this feature to pass the Id of a field that will be updated.
	finder.SelectFunctionData = functionData ;
	
	// Name of a function which is called when a thumbnail is selected in CKFinder.
	finder.SelectThumbnailFunction = ShowThumbnails ;

	// Launch CKFinder
	finder.Popup() ;
}

// This is a sample function which is called when a file is selected in CKFinder.
function SetFileField( fileUrl, data )
{
	document.getElementById( data["selectFunctionData"] ).value = fileUrl ;
}

// This is a sample function which is called when a thumbnail is selected in CKFinder.
function ShowThumbnails( fileUrl, data )
{
	var sFileName = decodeURIComponent( fileUrl.replace( /^.*[\/\\]/g, '' ) ) ;
	document.getElementById( 'thumbnails' ).innerHTML += 
			'<div class="thumb">' +
				'<img src="' + fileUrl + '" />' +
				'<div class="caption">' +
					'<a href="' + data["fileUrl"] + '" target="_blank">' + sFileName + '</a> (' + data["fileSize"] + 'KB)' +
				'</div>' +
			'</div>' ;

	document.getElementById( 'preview' ).style.display = "";
	// It is not required to return any value.
	// When false is returned, CKFinder will not close automatically.
	return false;
}]]>
	</script>

	<script src="assets/js/jquery.min.js" type="text/javascript"></script>

<!-- Fonction de nettoyage de text_link
		<script type="text/javascript" src="assets/js/jquery.stringToSlug.js"></script>
        	<script type="text/javascript">
        		$(document).ready( function() {
				$("#title").stringToSlug();
			});
        	</script>-->
<!-- FIN de fonction de nettoyage de text_link-->

<!-- Suppression de l'historique -->
<script type="text/javascript">
    function Navigate(){   
         window.location.replace('admin_console.php');
        return false;
    }
   </script>
<!-- FIN Suppression de l'historique -->

</head>
<body>


<div id="container">
<div id="header"><img src="skins/logo_admin.png" width="340" height="108" align="left" /><h1>Modification des articles</h1></div>
<div id="toolbar"><a href="admin_console.php">Accueil console</a>
 | <a href="index.php" target="site">Voir le site</a>
 | <a href="javascript:history.go(-1);">Annuler</a></div>

<div id="main">







<xsl:for-each select="document('data_xml/articles.xml')/Articles/article[id=$id]">
<xsl:variable name="sel_auteur"><xsl:value-of select="sel_auteur"/></xsl:variable>
<form class="cssform" name="articles" id="formid" method="post" action="article_replace_function.php"   onSubmit="return check();">
  <br />
  <label>Count : </label>
  <input type="text" name="item" id="item" value="{$item}" readonly="readonly"/>

  <br />
  <label>Id : </label>
  <input type="text" name="id" id="id" value="{id}" readonly="readonly"/>

  <br />
  <label>Date de création : </label>
  <input type="text" name="date" id="date" value="{date}"/>

  <br />
	<label for="title">Titre : </label><input type="text" name="title" id="title"  value="{title}"/><br /><br />
	<label for="text_link">Texte du lien : <a style="font-size:0.8em;" href="#" title="ATTENTION ! vous allez changer l'URL de ce contenu et perdre son référencement !" onclick="document.getElementById('text_link').removeAttribute('readonly'); alert ('ATTENTION ! vous allez changer l\'URL de ce contenu et perdre son référencement !'); return false">(Modifier l'URL)</a> </label><input type="text" name="text_link" id="text_link"  value="{text_link}" readonly="readonly"/><br /><br />
	<label for="meta_title">Meta title : </label><input type="text" name="meta_title" id="meta_title" value="{meta_title}" /><br /><br />
	<label for="meta_description">Meta description : </label><input type="text" name="meta_description" id="meta_description"  value="{meta_description}"/><br /><br />
	<label for="meta_keywords">meta_keywords : </label><input type="text" name="meta_keywords" id="meta_keywords"  value="{meta_keywords}"/><br /><br />
	<label for="headline">Accroche de l'article : </label><div class="editeur"><textarea name="headline" id="headline" rows="15" cols="80"><xsl:value-of select="headline" disable-output-escaping="no"/></textarea></div><br /><br />
	<label for="youtube_embed">Code pour vidéo Youtube, Viméo... : </label><div><textarea name="youtube_embed" id="youtube_embed" rows="15" cols="80"><xsl:value-of select="youtube_embed" disable-output-escaping="no"/></textarea></div><br /><br />
	<label for="media_embed">Code embed vidéo : </label><input type="text" name="media_embed" id="media_embed" value="{media_embed}"/><input type="button" class="submitbt" value="Browse Server" onclick="BrowseServer( 'Files:/', 'media_embed' );" /><br /><br />
	<label for="image_embed">Code embed image : </label><input type="text" name="image_embed" id="image_embed" value="{image_embed}"/><input type="button" class="submitbt" value="Browse Server" onclick="BrowseServer( 'Images:/', 'image_embed' );" /><br /><br />
	<label for="image_caption">Description de l'image : </label><input type="text" name="image_caption" id="image_embed" value="{image_caption}"/><br /><br />
	<label for="body">Corps de l'article : </label><div class="editeur"><textarea name="body" id="body" rows="15" cols="80"><xsl:value-of select="body" disable-output-escaping="no"/></textarea></div><br /><br />

	<label for="sel_hotel">Sélectionner un auteur : </label>
	<select name="sel_auteur" id="sel_auteur" >
	<option value="">selectionnez dans la liste</option>
	<xsl:for-each select="document('data_xml/auteurs.xml')/Articles/article">
	<xsl:sort select="title" order="ascending"/>
	<option value="{text_link}"><xsl:if test="$sel_auteur=text_link"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="nom"/></option>
	</xsl:for-each>
	</select>
	<br /><br />

	<label for="select_Word_King">Sélectionner le mot clé : </label>
	<select name="select_Word_King" id="select_Word_King" >
	<option value="">selectionnez dans la liste</option>
	<xsl:for-each select="document('data_xml/word_king.xml')/Keywords/keyword[type!='presc']">
	<xsl:sort select="word_king" order="ascending"/>
	<option value="{text_link}"><xsl:if test="$select_Word_King=text_link"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="word_king"/></option>
	</xsl:for-each>
	</select>
	<br /><br />

	<label for="select_Word_King_02">Sélectionner un second mot clé : </label>
	<select name="select_Word_King_02" id="select_Word_King_02" >
	<option value="">selectionnez dans la liste</option>
	<xsl:for-each select="document('data_xml/word_king.xml')/Keywords/keyword[type!='presc']">
	<xsl:sort select="word_king" order="ascending"/>
	<option value="{text_link}"><xsl:if test="$select_Word_King_02=text_link"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="word_king"/></option>
	</xsl:for-each>
	</select>
	<br /><br />

	<label for="select_Word_King_03">Sélectionner un troisième mot clé : </label>
	<select name="select_Word_King_03" id="select_Word_King_03" >
	<option value="">selectionnez dans la liste</option>
	<xsl:for-each select="document('data_xml/word_king.xml')/Keywords/keyword[type!='presc']">
	<xsl:sort select="word_king" order="ascending"/>
	<option value="{text_link}"><xsl:if test="$select_Word_King_03=text_link"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="word_king"/></option>
	</xsl:for-each>
	</select>
	<br /><br />

	<label for="page_dest">Page de destination :  </label>
	<select name="page_dest" id="page_dest" >
	<option value="">selectionnez dans la liste</option>
	<!--<option value="menu-accueil"><xsl:if test="page_dest='menu-accueil'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Menu de la page d'accueil</option>-->
	<xsl:for-each select="document('data_xml/pages.xml')/Pages/page">
	<xsl:sort select="title" order="ascending"/>
	<option value="{text_link}"><xsl:if test="$page_dest=text_link"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="title"/></option>
	</xsl:for-each>
	<option value="">--- Pages Spéciales ---</option>
	<option value="encarts_accueil"><xsl:if test="$page_dest='encarts_accueil'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Encarts accueil</option>
	<option value="accueil_lumiere_sur"><xsl:if test="$page_dest='accueil_lumiere_sur'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Lumière sur : (accueil)</option>
	</select>
	<br /><br />

	<label for="zone_dest">Placement dans la page : </label>
	<select name="zone_dest" id="zone_dest" >
	<option value="main">---Placement dans la page---</option> 
	<option value="main"><xsl:if test="zone_dest='main'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>corps de page</option>
	<option value="nav-r"><xsl:if test="zone_dest='nav-r'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Navigation droite</option>
	</select>
	<br /><br />

	<label for="galerie">Activation galerie : </label>
	<select name="galerie" id="galerie" >
	<option value="">selectionnez dans la liste</option>
	<option value="on"><xsl:if test="galerie='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>On</option>
	<option value="off"><xsl:if test="galerie='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option>
	</select>
	<br /><br />

	<label for="rss">Sortie RSS : </label>
	<select name="rss" id="rss" >
	<option value="on"><xsl:if test="rss='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>On</option>
	<option value="off"><xsl:if test="rss='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option>
	</select>
	<br /><br />

	<label for="top_news">Top news : </label>
	<select name="top_news" id="top_news" >
	<option value="on"><xsl:if test="top_news='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>On</option>
	<option value="off"><xsl:if test="top_news='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option>
	</select>
	<br /><br />

	<label for="visible">Publication : </label>
	<select name="visible" id="visible" >
	<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>On</option>
	<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option>
	</select>
	<br /><br />
	<label for="button">Validez le formulaire</label><input class="submitbt" type="submit" name="button" id="button" value="Envoyer" onclick="Navigate();" /><br /><br />
  
</form>

</xsl:for-each>


   
</div>


<div id="footer">Tous droits réservés 2010 Johan Puisais</div>
</div>


	<script type="text/javascript">

// This is a check for the CKEditor class. If not defined, the paths must be checked.
if ( typeof CKEDITOR == 'undefined' )
{
	document.write(
		'<strong><span style="color: #ff0000">Error</span>: CKEditor not found</strong>.' +
		'This sample assumes that CKEditor (not included with CKFinder) is installed in' +
		'the "/ckeditor/" path. If you have it installed in a different place, just edit' +
		'this file, changing the wrong paths in the &lt;head&gt; (line 5) and the "BasePath"' +
		'value (line 32).' ) ;
}
else
{
	var editor = CKEDITOR.replace( 'headline' );
	CKFinder.SetupCKEditor( editor, '' ) ;

 	var editor2 = CKEDITOR.replace( 'body' );
 	CKFinder.SetupCKEditor( editor2, '' ) ;

}

		</script>


</body>
</html>


</xsl:template> 
</xsl:stylesheet>