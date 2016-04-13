unit navsport_module;

interface
  uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module;
   type
   navsport_class=class(olimpbase_class)
   sportari:ari;
      constructor create;
   procedure nav;
   private
   procedure submit;







   end;

implementation

{ navsport_class }

constructor navsport_class.create;
begin
inherited;
 ermessages.Add('form not found in navsport_class');
end;

procedure navsport_class.nav;
var
at:attrs;
 trs,tds,inputs:ihtmlelementcollection;
 tr,td,inp:ihtmlelement;
 i,j,sportind:integer;
 sqlstr:string;
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
   tds:=tds.tags('TD')     as ihtmlelementcollection;
   if tds.length=2 then
      begin
       sqlstr:=tr.innerText;
       j:=pos('(',sqlstr);
       if j>1 then sqlstr:=copy(sqlstr,1,j-1);
       sqlstr:=trim(sqlstr);
       sqlstr:='findsport N'''+sqlstr+''';';
       sportind:=wwdb.oneinteger(sqlstr);
       if inari(sportind,sportari) then
        begin
        inputs:=tr.all   as ihtmlelementcollection;
   inputs:=inputs.tags('INPUT')     as ihtmlelementcollection;
       inp:=inputs.item(0,0) as ihtmlelement  ;
       inp.setAttribute('checked',true,0);


        end;
      end;



    end;

 submit;
end;

procedure navsport_class.submit;
var inputs:ihtmlelementcollection;
inp:ihtmlelement;
i:integer;
begin
 inputs:=form.all as ihtmlelementcollection;
 inputs:=inputs.tags('INPUT')    as ihtmlelementcollection;
 for i := inputs.length-1 downto 0 do
 begin
   inp:=inputs.item(i,0)  as ihtmlelement ;
   if ((inp.classname='msbtn1') and ( inp.getAttribute('type',0)='submit')) then
   begin
     inp.click;
     exit;
   end;

 end;



end;

end.
