using QRCoder;
using RGiesecke.DllExport;
using System;
using System.Drawing;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows;
using static QRCoder.PayloadGenerator;

namespace QRCoderClarionWrapper
{
    public static partial class QRCoderWrapper
    {

     

        //Payload is QRMail
        [DllExport("QRMail", CallingConvention = CallingConvention.StdCall)]
        public static void QRMail([MarshalAs(UnmanagedType.BStr)] string emailAddress, [MarshalAs(UnmanagedType.BStr)] string subject, [MarshalAs(UnmanagedType.BStr)] string emailText)
        {
            Mail generator = new Mail(emailAddress, subject, emailText);
            string payload = generator.ToString();

            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(payload, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            var qrCodeAsBitmap = qrCode.GetGraphic(20);
           // SaveImage(qrCodeAsBitmap, "qrmail.jpg");
        }

        //Payload is QR Simple Text
        [DllExport("QRText", CallingConvention = CallingConvention.StdCall)]
        public static void QRText([MarshalAs(UnmanagedType.BStr)] string theText, IntPtr ptrFileInformation)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(theText, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            Bitmap qrCodeImage = qrCode.GetGraphic(20);
            //CreateQRAndSave(FileInformation, theText);

        }

        //Payload is VCard
        [DllExport("QRVCard", CallingConvention = CallingConvention.StdCall)]
        public static void QRVCard(IntPtr ptrVcard, IntPtr ptrFileInformation)
        {
            //Retrieve and map clarion groups
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            QRContact contact = new QRContact(ptrVcard);
            
            CreateQRAndSave(FileInformation, contact.GetContactData());
            

        }


        [DllExport("QRSkypeCall", CallingConvention = CallingConvention.StdCall)]
        public static void QRSkypeCall([MarshalAs(UnmanagedType.BStr)] string skypeUserName, IntPtr ptrFileInformation)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            CreateQRAndSave(FileInformation, new SkypeCall(skypeUserName));
        }

        [DllExport("QRUrl", CallingConvention = CallingConvention.StdCall)]
        public static void QRUrl([MarshalAs(UnmanagedType.BStr)] string website, IntPtr ptrFileInformation)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            CreateQRAndSave(FileInformation, new Url(website));

            
        }
        [DllExport("QRSms", CallingConvention = CallingConvention.StdCall)]
        public static void QRSms([MarshalAs(UnmanagedType.BStr)] string number, [MarshalAs(UnmanagedType.BStr)] string message, IntPtr ptrFileInformation)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            CreateQRAndSave(FileInformation, new SMS(number, message));
        }

        private static void CreateQRAndSave(QRFileInfo FileInformation,  dynamic generator)
        {
            if (FileInformation.FileName != "")
            {
                if (File.Exists(FileInformation.FileName))
                    File.Delete(FileInformation.FileName);

                string payload = generator.ToString();
                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(payload, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);

                var qrCodeAsBitmap = qrCode.GetGraphic(20);

                qrCodeAsBitmap.Save(FileInformation.FileName, FileInformation.FileType);
            }
        }
    }
}
