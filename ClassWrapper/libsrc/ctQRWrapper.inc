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

EventEncoding       ITEMIZE(0),PRE(EventEncoding)
Universal             EQUATE
iCal                  EQUATE
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



gtQRCalendar        GROUP,TYPE
Subject               BSTRING
Description           BSTRING
Location              BSTRING !Location (lat:long or address) of the event
StartDateTime         BSTRING !Needs to be formatted as Year/Month/Day Hour:Min
EndDateTime           BSTRING !Needs to be formatted as Year/Month/Day Hour:Min
AllDayEven            LONG    !1 for true 0 for false
Encoding              LONG(EventEncoding:Universal)
                    END



gtFileInformation   GROUP,TYPE
FileName              BSTRING
imageType             LONG(ImageFormat:Jpeg) !Default to Jpeg
SaveImage             LONG(0)                !Default to not
                    END

  include('ctBase64Decode.inc'),Once

ctQRWrapper         CLASS,TYPE,MODULE('ctQRWrapper.clw'),LINK('ctQRWrapper.clw')
CurrentImage          &STRING,PRIVATE
cBase64Decode                     &ctBase64Decode,PRIVATE
Construct             PROCEDURE()
Destruct              PROCEDURE()

CreateQRCalendar      PROCEDURE(*gtQRContact calendar, *gtFileInformation FileInfo),VIRTUAL
CreateQRContact       PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo),VIRTUAL
CreateQRText          PROCEDURE(STRING txt, *gtFileInformation FileInfo),VIRTUAL
CreateQRSkypeCall     PROCEDURE(STRING skypeContact, *gtFileInformation FileInfo),VIRTUAL
CreateQRUrl           PROCEDURE(STRING url, *gtFileInformation FileInfo),VIRTUAL
CreateQRSms           PROCEDURE(STRING number, STRING message, *gtFileInformation FileInfo),VIRTUAL
SetCurrentImage       PROCEDURE(bstring img, long strLen, long SaveImage),PRIVATE
GetCurrentImage       PROCEDURE(),STRING

                    END