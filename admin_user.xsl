<?xml version="1.0" encoding="iso-8859-1"?>
	<!DOCTYPE xsl:stylesheet >
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:php="http://php.net/xsl"
	exclude-result-prefixes="xsl php"
	version="1.0">

  <xsl:output 
	indent="yes"
	method="xml" 
	omit-xml-declaration="yes"
	encoding="ISO-8859-1" />

<!--Paramêtre transmis à la feuille xslt-->
	<xsl:param name="text_link" />
	<xsl:variable name="path_images"><xsl:value-of select="document('data_xml/config.xml')/Sites/site/url" /></xsl:variable>

	<!--<xsl:variable name="xpathurlxmluser"><xsl:value-of select="$path_images"/><xsl:value-of select="$text_link"/><xsl:text>.php</xsl:text></xsl:variable>-->

<!--Base de l'URL du site-->
	<xsl:variable name="base_url_site"><xsl:value-of select="document('data_xml/config.xml')/Sites/site/url" /></xsl:variable>

<!--Résolution du chemin des fichier utilisateurs-->
	<xsl:variable name="xpathurlfilesuser"><xsl:value-of select="$base_url_site"/><xsl:text>lister-fichiers-galeries-xml.php?galerie_dir_file=</xsl:text><xsl:value-of select="$text_link"/></xsl:variable>

<!-- Taille totale des fichiers utilisateurs -->
	<xsl:variable name="file-size-totale">
	<xsl:for-each select="document($xpathurlfilesuser)/Files"><xsl:value-of select="format-number(sum(//size) div '1024' div '1024', '0.00')"/></xsl:for-each>
	</xsl:variable>



	<!-- Date et temps actuel pour empêcher la mise en cache des images -->
<xsl:param name="date_now" />

<xsl:template match="/"> 

	<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;</xsl:text>
	<html lang="fr">
	<head>
<!-- METAs -->
	<meta charset="ISO-8859-1" />
	<title>
	Création de la Galerie pour "<xsl:value-of select="$text_link"/>"
	</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<!--FIN METAs -->
<!-- CSS RSS et JS -->

	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<style>
	body {
	padding-top: 40px; /* 60px to make the container go all the way to the bottom of the topbar */
	}
	.black {
	background-color: #1E1E1E;
	-webkit-box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.35);
	-moz-box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.35);
	box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.35);
	}
	</style>
	<link href="assets/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="assets/css/docs.css" rel="stylesheet" type="text/css"/>
	<link href="assets/js/google-code-prettify/prettify.css" rel="stylesheet" type="text/css"/>

	<link href="assets/css/custom.min.css" rel="stylesheet" type="text/css"/>
	<link href="assets/css/gest-files-xslt.css" rel="stylesheet" type="text/css" />






	<!-- Plupload -->
	<link rel="stylesheet" href="assets/css/style.css" media="screen"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"><xsl:text> </xsl:text></script>
	<script src="assets/js/plupload.full.js"><xsl:text> </xsl:text></script>
	<script src="assets/js/jquery-progressbar.min.js"><xsl:text> </xsl:text></script>

	<script>
		// Upload Form
		$(function() {
			// Settings ////////////////////////////////////////////////
			var uploader = new plupload.Uploader({
				runtimes : 'html5,flash,silverlight', // Set runtimes, here it will use HTML5, if not supported will use flash, etc.
				browse_button : 'pickfiles', // The id on the select files button
				multi_selection: true, // Allow to select one file each time
				container : 'uploader', // The id of the upload form container
				max_file_size : '10mb', // Maximum file size allowed
				chunk_size : '1mb',
				url : 'upload.php?text_link=<xsl:value-of select="$text_link"/>', // The url to the upload.php file
				flash_swf_url : 'assets/js/plupload.flash.swf', // The url to thye flash file
				silverlight_xap_url : 'assets/js/plupload.silverlight.xap', // The url to the silverlight file
				filters : [ 
				{title : "Image files", extensions : "jpg"}
				 ],
				// redimmensionner la hauteur avec par ex : height : 800, 
				resize : {width : 1280, quality : 95}
				// Filter the files that will be showed on the select files window
			});

			// RUNTIME
			uploader.bind('Init', function(up, params) {
				$('#runtime').text(params.runtime);
			});

			// Start Upload ////////////////////////////////////////////
			// When the button with the id "#uploadfiles" is clicked the upload will start
			$('#uploadfiles').click(function(e) {
				uploader.start();
				e.preventDefault();
			});

			uploader.init(); // Initializes the Uploader instance and adds internal event listeners.

			// Selected Files //////////////////////////////////////////
			// When the user select a file it wiil append one div with the class "addedFile" and a unique id to the "#filelist" div.
			// This appended div will contain the file name and a remove button
			uploader.bind('FilesAdded', function(up, files) {
				$.each(files, function(i, file) {
					$('#filelist').append('<div class="addedFile" id="' + file.id + '">' + file.name + '<a href="#" id="' + file.id + '" class="removeFile"></a>' + '</div>');
				});
				up.refresh(); // Reposition Flash/Silverlight
			});

			// Error Alert /////////////////////////////////////////////
			// If an error occurs an alert window will popup with the error code and error message.
			// Ex: when a user adds a file with now allowed extension
			uploader.bind('Error', function(up, err) {
				alert("Error: " + err.code + ", Message: " + err.message + (err.file ? ", File: " + err.file.name : "") + "");
				up.refresh(); // Reposition Flash/Silverlight
			});

			// Remove file button //////////////////////////////////////
			// On click remove the file from the queue
			$('a.removeFile').live('click', function(e) {
				uploader.removeFile(uploader.getFile(this.id));
				$('#'+this.id).remove();
				e.preventDefault();
			});

			// Progress bar ////////////////////////////////////////////
			// Add the progress bar when the upload starts
			// Append the tooltip with the current percentage
			uploader.bind('UploadProgress', function(up, file) {
				var progressBarValue = up.total.percent;
				$('#progressbar').fadeIn().progressbar({
					value: progressBarValue
				});
				$('#progressbar .ui-progressbar-value').html('<span class="progressTooltip">' + up.total.percent + '%</span>');
			});

			// Close window after upload ///////////////////////////////
			// If checkbox is checked when the upload is complete it will close the window
			uploader.bind('UploadComplete', function() {
				if ($('.upload-form #checkbox').attr('checked')) {
					$('.upload-form').fadeOut('slow');
				}
			});

			// affichage du div vos fichiers sont uploadés ///////////////////////////////
			uploader.bind('UploadComplete', function()  {
					$('.upload-ok').fadeIn('slow');
					$('.info').fadeOut('slow');
			});



			// Recharger la page après upload ///////////////////////////////
			uploader.bind('UploadComplete', function()  {
					$("#reload-page").submit();
			});

			// Close window ////////////////////////////////////////////
			// When the close button is clicked close the window
			$('.upload-form .closeup').on('click', function(e) {
				$('.upload-form').fadeOut('slow');
				e.preventDefault();
			});



		}); // end of the upload form configuration

		// Check Box Styling
		$(document).ready(function() {

			var checkbox = $('.upload-form span.checkbox');

			// Check if JavaScript is enabled
			$('body').addClass('js');

			// Make the checkbox unchecked on load (checkbox.addClass et 'checked', true pour remettre)
			checkbox.removeClass('checked').children('input').attr('checked', false);

			// Click function
			checkbox.on('click', function() {

				if ($(this).children('input').attr('checked')) {
					$(this).children('input').attr('checked', false);
					$(this).removeClass('checked');
				}

				else {
					$(this).children('input').attr('checked', true);
					$(this).addClass('checked');
				}
			
			});

		});
	</script>

<!--Redimensionner l'iframe-->




	<!-- Preview Styles -->
	<style type="text/css">

.showfiles {
	/* [disabled]color: #249D9D; */
	/* [disabled]font-size: 12px; */
	/* [disabled]font-weight: normal; */
}
		#uploader {
	margin: 0 auto;
}
		.info {
	text-align: center;
	padding: 20px 0;
	color: #666;
	font-family: Helvetica, Arial, sans-serif;
}
.upload-ok {
	text-align: left;
	padding: 10px 0;
	color: #666;
	font-family: Helvetica, Arial, sans-serif;
}
		#runtime { text-transform: uppercase; }
		.info span {
	color: #0CC;
}
	#iframe {
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	margin: 0px;
	padding: 0px;
	height: 480px;
	width: 100%;
}
    .upload-ok h2 {
	/* [disabled]font-size: 16px; */
	/* [disabled]color: #999; */
}
    #delmembre {
	margin: 0px;
	padding:0px;
}
    </style>



<!--FIN RSS et JS -->

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
	<xsl:comment><![CDATA[[if IE]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]]]></xsl:comment>
<!--FIN Création des éléments HTML et des css pour IE -->
<!-- Touch icons -->
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png"/>
<!-- Fin touch icons -->
</head>
<body>



<!--header-->

	<!--Formulaire pour le reload après upload de fichier-->
	<form name="reload-page" id="reload-page" style="display: none;" action="admin_user.php?text_link=" method="GET">
	<input type="hidden" id="text_link" name="text_link" value="{$text_link}" />
	</form>

<div class="container">

	<div class="container"><!--Fin span7--><!--/span-->
	<div class=" upload-form" id="uploader">

	<!--Test des variables Désactivés

	<xsl:value-of select="$xpathurlxmluser" /><br/>
	<xsl:value-of select="$xpathurlfilesuser" /><br/>
	-->

	<!-- Form Heading --><!-- Infos sur les fichiers du membre -->

		<a href="javascript:window.close();" class="btn btn-info btn-small pull-right " style="" title="Voir ce fichier">Fermer cette fenêtre</a>
	<h2><span class="label label-success">jpeg</span><xsl:text> </xsl:text><span class="label label-warning">10Mo max./fichier</span></h2>



	<!-- Select & Upload Button -->

		<div class="btn-group pull-left">
		<h6>Envoyez vos images pour cette galerie</h6>


		<button class="btn btn-large" id="pickfiles" href="#">Choisir</button>
		<button class="btn btn-large" id="uploadfiles" href="#">Envoi</button>
		</div>
		<div class="btn-group pull-right">
		
	<h6>
	Vous avez <xsl:value-of select="count(document($xpathurlfilesuser)/Files/file)"/> images en ligne dans cette galerie<br/> 
	</h6>
		</div>
		

	<!-- File List -->
	<div id="filelist" class="cb"><xsl:text> </xsl:text></div>

	<!-- Progress Bar -->
	<div id="progressbar"><xsl:text> </xsl:text></div>

	<!-- Close After Upload
	<div id="closeAfter">
		<span class="checkbox">
			<input type="checkbox" name="checkbox" id="checkbox"/>
			<label for="checkbox">Fermer la fenêtre après l'envoi</label>
		</span>
	</div> -->
</div>
<!-- Boite d'affichage et de gestion des fichiers utilisateurs -->
<div class="container upload-ok"><h2>Fichiers de la galerie "<xsl:value-of select="$text_link"/>"</h2>

<br/>
	<ul class="ulf">
	<xsl:for-each select="document($xpathurlfilesuser)/Files/file">
	<xsl:sort select="date" order="ascending"/>
	<li class="lif">

	<xsl:variable name="size-mo"><xsl:value-of select="size div '1024' div '1024'"/></xsl:variable>

	<form name="delmembre" id="delmembre" method="GET" action="delete-file-galerie.php" onclick="return(confirm('Etes-vous sûr de vouloir supprimer cette entrée?'));">
	<input type="hidden" name="nom" id="nom" value="{name}" />
	<input type="hidden" name="text_link" id="text_link" value="{$text_link}" />
	<button type="submit" class="btn btn-danger btn-large pull-right" title="Supprimer ce fichier"><i class="icon-remove icon-white"><xsl:text> </xsl:text></i></button>
	</form>

	<a href="{$text_link}/{name}" target="_blank" class="btn btn-success btn-large pull-right " style="margin:0 10px 0 0;" title="Voir ce fichier">
	<i class="icon-play icon-white" style="padding:1px 0 1px 0"><xsl:text> </xsl:text></i>
	</a>

	<xsl:if test="contains(name, '.jpg') or contains(name, '.JPG') or contains(name, '.gif') or contains(name, '.png')">
	<img src="thumb.php?src={$text_link}/{name}&amp;w=47&amp;h=37&amp;zc=1" height="37" class="pull-right imglistefile" alt="$lien" style="margin:0 10px 0 10px"/>
	</xsl:if>

	<xsl:if test="contains(name, '.jpg') or contains(name, '.JPG') or contains(name, '.gif') or contains(name, '.png')">
	<i class="icon-camera" style="margin:2px 5px 0 0;"><xsl:text> </xsl:text></i>
	</xsl:if>
	<xsl:if test="contains(name, '.mp3') or contains(name, '.MP3')">
	<i class="icon-music" style="margin:2px 5px 0 0;"><xsl:text> </xsl:text></i>
	</xsl:if>

	<strong><xsl:value-of select="name"/></strong><xsl:text> </xsl:text><br/><span class="label label-info"><xsl:value-of select="format-number($size-mo, '0.00')"/>Mo</span>

	</li>
	</xsl:for-each>
	</ul>



</div>

     </div><!--/row-->

     <!-- /container -->
<!-- Footer -->


</div><!--div baladeur???-->



</body>

</html>


</xsl:template> 

</xsl:stylesheet>