﻿unit navchamp_module;

interface
 uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module;
   type
   navchamp_class=class(olimpbase_class)
   champari:ari;
   checkedchamp:ari;
   checkedsport:ari;
   tn:timeofnav;
   procedure nav;
   constructor create;
   private
   id_sport:integer;
   procedure submit;
   procedure checkmc(tr:ihtmlelement);
   procedure checktr(tr:ihtmlelement);
   procedure settimeofnav;
   procedure deletelinenumber;





   end;

implementation

{ navsport_class }

procedure navchamp_class.checkmc(tr: ihtmlelement);
var
sqlstr:string;
i,k:integer;
begin
 sqlstr:=tr.innerText;
 i:=pos('.',sqlstr);
 if i>0 then

 sqlstr:=copy(sqlstr,1,i-1);
 sqlstr:=trim(sqlstr);
 sqlstr:='findsport N'''+sqlstr+''';';
 id_sport:=wwdb.oneinteger(sqlstr);
    k:=length(checkedsport);
        setlength(checkedsport,k+1);
        checkedsport[k]:=id_sport;
end;

procedure navchamp_class.checktr(tr: ihtmlelement);
var

 tds,inputs:ihtmlelementcollection;
 td,inp:ihtmlelement;
 i,j,champind,k:integer;
 sqlstr:string;
begin
if id_sport=25 then exit;

tds:=tr.all as ihtmlelementcollection;
tds:=tds.tags('TD')  as ihtmlelementcollection;
if tds.length=2 then
      begin
      sqlstr:=tr.innerText;

       sqlstr:=trim(sqlstr);
       sqlstr:='findchamp N'''+sqlstr+''','+inttostr(id_sport)+';';
       champind:=wwdb.oneinteger(sqlstr);
       if inari(champind,champari) then
        begin
        inputs:=tr.all   as ihtmlelementcollection;
   inputs:=inputs.tags('INPUT')     as ihtmlelementcollection;
       inp:=inputs.item(0,0) as ihtmlelement  ;
       inp.setAttribute('checked',true,0);
        k:=length(checkedchamp);
        setlength(checkedchamp,k+1);
        checkedchamp[k]:=champind;

        end;
      end;
end;

constructor navchamp_class.create;
begin
inherited;
tn:=anytime;
ermessages.Add('not found form in navchamp_class');
end;

procedure navchamp_class.deletelinenumber;
var
inputs:ihtmlelementcollection;
inp:ihtmlelement;
i:integer;
begin
 inputs:=form.all as ihtmlelementcollection;
 inputs:=inputs.tags('INPUT')   as ihtmlelementcollection;
 for I := inputs.length-1 downto inputs.length-16 do
  begin
  inp:=inputs.item(i,0) as ihtmlelement;
    if ((inp.getAttribute('type',0)='checkbox') and (inp.getAttribute('name',0)='line_nums')) then
    begin
      inp.setAttribute('checked',false,0);
      exit;
    end;
  end;


end;

procedure navchamp_class.nav;
var
at:attrs;
 trs,tds,inputs:ihtmlelementcollection;
 tr,td,inp:ihtmlelement;
 i,j,champind:integer;
 sqlstr:string;
begin
 setlength(checkedchamp,0);
    setlength(checkedsport,0);
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
   trs:=form.all   as ihtmlelementcollection;
   trs:=trs.tags('TR')     as ihtmlelementcollection;
   for I := 0 to trs.length-1 do
    begin
    tr:=trs.item(i,0)   as ihtmlelement  ;
    if tr.className='m_c' then
    begin
      checkmc(tr);
      continue;
    end;


   checktr(tr);


    end;
  deletelinenumber;
  settimeofnav;
  if (length(checkedchamp)>0) then

 submit;
end;

procedure navchamp_class.settimeofnav;
 var
 options:ihtmlelementcollection;
opt:ihtmlelement;
i:integer;
begin
 if tn<>anytime then
  begin
    options:=form.all as ihtmlelementcollection;
  options:= options.tags('OPTION')    as ihtmlelementcollection;


   case tn of
    nexttwohour:
    begin
       opt:= options.item(1,0)  as ihtmlelement ;
   opt.setAttribute('selected',true,0);
     exit;
   end;
   nextsixhour:
       begin
       opt:= options.item(2,0)  as ihtmlelement ;
   opt.setAttribute('selected',true,0);
     exit;
   end;
      nexttvelwehour:
       begin
       opt:= options.item(3,0)  as ihtmlelement ;
   opt.setAttribute('selected',true,0);
     exit;
   end;
    nextday:
       begin
       opt:= options.item(4,0)  as ihtmlelement ;
   opt.setAttribute('selected',true,0);
     exit;
   end;



 end;
  end;
end;

procedure navchamp_class.submit;
var inputs:ihtmlelementcollection;
inp:ihtmlelement;
i:integer;
begin
 inputs:=form.all as ihtmlelementcollection;
 inputs:=inputs.tags('INPUT')    as ihtmlelementcollection;
 for i := inputs.length-1 downto 0 do
 begin
   inp:=inputs.item(i,0)  as ihtmlelement ;
   if ((inp.classname='msbtn1') and ( inp.getAttribute('type',0)='submit') and ((inp.getAttribute('value',0)='Next')or (inp.getAttribute('value',0)='Далее'))) then
   begin
     inp.click;
     exit;
   end;

 end;



end;
end.
