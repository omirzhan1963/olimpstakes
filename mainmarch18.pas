unit mainmarch18;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, login_module, globalfunc,
  navsport_module, navchamp_module, parseevent_module, insertstake_module,
  confirmstake_module, collectinfo_module, checkbet_module, strategy1_module,
  parselivetennis_module, insertstakelivetennis_module, navlive_module,
  navlivechamp_module, checkliveevent_module, livetennisstrategy_module,
  strategybase_module, parseresult_module;

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
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
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
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);

  private
   incl:init_class;
   incl2:init_class;
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
procedure TForm1.Button10Click(Sender: TObject);
begin
webbrowser1.Navigate('olimp.kz');
end;

procedure TForm1.Button11Click(Sender: TObject);
var
lt:parselivetennis_class;
 i:integer;
begin
 lt:=parselivetennis_class.create;
 initcl1;
 lt.init(incl);
 lt.parse;
  for I := 0 to length(lt.lc)-1 do
  memo1.Lines.Add(lt.lc[i].name+'='+inttostr(lt.lc[i].id));
     for I := 0 to length(lt.le)-1 do
  memo1.Lines.Add(lt.le[i].name+'='+inttostr(lt.le[i].id_event));
end;

procedure TForm1.Button12Click(Sender: TObject);
var
insst:insertstakelivetennis_class;
begin
insst:=insertstakelivetennis_class.Create;
initcl1;
insst.init(incl);
setlength(insst.stakes,1);
insst.stakes[0].idevent:=strtoint(edit1.Text);
insst.stakes[0].idstaketype:=strtoint(edit2.Text);
insst.stakes[0].stakevalue:=strtofloat(edit3.Text);
insst.stakes[0].margin:=1.5;
insst.insert;


end;

procedure TForm1.Button13Click(Sender: TObject);
var
nl:navlive_class;
begin
 initcl1;
 nl:=navlive_class.create;
 nl.init(incl);
 nl.nav;
end;

procedure TForm1.Button14Click(Sender: TObject);
var
nl:navlivechamp_class;
i:integer;
le:liveeventar;
cle:checkliveevent_class;
sqlstr:string;
begin
 initcl1;
 nl:=navlivechamp_class.create;
 cle:=checkliveevent_class.create;
 cle.init(incl);
 nl.init(incl);
 nl.sport:='Tennis';
 nl.nav;
 for I := 0 to length(nl.foundedle)-1 do
 begin
 memo1.Lines.Add(nl.foundedle[i].name);
  cle.le[0].id_champ:=nl.foundedle[i].id_champ;
   cle.le[0].name:=nl.foundedle[i].name;
    cle.le[0].id_event:=nl.foundedle[i].id_event;
    cle.check;
    if ((cle.le[0].id_champ<>-1) and (cle.le[0].id_champ<>cle.checkedle[0].id_champ)) then
     begin
      sqlstr:='changechamp '+inttostr(cle.checkedle[0].id_champ)+','+inttostr(cle.le[0].id_champ)+';' ;
     cle.changechamp(cle.checkedle[0].id_champ,cle.le[0].id_champ);
     end;
 end;
 form1.Color:=clblue;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
strat2:tennislive_class;
i:integer;
begin
 strat2:=tennislive_class.create;
 initcl1;
 strat2.init(incl);
 initcl2;
 strat2.incl2:=incl;
 strat2.dostrategy;
 for I := 0 to length(strat2.temple)-1 do
  memo1.Lines.Add(inttostr(strat2.temple[i].id_champ)+'==='+strat2.temple[i].name+'==='+inttostr(strat2.temple[i].id_event));
  form1.color:=clblue;
  end;

procedure TForm1.Button16Click(Sender: TObject);
var
strat3:strategybase_class;
incl1,incl2:init_class;
begin
 strat3:=strategybase_class.create;
 strat3.strategynumber:=2;
  incl1:=init_class.Create;
 incl1.wb:=webbrowser1;
 incl1.wait:=wait1;
  incl2:=init_class.Create;
 incl2.wb:=webbrowser2;
 incl2.wait:=wait2;
 strat3.incl1:=incl1;
 strat3.incl2:=incl2;
 strat3.init(incl1,incl2);
 strat3.preparestrategy;
 strat3.dostrategy;

end;

procedure TForm1.Button17Click(Sender: TObject);
var
pr:parseresult_class;
s:string;
begin
  pr:=parseresult_class.create;
  initcl1;
  pr.init(incl);
  pr.navresultpage;
 { pr.findspch(2929);
  s:=datetimetostr(pr.evdate);
  edit1.Text:=s;
  s:=inttostr(pr.id_sport);
  edit2.Text:=s;  }
  pr.parseresult(2929);
  memo1.Text:=pr.test;
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

procedure TForm1.Button9Click(Sender: TObject);
var
strat1:strategy1;

begin
initcl1;
initcl2;
strat1:=strategy1.Create;
 strat1.incl:=incl;
 strat1.incl2:=incl2;
 strat1.strategy:=1;
 strat1.dostrategy1;
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
    if not assigned(incl2) then  incl2:=init_class.Create;
 incl2.wb:=webbrowser2;
 incl2.wait:=wait2;
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
