<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
<!-- XSL to convert XML GDCM2 data dictionay into HTML form -->
<!--
  Program: GDCM (Grass Root DICOM). A DICOM library
  Module:  $URL$

  Copyright (c) 2006 Mathieu Malaterre
  Copyright (c) 1993-2005 CREATIS
  All rights reserved.
  See Copyright.txt or http://gdcm.sourceforge.net/Copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.  See the above copyright notice for more information.
-->
  <xsl:template match="/">
    <xsl:variable name="has_owner" select="dict/entry/@owner"/>
    <xsl:variable name="has_retired" select="dict/entry/@retired"/>
    <html>
      <body>
        <table border="1">
          <tr bgcolor="#d6d6d6">
<!--rgb(214,214,214) -->
            <th>Tag</th>
            <th>VR</th>
            <th>VM</th>
            <th>Description</th>
            <th>Version</th>
            <xsl:choose>
              <xsl:when test="$has_owner">
                <th>Owner</th>
              </xsl:when>
              <xsl:when test="$has_retired">
                <th>Retired</th>
              </xsl:when>
              <xsl:otherwise>
                <th>bla</th>
              </xsl:otherwise>
            </xsl:choose>
          </tr>
<!-- The main template that loop over all dict/entry -->
          <xsl:for-each select="dict/entry">
            <xsl:variable name="my_italic" value="@retired != 'false'"/>
            <tr>
              <td>
<!--xsl:if test="@retired != 'false'"><i></xsl:if-->
                <xsl:text>(</xsl:text>
                <xsl:value-of select="@group"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@element"/>
                <xsl:text>)</xsl:text>
<!--xsl:if test="$my_italic"></i></xsl:if-->
              </td>
              <td>
                <xsl:for-each select="representations/representation">
                  <xsl:value-of select="@vr"/>
                  <xsl:if test="position() != last()">
                    <br/>
                  </xsl:if>
                </xsl:for-each>
              </td>
              <td>
                <xsl:for-each select="representations/representation">
                  <xsl:value-of select="@vm"/>
                  <xsl:if test="position() != last()">
                    <br/>
                  </xsl:if>
                </xsl:for-each>
              </td>
              <td>
                <xsl:value-of select="description"/>
              </td>
              <td>
                <xsl:value-of select="@version"/>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="$has_owner">
                    <xsl:value-of select="@owner"/>
                  </xsl:when>
                  <xsl:when test="$has_retired">
                    <xsl:if test="@retired != 'false'">
                      <xsl:text> (RET)</xsl:text>
                    </xsl:if>
                  </xsl:when>
                </xsl:choose>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
