! Class interpretation of code from Diego Borojovich of SoftVelocity written by Mark Goldberg Feb/5/2019 
! it appears to generate a .BMP

              PRAGMA('link(QRGenerator.LIB)')



QRCode        CLASS,TYPE,MODULE('QRCode.clw'),LINK('QRCode.clw')
GenerateFile      PROCEDURE(*CSTRING pQRCode_Text, *CSTRING pFileName                           ),LONG,PROC
GenerateFile      PROCEDURE(*CSTRING pQRCode_Text, *CSTRING pFileName, ULONG cwcolor            ),LONG,PROC
GenerateFile      PROCEDURE(*CSTRING pQRCode_Text, *CSTRING pFileName, ULONG pPIXEL_PRESCALER, |
                       ULONG pPIXEL_COLOR_R, ULONG pPIXEL_COLOR_G, ULONG pPIXEL_COLOR_B         ),LONG,PROC

GenerateFile      PROCEDURE(  STRING pQRCode_Text,   STRING pFileName                           ),LONG,PROC
GenerateFile      PROCEDURE(  STRING pQRCode_Text,   STRING pFileName, ULONG cwcolor            ),LONG,PROC
GenerateFile      PROCEDURE(  STRING pQRCode_Text,   STRING pFileName, ULONG pPIXEL_PRESCALER, |
                       ULONG pPIXEL_COLOR_R, ULONG pPIXEL_COLOR_G, ULONG pPIXEL_COLOR_B         ),LONG,PROC
 
              END

