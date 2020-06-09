   PRAGMA('link(QRCoder.lib)')
!class by Mark Goldberg
ctQRCoder   CLASS,TYPE,MODULE('ctQRCoder.clw'),LINK('ctQRCoder.clw')
!------------------------
ToFile        PROCEDURE(STRING xText, STRING xFileName, STRING xBmpFormat, STRING xbackgroundcolor, STRING xgraphcolor, LONG xPixelSize=20)
ToFileAscii     PROCEDURE(STRING xText, STRING xFileName, LONG xPixelSize=20),string
SelectColor    PROCEDURE(),long
ViewImage     PROCEDURE(STRING xFileName)
   END