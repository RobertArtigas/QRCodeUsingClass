                    MEMBER

                    MAP
                    END

  include('ctBase64Decode.inc'),once

ctBase64Decode.Construct    PROCEDURE()

  CODE
  SELF.qBase64 &= new(qtBase64)
  Self.AddValues(SELF.qBase64,-1,43)
  Self.AddValues(SELF.qBase64,62,1)
  Self.AddValues(SELF.qBase64,-1,3)
  Self.AddValues(SELF.qBase64,63,1)
  Self.AddValueRange(SELF.qBase64,52,61)
  Self.AddValues(SELF.qBase64,-1,7)
  Self.AddValueRange(SELF.qBase64,0,25)
  Self.AddValues(SELF.qBase64,-1,6)
  Self.AddValueRange(SELF.qBase64,26,51)
  Self.AddValues(SELF.qBase64,-1,5)
  
ctBase64Decode.Destruct PROCEDURE()  
  CODE
  FREE(Self.qBase64)
  DISPOSE(Self.Qbase64)
  

ctBase64Decode.AddValues    PROCEDURE(*qtBase64 qBase64, long i, long amount)  
  CODE
  qBase64.V = i
  LOOP a#=1 to amount
    Add(qBase64)
  END
  
ctBase64Decode.AddValueRange    PROCEDURE(*qtBase64 qBase64, long from, long upto)  
  CODE
  
  LOOP a#=from to upto
    qBase64.V = a#
    Add(qBase64)
  END   
  
ctBase64Decode.DecodeBase64 PROCEDURE(*CSTRING out, *CString in, long len)
i                             LONG
n                             LONG
tmp                           LONG

  CODE
  
  IF len-1 < 0 THEN return -1.
  IF len-1 = 0 THEN
    out[1] = '<0>'
    return 0
  END
 
  n = 1
  loop i = 1 to len-1 by 4
    tmp = Self.GetDecodeValue(SELF.qBase64,in[i])
    tmp *=64
    tmp += Self.GetDecodeValue(SELF.qBase64,in[i+1])
    tmp *= 64
    if in[i + 2] <> '=' THEN
      tmp += Self.GetDecodeValue(SELF.qBase64,in[i+2])
    END
    tmp *= 64
    if in[i + 3] <> '=' THEN
      tmp += Self.GetDecodeValue(SELF.qBase64,in[i+3])
    END
    out[n] = chr(BSHIFT(band(tmp, 00FF0000h),-16)) ; n += 1;
    out[n] = chr(BSHIFT(band(tmp, 0000FF00h),-8)) ; n += 1;
    out[n] = chr(BSHIFT(band(tmp, 000000FFh),0)) ; n += 1
  END
  return n-1
  
ctBase64Decode.GetDecodeValue   PROCEDURE(*qtBase64 qBase64, string c)
u                                 ULONG

  CODE
  u = val(c) + 1
  Get(qBase64,U)
  RETURN qBase64.V  
  

  
  
  
  
