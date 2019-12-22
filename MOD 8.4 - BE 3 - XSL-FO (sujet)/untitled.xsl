<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <!-- margins are clockwise oredered starting at the top -->
        <fo:simple-page-master page-height="297mm"
                                page-width="210mm"
                                master-name="PageMaster">
          <fo:region-body margin="20mm 20mm 20mm 20mm" background-color="#c7ffd6"/>
          <fo:region-before margin="0mm 0mm 0mm 0mm" extent="20mm" background-color="#ea4622"/>
          <fo:region-after margin="20mm 0mm 20mm 0mm" extent="20mm" background-color="#226eea"/>
          <fo:region-start margin="20mm 0mm 20mm 0mm" background-color="#ea22d2"/>
          <fo:region-end margin="20mm 0mm 20mm 0mm" background-color="#000000"/>
        </fo:simple-page-master>

        <fo:simple-page-master page-height="297mm"
                                page-width="210mm"
                                master-name="PageMaster2">
          <fo:region-body margin="40mm 40mm 40mm 40mm" background-color="#c7ffd6"/>
          <fo:region-before margin="0mm 0mm 0mm 0mm" extent="20mm" background-color="#ea4622"/>
          <fo:region-after margin="20mm 0mm 20mm 0mm" extent="20mm" background-color="#226eea"/>
          <fo:region-start margin="20mm 0mm 20mm 0mm" background-color="#ea22d2"/>
          <fo:region-end margin="20mm 0mm 20mm 0mm" background-color="#000000"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="PageMaster">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block>before</fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block>Hello World !</fo:block>
            <!--
            <xsl:apply-templates select="body"/>
            -->
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="PageMaster2">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block>before</fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block>Hello World !</fo:block>
            <!--
            <xsl:apply-templates select="body"/>
            -->
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <!--

  <xsl:template match="body">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="p">
    <fo:block>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>

  <xsl:template match="b">
    <fo:inline font-weight="bold">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  -->

</xsl:stylesheet >
