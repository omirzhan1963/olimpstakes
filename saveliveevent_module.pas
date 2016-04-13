unit saveliveevent_module;

interface
  uses
  classes, globalfunc, olimpbase_module, navlive_module, navlivechamp_module,
  parseevent_module, parselivetennis_module;
  type
  checkliveevent_class=class(olimpbase_class)
  ns:navlive_class;
  nc:navlivechamp_class;
  pe:parselivetennis_class;
  le:liveeventar;

  checkedle:liveeventar;
  procedure check;
  constructor create;
 procedure init(incl:init_class);override;
  end;
implementation

{ checkliveevent_class }

procedure checkliveevent_class.check;
var

 i:integer;
begin
 setlength(checkedle,1);
 checkedle[1].id_champ:=-1;
 ns.nav;
 wait(2000);
 nc.le:=le;
 nc.nav;
 wait(3000);
 pe.parse;

  if length(pe.le)>0 then

 checkedle[0].id_champ:=pe.le[0].id_champ;
  checkedle[0].name:=pe.le[0].name;
  checkedle[0].id_event:=pe.le[0].id_event;

end;

constructor checkliveevent_class.create;
begin
inherited;
  ns:=navlive_class.create;
  nc:=navlivechamp_class.create;
  pe:=parseevent_class.create;
  nc.sport:='Tennis';
  setlength(le,1);
end;

procedure checkliveevent_class.init(incl:init_class);
begin
  inherited;
ns.init(incl);
nc.init(incl);
pe.init(incl);

end;

end.
