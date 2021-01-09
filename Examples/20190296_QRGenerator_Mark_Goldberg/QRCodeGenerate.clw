
  PROGRAM

  MAP
  END
  INCLUDE('equates.clw'),ONCE
  INCLUDE('debuger.inc'),ONCE
dbg        debuger

  INCLUDE('QRCode.inc'),ONCE
QR QRCode

QRText CSTRING(100)
QRFile CSTRING(256)
  CODE
  dbg.mg_init('')
  													assert(0,eqDBG&' make sure you compiled in debug mode to see asserts')
  													assert(0,eqDBG&' variables are STRING')

  QR.GenerateFile('www.ClarionHub.com','ClarionHub.BMP')
  													assert(0,eqDBG&'')

  QRText = 'www.SoftVelocity.com'
  QRFile = 'SoftVelocity.BMP'

  													assert(0,eqDBG&'')
  QR.GenerateFile( QRText, QRFile)
  													assert(0,eqDBG&'')
  QR.GenerateFile( QRText, QRFile, COLOR:Red)
  													assert(0,eqDBG&' DONE ')
