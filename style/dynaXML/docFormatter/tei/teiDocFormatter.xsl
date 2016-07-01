<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xmlns:ns="http://www.tei-c.org/ns/1.0" 
   xmlns:date="http://exslt.org/dates-and-times"
   xmlns:parse="http://cdlib.org/xtf/parse"
   xmlns:xtf="http://cdlib.org/xtf"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   xmlns:editURL="http://cdlib.org/xtf/editURL"
   xmlns:FileUtils="java:org.cdlib.xtf.xslt.FileUtils"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   extension-element-prefixes="date FileUtils"
   exclude-result-prefixes="#all">
   
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- dynaXML Stylesheet                                                     -->
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   
   <!--
      Copyright (c) 2008, Regents of the University of California
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
   
   <!-- ====================================================================== -->
   <!-- Import Common Templates                                                -->
   <!-- ====================================================================== -->
   
   <xsl:import href="../common/docFormatterCommon.xsl"/>
   <xsl:import href="../../../crossQuery/resultFormatter/common/resultFormatterCommon.xsl"/>
   
   <!-- ====================================================================== -->
   <!-- Output Format                                                          -->
   <!-- ====================================================================== -->
   
   <xsl:output name="xhtml" method="xhtml" indent="no" 
      encoding="UTF-8" media-type="text/html; charset=UTF-8" 
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
      exclude-result-prefixes="#all"
      omit-xml-declaration="yes"/>
 
   <!-- ====================================================================== -->
   <!-- Strip Space                                                            -->
   <!-- ====================================================================== -->
   
   <xsl:strip-space elements="*"/>
   
   <!-- ====================================================================== -->
   <!-- Included Stylesheets                                                   -->
   <!-- ====================================================================== -->
   
   <xsl:include href="component.xsl"/>
   <xsl:include href="search.xsl"/>
   <xsl:include href="parameter.xsl"/>
   <xsl:include href="structure.xsl"/>
   <xsl:include href="table.xsl"/>
   <xsl:include href="titlepage.xsl"/>
   <xsl:include href="biblStruct.xsl"/>
   
   <!-- ====================================================================== -->
   <!-- Define Keys                                                            -->
   <!-- ====================================================================== -->
   
   <xsl:key name="pb-id" match="*[matches(name(),'^pb$|^milestone$')]" use="@*:id"/>
   <xsl:key name="ref-id" match="*[matches(name(),'^ref$')]" use="@*:id"/>
   <xsl:key name="fnote-id" match="*[matches(name(),'^note$')][@type='footnote' or @place='foot']" use="@*:id"/>
   <xsl:key name="endnote-id" match="*[matches(name(),'^note$')][@type='endnote' or @place='end']" use="@*:id"/>
   <xsl:key name="div-id" match="*[matches(name(),'^div')]" use="@*:id"/>
   <xsl:key name="generic-id" match="*[matches(name(),'^note$')][not(@type='footnote' or @place='foot' or @type='endnote' or @place='end')]|*[matches(name(),'^figure$|^bibl$|^table$')]" use="@*:id"/>
   

   <!-- ====================================================================== -->
   <!-- Root Template                                                          -->
   <!-- ====================================================================== -->
   
   <xsl:template match="/">
      <xsl:choose>
         <!-- robot solution -->
         <xsl:when test="matches($http.user-agent,$robots)">
            <xsl:call-template name="robot"/>
         </xsl:when>
         <xsl:when test="$doc.view='bbar'">
            <xsl:call-template name="bbar"/>
         </xsl:when>
         <xsl:when test="$doc.view='content'">
            <xsl:call-template name="content"/>
         </xsl:when>
         <xsl:when test="$doc.view='popup'">
            <xsl:call-template name="popup"/>
         </xsl:when>
         <xsl:when test="$doc.view='citation'">
            <xsl:call-template name="citation"/>
         </xsl:when>
         <xsl:when test="$doc.view='print'">
            <xsl:call-template name="print"/>
         </xsl:when>
         <xsl:when test="$doc.view='xml'">
            <xsl:call-template name="xml"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="frames"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!-- TEI-specific parameters                                                -->
   <!-- ====================================================================== -->
   
   <!-- If a query was specified but no particular hit rank, jump to the first hit 
        (in document order) 
   -->
   <xsl:param name="hit.rank">
      <xsl:choose>
         <xsl:when test="$query and not($query = '0')">
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'0'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:param>
   
   <!-- To support direct links from snippets, the following two parameters must check value of $hit.rank -->
   <xsl:param name="chunk.id">
      <xsl:choose>
         <xsl:when test="$hit.rank != '0' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
            <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(local-name(),'^div')][1]/@*:id"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'0'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:param>
   
   <xsl:param name="toc.id">
      <xsl:choose>
         <xsl:when test="$hit.rank != '0' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
            <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(local-name(),'^div')][1]/parent::*/@*:id"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'0'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:param>
   
   <!-- ====================================================================== -->
   <!--   Using selector language from resultFormatter                               -->
   <!-- ====================================================================== -->
   
   <xsl:template name="topLevel">
   <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc">
      <strong><xsl:text>Title: "</xsl:text></strong>
         <xsl:value-of select="tei:titleStmt/tei:title[@type='main']"/><xsl:text>"</xsl:text>
   </xsl:for-each> <br/>
     <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt">
        <strong><xsl:text>Author: </xsl:text></strong>
            <xsl:value-of select="tei:author[1]/tei:name/tei:forename[@type='first']"/>
            <xsl:text> </xsl:text>
        <xsl:value-of select="tei:author[1]/tei:name/tei:surname"/>
   </xsl:for-each><br/>
      <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt">
         <strong><xsl:text>Affiliation: </xsl:text></strong>
         <xsl:value-of select="tei:author[1]/tei:name/tei:affiliation"/>
      </xsl:for-each><br/>
      <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt">
         <strong><xsl:text>Conference location: </xsl:text></strong>
         <xsl:value-of select="tei:publisher/tei:name"/>
      </xsl:for-each><br/>
      <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt">
         <strong> <xsl:text>Date: </xsl:text></strong>
         <xsl:value-of select="tei:date"/>
      </xsl:for-each><br/>
</xsl:template>

   <!-- ====================================================================== -->
   <!-- Content Template                                                       -->
   <!-- ====================================================================== -->
   <xsl:template name="content">
      <xsl:for-each select="tei:TEI">
         <h3><xsl:text>Abstract</xsl:text></h3>
         <xsl:value-of select="tei:text"/>
      </xsl:for-each>
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!-- Notes                                                                  -->
   <!-- ====================================================================== -->
   
   <xsl:template match="*:note">
      <xsl:choose>
         <xsl:when test="@type='footnote' or @place='foot'">
            <xsl:if test="$doc.view='popup' or $doc.view='print'">
               <xsl:apply-templates/>
            </xsl:if>
         </xsl:when>
         <xsl:when test="@type='endnote' or @place='end'">
            <xsl:choose>
               <xsl:when test="$anchor.id=@*:id">
                  <a name="X"></a>
                  <div class="note-hi">
                     <xsl:apply-templates/>
                  </div>
               </xsl:when>
               <xsl:otherwise>
                  <div class="note">
                     <xsl:apply-templates/>
                  </div>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="@type='note' or @place='inline'">
            <div class="inline-note">
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <div class="note">
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="*:p[ancestor::note[@type='footnote' or @place='foot']]">
      
      <xsl:variable name="n" select="parent::note/@n"/>
      
      <p>
         <xsl:if test="position()=1">
            <xsl:if test="$n != ''">
               <xsl:text>[</xsl:text><xsl:value-of select="$n"/><xsl:text>] </xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:apply-templates/>
      </p>
      
   </xsl:template>
   
   <xsl:template match="*:p[ancestor::note[@type='endnote' or @place='end']]">
      
      <xsl:variable name="n" select="parent::note/@n"/>
      
      <xsl:variable name="class">
         <xsl:choose>
            <xsl:when test="position()=1">noindent</xsl:when>
            <xsl:otherwise>indent</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <p class="{$class}">
         <xsl:if test="position()=1">
            <xsl:if test="$n != ''">
               <xsl:value-of select="$n"/><xsl:text>. </xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:apply-templates/>
         <xsl:if test="position()=last()">
            <xsl:if test="parent::note/@corresp">
               
               <xsl:variable name="corresp" select="parent::note/@corresp"/>
               
               <xsl:variable name="chunk" select="key('ref-id', $corresp)/ancestor::*[matches(local-name(), '^div[1-6]$')][1]/@*:id"/>
               
               <xsl:variable name="toc" select="key('div-id', $chunk)/parent::*/@*:id"/>
               
               <span class="down1">
                  <xsl:text> [</xsl:text>
                  <a>
                     <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/>&#038;anchor.id=<xsl:value-of select="$corresp"/>#X</xsl:attribute>
                     <xsl:attribute name="target">_top</xsl:attribute>
                     <xsl:text>BACK</xsl:text>
                  </a>
                  <xsl:text>]</xsl:text>
               </span>
            </xsl:if>
         </xsl:if>
      </p>
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!--   References                                                            -->
   <!-- ====================================================================== -->
  
   <xsl:template name="BiblStruct">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="tei:TEI/tei:text/tei:back/tei:listBibl"> 
         <xsl:apply-templates select="tei:biblStruct/tei:monogr"/>
            <xsl:for-each select="tei:biblStruct/tei:relatedItem[@type='constituent']">
              <xsl:apply-templates select="current()"/>
            </xsl:for-each>
   </xsl:template>
   
   <xsl:template match="tei:monogr"><div>
      <xsl:apply-templates select="tei:title"/> <br/> </div><br/>
   </xsl:template>
   
   <xsl:template match="tei:relatedItem[@type='constituent']">
      <xsl:variable name="title" select="tei:biblStruct/tei:analytic/tei:title"/>
      <xsl:variable name="byline">
         <xsl:apply-templates select="tei:biblStruct/tei:analytic/tei:respStmt"/>
      </xsl:variable>
      <xsl:variable name="page" select="tokenize(tei:biblStruct/tei:monogr/tei:imprint/tei:biblScope/@corresp, ' ')[1]"/>
      <a href="#{$page}"><xsl:value-of select="concat($title, ' . . . ', $byline)"/></a>
   </xsl:template>

   <!-- ====================================================================== -->
   <!-- Single-view (was Frames) Template -->
   <!-- ====================================================================== -->
   <xsl:template name="frames" exclude-result-prefixes="#all">   
      <xsl:variable name="bbar.href"><xsl:value-of select="$query.string"/>&#038;doc.view=bbar&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/></xsl:variable> 
      <xsl:variable name="xml.href"><xsl:value-of select="$query.string"/>&#038;doc.view=xml&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/></xsl:variable> 
      <xsl:variable name="toc.href"><xsl:value-of select="$query.string"/>&#038;doc.view=toc&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;<xsl:value-of select="$search"/>#X</xsl:variable>
      <xsl:variable name="content.href"><xsl:value-of select="$query.string"/>&#038;doc.view=content&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/></xsl:variable>
      
      <html xml:lang="en" lang="en">
         <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>
               <xsl:value-of select="$doc.title"/>
            </title>
            <xsl:copy-of select="$brand.links"/>
            <link rel="shortcut icon" href="icons/brand/favicon.ico" />
            <link rel="stylesheet" type="text/css" href="css/brand/tei.css"/>
            <!-- AJAX support -->
            <script src="script/yahoo-dom-event.js" type="text/javascript"/> 
            <script src="script/connection-min.js" type="text/javascript"/> 
         </head>
         <body>         
               <div class="bbar">
                  <xsl:attribute name="name">bbar</xsl:attribute>
                  <xsl:attribute name="src"><xsl:value-of select="$xtfURL"/>view?<xsl:value-of select="$bbar.href"/></xsl:attribute> 
                  <xsl:call-template name="bbar"/>
               </div> 
                <div class="topLevel">
                 <xsl:call-template name="topLevel"/>      
                </div>
            <div class="content">
               <xsl:attribute name="name">content</xsl:attribute>
             <xsl:attribute name="src"><xsl:value-of select="$xtfURL"/>view?<xsl:value-of select="$content.href"/></xsl:attribute> 
               <h2><xsl:text>Abstract</xsl:text></h2>
               <xsl:apply-templates select="/*/*:text/*"/>
            </div>
            <div class="bibliography"><p>
               <xsl:copy-of select="biblStruct"/></p>
            </div>
            <div>
            <xsl:copy-of select="$brand.footer"/>
            </div>
            </body>
         </html>
   </xsl:template>
   

   
   <!-- ====================================================================== -->
   <!-- Print Template                                                  -->
   <!-- ====================================================================== -->
   
   <xsl:template name="print" exclude-result-prefixes="#all">
      <html xml:lang="en" lang="en">
         <head>
            <title>
               <xsl:value-of select="$doc.title"/>
            </title>
            <link rel="stylesheet" type="text/css" href="css/brand/print.css"/>
         </head>
            <div align="center">
               <table width="80%">
                        <tr>
                           <td>
                              <xsl:choose>
                                 <xsl:when test="$chunk.id != '0'">
                                    <xsl:apply-templates select="key('div-id', $chunk.id)"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="topLevel">
                                       <xsl:call-template name="topLevel"/>      
                                    </div>
                                    <xsl:apply-templates select="/*/*:text/*"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </td>
                        </tr>
               </table>
            </div>
      </html>
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!-- Anchor Template                                                        -->
   <!-- ====================================================================== -->
   
   <xsl:template name="create.anchor">
      <xsl:choose>
         <!-- First so it takes precedence over computed hit.rank -->
         <xsl:when test="($query != '0' and $query != '') and $set.anchor != '0'">
            <xsl:text>#</xsl:text><xsl:value-of select="$set.anchor"/>
         </xsl:when>
         <!-- Next is hit.rank -->
         <xsl:when test="($query != '0' and $query != '') and $hit.rank != '0'">
            <xsl:text>#</xsl:text><xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/@hitNum"/>
         </xsl:when>
         <xsl:when test="($query != '0' and $query != '') and $chunk.id != '0'">
            <xsl:text>#</xsl:text><xsl:value-of select="key('div-id', $chunk.id)/@xtf:firstHit"/>
         </xsl:when>
         <xsl:when test="$anchor.id != '0'">
            <xsl:text>#X</xsl:text>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!-- Popup Window Template                                                  -->
   <!-- ====================================================================== -->
  
   <xsl:template name="popup" exclude-result-prefixes="#all">
      <html xml:lang="en" lang="en">
         <head>
            <title>
               <xsl:choose>
                  <xsl:when test="(key('fnote-id', $chunk.id)/@type = 'footnote') or (key('fnote-id', $chunk.id)/@place = 'foot')">
                     <xsl:text>Footnote</xsl:text>
                  </xsl:when>
                  <xsl:when test="key('div-id', $chunk.id)/@type = 'dedication'">
                     <xsl:text>Dedication</xsl:text>
                  </xsl:when>
                  <xsl:when test="key('div-id', $chunk.id)/@type = 'copyright'">
                     <xsl:text>Copyright</xsl:text>
                  </xsl:when>
                  <xsl:when test="key('div-id', $chunk.id)/@type = 'epigraph'">
                     <xsl:text>Epigraph</xsl:text>
                  </xsl:when>
                  <xsl:when test="$fig.ent != '0'">
                     <xsl:text>Illustration</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:text>popup</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </title>
            <link rel="stylesheet" type="text/css" href="css/brand/content.css"/>
            <link rel="shortcut icon" href="icons/brand/favicon.ico" />
 
         </head>
         <body>
            <div class="content">
               <xsl:choose>
                  <xsl:when test="(key('fnote-id', $chunk.id)/@type = 'footnote') or (key('fnote-id', $chunk.id)/@place = 'foot')">
                     <xsl:apply-templates select="key('fnote-id', $chunk.id)"/>  
                  </xsl:when>
                  <xsl:when test="key('div-id', $chunk.id)/@type = 'dedication'">
                     <xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"/>  
                  </xsl:when>
                  <xsl:when test="key('div-id', $chunk.id)/@type = 'copyright'">
                     <xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"/>  
                  </xsl:when>
                  <xsl:when test="key('div-id', $chunk.id)/@type = 'epigraph'">
                     <xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"/>  
                  </xsl:when>
                  <xsl:when test="$fig.ent != '0'">
                     <img src="{$fig.ent}" alt="full-size image"/>        
                  </xsl:when>
               </xsl:choose>
               <p>
                  <a>
                     <xsl:attribute name="href">javascript://</xsl:attribute>
                     <xsl:attribute name="onclick">
                        <xsl:text>javascript:window.close('popup')</xsl:text>
                     </xsl:attribute>
                     <span class="down1">Close this Window</span>
                  </a>
               </p>
            </div>
         </body>
      </html>
   </xsl:template> 
   
   <!-- ====================================================================== -->
   <!-- Navigation Bar Template                                                -->
   <!-- ====================================================================== -->
   
   <xsl:template name="navbar" exclude-result-prefixes="#all">
      
      <xsl:variable name="prev">
         <xsl:choose>
            <!-- preceding div sibling -->
            <xsl:when test="key('div-id', $chunk.id)/preceding-sibling::*[*:head][@*:id]">
               <xsl:value-of select="key('div-id', $chunk.id)/preceding-sibling::*[*:head][@*:id][1]/@*:id"/>
            </xsl:when>
            <!-- last div node in preceding div sibling of parent -->
            <xsl:when test="key('div-id', $chunk.id)/parent::*/preceding-sibling::*[*:head][@*:id]">
               <xsl:value-of select="key('div-id', $chunk.id)/parent::*/preceding-sibling::*[*:head][@*:id][1]/@*:id"/>
            </xsl:when>
            <!-- last div node in any preceding structure-->
            <xsl:when test="key('div-id', $chunk.id)/ancestor::*/preceding-sibling::*/*[*:head][@*:id]">
               <xsl:value-of select="(key('div-id', $chunk.id)/ancestor::*/preceding-sibling::*[1]/*[*:head][@*:id][position()=last()]/@*:id)[last()]"/>
            </xsl:when>
            <!-- top of tree -->
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="prev_toc">
         <xsl:choose>
            <xsl:when test="key('div-id', $prev)/*[*:head][@*:id]">
               <xsl:value-of select="key('div-id', $prev)/@*:id"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="key('div-id', $prev)/parent::*[*:head][@*:id]/@*:id"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="next">
         <xsl:choose>
            <!-- following div sibling -->
            <xsl:when test="key('div-id', $chunk.id)/following-sibling::*[*:head][@*:id]">
               <xsl:value-of select="key('div-id', $chunk.id)/following-sibling::*[*:head][@*:id][1]/@*:id"/>
            </xsl:when>
            <!-- first div node in following div sibling of parent -->
            <xsl:when test="key('div-id', $chunk.id)/parent::*/following-sibling::*[*:head][@*:id]">
               <xsl:value-of select="key('div-id', $chunk.id)/parent::*/following-sibling::*[*:head][@*:id][1]/@*:id"/>
            </xsl:when>
            <!-- first div node in any following structure -->
            <xsl:when test="key('div-id', $chunk.id)/ancestor::*/following-sibling::*/*[*:head][@*:id]">
               <xsl:value-of select="(key('div-id', $chunk.id)/ancestor::*/following-sibling::*[1]/*[*:head][@*:id][1]/@*:id)[1]"/>
            </xsl:when>
            <!-- no previous $chunk.id (i.e. titlePage) -->
            <xsl:when test="$chunk.id='0'">
               <xsl:value-of select="/*/*:text/*[*[*:head][@*:id]][1]/*[*:head][@*:id][1]/@*:id"/>
            </xsl:when>
            <!-- bottom of tree -->
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="next_toc">
         <xsl:choose>
            <xsl:when test="key('div-id', $next)/*[*:head][@*:id]">
               <xsl:value-of select="key('div-id', $next)/@*:id"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="key('div-id', $next)/parent::*[*:head][@*:id]/@*:id"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <tr>
         <td width="25%" align="left">
            <!-- BEGIN PREVIOUS SELECTION -->
            <a target="_top">
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
                     </xsl:attribute>
                     <img src="{$icon.path}b_prev.gif" width="15" height="15" border="0" alt="previous"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <img src="{$icon.path}d_prev.gif" width="15" height="15" border="0" alt="no previous"/>
                  </xsl:otherwise>
               </xsl:choose>
            </a>
            <!-- END PREVIOUS SELECTION -->
         </td>
         <td width="50%" align="center">
            <span class="chapter-text">
               <xsl:value-of select="key('div-id', $chunk.id)/ancestor-or-self::*[matches(@*:type,'fmsec|chapter|bmsec')][1]/*:head[1]"/>
            </span>
         </td>
         <td width="25%" align="right">
            <!-- BEGIN NEXT SELECTION -->
            <a target="_top">
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
                     </xsl:attribute>
                     <img src="{$icon.path}b_next.gif" width="15" height="15" border="0" alt="next"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <img src="{$icon.path}d_next.gif" width="15" height="15" border="0" alt="no next"/>
                  </xsl:otherwise>
               </xsl:choose>
            </a>
            <!-- END NEXT SELECTION -->
         </td>
      </tr>
      
   </xsl:template>
   
</xsl:stylesheet>  