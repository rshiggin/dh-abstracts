<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
  
  <xsl:strip-space elements="*"/>
  
  <xsl:template match="*"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="TEI.2"/>
  </xsl:template>
  
  <xsl:template match="TEI.2">
    <xsl:element name="x">
      <xsl:element name="dc">
        <xsl:apply-templates select="teiHeader"/>
        <xsl:element name="contentType">
          <xsl:text>Book</xsl:text>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="teiHeader">
    <xsl:apply-templates select="fileDesc/sourceDesc">
      <xsl:with-param name="type" select="'dc'"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="fileDesc/publicationStmt/idno">
      <xsl:with-param name="type" select="'dc'"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="sourceDesc">
    <xsl:param name="type"/>
    <xsl:apply-templates>
      <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="biblFull">
    <xsl:param name="type"/>
    <xsl:apply-templates select="extent"/>
    <xsl:apply-templates>
      <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="titleStmt">
    <xsl:param name="type"/>
    <xsl:apply-templates >
      <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="publicationStmt">
    <xsl:param name="type"/>
    <xsl:apply-templates>
      <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="title">
    <xsl:param name="type"/>
    <xsl:if test="not(@type='gmd')">
      <xsl:choose>
        <xsl:when test="$type='dc'">
          <xsl:call-template name="dc_title"/>
        </xsl:when>
        <xsl:when test="$type='x'">
          <xsl:call-template name="x_title"/>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="date[1]">
    <xsl:param name="type"/>
    <xsl:if test="$type='dc'">
      <xsl:call-template name="dc_date"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="extent[1]">
    <xsl:param name="type"/>
    <xsl:if test="$type='dc'">
      <xsl:call-template name="dc_extent"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="pubPlace[1]">
    <xsl:param name="type"/>
    <xsl:if test="$type='dc'">
      <xsl:call-template name="dc_pubPlace"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="publisher[1]">
    <xsl:param name="type"/>
    <xsl:if test="$type='dc'">
      <xsl:call-template name="dc_publisher"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="idno[1]">
    <xsl:param name="type"/>
    <xsl:if test="$type='dc'">
      <xsl:call-template name="dc_identifier"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="author">
    <xsl:param name="type"/>
    <xsl:if test="$type='dc'">
      <xsl:call-template name="dc_author"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="dc_title">
    <xsl:choose>
      <xsl:when test=".[@type='filing']">
        <xsl:element name="filingTitle">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test=".[@type='main']">
        <xsl:element name="title">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise> 
        <xsl:element name="subTitle">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="x_title">
    <xsl:element name="xtitle">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="x_creator">
    <xsl:element name="xcreator">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="dc_identifier">
    <xsl:element name="identifier">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="dc_author">
    <xsl:element name="creator">
      <xsl:if test="./name/@type='pseudonym'">
        <xsl:attribute name="type">pseudonym</xsl:attribute>
      </xsl:if>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  
  <xsl:template name="dc_date">
    <xsl:element name="date">
      <xsl:choose>
        <xsl:when test=".[@when != '']">
          <xsl:value-of select="./@when"/>
        </xsl:when>
        <xsl:when test=".[@from != '']">
          <xsl:value-of select="./@from"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
    <xsl:element name="dateDisplay">
      <xsl:value-of select="."/>
    </xsl:element>
    <xsl:variable name="date">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:variable name="cleandate">
      <xsl:value-of select='replace($date, "\D","")'/>
    </xsl:variable>
    <xsl:choose >
      <xsl:when test="$cleandate != ''">
        <xsl:variable name="decadeLower">
          <xsl:value-of select='replace($cleandate, "(\d{3})\d*","$10")'/>
        </xsl:variable>
        <xsl:variable name="decadeUpper">
          <xsl:value-of select="$decadeLower + 9"/>
        </xsl:variable>
        <xsl:element name="daterange">
          <xsl:value-of select="$decadeLower"/><xsl:text>-</xsl:text><xsl:value-of select="$decadeUpper"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="daterange">
          <xsl:text>Date Unknown</xsl:text>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="dc_pubPlace">
    <xsl:element name="pubPlace">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="dc_publisher">
    <xsl:element name="publisher">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="dc_extent">
    <xsl:element name="extent">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>
  
  
</xsl:stylesheet>