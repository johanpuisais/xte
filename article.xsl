<?xml version="1.0" encoding="utf-8"?>
	<!DOCTYPE xsl:stylesheet >
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:php="http://php.net/xsl"
	exclude-result-prefixes="xsl php"
	xmlns:og="http://ogp.me/ns#" 
	xmlns:twitter="http://api.twitter.com"
	version="1.0">
        <!-- XSL Import -->
	<xsl:import href="templates.xsl"/>
<xsl:output 
	indent="no"
	method="xml" 
	omit-xml-declaration="yes"
	encoding="utf-8" />

	<!--Paramêtre transmis à la feuille xslt-->
	<xsl:param name="page" />
	<xsl:param name="article" />
	<xsl:param name="datenow" />
	<xsl:param name="page_art"><xsl:value-of  select="document('data_xml/articles.xml')/Articles/article[text_link=$article]/page_dest"/></xsl:param>
	<xsl:param name="zone_art"><xsl:value-of  select="document('data_xml/articles.xml')/Articles/article[text_link=$article]/zone_dest"/></xsl:param>

	<!--Début Breadcrumbs-->
	<xsl:variable name="base_url_site"><xsl:value-of select="document('data_xml/config.xml')/Sites/site/url" /></xsl:variable>
	<xsl:variable name="base_url_site_sls1"><xsl:value-of select="substring-before(document('data_xml/config.xml')/Sites/site/url, 'fr/')" /></xsl:variable>
	<xsl:variable name="base_url_site_sls"><xsl:value-of select="$base_url_site_sls1" /></xsl:variable>
	<xsl:variable name="title_yes"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/title" /></xsl:variable>
	<xsl:variable name="name-page-bc">
	<xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/page_dest" />
	</xsl:variable>
	<xsl:variable name="page-bc"><xsl:value-of select="document('data_xml/pages.xml')/Pages/page[visible='on' and text_link=$name-page-bc]/title" /></xsl:variable>
	<!--FIN Breadcrumbs-->

	<!--DEBUT Variables Balise Metas articles et partage bt sociaux desc-->
	<xsl:variable name="title"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/title" /></xsl:variable>
	<xsl:variable name="meta_title"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/meta_title" /></xsl:variable>
	<xsl:variable name="description"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/meta_description" /></xsl:variable>
	<xsl:variable name="meta_keywords"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/meta_keywords" /></xsl:variable>
	<xsl:variable name="image_embed"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/image_embed" /></xsl:variable>
	<xsl:variable name="pint-image"><xsl:value-of select="$base_url_site_sls" /><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/image_embed" /></xsl:variable>
	<!--FIN Variables Balise Metas articles et partage bt sociaux desc-->


	<!--Taxonomie et affichage des mots clés-->
	<xsl:variable name="kw1"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/select_Word_King" /></xsl:variable>
	<xsl:variable name="kw2"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/select_Word_King_02" /></xsl:variable>
	<xsl:variable name="kw3"><xsl:value-of select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/select_Word_King_03" /></xsl:variable>

	<xsl:variable name="kw_fulltxt1"><xsl:value-of select="document('data_xml/word_king.xml')/Keywords/keyword[visible='on' and text_link=$kw1]/word_king"/></xsl:variable>
	<xsl:variable name="kw_fulltxt2"><xsl:value-of select="document('data_xml/word_king.xml')/Keywords/keyword[visible='on' and text_link=$kw2]/word_king"/></xsl:variable>
	<xsl:variable name="kw_fulltxt3"><xsl:value-of select="document('data_xml/word_king.xml')/Keywords/keyword[visible='on' and text_link=$kw3]/word_king"/></xsl:variable>
	<!--FIN Taxonomie et affichage des mots clés-->


	<!--Variable test activation galerie-->
	<xsl:param name="galerie_yes" ><xsl:value-of  select="document('data_xml/articles.xml')/Articles/article[text_link=$article]/galerie"/></xsl:param>
	<!--Chemin fichiers XML dynamique galerie photo-->
	<xsl:param name="xml_galerie" ><xsl:value-of select="$base_url_site"/><xsl:text>galerie_lister_fichiers_xml.php?galerie_dir_file=images/</xsl:text><xsl:value-of select="$article"/></xsl:param>

	<!--Variable Page mère article -->
	<xsl:variable name="motherpagetype"><xsl:value-of select="document('data_xml/pages.xml')/Pages/page[visible='on' and text_link=$name-page-bc]/type" /></xsl:variable>
	<!--Variable Page mère article -->

	<!--DEBUT Nb article NavR-->
	<xsl:variable name="nb-art-navr"><xsl:value-of select="count(document('data_xml/articles.xml')/Articles/article[visible='on' and page_dest=$name-page-bc and zone_dest='nav-r'])" /></xsl:variable>
	<!--FIN Nb article NavR-->


<xsl:template match="/"> 
	<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;</xsl:text>
	<html lang="fr">

<head>
<!-- METAs -->
	<meta charset="utf-8" />
	<title>
	<xsl:value-of select="$title" /> - <xsl:value-of select="$meta_title" />
	</title>

	<meta name="description" content="{$description}"/>
	<meta name="keywords" content="{$meta_keywords}"/>
	<link rel="canonical" href="{$base_url_site}article.php?article={$article}"/>

	<!--Open Graph FB-->
	<meta property="og:title" content="{$title}"/>
	<meta property="og:image" content="{$base_url_site_sls}{$image_embed}"/>
	<meta property="og:description" content="{$description}"/>
	<!--FIN Open Graph FB-->
	<!--Twitter Card-->
	<meta name="twitter:card" value="summary" />
	<meta name="twitter:url" value="{$base_url_site}article.php?article={$article}" />
	<meta name="twitter:title" value="{$title}" />
	<meta name="twitter:description" value="{$description}" />
	<meta name="twitter:image" value="{$base_url_site_sls}{$image_embed}" />
	<meta name="twitter:site" value="@mrgris" />
	<meta name="twitter:creator" value="@mrgris" />	<!--FIN Twitter Card-->

	<link rel="canonical" href="{$base_url_site}article.php?article={$article}"/>
	<link rel="sitemap" type="application/xml" title="Sitemap" href="{$base_url_site}sitemap.xml" />
<!--FIN METAs -->

<!-- RSS -->
	<link rel="alternate" type="application/rss+xml" title="RSS : Johan Puisais" href="rss.php" />
<!-- Fin RSS -->

	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=10"/><![endif]-->
	<meta name="viewport" content="initial-scale=1.0"/>
	<!--[if lt IE 9]><script src="assets/js/html5shiv.js"><xsl:text> </xsl:text></script><![endif]-->

<xsl:comment>
    <![CDATA[[if lt IE 9]><script src="assets/js/html5shiv.js"><xsl:text> </xsl:text></script><![endif]]]>
</xsl:comment>

	<link rel="stylesheet" href="assets/css/3214x4.css" media="all"/>
	<link rel="stylesheet" href="assets/css/knacss.css" media="all"/>
	<!--<link rel="stylesheet" href="assets/css/flexslider.min.css" type="text/css" media="all"/> -->
	<link rel="stylesheet" href="assets/css/nav.min.css" type="text/css" media="all"/>
	<link rel="stylesheet" href="assets/css/iconvault.min.css" type="text/css" media="screen" />


	<script src="assets/js/jquery.min.js"><xsl:text> </xsl:text></script>
	<!--<script type="text/javascript" src="assets/js/jquery.flexslider.min.js"><xsl:text> </xsl:text></script>-->


	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />

	<!-- Analytics start -->
	<xsl:value-of select="document('data_xml/config.xml')/Sites/site/analytics" disable-output-escaping="yes"/>
	<!-- Analytics end -->

	<xsl:if test="$galerie_yes='on'">
	<!--<link rel="stylesheet" href="assets/css/jquery.bxslider.css" />-->
	<script type="text/javascript" src="assets/js/jquery.bxslider.js"><xsl:text> </xsl:text></script>
	<script type="text/javascript">
	  $(document).ready(function(){
	    
	$('.bxslider').bxSlider({
	  pagerCustom: '#bx-pager',
	  minSlides: 2,
	  maxSlides: 2,
	  startSlide: 0
	});
	  });
	</script>
	</xsl:if>

</head>


<!--DEBUT de Body-->
<body id="body" class="center">
<a id="haut"><xsl:text> </xsl:text></a>

<!-- Corps de page start -->

<!--DEBUT Header Logo Espace part. -->
	<header class="line mod center">
	<div class="mod center mw960p" id="logo"><xsl:text> </xsl:text>
        <!-- Appel au template Header -->
	<xsl:call-template name="header"/>
        <!-- FIN Appel au template Header -->
	</div>
<!--debut Toolbar Nav -->
<div class="line mod center color-nav"><xsl:text> </xsl:text>
        <!-- Appel au template Toolbar Header -->
	<xsl:call-template name="toolbar_header"/>
        <!-- FIN Appel au template Toolbar Header -->
</div>
<!--fin Toolbar Nav -->
	</header>
<!--FIN Header Logo Espace part.-->


<!--DEBUT Main : Content - Nav-->
<div class="mod center mw960p pl1 pr1">

	<!--DEBUT Breadcrumbs-->
<div class="w960p left">
	<ul class="breadcrumbs ma0 pa0">
	<li>Vous êtes ici : </li>
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="{$base_url_site}" itemprop="url"><span itemprop="title" title="Retour à l'accueil">Accueil</span></a></li>
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
	<xsl:if test="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/page_dest!='my-honeymoons'">
	<a href="{$base_url_site}page.php?page={$name-page-bc}" itemprop="url" title="{$page-bc}"><span itemprop="title"><xsl:value-of select="$page-bc"/></span></a>
	</xsl:if>
	<xsl:if test="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]/page_dest='my-honeymoons'">
	<a href="{$base_url_site}{$name-page-bc}" itemprop="url" title="{$page-bc}"><span itemprop="title">My Honeymoons</span></a>
	</xsl:if>
	</li>
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="{$base_url_site}article.php?article={$article}" itemprop="url" title="{$title_yes}"><span itemprop="title"><xsl:value-of select="$title_yes"/></span></a></li>
	</ul>
</div>
	<!--FIN Breadcrumbs-->


<!--DEBUT Corps articles standards-->

<!--<p>Variable XML galerie : <xsl:value-of select="$xml_galerie"/> | Galerie oui / non <xsl:value-of select="$galerie_yes"/></p>-->

<div class="w600p left mt2">
	<xsl:for-each select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]">
	<xsl:variable name="auteur"><xsl:value-of select="sel_auteur"/></xsl:variable>
<!--Module Commentaires Variables For-each-->
	<xsl:variable name= "id_article"><xsl:value-of select= "id"/></xsl:variable>
	<xsl:variable name= "link_article"><xsl:value-of select= "text_link"/></xsl:variable><!--Ajout Nouvelle version-->
	<xsl:variable name="ag-rate"><xsl:value-of select="count(document('data_users/commentaires.xml')/Commentaires/commentaire[publication='on' and id_article=$id_article])" /></xsl:variable>
	<xsl:variable name="sum-rate"><xsl:value-of select="sum(document('data_users/commentaires.xml')/Commentaires/commentaire[publication='on' and id_article=$id_article]/note)"/></xsl:variable>
<!--FIN Module Commentaires Variables For-each-->

	<article itemscope="itemscope" itemtype="http://schema.org/Article">
	<h1 itemprop="name" class="h1_article_accueil"><i class="icon-paperclip-5 size-28 ih1home"><xsl:text> </xsl:text></i><xsl:value-of select="title"/>
	<!--<xsl:if test="youtube_embed!=''">
	<xsl:text> </xsl:text><span class="vsmaller right"><i class="icon-video size-20 i-email"><xsl:text> </xsl:text></i><a href="#video" title="Voir la vidéo">Voir la vidéo</a></span>
	</xsl:if>
	<xsl:if test="media_embed!=''">
	<xsl:text> </xsl:text><span class="vsmaller right"><i class="icon-video size-20 i-email"><xsl:text> </xsl:text></i><a href="#video2" title="Voir la vidéo">Voir la vidéo</a></span>
	</xsl:if>-->
	</h1>
	<span class="author-date">
	<span class="author">Auteur : <xsl:value-of select="document('data_xml/auteurs.xml')/Articles/article[visible='on' and text_link=$auteur]/nom"/></span>
	<xsl:if test="$ag-rate &gt; 0"> | <span class="aggregateRating" itemscope="itemscope" itemprop="aggregateRating" itemtype="http://schema.org/AggregateRating"> Note : <span itemprop="ratingValue"><xsl:value-of select="$sum-rate div $ag-rate" /></span> en <span itemprop="reviewCount"><xsl:value-of select="$ag-rate" /></span> votes</span></xsl:if>
	<span class="publication-date" itemprop="dateCreated" datetime="{concat(substring(date,7,2), '-', substring(date,5,2), '-', substring(date,1,4))}" style="margin-left:5px;">Publié le <xsl:value-of select="concat(substring(date,7,2), '/', substring(date,5,2), '/', substring(date,1,4), ' à ', substring(date,9,2), 'h', substring(date,11,2))"/></span>
	</span>

	<!--DEBUT Boutons de partage
	<div class="clear mb0"><xsl:text> </xsl:text></div>-->
	<span class="right ml1" style="display:block;height:30px;">
<a title="Partager sur Twitter" href="#" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:(function(){{window.twttr=window.twttr||{{}};var D=550,A=450,C=screen.height,B=screen.width,H=Math.round((B/2)-(D/2)),G=0,F=document,E;if(C>A){{G=Math.round((C/2)-(A/2))}}window.twttr.shareWin=window.open('http://twitter.com/share','','left='+H+',top='+G+',width='+D+',height='+A+',personalbar=0,toolbar=0,scrollbars=1,resizable=1');E=F.createElement('script');E.src='http://platform.twitter.com/bookmarklets/share.js?v=1';F.getElementsByTagName('head')[0].appendChild(E)}}());return false;"><i class="icon-twitter size-25 i-social i-twt"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Google Plus" href="https://plus.google.com/share?url={$base_url_site}article.php?article={$article}&amp;hl=fr" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=650');return false;"><i class="icon-google-plus size-25 i-social i-gplus"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Facebook" href="https://www.facebook.com/sharer.php?u={$base_url_site}article.php?article={$article}&amp;t={$title_yes}" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=500,width=700');return false;"><i class="icon-facebook size-25 i-social i-fb"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Linkedin" href="https://www.linkedin.com/shareArticle?mini=true&amp;url={$base_url_site}article.php?article={$article}&amp;title={$title_yes}" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=650');return false;"><i class="icon-linkedin-icon size-25 i-social i-ldin"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Pinterest" href="#" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:void((function(){{var e=document.createElement('script');e.setAttribute('type','text/javascript');e.setAttribute('charset','UTF-8');e.setAttribute('src','http://assets.pinterest.com/js/pinmarklet.js?r='+Math.random()*99999999);document.body.appendChild(e)}})());return false;"><i class="icon-pinterest size-25 i-social i-prst"><xsl:text> </xsl:text></i></a>

<a title="Partager par email" href="mailto:?subject={$title_yes}&amp;body={$base_url_site}article.php?article={$article}" class="bt-social-share" target="_blank" rel="nofollow"><i class="icon-email size-25 i-social i-email-s"><xsl:text> </xsl:text></i></a>
	</span>
	<div class="clear mb1"><xsl:text> </xsl:text></div>
	<!--FIN Boutons de partage-->

<span itemprop="text">
	<xsl:if test="image_embed!=''">
	<figure class="left mt1 mr2">
	  <img src="{$base_url_site_sls}{image_embed}" alt="{title} - {description}" title="{title} - {description}" width="240" height="150"/>
	  <figcaption><xsl:value-of select="image_caption"/></figcaption>
	</figure>
	</xsl:if>
	<xsl:value-of select="headline" disable-output-escaping="yes"/>	
	<div class="clear mt1"><xsl:text> </xsl:text></div>


<!--DEBUT galerie-->
<xsl:if test="$galerie_yes='on'">
		<xsl:for-each select="document($xml_galerie)/Files/file">
		<xsl:sort select="name" order="ascending" data-type="text"/>
		<xsl:variable name="path_full_img"><xsl:text>images/</xsl:text><xsl:value-of select="substring-after(fullpath,'images/')" /></xsl:variable>
		<xsl:variable name="name_img"><xsl:value-of select="substring-before(name,'.jpg')" /><xsl:text>.jpg</xsl:text></xsl:variable>
		<xsl:variable name="name_slide"><xsl:value-of select="substring-before(name,'.jpg')" /><xsl:text>-galerie-600.jpg</xsl:text></xsl:variable>
		
		<!--Lien standard vers image HD
		<a href="{$base_url_site_sls}/{$path_full_img}/{$name_img}" title="Galerie {$title_yes} {position()}" target="_blank">
		<img src="images-600/{$name_slide}" width="600" height="285" title="Galerie {$title_yes} {position()}" alt="Galerie {$title_yes} {position()}" style="margin:10px 0 10px 0;" /></a><br/>-->

<!-- Lien Light Box vers image HD -->
		<a href="#imgf{position()-'1'}" title="Galerie {$title_yes} {position()}" class="lightbox">
		<img src="images-600/{$name_slide}" width="600" height="285" title="Galerie {$title_yes} {position()}" alt="Galerie {$title_yes} {position()}" style="margin:20px 0 0 0;" onClick="document.getElementById('imgfsrc{position()-'1'}').setAttribute('src', '{$base_url_site_sls}/{$path_full_img}/{$name_img}');" /></a>
		<a href="{$base_url_site_sls}/{$path_full_img}/{$name_img}" title="Galerie {$title_yes} {position()}" target="_blank">
		Liens direct vers l'image HD "<xsl:value-of select="$title_yes"/>" n° <xsl:value-of select="position()"/></a> <br/>

<div class="lightbox-target" id="imgf{position()-'1'}">
   <img id="imgfsrc{position()-'1'}" src="images-600/{$name_slide}"/>
   <a class="lightbox-close" href="#img" title="Fermer cette image HD"><xsl:text> </xsl:text></a>
</div>

<!-- FIN Lien Light Box vers image HD -->

		</xsl:for-each>

</xsl:if>
<!--FIN galerie-->


	<!--DEBUT vidéo Youtube-->
	<xsl:if test="youtube_embed!=''">
	<a name="video"><xsl:text> </xsl:text></a><br/>
	<div class="container-youtube">
	<xsl:value-of select="youtube_embed" disable-output-escaping="yes"/>
	</div>
	</xsl:if>
	<!--FIN vidéo Youtube-->

	<!--DEBUT vidéo-->
	<xsl:if test="media_embed!=''">
	<a name="video2"><xsl:text> </xsl:text></a><br/>
	<p><object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="520" height="360" style="width:100%!important;height:auto!important;">
	<param name="movie" value="player.swf" />
	<param name="allowfullscreen" value="true" />
	<param name="allowscriptaccess" value="always" />
	<param name="flashvars" value="file={media_embed}&amp;image={image_embed}" />
	<embed style="width:100%!important;height:360px!important;"
		type="application/x-shockwave-flash"
		id="player2"
		name="player2"
		src="player.swf" 
		width="520" 
		height="360"
		allowscriptaccess="always" 
		allowfullscreen="true"
		flashvars="file={media_embed}&amp;image={image_embed}" 
	/>
	</object><br/>
	<span class="small"><a href="{media_embed}" title="{title}" target="_blank">Télécharger ou voir cette vidéo 4x4 dans votre lecteur</a></span><!---->
	</p>
	</xsl:if>
	<!--FIN vidéo-->

	<xsl:if test="body!=''">
	<xsl:value-of select="body" disable-output-escaping="yes"/><br />
	</xsl:if>

	<div class="clear pb1"><xsl:text> </xsl:text></div>
	<!--DEBUT Boutons de partage-->
<p class="pt2 pb2"><strong>Partager cet article sur : </strong>

	<span class="right">
<a title="Partager sur Twitter" href="#" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:(function(){{window.twttr=window.twttr||{{}};var D=550,A=450,C=screen.height,B=screen.width,H=Math.round((B/2)-(D/2)),G=0,F=document,E;if(C>A){{G=Math.round((C/2)-(A/2))}}window.twttr.shareWin=window.open('http://twitter.com/share','','left='+H+',top='+G+',width='+D+',height='+A+',personalbar=0,toolbar=0,scrollbars=1,resizable=1');E=F.createElement('script');E.src='http://platform.twitter.com/bookmarklets/share.js?v=1';F.getElementsByTagName('head')[0].appendChild(E)}}());return false;"><i class="icon-twitter size-25 i-social i-twt"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Google Plus" href="https://plus.google.com/share?url={$base_url_site}article.php?article={$article}&amp;hl=fr" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=650');return false;"><i class="icon-google-plus size-25 i-social i-gplus"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Facebook" href="https://www.facebook.com/sharer.php?u={$base_url_site}article.php?article={$article}&amp;t={$title_yes}" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=500,width=700');return false;"><i class="icon-facebook size-25 i-social i-fb"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Linkedin" href="https://www.linkedin.com/shareArticle?mini=true&amp;url={$base_url_site}article.php?article={$article}&amp;title={$title_yes}" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=650');return false;"><i class="icon-linkedin-icon size-25 i-social i-ldin"><xsl:text> </xsl:text></i></a>

<a title="Partager sur Pinterest" href="#" class="bt-social-share" target="_blank" rel="nofollow" onclick="javascript:void((function(){{var e=document.createElement('script');e.setAttribute('type','text/javascript');e.setAttribute('charset','UTF-8');e.setAttribute('src','http://assets.pinterest.com/js/pinmarklet.js?r='+Math.random()*99999999);document.body.appendChild(e)}})());return false;"><i class="icon-pinterest size-25 i-social i-prst"><xsl:text> </xsl:text></i></a>

<a title="Partager par email" href="mailto:?subject={$title_yes}&amp;body={$base_url_site}article.php?article={$article}" class="bt-social-share" target="_blank" rel="nofollow"><i class="icon-email size-25 i-social i-email-s"><xsl:text> </xsl:text></i></a>
	</span>
</p>
	<div class="clear mb1"><xsl:text> </xsl:text></div>
	<!--FIN Boutons de partage-->

	<p class="pt2 pb2">Lien permanent vers cet article : <a itemprop="url" href="{document('data_xml/config.xml')/Sites/site/url}article.php?article={text_link}" title="{title}"><xsl:value-of select="title"/></a></p>

	<p class="pt2 pb2"><a rel="author" href="{document('data_xml/config.xml')/Sites/site/url_google_plus_profil}" target="gp">Retrouver l'auteur sur Google+</a></p>
</span>
	<p id="keywords"><strong>Tags : </strong>
	<xsl:value-of select="$kw_fulltxt1" />, <xsl:value-of select="$kw_fulltxt2" />, <xsl:value-of select="$kw_fulltxt3" />, 
	<!--<xsl:if test="$kw1!=''"><a href="{document('data_xml/config.xml')/Sites/site/url}categorie.php?keyword={$kw1}" title="Articles sur le sujet {$kw_fulltxt1}"><xsl:value-of select="$kw_fulltxt1" /></a>, </xsl:if>
	<xsl:if test="$kw2!=''"><a href="{document('data_xml/config.xml')/Sites/site/url}categorie.php?keyword={$kw2}" title="Articles sur le sujet {$kw_fulltxt2}"><xsl:value-of select="$kw_fulltxt2" /></a>, </xsl:if>
	<xsl:if test="$kw3!=''"><a href="{document('data_xml/config.xml')/Sites/site/url}categorie.php?keyword={$kw3}" title="Articles sur le sujet {$kw_fulltxt3}"><xsl:value-of select="$kw_fulltxt3" /></a>, </xsl:if>-->

	<xsl:for-each select="document('data_xml/articles.xml')/Articles/article[visible='on' and text_link=$article]">
	<xsl:value-of select="meta_keywords" />
	</xsl:for-each>
	</p>

	<!--lien Commentaires article
	<p class="line">
	<a class="lien_commentaire" href="{document('data_xml/config.xml')/Sites/site/url}captcha/captcha_commentaires.php?id={id}&amp;text_link={text_link}&amp;title={title}" title="Commenter et noter cet article"><i class="icon-quote-11 size-28 i-comment"><xsl:text> </xsl:text></i>Commenter et noter cet article</a></p>-->
	<!--FIN lien Commentaires article-->

<!--Module Commentaires code bas article
	<p class="mt2 mb1">Les commentaires pour cet article</p>
	<xsl:for-each select="document('data_users/commentaires.xml')/Commentaires/commentaire[publication='on' and id_article=$id_article]">
	<div itemprop="review" itemscope="itemscope" itemtype="http://schema.org/Review">
	<meta itemprop="name" content="{prenom} {nom}" />
	<h3>
	<span itemprop="author">
	<xsl:value-of select="prenom" /><xsl:text> </xsl:text><xsl:value-of select="nom" /> 
	</span>
	<xsl:if test="site!=''"><xsl:text> </xsl:text>
	<a href="{site}" title="site ou profil de {prenom} {nom}" target="_blank" class="smaller">Site</a>
	</xsl:if>
	<span class="smaller"><xsl:text> </xsl:text><xsl:value-of select="ville" /><xsl:text> </xsl:text><xsl:value-of select="pays" /></span>
	<meta itemprop="datePublished" content="{substring(date,7,2)}-{substring(date,5,2)}-{substring(date,1,4)}"/>
	<div itemscope="itemscope" itemprop="reviewRating" itemtype="http://schema.org/Rating" class="right vsmaller reviewrate">
	<meta itemprop="worstRating" content="1"/>
	Note pour l'article : <span itemprop="ratingValue"><xsl:value-of select="note"/></span> sur <span itemprop="bestRating">5</span>
	</div>
	</h3>
	<span itemprop="description"><xsl:value-of select="comment" disable-output-escaping="yes"/></span>
	<span class="date">Le : <xsl:value-of select="concat(substring(date,7,2), '/', substring(date,5,2), '/', substring(date,1,4), ' à ', substring(date,9,2), 'h', substring(date,11,2))"/>
	</span>
	</div><hr />
	</xsl:for-each>-->
<!--FIN Module Commentaires code bas article-->

	</article>
	</xsl:for-each>


</div>

<!--FIN Corps articles standards-->


<!--FIN Content-->


<!--Bloc newsletter et bt sociaux-->
        <!-- Appel au template navigation droite sans liens blogs -->
	<xsl:call-template name="nav_left_social_article"/>
        <!-- FIN Appel au template navigation droite sans liens blogs -->
<!--FIN Bloc newsletter et bt sociaux-->

</div>


<div class="mod center mw960p page-nav">

        <!-- Appel au template Pages Nav -->
	<xsl:call-template name="page-nav"/>
        <!-- FIN Appel au template Pages Nav -->

</div>
<!--FIN Main : Content - Nav-->

<!--DEBUT Footer -->
	<footer class="line mod">
        <!-- Appel au template Footer -->
	<xsl:call-template name="footer"/>
        <!-- FIN Appel au template Footer -->
	</footer>
<!--FIN Footer -->



</body>
</html>


</xsl:template> 
</xsl:stylesheet>