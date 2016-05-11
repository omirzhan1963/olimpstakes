unit workwithdb_module;

interface
  uses
SysUtils, Classes, adodb, dm_module, globalfunc;
  type
  workwithdb_class=class
   query:tadoquery;
   procedure setval(qrstr:string);
   function onestring(qstr:string):string;
    function oneinteger(qstr:string):integer;
    function onereal(qstr:string):real;
    function getari(sqlstr:string):ari;
    function onedate(sqlstr:string):tdatetime;
    function findchamp(champ:string;id_sport:integer):integer;
    function findsport(sport:string):integer;
    function findcom(com:string;id_sport,id_champ:integer):integer;
    function findevent(odate:string;id_com1,id_com2,id_champ:integer):integer;
     function findstakegroup(stakegroup:string;id_sport:integer):integer;
     function findstaketype(staketype:string;id_sport,id_stakegroup:integer):integer;

     constructor create;
  destructor destroy;override;
  class var    refcount:integer;
  end;
   var
  globalwwdb:workwithdb_class =nil;
implementation


{ workwithdb_class }

constructor workwithdb_class.create;
begin
  if assigned(globalwwdb) then
begin
  self:=globalwwdb;
refcount:=refcount+1;
 exit;

end;

query:=dm_module.DataModule1.ADOQuery1;
 globalwwdb:=self;
refcount:=1;
end;

destructor workwithdb_class.destroy;
begin
 if self=globalwwdb then begin
  dec(refcount );
  if refcount=0  then
    begin
  globalwwdb:=nil;
  inherited;
    end;
  end;
end;

function workwithdb_class.findchamp(champ: string; id_sport: integer): integer;
var
sqlstr:string;
begin
 sqlstr:='findchamp  N'''+champ+''','+inttostr(id_sport)+';';
 result:=oneinteger(sqlstr);
end;

function workwithdb_class.findcom(com: string;id_sport, id_champ: integer):
 integer;
 var
 sqlstr:string;
begin
sqlstr:='findcom N'''+com+''','+inttostr(id_sport)+','+inttostr(id_champ)+';';
result:=oneinteger(sqlstr);

end;

function workwithdb_class.findevent(odate: string; id_com1, id_com2,
  id_champ: integer): integer;
  var
  sqlstr:string;
begin
 sqlstr:='findevent  N'''+odate+''','+inttostr(id_com1)+','+inttostr(id_com2)+','+inttostr(id_champ)+';';
 result:=oneinteger(sqlstr);
end;

function workwithdb_class.findsport(sport: string): integer;
var
qstr:string;
begin
 result:=-1;

qstr:='findsport N'''+sport+''';';
 query.Close;
query.SQL.Clear;
query.SQL.Add(qstr);

query.Active:=true;
if query.RecordCount>0 then

  result:=query.Fields.Fields[0].AsInteger;
query.Close;
end;

function workwithdb_class.findstakegroup(stakegroup: string;
  id_sport: integer): integer;
 var
  sqlstr:string;
begin
 sqlstr:='findstakegroup  N'''+stakegroup+''','+inttostr(id_sport)+';';
 result:=oneinteger(sqlstr);

end;

function workwithdb_class.findstaketype(staketype: string; id_sport,
  id_stakegroup: integer): integer;
var
  sqlstr:string;
begin
 sqlstr:='findstaketype  N'''+staketype+''','+inttostr(id_sport)+','+inttostr(id_stakegroup)+';';
 result:=oneinteger(sqlstr);


end;

function workwithdb_class.getari(sqlstr: string): ari;
var
k:integer;
begin
setlength(result,0);
 query.Close;
query.SQL.Clear;
query.SQL.Add(sqlstr);

query.Active:=true;
while (not query.Eof) do
  begin
  k:=length(result);
  setlength(result,k+1);


  result[k]:=query.Fields.Fields[0].AsInteger;
  query.Next;
  end;
query.Close;
end;

function workwithdb_class.onedate(sqlstr: string): tdatetime;
begin
 query.Close;
query.SQL.Clear;
query.SQL.Add(sqlstr);

query.Active:=true;
if query.RecordCount>0 then

  result:=query.Fields.Fields[0].AsDateTime;
query.Close;
end;

function workwithdb_class.oneinteger(qstr: string): integer;
begin
result:=-1;


 query.Close;
query.SQL.Clear;
query.SQL.Add(qstr);

query.Active:=true;
if query.RecordCount>0 then

  result:=query.Fields.Fields[0].AsInteger;
query.Close;
end;

function workwithdb_class.onereal(qstr: string): real;
begin
  result:=-1;


 query.Close;
query.SQL.Clear;
query.SQL.Add(qstr);

query.Active:=true;
if query.RecordCount>0 then

  result:=query.Fields.Fields[0].AsSingle;
query.Close;
end;

function workwithdb_class.onestring(qstr: string): string;
begin
result:='';


 query.Close;
query.SQL.Clear;
query.SQL.Add(qstr);

query.Active:=true;
if query.RecordCount>0 then

  result:=query.Fields.Fields[0].AsString;
query.Close;
end;

procedure workwithdb_class.setval(qrstr: string);
begin
  query.Close;
query.SQL.Clear;
query.SQL.Add(qrstr);

query.ExecSQL;

query.Close;
end;

end.
