OutType             ITEMIZE(0),PRE(OutType)
MeCard                EQUATE
VCard21               EQUATE
VCard3                EQUATE
VCard4                EQUATE
                    END

OrderType           ITEMIZE(0),PRE(ORDTYPE)
Default               EQUATE
Reversed              EQUATE
                    END

ImageFormat         ITEMIZE(0),PRE(ImageFormat)
Bmp                   EQUATE
Emf                   EQUATE
Wmf                   EQUATE
Gif                   EQUATE
Jpeg                  EQUATE
Png                   EQUATE
Tiff                  EQUATE
Exif                  EQUATE
Icon                  EQUATE
                    END

gtQRContact         GROUP,TYPE
OutputType            LONG(OutType:VCard3)
FirstName             BSTRING
LastName              BSTRING
NickName              BSTRING
Phone                 BSTRING
MobilePhone           BSTRING
WorkPhone             BSTRING
EmailAddress          BSTRING
Birthday              BSTRING
Website               BSTRING
Street                BSTRING
HouseNumber           BSTRING
City                  BSTRING
ZipCode               BSTRING
Country               BSTRING
Note                  BSTRING
StateRegion           BSTRING
AddressOrder          LONG(ORDTYPE:Default)
                    end

gtFileInformation   GROUP,TYPE
FileName              BSTRING
imageType             LONG(ImageFormat:Jpeg)
                    END


ctQRWrapper         CLASS,TYPE,MODULE('ctQRWrapper.clw'),LINK('ctQRWrapper.clw')
CreateQRContact       PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo),VIRTUAL
CreateQRText          PROCEDURE(STRING txt, *gtFileInformation FileInfo),VIRTUAL
CreateQRSkypeCall     PROCEDURE(STRING skypeContact, *gtFileInformation FileInfo),VIRTUAL
CreateQRUrl           PROCEDURE(STRING url, *gtFileInformation FileInfo),VIRTUAL
CreateQRSms           PROCEDURE(STRING number, STRING message, *gtFileInformation FileInfo),VIRTUAL
                    END