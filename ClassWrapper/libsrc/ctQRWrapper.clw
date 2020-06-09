                    MEMBER
                    MAP
                      MODULE('QRCoderClarionWrapper.lib')
QRText                  PROCEDURE(BSTRING theText, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRText')
QRMail                  PROCEDURE(BSTRING emailAddress, BSTRING subject, BSTRING emailText) ,PASCAL,RAW,DLL(1),NAME('QRMail')
QRVCard                 PROCEDURE(LONG card, LONG FileInfo),PASCAL,RAW,DLL(1),NAME('QRVCard')
QRSkypeCall             PROCEDURE(BSTRING contact, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRSkypeCall')
QRUrl                   PROCEDURE(BSTRING url, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRUrl')
QRSms                   PROCEDURE(BSTRING number, BSTRING message, LONG FileInfo) ,PASCAL,RAW,DLL(1),NAME('QRsms')
                      END
                    END

  INCLUDE('ctQRWrapper.inc'),ONCE

ctQRWrapper.CreateQRContact PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo)

  CODE

  QRVCard(Address(contact), ADDRESS(FileInfo))

ctQRWrapper.CreateQRText    PROCEDURE(STRING txt, *gtFileInformation FileInfo)
  CODE
  QRText(CLIP(txt), Address(FileInfo))

ctQRWrapper.CreateQRSkypeCall   PROCEDURE(STRING skypeContact, *gtFileInformation FileInfo)
  CODE
  QRSkypeCall(clip(skypeContact), Address(FileInfo))  

ctQRWrapper.CreateQRUrl PROCEDURE(STRING url, *gtFileInformation FileInfo)
  CODE
  QRUrl(CLIP(url), Address(FileInfo))   

ctQRWrapper.CreateQRSms PROCEDURE(STRING number, STRING message, *gtFileInformation FileInfo)
  CODE
  QRSms(CLIP(number), CLIP(message), Address(FileInfo))    

