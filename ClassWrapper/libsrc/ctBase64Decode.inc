qtBase64            Queue,TYPE
V                     LONG

                    END
ctBase64Decode      CLASS,TYPE,MODULE('ctBase64Decode.clw'),LINK('ctBase64Decode.clw')
qBase64               &qtBase64,PRIVATE
AddValues             PROCEDURE(*qtBase64 qBase64, long i, long amount),PRIVATE
AddValueRange         PROCEDURE(*qtBase64 qBase64, long from, long upto),PRIVATE
DecodeBase64          PROCEDURE(*CSTRING out, *CString in, long len),LONG
GetDecodeValue        PROCEDURE(*qtBase64 qBase64, string c),long,PRIVATE
CONSTRUCT             PROCEDURE()
DESTRUCT              PROCEDURE()
                    END



