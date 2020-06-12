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
  
  
ctQRWrapper.Destruct    PROCEDURE()
  CODE
  DISPOSE(Self.CurrentImage)
  
!Used to decode a returned BSTRING reuslt that is Base64 to the CurrentImage property  
ctQRWrapper.DecodeImageToString PROCEDURE(*BSTRING b64Image, long strLen)  
inStr                             &CSTRING
outStr                            &CSTRING
cBase64Decode                     &ctBase64Decode
  CODE
 
  DISPOSE(Self.CurrentImage)
  
  inStr &= new(CSTRING(strLen+1))
  outStr &= new(CSTRING(strLen+1))
  Self.CurrentImage &= new(String(strLen))
  inStr = b64Image
  cBase64Decode &= new(ctBase64Decode)
  a# =cBase64Decode.DecodeBase64(outStr, inStr, strlen)
  Self.CurrentImage = outStr[1:strLen]
  DISPOSE(cBase64Decode)
  DISPOSE(inStr)
  DISPOSE(outStr)
    
ctQRWrapper.CreateQRCalendar    PROCEDURE(*gtQRContact calendar, *gtFileInformation FileInfo)
  CODE
  !QRCalendar(ADDRESS(calendar), ADDRESS(FileInfo))

ctQRWrapper.CreateQRContact PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo)
img                           BSTRING
strLen                        LONG

  CODE
  IMG = QRVCard(Address(contact), ADDRESS(FileInfo), strLen)
  IF ~FileInfo.SaveImage
    SELF.DecodeImageToString(img, strLen)
  END
  

ctQRWrapper.CreateQRText    PROCEDURE(STRING txt, *gtFileInformation FileInfo)
img                           BSTRING
strLen                        LONG

  CODE
  IMG = QRText(CLIP(txt), ADDRESS(FileInfo), strLen)
  IF ~FileInfo.SaveImage THEN
    Self.DecodeImageToString(img, strLen)
  END
  
  
  

  
ctQRWrapper.CreateQRSkypeCall   PROCEDURE(STRING skypeContact, *gtFileInformation FileInfo)
IMG                               BSTRING
strLen                            LONG
  CODE
  IMG = QRSkypeCall(clip(skypeContact), Address(FileInfo), strLen)
  IF ~FileInfo.SaveImage THEN
    Self.DecodeImageToString(img, strLen)
  END
  

ctQRWrapper.CreateQRUrl PROCEDURE(STRING url, *gtFileInformation FileInfo)
IMG                       BSTRING
strLen                    LONG
  CODE
  IMG = QRUrl(CLIP(url), Address(FileInfo), strlen) 
  IF ~FileInfo.SaveImage THEN
    Self.DecodeImageToString(img, strLen)
  END

ctQRWrapper.CreateQRSms PROCEDURE(STRING number, STRING message, *gtFileInformation FileInfo)
IMG                       BSTRING
strLen                    LONG
  CODE
  IMG = QRSms(CLIP(number), CLIP(message), Address(FileInfo),strlen)    
  IF ~FileInfo.SaveImage THEN
    Self.DecodeImageToString(img, strLen)
  END
  
ctQRWrapper.GetCurrentImage PROCEDURE()
  CODE
  RETURN Self.CurrentImage



  
  
