unit navchamp_module;

interface
 uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module;
   type
   navchamp_class=class(olimpbase_class)
   champari:ari;

   procedure nav;
   private
   id_sport:integer;
   procedure submit;
   procedure checkmc(tr:ihtmlelement);
   procedure checktr(tr:ihtmlelement);






   end;

implementation

{ navsport_class }

procedure navchamp_class.checkmc(tr: ihtmlelement);
var
sqlstr:string;
i:integer;
begin
 sqlstr:=tr.innerText;
 i:=pos('.',sqlstr);
 if i>0 then

 sqlstr:=copy(sqlstr,1,i-1);
 sqlstr:=trim(sqlstr);
 sqlstr:='findsport N'''+sqlstr+''';';
 id_sport:=wwdb.oneinteger(sqlstr);

end;

procedure navchamp_class.checktr(tr: ihtmlelement);
var

 tds,inputs:ihtmlelementcollection;
 td,inp:ihtmlelement;
 i,j,champind:integer;
 sqlstr:string;
begin
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

doc:=wb.Document as ihtmldocument2;
  setlength(at,1);
  at[0].name:='name';
  at[0].value:='BetLine';
  findform(at);
  if not assigned(form) then exit;
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

 submit;
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
