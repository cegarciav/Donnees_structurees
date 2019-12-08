<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="max_annee">
        <xsl:call-template name="max">
            <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee/@millesime">
            </xsl:with-param>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="max_mois">
        <xsl:call-template name="max">
            <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee/mesure/@mois">
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


    <xsl:variable name="min_annee">
        <xsl:call-template name="min">
            <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee/@millesime">
            </xsl:with-param>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="min_mois">
        <xsl:call-template name="min">
            <xsl:with-param name="liste" select="ponctualite-transilien/service/ligne/annee/mesure/@mois">
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
        <html xmlns="http://www.w3.org/1999/xhtml" >
        	<h1>Ponctualité des lignes transiliennes de <xsl:value-of select="$min_mois_lettres"></xsl:value-of><xsl:text> </xsl:text> - <xsl:value-of select="$min_annee"></xsl:value-of><xsl:text> </xsl:text> à <xsl:value-of select="$max_mois_lettres"></xsl:value-of><xsl:text> </xsl:text> - <xsl:value-of select="$max_annee"></xsl:value-of><xsl:text> </xsl:text></h1>
            <xsl:for-each select="ponctualite-transilien/service">
            	<h2><xsl:value-of select="@nom"></xsl:value-of></h2>
            	<xsl:for-each select="ligne">
            		<xsl:sort select="@sigle"></xsl:sort>

                    <xsl:variable name="couleur">
                        <xsl:call-template name="couleur_ligne">
                            <xsl:with-param name="ligne" select="@sigle"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:variable>

            		<table>
                        <h3>
                            <font color="{$couleur}">
                                <xsl:value-of select="@nom"></xsl:value-of>
                            </font> 
                        </h3>
            			<tr>
            				<th>Date</th>
            				<th>Ponctualite</th>
            				<th>Satisfaction</th>
            			</tr>

            			<xsl:for-each select="annee">
            				<xsl:sort select="@millesime"></xsl:sort>
            				<xsl:for-each select="mesure">
            					<xsl:sort select="@mois"></xsl:sort>

                                <xsl:variable name="mois">
                                    <xsl:call-template name="lettres_mois">
                                        <xsl:with-param name="numero">
                                            <xsl:value-of select="@mois"></xsl:value-of>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:variable>

            					<tr>
            						<td><xsl:value-of select="$mois"></xsl:value-of> - <xsl:value-of select="../@millesime"></xsl:value-of></td>
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
    	<xsl:param name="liste"></xsl:param>
    	<xsl:for-each select="$liste">
    		<xsl:sort select="." data-type="number" order="descending"></xsl:sort>
    		<xsl:if test="position() = 1">
    			<xsl:value-of select="."></xsl:value-of>
    		</xsl:if>
    	</xsl:for-each>
    </xsl:template>

    <xsl:template name="min">
    	<xsl:param name="liste"></xsl:param>
    	<xsl:for-each select="$liste">
    		<xsl:sort select="." data-type="number" order="descending"  ></xsl:sort>
    		<xsl:if test="position() = last()">
    			<xsl:value-of select="."></xsl:value-of>
    		</xsl:if>
    	</xsl:for-each>
    </xsl:template>


    <xsl:template name="couleur_ligne">
        <xsl:param name="ligne"></xsl:param>
        <xsl:value-of select="//code-couleur-transilien/ligne[@sigle=$ligne]/@hex"></xsl:value-of>
    </xsl:template>


</xsl:stylesheet>


