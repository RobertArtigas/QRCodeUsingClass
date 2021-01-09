   MEMBER()
   INCLUDE('QRCode.inc'),ONCE
   MAP
     MODULE('QRGenerator.dll')
      GenerateQRFile(*CSTRING pQRCode_Text, *CSTRING pFileName                        )    ,LONG, RAW, DLL, C,NAME('GenerateQRFile' ),PROC
      GenerateQRFile(*CSTRING pQRCode_Text, *CSTRING pFileName, ULONG cwcolor         )    ,LONG, RAW, DLL, C,NAME('GenerateQRFileC'),PROC
      GenerateQRFile(*CSTRING pQRCode_Text, *CSTRING pFileName, ULONG pPIXEL_PRESCALER, |
                     ULONG pPIXEL_COLOR_R, ULONG pPIXEL_COLOR_G, ULONG pPIXEL_COLOR_B)     ,LONG, RAW, DLL, C,NAME('GenerateQRFileB'),PROC
     END

   END


eqDBG EQUATE('<4,2,7>')

QRCode.GenerateFile          PROCEDURE(*CSTRING pQRCode_Text, *CSTRING pFileName )
   CODE 
   RETURN GenerateQRFile( pQRCode_Text, pFileName )

QRCode.GenerateFile          PROCEDURE(*CSTRING pQRCode_Text, *CSTRING pFileName, ULONG cwcolor            )
   CODE 
   RETURN GenerateQRFile( pQRCode_Text, pFileName, cwColor )

QRCode.GenerateFile          PROCEDURE(*CSTRING pQRCode_Text, *CSTRING pFileName, ULONG pPIXEL_PRESCALER, |
                           ULONG pPIXEL_COLOR_R, ULONG pPIXEL_COLOR_G, ULONG pPIXEL_COLOR_B          )
   CODE 
   RETURN GenerateQRFile( pQRCode_Text, pFileName, pPIXEL_PRESCALER, pPIXEL_COLOR_R, pPIXEL_COLOR_G, pPIXEL_COLOR_B)


   
QRCode.GenerateFile          PROCEDURE( STRING pQRCode_Text,  STRING pFileName )
szText &CSTRING
szFile &CSTRING
Answer LONG,AUTO
   CODE 
   szText &= NEW CSTRING( LEN(CLIP(pQRCode_Text)) + 1 )
   szText  =                  CLIP(pQRCode_Text)

   szFile &= NEW CSTRING( LEN(CLIP(pFileName)) + 1 )
   szFile  =                  CLIP(pFileName)

   Answer = GenerateQRFile( szText, szFile)

   DISPOSE( szText )
   DISPOSE( szFile )
   RETURN Answer

QRCode.GenerateFile          PROCEDURE( STRING pQRCode_Text,  STRING pFileName, ULONG cwcolor              )
szText &CSTRING
szFile &CSTRING
Answer LONG,AUTO
   CODE 
   szText &= NEW CSTRING( LEN(CLIP(pQRCode_Text)) + 1 )
   szText  =                  CLIP(pQRCode_Text)

   szFile &= NEW CSTRING( LEN(CLIP(pFileName)) + 1 )
   szFile  =                  CLIP(pFileName)

   Answer = GenerateQRFile( szText, szFile, cwColor)
   DISPOSE( szText )
   DISPOSE( szFile )
   RETURN Answer

QRCode.GenerateFile          PROCEDURE( STRING pQRCode_Text,  STRING pFileName, ULONG pPIXEL_PRESCALER, |
                                         ULONG pPIXEL_COLOR_R, ULONG pPIXEL_COLOR_G, ULONG pPIXEL_COLOR_B          )
szText &CSTRING
szFile &CSTRING
Answer LONG,AUTO
  CODE 
   szText &= NEW CSTRING( LEN(CLIP(pQRCode_Text)) + 1 )
   szText  =                  CLIP(pQRCode_Text)

   szFile &= NEW CSTRING( LEN(CLIP(pFileName)) + 1 )
   szFile  =                  CLIP(pFileName)

   Answer = GenerateQRFile( szText, szFile, pPIXEL_PRESCALER, pPIXEL_COLOR_R, pPIXEL_COLOR_G, pPIXEL_COLOR_B)
   DISPOSE( szText )
   DISPOSE( szFile )
   RETURN Answer
                          
