unit parseresult_module;

interface
  uses
  classes,mshtml, sysutils,olimpbase_module, globalfunc;
  type
  parseresult_class=class(olimpbase_class)
  procedure parseresult(idevent:integer);overload;
  procedure parseresult(evdate:tdate;idsport:integer);overload;

  public
  id_champ,id_sport:integer;
  tempid_champ,tempid_com1,tempid_com2,tempid_event:integer;
  id_stakegroup,id_staketype:integer;
  evdate:tdate;
  test:string;
  maintable,smalltable:ihtmlelement;
  mcchecked:boolean;
  procedure  checkfirst;
  procedure navresultpage;
  procedure navdateandsport(date:tdate;id_sport:integer);
  procedure checkmc(tr:ihtmlelement);
  procedure checktr(tr:ihtmlelement);
  procedure checkfirsttd(td:ihtmlelement);
  procedure checksecondtd(td:ihtmlelement);
  procedure findspch(idevent:integer);
  procedure findmaintable;
  procedure parsemaintable;
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
    if pos('olimp',s)<1 then error:=1;
end;

procedure parseresult_class.checkfirsttd(td: ihtmlelement);
var
s,com1,com2,evdatestr:string;
i:integer;
begin
  s:=td.innerText;
  i:=pos(br,s);
   com2:=copy(s,i-1);
   delete(s,1,i+1);
   evdatestr:=trim(s);
   evdatestr:=transformdate(evdatestr);
   i:=pos(' - ',com2);
   com1:=copy(com2,1,i-1);
   delete(com2,1,i+2);
   com1:=trim(com1);
   com2:=trim(com2);
   tempid_com1:=wwdb.findcom(com1,id_sport,tempid_champ);
   tempid_com2:= wwdb.findcom(com2,id_sport,tempid_champ);
   tempid_event:=wwdb.findevent(evdatestr,tempid_com1,tempid_com2,tempid_champ);

end;

procedure parseresult_class.checkmc(tr: ihtmlelement);
var
s,sport,champ:string;
i:integer;
begin
 champ:=tr.innerText;
 i:=pos('.',champ);
  sport:=copy(champ,1,i-1);
  delete(champ,1,i);
  champ:=trim(champ);
  id_sport:=wwdb.findsport(sport) ;
  tempid_champ:=wwdb.findchamp(champ,id_sport) ;

end;

procedure parseresult_class.checksecondtd(td: ihtmlelement);
var
divs:icol;
divtag:iel;
s,sqlstr,staketype,stakegroup,resultstr:string;
i,resultinteger:integer;
begin
 divs:=td.all as icol;
 divs:=divs.tags('DIV') as icol;
 if divs.length=1 then
  begin
    divtag:=divs.item(0,0) as iel;
    s:=divtag.innerText;
    i:=pos(br,s);
    while i>1 do
    begin
      staketype:=copy(s,1,i-1);
      delete(s,1,i+1);
      s:=trim(s);
      i:=pos('.',staketype);
      stakegroup:=copy(staketype,1,i-1);
      delete(staketype,1,i);
      stakegroup:=trim(stakegroup);
      staketype:=trim(staketype);
      resultstr:=copy(staketype,i,100);
       resultstr:=trim(resultstr);
       if resultstr='W' then resultinteger:=1;
         if resultstr='W' then resultinteger:=1;
      id_stakegroup:=wwdb.findstakegroup(stakegroup,id_sport);
      id_staketype:=wwdb.findstaketype(staketype,id_sport,id_stakegroup);
     sqlstr:='insert into
    end;
  end;
end;

procedure parseresult_class.checktr(tr: ihtmlelement);
var
tds,atags:icol;
td,atag:iel;
vartd:ihtmlelement;
begin
 tds:=tr.all as iel;
 td:=tds.item(0,0) as iel;
  atags:=td.all as icol;
  if atags.length>0 then
   begin
     atag:=atags.item(0,0) as iel;
     atag.click;
     wait(2000);

   end;
   checkfirsttd(td);
   if error>0 then
   begin
   writeer;
   exit;
   end;
    td:=tds.item(1,0) as iel;
    checksecondtd(td);
   if error>0 then
   begin
   writeer;
   exit;
   end;
end;

procedure parseresult_class.findmaintable;
var
   tbls:ihtmlelementcollection;
 tbl:ihtmlelement;
 i,j:integer;
begin
  doc:=wb.Document as ihtmldocument2;
 elcol:=doc.all;
tbls:=elcol.tags('TABLE') as ihtmlelementcollection;

for I := 0 to tbls.length-1 do
begin
  tbl:=tbls.item(i,0)  as ihtmlelement;
  if tbl.className='smallwnd2' then
   begin
     maintable:=tbl;
     test:=maintable.innerHTML;
     exit;
   end;
end;
end;

procedure parseresult_class.findspch(idevent: integer);
var
sqlstr:string;
begin
id_sport:=-1;
sqlstr:='select event_date from event_tbl where id_event='+inttostr(idevent)+';';
evdate:=wwdb.onedate(sqlstr);
 sqlstr:='select id_champ from event_tbl where id_event='+inttostr(idevent)+';';
 id_champ:=wwdb.oneinteger(sqlstr);
 if id_champ>0 then
  begin
    sqlstr:='select min(id_sport) from champ_syn_tbl where id_champ='+inttostr(id_champ)+';';
 id_sport:=wwdb.oneinteger(sqlstr);
  if id_sport<1 then exit;


  end;

 end;

procedure parseresult_class.navdateandsport(date: tdate; id_sport: integer);
var
sels,optns,inputs:ihtmlelementcollection;
sel,optn,inp:ihtmlelement;
i,tempidsport:integer;
s:string;
day,month,year:string;
y,m,d:word;
begin
decodedate(evdate,y,m,d);
day:=inttostr(d);
month:=inttostr(m);
year:=inttostr(y);
 doc:=wb.Document as ihtmldocument2;
 elcol:=doc.all;
 sels:=elcol.tags('SELECT') as ihtmlelementcollection;
 sel:=sels.item(0,0)as ihtmlelement;
 optns:=sel.all as  ihtmlelementcollection;
 optns:=optns.tags('OPTION') as  ihtmlelementcollection;
 for I := 0 to optns.length-1 do
   begin
     optn:=optns.item(i,0) as ihtmlelement;
     s:=optn.innerText;
      tempidsport:=wwdb.findsport(s);
      if tempidsport=id_sport then
       begin
         optn.setAttribute('selected',true,0);
         break;
       end;
   end;
   sel:=sels.item(1,0)as ihtmlelement;
 optns:=sel.all as  ihtmlelementcollection;
 optns:=optns.tags('OPTION') as  ihtmlelementcollection;
 for I := 0 to optns.length-1 do
   begin
     optn:=optns.item(i,0) as ihtmlelement;
      s:=optn.getAttribute('value',0) ;
      if s=day then
       begin
         optn.setAttribute('selected',true,0);
         break;
       end;

   end;
      sel:=sels.item(2,0)as ihtmlelement;
 optns:=sel.all as  ihtmlelementcollection;
 optns:=optns.tags('OPTION') as  ihtmlelementcollection;
 for I := 0 to optns.length-1 do
   begin
     optn:=optns.item(i,0) as ihtmlelement;
      s:=optn.getAttribute('value',0) ;
      if s=month then
       begin
         optn.setAttribute('selected',true,0);
         break;
       end;

   end;
      sel:=sels.item(3,0)as ihtmlelement;
 optns:=sel.all as  ihtmlelementcollection;
 optns:=optns.tags('OPTION') as  ihtmlelementcollection;
 for I := 0 to optns.length-1 do
   begin
     optn:=optns.item(i,0) as ihtmlelement;
      s:=optn.getAttribute('value',0) ;
      if s=year then
       begin
         optn.setAttribute('selected',true,0);
         break;
       end;

   end;
   wait(200);
 inputs:=elcol.tags('INPUT') as ihtmlelementcollection;
 for I := inputs.length-1 downto 0 do
  begin
    inp:=inputs.item(i,0)  as ihtmlelement;
    if inp.getAttribute('type',0)='submit' then
    begin
     inp.click;
     wait(3000);
     exit;
    end;
  end;
end;

procedure parseresult_class.navresultpage;
var
atags:ihtmlelementcollection;
atag:ihtmlelement;
i:integer;
s:string;
begin
 doc:=wb.Document as ihtmldocument2;
 elcol:=doc.all;
 atags:=elcol.tags('A') as  ihtmlelementcollection;
 for I := 0 to atags.length-1 do
  begin
    atag:=atags.item(i,0) as ihtmlelement;
     s:=atag.innerText;
     if (s='Results')  then
     begin
      atag.click;
      wait(3000);
      exit;
     end;
  end;
  error:=2;
end;

procedure parseresult_class.parseresult(idevent: integer);

begin
error:=0;
maintable:=nil;

 checkfirst;
 navresultpage;
 if error>0 then
  begin
    writeer;
    exit;
  end;
 findspch(idevent);
 if evdate>now then error:=3;
 if id_sport<1 then  error:=4;
 if error>0 then
 begin
   writeer;
   exit;
 end;
 navdateandsport(evdate,id_sport);
 findmaintable;
 if not assigned(maintable) then error:=5;
 if error>0 then
 begin
   writeer;
   exit;
 end;
  parsemaintable;

end;

procedure parseresult_class.parsemaintable;
var
 trs,tds:ihtmlelementcollection;
 tr,td,tb:ihtmlelement;
 i,j:integer;

begin
mcchecked:=false;
   trs:=maintable.all as ihtmlelementcollection;
       tb:=trs.item(0,0)  as ihtmlelement;
                  trs:=trs.tags('TR')  as ihtmlelementcollection;


     for i := 0 to trs.length-1 do
       begin
         tr:=trs.item(i,0)  as ihtmlelement;
         if tr.className='m_c' then
          begin
            checkmc(tr);
            continue;

          end;
          if ismainchild(tb,tr) then

          checktr(tr);

       end;
end;

procedure parseresult_class.parseresult(evdate: tdate; idsport: integer);
begin

end;

end.
