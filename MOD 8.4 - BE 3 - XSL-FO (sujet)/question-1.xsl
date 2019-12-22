<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <!-- margins are clockwise oredered starting at the top -->
        <fo:simple-page-master page-height="297mm"
                                page-width="210mm"
                                margin="20mm 20mm 20mm 20mm"
                                master-name="PageMaster">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="PageMaster">
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="30pt">Hello World !</fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
</xsl:stylesheet >
