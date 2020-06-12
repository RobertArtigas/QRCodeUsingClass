                    MEMBER
                    MAP
                      MODULE('QRCoderClarionWrapper.lib')
QRText                  PROCEDURE(BSTRING theText, LONG FileInfo,*Long strLen),BSTRING,PASCAL,RAW,DLL(1),NAME('QRText'),PROC
QRMail                  PROCEDURE(BSTRING emailAddress, BSTRING subject, BSTRING emailText) ,PASCAL,RAW,DLL(1),NAME('QRMail')
QRVCard                 PROCEDURE(LONG card, LONG FileInfo,*LONG strLen),BSTRING,PASCAL,RAW,DLL(1),NAME('QRVCard'),PROC
QRSkypeCall             PROCEDURE(BSTRING contact, LONG FileInfo,*LONG strLen),BSTRING ,PASCAL,RAW,DLL(1),NAME('QRSkypeCall'),PROC
QRUrl                   PROCEDURE(BSTRING url, LONG FileInfo,*LONG strLen),BSTRING ,PASCAL,RAW,DLL(1),NAME('QRUrl'),PROC
QRSms                   PROCEDURE(BSTRING number, BSTRING message, LONG FileInfo,*LONG strLen),BSTRING ,PASCAL,RAW,DLL(1),NAME('QRsms'),PROC
                      END
                    END
  

  INCLUDE('ctQRWrapper.inc'),ONCE

ctQRWrapper.Construct   PROCEDURE()
  CODE
  Self.CurrentImage &= New(string(1))
  Self.cBase64Decode &= new(ctBase64Decode)
  
ctQRWrapper.Destruct    PROCEDURE()
  CODE
  DISPOSE(Self.CurrentImage)
  DISPOSE(Self.cBase64Decode)

  
  !Used to decode a base64 image returned from .net into the
  !string property current image
ctQRWrapper.SetCurrentImage PROCEDURE(bstring img, long strLen)
imgLen                        LONG
  CODE
  
  DISPOSE(Self.CurrentImage)
  imgLen = SELF.cBase64Decode.DecodeImageToString(img, strLen)
  Self.CurrentImage &= new(string(imgLen))
  Self.CurrentImage = Self.cBase64Decode.ReturnImage
    
ctQRWrapper.CreateQRCalendar    PROCEDURE(*gtQRContact calendar, *gtFileInformation FileInfo)
  CODE
  !QRCalendar(ADDRESS(calendar), ADDRESS(FileInfo))

ctQRWrapper.CreateQRContact PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo)
img                           BSTRING
strLen                        LONG

  CODE
  IMG = QRVCard(Address(contact), ADDRESS(FileInfo), strLen)
  IF ~FileInfo.SaveImage
    Self.SetCurrentImage(img, strLen)
  END
  


ctQRWrapper.CreateQRText    PROCEDURE(STRING txt, *gtFileInformation FileInfo)
img                           BSTRING
strLen                        LONG

  CODE
  IMG = QRText(CLIP(txt), ADDRESS(FileInfo), strLen)
  IF ~FileInfo.SaveImage
    Self.SetCurrentImage(img, strLen)
  END
  
ctQRWrapper.CreateQRSkypeCall   PROCEDURE(STRING skypeContact, *gtFileInformation FileInfo)
IMG                               BSTRING
strLen                            LONG
  CODE
  IMG = QRSkypeCall(clip(skypeContact), Address(FileInfo), strLen)
  IF ~FileInfo.SaveImage
    Self.SetCurrentImage(img, strLen)
  END
  

ctQRWrapper.CreateQRUrl PROCEDURE(STRING url, *gtFileInformation FileInfo)
IMG                       BSTRING
strLen                    LONG
  CODE
  IMG = QRUrl(CLIP(url), Address(FileInfo), strlen) 
  IF ~FileInfo.SaveImage
    Self.SetCurrentImage(img, strLen)
  END

ctQRWrapper.CreateQRSms PROCEDURE(STRING number, STRING message, *gtFileInformation FileInfo)
IMG                       BSTRING
strLen                    LONG
  CODE
  IMG = QRSms(CLIP(number), CLIP(message), Address(FileInfo),strlen)    
  IF ~FileInfo.SaveImage
    Self.SetCurrentImage(img, strLen)
  END
  
ctQRWrapper.GetCurrentImage PROCEDURE()
  CODE
  RETURN Self.CurrentImage



  
  
