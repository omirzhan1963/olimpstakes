unit login_module;

interface
 uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module;
   type
    login_class=class(olimpbase_class)
    logstr,passstr:string;
    checked:boolean;
    currusum:integer;
    error:integer;
     procedure login;
      procedure check;
      constructor create;
      private
      procedure checksw(tbl:ihtmlelement);

    end;
implementation

{ login_class }

procedure login_class.check;
var

tables:ihtmlelementcollection;
tbl:ihtmlelement;
i:integer;

begin
  wait(1000);
     doc:=wb.Document as ihtmldocument2;
     elcol:=doc.all;
     tables:=elcol.tags('TABLE') as ihtmlelementcollection;
     for I := 0 to tables.length-1 do
      begin
        tbl:=tables.item(i,0)as ihtmlelement;
        if tbl.className='smallwnd' then
        begin

         checksw(tbl);
         if checked then  break;

        end;
      end;
end;

procedure login_class.checksw(tbl: ihtmlelement);
var
 s:string;
spans,tds:ihtmlelementcollection;
td,spn:ihtmlelement;
i:integer;
chd:integer;
begin
checked:=false;
currusum:=-1;

 tds:=tbl.all as ihtmlelementcollection;
 tds:=tds.tags('TD')  as ihtmlelementcollection;
 for I := 0 to tds.length-1 do
   begin
     td:=tds.item(i,0) as ihtmlelement;
     if td.innerText=logstr then
      begin
        checked:=true;
        break;
      end;
   end;
   if checked then
   begin
     spans:=tbl.all as ihtmlelementcollection;
 spans:=spans.tags('SPAN')  as ihtmlelementcollection;

 for I := 0 to spans.length-1 do
   begin
     spn:=spans.item(i,0) as ihtmlelement;
     if spn.getAttribute('id',0)='currusum' then
      begin
     s:=spn.innerText;
     s:=trim(s);
     currusum:=strtoint(s);
        break;
      end;
   end;
   end;
end;

constructor login_class.create;
begin
logstr:='222800';
passstr:='noik52ABDR';
end;

procedure login_class.login;
var
at:attrs;
inputs:ihtmlelementcollection;
inp:ihtmlelement;
i:integer;
chd:integer;
begin
  doc:=wb.Document as ihtmldocument2;
  setlength(at,1);
  at[0].name:='id';
  at[0].value:='lf';
  findform(at);
  if not assigned(form) then
      exit;
  inputs:=form.all as ihtmlelementcollection;
   chd:=0;
  inputs:=inputs.tags('INPUT') as ihtmlelementcollection;
  for I := 0 to inputs.length-1 do
  begin
    inp:=inputs.item(i,0) as ihtmlelement;
    if inp.className='loginbox' then
      begin
        if inp.getAttribute('name',0)='login' then
        begin;
         inp.setAttribute('value',logstr,0);
         chd:=chd+1;
        end;
         if inp.getAttribute('name',0)='passw' then
         begin
         inp.setAttribute('value',passstr,0);
            chd:=chd+1;
         end;
      end;
      if ((inp.className='msbtn1') and (chd=2)) then
       inp.click;
  end;
  wait(2000);

end;

end.
