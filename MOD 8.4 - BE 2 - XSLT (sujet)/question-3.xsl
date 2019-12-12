<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html lang="fr-FR" >
      <head>
        <meta charset="utf-8"></meta>
        <link rel="stylesheet" type="text/css" href="question-1.css"/>
        <title>Question-3</title>
      </head>
      <body>
        <xsl:for-each select="ponctualite-transilien/service">
          <div class="service">
            <h1><xsl:value-of select="@nom"></xsl:value-of></h1>
            <div class="lines">
              <xsl:for-each select="ligne">
                <xsl:sort select="@nom"></xsl:sort>

                <div class="line">
                  <h2><xsl:value-of select="@nom"></xsl:value-of></h2>
                  <table>
                    <tr class='header-row'>
                      <th>Date</th>
                      <th>Ponctualite</th>
                      <th>Satisfaction</th>
                    </tr>

                    <xsl:for-each select="annee">
                      <!-- tri en utilisant millesime comme nombre -->
                      <xsl:sort select="@millesime" data-type="number"/>
                      <xsl:for-each select="mesure">
                        <!-- tri en utilisant mois comme nombre -->
                        <xsl:sort select="@mois" data-type="number"/>

                        <xsl:variable name="mois">
                          <xsl:call-template name="lettres_mois">
                            <xsl:with-param name="numero">
                              <xsl:value-of select="@mois"></xsl:value-of>
                            </xsl:with-param>
                          </xsl:call-template>
                        </xsl:variable>

                        <tr class='data-row'>
                          <td><xsl:value-of select="$mois"></xsl:value-of> - <xsl:value-of select="../@millesime"></xsl:value-of></td>
                          <td><xsl:value-of select="round(ponctualite*10)div 10"></xsl:value-of></td>
                          <td><xsl:value-of select="satisfaction"></xsl:value-of></td>
                        </tr>                           
                      </xsl:for-each>
                    </xsl:for-each>

                  </table>
                </div>
              </xsl:for-each>
            </div>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>


  <xsl:template name="lettres_mois">
    <xsl:param name="numero"></xsl:param>
    <xsl:choose>
      <xsl:when test="number($numero)=1">
        <xsl:value-of select="'Janvier'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=2">
        <xsl:value-of select="'Fevrier'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=3">
        <xsl:value-of select="'Mars'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=4">
        <xsl:value-of select="'Avril'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=5">
        <xsl:value-of select="'Mai'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=6">
        <xsl:value-of select="'June'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=7">
        <xsl:value-of select="'Juillet'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=8">
        <xsl:value-of select="'Août'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=9">
        <xsl:value-of select="'Septembre'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=10">
        <xsl:value-of select="'Octobre'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=11">
        <xsl:value-of select="'Novembre'"></xsl:value-of>
      </xsl:when>
      <xsl:when test="number($numero)=12">
        <xsl:value-of select="'Decembre'"></xsl:value-of>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="' - '"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
