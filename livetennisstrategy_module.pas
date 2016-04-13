unit livetennisstrategy_module;

interface
 uses
 classes,sysutils, checkbet_module, checkliveevent_module, globalfunc,
  insertstakelivetennis_module, login_module, navlive_module,
  navlivechamp_module, parselivetennis_module, olimpbase_module,
  confirmstake_module;
  type
  tennislive_class=class(olimpbase_class)
  l:login_class;
  nl:navlive_class;
  nc:navlivechamp_class;
  cle:checkliveevent_class;
  pe:parselivetennis_class;
  insst:insertstakelivetennis_class;
  cs:confirmstake_class;
  cb:checkbet_class;
   strategy:integer;
   incl2:init_class;
      temple,le:liveeventar;
   procedure dostrategy;
   constructor create;
   procedure init(incl:init_class);
   private

  end;
implementation

{ tennislive_class }

constructor tennislive_class.create;
begin
inherited;
  l:=login_class.create;
  nl:=navlive_class.create;
  nc:=navlivechamp_class.create;
  cle:=checkliveevent_class.create;
  pe:=parselivetennis_class.create;
  insst:=insertstakelivetennis_class.create;
  cs:=confirmstake_class.create;
  cb:=checkbet_class.create;
  strategy:=2;
end;

procedure tennislive_class.dostrategy;
var
s:string;
i,k:integer;
begin
  s:=wb.LocationURL;
  if pos('olimp',s)<1 then
  begin
  wb.Navigate('olimp.kz');
  wait(2000);

   l.login;
   wait(2000);
  end;

 l.check;
   if not l.checked then
   begin
   l.login;
   wait(2000);
   l.check;


 if not l.checked then  error:=3;
   if error>0 then
 begin
 writeer;
 exit;
 end;
   end;
 cs.init(incl2);
  nl.nav;
  wait(2000);
  nc.nav;
  k:=length(nc.foundedle);
  setlength(temple,k);
  for I := 0 to k-1 do
  begin
  temple[i].id_champ:=nc.foundedle[i].id_champ;
  temple[i].name:=nc.foundedle[i].name;
  temple[i].id_event:=nc.foundedle[i].id_event;
   cle.le[0].id_champ:=nc.foundedle[i].id_champ;
     cle.le[0].name:=nc.foundedle[i].name;
        cle.le[0].id_event:=nc.foundedle[i].id_event;
        cle.check;

    temple[i].id_event:=cle.checkedle[0].id_event;
        temple[i].id_champ:=cle.checkedle[0].id_champ;


  end;


end;

procedure tennislive_class.init(incl: init_class);
begin
inherited;
 l.init(incl);
 nl.init(incl);
 nc.init(incl);
 pe.init(incl);
 cle.init(incl);
 insst.init(incl);
 cb.init(incl);



end;

end.
