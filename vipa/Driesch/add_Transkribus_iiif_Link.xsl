<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:variable name="trpData" select="document('trp.xml')"/>
    <xsl:variable name="iiifprefix" select="'https://files.transkribus.eu/iiif/2/'"/>
    <xsl:variable name="iiifsuffix" select="'/full/max/0/default.jpg'"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:graphic[ancestor::tei:facsimile]">
        <xsl:variable name="origuri" select="@url"/>
        <xsl:copy>
            <xsl:attribute name="url">
                <xsl:value-of select="$iiifprefix"/>
                <xsl:value-of select="$trpData//pageList/pages[imgFileName=$origuri]/key"/>
                <xsl:value-of select="$iiifsuffix"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:graphic/@url">
        <xsl:attribute name="sameAs">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>