unit checkbet_module;

interface
  uses
  classes,sysutils,math, globalfunc,mshtml, olimpbase_module, workwithdb_module;
  type
 
  checkbet_class=class(olimpbase_class)
  betnumber:integer;


  function getbetrec:betrecord;
  function getfirst:betrecord;
  constructor create;

  private
          firstinpage:integer;
  ftblindex:integer;
  firsttbl:ihtmlelement;
  maintbl:ihtmlelement;
  maintblindex:integer;
  maintrs: ihtmlelementcollection;
  fbr:betrecord;
  tempdate:string;
  tempsport:string;
  tempchamp:string;
  tempcom1,tempcom2:string;
  tempid_sport,tempid_champ,tempid_com1,tempid_com2,tempid_event:integer;
  tempstakegroup,tempstaketype:string;
  tempid_stakegroup,tempid_staketype:integer;
   tempstakeval:string;
   tempstatus:string;

   procedure parsemaintr(tr:ihtmlelement);

       procedure navigatefirst;
      procedure navtopage(pagenumber:integer);

   procedure findmaintbl;
   function ismaintr(tr:ihtmlelement):boolean;
   procedure parse1td(td:ihtmlelement);
    procedure parse2td(td:ihtmlelement);
      procedure parse3td(td:ihtmlelement);
      procedure    parsesmalltbl(tbl:ihtmlelement);
      procedure  parsestaketr(tr:ihtmlelement;ind:integer);
       procedure parse1smalltd(td:ihtmlelement;ind:integer);
    procedure parse2smalltd(td:ihtmlelement;ind:integer);
      procedure parse3smalltd(td:ihtmlelement;ind:integer);
            procedure parse4smalltd(td:ihtmlelement;ind:integer);

  end;





  implementation

{ checkbet_class }

constructor checkbet_class.create;
begin
 inherited;
   ftblindex:=15;
 ermessages.Add('incorrect bet number in checkbet_class');

end;



procedure checkbet_class.findmaintbl;
  var
i:integer;
tables,trs: ihtmlelementcollection;
tbl,btag:ihtmlelement;
 s:string;
begin
   doc:=wb.Document as ihtmldocument2;
     elcol:=doc.all;
    tables:=elcol.tags('TABLE') as ihtmlelementcollection;
    maintbl:=tables.item(ftblindex,0) as ihtmlelement ;
    maintrs:=maintbl.all as ihtmlelementcollection;
    maintrs:=maintrs.tags('TR') as ihtmlelementcollection;
    maintblindex:=maintbl.sourceIndex;
end;

function checkbet_class.getbetrec: betrecord;
var
i:integer;
tr:ihtmlelement;
begin
error:=0;
getfirst;
firstinpage:=fbr.betnum;
if ((firstinpage-betnumber)<0) or ((firstinpage-betnumber)>100) then   error:=1;
if error>0 then
begin
writeer;
 exit;
end;
i:=floor((firstinpage-betnumber)/10);
i:=i+1;
navtopage(i);
 doc:=wb.Document as ihtmldocument2;

  findmaintbl;
  for I := 1 to maintrs.length-1 do
   begin
     tr:=maintrs.item(i,0) as ihtmlelement;
     if ismaintr(tr) then
       begin
         parsemaintr(tr);
         if fbr.betnum=betnumber then
           begin
             result:=fbr;
             exit;
           end;


       end;
   end;
end;

function checkbet_class.getfirst: betrecord;
var
tr:ihtmlelement;
begin
navigatefirst;

  findmaintbl;

     tr:=maintrs.item(1,0) as ihtmlelement;
     if ismaintr(tr) then
       begin
         parsemaintr(tr);

             result:=fbr;
             exit;

   end;

end;

function checkbet_class.ismaintr(tr: ihtmlelement): boolean;
var
parentel:ihtmlelement;
begin
 parentel:=tr.parentElement;
 result:=false;
 while parentel.tagName<>'HTML' do
 begin
 if ((parentel.tagName='TABLE') and (parentel.sourceIndex<>maintblindex)) then
   begin
     exit;
   end;
   if parentel.sourceIndex=maintblindex then
    begin
      result:=true;
      exit;
    end;
  parentel:=parentel.parentElement;
 end;

end;

procedure checkbet_class.navigatefirst;
var
atags:ihtmlelementcollection;
atag:ihtmlelement;
i:integer;
s:string;
begin
    doc:=wb.Document as ihtmldocument2;
     elcol:=doc.all;
    atags:=elcol.tags('A') as  ihtmlelementcollection;
    for I := 2 to atags.length-1 do
    begin
      atag:=atags.item(i,0) as   ihtmlelement;
      s:=atag.innerText;
      s:=trim(s);
      if s='My bets' then
       begin
         atag.click;
         wait(3000);
         exit;
       end;


    end;


end;


procedure checkbet_class.navtopage(pagenumber: integer);
var
selects,optioncol,inputs:ihtmlelementcollection;
slt,optn,inp:ihtmlelement;
i:integer;

begin
 doc:=wb.Document as ihtmldocument2;
 elcol:=doc.all;
 selects:=elcol.tags('SELECT')  as  ihtmlelementcollection;
 for I := 0 to selects.length-1 do
   begin
     slt:=selects.item(i,0) as   ihtmlelement;
     if slt.getAttribute('name',0)='offset' then
     begin
       optioncol:=slt.all as ihtmlelementcollection;
       optioncol:=optioncol.tags('OPTION') as ihtmlelementcollection;
    slt:=optioncol.item(pagenumber-1,0) as    ihtmlelement   ;
    slt.setAttribute('selected',true,0);
    break;

     end;
   end;
   inputs:=elcol.tags('INPUT') as  ihtmlelementcollection;
   for I := inputs.length-1 downto 0 do
    begin
      inp:=inputs.item(i,0) as  ihtmlelement   ;
      if ((inp.className='msbtn1') and (inp.getAttribute('value',0)='Go to')) then
      begin
        inp.click;
        wait(4000);
        exit;
      end;



    end;




end;

procedure checkbet_class.parse1smalltd(td: ihtmlelement;ind:integer);
var
s:string;
begin
s:=td.innerText;
s:=trim(s);
 if s='Online' then s:='01:01:2000 00:00';
 tempdate:=transformdate(s);

end;

procedure checkbet_class.parse1td(td: ihtmlelement);
var
s:string;
begin
 s:=td.innerText;
 fbr.settledtimestr:=s;

     fbr.settledtimestr:=transformdate(fbr.settledtimestr);

end;

procedure checkbet_class.parse2smalltd(td: ihtmlelement;ind:integer);
var
s,s1,sqlstr:string;
i:integer;
br:string;
atags:ihtmlelementcollection;
atag:ihtmlelement;
begin
  atags:=td.all as ihtmlelementcollection;
  atags:=atags.tags('A')as ihtmlelementcollection;
  atag:=atags.item(0,0) as ihtmlelement;
 s:=td.innerText;
   s1:=atag.innerText;
   i:=length(s1);
   delete(s,1,i);
   s:=trim(s);
       s:=stringreplace(s,'''','$$$',[rfreplaceall]);
        s1:=stringreplace(s1,'''','$$$',[rfreplaceall]);

   i:=pos('.',s1);
   tempsport:=copy(s1,1,i-1);
   delete(s1,1,i);
   s1:=trim(s1);
   i:=length(s1);
   delete(s1,i,1);
   s1:=trim(s1);
    i:=length(s1);
    if s1[i]='.'  then  delete(s,i,1);
    i:=pos(' - ',s1 );
    tempcom2:=copy(s1,i+3,1000);
    delete(s1,i,1000);
       i:=length(s1);
    if s1[i]='.'  then  delete(s,i,1);
     tempcom1:='';
     i:=length(s1);
     while s1[i]<>'.' do
     begin
     tempcom1:=s1[i]+tempcom1;
     delete(s1,i,1);
     i:=i-1;
     end;
     if length(tempcom1)<3 then
      begin
        if s1[i]='.' then
        begin
          tempcom1:='.'+tempcom1;
          delete(s1,i,1);
          i:=i-1;
              while s1[i]<>'.' do
     begin
     tempcom1:=s1[i]+tempcom1;
     delete(s1,i,1);
     i:=i-1;
     end;
        end;
      end;
   tempchamp:=s1;
   sqlstr:='findsport N'''+tempsport+''';';
   tempid_sport:=wwdb.oneinteger(sqlstr) ;
   sqlstr:='findchamp N'''+tempchamp+''','+inttostr(tempid_sport)+';';
   tempid_champ:=wwdb.oneinteger(sqlstr);

   sqlstr:='findcom N'''+tempcom1+''','+inttostr(tempid_sport)+','+inttostr(tempid_champ)+';';

   tempid_com1:=wwdb.oneinteger(sqlstr);
   sqlstr:='findcom N'''+tempcom2+''','+inttostr(tempid_sport)+','+inttostr(tempid_champ)+';';

   tempid_com2:=wwdb.oneinteger(sqlstr);
      sqlstr:='findevent N'''+tempdate+''','+inttostr(tempid_com1)+','+inttostr(tempid_com2)+','+inttostr(tempid_champ)+';';

   tempid_event:=wwdb.oneinteger(sqlstr) ;
   i:=pos('.',s);
   tempstakegroup:=copy(s,1,i-1);
   delete(s,1,i);
   tempstaketype:=trim(s);
   tempstakegroup:=trim(tempstakegroup);
 sqlstr:='findstakegroup N'''+tempstakegroup+''','+inttostr(tempid_sport)+';';
 tempid_stakegroup:=wwdb.oneinteger(sqlstr);
    tempstaketype:=stringreplace(  tempstaketype,tempcom1,'com1',[rfreplaceall]);
       tempstaketype:=stringreplace(  tempstaketype,tempcom2,'com2',[rfreplaceall]);

    sqlstr:='findstaketype N'''+tempstaketype+''','+inttostr(tempid_sport)+','+inttostr(tempid_stakegroup)+';';
  tempid_staketype:=wwdb.oneinteger(sqlstr);

end;

procedure checkbet_class.parse2td(td: ihtmlelement);
var
s,s1:string;
btags,tdels,itags,tables:ihtmlelementcollection;
btag,itag,tbl:ihtmlelement;
i:integer;
begin
tdels:=td.all as ihtmlelementcollection;
 btags:=tdels.tags('B') as   ihtmlelementcollection;
 btag:=btags.item(0,0) as  ihtmlelement  ;
   itags:=btag.all as ihtmlelementcollection;
 itags:=itags.tags('I') as   ihtmlelementcollection;
   itag:=itags.item(0,0) as  ihtmlelement  ;
   s:=btag.innerText;
   s1:=itag.innerText;
   i:=pos(s1,s);
   delete(s,i,1000);
   s:=trim(s);
   i:=pos('#',s);
   delete(s,1,i);
   i:=pos('.',s);
   s:=copy(s,1,i-1);
   fbr.betnum:=strtoint(s);
  tables:=tdels.tags('TABLE') as ihtmlelementcollection;
    tbl:=tables.item(0,0) as  ihtmlelement  ;
    parsesmalltbl(tbl);
end;

procedure checkbet_class.parse3smalltd(td: ihtmlelement;ind:integer);
var
s:string;
begin
 s:=td.innerText;

 tempstakeval:=trim(s);
end;

procedure checkbet_class.parse3td(td: ihtmlelement);
var
s:string;
begin
 s:=td.innerText;
 s:=trim(s);
 delete(s,1,1);
 fbr.betsum:=strtoint(s);
end;

procedure checkbet_class.parse4smalltd(td: ihtmlelement; ind: integer);
var
s:string;
begin
 s:=td.innerText;

 tempstatus:=trim(s);

end;

procedure checkbet_class.parsemaintr(tr: ihtmlelement);
var
tds:ihtmlelementcollection;
td:ihtmlelement;
i,j,testint:integer;
begin
setlength(fbr.bstakear,0);
 tds:=tr.all as ihtmlelementcollection;
 tds:=tds.tags('TD') as ihtmlelementcollection;
  j:=0;
  for I := 0 to tds.length-1 do
    begin
    td:=tds.item(i,0) as ihtmlelement;
      if not ismainchild(tr,td) then  continue;
      j:=j+1;
      case j of
       1:parse1td(td);
       2:parse2td(td);
       3:parse3td(td);

      end;
    testint:=j;
    end;
end;



procedure checkbet_class.parsesmalltbl(tbl: ihtmlelement);
var
trs:ihtmlelementcollection;
tr:ihtmlelement;
  I,k: Integer;
begin
  trs:=tbl.all as ihtmlelementcollection;
  trs:=trs.tags('TR')  as ihtmlelementcollection;
  k:=trs.length-1;
  setlength(fbr.bstakear,k);
  for I := 1 to k do
  begin
  tr:=trs.item(i,0) as ihtmlelement;
   parsestaketr(tr,i-1);
  end;
end;

procedure checkbet_class.parsestaketr(tr: ihtmlelement;ind:integer);
var
tds:ihtmlelementcollection;
td:ihtmlelement;
i,j:integer;
begin
 tds:=tr.all as ihtmlelementcollection;
 tds:=tds.tags('TD') as ihtmlelementcollection;
  j:=0;
  for I := 0 to tds.length-1 do
    begin
    td:=tds.item(i,0) as ihtmlelement;

      j:=j+1;
      case j of
       1:parse1smalltd(td,ind);
       2:parse2smalltd(td,ind);
       3:parse3smalltd(td,ind);
       4:parse4smalltd(td,ind);
      end;
    end;
    fbr.bstakear[ind].id_event:=tempid_event;
    fbr.bstakear[ind].id_staketype:=tempid_staketype;
    fbr.bstakear[ind].stval:=strtofloat(tempstakeval);
    if tempstatus='Won' then
      begin
    fbr.bstakear[ind].settled:=true;
    fbr.bstakear[ind].won:=true;

      end
      else
      begin
     if tempstatus='Lost' then
      begin
    fbr.bstakear[ind].settled:=true;
    fbr.bstakear[ind].won:=false;

      end
      else
      fbr.bstakear[ind].settled:=false;
      end;


end;



end.
