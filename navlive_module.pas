unit navlive_module;

interface
   uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module;
   type
   navlive_class=class(olimpbase_class)


   procedure nav;
      constructor create;
   private


   end;



implementation

{ navsport_class }

constructor navlive_class.create;
begin
    inherited;
 ermessages.Add('form not found in navlive_class');
end;

procedure navlive_class.nav;
var
at:attrs;
 trs,tds,inputs:ihtmlelementcollection;
 tr,td,inp:ihtmlelement;
 i,j,sportind:integer;
 s:string;
begin

doc:=wb.Document as ihtmldocument2;
  setlength(at,1);
  at[0].name:='id';
  at[0].value:='shline';
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
    tds:=tr.all   as ihtmlelementcollection;
   tds:=tds.tags('A')     as ihtmlelementcollection;
       if tds.length>0 then
         begin
         td:=tds.item(0,0) as ihtmlelement;
         s:=td.innerText;
         if pos('Live',s)>0 then td.click;
         end;





    end;

wait(2000);
end;



end.
