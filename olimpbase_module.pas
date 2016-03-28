unit olimpbase_module;

interface
 uses
  SysUtils, Variants, Classes, SHDocVw,mshtml, workwithdb_module, globalfunc;
  type
  olimpbase_class=class
  protected
  wwdb:workwithdb_class;
  wb:twebbrowser;
  wait:tprocedure;
  form:ihtmlelement;
  doc:ihtmldocument2;
  elcol:ihtmlelementcollection;
  procedure findform(at:attrs);
  public
  error:integer;
  procedure init(initcl:init_class);
  end;




implementation

{ olimpbase_class }

procedure olimpbase_class.findform(at: attrs);
var
forms:ihtmlelementcollection;
tform:ihtmlelement;
i:integer;
begin
if not assigned(doc) then  exit;
form:=nil;
elcol:=doc.all;
 forms:=elcol.tags('FORM') as ihtmlelementcollection;
 for I := 0 to forms.length-1 do
 begin
   tform:=forms.item(i,0) as ihtmlelement;
   if hasattrs(tform,at) then
   begin
     form:=tform;
     exit;
   end;
 end;
end;

procedure olimpbase_class.init(initcl: init_class);
begin
wb:=initcl.wb;
wait:=initcl.wait;
wwdb:=workwithdb_class.Create;

end;

end.
