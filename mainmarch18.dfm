object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 561
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 496
    Top = 8
    Width = 480
    Height = 529
    TabOrder = 0
    OnNewWindow2 = WebBrowser1NewWindow2
    ControlData = {
      4C0000009C310000AC3600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object WebBrowser2: TWebBrowser
    Left = 8
    Top = 24
    Width = 313
    Height = 281
    TabOrder = 1
    ControlData = {
      4C000000592000000B1D00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 22
    Top = 315
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 103
    Top = 311
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 103
    Top = 342
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 103
    Top = 373
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 103
    Top = 435
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 103
    Top = 466
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Memo1: TMemo
    Left = 176
    Top = 24
    Width = 337
    Height = 281
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object Memo2: TMemo
    Left = 184
    Top = 344
    Width = 329
    Height = 209
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssBoth
    TabOrder = 9
  end
  object Button7: TButton
    Left = 103
    Top = 497
    Width = 75
    Height = 25
    Caption = 'Button7'
    TabOrder = 10
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 103
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Button8'
    TabOrder = 11
    OnClick = Button8Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 180
    Width = 121
    Height = 21
    TabOrder = 12
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 16
    Top = 208
    Width = 121
    Height = 21
    TabOrder = 13
    Text = 'Edit2'
  end
  object Button9: TButton
    Left = 8
    Top = 466
    Width = 81
    Height = 25
    Caption = 'Button9'
    TabOrder = 14
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 103
    Top = 404
    Width = 75
    Height = 25
    Caption = 'Button10'
    TabOrder = 15
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 8
    Top = 497
    Width = 75
    Height = 25
    Caption = 'livetennisparse'
    TabOrder = 16
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 8
    Top = 528
    Width = 75
    Height = 25
    Caption = 'insertlivetennisstake'
    TabOrder = 17
    OnClick = Button12Click
  end
  object Edit3: TEdit
    Left = 16
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 18
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 16
    Top = 288
    Width = 121
    Height = 21
    TabOrder = 19
    Text = 'Edit4'
  end
  object Button13: TButton
    Left = 22
    Top = 342
    Width = 75
    Height = 25
    Caption = 'navlive'
    TabOrder = 20
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 22
    Top = 373
    Width = 75
    Height = 25
    Caption = 'navlivechamp'
    TabOrder = 21
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 22
    Top = 399
    Width = 75
    Height = 25
    Caption = 'strategy2'
    TabOrder = 22
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 22
    Top = 430
    Width = 75
    Height = 25
    Caption = 'strategy3'
    TabOrder = 23
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 272
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Button17'
    TabOrder = 24
    OnClick = Button17Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 24
    Top = 184
  end
end
