<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      xmlns:xtm="http://www.topicmaps.org/xtm/"
      xmlns:xtf="http://cdlib.org/xtf" xmlns="http://www.w3.org/1999/xhtml"
      version="2.0"
      xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    

    <xsl:import href="../dynaXML/docFormatter/dh-abstracts/xslt/tei2html-docinfo.xsl"/>
    <xsl:param name="crossqueryPath" select="if (matches($servlet.path, 'org.cdlib.xtf.dynaXML.DynaXML')) then 'org.cdlib.xtf.crossQuery.CrossQuery' else 'search'"/>
    <!-- xmlSourcePath is used in tei2html-docinfo.xsl, so needs to be declared here. -->
    <xsl:param name="root.path"/>
    <xsl:param name="servlet.path"/>
    <xsl:param name="xtfURL" select="$root.path"/>
    
    <xsl:param name="imagePath"/>
    <!--
    <xsl:param name="xmlSourcePath" as="xs:string" select="'http://www.purl.org/swinburnearchive/source/xml/'"/>
    -->
    <xsl:param name="cssFile" as="xs:string"
    select="concat($xtfURL, 'css/dh-abstracts/dh-abstracts2html.css')"/>
    <xsl:param name="cssExtAll" as="xs:string" select="concat($xtfURL,'/js/swinburne/ext-3.2.1/resources/css/ext-all.css')"/>
    <xsl:param name="cssExtTheme" as="xs:string" select="'http://brie.dlib.indiana.edu:8080/metsnav3service/css/ext-themes/css/xtheme-gray.css'"/>
    <xsl:param name="cssPrintFile" as="xs:string"
        select="concat($xtfURL, 'css/swinburne/swinburne2html-print.css')"/>
    <xsl:param name="jsFile" as="xs:string" select="concat($xtfURL, 'js/swinburne/tei2html.js')"/>
    <xsl:param name="jsExtBase" as="xs:string" select="concat($xtfURL,'/js/swinburne/ext-3.2.1/adapter/ext/ext-base.js')"/>
    <xsl:param name="jsExtAll" as="xs:string" select="concat($xtfURL,'/js/swinburne/ext-3.2.1/ext-all.js')"/>
    <xsl:param name="jsMetsNavAll" as="xs:string" select="concat($xtfURL,'metsnav/js/metsnav/metsnav-all.js')"/>
    <xsl:param name="jsMetsNavSwinburne" as="xs:string" select="concat($xtfURL,'metsnav/js/metsnav/metsnav-swinburne.js')"/>
   <!-- <xsl:param name="jsMetsNavAll" as="xs:string" select="'http://brie.dlib.indiana.edu:8080/metsnav3service/js/metsnav/metsnav-all.js'"/> -->
    <!-- metsnav service for new metsnav.TreeDocumentBrowser invocation -->
    <xsl:param name="jsonp" as="xs:string" select="'http://brie.dlib.indiana.edu:8080/metsnav3service/rest/jsonp'"/>
    <xsl:param name="standalone" as="xs:boolean" select="false()"/>
    <xsl:param name="apos"><xsl:value-of><text>'</text></xsl:value-of></xsl:param>
    <xsl:param name="quot"><xsl:value-of><text>"</text></xsl:value-of></xsl:param>
    <xsl:param name="template" select="'swinburne/acs0000000-00.xml'"/>
    <xsl:param name="dynaxmlPath" select="if (matches($servlet.path, 'org.cdlib.xtf.crossQuery.CrossQuery')) then 'org.cdlib.xtf.dynaXML.DynaXML' else 'view'"/>
    
    <xsl:param name="metsnav-viewer" select="concat($xtfURL,'metsnav/viewer.html')"/>
    <xsl:param name="xmlSourcePath"/>
    
    
    
    <xsl:param name="mets-location" select="'http://ella.slis.indiana.edu/~jawalsh/swinburne/mets/'"/>
    <!-- <xsl:param name="mets-location" select="concat($xtfURL,'mets/swinburne/')"/> -->
    
    <xsl:param name="fax-thumbnail-location" select="'http://purl.dlib.indiana.edu/iudl/swinburne/thumbnail/'"/>
    <xsl:param name="lt"><xsl:value-of><text>&lt;</text></xsl:value-of></xsl:param>
    
    <xsl:template name="getXtmName">
        <xsl:param name="target"/>
        <xsl:param name="scope"/>
    </xsl:template>
    
    <xsl:template name="banner">
        <div id="banner">
            <div id="bannerGraphic">
                <img alt="ADHO: Alliance of Digital Humanities Organizations">
                    <xsl:attribute name="src"
                        select="concat($imagePath,'banner_portrait.png')"/>
                </img>
            </div>
            <div id="bannerSubNav">
                <div class="searchBox">
                    <form method="get" id="searchform" action="{$xtfURL}{$crossqueryPath}">
                        <div>
                            <input class="query" type="text"
                                value="Search: enter term, hit return"
                                onfocus="clearDefaultValue(this , 'Search: enter term, hit return')"
                                onblur="addDefaultValue(this , 'Search: enter term, hit return')"
                                name="keyword" id="s"/>
                        </div>
                    </form>
                </div>
                <!-- <div id="navItem-info"> Project Information </div> -->
                <div id="navItem-help"> Help </div>
            </div>
            <div id="bannerNav">
                <div id="navItem-home">
                    <a>
                        <xsl:attribute name="href" select="$xtfURL"/>
                        home
                    </a>
                </div>
                <div id="navItem-browse">
                    <a>
                        <xsl:attribute name="href" select="concat($xtfURL,'search?smode=browse')"/>
                        browse
                    </a>
                </div>
                <div id="navItem-search">
                    <a>
                        <xsl:attribute name="href" select="concat($xtfURL,'search')"/>
                        search
                    </a>
                </div>
                <!--
                    <div id="navItem-about">
                    <a href="">
                    <img alt="about" src="about_hw.png" />
                    </a>
                    </div>
                -->
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="footer">
        <div id="footer">
       <!--     Last Updated: 31 August 2009
            URL: [web app URL]<br/>             -->           
            Comments: <a href="mailto:jawalsh@indiana.edu">jawalsh@indiana.edu</a><br/> 
            Published by Indiana University <a href="http://www.indiana.edu/~idah/">Institute for Digital Arts and Humanities</a> &amp; <a href="http://dlib.indiana.edu">Digital Library Program</a><br/>
            
        </div>
    </xsl:template>
    
    
    <xsl:template name="htmlHead">
        <xsl:param name="headTitle">
            
        </xsl:param>
        <head>
            <title>
                <xsl:value-of select="$headTitle"/>
            </title>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <script type="text/javascript">
		function clearDefaultValue ( object, defaultText ) {
			if( object.value == defaultText ) {
			object.value = '';
			}
		}

		function addDefaultValue ( object, defaultText ) {
			if( object.value == '' ) {
				object.value = defaultText;
			}
		}

            </script> 
            <script src="script/yui/yahoo-dom-event.js" type="text/javascript"/> 
            <script src="script/yui/connection-min.js" type="text/javascript"/> 
            
            <xsl:if test="$jsFile != ''">
                <xsl:choose>
                    <xsl:when test="$standalone = true()">
                        <!-- embedding js isn't working -->
                        <script type="text/javascript" src="{$jsFile}">
                            <xsl:comment> //IE doesn't like empty script tag. </xsl:comment>
                        </script>
                        <!--
                            <script type="text/javascript">
                            <xsl:comment>
                            <xsl:text>
                            </xsl:text>
                            <xsl:value-of select="unparsed-text($jsFile)"/>
                            </xsl:comment>
                            </script>
                        -->
                    </xsl:when>
                    <xsl:otherwise>
                        <script type="text/javascript" src="{$jsFile}">
                            <xsl:comment> //IE doesn't like empty script tag. </xsl:comment>
                        </script>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:copy-of select="$brand.links"/>
            <!--
            <xsl:if test="$cssFile != ''">
                <xsl:choose>
                    <xsl:when test="$standalone = true()">
                        <style type="text/css">
                            <xsl:value-of select="unparsed-text($cssFile)"/>
                        </style>
                    </xsl:when>
                    <xsl:otherwise>
                        <link rel="stylesheet" type="text/css">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$cssFile"/>
                            </xsl:attribute>
                        </link>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="$cssPrintFile != ''">
                <xsl:choose>
                    <xsl:when test="$standalone = true()">
                        <style type="text/css" media="print">
                            <xsl:value-of select="unparsed-text($cssPrintFile)"/>
                        </style>
                    </xsl:when>
                    <xsl:otherwise>
                        <link rel="stylesheet" type="text/css" media="print">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$cssPrintFile"/>
                            </xsl:attribute>
                        </link>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            -->
           
            <!-- For XTF Ajax Support -->
        </head>
    </xsl:template>
    
    
    
    <xsl:template name="fax-thumbnail-link">
        <xsl:param name="page-id"/>
        <xsl:param name="mets-file" select="concat(substring($page-id,1,13),'.mets.xml')"/>
        <xsl:param name="page">
            <xsl:call-template name="getPage">
                <xsl:with-param name="page-id" select="$page-id"/>
            </xsl:call-template>
        </xsl:param>
        <xsl:param name="metsnav-url" select="concat($metsnav-viewer,'#mets=',$mets-location,$mets-file,'&amp;page=',$page)"/>
        <xsl:if test="$page != 'dummy'">
        <div class="fax-thumbnail-link">
            <a alt="view page image(s)">
                <xsl:attribute name="onclick" select="concat('newwin = window.open(',$quot,$metsnav-url,$quot,',',$quot,'metsnav',$quot,',',$quot,'resizable=1,height=700,width=1100',$quot,'); newwin.focus()')"/>
                <img class="thumbnail">
                    <xsl:attribute name="src">
                        <xsl:value-of select="concat($fax-thumbnail-location,$page-id)"/>
                    </xsl:attribute>
                </img>
            </a>
        </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="getPage">
        <xsl:param name="page-id"/>
        <xsl:choose>
            <xsl:when test="contains($page-id,'-')">
                <xsl:call-template name="getPage">
                    <xsl:with-param name="page-id" select="substring-after($page-id,'-')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="substring($page-id,1,1) = '0'">
                <xsl:call-template name="getPage">
                    <xsl:with-param name="page-id" select="substring-after($page-id,'0')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$page-id"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="header">
        <div class="header">
            <!--
                <img src="icons/default/xtf_logo.gif" width="302" height="18" alt="eXtensible Text Framework" class="xtf-logo"/>
            -->
            <div class="headerTitle">Digital Humanities Abstracts
                <div class="nav">
                    <a href="{concat($xtfURL,'search')}">home</a>&#160;|&#160;<a href="{concat($xtfURL,'search?smode=browse')}">browse</a>
                </div>
            </div>
            <!-- <img src="icons/default/your_logo.gif" width="100" height="40" alt="graphic" class="your-logo" /> -->
            <div class="searchBox">
                <form method="get" id="searchform" action="{$xtfURL}{$crossqueryPath}">
                    <div>
                        <input class="query" type="text"
                            value="Search: enter term, hit return"
                            onfocus="clearDefaultValue(this , 'Search: enter term, hit return')"
                            onblur="addDefaultValue(this , 'Search: enter term, hit return')"
                            name="keyword" id="s"/>
                    </div>
                </form>
            </div>
            <br class="clear" />
        </div>
    </xsl:template>
    

</xsl:stylesheet>
