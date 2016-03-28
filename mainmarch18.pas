unit mainmarch18;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, login_module, globalfunc,
  navsport_module, navchamp_module, parseevent_module, insertstake_module,
  confirmstake_module, collectinfo_module, checkbet_module;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    WebBrowser2: TWebBrowser;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button7: TButton;
    Button8: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure WebBrowser1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);

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
 initcl1;
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
 initcl1;
 nc.init(incl);
setlength(nc.champari,2);
nc.champari[0]:=9;
nc.champari[1]:=10;
 nc.nav;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
ps:parseevent_class;
begin
ps:=parseevent_class.Create;
initcl1;
ps.init(incl);
ps.parse;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
insst:insertstake_class;
begin
insst:=insertstake_class.Create;
initcl1;
insst.init(incl);
setlength(insst.stakes,1);
insst.stakes[0].idevent:=1392;
insst.stakes[0].idstaketype:=341;
insst.stakes[0].stakevalue:=1.29;
insst.stakes[0].margin:=0.5;
insst.insert;


end;

procedure TForm1.Button6Click(Sender: TObject);
var
conf:confirmstake_class;
begin
 conf:=confirmstake_class.Create;
 initcl2;
 conf.init(incl);
 setlength(conf.stakes,3);
 conf.stakes[0].idevent:=456;
 conf.stakes[0].idstaketype:=345;
 conf.stakes[0].stakevalue:=1.89;
 conf.stakes[0].margin:=0.5;
 conf.stakes[1].idevent:=456;
 conf.stakes[1].idstaketype:=345;
 conf.stakes[1].stakevalue:=1.89;
 conf.stakes[1].margin:=0.5;
  conf.stakes[2].idevent:=456;
 conf.stakes[2].idstaketype:=345;
 conf.stakes[2].stakevalue:=1.89;
 conf.stakes[2].margin:=0.5;



 conf.sum:=200;
 conf.acceptchange:=true;
 conf.confirm;
 if conf.confirmed then form1.Color:=clblue
 else form1.Color:=clred;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
cio:collectinfo;

begin
   webbrowser1.Navigate('olimp.kz');
wait1(2000);
 cio:=collectinfo.create;
 initcl1;
 cio.incl:=incl;
 cio.ci;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
cb:checkbet_class;
 ind:integer;
 str:string;
 fbr:betrecord;
 i:integer;
begin
 cb:=checkbet_class.Create;
 initcl1;
 cb.init(incl);
 cb.betnumber:=22269;
fbr:=cb.getbetrec;
memo1.Lines.Add(fbr.settledtimestr);
 memo1.Lines.Add(inttostr(fbr.betnum));
 memo1.Lines.Add(inttostr(fbr.betsum));
 for I := length(fbr.bstakear)-1 downto 0 do
   begin
     memo1.Lines.Add('id_event='+inttostr(fbr.bstakear[i].id_event));
      memo1.Lines.Add('id_staketype='+inttostr(fbr.bstakear[i].id_staketype));
      memo1.Lines.Add('stval='+floattostr(fbr.bstakear[i].stval));
      if fbr.bstakear[i].settled then
      memo1.Lines.Add('settled') else
         memo1.Lines.Add('not settled');

   end;
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
