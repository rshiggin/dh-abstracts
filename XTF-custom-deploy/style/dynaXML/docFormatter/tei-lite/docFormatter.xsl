<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- dynaXML Stylesheet                                                     -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!--
   Copyright (c) 2005, Regents of the University of California
   All rights reserved.
 
   Redistribution and use in source and binary forms, with or without 
   modification, are permitted provided that the following conditions are 
   met:

   - Redistributions of source code must retain the above copyright notice, 
     this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright 
     notice, this list of conditions and the following disclaimer in the 
     documentation and/or other materials provided with the distribution.
   - Neither the name of the University of California nor the names of its
     contributors may be used to endorse or promote products derived from 
     this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
   POSSIBILITY OF SUCH DAMAGE.
-->

<xsl:stylesheet version="2.0"
				xmlns="http://www.w3.org/1999/xhtml"
                xmlns:none="http://www.dlib.indiana.edu"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xtf="http://cdlib.org/xtf"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:session="java:org.cdlib.xtf.xslt.Session"
                exclude-result-prefixes="xtf">

<!-- ====================================================================== -->
<!-- Import Common Templates                                                -->
<!-- ====================================================================== -->

<xsl:import href="/opt/etext/common/XTF-latest/style/dynaXML/docFormatter/common/docFormatterCommon.xsl"/>
<xsl:import href="docFormatterCommon.xsl"/>

<!-- ======================================================================
	 indent="no" is required:
	 indent set to "no" on xsl:output so text strings that 
	 receive internal rendering (ex. L<hi rend="sc">EWIS</hi>) do not end up
	 rendering in the browser with extra space before the internal tag
====================================================================== -->  
<xsl:output method="xhtml"
            indent="no"
            encoding="utf-8"
            media-type="text/html"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  
<!-- ====================================================================== -->
<!-- Strip Space                                                            -->
<!-- ====================================================================== -->

<xsl:strip-space elements="*"/>

<!-- ====================================================================== -->
<!-- Included Stylesheets                                                   -->
<!-- ====================================================================== -->

<xsl:include href="autotoc.xsl"/>
<xsl:include href="component.xsl"/>
<xsl:include href="search.xsl"/>
<xsl:include href="parameter.xsl"/>
<xsl:include href="structure.xsl"/>
<xsl:include href="table.xsl"/>
<xsl:include href="titlepage.xsl"/>


<xsl:param name="brand" select="'general'"/>
  <xsl:param name="text1"/>
  <xsl:param name="text2"/>
  <xsl:param name="text3"/>
  <xsl:param name="field1"/>
  <xsl:param name="field2"/>
  <xsl:param name="field3"/>
  <xsl:param name="op1"/>
  <xsl:param name="op2"/>
  <xsl:param name="freeformQuery"/>
  
  <xsl:param name="fromMonth"/>
  <xsl:param name="fromYear"/>
  <xsl:param name="toMonth"/>
  <xsl:param name="toYear"/>   

<xsl:param name="query">
  <xsl:if test="$text1"><xsl:value-of select="concat('&amp;text1=', $text1)"/></xsl:if>
  <xsl:if test="$text2"><xsl:value-of select="concat('&amp;text2=', $text2)"/></xsl:if>
  <xsl:if test="$text3"><xsl:value-of select="concat('&amp;text3=', $text3)"/></xsl:if>
  <xsl:if test="$op1"><xsl:value-of select="concat('&amp;op1=', $op1)"/></xsl:if>
  <xsl:if test="$op2"><xsl:value-of select="concat('&amp;op2=', $op2)"/></xsl:if>
  <xsl:if test="$field1"><xsl:value-of select="concat('&amp;field1=', $field1)"/></xsl:if>
  <xsl:if test="$field2"><xsl:value-of select="concat('&amp;field2=', $field2)"/></xsl:if>
  <xsl:if test="$field3"><xsl:value-of select="concat('&amp;field3=', $field3)"/></xsl:if>
  <xsl:if test="$freeformQuery"><xsl:value-of select="concat('&amp;freeformQuery=', $freeformQuery)"/></xsl:if>
</xsl:param>

<xsl:param name="queryText">
  <xsl:call-template name="queryString"/>
</xsl:param>  

<xsl:param name="idno">
  <xsl:value-of select="/TEI.2/teiHeader/fileDesc/publicationStmt/idno"></xsl:value-of>
</xsl:param>
  
  <xsl:param name="pageImageBrand"/>
  <xsl:param name="brandName"/>
  
  <xsl:param name="pageImageId-length"/>
  <xsl:param name="pageImageId-page"/>
  
  
  <xsl:param name="hasPageImage">
    <xsl:choose>
      <xsl:when test="//*[matches(name(), '^note') and @*:id = 'noPageImages']">
        <xsl:text>no</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>yes</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="encyclopedia">
  	<xsl:choose>
  		<xsl:when test="contains($docId, 'encyclopedia/')">
  			<xsl:text>yes</xsl:text>
  		</xsl:when>
  		<xsl:otherwise>
  			<xsl:text>no</xsl:text>
  		</xsl:otherwise>
  	</xsl:choose>
  </xsl:param>
  
  <xsl:param name="inauthorsPURL">
    <xsl:choose>
        <xsl:when test="$encyclopedia='yes'">
        	<xsl:text>http://purl.dlib.indiana.edu/iudl/</xsl:text><xsl:value-of select="$pageImageBrand"/><xsl:text>/encyclopedia/</xsl:text><xsl:value-of select="$idno"/>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:text>http://purl.dlib.indiana.edu/iudl/</xsl:text><xsl:value-of select="$pageImageBrand"/><xsl:text>/</xsl:text><xsl:value-of select="$idno"/>
    	</xsl:otherwise>
  	</xsl:choose>
  </xsl:param>

<!-- ====================================================================== -->
<!-- Define Keys                                                            -->
<!-- ====================================================================== -->

  <xsl:key name="pb-id" match="*[matches(name(),'^pb$|^milestone$')]" use="@*[matches(local-name(),'^id')]"/>
  <xsl:key name="ref-id" match="*[matches(name(),'^ref$')]" use="@*[local-name()='id']"/>
  <xsl:key name="fnote-id" match="*[matches(name(),'^note$')][@type='footnote' or @place='foot']" use="@*[local-name()='id']"/>
  <xsl:key name="endnote-id" match="*[matches(name(),'^note$')][@type='endnote' or @place='end']" use="@*[local-name()='id']"/>
  <xsl:key name="div-id" match="*[matches(name(),'^div')]" use="@*[local-name()='id']"/>
  <xsl:key name="generic-id" match="*[matches(name(),'^note$')][not(@type='footnote' or @place='foot' or @type='endnote' or @place='end')]|*[matches(name(),'^figure$|^bibl$|^table$')]" use="@*[local-name()='id']"/>
  <xsl:key name="note-id" match="note" use="@*[local-name()='id']"/>
  

<!--  <xsl:key name="pb-id" match="pb|milestone" use="@id"/>
  <xsl:key name="ref-id" match="ref" use="@id"/>
  <xsl:key name="formula-id" match="formula" use="@id"/>
  <xsl:key name="fnote-id" match="note[@type='footnote' or @place='foot']" use="@id"/>
  <xsl:key name="endnote-id" match="note[@type='endnote' or @place='end']" use="@id"/>
  <xsl:key name="div-id" match="*[matches(name(),'^div')]" use="@*[local-name()='id']"/>
  <xsl:key name="hit-num-dynamic" match="xtf:hit" use="@hitNum"/>
  <xsl:key name="hit-rank-dynamic" match="xtf:hit" use="@rank"/>
  <xsl:key name="generic-id" match="note[not(@type='footnote' or @place='foot' or @type='endnote' or @place='end')]|figure|bibl|table" use="@id"/>-->

  <!-- ====================================================================== -->
  <!-- TEI.2-specific parameters                                                -->
  <!-- ====================================================================== -->
  
  <!-- If a query was specified but no particular hit rank, jump to the first hit 
    (in document order) 
  -->
  <xsl:param name="hit.rank">
    <xsl:choose>
      <xsl:when test="$query and not($query = '')">
        <xsl:value-of select="key('hit-num-dynamic', '1')/@rank"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'0'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="hit.num">
    <xsl:choose>
      <xsl:when test="$query and not($query = '')">
        <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/@hitNum"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'0'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="image.id">
    <xsl:value-of select="'0'"/>
  </xsl:param>
  
  <xsl:param name="chunk.id">
    <xsl:choose>
      <xsl:when test="$hit.rank != '0' and $doc.view !='pagedImage' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
        <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(local-name(),'^div')][1]/@*:id"/>
      </xsl:when>
      <xsl:when test="$doc.view ='pagedImage' and $image.id !='0'">
        <xsl:choose>
          <xsl:when test="key('pb-id', $image.id)/ancestor::*[matches(local-name(),'^front')]">
            <xsl:value-of select="'0'"/>
          </xsl:when>
          <xsl:when test="key('pb-id', $image.id)/following-sibling::*[matches(local-name(),'^div')]">
            <xsl:value-of select="key('pb-id', $image.id)/following-sibling::*[matches(local-name(),'^div')][1]/@*:id"/>    
          </xsl:when>
          <xsl:when test="key('pb-id', $image.id)/preceding::*[matches(local-name(),'^div')]">
            <xsl:value-of select="key('pb-id', $image.id)/ancestor::*[matches(local-name(),'^div')][1]/@*:id"/>    
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="key('pb-id', $image.id)/descendant::*[matches(local-name(),'^div')][1]/@*:id"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'0'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="toc.id">
    <xsl:choose>
      <xsl:when test="$hit.rank != '0' and $doc.view !='pagedImage' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
        <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(local-name(),'^div')][1]/parent::*/@*:id"/>
      </xsl:when>
      <xsl:when test="$doc.view ='pagedImage' and $image.id !='0'">
        <xsl:choose>
          <xsl:when test="key('div-id',$chunk.id)/ancestor::*[matches(local-name(),'^div')]">
            <xsl:value-of select="key('div-id',$chunk.id)/ancestor::*[matches(local-name(),'^div')][1]/@*:id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'0'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'0'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="this.image.id">
    <xsl:choose>
      <xsl:when test="$chunk.id != '0' and $image.id ='0'">
        <xsl:choose>
          <!--For some reason we were checking preceding sibling before sibling, but was commented out 
          to fix INA-110. If this breaks something we'll have to dig deeper-->
          <!--<xsl:when test="key('div-id', $chunk.id)/preceding-sibling::*[matches(local-name(),'^pb')]">
            <xsl:value-of select="key('div-id', $chunk.id)/preceding-sibling::*[matches(local-name(),'^pb')][1]/@*:id"/>    
          </xsl:when>-->
          <xsl:when test="key('div-id', $chunk.id)/preceding::*[matches(local-name(),'^pb')]">
            <xsl:value-of select="key('div-id', $chunk.id)/preceding::*[matches(local-name(),'^pb')][1]/@*:id"/>    
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="key('div-id', $chunk.id)/ancestor::*[matches(local-name(),'^pb')][1]/@*:id"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$chunk.id = '0' and $image.id ='0'">
        <xsl:value-of select="/descendant::*[matches(local-name(),'^pb')][1]/@*:id"></xsl:value-of>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$image.id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="this.page.number">
    <xsl:choose>
      <xsl:when test="$chunk.id != '0'">
        <xsl:choose>
          <!--For some reason we were checking preceding sibling before sibling, but was commented out 
            to fix INA-110. If this breaks something we'll have to dig deeper-->
          <!--<xsl:when test="key('div-id', $chunk.id)/preceding-sibling::*[matches(local-name(),'^pb')]">
            <xsl:value-of select="key('div-id', $chunk.id)/preceding-sibling::*[matches(local-name(),'^pb')][1]/@n"/>    
          </xsl:when>-->
          <xsl:when test="key('div-id', $chunk.id)/preceding::*[matches(local-name(),'^pb')]">
            <xsl:value-of select="key('div-id', $chunk.id)/preceding::*[matches(local-name(),'^pb')][1]/@n"/>    
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="key('div-id', $chunk.id)/ancestor::*[matches(local-name(),'^pb')][1]/@n"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$chunk.id = '0'">
        <xsl:value-of select="/descendant::*[matches(local-name(),'^pb')][1]/@n"></xsl:value-of>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:param>
  
  <xsl:param name="first.image.id">
    <xsl:value-of select="/descendant::*[matches(local-name(),'^pb')][1]/@*:id"></xsl:value-of>
  </xsl:param>
  
  <xsl:param name="last.image.id">
    <xsl:value-of select="/descendant::*[matches(local-name(),'^pb')][last()]/@*:id"></xsl:value-of>
  </xsl:param>
  
<!-- ====================================================================== -->
<!-- Root Template                                                          -->
<!-- ====================================================================== -->

<xsl:template match="/">

  <xsl:choose>
    <xsl:when test="$doc.view='bbar'">
      <xsl:call-template name="bbar"/>
    </xsl:when>
    <xsl:when test="$doc.view='toc'">
      <xsl:call-template name="docview"/>
    </xsl:when>
   <xsl:when test="$doc.view='content'">
      <xsl:call-template name="docview"/>
   </xsl:when>
    <xsl:when test="$doc.view='subdoc'">
      <xsl:call-template name="subdoc"/>
    </xsl:when>
    <xsl:when test="$doc.view='subdoc-content'">
      <xsl:call-template name="subdoc-content"/>
    </xsl:when>
<!--    <xsl:when test="$doc.view='popup'">
      <xsl:call-template name="popup"/>
    </xsl:when>
-->    <xsl:when test="$doc.view='print'">
      <xsl:call-template name="print"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="docview"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  
<!-- ====================================================================== -->
<!-- Frames Template                                                        -->
<!-- ====================================================================== -->

  <!--<xsl:template name="frames">
    
    <xsl:variable name="bbar.href"><xsl:value-of select="$query.string"/>&#038;doc.view=bbar&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/></xsl:variable> 
    <xsl:variable name="toc.href"><xsl:value-of select="$query.string"/>&#038;doc.view=toc&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;toc.id=<xsl:value-of select="$toc.id"/><xsl:value-of select="$search"/>#X</xsl:variable>
    <xsl:variable name="content.href"><xsl:value-of select="$query.string"/>&#038;doc.view=content&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;anchor.id=<xsl:value-of select="$anchor.id"/><xsl:value-of select="$search"/><xsl:call-template name="create.anchor"/></xsl:variable>
    
    <html>
      <head>
        <title>
          <xsl:value-of select="$doc.title"/>
        </title>
      </head>
      <frameset rows="80,*" border="2" framespacing="2" frameborder="1">
        <frame scrolling="no" title="Navigation Bar">
          <xsl:attribute name="name">bbar</xsl:attribute>
          <xsl:attribute name="src"><xsl:value-of select="$xtfURL"/>view?<xsl:value-of select="$bbar.href"/></xsl:attribute>
        </frame>
        <frameset cols="35%,65%" border="2" framespacing="2" frameborder="1">
          <frame title="Table of Contents">
            <xsl:attribute name="name">toc</xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="$xtfURL"/>view?<xsl:value-of select="$toc.href"/></xsl:attribute>
          </frame>
          <frame title="Content">
            <xsl:attribute name="name">content</xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="$xtfURL"/>view?<xsl:value-of select="$content.href"/></xsl:attribute>
          </frame>
        </frameset>
      </frameset>
      <noframes>
        <h1>Sorry, your browser doesn't support frames...</h1>
      </noframes>
    </html>
  </xsl:template>
-->
<!-- ====================================================================== -->
<!-- Anchor Template                                                        -->
<!-- ====================================================================== -->

<!--  From original VWWP implementation - check to see what is different
  <xsl:template name="create.anchor">
    <xsl:choose>
      <xsl:when test="($query != '0' and $query != '') and $hit.rank != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/@hitNum"/>
      </xsl:when>
      <xsl:when test="($query != '0' and $query != '') and $set.anchor != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="$set.anchor"/>
      </xsl:when>
      <xsl:when test="$query != '0' and $query != ''">
        <xsl:text>#</xsl:text><xsl:value-of select="key('div-id', $chunk.id)/@xtf:firstHit"/>
      </xsl:when>
      <xsl:when test="$anchor.id != '0'">
        <xsl:text>#X</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
-->  
  <xsl:template name="create.anchor">
    <xsl:choose>
      <!-- First so it takes precedence over computed hit.rank -->
      <xsl:when test="($query != '0' and $query != '') and $set.anchor != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="$set.anchor"/>
      </xsl:when>
      <!-- Next is hit.rank -->
<!--      <xsl:when test="($query != '0' and $query != '') and $hit.rank != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/@hitNum"/>
      </xsl:when>-->
      <xsl:when test="($query != '0' and $query != '') and $chunk.id != '0'">
        <xsl:variable name="chunkID">
          <xsl:value-of select="ancestor::*[1]/@*[local-name()='id']"/>
        </xsl:variable>
        <xsl:variable name="firstHit">
          <xsl:value-of select="key('div-id', $chunkID)/@xtf:firstHit"/>
        </xsl:variable>
        <xsl:variable name="anchorLoc">
          <xsl:value-of select="key('hit-num-dynamic', $firstHit)/@rank"/>
        </xsl:variable>
        <xsl:value-of select="$anchorLoc"></xsl:value-of>
      </xsl:when>
      <xsl:when test="$anchor.id != '0'">
        <xsl:text>#X</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  

<!-- ====================================================================== -->
<!-- TOC Template                                                           -->
<!-- ====================================================================== -->

<xsl:template name="toc">
  <html>
    <head>
      <title>
Title goes here
        <xsl:value-of select="$doc.title"/>
      </title>
      <xsl:copy-of select="$brand.links"/>
      <link rel="stylesheet" type="text/css" href="{$css.path}toc.css"/>
    </head>
    <body>
      <div class="toc">
	Start TOC Here
        <xsl:call-template name="book.autotoc"/>
	End TOC Here
      </div>
    </body>
  </html>
</xsl:template>

<!-- ====================================================================== -->
<!-- Content Template                                                       -->
<!-- ====================================================================== -->

<!--<xsl:template name="content">

  <xsl:variable name="navbar">
    <xsl:call-template name="navbar"/>
  </xsl:variable>

  <html>
    <head>
      <title>
        <xsl:value-of select="$doc.title"/> "<xsl:value-of select="$chunk.id"/>"
      </title>
      <xsl:copy-of select="$brand.links"/>
      <link rel="stylesheet" type="text/css" href="{$css.path}{$content.css}"/>
    </head>
    <body>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <!-\- BEGIN MIDNAV ROW -\->
        <tr width="100%">
          <td colspan="2" width="100%" align="center" valign="top">
            <!-\- BEGIN MIDNAV INNER TABLE -\->
            <table width="94%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="3">
                  <xsl:text>&#160;</xsl:text>
                </td>
              </tr>
              <xsl:copy-of select="$navbar"/>
              <tr>
                <td colspan="3" >
                  <hr class="hr-title"/>
                </td>
              </tr>
            </table>
            <!-\- END MIDNAV INNER TABLE -\->
          </td>
        </tr>
        <!-\- END MIDNAV ROW -\->
      </table>

      <!-\- BEGIN CONTENT ROW -\->
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="left" valign="top">
            <div class="content">
              <!-\- BEGIN CONTENT -\->
              <xsl:choose>
                <xsl:when test="$chunk.id = '0'">
                  <xsl:apply-templates select="/TEI.2/text/front/titlePage"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="key('div-id', $chunk.id)"/>          
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <!-\- BEGIN MIDNAV ROW -\->
        <tr width="100%">
          <td colspan="2" width="100%" align="center" valign="top">
            <!-\- BEGIN MIDNAV INNER TABLE -\->
            <table width="94%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="3">
                  <hr class="hr-title"/>
                </td>
              </tr>
              <xsl:copy-of select="$navbar"/>
              <tr>
                <td colspan="3" >
                  <xsl:text>&#160;</xsl:text>
                </td>
              </tr>
            </table>
            <!-\- END MIDNAV INNER TABLE -\->
          </td>
        </tr>
        <!-\- END MIDNAV ROW -\->
      </table>

    </body>
  </html>
</xsl:template>
-->
<!-- ====================================================================== -->
<!-- docview Template                                                  -->
<!-- ====================================================================== -->


<xsl:template name="docview">
  
  <xsl:variable name="navbar">
    <xsl:call-template name="navbar"/>
  </xsl:variable>
  
  <html lang="en" xml:lang="en">
    <head>
      <meta name="viewport" content="width = 320" />
	  <meta name="viewport" content="initial-scale=1.0, user-scalable=yes" />
      <title>
        <xsl:value-of select="$doc.title"/>
      </title>
      <xsl:copy-of select="$brand.links"/>
      <script src="js/yui/yahoo-dom-event.js" type="text/javascript"/> 
      <script src="js/yui/connection-min.js" type="text/javascript"/> 
      <script xmlns="" type="text/javascript">
	       function showHideArticleInfo(name) {
		        var show = document.getElementById('show' + name);
		        var hide = document.getElementById('hide' + name);
		        if (show.style.display == 'none') {
		            show.style.display = '';
		            document.getElementById('hideInfo').setAttribute('aria-expanded','false');
                	hide.style.display = 'none';
		        } else { 
		        	show.style.display = 'none';
		        	document.getElementById('hideInfo').setAttribute('aria-expanded','true');
		        	hide.style.display = ''; 
		        }
		        if (name == 'TOC') {
		        	if (show.style.display == '') {
		        		document.getElementById('tocView').style.display = 'none';
		        	} else {
		        		document.getElementById('tocView').style.display = '';
		        	}
		        }
        	}
      </script>
      
    </head>
    <body>
      <xsl:copy-of select="$brand.headerIU"/>
      <div id="site_container">
      <xsl:copy-of select="$brand.header"/>
        <div id="content" class="clearfix">
          <div id="doc-search-options">
            <h2>Search Options</h2>
            <div class="search-options">
              
              <xsl:call-template name="searchWithinForm"/>
<!--              <h4><xsl:text>queryURL: </xsl:text><xsl:value-of select="session:getData('queryURL')"/></h4>-->
              <xsl:choose>
                <xsl:when test="session:getData('queryURL')">
                  <span>Back to <a href="{session:getData('queryURL')}">search results</a></span>
                </xsl:when>
              </xsl:choose>
              <br class="clear_both"/>
              <xsl:if test="$textHitCount &gt; 0">
                <h3 id="hitSummary"><xsl:value-of select="$textHitCount"/>
                  <xsl:choose>
                    <xsl:when test="$textHitCount = '1'">
                      <xsl:text> occurrence</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text> occurrences</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:text> of </xsl:text>
                <!--<h4><xsl:text>testQueryString: </xsl:text><xsl:value-of select="session:getData('testQueryString')"/></h4>
                <h4><xsl:text>text1: </xsl:text><xsl:value-of select="$text1"/></h4>
                <h4><xsl:text>text2: </xsl:text><xsl:value-of select="$text2"/></h4>-->
                <a href="#1"><xsl:call-template name="queryString"/></a>
                [<a href="{concat($xtfURL,$dynaxmlPath,'?',$query.string)}&amp;brand={$brand}">Clear Hits</a>]
                </h3>
              </xsl:if>
              <br />
              <xsl:if test="$doc.view!='notoc'">
             	
    				<a href="javascript:showHideArticleInfo('TOC')" id="showTOC" style="display:none;">[Show Table of Contents]</a>

    				<a href="javascript:showHideArticleInfo('TOC')" id="hideTOC">[Hide Table of Contents]</a>
  				 
  			</xsl:if>
<!--  			<xsl:choose>
  				<xsl:when test="$doc.view!='notoc'">
		            
	    		         <a href="{$xtfURL}{$dynaxmlPath}?docId={$docId}&amp;brand={$brand}&amp;doc.view=notoc&amp;source={$source}" id="viewEntire">[View Entire Document]</a>
			         
	         	</xsl:when>
	         	<xsl:otherwise>
	         		
	    		         <a href="{$xtfURL}{$dynaxmlPath}?docId={$docId}&amp;brand={$brand}&amp;source={$source}" id="viewChunk">[View Table of Contents]</a>
	         		 
			     </xsl:otherwise>
			 </xsl:choose> -->
            </div>
          </div>
          
          <br class="clear_both"/>
          
          <div id="viewOptions" class="toc">
            <h2>View Options</h2>
            <hr/>
            <ul>
            <xsl:choose>
              <xsl:when test="$doc.view = 'pagedImage' and $hasPageImage = 'yes'">
              <li>
              <xsl:element name="a">
      			<xsl:attribute name="href">
		        	<xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>
			        <xsl:text>?docId=</xsl:text><xsl:value-of select="$docId"/>
    	    		<xsl:text>&amp;brand=</xsl:text><xsl:value-of select="$brand"/>
			        <xsl:text>&amp;doc.view=docview</xsl:text>
		    	    <xsl:text>&amp;source=</xsl:text><xsl:value-of select="$source"/>
        			<xsl:text>&amp;chunk.id=</xsl:text><xsl:value-of select="$chunk.id"/>
			        <xsl:text>&amp;toc.id=</xsl:text><xsl:value-of select="$toc.id"/>
    	    		<xsl:text>&amp;query=</xsl:text><xsl:value-of select="$query"/>
			        <xsl:text>&amp;doc.view=docview</xsl:text>
                 </xsl:attribute>
                 <xsl:attribute name="title">
                 	<xsl:text>View sections of text based on the Table of Contents.</xsl:text>
                 </xsl:attribute>
		         <xsl:text>Text Mode</xsl:text>
		      </xsl:element>
              </li>
              <li><h3>Image Mode</h3></li>
              </xsl:when>
              <xsl:otherwise>
              		<li><h3>Text Mode</h3></li>
              		<xsl:if test="$hasPageImage = 'yes'">
              		<li>
              			<xsl:element name="a">
      					  <xsl:attribute name="href">
					        <xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>
					        <xsl:text>?docId=</xsl:text><xsl:value-of select="$docId"/>
					        <xsl:text>&amp;brand=</xsl:text><xsl:value-of select="$brand"/>
					        <xsl:text>&amp;doc.view=docview</xsl:text>
					        <xsl:text>&amp;source=</xsl:text><xsl:value-of select="$source"/>
					        <xsl:text>&amp;chunk.id=</xsl:text><xsl:value-of select="$chunk.id"/>
					        <xsl:text>&amp;toc.id=</xsl:text><xsl:value-of select="$toc.id"/>
					        <xsl:text>&amp;query=</xsl:text><xsl:value-of select="$query"/> 
				            <xsl:text>&amp;doc.view=pagedImage</xsl:text>
				            <xsl:text>&amp;image.id=</xsl:text><xsl:value-of select="$this.image.id"/>
					      </xsl:attribute>
					      <xsl:attribute name="title">
					      	<xsl:text>View page images from the beginning or from the current location in the Table of Contents.</xsl:text>
					      </xsl:attribute>
          				<xsl:text>Image Mode</xsl:text><br/>      
    				   </xsl:element>
              		</li>
              		</xsl:if>
              </xsl:otherwise>
           </xsl:choose>
           
              <li><a href="{$xtfURL}{$dynaxmlPath}?docId={$docId}&amp;doc.view=print" title="View the entire text of the document.  NOTE: Text might be very lengthy.">Entire Document</a></li>
              <xsl:if test="$hasPageImage = 'yes'">
                <li><a href="http://purl.dlib.indiana.edu/iudl/{$pageImageBrand}/printable/{$idno}" title="Download Adobe PDF file of entire document.  NOTE: File size might be large if document is lengthy.">PDF</a></li>  
              </xsl:if>
              <li>
                <xsl:choose>
                  <xsl:when test="$encyclopedia='yes'">
                    <a href="http://purl.dlib.indiana.edu/iudl/{$pageImageBrand}/encyclopedia/encodedtext/{$idno}" title="Download original document encoding as XML file.">XML</a>
                  </xsl:when>
                  <xsl:otherwise>
                    <a href="http://purl.dlib.indiana.edu/iudl/{$pageImageBrand}/encodedtext/{$idno}" title="Download original document encoding as XML file.">XML</a>
                  </xsl:otherwise>
                </xsl:choose>
                
              </li>
              </ul>
          </div>
          
          <xsl:if test="$doc.view!='notoc'">
            <div id="tocView" class="toc">
              <h2>Table of Contents</h2>
              <xsl:call-template name="book.autotoc"/>
            </div>
            </xsl:if>
          
          <xsl:variable name="docViewWidth">
    		<xsl:choose>
    			<xsl:when test="$doc.view != 'notoc'">docView</xsl:when>
    			<xsl:otherwise>docViewFull</xsl:otherwise>
    		</xsl:choose>
  		  </xsl:variable>

          <a name="docView"/>
          <div id="{$docViewWidth}" role="article">
            
            <xsl:call-template name="generateDocInfo"/>
            
            <xsl:choose>
              <xsl:when test="$doc.view='notoc' and $chunk.id!='0'">
              	<xsl:call-template name="generateMetadata"/>
              	<xsl:apply-templates select="key('div-id', $chunk.id)"/>
              </xsl:when>
              <xsl:when test="$doc.view='notoc'">
              	  <xsl:call-template name="generateMetadata"/>
                  <xsl:apply-templates select="/TEI.2/text"/>
              </xsl:when>
                
            <xsl:otherwise>
            <xsl:if test="not($doc.view='pagedImage')">
              <div class="toc-nav">
                <xsl:copy-of select="$navbar"/>
              </div>
            </xsl:if>
            
       <!--     <xsl:if test="$encyclopedia = 'no'">
            	<xsl:variable name="encyclopediaFile">
					<xsl:text>../../../../data/encyclopedia/VAA5365-0</xsl:text><xsl:value-of select="substring($author.id,6,1)"/><xsl:text>.xml</xsl:text>
				</xsl:variable>
				<div id="authorEntry" class="showAuthorEntry" style="display:none;">
					<a href="/{$pageImageBrand}/view?docId=encyclopedia/VAA5365-0{substring($author.id,6,1)};chunk.id={$author.id};toc.id={$author.id}" class="left">Switch to Encyclopedia</a>
					<a href="javascript:closeAuthor();" class="floatright">Close X</a>
					<div>
						<xsl:apply-templates select="document($encyclopediaFile)/TEI.2/text/body/div[@type='filingLetter']/div[@id=$author.id]"/>
					</div>
				</div>
			</xsl:if> -->
            
            <xsl:call-template name="generateMetadata"/>
            <xsl:call-template name="topPageLink"/>
                            
              <xsl:choose>
              <xsl:when test="$chunk.id = '0'">
                <xsl:choose>
                  <xsl:when test="$doc.view='pagedImage'">
                    <xsl:call-template name="pageImageViewer">
                      <!--How should we call if we don't have a chunk.id?-->
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
<!--                    <xsl:apply-templates select="/*/*[local-name()='text']/*[local-name()='front']/*[local-name()='titlePage']"/>-->
                    <xsl:apply-templates select="/*/*[local-name()='text']/*[local-name()='front']"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$doc.view='pagedImage'">
                    <xsl:call-template name="pageImageViewer"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="key('div-id', $chunk.id)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>


              <xsl:if test="not($doc.view='pagedImage')">
                <div class="toc-nav">
                  <xsl:copy-of select="$navbar"/>
                </div>
              </xsl:if>   
              

            </xsl:otherwise>
            </xsl:choose>
                  
            
          </div>
         </div>
        </div>
        <div id="footer" role="contentinfo">
          <div class="contactinfo">
            <p>
              Bookmark this page at: <a href="{$inauthorsPURL}"><xsl:value-of select="$inauthorsPURL"/></a>
            </p>
              <xsl:copy-of select="$brand.footer"/>
          </div>
        </div>
      <xsl:copy-of select="$brand.footerIU"/>
    </body>
  </html>
</xsl:template>

  <xsl:template name="generateDocInfo">
      <xsl:param name="smode"/>
      <xsl:variable name="myselection_identifier">
      <xsl:choose>
      	<xsl:when test="$encyclopedia='yes'">
      		<xsl:value-of select="replace($chunk.id,'-','')"/>
      	</xsl:when>
      	<xsl:otherwise>
      		<xsl:value-of select="$idno"/>
      	</xsl:otherwise>
      </xsl:choose>
      </xsl:variable>
      <xsl:variable name="myselection_identifier_string">
      <xsl:choose>
      	<xsl:when test="$encyclopedia='yes'">
	       <xsl:text>volSubDocId=</xsl:text><xsl:value-of select="$myselection_identifier"/>
	    </xsl:when>
	    <xsl:otherwise>
	    	<xsl:text>identifier=</xsl:text><xsl:value-of select="$myselection_identifier"/>
	    </xsl:otherwise>
      </xsl:choose>
      </xsl:variable>
    <!-- Title, Author -->
    <strong class="chunkTitle"><xsl:value-of select="$doc.title"/>.
		<xsl:for-each select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/author">
			<xsl:value-of select="replace(.,'-','&#150;')"/>&#160;
		</xsl:for-each>
    </strong>
    <div class="print_myselections">
    	<xsl:if test="session:isEnabled()">
        <xsl:choose>
          <xsl:when test="session:noCookie()">
            <span><a href="javascript:alert('To use the bag, you must enable cookies in your web browser.')">Requires cookie*</a></span>                                 
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="session:getData('bag')/bag/savedDoc[@id=$myselection_identifier]">
                <span class="addToMySelection italic">Added to My Selections</span>
              </xsl:when>
              <xsl:when test="session:getData('bag')/bag/savedDoc[@volSubDocId=$myselection_identifier]">
                <span class="addToMySelection italic">Added to My Selections</span>
              </xsl:when>
              <xsl:otherwise> 
                <span id="add" class="addToMySelection">
                <script type="text/javascript">
                                    add_f = function() {
                                       var span = YAHOO.util.Dom.get('add');
                                       span.innerHTML = "Adding...";
                                       YAHOO.util.Connect.asyncRequest('GET', 
                                          '<xsl:value-of select="concat($xtfURL, $crossqueryPath, '?smode=addToBag;', $myselection_identifier_string)"/>',
                                          {  success: function(o) { 
                                                span.innerHTML = o.responseText;
                                              //  ++(YAHOO.util.Dom.get('bagCount').innerHTML);
                                             },
                                             failure: function(o) { span.innerHTML = 'Failed to add!'; }
                                          }, null);
                                    };
                                 </script> 
                  <a href="javascript:add_f()">[Add<span class="auraltext"> "<xsl:value-of select="$doc.title"/>"</span> to My Selections]</a>
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      
    	<a href="javascript:window.print()" class="print">[Print]</a>
    </div>
  </xsl:template>
  

<xsl:template name="generateMetadata">
  <div id="showInfo">
    <p><a href="javascript:showHideArticleInfo('Info')">[Show Document Information]</a></p>
  </div>
  
  <div class="metadataBox" id="hideInfo" style="display:none;" aria-expanded="false">
    <p><a href="javascript:showHideArticleInfo('Info')">[Hide Document Information]</a></p>
  
  <div id="itemMetadata">

    <xsl:apply-templates select="/TEI.2/teiHeader/fileDesc"/>

<!--	<p><a href="{$xtfURL}{$dynaxmlPath}?docId={$docId}&amp;doc.view=print">View printer friendly version</a></p> -->
	
  </div>
  
</div>  
  
  
</xsl:template>
  
<!--  Here's a sample test we can do for existence and punctuation, probably will need this -->
<!--  <xsl:if test="meta/creator and meta/creator != ''">
    <xsl:value-of select="normalize-space(meta/creator[1])"/>
    <xsl:if test="not(ends-with(meta/creator[1],'.'))"></xsl:if>
  </xsl:if>-->
  
<!--  <xsl:template match="/TEI.2/teiHeader/fileDesc">
   <dl class="resultItem">
    <xsl:element name="dt">Title:</xsl:element>
     <xsl:element name="dd"><xsl:value-of select="sourceDesc/biblStruct/monogr/title[1]"/></xsl:element>
    <xsl:element name="dt">Source:</xsl:element>
    <xsl:element name="dd">
      <xsl:value-of select="sourceDesc/biblStruct/monogr/title"/><xsl:text>, </xsl:text>
      <xsl:text>Volume </xsl:text><xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/biblScope[@type='volume']"/><xsl:text>, </xsl:text>
      <xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/date"/><xsl:text>, </xsl:text>
      <xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/biblScope[@type='pp']"/><xsl:text> pp</xsl:text>  -->
      <!--<xsl:value-of select="sourceDesc/biblFull/publicationStmt/pubPlace"/><xsl:text>: </xsl:text>
      <xsl:value-of select="sourceDesc/biblFull/publicationStmt/publisher"/><xsl:text>, </xsl:text>
      <xsl:value-of select="sourceDesc/biblFull/publicationStmt/date"/><xsl:text>. </xsl:text>
      <xsl:value-of select="sourceDesc/biblFull/extent"/>-->
<!--    </xsl:element>
    <xsl:if test="publicationStmt/availability/@status eq 'free'">
    	<dt>Rights:</dt>
    	<xsl:for-each select="publicationStmt/availability">
    		<xsl:if test="@status eq 'free'">
    			<dd><xsl:value-of select="."/></dd>
    		</xsl:if>
    	</xsl:for-each>
    </xsl:if>
   </dl>
  </xsl:template> -->
  
	<xsl:template match="/TEI.2/teiHeader/fileDesc">
 		<dl class="resultItem">
 			<xsl:element name="dt">Title:</xsl:element>
			<xsl:element name="dd"><xsl:value-of select="$doc.title"/><xsl:if test="$doc.subtitle != ''">; <xsl:value-of select="$doc.subtitle"/></xsl:if></xsl:element>
 			<xsl:element name="dt">Author:</xsl:element>
			<xsl:choose>
				<!-- ENCYCLOPEDIA -->
				<xsl:when test="$encyclopedia = 'yes'">
					<xsl:element name="dd">
						<xsl:value-of select="replace($doc.author, '-', '&#150;')"/>
					</xsl:element>
					<xsl:element name="dt">Source:</xsl:element>
					<xsl:element name="dd"><xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/pubPlace"/>: <xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/publisher"/>, <xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/date"/>. <xsl:value-of select="sourceDesc/biblStruct/monogr/imprint/biblScope[@type='pages']"/></xsl:element>
					<xsl:element name="dt">Bookmark:</xsl:element>
					<xsl:element name="dd">
						<a href="{$inauthorsPURL}"><xsl:value-of select="$inauthorsPURL"/></a>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<!-- BOOK -->
					<xsl:element name="dd">
						<xsl:for-each select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/author">
							<a href="javascript:showAuthor('{@id}');">
							<xsl:value-of select="."/></a>&#160;
							<xsl:call-template name="encyclopediaAuthorEntry">
								<xsl:with-param name="currentAuthor" select="@id"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:element>
					<xsl:element name="dt">Publication Year:</xsl:element>
      				<xsl:element name="dd"><xsl:value-of select="sourceDesc/biblFull/publicationStmt/date"/></xsl:element>
    				<xsl:element name="dt">Source:</xsl:element>
    				<xsl:element name="dd">
      					<xsl:value-of select="sourceDesc/biblFull/publicationStmt/pubPlace"/><xsl:text>: </xsl:text><xsl:value-of select="sourceDesc/biblFull/publicationStmt/publisher"/><xsl:text>, </xsl:text><xsl:value-of select="sourceDesc/biblFull/publicationStmt/date"/><xsl:text>. </xsl:text><xsl:value-of select="sourceDesc/biblFull/extent"/>
    				</xsl:element>
    				<xsl:element name="dt">Bookmark:</xsl:element>
					<xsl:element name="dd">
						<a href="{$inauthorsPURL}"><xsl:value-of select="$inauthorsPURL"/></a>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</dl>
 	</xsl:template>
 	
 	<xsl:template name="encyclopediaAuthorEntry">
 		<xsl:param name="currentAuthor"/>
 		<xsl:if test="$encyclopedia = 'no'">
	 			<xsl:variable name="encyclopediaFile">
					<xsl:text>../../../../data/encyclopedia/VAA5365-0</xsl:text><xsl:value-of select="substring($currentAuthor,6,1)"/><xsl:text>.xml</xsl:text>
				</xsl:variable>
				<div id="authorEntry-{$currentAuthor}" class="showAuthorEntry" style="display:none;">
					<a href="/{$pageImageBrand}/view?docId=encyclopedia/VAA5365-0{substring($currentAuthor,6,1)};chunk.id={$currentAuthor};toc.id={$currentAuthor}" class="left">Switch to Encyclopedia</a>
					<a href="javascript:closeAuthor('{$currentAuthor}');" class="floatright">Close X</a>
					<div>
						<xsl:apply-templates select="document($encyclopediaFile)/TEI.2/text/body/div[@type='filingLetter']/div[@id=$currentAuthor]"/>
					</div>
				</div>
		</xsl:if>
 	</xsl:template>

  <!-- ====================================================================== -->
  <!-- Print Template                                                  -->
  <!-- ====================================================================== -->


<xsl:template name="print">
  <html lang="en" xml:lang="en">
    <head>
      <title>
        <xsl:value-of select="$doc.title"/>
      </title>
      <xsl:copy-of select="$brand.links"/>
      <link rel="stylesheet" type="text/css" href="{$css.path}print.css"/>
      <body>
      		<div id="printNavigation">
      			<h1><xsl:value-of select="$brandName"/></h1>
      			<p><xsl:call-template name="generateDocInfo"/>&#160;<a href="{$inauthorsPURL}"><xsl:value-of select="$inauthorsPURL"/></a></p>
      		</div>
      		<div id="print_content">
      			<div id="docViewFull" role="article">
		       		<xsl:apply-templates select="/TEI.2/text"/>
		       	</div>
		    </div>
      </body>
    </head>
    </html>
</xsl:template>

  <xsl:template name="subdoc">
    <html lang="en" xml:lang="en">
      <head>
        <title>
          <xsl:value-of select="$doc.title"/>
        </title>
        <xsl:copy-of select="$brand.links"/>
        <link rel="stylesheet" type="text/css" href="{$css.path}print.css"/>
        <body>
            <div id="docViewFull" role="article">
              <xsl:apply-templates select="key('div-id', $chunk.id)"/>
            </div>
        </body>
      </head>
    </html>
  </xsl:template>
  
  <xsl:template name="subdoc-content">
    <html lang="en" xml:lang="en">
      <head>
        <title>
          <xsl:value-of select="$doc.title"/>
        </title>
        <xsl:copy-of select="$brand.links"/>
        <link rel="stylesheet" type="text/css" href="{$css.path}print.css"/>
        <body>
          <div id="docViewFull" role="article">
            <xsl:apply-templates select="key('div-id', $chunk.id)//pathToContent"/>
          </div>
        </body>
      </head>
    </html>
  </xsl:template>
  

<xsl:template name="searchWithinForm">
  <form method="get" id="searchWithinForm" action="{$xtfURL}{$dynaxmlPath}#1" role="search">
    <fieldset>
      <input type="hidden" name="docId" value="{$docId}"/>
      <input type="hidden" name="brand" value="{$brand}"/>
      <input type="hidden" name="field1" value="text"/>
      <label for="text1">Search within this document:</label><input type="text" size="15" name="text1" id="text1"/>
      <xsl:text disable-output-escaping='yes'>&#160;</xsl:text>
      <input type="submit" name="submit" value="Search" />
      <input type="hidden" name="hit.rank" value="1"/>
    </fieldset>
  </form>
  
  
  <!--<form method="get" action="http://localhost:8080/tei-general/view">
    <fieldset>
      <input type="hidden" name="docId" value="VAB7129.xml"></input>
      <input type="hidden" name="brand" value="$brand"></input>
      <input type="hidden" name="field1" value="text"></input>
      <input type="text" size="15" name="text1"></input> 
      <input type="image" name="submit" src="images/goButton.gif" id="submitSearchWithin"></input>
    </fieldset>
  </form>-->
</xsl:template>

  <xsl:template name="queryString">
    <xsl:if test="$text1">
      <xsl:if test="$field1 = 'text'">
        <xsl:value-of select="$text1"/>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$text2">
      <xsl:if test="$field2 = 'text'">
        &#160;<xsl:value-of select="$op1"/>&#160;<xsl:value-of select="$text2"/>
      </xsl:if>  
    </xsl:if>
    <xsl:if test="$text3">
      <xsl:if test="$field3 = 'text'">
        &#160;<xsl:value-of select="$op2"/>&#160;<xsl:value-of select="$text3"/>
      </xsl:if>  
    </xsl:if>
    <!-- <xsl:text> in this document</xsl:text> -->
    <xsl:if test="$fromYear != '' and $fromMonth != ''">
      <xsl:choose>
        <xsl:when test="count($toYear) = 1 and count($toMonth) = 1">
          <xsl:text> [ </xsl:text>
          <xsl:value-of select="$fromYear"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$fromMonth"/>
          <xsl:text> - </xsl:text>
          <xsl:value-of select="$toYear"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$toMonth"/>
          <xsl:text> ]</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> [ </xsl:text>
          <xsl:value-of select="$fromYear"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$fromMonth"/>
          <xsl:text> ]</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$freeformQuery != ''">
      <xsl:value-of select="$freeformQuery"/>
    </xsl:if>
  </xsl:template> 
  
  <!-- ====================================================================== -->
  <!-- Navigation Bar Template                                                -->
  <!-- ====================================================================== -->
  
  <xsl:template name="navbar" exclude-result-prefixes="#all">
    
    <xsl:variable name="prev">
      <xsl:choose>
        <!-- preceding div sibling -->
        <xsl:when test="key('div-id', $chunk.id)/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="key('div-id', $chunk.id)/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"/>
        </xsl:when>
        <!-- last div node in preceding div sibling of parent -->
        <xsl:when test="key('div-id', $chunk.id)/parent::*/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="key('div-id', $chunk.id)/parent::*/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"/>
        </xsl:when>
        <!-- last div node in any preceding structure-->
        <xsl:when test="key('div-id', $chunk.id)/ancestor::*/preceding-sibling::*/*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="(key('div-id', $chunk.id)/ancestor::*/preceding-sibling::*[1]/*[*[local-name()='head']][@*[local-name()='id']][position()=last()]/@*[local-name()='id'])[last()]"/>
        </xsl:when>
        <!-- top of tree -->
        <xsl:otherwise>
          <xsl:value-of select="'0'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="prev_toc">
      <xsl:choose>
        <xsl:when test="key('div-id', $prev)/*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="key('div-id', $prev)/@*[local-name()='id']"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="key('div-id', $prev)/parent::*[*[local-name()='head']][@*[local-name()='id']]/@*[local-name()='id']"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="next">
      <xsl:choose>
        <!-- following div sibling -->
        <xsl:when test="key('div-id', $chunk.id)/following-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="key('div-id', $chunk.id)/following-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"/>
        </xsl:when>
        <!-- first div node in following div sibling of parent -->
        <xsl:when test="key('div-id', $chunk.id)/parent::*/following-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="key('div-id', $chunk.id)/parent::*/following-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"/>
        </xsl:when>
        <!-- first div node in any following structure -->
        <xsl:when test="key('div-id', $chunk.id)/ancestor::*/following-sibling::*/*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="(key('div-id', $chunk.id)/ancestor::*/following-sibling::*[1]/*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id'])[1]"/>
        </xsl:when>
        <!-- no previous $chunk.id (i.e. titlePage) -->
        <xsl:when test="$chunk.id='0'">
          <xsl:value-of select="/*/*[local-name()='text']/*[*[*[local-name()='head']][@*[local-name()='id']]][1]/*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"/>
        </xsl:when>
        <!-- bottom of tree -->
        <xsl:otherwise>
          <xsl:value-of select="'0'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="next_toc">
      <xsl:choose>
        <xsl:when test="key('div-id', $next)/*[*[local-name()='head']][@*[local-name()='id']]">
          <xsl:value-of select="key('div-id', $next)/@*[local-name()='id']"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="key('div-id', $next)/parent::*[*[local-name()='head']][@*[local-name()='id']]/@*[local-name()='id']"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    
    <!--  <td width="25%" align="left">-->
      <div class="toc-prev">
        <!-- BEGIN PREVIOUS SELECTION -->
        <a>
          <xsl:choose>
            <xsl:when test="$prev != '0'">
              <xsl:attribute name="href">
                <xsl:value-of select="$doc.path"/>
                <xsl:text>&#038;chunk.id=</xsl:text>
                <xsl:value-of select="$prev"/>
                <xsl:text>&#038;toc.id=</xsl:text>
                <xsl:value-of select="$prev_toc"/>
                <xsl:text>&#038;brand=</xsl:text>
                <xsl:value-of select="$brand"/>
                <xsl:value-of select="$search"/>
                <xsl:text>#docView</xsl:text>
              </xsl:attribute>
              <img src="{$icon.path}previousButton.png" alt="previous"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="{$icon.path}d_previousButton.png" alt="no previous"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
        <!-- END PREVIOUS SELECTION -->
<!--      </td>-->
<!--      <td width="50%" align="center">
        <span class="chapter-text">
          <xsl:value-of select="key('div-id', $chunk.id)/ancestor-or-self::*[matches(@*[local-name()='type'],'fmsec|chapter|bmsec')][1]/*[local-name()='head'][1]"/>
        </span>
      </td>
-->
    
<!--      <td width="25%" align="right">-->
        <div class="toc-next">
        <!-- BEGIN NEXT SELECTION -->
        <a>
          <xsl:choose>
            <xsl:when test="$next != '0'">
              <xsl:attribute name="href">
                <xsl:value-of select="$doc.path"/>
                <xsl:text>&#038;chunk.id=</xsl:text>
                <xsl:value-of select="$next"/>
                <xsl:text>&#038;toc.id=</xsl:text>
                <xsl:value-of select="$next_toc"/>
                <xsl:text>&#038;brand=</xsl:text>
                <xsl:value-of select="$brand"/>
                <xsl:value-of select="$search"/>
                <xsl:text>#docView</xsl:text>
              </xsl:attribute>
              <img src="{$icon.path}nextButton.png" alt="next"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="{$icon.path}d_nextButton.png" width="30" height="32" alt="no next"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
        <!-- END NEXT SELECTION -->
      </div>
<!--      </td>-->
    
    
  </xsl:template>

  <xsl:template name="pageImageViewer">
    <div class="image-viewer">
    <div class="toc-nav">
      <xsl:call-template name="image-navbar"/><br/>
    </div>
      <div id="zoomPageImage" style="display:none;">
      	<a href="javascript:zoomPageImage();">ZOOM +</a>
      </div>
      <img src="http://purl.dlib.indiana.edu/iudl/inauthors/{$this.image.id}" class="pageImage" onmouseover="javascript:zoomImageShow();" alt=""/>
      <div id="bigPageImage" style="display:none;">
      	<a href="javascript:zoomImageHide();">CLOSE  X</a>
     	<img src="http://purl.dlib.indiana.edu/iudl/inauthors/large/{$this.image.id}" id="zoomOverlay" style="display:none;" alt="Page image - large version"/>
      </div>
    <div class="toc-nav">
      <xsl:call-template name="image-navbar"/>
    </div>
    </div>
  </xsl:template>
  	
  <xsl:template name="image-navbar">
    
    <xsl:variable name="next.image.id">
      <xsl:choose>
        <xsl:when test="key('pb-id', $this.image.id)/following::*[matches(local-name(),'^pb')]">
          <xsl:value-of select="key('pb-id', $this.image.id)/following::*[matches(local-name(),'^pb')][1]/@*:id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="key('div-id', $chunk.id)/ancestor::*[matches(local-name(),'^pb')][1]/@*:id"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="prev.image.id">
      <xsl:choose>
        <xsl:when test="key('pb-id', $this.image.id)/preceding::*[matches(local-name(),'^pb')]">
          <xsl:value-of select="key('pb-id', $this.image.id)/preceding::*[matches(local-name(),'^pb')][1]/@*:id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="key('div-id', $chunk.id)/ancestor::*[matches(local-name(),'^pb')][1]/@*:id"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    
    
<!--    <xsl:text>prev.image.id=</xsl:text><xsl:value-of select="$prev.image.id"/><br/>
    <xsl:text>next.image.id=</xsl:text><xsl:value-of select="$next.image.id"/><br/>
    <xsl:text>this.div=</xsl:text><xsl:value-of select="$this.div"/><br/>
    <xsl:text>prev.div=</xsl:text><xsl:value-of select="$prev.div"/><br/>
    <xsl:text>next.div=</xsl:text><xsl:value-of select="$next.div"/><br/>
    <xsl:text>prev.toc=</xsl:text><xsl:value-of select="$prev.toc"/><br/>
    <xsl:text>next.toc=</xsl:text><xsl:value-of select="$next.toc"/><br/>-->
    
    <div class="toc-prev">
	    <xsl:choose>
    		<xsl:when test="$prev.image.id != ''">
    		  <xsl:element name="a">
    		    <xsl:attribute name="href">
    		      <xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>
    		      <xsl:text>?docId=</xsl:text><xsl:value-of select="$docId"/>
    		      <xsl:text>&amp;brand=</xsl:text><xsl:value-of select="$brand"/>
    		      <xsl:text>&amp;doc.view=pagedImage</xsl:text>
    		      <xsl:text>&amp;source=</xsl:text><xsl:value-of select="$source"/>
    		      <xsl:text>&amp;image.id=</xsl:text><xsl:value-of select="$first.image.id"/>
    		      <xsl:text>&amp;query=</xsl:text><xsl:value-of select="$query"/>
    		      <xsl:text>#docView</xsl:text>
    		    </xsl:attribute>
    		    <img src="{$icon.path}firstPage.png" class="firstPageImage" alt="First Page Image"/>
    		  </xsl:element>
    		  <xsl:element name="a">
		    	  <xsl:attribute name="href">
        			<xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>
			        <xsl:text>?docId=</xsl:text><xsl:value-of select="$docId"/>
    	    		<xsl:text>&amp;brand=</xsl:text><xsl:value-of select="$brand"/>
			        <xsl:text>&amp;doc.view=pagedImage</xsl:text>
        			<xsl:text>&amp;source=</xsl:text><xsl:value-of select="$source"/>
		        	<xsl:text>&amp;image.id=</xsl:text><xsl:value-of select="$prev.image.id"/>
	        		<xsl:text>&amp;query=</xsl:text><xsl:value-of select="$query"/>
		    	    <xsl:text>#docView</xsl:text>
		    	  </xsl:attribute>
			      <img src="{$icon.path}previousButton.png" alt="Previous Page Image"/>
			    </xsl:element>
    		</xsl:when>
    		<xsl:otherwise>
    			<img src="{$icon.path}d_firstPage.png" class="firstPageImage" alt="At First Page Image"/>
    			<img src="{$icon.path}d_previousButton.png" alt="No Previous Page Image"/>
	    	</xsl:otherwise>
    	</xsl:choose>
    </div>
    
    <div class="toc-next">
    	<xsl:choose>
    		<xsl:when test="$next.image.id != ''">
			    <xsl:element name="a">
			      <xsl:attribute name="href">
				      <xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>
		        	  <xsl:text>?docId=</xsl:text><xsl:value-of select="$docId"/>
			          <xsl:text>&amp;brand=</xsl:text><xsl:value-of select="$brand"/>
			          <xsl:text>&amp;doc.view=pagedImage</xsl:text>
			          <xsl:text>&amp;source=</xsl:text><xsl:value-of select="$source"/>
		    	      <xsl:text>&amp;image.id=</xsl:text><xsl:value-of select="$next.image.id"/>
		        	  <xsl:text>&amp;query=</xsl:text><xsl:value-of select="$query"/>
			          <xsl:text>#docView</xsl:text>
			      </xsl:attribute>
			      <img src="{$icon.path}nextButton.png" alt="Next Page Image"/>
			    </xsl:element>
    		  <xsl:element name="a">
    		    <xsl:attribute name="href">
    		      <xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>
    		      <xsl:text>?docId=</xsl:text><xsl:value-of select="$docId"/>
    		      <xsl:text>&amp;brand=</xsl:text><xsl:value-of select="$brand"/>
    		      <xsl:text>&amp;doc.view=pagedImage</xsl:text>
    		      <xsl:text>&amp;source=</xsl:text><xsl:value-of select="$source"/>
    		      <xsl:text>&amp;image.id=</xsl:text><xsl:value-of select="$last.image.id"/>
    		      <xsl:text>&amp;query=</xsl:text><xsl:value-of select="$query"/>
    		      <xsl:text>#docView</xsl:text>
    		    </xsl:attribute>
    		    <img src="{$icon.path}lastPage.png" class="lastPageImage" alt="Last Page Image"/>
    		  </xsl:element>
    		</xsl:when>
    		<xsl:otherwise>
    			<img src="{$icon.path}d_nextButton.png" alt="No Next Page Image"/>
    			<img src="{$icon.path}d_lastPage.png" class="lastPageImage" alt="At Last Page Image"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </div>
    
    
  </xsl:template>

  <xsl:template name="topPageLink"/>

</xsl:stylesheet>
