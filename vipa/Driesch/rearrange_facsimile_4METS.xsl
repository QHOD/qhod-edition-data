<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:template match="/">
       <xsl:apply-templates/>    
    </xsl:template>

    <xsl:template match="@* | text()" priority="-1">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="*" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@* | text() | *"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:facsimile">
        <xsl:copy select="t:surface">
            <xsl:attribute name="start" select="concat('#', ancestor::t:facsimile/@xml:id)"/>
            <xsl:apply-templates select="@*|*|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:graphic">
        <xsl:copy select=".">
            <xsl:apply-templates select="@*|*|text()"/>
            <xsl:attribute name="xml:id" select="ancestor::t:facsimile/@xml:id"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
