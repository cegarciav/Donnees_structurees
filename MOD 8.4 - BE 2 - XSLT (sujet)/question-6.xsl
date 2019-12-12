<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- obtention de la date la plus recente grace aux templates parametres -->

  <xsl:variable name="max_annee">
    <xsl:call-template name="max">
      <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee/@millesime">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="max_mois">
    <xsl:call-template name="max">
      <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee[@millesime = $max_annee]/mesure/@mois">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="max_mois_lettres">
    <xsl:call-template name="lettres_mois">
      <xsl:with-param name="numero">
        <xsl:value-of select="$max_mois"></xsl:value-of>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <!-- obtention de la date la plus ancienne grace aux templates parametres -->

  <xsl:variable name="min_annee">
    <xsl:call-template name="min">
      <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee/@millesime">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="min_mois">
    <xsl:call-template name="min">
      <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee[@millesime = $min_annee]/mesure/@mois">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="min_mois_lettres">
    <xsl:call-template name="lettres_mois">
      <xsl:with-param name="numero">
        <xsl:value-of select="$min_mois"></xsl:value-of>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:template match="/">
    <html lang="fr-FR" >
      <head>
        <meta charset="utf-8"></meta>
        <link rel="stylesheet" type="text/css" href="question-6.css"/>
        <title>Question-4</title>
      </head>
      <body>
        <h1 class="big-title">
          Ponctualité des lignes transiliennes de <xsl:value-of select="$min_mois_lettres"></xsl:value-of><xsl:text> </xsl:text> - <xsl:value-of select="$min_annee"></xsl:value-of><xsl:text> </xsl:text> à <xsl:value-of select="$max_mois_lettres"></xsl:value-of><xsl:text> </xsl:text> - <xsl:value-of select="$max_annee"></xsl:value-of><xsl:text> </xsl:text>
        </h1>

        <xsl:for-each select="ponctualite-transilien/service">
          <div class="service">
            <h1><xsl:value-of select="@nom"></xsl:value-of></h1>
            <div class="lines">
              <xsl:for-each select="ligne">
                <xsl:sort select="@nom"></xsl:sort>
                <div class="line">
                  <!--
                    variable "couleur" contenant la couleur retournee
                    par le template "couleur_ligne" selon la sigle
                    unique d'une ligne
                  -->
                  <xsl:variable name="couleur">
                    <xsl:call-template name="couleur_ligne">
                      <xsl:with-param name="ligne" select="@sigle"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <h2>
                    <font color="{$couleur}">
                      <xsl:value-of select="@nom"></xsl:value-of>
                    </font> 
                  </h2>
                  <table>
                    <tr class='header-row'>
                      <!-- pour ajouter la couleur dans les entetes -->
                      <xsl:attribute name="style">
                        <xsl:text>background-color:</xsl:text>
                        <xsl:value-of select="$couleur"/>
                      </xsl:attribute>
                      <th>Date</th>
                      <th>Ponctualite</th>
                      <th>Satisfaction</th>
                    </tr>

                    <xsl:for-each select="annee">
                      <xsl:sort select="@millesime" data-type="number"/>
                      <xsl:for-each select="mesure">
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

  <!-- 
    templates pour obtenir la valeur numerique la plus grande
    (name="max") ou la plus petite (name="min") d'un ensemble
    de noeuds mis sur le parametre "liste"
   -->

  <xsl:template name="max">
    <xsl:param name="liste"/>
    <xsl:for-each select="$liste">
      <!--
        utilisation de l'attribut order avec la valeur "descending"
        pour laisser dans la première possition la valeur la plus
        grande. Alternative : utiliser position() = last() avec
        order par defaut.
      -->
      <xsl:sort select="." data-type="number" order="descending"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="."/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="min">
    <xsl:param name="liste"/>
    <xsl:for-each select="$liste">
      <!-- 
        le sort a par defaut une valeur "ascending" pour
        l'attribut order. Alors, le premier element sera le
        plus petit
      -->
      <xsl:sort select="." data-type="number"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="."></xsl:value-of>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!--
    template pour faire le lien entre la couleur d'une ligne mis
    dans le parametre "ligne" et une couleur dans le noeud
    code-couleur-transilien (nous savons qu'il n'y a qu'un noeud
    avec ce nom). Nous utilisons la valeur hexadecimale pour
    ajouter la couleur dans le style du fichier final
  -->

  <xsl:template name="couleur_ligne">
    <xsl:param name="ligne"></xsl:param>
    <xsl:value-of select="//code-couleur-transilien/ligne[@sigle=$ligne]/@hex"></xsl:value-of>
  </xsl:template>


</xsl:stylesheet>


