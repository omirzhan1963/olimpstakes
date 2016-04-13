﻿unit navlivechamp_module;

interface
 uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module;
   type
   navlivechamp_class=class(olimpbase_class)
  sport:string;
  le:liveeventar;
  foundedle:liveeventar;

   procedure nav;
   constructor create;
   private
    eventchecked:boolean;
    foundsport:boolean;
   procedure submit;
    function checkeventstr(s:string):boolean;
   procedure deletelinenumber;





   end;

implementation

{ navlivechamp_class }

function navlivechamp_class.checkeventstr(s: string): boolean;
var
i,k:integer;
begin
result:=false;
k:=length(foundedle);
  i:=pos(br,s);
  if i>0 then delete(s,i,100);
  s:=trim(s);
  for I := 0 to length(le)-1 do
     if le[i].name=s then
     begin
       setlength(foundedle,k+1);
       foundedle[k].id_champ:=le[i].id_champ;
       foundedle[k].name:=s;
       foundedle[k].id_event:=le[i].id_event;
       result:=true;
       exit;
     end;
       setlength(foundedle,k+1);
       foundedle[k].id_champ:=-1;
       foundedle[k].name:=s;
       foundedle[k].id_event:=-1;
end;

constructor navlivechamp_class.create;
begin
  inherited;
sport:='Tennis';

ermessages.Add('not found form in navlivechamp_class');
end;

procedure navlivechamp_class.deletelinenumber;
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

procedure navlivechamp_class.nav;
var
at:attrs;
 trs,tds,inputs:ihtmlelementcollection;
 tr,td0,td1,inp:ihtmlelement;
 i,j,champind:integer;
 sportchecked:boolean;
 trstr,eventstr:string;
begin
 setlength(foundedle,0);
 eventchecked:=false;
 foundsport:=false;
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
    trstr:=tr.innerText;
     if not foundsport then
     begin
       if trstr<>sport then continue;
       if trstr=sport then
       begin
         foundsport:=true;
         continue;

       end;
     end;
       tds:=tr.all as ihtmlelementcollection;
       tds:=tds.tags('TD')  as ihtmlelementcollection;
       if tds.length<>2 then  break;
      td1:=tds.item(1,0) as ihtmlelement;
      eventstr:=td1.innerText;
      if checkeventstr(eventstr) then
        begin
          td0:=tds.item(0,0) as ihtmlelement;
          inputs:=td0.all as ihtmlelementcollection;
          inputs:=inputs.tags('INPUT') as ihtmlelementcollection;
          if inputs.length<>1 then  error:=2;
          if error>0 then
   begin
   writeer;
      exit;
   end;
   inp:=inputs.item(0,0) as ihtmlelement;
   inp.setAttribute('checked',true,0);
   eventchecked:=true;
        end;
    end;

    if eventchecked then
   begin
  deletelinenumber;



 submit;
   end;

end;

procedure navlivechamp_class.submit;
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
