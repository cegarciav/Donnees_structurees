<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" encoding="utf-8"/>
  <xsl:param name="date"/>

  <xsl:variable name="max_annee">
    <xsl:call-template name="max">
      <xsl:with-param name="liste" select="//mesure/@annee">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="max_mois">
    <xsl:call-template name="max">
      <xsl:with-param name="liste" select="//mesure/@mois">
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
      <xsl:with-param name="liste" select="//mesure/@annee">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="min_mois">
    <xsl:call-template name="min">
      <xsl:with-param name="liste" select="//mesure/@mois">
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

    <xsl:variable name="title">
      <xsl:text>Rapport sur la régularité des TGV</xsl:text>
    </xsl:variable>

    <xsl:variable name="subtitle">
      <xsl:copy-of select="$min_mois_lettres"/>
      <xsl:text> </xsl:text>
      <xsl:copy-of select="$min_annee"/>
      <xsl:text> - </xsl:text>
      <xsl:copy-of select="$max_mois_lettres"/>
      <xsl:text> </xsl:text>
      <xsl:copy-of select="$max_annee"/>
    </xsl:variable>

  <xsl:variable name="header">
    <fo:static-content flow-name="xsl-region-before">
      <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="50%"
                          number-columns-repeated="2"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell text-align="left"
                            font-size="0.7em">
              <fo:block padding-top="8mm"
                        start-indent="8mm">
                <xsl:copy-of select="$title"/>
                <xsl:text> </xsl:text>
                <xsl:copy-of select="$subtitle"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right"
                            font-size="0.7em">
              <fo:block padding-top="8mm"
                         end-indent="8mm">
                Belen DEL EGIDO GRANDE
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="left"
                            font-size="0.7em">
              <fo:block></fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right"
                            font-size="0.7em">
              <fo:block end-indent="8mm">
                Camilo GARCÍA VERGARA
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:static-content>
  </xsl:variable>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="title-page"
                               page-height="29.7cm"
                               page-width="21cm"
                               margin="25mm">
          <fo:region-body/>
          <fo:region-after margin="0mm"
                            extent="20mm"/>
        </fo:simple-page-master>

        <fo:simple-page-master master-name="corpus-page"
                               page-height="29.7cm"
                               page-width="21cm">
          <fo:region-body margin="20mm"/>
          <fo:region-before margin="0mm"
                            extent="20mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="title-page">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="right"
                    font-size="0.8em"
                    padding-top="8mm"
                    end-indent="8mm">
            <xsl:text>Dernière modification : </xsl:text>
            <xsl:copy-of select="$date"/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <fo:block font-family="Helvetica"
                    font-size="250%"
                    padding-top="50mm"
                    letter-spacing="0.1em"
                    text-align="center">
            <xsl:copy-of select="$title"/>
          </fo:block>
          <fo:block font-family="Helvetica"
                    font-size="200%"
                    padding-top="5mm"
                    letter-spacing="0.1em"
                    text-align="center">
            <xsl:copy-of select="$subtitle"/>
          </fo:block>
          <fo:block font-family="Helvetica"
                    space-before="2cm"
                    font-style="italic"
                    font-size="90%"
                    start-indent="2cm"
                    end-indent="2cm"
                    text-align="justify">
            <fo:inline font-weight="bold">N.B. </fo:inline>
            <xsl:text>Ce rapport a été créé dans le cadre du troisième Bureau d'Etudes du cours de troisième année de l'Ecole Centrale de Lyon, intitulé "Représentation et Manipulation de Données Structurées", par le binôme Belén del Egido Grande et Camilo García Vergara</xsl:text>
          </fo:block>
          <fo:block page-break-after="always"
                    text-align="left"
                    space-before="2cm">
            <!--
              image telecharge de l'Internet, elle ne
              nous appartient pas
            -->
            <fo:external-graphic content-width="50%"
                                  content-height="50%"
                                  src="url(train_icon.svg)"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="corpus-page">
        <xsl:copy-of select="$header"/>
        <fo:flow flow-name="xsl-region-body">
          <xsl:for-each select="regularite-tgv/axe">
            <fo:block page-break-after="always">
              <fo:block font-size="150%"
                        font-family="Helvetica"
                        letter-spacing="0.1em"
                        space-after="3mm">
                <xsl:number/>
                <xsl:text>. Axe </xsl:text>
                <xsl:value-of select="@nom"/>
              </fo:block>
              <xsl:for-each select="gare-depart">
                <xsl:for-each select="gare-arrivee">
                  <fo:block page-break-inside="avoid"
                            space-after="5mm">
                    <fo:block font-size="100%"
                              font-family="Helvetica"
                              letter-spacing="0.1em"
                              space-after="3mm">
                      <xsl:value-of select="../@nom"/>
                      <xsl:text> - </xsl:text>
                      <xsl:value-of select="@nom"/>
                    </fo:block>
                    <fo:block font-size="85%"
                              font-family="Helvetica"
                              letter-spacing="0.1em"
                              space-after="3mm"
                              text-decoration="underline">
                      <xsl:text>Tableau des statistiques</xsl:text>
                    </fo:block>
                    <fo:table table-layout="fixed"
                              width="100%"
                              border="0.5pt solid #000000">
                      <fo:table-column column-width="20%"/>
                      <fo:table-column column-width="16%"
                                        number-columns-repeated="5"/>
                      <fo:table-body>
                        <fo:table-row border="0.5pt solid #000000">
                          <fo:table-cell text-align="center"
                                          border="0.5pt solid #000000"
                                          background-color="#d32424">
                            <fo:block font-size="60%"
                                      color="#FFFFFF">
                              <xsl:text>Date</xsl:text>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="center"
                                          border="0.5pt solid #000000"
                                          background-color="#d32424">
                            <fo:block font-size="60%"
                                      color="#FFFFFF">
                              <xsl:text>Trains prevus</xsl:text>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="center"
                                          border="0.5pt solid #000000"
                                          background-color="#d32424">
                            <fo:block font-size="60%"
                                      color="#FFFFFF">
                              <xsl:text>Trains ok</xsl:text>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="center"
                                          border="0.5pt solid #000000"
                                          background-color="#d32424">
                            <fo:block font-size="60%"
                                      color="#FFFFFF">
                              <xsl:text>Annulés</xsl:text>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="center"
                                          border="0.5pt solid #000000"
                                          background-color="#d32424">
                            <fo:block font-size="60%"
                                      color="#FFFFFF">
                              <xsl:text>Retards</xsl:text>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="center"
                                          border="0.5pt solid #000000"
                                          background-color="#d32424">
                            <fo:block font-size="60%"
                                      color="#FFFFFF">
                              <xsl:text>Régularité</xsl:text>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <xsl:for-each select="mesure">
                          <xsl:sort select="@annee" data-type="number"/>
                          <xsl:sort select="@mois" data-type="number"/>
                          <xsl:variable name="trains_prevus">
                            <xsl:value-of select="@trains-prevus"/>
                          </xsl:variable>
                          <xsl:variable name="trains_ok">
                            <xsl:value-of select="@trains-ok"/>
                          </xsl:variable>
                          <xsl:variable name="trains_annules">
                            <xsl:value-of select="@annules"/>
                          </xsl:variable>
                          <xsl:variable name="trains_retards">
                            <xsl:value-of select="@retards"/>
                          </xsl:variable>
                          <xsl:variable name="trains_regularite">
                            <xsl:value-of select="@regularite"/>
                          </xsl:variable>
                          <xsl:call-template name="row4table">
                            <xsl:with-param name="date-cell"
                                            select="concat(@mois, '-', @annee)"/>
                            <xsl:with-param name="prevus-cell"
                                            select="$trains_prevus"/>
                            <xsl:with-param name="ok-cell"
                                            select="$trains_ok"/>
                            <xsl:with-param name="annules-cell"
                                            select="$trains_annules"/>
                            <xsl:with-param name="retards-cell"
                                            select="$trains_retards"/>
                            <xsl:with-param name="regularite-cell"
                                            select="$trains_regularite"/>
                          </xsl:call-template>
                        </xsl:for-each>
                      </fo:table-body>
                    </fo:table>
                  </fo:block>
                  <fo:block space-after="3mm">
                    <fo:block font-size="85%"
                              font-family="Helvetica"
                              letter-spacing="0.1em"
                              space-after="3mm"
                              text-decoration="underline">
                      <xsl:text>Commentaires</xsl:text>
                    </fo:block>
                    <xsl:for-each select="mesure">
                      <xsl:sort select="@annee" data-type="number"/>
                      <xsl:sort select="@mois" data-type="number"/>
                      <xsl:if test="string-length(@commentaire) > 0">
                        <xsl:variable name="current_month">
                          <xsl:call-template name="lettres_mois">
                            <xsl:with-param name="numero">
                              <xsl:value-of select="@mois"></xsl:value-of>
                            </xsl:with-param>
                          </xsl:call-template>
                        </xsl:variable>
                        <fo:block font-family="Helvetica"
                                  font-size="75%"
                                  space-after="2mm"
                                  text-align="justify">
                          <fo:inline font-weight="bold">
                            <xsl:value-of select="concat($current_month, ' ', @annee, ' : ')"/>
                          </fo:inline>
                          <xsl:value-of select="@commentaire"/>
                        </fo:block>
                      </xsl:if>
                    </xsl:for-each>
                  </fo:block>
                </xsl:for-each>
              </xsl:for-each>
            </fo:block>
          </xsl:for-each>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
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

  <xsl:template name="row4table">
    <xsl:param name="date-cell"/>
    <xsl:param name="prevus-cell"/>
    <xsl:param name="ok-cell"/>
    <xsl:param name="annules-cell"/>
    <xsl:param name="retards-cell"/>
    <xsl:param name="regularite-cell"/>

    <fo:table-row>
      <fo:table-cell text-align="center"
                      border="0.5pt solid #000000">
        <fo:block font-size="60%">
          <xsl:copy-of select="$date-cell"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell text-align="center"
                      border="0.5pt solid #000000">
        <fo:block font-size="60%">
          <xsl:copy-of select="$prevus-cell"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell text-align="center"
                      border="0.5pt solid #000000">
        <fo:block font-size="60%">
          <xsl:copy-of select="$ok-cell"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell text-align="center"
                      border="0.5pt solid #000000">
        <fo:block font-size="60%">
          <xsl:copy-of select="$annules-cell"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell text-align="center"
                      border="0.5pt solid #000000">
        <fo:block font-size="60%">
          <xsl:copy-of select="$retards-cell"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell text-align="center"
                      border="0.5pt solid #000000">
        <fo:block font-size="60%">
          <xsl:copy-of select="$regularite-cell"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
</xsl:stylesheet>
