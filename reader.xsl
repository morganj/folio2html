<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/folio">
        <html>
            <head>
                <style>
                    *{position:absolute;}
                </style>
                <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
            </head>
            <body>
                <xsl:for-each select="//contentStack/content/overlays">
                    <xsl:apply-templates/>
                </xsl:for-each>

                <script src="http://mozilla.github.io/pdf.js/build/pdf.js"></script>
                <script>
                    function render(){
                        PDFJS.getDocument($(this).attr('data-src'), function getPdfHelloWorld(data) {
                        //
                        // Instantiate PDFDoc with PDF data
                        //
                        var pdf = new PDFJS.PDFDoc(data);
                        var page = pdf.getPage(1);
                        var scale = 1.5;

                        //
                        // Prepare canvas using PDF page dimensions
                        //
                        var canvas = document.getElementById('the-canvas');
                        var context = canvas.getContext('2d');
                        canvas.height = page.height * scale;
                        canvas.width = page.width * scale;

                        //
                        // Render PDF page into canvas context
                        //
                        page.startRendering(context);
                        });
                    }

                    $("canvas").each(render);
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="overlay[@type='container']">
        <xsl:element name="div">
            <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
            <xsl:attribute name="style">
                top:<xsl:value-of select="portraitBounds/rectangle/@y"/>px;
                left:<xsl:value-of select="portraitBounds/rectangle/@x"/>px;
                width:<xsl:value-of select="portraitBounds/rectangle/@width"/>px;
                height:<xsl:value-of select="portraitBounds/rectangle/@height"/>px;
            </xsl:attribute>
            <xsl:apply-templates select="data/children"/>

        </xsl:element>
    </xsl:template>

    <xsl:template match="overlay[@type='hyperlink']">
        <xsl:element name="a">
            <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="./data/url/text()"/>
            </xsl:attribute>
            <xsl:attribute name="style">
                top:<xsl:value-of select="portraitBounds/rectangle/@y"/>px;
                left:<xsl:value-of select="portraitBounds/rectangle/@x"/>px;
                width:<xsl:value-of select="portraitBounds/rectangle/@width"/>px;
                height:<xsl:value-of select="portraitBounds/rectangle/@height"/>px;
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="overlay[@type='video']">
        <xsl:element name="video">
            <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
            <xsl:attribute name="autoplay"/>
            <xsl:attribute name="src">
                <xsl:value-of select="data/videoUrl/text()"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="overlay[@type='image']/data/overlayAsset[@type='pdf']">
        <xsl:element name="canvas">
            <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
            <xsl:attribute name="data-src">
                <xsl:value-of select="text()"/>
            </xsl:attribute>
            <xsl:attribute name="style">
                top:<xsl:value-of select="../../portraitBounds/rectangle/@y"/>px;
                left:<xsl:value-of select="../../portraitBounds/rectangle/@x"/>px;
                width:<xsl:value-of select="../../portraitBounds/rectangle/@width"/>px;
                height:<xsl:value-of select="../../portraitBounds/rectangle/@height"/>px;
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

  <xsl:template match="overlayAsset">
      <xsl:element name="img">
          <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
          <xsl:attribute name="src">
              <xsl:value-of select="text()"/>
          </xsl:attribute>
        <xsl:attribute name="style">
              top:<xsl:value-of select="../../portraitBounds/rectangle/@y"/>px;
              left:<xsl:value-of select="../../portraitBounds/rectangle/@x"/>px;
              width:<xsl:value-of select="../../portraitBounds/rectangle/@width"/>px;
              height:<xsl:value-of select="../../portraitBounds/rectangle/@height"/>px;
          </xsl:attribute>
      </xsl:element>
  </xsl:template>


<xsl:template match="overlayAsset[@type='pdf']">
<xsl:element name="canvas">
    <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
    <xsl:attribute name="data-src">
        <xsl:value-of select="text()"/>
    </xsl:attribute>
    <xsl:attribute name="style">
        top:<xsl:value-of select="../../portraitBounds/rectangle/@y"/>px;
        left:<xsl:value-of select="../../portraitBounds/rectangle/@x"/>px;
        width:<xsl:value-of select="../../portraitBounds/rectangle/@width"/>px;
        height:<xsl:value-of select="../../portraitBounds/rectangle/@height"/>px;
    </xsl:attribute>
</xsl:element>
</xsl:template>

</xsl:stylesheet>