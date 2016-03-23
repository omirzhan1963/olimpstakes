unit mainmarch18;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, login_module, globalfunc,
  navsport_module, navchamp_module, parseevent_module;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    WebBrowser2: TWebBrowser;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure WebBrowser1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
   incl:init_class;
   procedure initcl1;
       procedure initcl2;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
 procedure wait1(ms:integer) ;
 begin
  form1.Timer1.Interval:=ms;
 form1.Timer1.Enabled:=true;
 while form1.Timer1.Enabled do  application.ProcessMessages;
 if form1.WebBrowser1.ReadyState<>4 then
   begin
      form1.Timer1.Interval:=2000;
 form1.Timer1.Enabled:=true;
 while form1.Timer1.Enabled do  application.ProcessMessages;
   end;
 end;
 procedure wait2(ms:integer);
   begin
  form1.Timer1.Interval:=ms;
 form1.Timer1.Enabled:=true;
 while form1.Timer1.Enabled do  application.ProcessMessages;
 if form1.WebBrowser2.ReadyState<>4 then
   begin
      form1.Timer1.Interval:=2000;
 form1.Timer1.Enabled:=true;
 while form1.Timer1.Enabled do  application.ProcessMessages;
   end;
 end;
procedure TForm1.Button1Click(Sender: TObject);
var
l:login_class;

begin
webbrowser1.Navigate('olimp.kz');
wait1(2000);

initcl1;
l:=login_class.create;
l.init(incl);
l.logstr:='222800';
l.passstr:='noik52ABDR';
l.login;


end;






procedure TForm1.Button2Click(Sender: TObject);
var
ns:navsport_class;
begin
 ns:=navsport_class.Create;
 ns.init(incl);
 setlength(ns.sportari,2);
 ns.sportari[0]:=1;
 ns.sportari[1]:=23;
 ns.nav;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
nc:navchamp_class;
begin
 nc:=navchamp_class.Create;
 nc.init(incl);
{ setlength(nc.champari,2);
nc.champari[0]:=2;
nc.champari[1]:=3;  }
 nc.nav;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
ps:parseevent_class;
begin
ps:=parseevent_class.Create;
ps.init(incl);
ps.parse;
end;

procedure TForm1.initcl1;
begin
    if not assigned(incl) then
    incl:=init_class.Create;
 incl.wb:=webbrowser1;
 incl.wait:=wait1;
end;

procedure TForm1.initcl2;
begin
    if not assigned(incl) then  incl:=init_class.Create;
 incl.wb:=webbrowser2;
 incl.wait:=wait2;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
timer1.Enabled:=false;
end;

procedure TForm1.WebBrowser1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
  var Cancel: WordBool);
begin
    cancel:=false;
ppdisp:=webbrowser2.DefaultDispatch;
end;

end.