unit collectinfo_module;

interface
uses
classes,sysutils, globalfunc, login_module, navchamp_module,
  navsport_module, parseevent_module, workwithdb_module;
   type
   collectinfo=class
     l:login_class;
     ns:navsport_class;
     nc:navchamp_class;
     p:parseevent_class;
     logstr,passstr:string;
     incl:init_class;
     currusum:integer;
     restrictedsport:ari;
     restrictedchamp:ari;
     procedure ci;
     constructor create;
     private
     wwdb:workwithdb_class;
   end;


implementation

{ collectinfo }

procedure collectinfo.ci;
var
sports,champs:ari;
i,j:integer;
id_sport,id_champ:integer;
 id_sporttemp,id_champtemp:integer;
 sqlstr:string;
begin
setlength(restrictedsport,1);
restrictedsport[0]:=25;

  wwdb:=workwithdb_class.create;
  l:=login_class.create;
  l.init(incl);
  l.logstr:=logstr;
  l.passstr:=passstr;
  l.check;
    incl.wait(2000);
  if not l.checked then

  l.login;
  incl.wait(2000);
  l.check;
  if not l.checked then  exit;
  currusum:=l.currusum;
  incl.wait(2000);
   ns:=navsport_class.Create;
   ns.init(incl);
   setlength(ns.sportari,1);
   nc:=navchamp_class.create;
   nc.init(incl);
   setlength(nc.champari,1);
   p:=parseevent_class.Create;
   p.init(incl);
   sports:=wwdb.getari('select id_sport from sport_tbl;');
  for I := 0 to length(sports)-1 do
    begin
      id_sport:=sports[i];
      if not inari(id_sport,restrictedsport) then
       begin
       ns.sportari[0]:=id_sport;
       ns.nav;
       if ns.error>0 then continue;
       incl.wait(2000);
       sqlstr:='select id_champ  from champ_syn_tbl where id_sport='+inttostr(id_sport)+';';
          champs:=wwdb.getari(sqlstr);
          for j := 0 to length(champs)-1 do
           begin
           id_champ:=champs[j];
             if not inari(id_champ,restrictedchamp) then
               begin
                nc.champari[0]:=id_champ;
                ns.nav;
                incl.wait(2000);
                nc.nav;
                incl.wait(2000);
                if nc.error>0 then continue;
                if length(nc.checkedchamp)=0 then
                continue;
                id_sporttemp:=nc.checkedsport[0];
                id_champtemp:=nc.checkedchamp[0];
                if id_sporttemp<>id_sport then
                  begin
                    wwdb.setval('changesport '+inttostr(id_sporttemp)+','+inttostr(id_sport)+';');
                  end;
                  if id_champtemp<>id_champ then
                    begin
                      wwdb.setval('changechamp '+inttostr(id_champtemp)+','+inttostr(id_champ)+';');
                     continue;
                    end;

                    p.parse;
                    incl.wait(2000);
               end;
           end;






       end;



    end;
end;

constructor collectinfo.create;
begin
inherited;
logstr:='222800';
passstr:='noik52ABDR';

end;

end.
