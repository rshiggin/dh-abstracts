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

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:variable name="uniqueKey" select="replace(replace($docId,'^.+/',''), '\.xml$', '')"/>

<xsl:template match="titlePage">

    <div id="titlepage" class="center {@rend}">
      	<xsl:apply-templates select="/TEI.2/text/front/titlePage/*" mode="titlepage"/>
    </div>

</xsl:template>

<xsl:template match="docEdition" mode="titlepage">
	<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="titlePart" mode="titlepage">
  <xsl:choose>
    <xsl:when test="@type='subtitle'">
      <h2 class="italic"><xsl:apply-templates/></h2>
    </xsl:when>
    <xsl:otherwise>
      <h2><xsl:apply-templates/></h2>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="docTitle" mode="titlepage">
	<h2 class="centerbold"><xsl:apply-templates/></h2>
</xsl:template>

<xsl:template match="docAuthor" mode="titlepage">
  <xsl:choose>
    <xsl:when test="name">
      <xsl:apply-templates mode="titlepage"/>
    </xsl:when>
    <xsl:otherwise>
      <h2 class="inline"><xsl:apply-templates/></h2>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="docAuthor/name" mode="titlepage">
  <h2 class="inline"><xsl:apply-templates/></h2>
</xsl:template>

<xsl:template match="docAuthor/address" mode="titlepage">
  <h3><xsl:apply-templates/></h3>
</xsl:template>

<xsl:template match="docImprint" mode="titlepage">
	<h3><xsl:apply-templates/></h3>
</xsl:template>

<xsl:template match="docImprint/publisher" mode="titlepage">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="docImprint/pubPlace" mode="titlepage">
  <span class="italic"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="milestone" mode="titlepage">
	<xsl:choose>
  		<xsl:when test="@rend">
  			<p class="{@rend}"><xsl:value-of select="@n"/></p>
  		</xsl:when>
  		<xsl:otherwise>
		  	<xsl:value-of select="@n"/>
		</xsl:otherwise>
  	</xsl:choose>
</xsl:template>

<xsl:template match="epigraph" mode="titlepage">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="docImprint/docDate" mode="titlepage">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="*[@type='dedication']" mode="titlepage">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="*[@type='copyright']" mode="titlepage">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="*[@type='epigraph']" mode="titlepage">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="lb" mode="titlepage">
  	<xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
</xsl:template>

</xsl:stylesheet>
