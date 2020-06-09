                    MEMBER
                    MAP
                      MODULE('QRCoderClarionWrapper.lib')
QRText                PROCEDURE(BSTRING theText, long FileInfo) ,pascal,raw,dll(1),name('QRText')
QRMail                  PROCEDURE(BSTRING emailAddress, BSTRING subject, BSTRING emailText) ,pascal,raw,dll(1),name('QRMail')
QRVCard                 PROCEDURE(long card, long FileInfo),pascal,raw,dll(1),name('QRVCard')
QRSkypeCall             PROCEDURE(BSTRING contact, long FileInfo) ,pascal,raw,dll(1),name('QRSkypeCall')
QRUrl                   PROCEDURE(BSTRING url, long FileInfo) ,pascal,raw,dll(1),name('QRUrl')
QRSms                   PROCEDURE(BSTRING number, BSTRING message, long FileInfo) ,pascal,raw,dll(1),name('QRsms')
                      END

                    END
  INCLUDE('ctQRWrapper.inc'),once

ctQRWrapper.CreateQRContact PROCEDURE(*gtQRContact contact, *gtFileInformation FileInfo)

  CODE

  QRVCard(Address(contact), ADDRESS(FileInfo))

ctQRWrapper.CreateQRText  PROCEDURE(string txt, *gtFileInformation FileInfo)
  CODE
    QRText(CLIP(txt), Address(FileInfo))

ctQRWrapper.CreateQRSkypeCall      PROCEDURE(string skypeContact, *gtFileInformation FileInfo)
  CODE
  QRSkypeCall(clip(skypeContact), Address(FileInfo))  

ctQRWrapper.CreateQRUrl      PROCEDURE(string url, *gtFileInformation FileInfo)
  CODE
  QRUrl(CLIP(url), Address(FileInfo))   

ctQRWrapper.CreateQRSms      PROCEDURE(string number, string message, *gtFileInformation FileInfo)
  CODE
  QRSms(CLIP(number), CLIP(message), Address(FileInfo))    

