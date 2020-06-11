                    MEMBER
                    MAP
                      MODULE('QRCoderClarionWrapper.lib')
QRText                  PROCEDURE(BSTRING theText, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRText')
QRTextMemory            PROCEDURE(BSTRING theText, LONG FileInfo,*Long Len) BSTRING,PASCAL,RAW,DLL(1),NAME('QRTextmemory')
QRMail                  PROCEDURE(BSTRING emailAddress, BSTRING subject, BSTRING emailText) ,PASCAL,RAW,DLL(1),NAME('QRMail')
QRVCard                 PROCEDURE(LONG card, LONG FileInfo),PASCAL,RAW,DLL(1),NAME('QRVCard')
QRSkypeCall             PROCEDURE(BSTRING contact, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRSkypeCall')
QRUrl                   PROCEDURE(BSTRING url, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRUrl')
QRSms                   PROCEDURE(BSTRING number, BSTRING message, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRsms')
                      END
                    END
  

  INCLUDE('ctQRWrapper.inc'),ONCE

ctQRWrapper.Construct   PROCEDURE()
  CODE
  Self.CurrentImage &= New(string(1))
  
  
ctQRWrapper.Destruct    PROCEDURE()
  CODE
  DISPOSE(Self.CurrentImage)
  
ctQRWrapper.DecodeImageToString    PROCEDURE(*BSTRING b64Image, long strLen)  
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
  !res# = CWdecode64(outStr, inStr, strLen)
  Self.CurrentImage = outStr[1:strLen]
  dispose(cBase64Decode)
  DISPOSE(inStr)
  DISPOSE(outStr)
    
ctQRWrapper.CreateQRCalendar    PROCEDURE(*gtQRContact calendar, *gtFileInformation FileInfo)
  CODE
  !QRCalendar(ADDRESS(calendar), ADDRESS(FileInfo))

ctQRWrapper.CreateQRContact PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo)

  CODE

  QRVCard(Address(contact), ADDRESS(FileInfo))

ctQRWrapper.CreateQRText    PROCEDURE(STRING txt, *gtFileInformation FileInfo)
  CODE
  QRText(CLIP(txt), Address(FileInfo))
  
  
ctQRWrapper.CreateQRTextToString    PROCEDURE(STRING txt, *gtFileInformation FileInfo)
img                                   BSTRING
strLen   LONG
  CODE
  
  img = QRTextMemory(Clip(txt),ADDRESS(FileInfo), strLen)
  Self.DecodeImageToString(img, strLen)
  
ctQRWrapper.CreateQRSkypeCall   PROCEDURE(STRING skypeContact, *gtFileInformation FileInfo)
  CODE
  QRSkypeCall(clip(skypeContact), Address(FileInfo))  

ctQRWrapper.CreateQRUrl PROCEDURE(STRING url, *gtFileInformation FileInfo)
  CODE
  QRUrl(CLIP(url), Address(FileInfo))   

ctQRWrapper.CreateQRSms PROCEDURE(STRING number, STRING message, *gtFileInformation FileInfo)
  CODE
  QRSms(CLIP(number), CLIP(message), Address(FileInfo))    
  
ctQRWrapper.GetCurrentImage PROCEDURE()
  CODE
  RETURN Self.CurrentImage



  
  
