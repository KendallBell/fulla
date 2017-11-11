program testfulla;

uses
  consoletestrunner, Fulla_TestCases;

var
  App: TTestRunner;

begin
  App := TTestRunner.Create(nil);
  App.Initialize;
  App.Title := 'FPCUnit Console runner.';
  App.Run;
  App.Free;
end.

