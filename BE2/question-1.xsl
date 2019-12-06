<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



	<xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" >
            <xsl:for-each select="ponctualite-transilien/service">
            	<xsl:value-of select="@nom"></xsl:value-of>
            	<xsl:for-each select="ligne">
            		<xsl:sort select="sigle"></xsl:sort>

            		<table>
            			<tr>
            				<th>Date</th>
            				<th>Ponctualite</th>
            				<th>Satisfaction</th>
            			</tr>

            			<xsl:for-each select="annee">
            				<xsl:sort select="@millesime"></xsl:sort>
            				<xsl:for-each select="mesure">
            					<xsl:sort select="@mois"></xsl:sort>
            					<tr>
            						<td><xsl:value-of select="@mois"></xsl:value-of> - <xsl:value-of select="../@millesime"></xsl:value-of></td>
            						<td><xsl:value-of select="round(ponctualite*10)div 10"></xsl:value-of></td>
    	        					<td><xsl:value-of select="satisfaction"></xsl:value-of></td>
            					</tr>        					
            				</xsl:for-each>
            			</xsl:for-each>

            		</table>
            	</xsl:for-each>

            </xsl:for-each>
        </html>
    </xsl:template>

</xsl:stylesheet>


