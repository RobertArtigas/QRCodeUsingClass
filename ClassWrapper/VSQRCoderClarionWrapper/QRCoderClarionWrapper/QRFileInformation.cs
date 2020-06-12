using System;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace QRCoderClarionWrapper
{
    public enum FileTypes
    {
        jpeg = 0,
        png = 1
    }
    public struct QRFileInformation
    {
        [MarshalAs(UnmanagedType.BStr)]
        public string FileName;
        public int FileType;
        public int SaveOrReturn;
    }
    public class QRFileInfo : GroupBaseClass<QRFileInformation>
    {
        public QRFileInfo(IntPtr ptr) : base(ptr)
        {
        }
        public string FileName
        {
            get => group.FileName;

        }

        public ImageFormat FileType
        {
            
            get
            {
                return group.FileType switch
                {
                    0 => ImageFormat.Bmp,
                    1 => ImageFormat.Emf,
                    2 => ImageFormat.Wmf,
                    3 => ImageFormat.Gif,
                    4 => ImageFormat.Jpeg,
                    5 => ImageFormat.Png,
                    6 => ImageFormat.Tiff,
                    7 => ImageFormat.Exif,
                    8 => ImageFormat.Icon,
                    _ => ImageFormat.Jpeg,
                };
            }
        }
        public bool SaveImage
        {
            get
            {
                return group.SaveOrReturn == 1;
            }
        }
    }
}
