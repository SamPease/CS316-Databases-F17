<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="text()|@*"/> 
	<xsl:template match="congress">
		<xsl:element name="congress">
			<xsl:element name="house">
				<xsl:for-each select="people/person/role[@current=1][@type='rep']">
					<xsl:variable name="a" select="."/>
					<person name ="{normalize-space(../@name)}"> 
						<xsl:for-each select="/congress/committees/committee/member[@id=$a/../@id]">
							<xsl:choose>
								<xsl:when test="@role!=''">
									<committee name="{normalize-space(../@displayname)}" role="{normalize-space(@role)}">
									<xsl:for-each select="../subcommittee/member[@id=$a/../@id]">
										<xsl:choose>
											<xsl:when test="@role!=''">
												<subcommittee name="{normalize-space(../@displayname)}" role="{normalize-space(@role)}"/>
											</xsl:when>
											<xsl:otherwise>
												<subcommittee name="{normalize-space(../@displayname)}" role="Member"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
									</committee>
								</xsl:when>
								<xsl:otherwise>
									<committee name="{normalize-space(../@displayname)}" role="Member">
									<xsl:for-each select="../subcommittee/member[@id=$a/../@id]">
										<xsl:choose>
											<xsl:when test="@role!=''">
												<subcommittee name="{normalize-space(../@displayname)}" role="{normalize-space(@role)}"/>
											</xsl:when>
											<xsl:otherwise>
												<subcommittee name="{normalize-space(../@displayname)}" role="Member"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
									</committee>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>	
					</person>
				</xsl:for-each>
			</xsl:element>
			<xsl:element name="senate">
				<xsl:for-each select="people/person/role[@current=1][@type='sen']">
					<xsl:variable name="d" select="."/>
					<person name ="{normalize-space(../@name)}"> 
						<xsl:for-each select="/congress/committees/committee/member[@id=$d/../@id]">
							<xsl:choose>
								<xsl:when test="@role!=''">
									<committee name="{normalize-space(../@displayname)}" role="{normalize-space(@role)}">
									<xsl:for-each select="../subcommittee/member[@id=$d/../@id]">
										<xsl:choose>
											<xsl:when test="@role!=''">
												<subcommittee name="{normalize-space(../@displayname)}" role="{normalize-space(@role)}"/>
											</xsl:when>
											<xsl:otherwise>
												<subcommittee name="{normalize-space(../@displayname)}" role="Member"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
									</committee>
								</xsl:when>
								<xsl:otherwise>
									<committee name="{normalize-space(../@displayname)}" role="Member">
									<xsl:for-each select="../subcommittee/member[@id=$d/../@id]">
										<xsl:choose>
											<xsl:when test="@role!=''">
												<subcommittee name="{normalize-space(../@displayname)}" role="{normalize-space(@role)}"/>
											</xsl:when>
											<xsl:otherwise>
												<subcommittee name="{normalize-space(../@displayname)}" role="Member"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
									</committee>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>	
					</person>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>


<!-- -->


	<!--			<xsl:copy-of select="../@name"/>	-->