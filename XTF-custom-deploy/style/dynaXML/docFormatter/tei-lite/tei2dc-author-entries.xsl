<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
  
  <xsl:strip-space elements="*"/>
  
  <xsl:variable name="srcId">
    <xsl:value-of select="/TEI.2/teiHeader/fileDesc/publicationStmt/idno"></xsl:value-of>
  </xsl:variable>
  
  <xsl:template match="*"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="TEI.2"/>
  </xsl:template>
  
  <xsl:template match="TEI.2">
    <xsl:element name="x">
      <xsl:element name="dc">
        <xsl:apply-templates select="text/body/descendant::div[@type='entry']/head"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="head">
    <!--<xsl:variable name="srcId">
      <xsl:value-of select="/TEI.2/teiHeader/fileDesc/publicationStmt/idno"></xsl:value-of>
    </xsl:variable>-->
    <xsl:variable name="entryId">
      <xsl:value-of select="parent::*[@type='entry']/@id"/>
    </xsl:variable>
    <xsl:element name="creator">
      <xsl:attribute name="content"><xsl:text>entry</xsl:text></xsl:attribute>
      <xsl:attribute name="src">
        <xsl:value-of select="$srcId"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$entryId"/>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>