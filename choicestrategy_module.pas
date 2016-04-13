unit choicestrategy_module;

interface
 uses
 classes,sysutils, olimpbase_module, strategybase_module, login_module,
  globalfunc;
 type
 choicestrategy_class=class(olimpbase_class)
  procedure choice;
  constructor create;
  procedure init(incl1,incl2:init_class);overload;
  private
  strat:strategybase_class;
  l:login_class;
  procedure firstcheck;

 end;
implementation

{ choicestrategy_class }

procedure choicestrategy_class.choice;
begin

end;

constructor choicestrategy_class.create;
begin
inherited;
strat:=strategybase_class.create;
l:=login_class.create;
end;

procedure choicestrategy_class.firstcheck;
var
s:string;

begin
s:=wb.LocationURL;
if pos('olimp',s)<1 then
 begin
   wb.Navigate('olimp.kz');
   wait(4000);

 end;
  l.check;
  if not l.checked then
  begin
    l.login;
    wait(4000);
     l.check;
     if not l.checked then
      begin
        error:=1;

      end;
  end;

end;

procedure choicestrategy_class.init(incl1, incl2: init_class);
begin
strat.init(incl1,incl2);
 l.init(incl1);
end;

end.
