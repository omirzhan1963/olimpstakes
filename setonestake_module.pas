unit setonestake_module;

interface
 uses
 classes,sysutils,mshtml, workwithdb_module, confirmstake_module, globalfunc,
  insertstake_module, navchamp_module, navsport_module, login_module,
  olimpbase_module, checkbet_module, checkbetstakes_module;
 type
 setonestake=class(olimpbase_class)
 esa:evstar ;
 sum:integer;
 strategynumber:integer;
 logstr,passstr:string;
  incl1,incl2:init_class;
  l:login_class;
  nc:navchamp_class;
  ns:navsport_class;
  strictsubmit:boolean;
  insst:insertstake_class;
  cs:confirmstake_class;
  cb:checkbet_class;
  cbs:checkbetstakes_class;
   mixedevent,mixedstaketype:integer;
    betnumberstr:string;
  procedure insertstake;
  constructor create;
  procedure init(incl:init_class); overload;
  procedure init(inclvar1,inclvar2:init_class);overload;
  private
  sportari,champari:ari;
   fbr:betrecord;
  function findchfromev(id_event:integer):integer;
  function findspfromch(id_champ:integer):integer;
  procedure findspchari;
  procedure compareesa;
 end;
implementation

{ setonestake }

procedure setonestake.compareesa;
var
i,j,k,l,d,n:integer;
tempevari,tempsttypeari:ari;
b:boolean;
sl:tstringlist;
begin
sl:=tstringlist.Create;
    setlength(tempevari,0);
        setlength(tempsttypeari,0);
 k:=length(esa);
  for I := 0 to k-1 do
   begin
   b:=true;
     j:=esa[i].idevent;
      for l :=0  to length(fbr.bstakear)-1 do
       if fbr.bstakear[l].id_event=j then  b:=false;

   if b then
   begin
        d:=length(tempevari);
   setlength(tempevari,d+1);
   tempevari[d]:=j;
   end;
   end;
    k:=length(fbr.bstakear);
  for I := 0 to k-1 do
   begin
   b:=true;
     j:=fbr.bstakear[i].id_event;

      for l :=0  to length(esa)-1 do
       if esa[l].idevent=j then  b:=false;

   if b then
   begin
        d:=length(tempevari);
   setlength(tempevari,d+1);
   tempevari[d]:=j;
   end;
   end;





   k:=length(esa);
  for I := 0 to k-1 do
   begin
   b:=true;
     j:=esa[i].idevent;
     n:=esa[i].idstaketype;
      for l :=0  to length(fbr.bstakear)-1 do
       if ((fbr.bstakear[l].id_event=j) and (fbr.bstakear[l].id_staketype=n))  then  b:=false;

   if b then
   begin
        d:=length(tempsttypeari);
   setlength(tempsttypeari,d+1);
   tempsttypeari[d]:=n;
   end;
   end;
    k:=length(fbr.bstakear);
  for I := 0 to k-1 do
   begin
   b:=true;
     j:=fbr.bstakear[i].id_event;
     n:=fbr.bstakear[i].id_staketype;
      for l :=0  to length(esa)-1 do
       if ((esa[l].idevent=j) and (esa[l].idstaketype=n)) then  b:=false;

   if b then
   begin
      d:=length(tempsttypeari);
   setlength(tempsttypeari,d+1);
   tempsttypeari[d]:=n;
   end;
   end;
  sl.Clear;
  sl.LoadFromFile('mixedid_event.txt');
  for I := 0 to length(tempevari)-1 do
  sl.Add(inttostr(tempevari[i]));
  sl.SaveToFile('mixedid_event.txt');
  mixedevent:=sl.Count;
     sl.Clear;
     sl.LoadFromFile('mixedid_staketype.txt');
  for I := 0 to length(tempsttypeari)-1 do
  sl.Add(inttostr(tempsttypeari[i]));
  sl.SaveToFile('mixedid_staketype.txt');
  mixedstaketype:=sl.Count;
  sl.Free;
end;

constructor setonestake.create;
begin
inherited;
logstr:='222800';
passstr:='noik52ABDR';
l:=login_class.create;
ns:=navsport_class.Create;
nc:=navchamp_class.create;
insst:=insertstake_class.Create;
cs:=confirmstake_class.Create;
cb:=checkbet_class.Create;
strictsubmit:=false;
ermessages.Add('not assigned incl2 for confirm_class in setonestake');
   ermessages.Add('not assigned eventstakearray for insertstake_class in setonestake');
  ermessages.Add('cannot login in setonestake')   ;
  ermessages.Add('cannot navigate to selected sport in setonestake');
  ermessages.Add('cannot navigate to selected sport in setonestake');
  ermessages.Add('cannot insert stake in setonestake');
  ermessages.Add('accident error while confirming stake in setonestake');
  ermessages.Add('cannot confirm stake in setonestake');




end;

function setonestake.findchfromev(id_event: integer): integer;
var
sqlstr:string;
begin
 sqlstr:='select id_champ from event_tbl where id_event='+inttostr(id_event)+';';
 result:=wwdb.oneinteger(sqlstr)  ;
end;

procedure setonestake.findspchari;
var
i,j,k:integer;
begin

  k:=length(esa);
  setlength(sportari,k);
 setlength(champari,k);
  for I := 0 to k-1 do
    begin
    j:=findchfromev(esa[i].idevent);
   champari[i]:=j;
   j:=findspfromch(j);
   sportari[i]:=j;



    end;
end;

function setonestake.findspfromch(id_champ: integer): integer;
var
sqlstr:string;
begin
 sqlstr:='select max(id_sport) from champ_syn_tbl where id_champ='+inttostr(id_champ)+';';
 result:=wwdb.oneinteger(sqlstr)  ;

end;

procedure setonestake.init(incl: init_class);
begin
  inherited;
l.init(incl);
ns.init(incl);
nc.init(incl);
cb.init(incl);
insst.init(incl);




end;

procedure setonestake.init(inclvar1, inclvar2: init_class);
begin
init(inclvar1);
cs.init(inclvar2);
incl1:=inclvar1;
incl2:=inclvar2;
end;

procedure setonestake.insertstake;
var
s,sqlstr:string;
i:integer;

begin
    if not assigned(incl2) then  error:=1;
    if not assigned(esa) then  error:=2;
  insst.strictsubmit:=strictsubmit;
 if error>0 then
 begin
 writeer;
 exit;
 end;
    cs.init(incl2);
  s:=wb.LocationURL;
  if pos('olimp',s)<1 then
  begin
  wb.Navigate('olimp.kz');
  wait(2000);
  l.logstr:=logstr;
  l.passstr:=passstr;
   l.login;
   wait(2000);
  end;

 l.check;
 if not l.checked then  error:=3;
   if error>0 then
 begin
 writeer;
 exit;
 end;
 findspchari;
 ns.sportari:=sportari;
 ns.nav;
 if ns.error>0 then error:=4;
   if error>0 then
 begin
 writeer;
 exit;
 end;
 wait(3000);
 nc.champari:=champari;
 nc.nav;
 if nc.error>0 then error:=5;
   if error>0 then
 begin
 writeer;
 exit;
 end;
 wait(3000);
 insst.stakes:=esa;
 insst.insert;
 if insst.error>0 then error:=6;
   if error>0 then
 begin
 writeer;
 exit;
 end;
 wait(50000);
 cs.sum:=sum;
 cs.acceptchange:=true;
 cs.stakes:=esa;
 cs.confirm;
  if cs.error>0 then error:=7;
   if error>0 then
 begin
 writeer;
 exit;
 end;
 wait(2000);
 cs.check;
 if not cs.confirmed then error:=8;
 if error>0  then
 begin
 writeer;
 exit;
 end;
fbr:=cb.getfirst;
betnumberstr:=inttostr(fbr.betnum);

 compareesa;
 sqlstr:='insert into bet_tbl values('+betnumberstr+','+inttostr(fbr.betsum)+',0,'''+fbr.settledtimestr+''');';
 wwdb.setval(sqlstr);
 sqlstr:='insert into strategybet_tbl values('+inttostr(strategynumber)+','+betnumberstr+');';
 wwdb.setval(sqlstr);
 for I := 0 to length(fbr.bstakear)-1 do
   begin
   sqlstr:='insert into betstake_tbl values('+betnumberstr+','+inttostr(fbr.bstakear[i].id_event)+','+inttostr(fbr.bstakear[i].id_staketype)+','+floattostr(fbr.bstakear[i].stval)+',0);';
   wwdb.setval(sqlstr);
  sqlstr:='insert into strategystake_tbl values('+inttostr(strategynumber)+','+betnumberstr+','


   end;
 end;

end.
