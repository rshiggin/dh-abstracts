<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:strip-space elements="*"/>

<xsl:template match="*"/>

<xsl:template match="/">
 <xsl:apply-templates select="TEI/teiHeader/fileDesc"/> 
</xsl:template>

  

<xsl:template match="TEI/teiHeader/fileDesc">
    <xsl:element name="dt">Title:</xsl:element>
    <xsl:element name="dd"><xsl:value-of select="sourceDesc/biblFull/titleStmt/title"/></xsl:element>
    <xsl:element name="dt">Author:</xsl:element>
    <xsl:element name="dd"><xsl:value-of select="titleStmt/author"/></xsl:element>
    <xsl:element name="dt">Publication Year:</xsl:element>
    <xsl:element name="dd"><xsl:value-of select="sourceDesc/biblFull/publicationStmt/date"/></xsl:element>
    <xsl:element name="dt">Source:</xsl:element>
    <xsl:element name="dd">
      <xsl:value-of select="sourceDesc/biblFull/publicationStmt/pubPlace"/><xsl:text>: </xsl:text>
      <xsl:value-of select="sourceDesc/biblFull/publicationStmt/publisher"/><xsl:text>, </xsl:text>
      <xsl:value-of select="sourceDesc/biblFull/publicationStmt/date"/><xsl:text>. </xsl:text>
      <xsl:value-of select="sourceDesc/biblFull/extent"/>
    </xsl:element>
</xsl:template>
  
</xsl:stylesheet>

