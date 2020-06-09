using System;
using System.ComponentModel;
using System.Runtime.InteropServices;

namespace QRCoderClarionWrapper
{
    public class GroupBaseClass<T> : INotifyPropertyChanged
    {

        protected T group;
        IntPtr Ptr;
        public GroupBaseClass(IntPtr ptr)
        {
            Ptr = ptr;
            group = (T)Marshal.PtrToStructure(Ptr, typeof(T));
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }
        public void UpdateGroupMemory() => Marshal.StructureToPtr(group, Ptr, false);



    }
}
