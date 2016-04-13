unit strategybase_module;

interface
  uses
  classes,sysutils,mshtml, workwithdb_module, setonestake_module, globalfunc,
  olimpbase_module, login_module, checkbetstakes_module;
  type
  strategybase_class=class(olimpbase_class)
  incl1,incl2:init_class;
  strategynumber:integer;
  neededsum:integer;
  priority:integer;
    procedure dostrategy;virtual;
    procedure preparestrategy;
    constructor create;
    procedure init(inclvar1,inclvar2:init_class);overload;
    private
    strategystakesnumber:integer;
     sum:integer;

    stakesari:ari;
    esa:evstar;
    insst:setonestake;
    l:login_class;
    cbs:checkbetstakes_class;
    procedure firstcheck;
  end;
implementation

{ strategybase_class }

constructor strategybase_class.create;
begin
inherited;
  cbs:=checkbetstakes_class.create;
 insst:=setonestake.create;
 l:=login_class.create;

end;

procedure strategybase_class.dostrategy;
var
sqlstr:string;
i,j,k:integer;
tempid:integer;
begin
firstcheck;
if error>0 then
 begin
   writeer;
   exit;
 end;
 sqlstr:='select count(stakenumber) from strategystake_tbl where strategy='+inttostr(strategynumber)+';';
  strategystakesnumber:=wwdb.oneinteger(sqlstr);
 for I := 1 to strategystakesnumber do
  begin
  sqlstr:='select count(id_event) from strategystake_tbl where strategy='+inttostr(strategynumber)+' and stakenumber='+inttostr(i)+';';
   k:=wwdb.oneinteger(sqlstr);
   sqlstr:='select min(sum) from strategystake_tbl where strategy='+inttostr(strategynumber)+' and stakenumber='+inttostr(i)+';';
    sum:=wwdb.oneinteger(sqlstr);
      l.check;
      if l.currusum<10 then  error:=3;
      if error>0 then
      begin
        writeer;
        exit;
      end;
      if sum>l.currusum then  sum:=l.currusum;

   setlength(esa,k);
   tempid:=0;
   for j := 1 to k do
      begin
       sqlstr:='select min(id) from strategystake_tbl where id>'+inttostr(tempid)+' and strategy='+inttostr(strategynumber)+' and stakenumber='+inttostr(i)+';';
        tempid:=wwdb.oneinteger(sqlstr);
        sqlstr:='select id_event from strategystake_tbl where id='+inttostr(tempid)+';';
         esa[j-1].idevent:=wwdb.oneinteger(sqlstr);
         sqlstr:='select id_staketype from strategystake_tbl where id='+inttostr(tempid)+';';
         esa[j-1].idstaketype:=wwdb.oneinteger(sqlstr);
          sqlstr:='select stakeval from strategystake_tbl where id='+inttostr(tempid)+';';
         esa[j-1].stakevalue:=wwdb.onereal(sqlstr);
            sqlstr:='select margin from strategystake_tbl where id='+inttostr(tempid)+';';
         esa[j-1].margin:=wwdb.onereal(sqlstr);

      end;
      insst.esa:=esa;
      insst.strategynumber:=strategynumber;
      insst.sum:=sum;


      insst.insertstake;

      if ((insst.mixedevent>0) or (insst.mixedstaketype>0)) then
      begin
      cbs.esa:=esa;
      cbs.checkbetstakes;
      end;
  end;

end;

procedure strategybase_class.firstcheck;

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

procedure strategybase_class.init(inclvar1, inclvar2: init_class);
begin
incl1:=inclvar1;
incl2:=inclvar2;
l.init(inclvar1);
insst.init(inclvar1,inclvar2);
cbs.init(inclvar1,inclvar2);
wb:=inclvar1.wb;
wait:=inclvar1.wait;
end;

procedure strategybase_class.preparestrategy;
var
sqlstr:string;

begin
 sqlstr:='strategy'+inttostr(strategynumber)+' ;';


 wwdb.setval(sqlstr);
end;

end.
