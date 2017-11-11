{******************************************************************************
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
******************************************************************************
UNIT
  Fulla
UNIT SUMMARY
  Provides utilities for the encryption library, Fulla.
ORIGINAL AUTHOR
  Kendall Bell <kendall@bellsoft.net>
REVISION HISTORY
  10/18/2017 K. Bell
    - Original version.
  10/29/2017 K. Bell
    - Completed initial interface.
    - Implemented StrToBytes.
  10/30/2017 K. Bell
    - Implemented StrToBytesInsert, BytesToStr and BytesToUInt*.
  10/31/2017 K. Bell
    - Implemented UInt16BEtoBytes*, UInt16LEtoBytes*, UInt32BEtoBytes*, UInt32LEtoBytes*,
        UInt64BEtoBytes*, UInt34LEtoBytes*.
  11/03/2017 K. Bell
    - Fixed bug in UInt16LEtoBytes, UInt32LEtoBytes and UInt64LEtoBytes.
******************************************************************************}

unit Fulla;
{$mode delphi}
interface

type
  TByteList = array of byte;

function StrToBytes(str: string): TByteList;
procedure StrToBytesInsert(str: string; var bytes: TByteList; index: integer);
function BytesToStr(bytes: TByteList): string;

function BytesToUInt16BE(bytes: TByteList; index: integer = 0): word;
function BytesToUInt16LE(bytes: TByteList; index: integer = 0): word;
function BytesToUInt32BE(bytes: TByteList; index: integer = 0): longword;
function BytesToUInt32LE(bytes: TByteList; index: integer = 0): longword;
function BytesToUInt64BE(bytes: TByteList; index: integer = 0): qword;
function BytesToUInt64LE(bytes: TByteList; index: integer = 0): qword;

function UInt16BEtoBytes(int: word): TByteList;
procedure UInt16BEtoBytesInsert(int: word; var bytes: TByteList; index: integer);
function UInt16LEtoBytes(int: word): TByteList;
procedure UInt16LEtoBytesInsert(int: word; var bytes: TByteList; index: integer);
function UInt32BEtoBytes(int: longword): TByteList;
procedure UInt32BEtoBytesInsert(int: longword; var bytes: TByteList; index: integer);
function UInt32LEtoBytes(int: longword): TByteList;
procedure UInt32LEtoBytesInsert(int: longword; var bytes: TByteList; index: integer);
function UInt64BEtoBytes(int: qword): TByteList;
procedure UInt64BEtoBytesInsert(int: qword; var bytes: TByteList; index: integer);
function UInt64LEtoBytes(int: qword): TByteList;
procedure UInt64LEtoBytesInsert(int: qword; var bytes: TByteList; index: integer);

implementation

function StrToBytes;
begin
  SetLength(result, Length(str));
  StrToBytesInsert(str, result, 0)
end;

procedure StrToBytesInsert;
var
  i, j: integer;
begin
  j := index;
  for i := 1 to Length(str) do
  begin
    bytes[j] := byte(str[i]);
    Inc(j)
  end;
end;

function BytesToStr;
var
  i: integer;
begin
  result := '';
  for i := 0 to Length(bytes) - 1 do
    result := result + char(bytes[i])
end;

function BytesToUInt16BE;
begin
  result := (word(bytes[index]) shl 8) or
            (word(bytes[index+1]))
end;

function BytesToUInt16LE;
begin
  result := (word(bytes[index])) or
            (word(bytes[index+1]) shl 8)
end;

function BytesToUInt32BE;
begin
  result := (longword(bytes[index]) shl 24) or
            (longword(bytes[index+1]) shl 16) or
            (longword(bytes[index+2]) shl 8) or
            (longword(bytes[index+3]))
end;

function BytesToUInt32LE;
begin
  result := (longword(bytes[index])) or
            (longword(bytes[index+1]) shl 8) or
            (longword(bytes[index+2]) shl 16) or
            (longword(bytes[index+3]) shl 24)
end;

function BytesToUInt64BE;
begin
  result := (qword(bytes[index]) shl 56) or
            (qword(bytes[index+1]) shl 48) or
            (qword(bytes[index+2]) shl 40) or
            (qword(bytes[index+3]) shl 32) or
            (qword(bytes[index+4]) shl 24) or
            (qword(bytes[index+5]) shl 16) or
            (qword(bytes[index+6]) shl 8) or
            (qword(bytes[index+7]))
end;

function BytesToUInt64LE;
begin
  result := (qword(bytes[index])) or
            (qword(bytes[index+1]) shl 8) or
            (qword(bytes[index+2]) shl 16) or
            (qword(bytes[index+3]) shl 24) or
            (qword(bytes[index+4]) shl 32) or
            (qword(bytes[index+5]) shl 40) or
            (qword(bytes[index+6]) shl 48) or
            (qword(bytes[index+7]) shl 56)
end;

function UInt16BEtoBytes;
begin
  SetLength(result, 2);
  UInt16BEtoBytesInsert(int, result, 0)
end;

procedure UInt16BEtoBytesInsert;
begin
  bytes[index] := byte((int shr 8) and $ff);
  bytes[index+1] := byte(int and $ff);
end;

function UInt16LEtoBytes;
begin
  SetLength(result, 2);
  UInt16LEtoBytesInsert(int, result, 0)
end;

procedure UInt16LEtoBytesInsert;
begin
  bytes[index] := byte(int and $ff);
  bytes[index+1] := byte((int shr 8) and $ff)
end;

function UInt32BEtoBytes;
begin
  SetLength(result, 4);
  UInt32BEtoBytesInsert(int, result, 0)
end;

procedure UInt32BEtoBytesInsert;
begin
  bytes[index] := byte((int shr 24) and $ff);
  bytes[index+1] := byte((int shr 16) and $ff);
  bytes[index+2] := byte((int shr 8) and $ff);
  bytes[index+3] := byte(int and $ff)
end;

function UInt32LEtoBytes;
begin
  SetLength(result, 4);
  UInt32LEtoBytesInsert(int, result, 0)
end;

procedure UInt32LEtoBytesInsert;
begin
  bytes[index] := byte(int and $ff);
  bytes[index+1] := byte((int shr 8) and $ff);
  bytes[index+2] := byte((int shr 16) and $ff);
  bytes[index+3] := byte((int shr 24) and $ff)
end;

function UInt64BEtoBytes;
begin
  SetLength(result, 8);
  UInt64BEtoBytesInsert(int, result, 0)
end;

procedure UInt64BEtoBytesInsert;
begin
  bytes[index] := byte((int shr 56) and $ff);
  bytes[index+1] := byte((int shr 48) and $ff);
  bytes[index+2] := byte((int shr 40) and $ff);
  bytes[index+3] := byte((int shr 32) and $ff);
  bytes[index+4] := byte((int shr 24) and $ff);
  bytes[index+5] := byte((int shr 16) and $ff);
  bytes[index+6] := byte((int shr 8) and $ff);
  bytes[index+7] := byte(int and $ff)
end;

function UInt64LEtoBytes;
begin
  SetLength(result, 8);
  UInt64LEtoBytesInsert(int, result, 0)
end;

procedure UInt64LEtoBytesInsert;
begin
  bytes[index] := byte(int and $ff);
  bytes[index+1] := byte((int shr 8) and $ff);
  bytes[index+2] := byte((int shr 16) and $ff);
  bytes[index+3] := byte((int shr 24) and $ff);
  bytes[index+4] := byte((int shr 32) and $ff);
  bytes[index+5] := byte((int shr 40) and $ff);
  bytes[index+6] := byte((int shr 48) and $ff);
  bytes[index+7] := byte((int shr 56) and $ff)
end;

end.

