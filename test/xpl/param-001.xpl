<p:declare-step xmlns:t="http://xproc.org/ns/testsuite" xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:err="http://www.w3.org/ns/xproc-error" version="1.0" name="main">
  <p:input port="parameters" kind="parameter"/>
  <p:output port="result"/>

  <p:xslt name="xslt">
    <p:with-param name="stepparam" select="'step value'">
      <p:empty/>
    </p:with-param>
    <p:input port="source">
      <p:inline>
	<doc/>
      </p:inline>
    </p:input>
    <p:input port="stylesheet">
      <p:inline>
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	  <xsl:param name="pipeparam" select="'unset'"/>
	  <xsl:param name="stepparam" select="'unset'"/>
	  <xsl:param name="notaparam" select="'no value'"/>

	  <xsl:template match="/">
	    <doc>
	      <param name="pipeparam" value="{$pipeparam}"/>
	      <param name="stepparam" value="{$stepparam}"/>
	      <param name="notaparam" value="{$notaparam}"/>
	    </doc>
	  </xsl:template>
	</xsl:stylesheet>
      </p:inline>
    </p:input>
  </p:xslt>
</p:declare-step>