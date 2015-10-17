<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:iutei="http://www.dlib.indiana.edu/collections/tei/"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
  
  <xsl:strip-space elements="*"/>
  
  <xsl:include href="../../../iutei.xsl"/>
  
  <xsl:template match="*"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="TEI.2"/>
  </xsl:template>
  
  <xsl:template match="TEI.2">
    <xsl:element name="x">
      <xsl:element name="dc">
        <xsl:apply-templates select="text/body/descendant::div[@type='entry']/descendant::bibl"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="bibl">
    <xsl:variable name="entryId">
      <xsl:value-of select="ancestor::*[@type='entry']/@id"/>
    </xsl:variable>
    <xsl:variable name="href" select="./title/xref/@xlink:href"/>
    <xsl:element name="title">
      <xsl:attribute name="content"><xsl:text>entry</xsl:text></xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$entryId"/>
      </xsl:attribute>
      <xsl:if test="./title/xref">
        <xsl:if test="iutei:docExists($href) eq 'true'">
          <xsl:attribute name="href">
            <xsl:value-of select="$href"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  

  
</xsl:stylesheet>