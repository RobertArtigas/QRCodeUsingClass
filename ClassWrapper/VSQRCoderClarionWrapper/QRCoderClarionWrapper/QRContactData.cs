using System;
using System.Runtime.InteropServices;
using System.Windows;
using static QRCoder.PayloadGenerator;
using static QRCoder.PayloadGenerator.ContactData;

namespace QRCoderClarionWrapper
{
    public struct QRContactData
    {
        public int OutputType;
        [MarshalAs(UnmanagedType.BStr)]
        public string FirstName;
        [MarshalAs(UnmanagedType.BStr)]
        public string LastName;
#nullable enable
        [MarshalAs(UnmanagedType.BStr)]
        public string? NickName;
        [MarshalAs(UnmanagedType.BStr)]
        public string? Phone;
        [MarshalAs(UnmanagedType.BStr)]
        public string? MobilePhone;
        [MarshalAs(UnmanagedType.BStr)]
        public string? WorkPhone;
        [MarshalAs(UnmanagedType.BStr)]
        public string? EmailAddress;
        [MarshalAs(UnmanagedType.BStr)]
        public string? Birthday;
        [MarshalAs(UnmanagedType.BStr)]
        public string? Website;
        [MarshalAs(UnmanagedType.BStr)]
        public string? Street;
        [MarshalAs(UnmanagedType.BStr)]
        public string? HouseNumber;
        [MarshalAs(UnmanagedType.BStr)]
        public string? City;
        [MarshalAs(UnmanagedType.BStr)]
        public string? ZipCode;
        [MarshalAs(UnmanagedType.BStr)]
        public string? Country;
        [MarshalAs(UnmanagedType.BStr)]
        public string? Note;
        [MarshalAs(UnmanagedType.BStr)]
        public string? StateRegion;
        public int AddressOrder;
    }
    public class QRContact : GroupBaseClass<QRContactData>
    {

        public QRContact(IntPtr ptr) : base(ptr)
        {
        }
        public ContactOutputType OutputType
        {
            get
            {
                return group.OutputType switch
                {
                    0 => ContactOutputType.MeCard,
                    1 => ContactOutputType.VCard21,
                    2 => ContactOutputType.VCard3,
                    3 => ContactOutputType.VCard4,
                    _ => ContactOutputType.VCard3,
                };
            }
        }
        public string FirstName
        {
            get => group.FirstName;
          
        }
       
        public string LastName
        {
            get => group.LastName;
           
        }

        public string? Phone
        {
            get => group.Phone;
        }
        public string? MobilePhone
        {
            get => group.MobilePhone;
        }
        public string? WorkPhone
        {
            get => group.WorkPhone;
        }
        public string? NickName
        {
            get => group.NickName;
        }
        public string? EmailAddress
        {
            get => group.EmailAddress;
        }
        public DateTime? Birthday
        {
            get
            {
                
                if (group.Birthday == null)
                    return null;
                return Convert.ToDateTime(group.Birthday);
            }
        }
        public string? Website
        {
            get => group.Website;
        }
        public string? Street
        {
            get => group.Street;
        }
        public string? HouseNumber
        {
            get => group.HouseNumber;
        }
        public string? City
        {
            get => group.City;
        }
        public string? ZipCode
        {
            get => group.ZipCode;
        }
        public string? Country
        {
            get => group.Country;
        }
        public string? Note
        {
            get => group.Note;
        }
        public string? StateRegion
        {
            get => group.StateRegion;
        }
        public AddressOrder AddressOrder
        {
            get
            {
                return group.AddressOrder switch
                {
                    1 => AddressOrder.Reversed,
                    _ => AddressOrder.Default,
                };
            }
        }

        public ContactData GetContactData()
        {

            return new ContactData
            (
                OutputType,
                FirstName,
                LastName,
                NickName,
                Phone,
                MobilePhone,
                WorkPhone,
                EmailAddress,
                Birthday,
                Website,
                Street,
                HouseNumber,
                City,
                ZipCode,
                Country,
                Note,
                StateRegion,
                AddressOrder
            );
        }

    }
}
