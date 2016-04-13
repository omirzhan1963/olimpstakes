unit Unit1;

interface
  uses
  classes, globalfunc, olimpbase_module, navlive_module, navlivechamp_module,
  parseevent_module;
  type
  checkliveevent_class=class(olimpbase_class)
  ns:navlive_class;
  nc:navlivechamp_class;
  pe:parseevent_class;
  le:liveeventar;
  checkedle:liveeventar;
  procedure check;
  constructor create;
 procedure init(incl:init_class);override;
  end;
implementation

{ checkliveevent_class }

procedure checkliveevent_class.check;
begin

end;

constructor checkliveevent_class.create;
begin
inherited;
  ns:=navlive_class.create;
  nc:=navlivechamp_class.create;
  pe:=parseevent_class.create;
  nc.sport:='Tennis';
end;

procedure checkliveevent_class.init(incl:init_class);
begin
  inherited;
ns.init(incl);
nc.init(incl);
pe.init(incl);

end;

end.
