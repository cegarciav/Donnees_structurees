<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" encoding="utf-8"/>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="index-page"
                               page-height="29.7cm"
                               page-width="21cm"
                               margin="25mm">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="index-page">
        <fo:flow flow-name="xsl-region-body">
          <xsl:for-each select="regularite-tgv/axe">
            <fo:block font-size="150%"
                      font-family="Helvetica"
                      letter-spacing="0.1em">
                <xsl:number/>
                <xsl:text>. Axe </xsl:text>
                <xsl:value-of select="@nom"/>
            </fo:block>
          </xsl:for-each>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
