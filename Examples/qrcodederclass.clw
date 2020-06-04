
  PROGRAM

 INCLUDE('ctqrcoder.INC'),once

  MAP
  END
QR ctQRCoder

    CODE
        qr.tofile('my text', 'file1.bmp')
        qr.tofile('my text', 'clarion.bmp', 2)
        qr.tofile('my text', 'file3.bmp', 10)