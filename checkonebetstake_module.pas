unit checkonebetstake_module;

interface
  uses
 classes,sysutils, olimpbase_module, globalfunc, checkbet_module,
  confirmstake_module, insertstake_module, login_module, navchamp_module,
  navsport_module, parseevent_module, workwithdb_module;
 type
 checkonebetstake_class=class(olimpbase_class)
   incl1,incl2:init_class;
      est:evst;
      l:login_class;
       ns:navsport_class;
  nc:navchamp_class;
  pe:parseevent_class;
  insst:insertstake_class;
  cs:confirmstake_class;
  cb:checkbet_class;

      procedure firstcheck;
      procedure checonekbetstake;
      procedure init(inclvar1,inclvar2:init_class);overload;
      constructor create;
      private
      id_champ,id_sport:integer;
      trueid_champ,trueid_sport:integer;
      betid_sport,betid_champ:integer;
      brec:betrecord;

 end;
implementation

{ checkonebetstake_class }

procedure checkonebetstake_class.checonekbetstake;
label label1,label2;
var
s,sqlstr:string;
i:integer;
begin
 firstcheck;
 if error>0 then
   begin
     writeer;
     exit;
   end;
  sqlstr:='select id_champ from event_tbl where id_event='+inttostr(est.idevent)+';';
  id_champ:=wwdb.oneinteger(sqlstr);
  sqlstr:='select min(id_sport) from champ_syn_tbl where id_champ='+inttostr(id_champ)+';';
  id_sport:=wwdb.oneinteger(sqlstr);
   setlength(ns.sportari,1);
   ns.sportari[0]:=id_sport;
   label2:
   ns.nav;
   if ns.error>0 then error:=2;
    if error>0 then
   begin
     writeer;
     exit;
   end;
   wait(2000);

    setlength(nc.champari,1);
   nc.champari[0]:=id_champ;
   nc.nav;
   if nc.error>0 then error:=3;
    if error>0 then
   begin
     writeer;
     exit;
   end;
   wait(2000);
   label1:
   pe.parse;
   if pe.error>0 then error:=4;
      if length(pe.checkedchamp)=0 then error:=5;
    if error>0 then
   begin
     writeer;
     exit;
   end;

  trueid_champ:=pe.checkedchamp[0];
    sqlstr:='select min(id_sport) from champ_syn_tbl where id_champ='+inttostr(trueid_champ)+';';
  trueid_sport:=wwdb.oneinteger(sqlstr);
  if trueid_sport<>id_sport then
  begin
    sqlstr:='changesport '+inttostr(trueid_sport)+','+inttostr(id_sport)+';';
     wwdb.setval(sqlstr);
    error:=6;
    exit;

  end;
   if trueid_champ<>id_champ then
  begin
    sqlstr:='changechamp '+inttostr(trueid_champ)+','+inttostr(id_champ)+';';
     wwdb.setval(sqlstr);
    goto label1;

  end;
  setlength(insst.stakes,1);
  insst.stakes[0].idevent:=est.idevent;
  insst.stakes[0].idstaketype:=est.idstaketype;
  insst.stakes[0].stakevalue:=est.stakevalue;
  insst.stakes[0].margin:=est.margin;
  insst.strictsubmit:=true;
  insst.insert;
  if insst.error>0 then error:=7;
   if error>0 then
   begin
     writeer;
     exit;
   end;
   incl2.wait(2000);
   l.check;
   if l.currusum<10 then error:=9;
    if error>0 then
   begin
     writeer;
     exit;
   end;



   cs.acceptchange:=true;
   cs.stakes:=insst.stakes;
   cs.sum:=10;
   cs.confirm;
     incl2.wait(2000);
   cs.check;
   if not cs.confirmed then  error:=8;
     if error>0 then
   begin
     writeer;
     exit;
   end;

 brec:=cb.getfirst;
 if brec.bstakear[0].id_event<>est.idevent then
   begin
 sqlstr:='select id_champ from event_tbl where id_event='+inttostr(brec.bstakear[0].id_event)+';';
  betid_champ:=wwdb.oneinteger(sqlstr);
    sqlstr:='select min(id_sport) from champ_syn_tbl where id_champ='+inttostr(betid_champ)+';';
  betid_sport:=wwdb.oneinteger(sqlstr);
  if betid_sport<>id_sport then
     begin
       sqlstr:='changesport '+inttostr(betid_sport)+','+inttostr(id_sport)+';';
     wwdb.setval(sqlstr);
  goto label2;
     end;
    if betid_champ<>id_champ then
  begin
    sqlstr:='changechamp '+inttostr(betid_champ)+','+inttostr(id_champ)+';';
     wwdb.setval(sqlstr);
    goto label2;

  end;
   end;
   if brec.bstakear[0].id_staketype<>est.idstaketype then
     begin
       sqlstr:='changestaketype '+inttostr(brec.bstakear[0].id_staketype)+','+inttostr(est.idstaketype)+';';
       wwdb.setval(sqlstr);
     end;
end;

constructor checkonebetstake_class.create;
begin
   inherited;
     l:=login_class.create;
       ns:=navsport_class.create;
  nc:=navchamp_class.create;
  pe:=parseevent_class.create;;
  insst:=insertstake_class.create;
  cs:=confirmstake_class.create;
  cb:=checkbet_class.create;

end;

procedure checkonebetstake_class.firstcheck;

var
s,sqlstr:string;
i:integer;
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

procedure checkonebetstake_class.init(inclvar1, inclvar2: init_class);
begin
  wb:=inclvar1.wb;
  wait:=inclvar1.wait;
  l.init(inclvar1);
  ns.init(inclvar1);
  nc.init(inclvar1);
  pe.init(inclvar1);
  insst.init(inclvar1);
  cs.init(inclvar2);
  cb.init(inclvar1);

  wait:=inclvar1.wait;
  incl1:=inclvar1;
incl2:=inclvar2;

end;

end.
