unit parseresult_module;

interface
  uses
  classes,mshtml, sysutils,olimpbase_module;
  type
  parseresult_class=class(olimpbase_class)
  procedure parseresult(idevent:integer);overload;
  procedure parseresult(evdate:tdate;idsport:integer);overload;

  private
  id_champ,id_sport:integer;
  evdate:tdate;
  maintable,smalltable:ihtmlelement;
  procedure  checkfirst;
  procedure navresultpage;
  procedure navdateandsport(date:tdate;id_sport:integer);
  procedure checkmc(tr:ihtmlelement);
  procedure checktr(tr:ihtmlelement);
  procedure checkfirsttd(td:ihtmlelement);
  procedure checksecondtd(td:ihtmlelement);
  procedure findspch(idevent:integer);
  end;
implementation

{ parseresult_class }

procedure parseresult_class.checkfirst;
var
s:string;
begin
  s:=wb.LocationURL;
  if pos('olimp',s)<1 then
   begin
     wb.Navigate('olimp.kz');
     wait(3000);

   end;
end;

procedure parseresult_class.checkfirsttd(td: ihtmlelement);
begin

end;

procedure parseresult_class.checkmc(tr: ihtmlelement);
begin

end;

procedure parseresult_class.checksecondtd(td: ihtmlelement);
begin

end;

procedure parseresult_class.checktr(tr: ihtmlelement);
begin

end;

procedure parseresult_class.findspch(idevent: integer);
var
sqlstr:string;
begin
 sqlstr:='select id_champ from event_tbl where id_event='+inttostr(idevent)+';';
 id_champ:=wwdb.oneinteger(sqlstr);

 end;

procedure parseresult_class.navdateandsport(date: tdate; id_sport: integer);
begin

end;

procedure parseresult_class.navresultpage;
begin

end;

procedure parseresult_class.parseresult(idevent: integer);
begin
 checkfirst;
 navresultpage;
 findch
end;

procedure parseresult_class.parseresult(evdate: tdate; idsport: integer);
begin

end;

end.
