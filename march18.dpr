program march18;

uses
  Forms,
  mainmarch18 in 'mainmarch18.pas' {Form1},
  globalfunc in 'globalfunc.pas',
  olimpbase_module in 'olimpbase_module.pas',
  login_module in 'login_module.pas',
  navsport_module in 'navsport_module.pas',
  navchamp_module in 'navchamp_module.pas',
  workwithdb_module in 'workwithdb_module.pas',
  parseevent_module in 'parseevent_module.pas',
  dm_module in 'dm_module.pas' {DataModule1: TDataModule},
  insertstake_module in 'insertstake_module.pas',
  confirmstake_module in 'confirmstake_module.pas',
  checkbet_module in 'checkbet_module.pas',
  strategybase_module in 'strategybase_module.pas',
  strategy1_module in 'strategy1_module.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.