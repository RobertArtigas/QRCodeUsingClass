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
                switch (group.FileType)
                {
                    case 0:
                        return ImageFormat.Bmp;
                    case 1:
                        return ImageFormat.Emf;
                    case 2:
                        return ImageFormat.Wmf;
                    case 3:
                        return ImageFormat.Gif;
                    case 4:
                        return ImageFormat.Jpeg;
                    case 5:
                        return ImageFormat.Png;
                    case 6:
                        return ImageFormat.Tiff;
                    case 7:
                        return ImageFormat.Exif;
                    case 8:
                        return ImageFormat.Icon;
                    default:
                        return ImageFormat.Jpeg;
                }
                
            }
        }
    }
}
