<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <!-- element racine avec nom = html, donc output html par defaut -->
    <!--
        pour obtenir du XHTML comme output, changer la balise <html lang="fr-FR">
        par <html xmlns="http://www.w3.org/1999/xhtml" lang="fr-FR">
    -->
    <html lang="fr-FR">
      <head>
        <!--
            pour obtenir du XHTML comme output, changer la balise
            <meta charset="utf-8"> par <meta content="text/html">
        --> 
        <meta charset="utf-8"></meta>
        <link rel="stylesheet" type="text/css" href="question-1.css"/>
        <title>Question-1</title>
      </head>
      <body>
        <xsl:for-each select="ponctualite-transilien/service">
          <div class="service">
            <h1><xsl:value-of select="@nom"/></h1>
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
                        <tr class='data-row'>
                          <td><xsl:value-of select="@mois"/> - <xsl:value-of select="../@millesime"/></td>
                          <!-- 
                              Astuce pour ne garder qu'un digit apres virgule. Si
                              jamais l'approximation n'etait pas le comportement
                              desire, nous pourrions utiliser quelque chose comme

                                <td>
                                  <xsl:choose>
                                    <xsl:when test="not(substring-before(ponctualite, '.'))">
                                      <xsl:value-of select="ponctualite"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:value-of select="substring-before(ponctualite, '.')"/>.<xsl:value-of select="substring(substring-after(ponctualite, '.'), 1, 1)"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </td>
                              
                              cette structure permet de ne garder qu'un decimal sans
                              approximation 
                          -->
                          <td><xsl:value-of select="round(ponctualite * 10) div 10"/></td>
                          <td><xsl:value-of select="satisfaction"/></td>
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

</xsl:stylesheet>


