<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>Students</title>
        <style>
          body {
          align-items: center;
          }

          h1 {
          font-size: 20px;
          color: blue;
          }

          #student-container {
          width:50%;
          margin:10px;
          font-size:20px;
          padding:10px;
          border: 2px solid gray;

          }

          #exam-title {
          color: green;
          }

          #exam-container {
          margin-left:60px;
          }
          
          #exams {
          margin-left: 20px;
          }
          
          #failMsg {
          color:red;
          }

        </style>
      </head>
      <body>

        <h1>Students</h1>
        <xsl:for-each select="students/student">
          <div id="student-container">
            Name: <xsl:value-of select="name"/>
            <div>
              Faculty Number: <xsl:value-of select="faculty-number"/>
            </div>
            <div id="exam-title">Taken exams:</div>
            <xsl:for-each select="exams/exam">
              <div id="exam-container">
                <xsl:value-of select="position()"/>.<xsl:value-of select="name"/>
                <div id="exams">

                  <xsl:choose>
                    <xsl:when test="score > 40">
                      - Score: <xsl:value-of select="score"/>
                      <br/> - Tutor: <xsl:value-of select="tutor"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <p id="failMsg">Failed exam - score: <xsl:value-of select="score"/> <br/>
                        Tutor: <xsl:value-of select="tutor"/>
                      </p>
                    </xsl:otherwise>
                  </xsl:choose>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
