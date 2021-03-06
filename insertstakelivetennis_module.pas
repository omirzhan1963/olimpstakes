unit insertstakelivetennis_module;

interface
 uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module,RegularExpressions;
   type
   staketemp=record
     sttype:string;
     stval:string;


   end;
   stakestemp=array of staketemp;

   insertstakelivetennis_class=class(olimpbase_class)
   lc:livechampar;
   le:liveeventar;
   lsg:livestakegroupar;
    lst:livestaketypear;
        stakes:evstar;
           stakesinserted:evstar;
           strictsubmit:boolean;
    procedure parse;
    procedure insert;
    constructor create;
    private
    id_sport,id_champ,id_event:integer;
    id_com1,id_com2:integer;
    id_stakegroup:integer;
    olimpdate:string;
    sts:stakestemp;
    com1,com2:string;
    odate:string;
    mcchecked:boolean;
    checkedchamp:ari;
    situationstr:string;

    submitbtn:ihtmlelement;
    submitbtnsettled:boolean;
       trange1,trange2:ihtmltxtrange;
       body:ihtmlbodyelement;

      stakechecked:boolean;
    procedure deleterefresh;
    procedure parsemc(tr:ihtmlelement);
      procedure parsehi(tr:ihtmlelement);
     procedure parsetr (tr:ihtmlelement);
     procedure parsenobr(nbr:ihtmlelement);
    procedure insertstakeindb;
    procedure parseinnerb(s:string);
    procedure parseeventtd(td:ihtmlelement);
    procedure insertstake(el:ihtmlelement);
   end;
implementation

{ insertstakelivetennis_class }

constructor insertstakelivetennis_class.create;
begin
 inherited;
ermessages.Add('form not found in insertstakelivetennis_class');
ermessages.Add('not enough stakes checked in insetrstakelivetennis_class');
end;

procedure insertstakelivetennis_class.deleterefresh;
  var
  inputs:ihtmlelementcollection;
  inp:ihtmlelement;
  i:integer;
  at:attrs;
begin
   inputs:=form.all as ihtmlelementcollection;
   inputs:=inputs.tags('INPUT')  as ihtmlelementcollection;
   setlength(at,1);
   at[0].name:='id';
   at[0].value:='refresh';
   for I := 0 to inputs.length-1 do
     begin
       inp:=inputs.item(i,0) as ihtmlelement;
       if hasattrs(inp,at) then
        inp.setAttribute('checked',false,0);
        exit;
     end;
end;

procedure insertstakelivetennis_class.insert;
var
at:attrs;
 trs,tds,inputs:ihtmlelementcollection;
 tr,td,inp:ihtmlelement;
 i,j,champind:integer;
 sqlstr:string;

begin

 setlength(stakesinserted,0);
 mcchecked:=false;
 submitbtnsettled:=false;
 stakechecked:=false;

doc:=wb.Document as ihtmldocument2;

  setlength(at,1);
  at[0].name:='name';
  at[0].value:='BetLine';
  findform(at);
  if not assigned(form) then error:=1;
       if error>0 then
       begin
         writeer;
         exit;
       end;
       deleterefresh;
       wait(1000);
    doc:=wb.Document as ihtmldocument2;
      body:=doc.body as ihtmlbodyelement;
 trange1:=body.createTextRange;
 findform(at);
     if not assigned(form) then error:=1;
       if error>0 then
       begin
         writeer;
         exit;
       end;
  trs:=form.all as ihtmlelementcollection;
  trs:=trs.tags('TR')as ihtmlelementcollection;
  for I := 0 to trs.length-1 do
    begin
      tr:=trs.item(i,0) as ihtmlelement;
      if tr.className='m_c' then
      begin
        parsemc(tr);
if error>90 then
exit;

        continue;
      end;


       if tr.className='hi' then
      begin
        parsehi(tr);
if error>90 then
 exit;

        continue;
      end;
      parsetr(tr);
    end;
    wait(200);
    if strictsubmit then
     begin
       if length(stakesinserted)<length(stakes) then error:=2;
       if error>0 then
       begin
         writeer;
         exit;
       end;
     end;
 if stakechecked then
 submitbtn.click;

end;

procedure insertstakelivetennis_class.insertstake(el: ihtmlelement);
var
i,j,id_staketype,k:integer;
sqlstr,st,sv:string;
inputs:ihtmlelementcollection;
inp:ihtmlelement;
begin
 st:=sts[0].sttype;
      st:=stringreplace(st,'''','$$$',[rfreplaceall]);
    st:=stringreplace(st,com1,'com1',[rfreplaceall]);
     st:=stringreplace(st,com2,'com2',[rfreplaceall]);
  sv:=sts[0].stval;
  sqlstr:='findstaketype N'''+st+''','+inttostr(id_sport)+','+inttostr(id_stakegroup)+';';
  id_staketype:=wwdb.oneinteger(sqlstr);
   for j := 0 to length(stakes)-1 do
     begin
       if ((stakes[j].idevent=id_event) and (stakes[j].idstaketype=id_staketype) and (abs(stakes[j].stakevalue-strtofloat(sts[0].stval))<stakes[j].margin)) then
        begin
         inputs:=el.all as ihtmlelementcollection;
         inp:=inputs.item(0,0) as ihtmlelement;
          inp.setAttribute('checked',true,0);
           stakechecked:=true;
           k:=length( stakesinserted );
           setlength(stakesinserted,k+1);
           stakesinserted[k]:=stakes[j];

           exit;
        end;
     end;
  for I := 1 to length(sts)-1 do
   begin
     st:=st+'@@@'+sts[i].sttype;
     st:= stringreplace(st,'''','$$$',[rfreplaceall]);
   st:= stringreplace(st,com1,'com1',[rfreplaceall]);
   st:=  stringreplace(st,com2,'com2',[rfreplaceall]);
  sv:=sts[i].stval;
  sqlstr:='findstaketype N'''+st+''','+inttostr(id_sport)+','+inttostr(id_stakegroup)+';';
  id_staketype:=wwdb.oneinteger(sqlstr);
for j := 0 to length(stakes)-1 do
     begin
       if ((stakes[j].idevent=id_event) and (stakes[j].idstaketype=id_staketype) and (abs(stakes[j].stakevalue-strtofloat(sts[0].stval))<stakes[j].margin)) then
        begin
         inputs:=el.all as ihtmlelementcollection;
         inp:=inputs.item(i,0) as ihtmlelement;
          inp.setAttribute('checked',true,0);
           stakechecked:=true;
           k:=length( stakesinserted );
           setlength(stakesinserted,k+1);
           stakesinserted[k]:=stakes[j];

           exit;
        end;
     end;
   end;

end;

procedure insertstakelivetennis_class.insertstakeindb;
var
i,id_staketype:integer;
sqlstr,st,sv:string;
begin
 if length(sts)=0 then exit;
  st:=sts[0].sttype;
      st:=stringreplace(st,'''','$$$',[rfreplaceall]);
    st:=stringreplace(st,com1,'com1',[rfreplaceall]);
     st:=stringreplace(st,com2,'com2',[rfreplaceall]);
  sv:=sts[0].stval;
  sqlstr:='findstaketype N'''+st+''','+inttostr(id_sport)+','+inttostr(id_stakegroup)+';';
  id_staketype:=wwdb.oneinteger(sqlstr);
  sqlstr:='insertstakes '+inttostr(id_event)+','+inttostr(id_staketype)+','+sv+';';
  wwdb.setval(sqlstr);
  for I := 1 to length(sts)-1 do
   begin
     st:=st+'@@@'+sts[i].sttype;
     st:= stringreplace(st,'''','$$$',[rfreplaceall]);
   st:= stringreplace(st,com1,'com1',[rfreplaceall]);
   st:=  stringreplace(st,com2,'com2',[rfreplaceall]);
  sv:=sts[i].stval;
  sqlstr:='findstaketype N'''+st+''','+inttostr(id_sport)+','+inttostr(id_stakegroup)+';';
  id_staketype:=wwdb.oneinteger(sqlstr);
  sqlstr:='insertlivetennisstakes '+inttostr(id_event)+','+inttostr(id_staketype)+','+sv+','+'N'''+situationstr+''';';
  wwdb.setval(sqlstr);
   end;


end;

procedure insertstakelivetennis_class.parse;
var
at:attrs;
 trs,tds,inputs:ihtmlelementcollection;
 tr,td,inp:ihtmlelement;
 i,j,champind:integer;
 sqlstr:string;

begin

 setlength(stakesinserted,0);
 mcchecked:=false;
 submitbtnsettled:=false;
 stakechecked:=false;
     setlength(checkedchamp,0);


 doc:=wb.Document as ihtmldocument2;
  setlength(at,1);
  at[0].name:='name';
  at[0].value:='BetLine';
      findform(at);
        if not assigned(form) then exit;
deleterefresh;
wait(6000);

 doc:=wb.Document as ihtmldocument2;
     findform(at);
  if not assigned(form) then exit;
  trs:=form.all as ihtmlelementcollection;
  trs:=trs.tags('TR')as ihtmlelementcollection;
  for I := 0 to trs.length-1 do
    begin
      tr:=trs.item(i,0) as ihtmlelement;
      if tr.className='m_c' then
      begin
        parsemc(tr);
if error>0 then exit;

        continue;
      end;
      if not mcchecked then  continue;

       if tr.className='hi' then
      begin
        parsehi(tr);
if error>0 then exit;

        continue;
      end;
      parsetr(tr);
    end;

end;



procedure insertstakelivetennis_class.parseeventtd(td: ihtmlelement);
var
fonts,imgs:ihtmlelementcollection;
font,img:ihtmlelement;
i,j,k:integer;
s,s1,s2,sqlstr:string;
 rg,rg1:tregex;
mch:tmatch;
gr:tgroup;
begin
s:=td.innerText;
i:=pos(' - ',s);
s1:=copy(s,1,i-1);
s2:=td.innerHTML;
i:=pos('src="https://www.olimpkz.com/img/ball.png"',s2);

if i>0 then
begin
 j:=pos(s1,s2);
 if i<j then situationstr:='serve first.'
 else situationstr:='serve second.';

end
else
situationstr:='serve not defined.';
 fonts:=td.all as ihtmlelementcollection;
 fonts:=fonts.tags('FONT') as ihtmlelementcollection;
 if fonts.length>1 then
 begin
  font:=fonts.item(1,0) as ihtmlelement;
  s2:=font.innerText;
  situationstr:=situationstr+s2;
  i:=pos(s2,s);
  if i>1 then

  delete(s,i,1000);
  s:=trim(s);
 end;
 for I := 0 to length(le)-1 do
   begin
     if ((le[i].id_champ=id_champ) and(le[i].name=s)) then
      begin
        id_event:=le[i].id_event;
        exit;
      end;
   end;
  rg:=tregex.Create('(.*?)\s\-\s');
 rg1:=tregex.Create('\s\-\s(.*)');
 if rg.IsMatch(s) then
  begin
    mch:=rg.Match(s);
    gr:=mch.Groups[1];
    com1:=gr.Value;
    com1:=trim(com1);
    com1:=stringreplace(com1,'''','$$$',[rfreplaceall]);
    sqlstr:='findcom N'''+com1+''','+inttostr(id_sport)+','+inttostr(id_champ)+';';
    id_com1:=wwdb.oneinteger(sqlstr);
  end
  else error:=6;
  if error>0 then exit;
   if rg1.IsMatch(s) then
  begin
    mch:=rg1.Match(s);
    gr:=mch.Groups[1];
    com2:=gr.Value;
    com2:=trim(com2);
    com2:=stringreplace(com2,'''','$$$',[rfreplaceall]);
    sqlstr:='findcom N'''+com2+''','+inttostr(id_sport)+','+inttostr(id_champ)+';';
    id_com2:=wwdb.oneinteger(sqlstr);
  end
  else error:=7;
  if error>0 then exit;
  sqlstr:='findevent N'''+odate+''','+inttostr(id_com1)+','+inttostr(id_com2)+','+inttostr(id_champ)+';';
  id_event:=wwdb.oneinteger(sqlstr);
    k:=length(le);
        setlength(le,k+1);
        le[k].id_champ:=id_champ;
        le[k].name:=s;
        le[k].id_event:=id_event;
end;

procedure insertstakelivetennis_class.parsehi(tr: ihtmlelement);
var
i:integer;
tds,atags:ihtmlelementcollection;
td,a:ihtmlelement;
 s,sqlstr:string;

begin
tds:=tr.all as ihtmlelementcollection;
tds:=tds.tags('TD')   as  ihtmlelementcollection;
td:=tds.item(0,0) as ihtmlelement;

s:=td.innerText;
i:=pos(br,s);
if i>0 then  delete(s,i,1000);

s:=trim(s);
if not isolimpdate(s) then  error:=5;
if error>0 then exit;
 odate:=transformdate(s);
 td:=tds.item(1,0) as ihtmlelement;

parseeventtd(td);

end;

procedure insertstakelivetennis_class.parseinnerb(s: string);
var
sqlstr,temps:string;
i,k:integer;
begin
  s:=trim(s);
  for I := 0 to length(lsg)-1 do
   begin
     if lsg[i].name=s then
      begin
        id_stakegroup:=lsg[i].id;
        exit;
      end;
   end;
    s:=stringreplace(s,'''','$$$',[rfreplaceall]);
 sqlstr:='findstakegroup N'''+s+''','+inttostr(id_sport)+';';
 id_stakegroup:=wwdb.oneinteger(sqlstr);
   k:=length(lsg);
        setlength(lsg,k+1);

        lsg[k].name:=s;
        lsg[k].id:=id_stakegroup;
end;

procedure insertstakelivetennis_class.parsemc(tr: ihtmlelement);
var
s,sqlstr:string;
i,k:integer;
inputs:ihtmlelementcollection;
begin
mcchecked:=false;

  if not submitbtnsettled then
    begin
      inputs:=tr.all as ihtmlelementcollection;
      inputs:=inputs.tags('INPUT')  as ihtmlelementcollection;
      submitbtn:=inputs.item(0,0)as ihtmlelement;

      submitbtnsettled:=true;
    end;

  s:=tr.innerText;
 i:=pos(br,s);
 if i>0 then
 s:=copy(s,1,i-1);
 s:=trim(s);
  i:=pos('Tennis.',s);
  if i<4 then error:=2;
  if error>0  then
  begin
    writeer;
    exit;
  end;
  s:=copy(s,i+7,1000);
  s:=trim(s);

  for I := 0 to length(lc)-1 do
   begin
     if lc[i].name=s then
       begin
       id_champ:=lc[i].id;
         mcchecked:=true;

         exit;

       end;

   end;


    sqlstr:='findchamp N'''+s+''',1;';
      id_champ:=wwdb.oneinteger(sqlstr);
  if id_champ>0 then
  begin
  mcchecked:=true;
    k:=length(lc);
        setlength(lc,k+1);
        lc[k].id:=id_champ;
        lc[k].name:=s;
  end;
end;

procedure insertstakelivetennis_class.parsenobr(nbr: ihtmlelement);
var
s,sqlstr,sttype,stval:string;
i,j:integer;
rg,rg1:tregex;
mch:tmatch;
gr:tgroup;
id_staketype:integer;
begin
  s:=nbr.innerHTML;
  setlength(sts,0);

  rg:=tregex.Create('(.*?)<(input|INPUT).*?>');
  rg1:=tregex.Create('<(b|B)>(.*?)</(b|B)>');
  while length(s)>0 do
    begin
  if rg.IsMatch(s) then
   begin
     mch:=rg.Match(s);
     gr:=mch.Groups[1];
     sttype:=gr.Value;
     sttype:=trim(sttype);

     i:=mch.Index;
     j:=mch.Length+i-1;
     delete(s,1,j);
   end
   else
   exit;
   if rg1.IsMatch(s) then
   begin
     mch:=rg1.Match(s);
     gr:=mch.Groups[2];
     stval:=gr.Value;
    stval:=trim(stval);

     i:=mch.Index;
     j:=mch.Length+i-1;
     delete(s,1,j);
   end
   else
   exit;
   i:=length(sts)+1;
   setlength(sts,i);
   i:=i-1;
   j:=pos('&nbsp;',sttype);
   if j>0 then
    delete(sttype,1,j+5);

   sts[i].sttype:=sttype;
   sts[i].stval:=stval
    end;

end;

procedure insertstakelivetennis_class.parsetr(tr: ihtmlelement);
var
 tbls,els:ihtmlelementcollection;
el:ihtmlelement;
i:integer;
s:string;
begin
       if not mcchecked then
      exit;
   els:=tr.all as ihtmlelementcollection;
   tbls:=els.tags('TABLE')    as ihtmlelementcollection;
   if tbls.length>0 then  exit;

   parseinnerb('main');
  for I := 0 to  els.length-1 do
   begin
     el:= els.item(i,0)as ihtmlelement;
     if ((el.tagName='B') and (el.parentElement.tagName<>'NOBR')) then
     begin
       s:=el.innerText;
       parseinnerb(s);
     end;
      if el.tagName='NOBR' then
       begin
     parsenobr(el);
     if length(sts)>0 then
      insertstake(el);
       end;

   end;


end;


end.
