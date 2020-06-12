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

        private static void CreateQRAndSave(dynamic data, QRFileInfo FileInformation)
        {
            if (FileInformation.FileName != string.Empty)
            {
                if (File.Exists(FileInformation.FileName))
                    File.Delete(FileInformation.FileName);

                string payload = data.ToString();
                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(payload, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);

                var qrCodeAsBitmap = qrCode.GetGraphic(20);

                qrCodeAsBitmap.Save(FileInformation.FileName, FileInformation.FileType);
            }
        }

        private static string GetImageAsString(IntPtr ptrFileInformation, string payload)
        {
            string result;
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(payload, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            var qrCodeAsBitmap = qrCode.GetGraphic(20);
            result = Convert.ToBase64String(ImageToByte2(qrCodeAsBitmap, new QRFileInfo(ptrFileInformation)));
            return result;
        }
        private static byte[] ImageToByte2(Image img, QRFileInfo fileInformation)
        {

            using (var stream = new MemoryStream())
            {
                img.Save(stream, fileInformation.FileType);
                return stream.ToArray();
            }
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
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            CreateQRAndSave(new SkypeCall(skypeUserName), FileInformation);
        }
        [DllExport("QRSkypeCallAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRSkypeCallAsString([MarshalAs(UnmanagedType.BStr)] string skypeUserName, IntPtr ptrFileInformation, out int len)
        {


            var result = GetImageAsString(ptrFileInformation, new SkypeCall(skypeUserName).ToString());
            len = result.Length;
            return result;

        }

        [DllExport("QRSms", CallingConvention = CallingConvention.StdCall)]
        public static void QRSms([MarshalAs(UnmanagedType.BStr)] string number, [MarshalAs(UnmanagedType.BStr)] string message, IntPtr ptrFileInformation)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            CreateQRAndSave(new SMS(number, message), FileInformation);
        }

        [DllExport("QRSmsAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRSmsAsString([MarshalAs(UnmanagedType.BStr)] string number, [MarshalAs(UnmanagedType.BStr)] string message, IntPtr ptrFileInformation, out int len)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);

            var result = GetImageAsString(ptrFileInformation, new SMS(number, message).ToString());
            len = result.Length;
            return result;

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
            qrCodeImage.Save(FileInformation.FileName, FileInformation.FileType);
        }

        [DllExport("QRTextAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRTextAsString([MarshalAs(UnmanagedType.BStr)] string theText, IntPtr ptrFileInformation, out int len)
        {
            string result = GetImageAsString(ptrFileInformation, theText);

            len = result.Length;
            return result;
        }

        [DllExport("QRUrl", CallingConvention = CallingConvention.StdCall)]
        public static void QRUrl([MarshalAs(UnmanagedType.BStr)] string website, IntPtr ptrFileInformation)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            CreateQRAndSave(new Url(website), FileInformation);


        }

        [DllExport("QRUrlAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static string QRUrlAsString([MarshalAs(UnmanagedType.BStr)] string website, IntPtr ptrFileInformation, out int len)
        {
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            var result = GetImageAsString(ptrFileInformation, new Url(website).ToString());
            len = result.Length;
            return result;



        }
        //Payload is VCard
        [DllExport("QRVCard", CallingConvention = CallingConvention.StdCall)]
        public static void QRVCard(IntPtr ptrVcard, IntPtr ptrFileInformation)
        {
            //Retrieve and map clarion groups
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            QRContact contact = new QRContact(ptrVcard);

            CreateQRAndSave(contact.GetContactData(), FileInformation);


        }

        [DllExport("QRVCardAsString", CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.BStr)]
        public static String QRVCardAsString(IntPtr ptrVcard, IntPtr ptrFileInformation, out int len)
        {
            string result;
            //Retrieve and map clarion groups
            QRFileInfo FileInformation = new QRFileInfo(ptrFileInformation);
            QRContact contact = new QRContact(ptrVcard);
            string payload = contact.GetContactData().ToString();
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            result = GetImageAsString(ptrFileInformation, payload);
            len = result.Length;
            return result;


        }
    }
}
