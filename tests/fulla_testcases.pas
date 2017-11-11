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
ORIGINAL AUTHOR
  Kendall Bell <kendall@bellsoft.net>
UNIT SUMMARY
  Test cases for the Fulla base unit.
REVISION HISTORY
  11/03/2017 K. Bell
    - Original version.
******************************************************************************}

unit Fulla_TestCases;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TFullaTestCase }

  TFullaTestCase= class(TTestCase)
  published
    procedure TestStrToBytes;
    procedure TestUInt16BEtoBytes;
    procedure TestUInt16LEtoBytes;
    procedure TestUInt32BEtoBytes;
    procedure TestUInt32LEtoBytes;
    procedure TestUInt64BEtoBytes;
    procedure TestUInt64LEtoBytes;
  end;

implementation

uses
  Fulla;

{ TFullaTestCase }

procedure TFullaTestCase.TestStrToBytes;
var
  output: TBytes;
begin
  output := StrToBytes('abc');
  AssertEquals('Output should have length of 3.', 3, Length(output));
  AssertEquals('Index 0 should be $61.', $61, output[0]);
  AssertEquals('Index 1 should be $62.', $62, output[1]);
  AssertEquals('Index 2 should be $63.', $63, output[2]);
  AssertEquals('Output should be ''''abc''''.', 'abc', BytesToStr(output))
end;

procedure TFullaTestCase.TestUInt16BEtoBytes;
var
  output: TBytes;
begin
  output := UInt16BEtoBytes($0a0b);
  AssertEquals('Output should have length of 2.', 2, Length(output));
  AssertEquals('Index 0 should be $0A, ' + IntToHex(output[0], 2) + ' found.', $0a, output[0]);
  AssertEquals('Index 1 should be $0B, ' + IntToHex(output[1], 2) + ' found.', $0b, output[1]);
  AssertEquals('Output should be $0A0B.', $0a0b, BytesToUInt16BE(output))
end;

procedure TFullaTestCase.TestUInt16LEtoBytes;
var
  output: TBytes;
begin
  output := UInt16LEtoBytes($0a0b);
  AssertEquals('Output should have length of 2.', 2, Length(output));
  AssertEquals('Index 0 should be $0B, ' + IntToHex(output[0], 2) + ' found.', $0b, output[0]);
  AssertEquals('Index 1 should be $0A, ' + IntToHex(output[1], 2) + ' found.', $0a, output[1]);
  AssertEquals('Output should be $0A0B.', $0a0b, BytesToUInt16LE(output))
end;

procedure TFullaTestCase.TestUInt32BEtoBytes;
var
  output: TBytes;
begin
  output := UInt32BEtoBytes($0a0b0c0d);
  AssertEquals('Output should have length of 4.', 4, Length(output));
  AssertEquals('Index 0 should be $0A.', $0a, output[0]);
  AssertEquals('Index 1 should be $0B.', $0b, output[1]);
  AssertEquals('Index 2 should be $0C.', $0c, output[2]);
  AssertEquals('Index 3 should be $0D.', $0d, output[3]);
  AssertEquals('Output should be $0A0B0C0D.', $0a0b0c0d, BytesToUInt32BE(output))
end;

procedure TFullaTestCase.TestUInt32LEtoBytes;
var
  output: TBytes;
begin
  output := UInt32LEtoBytes($0a0b0c0d);
  AssertEquals('Output should have length of 4.', 4, Length(output));
  AssertEquals('Index 0 should be $0D.', $0d, output[0]);
  AssertEquals('Index 1 should be $0C.', $0c, output[1]);
  AssertEquals('Index 2 should be $0B.', $0b, output[2]);
  AssertEquals('Index 3 should be $0A.', $0a, output[3]);
  AssertEquals('Output should be $0A0B0C0D.', $0a0b0c0d, BytesToUInt32LE(output))
end;

procedure TFullaTestCase.TestUInt64BEtoBytes;
var
  output: TBytes;
begin
  output := UInt64BEtoBytes($0a0b0c0d0e0f1011);
  AssertEquals('Output should have length of 8.', 8, Length(output));
  AssertEquals('Index 0 should be $0A.', $0a, output[0]);
  AssertEquals('Index 1 should be $0B.', $0b, output[1]);
  AssertEquals('Index 2 should be $0C.', $0c, output[2]);
  AssertEquals('Index 3 should be $0D.', $0d, output[3]);
  AssertEquals('Index 4 should be $0E.', $0e, output[4]);
  AssertEquals('Index 5 should be $0F.', $0f, output[5]);
  AssertEquals('Index 6 should be $10.', $10, output[6]);
  AssertEquals('Index 7 should be $11.', $11, output[7]);
  AssertEquals('Output should be $0A0B0C0D0E0F1011.', $0a0b0c0d0e0f1011, BytesToUInt64BE(output))
end;

procedure TFullaTestCase.TestUInt64LEtoBytes;
var
  output: TBytes;
begin
  output := UInt64LEtoBytes($0a0b0c0d0e0f1011);
  AssertEquals('Output should have length of 8.', 8, Length(output));
  AssertEquals('Index 0 should be $11.', $11, output[0]);
  AssertEquals('Index 1 should be $10.', $10, output[1]);
  AssertEquals('Index 2 should be $0F.', $0f, output[2]);
  AssertEquals('Index 3 should be $0E.', $0e, output[3]);
  AssertEquals('Index 4 should be $0D.', $0d, output[4]);
  AssertEquals('Index 5 should be $0C.', $0c, output[5]);
  AssertEquals('Index 6 should be $0B.', $0b, output[6]);
  AssertEquals('Index 7 should be $0A.', $0a, output[7]);
  AssertEquals('Output should be $0A0B0C0D0E0F1011.', $0a0b0c0d0e0f1011, BytesToUInt64LE(output))
end;

initialization

  RegisterTest(TFullaTestCase);
end.

