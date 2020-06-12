using QRCoder;
using RGiesecke.DllExport;
using System;
using System.Drawing;
using System.IO;
using System.Runtime.InteropServices;
using static QRCoder.PayloadGenerator;

namespace QRCoderClarionWrapper
{
    public static partial class QRCoderWrapper
    {

        private static string CreateQRAndSave(IntPtr ptrFileInformation, dynamic payload)
        {
            var FileInformation = new QRFileInfo(ptrFileInformation);
            
            QRCode qrCode = GenerateQR(payload);
            if (!FileInformation.ReturnString && FileInformation.FileName != "")
            {
                if (File.Exists(FileInformation.FileName))
                    File.Delete(FileInformation.FileName);
                qrCode.GetGraphic(20).Save(FileInformation.FileName, FileInformation.FileType);
            }
            return "";
        }

        private static string CreateQR(IntPtr ptrFileInformation, dynamic payload)
        {
            QRCode qrCode = GenerateQR(payload);
            return Convert.ToBase64String(ImageToByte2(qrCode.GetGraphic(20), new QRFileInfo(ptrFileInformation)));
        }

        private static QRCode GenerateQR(dynamic payload)
        {
            using QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(payload.ToString(), QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            return qrCode;
        }

        private static byte[] ImageToByte2(Image img, QRFileInfo fileInformation)
        {

            using var stream = new MemoryStream();
            img.Save(stream, fileInformation.FileType);
            return stream.ToArray();
        }



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

        [DllExport("QRSkypeCall", CallingConvention = CallingConvention.StdCall)]
        public static void QRSkypeCall([MarshalAs(UnmanagedType.BStr)] string skypeUserName, IntPtr ptrFileInformation)
        {
            CreateQRAndSave(ptrFileInformation, new SkypeCall(skypeUserName));
        }

        [DllExport("QRSkypeCallAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRSkypeCallAsString([MarshalAs(UnmanagedType.BStr)] string skypeUserName, IntPtr ptrFileInformation, out int len)
        {
            var result = CreateQR(ptrFileInformation, new SkypeCall(skypeUserName));
            len = result.Length;
            return result;
        }

        [DllExport("QRSms", CallingConvention = CallingConvention.StdCall)]
        public static void QRSms([MarshalAs(UnmanagedType.BStr)] string number, [MarshalAs(UnmanagedType.BStr)] string message, IntPtr ptrFileInformation)
        {
            CreateQRAndSave(ptrFileInformation, new SMS(number, message));
        }

        [DllExport("QRSmsAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRSmsAsString([MarshalAs(UnmanagedType.BStr)] string number, [MarshalAs(UnmanagedType.BStr)] string message, IntPtr ptrFileInformation, out int len)
        {
            var result = CreateQR(ptrFileInformation, new SMS(number, message));
            len = result.Length;
            return result;

        }

        //Payload is QR Simple Text
        [DllExport("QRText", CallingConvention = CallingConvention.StdCall)]
        public static void QRText([MarshalAs(UnmanagedType.BStr)] string theText, IntPtr ptrFileInformation)
        {
            CreateQRAndSave(ptrFileInformation, theText);
            //QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            //QRCodeGenerator qrGenerator = new QRCodeGenerator();

            //QRCodeData qrCodeData = qrGenerator.CreateQrCode(theText, QRCodeGenerator.ECCLevel.Q);
            //QRCode qrCode = new QRCode(qrCodeData);
            //Bitmap qrCodeImage = qrCode.GetGraphic(20);
            //qrCodeImage.Save(FileInformation.FileName, FileInformation.FileType);
        }

        [DllExport("QRTextAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRTextAsString([MarshalAs(UnmanagedType.BStr)] string theText, IntPtr ptrFileInformation, out int len)
        {
            string result = CreateQR(ptrFileInformation, theText);
            len = result.Length;
            return result;
        }

        [DllExport("QRUrl", CallingConvention = CallingConvention.StdCall)]
        public static void QRUrl([MarshalAs(UnmanagedType.BStr)] string website, IntPtr ptrFileInformation)
        {
            CreateQRAndSave(ptrFileInformation, new Url(website));
        }

        [DllExport("QRUrlAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRUrlAsString([MarshalAs(UnmanagedType.BStr)] string website, IntPtr ptrFileInformation, out int len)
        {
            var result = CreateQR(ptrFileInformation, new Url(website));
            len = result.Length;
            return result;
        }

        [DllExport("QRVCard", CallingConvention = CallingConvention.StdCall)]
        public static void QRVCard(IntPtr ptrVcard, IntPtr ptrFileInformation)
        {
            //Retrieve and map clarion groups
            QRContact contact = new QRContact(ptrVcard);
            CreateQRAndSave(ptrFileInformation, contact.GetContactData());
        }

        [DllExport("QRVCardAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static String QRVCardAsString(IntPtr ptrVcard, IntPtr ptrFileInformation, out int len)
        {
            //Generator is used to return The contact data
            string result = CreateQR(ptrFileInformation, new QRContact(ptrVcard).GetContactData());
            len = result.Length;
            return result;


        }
    }
}
