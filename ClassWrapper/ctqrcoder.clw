!class by Mark Goldberg
   MEMBER()
   INCLUDE('ctQRCoder.inc'),ONCE
   MAP
     MODULE('QRCoder.lib')
       GenerateQrCode    (bstring xText,bstring xFileName,bstring xPixelSize,bstring xBmpFormat, bstring xbackgroundcolor, bstring xgraphcolor )        ,pascal,raw,dll(1),name('GenerateQrCode')
       GenerateQrCodeAsci(bstring xText,bstring xFileName,bstring xPixelSize),bstring,pascal,raw,dll(1),name('GenerateQrCodeAsci')
       calendar          (				) ,bstring               ,NAME('calendar'),PASCAL,RAW,DLL(TRUE)
       colorp            (				) ,long               ,NAME('colorp'),PASCAL,RAW,DLL(TRUE)
       viewimagep        (bstring xFileName),pascal,raw,dll(1),name('viewimagep')       
     END
   END

ctQRCoder.ToFile        PROCEDURE(STRING xText, STRING xFileName,  STRING xBmpFormat , STRING xbackgroundcolor, STRING xgraphcolor, LONG xPixelSize = 20)
bText              BSTRING 
bFileName          BSTRING 
bPixelSize         BSTRING
bBmpFormat         BSTRING
bbackgroundcolor   BSTRING
bgraphcolor        BSTRING

   CODE    
            
   bText            = xText
   bFileName        = xFileName
   bPixelSize       = xPixelSize  ! values around 20 seem normal
   bBmpFormat       = xBmpFormat  
   bbackgroundcolor = xbackgroundcolor
   bgraphcolor      = xgraphcolor
   
   IF xPixelSize < 1
      ! complain
   END 
        
   IF  xBmpFormat <> 'jpeg' or xBmpFormat <> 'bmp' or xBmpFormat <> 'png' THEN
      ! complain
   END     
!        message('btest', btext)
!        message('bFilename', bFilename)
!        message('bPixelSize', bPixelSize)
!        message('bBmpFormat', bBmpFormat)
!        message('bbackgroundcolor', bbackgroundcolor)
!        message('bgraphcolor', bgraphcolor)
   GenerateQrCode( bText, bFileName, bPixelSize, bBmpFormat, bbackgroundcolor, bgraphcolor )



ctQRCoder.ToFileAscii   PROCEDURE(STRING xText, STRING xFileName, LONG xPixelSize = 20)
bText      BSTRING 
bFileName  BSTRING 
bPixelSize BSTRING

Answer     string(4000)

   CODE 
   bText      = xText
   bFileName  = xFileName
   bPixelSize = xPixelSize  ! values around 20 seem normal
   IF xPixelSize < 1
      ! complain
   END 

   Answer = GenerateQrCodeAsci( bText, bFileName, bPixelSize )
   return answer
   ! what is returned ?
        
     
    
ctQRCoder.SelectColor       PROCEDURE()          
bColor  long

CODE 
    bColor = colorp()    
    return bColor
    
    
ctQRCoder.ViewImage PROCEDURE(STRING xFileName)          
bFileName               BSTRING 
CODE 
    bFileName  = xFileName
     !message(bfilename)
    ViewImagep(bFileName)
    
    
