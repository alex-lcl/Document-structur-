<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="no"/>
<xsl:template match="/world">
<html>
<head><title> Fiction Interactive: carte du monde enchanté </title>
<style>html{height:750px;}
article #map{    
    background-color:transparent; color: white;
}</style>
</head>
<body><article id="map">
<!-- Légendes de la carte -->
<svg width="30%" height="350px" xmlns="http://www.w3.org/2000/svg" style="float:right">
  <rect id="ex" x="5" y="5" width="100" height="100" visibility="visible" style="fill:white;fill-opacity:0;stroke-width:5;stroke:rgb(0,0,0)" alt="scene04"/>
  <text id="ex" x="23" y="23" visibility="visible" fill="white">Escalier</text>
  <line id="ex" x1="10" y1="10" x2="80" y2="10" visibility="visible" style="stroke:rgb(255, 153, 0);stroke-width:5" />
  <text id="ex" x="110" y="50" fill="white" visibility="visible">Porte</text>
  <line id="ex" x1="100" y1="15" x2="100" y2="80" visibility="visible" style="stroke:rgb(255,0,0);stroke-width:5" />
  <text id="ex" x="50" y="140" fill="white" visibility="visible">Objet</text>
  <rect id="ex" x="130" y="130" width="10" height="10" visibility="visible" style="stroke-width:5;stroke:rgb(0,0,0)" alt="scene04"/>
  <text id="ex" x="50" y="165" fill="white" visibility="visible">Créature</text>
  <text id="ex" x="6" y="95" fill="white" visibility="visible">SceneExemple</text>
  <text id="ex_player" x="50" y="195" fill="white" visibility="visible">Joueur  😀 </text>
  <rect id="ex" x="130" y="160" width="10" height="10" visibility="visible" style="fill: rgb(93, 83, 235);stroke-width:5;stroke:rgb(93, 83, 235)" alt="scene04"/>
</svg>
<h2><xsl:text>Etage 0</xsl:text></h2>
<!-- Carte du Rez de Chaussé -->
<svg width="70%" height="350px" xmlns="http://www.w3.org/2000/svg">
<xsl:for-each select="//scene">
    <xsl:variable name="x" select="@x"/>
    <xsl:variable name="y" select="@y"/>
    <xsl:variable name="id" select="@id"/>
    <xsl:if test="@id != 'scene04'">
        <xsl:choose>
        <xsl:when test="@id='scene07'"><!-- si c'est la scene 07, à l'extérieur -->
            <rect id="{$id}" x="{$x}" y="{$y}" width="220" height="100" visibility="hidden" style="fill:white;fill-opacity:0;stroke-width:5;stroke:green;"/>
            <text id="{$id}" x="{$x+15}" y="{$y+20}" fill="white" visibility="hidden"><xsl:value-of select="@id"/></text>
            <text id="{$id}_player" x="{$x+45}" y="{$y+50}" fill="white" visibility="hidden">😀</text>
            <xsl:call-template name="actions" />
        </xsl:when>
        <xsl:when test="@id='scene06' or @id='scene05'"><!-- si c'est la scene 06 ou 05, à l'extérieur-->
            <rect id="{$id}" x="{$x}" y="{$y}" width="100" height="100" visibility="hidden" style="fill:white;fill-opacity:0;stroke-width:5;stroke:green"/>
            <text id="{$id}" x="{$x+15}" y="{$y+20}" fill="white" visibility="hidden"><xsl:value-of select="@id"/></text>
            <text id="{$id}_player" x="{$x+45}" y="{$y+40}" fill="white" visibility="hidden">😀</text>
            <xsl:call-template name="actions" />
        </xsl:when>
        <xsl:when test="@id='scene00'"><!-- si c'est la scene 00, à l'intérieur-->
            <rect id="{$id}" x="{$x}" y="{$y}" width="100" height="100" visibility="visible" style="fill:white;fill-opacity:0;stroke-width:5;stroke:green"/>
            <text id="{$id}" x="{$x+15}" y="{$y+20}" fill="white" visibility="visible"><xsl:value-of select="@id"/></text>
            <text id="{$id}_player" x="{$x+50}" y="{$y+40}" fill="white" visibility="visible">😀</text>
            <xsl:call-template name="actionsbis" />
        </xsl:when>
        <xsl:otherwise><!-- si c'est une scene à l'intérieur (01, 02, 03)-->
            <rect id="{$id}" x="{$x}" y="{$y}" width="100" height="100" visibility="hidden" style="fill:white;fill-opacity:0;stroke-width:5;stroke:rgb(0,0,0)"/>
            <text id="{$id}" x="{$x+15}" y="{$y+20}" fill="white" visibility="hidden"><xsl:value-of select="@id"/></text>
            <text id="{$id}_player" x="{$x+50}" y="{$y+40}" fill="white" visibility="hidden">😀</text>
            <xsl:call-template name="actions" />
        </xsl:otherwise>
        </xsl:choose>
       
    </xsl:if>
</xsl:for-each>
</svg>
<h2><xsl:text>Etage -1</xsl:text></h2>
<!-- Carte de l'étage -1 -->
<svg width="70%" height="250px" xmlns="http://www.w3.org/2000/svg">
<xsl:for-each select="//scene">
    <xsl:if test="@id = 'scene04'">
        <xsl:variable name="x" select="@x"/>
        <xsl:variable name="y" select="@y"/>
        <xsl:variable name="id" select="@id"/>
        <rect id="{$id}" x="{$x}" y="{$y}" width="100" height="100" visibility="hidden" style="fill:white;fill-opacity:0;stroke-width:5;stroke:rgb(0,0,0)"/>
        <text id="{$id}" x="{$x+15}" y="{$y+20}" fill="white" visibility="hidden">scene04</text>
        <text id="{$id}_player" x="{$x+50}" y="{$y+40}" fill="white" visibility="hidden">😀</text>
        <xsl:call-template name="actions" />
    </xsl:if>
</xsl:for-each>
</svg></article>
</body>
</html>
</xsl:template>
<xsl:template name="actionsbis">
<!-- Pour afficher les objets et les chemins dans une scene -->
<xsl:for-each select="./*">
    <xsl:choose>
            <xsl:when test="contains(@dest, 'path')"> <!-- Pour afficher un chemin -->
                <xsl:variable name="x1" select="@x1"/>
                <xsl:variable name="y1" select="@y1"/>
                <xsl:variable name="x2" select="@x2"/>
                <xsl:variable name="y2" select="@y2"/>
                <xsl:variable name="id" select="@id"/>
                <xsl:choose>
                <xsl:when test="contains( @msj, 'Escalier')"><!-- Si c'est un escalier -->
                    <line id="{$id}" x1="{$x1}" y1="{$y1}" x2="{$x2}" y2="{$y2}" visibility="visible" style="stroke:rgb(255, 153, 0);stroke-width:5;" />
                </xsl:when>
                <xsl:otherwise> <!-- Si c'est une porte -->
                    <line id="{$id}" x1="{$x1}" y1="{$y1}" x2="{$x2}" y2="{$y2}" visibility="visible" style="stroke:rgb(255, 0, 0);stroke-width:5;" />
                </xsl:otherwise>
                </xsl:choose>
      
            </xsl:when>
            <xsl:when test="contains(@dest, 'creature')"> <!-- Pour afficher une créature -->
                <xsl:variable name="x3" select="@x"/>
                <xsl:variable name="y3" select="@y"/>
                <xsl:variable name="id" select="@id"/>
                <rect id="{$id}" x="{$x3}" y="{$y3}" width="10" height="10" visibility="visible" style="fill:rgb(93, 83, 235); stroke:rgb(93, 83, 235);stroke-width:5;" />
            </xsl:when>
            <xsl:otherwise> <!-- Pour afficher un objet -->
                <xsl:variable name="x3" select="@x"/>
                <xsl:variable name="y3" select="@y"/>
                <xsl:variable name="id" select="@id"/>
                <rect id="{$id}" x="{$x3}" y="{$y3}" width="10" height="10" visibility="visible" style="fill:rgb(0, 0, 0);stroke:rgb(0,0,0);stroke-width:5;" />
            </xsl:otherwise>
    </xsl:choose>
</xsl:for-each>
</xsl:template>
<xsl:template name="actions">
<!-- Pour afficher les objets et les chemins dans une scene -->
<xsl:for-each select="./*">
    <xsl:choose>
            <xsl:when test="contains(@dest, 'path')"> <!-- Pour afficher un chemin -->
                <xsl:variable name="x1" select="@x1"/>
                <xsl:variable name="y1" select="@y1"/>
                <xsl:variable name="x2" select="@x2"/>
                <xsl:variable name="y2" select="@y2"/>
                <xsl:variable name="id" select="@id"/>
                <xsl:choose>
                <xsl:when test="contains( @msj, 'Escalier')"><!-- Si c'est un escalier -->
                    <line id="{$id}" x1="{$x1}" y1="{$y1}" x2="{$x2}" y2="{$y2}" visibility="hidden" style="stroke:rgb(255, 153, 0);stroke-width:5;" />
                </xsl:when>
                <xsl:otherwise> <!-- Si c'est une porte -->
                    <line id="{$id}" x1="{$x1}" y1="{$y1}" x2="{$x2}" y2="{$y2}" visibility="hidden" style="stroke:rgb(255, 0, 0);stroke-width:5;" />
                </xsl:otherwise>
                </xsl:choose>
      
            </xsl:when>
            <xsl:when test="contains(@dest, 'creature')"> <!-- Pour afficher une créature -->
                <xsl:variable name="x3" select="@x"/>
                <xsl:variable name="y3" select="@y"/>
                <xsl:variable name="id" select="@id"/>
                <rect id="{$id}" x="{$x3}" y="{$y3}" width="10" height="10" visibility="hidden" style="fill:rgb(93, 83, 235); stroke:rgb(93, 83, 235);stroke-width:5;" />
            </xsl:when>
            <xsl:otherwise> <!-- Pour afficher un objet -->
                <xsl:variable name="x3" select="@x"/>
                <xsl:variable name="y3" select="@y"/>
                <xsl:variable name="id" select="@id"/>
                <rect id="{$id}" x="{$x3}" y="{$y3}" width="10" height="10" visibility="hidden" style="fill:rgb(0, 0, 0);stroke:rgb(0,0,0);stroke-width:5;" />
            </xsl:otherwise>
    </xsl:choose>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>