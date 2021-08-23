<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">

    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
    <xsl:template match="tei:teiHeader">
        <!-- <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>
                <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/>
            </title>
            <link href="http://www.tei-c.org/release/xml/tei/stylesheet/tei.css" rel="stylesheet" type="text/css"/>
            <link rel="stylesheet" media="print" type="text/css" href="http://www.tei-c.org/release/xml/tei/stylesheet/tei-print.css"/>
        </head> -->
    </xsl:template>

    <!-- <xsl:template match="tei:TEI">
        <html dir="rtl">
            <xsl:apply-templates/>
        </html>
    </xsl:template>

    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template> -->

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

    <xsl:template match="tei:seg">
      <seg data-toggle="popover" data-placement="bottom">
            <xsl:attribute name="data-content"><xsl:value-of select="//tei:app[@corresp=concat('#', current()/@xml:id)]"/></xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </seg>
    </xsl:template>

    <xsl:template match="tei:app">
    </xsl:template>

    <xsl:template match="@xml:id">
        <xsl:attribute name="id"><xsl:value-of select='.' /></xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
