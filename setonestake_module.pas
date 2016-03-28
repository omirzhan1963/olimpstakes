unit setonestake_module;

interface
 uses
 classes,sysutils,mshtml, workwithdb_module, confirmstake_module, globalfunc,
  insertstake_module, navchamp_module, navsport_module, login_module,
  olimpbase_module, checkbet_module;
 type
 setonestake=class(olimpbase_class)
 esa:evstar ;
 sum:integer;
 logstr,passstr:string;
  incl2:init_class;
  l:login_class;
  nc:navchamp_class;
  ns:navsport_class;
  insst:insertstake_class;
  cs:confirmstake_class;
  cb:checkbet_class;
  procedure insertstake;
  constructor create;
  procedure init(incl:init_class); override;
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
     sl.Clear;
     sl.LoadFromFile('mixedid_staketype.txt');
  for I := 0 to length(tempsttypeari)-1 do
  sl.Add(inttostr(tempsttypeari[i]));
  sl.SaveToFile('mixedid_staketype.txt');
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

procedure setonestake.insertstake;
var
s:string;
begin
    if not assigned(incl2) then  error:=5;
    if not assigned(esa) then  error:=4;

 if error>0 then  exit;
  s:=wb.LocationURL;
  if pos('olimp',s)<1 then
  begin
  l.logstr:=logstr;
  l.passstr:=passstr;
   l.login;
   wait(2000);
  end;

 l.check;
 if not l.checked then  error:=6;
   if error>0 then  exit;
 findspchari;
 ns.sportari:=sportari;
 ns.nav;
 wait(3000);
 nc.champari:=champari;
 nc.nav;
 wait(3000);
 insst.stakes:=esa;
 insst.insert;
 wait(5000);
 cs.sum:=sum;
 cs.acceptchange:=true;
 cs.confirm;
 wait(2000);
 cs.check;
 if not cs.confirmed then error:=10;
 if error>0  then exit;
fbr:=cb.getfirst;
 compareesa;
end;

end.
