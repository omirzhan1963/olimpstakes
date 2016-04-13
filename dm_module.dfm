object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 341
  Width = 411
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=sport;Data Source=OLEG-PC\SQLEXPRESS'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 72
    Top = 40
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 64
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 208
    Top = 104
  end
end
