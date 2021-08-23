<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">

    <xsl:param name="layer"/>

    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
    <xsl:template match="tei:teiHeader">
    </xsl:template>

    <xsl:template match="tei:body">
        <body>
            <xsl:apply-templates/>
        </body>
    </xsl:template>

    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template name="findVariant">
        <xsl:param name="current-layer"/>
        <xsl:param name="app"/>
        <xsl:choose>
            <xsl:when test="$app/tei:rdg[@change=concat('#', $current-layer)]">
                <xsl:attribute name="rend">
                    <xsl:value-of select="$current-layer"/>
                </xsl:attribute>
                <xsl:copy-of select="$app/tei:rdg[@change=concat('#', $current-layer)]/node()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="findVariant">
                    <xsl:with-param name="current-layer" select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:listChange/tei:change[@xml:id=$current-layer]/preceding-sibling::tei:change[1]/@xml:id"/>
                    <xsl:with-param name="app"
                        select="$app"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:seg">
        <seg>
            <xsl:apply-templates select="@*"/>
            <xsl:variable name="app" select="//tei:app[@corresp=concat('#', current()/@xml:id)]"/>
            <xsl:call-template name="findVariant">
                <xsl:with-param name="app" select="$app"/>
                <xsl:with-param name="current-layer" select="$layer"/>
            </xsl:call-template>
        </seg>
    </xsl:template>

    <xsl:template match="tei:app"/>

    <xsl:template match="@xml:id">
        <xsl:attribute name="id"><xsl:value-of select='.' /></xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
