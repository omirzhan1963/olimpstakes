unit confirmstake_module;

interface
    uses
   SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc,
  olimpbase_module,RegularExpressions;
   type
   confirmstake_class=class(olimpbase_class)
   combobet:boolean;
   acceptchange:boolean;
   sum:integer;
   stakes:evstar;
   betsettled:boolean;
   submittbl,staketbl:ihtmlelement;
   sumsettled:boolean;
   procedure confirm;
   procedure check;
   private
   procedure acceptchangeset;
   procedure setsumcombo;
   procedure setsumsingle;
   procedure submit;
   procedure parsecoeftable;

   end;
implementation

{ confirmstake_class }

procedure confirmstake_class.acceptchangeset;
begin

end;

procedure confirmstake_class.check;
begin

end;

procedure confirmstake_class.confirm;
var
tables:ihtmlelementcollection;
tbl:ihtmlelement;
begin
 doc:=wb.Document as ihtmldocument2;
 elcol:=doc.all;
 tables:=elcol.tags('TABLE') as  ihtmlelementcollection;
 staketbl:=tables.item(0,0) as ihtmlelement;
 parsecoeftable;
 submittbl:=tables.item(1,0) as ihtmlelement;
acceptchangeset;
if length(stakes)=1 then
  setsumsingle;
  if length(stakes)>1 then
  setsumcombo;
 if sumsettled then
   submit;
end;

procedure confirmstake_class.parsecoeftable(tbl:ihtmlelement);
begin

end;

procedure confirmstake_class.setsumcombo;
begin

end;

procedure confirmstake_class.setsumsingle;
begin

end;

procedure confirmstake_class.submit;
begin

end;

end.
