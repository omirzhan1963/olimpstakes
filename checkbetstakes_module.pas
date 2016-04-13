unit checkbetstakes_module;

interface
 uses
 classes,sysutils, olimpbase_module, globalfunc, checkonebetstake_module,
  workwithdb_module;
 type
 checkbetstakes_class=class(olimpbase_class)
   incl1,incl2:init_class;
      esa:evstar;
      procedure checkbetstakes;
      constructor create;
      procedure init(inclvar1,inclvar2:init_class);overload;
      private
      cobs:checkonebetstake_class;
 end;
implementation

{ checkbetstakes_class }

procedure checkbetstakes_class.checkbetstakes;
var
i:integer;
begin
  for i := 0 to length(esa)-1 do
  begin
  cobs.est.idevent:=esa[i].idevent;
  cobs.est.idstaketype:=esa[i].idstaketype;
  cobs.est.stakevalue:=esa[i].stakevalue;
  cobs.est.margin:=esa[i].margin;
  cobs.checonekbetstake;
  if cobs.error>0 then error:=2;
  if error>0 then writeer;
  error:=0;



  end;
end;

constructor checkbetstakes_class.create;
begin
inherited;
cobs:=checkonebetstake_class.create;

end;

procedure checkbetstakes_class.init(inclvar1, inclvar2: init_class);
begin
cobs.init(inclvar1,inclvar2);
incl1:=inclvar1;
incl2:=inclvar2;

end;

end.
