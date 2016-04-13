unit confirmstake_module;

interface
    uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module,RegularExpressions;
   type
   confirmstake_class=class(olimpbase_class)

   acceptchange:boolean;
   sum:integer;
   stakes:evstar;
   confirmed:boolean;
    constructor create;
   procedure confirm;
   procedure check;
   private
sumstr:string;
     aftertbl:integer;
          combobet:boolean;
      betsettled:boolean;
   submittbl,staketbl:ihtmlelement;
   sumsettled:boolean;


   procedure submit;
   procedure parsecoeftable;

   end;
implementation

{ confirmstake_class }



procedure confirmstake_class.check;
var
b:ihtmlelement;
str:string;

begin
confirmed:=false;
  doc:=wb.Document as ihtmldocument2;
  b:=doc.body;
   str:=b.innerText;
   if pos('Your bet is successfully accepted!',str)>0 then
    confirmed:=true;
end;

procedure confirmstake_class.confirm;
var
tables,tblel:ihtmlelementcollection;
tbl,el:ihtmlelement;
i:integer;
teststr:string;
begin
 if length(stakes)=0 then  error:=1;
 if error>0 then
 begin
 writeer;
 exit;
 end;

  if length(stakes)=1 then
  combobet:=false
  else
  combobet:=true;
 doc:=wb.Document as ihtmldocument2;
 elcol:=doc.all;
 sumstr:=inttostr(sum);
 sumsettled:=false;

 tables:=elcol.tags('TABLE') as  ihtmlelementcollection;
 staketbl:=tables.item(1,0) as ihtmlelement;
     aftertbl:=staketbl.sourceIndex;
    tblel:=staketbl.all as  ihtmlelementcollection;
    aftertbl:=aftertbl+tblel.length;
 parsecoeftable;
  for I := aftertbl to elcol.length-1 do
   begin
     el:=elcol.item(i,0) as ihtmlelement;
     if el.tagName='INPUT' then
     begin
     teststr:=el.outerHTML;
       if (combobet and(el.getAttribute('type',0)='radio') and (el.getAttribute('id',0)='re')) then

        el.setAttribute('checked',true,0);


        if (acceptchange and (el.getAttribute('type',0)='checkbox')) then
          el.setAttribute('checked',true,0);
          if (combobet and (el.getAttribute('type',0)='text')) then
          begin
          el.setAttribute('value',sumstr,0);
          sumsettled:=true;
          end;

     end;
   end;
 if sumsettled then submit;

  wait(2000);
  check;
end;

constructor confirmstake_class.create;
begin
inherited;
ermessages.Add('stakes not settled in confirmstake_class') ;
end;

procedure confirmstake_class.parsecoeftable;
var
inputs:ihtmlelementcollection;
inp:ihtmlelement;
i,j:integer;
begin

  if not combobet then
   begin
   inputs:=staketbl.all as     ihtmlelementcollection;
      inputs:=inputs.tags('INPUT') as   ihtmlelementcollection;
   for I := inputs.length-1 downto 1 do
   begin
    inp:=inputs.item(i,0) as   ihtmlelement  ;
    if inp.className='loginbox_big' then
    begin
     inp.setAttribute('value',sumstr,0);
          sumsettled:=true;
      exit;
    end;
   end;




   end;
end;


procedure confirmstake_class.submit;
var
inputs:ihtmlelementcollection;
inp:ihtmlelement;
i,j:integer;
begin
   inputs:=elcol.tags('INPUT') as   ihtmlelementcollection;
   for I := inputs.length-1 downto 1 do
   begin
    inp:=inputs.item(i,0) as   ihtmlelement  ;
    if ((inp.className='msbtn1') and (inp.getAttribute('value',0)='Place a bet')) then
    begin
      inp.click;
      exit;
    end;
   end;
end;

end.
