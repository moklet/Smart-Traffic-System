object Form1: TForm1
  Left = 192
  Top = 124
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 200
    Top = 40
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 472
    Top = 24
    Width = 185
    Height = 89
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 136
    Width = 305
    Height = 225
    Caption = 'Dasar'
    TabOrder = 2
    object Shape1: TShape
      Left = 16
      Top = 24
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape2: TShape
      Left = 72
      Top = 24
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape3: TShape
      Left = 128
      Top = 24
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape4: TShape
      Left = 184
      Top = 24
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape5: TShape
      Left = 240
      Top = 24
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape6: TShape
      Left = 16
      Top = 120
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape8: TShape
      Left = 128
      Top = 120
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape9: TShape
      Left = 184
      Top = 120
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape10: TShape
      Left = 240
      Top = 120
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
    object Shape7: TShape
      Left = 72
      Top = 120
      Width = 49
      Height = 89
      Brush.Color = clLime
    end
  end
  object DBGrid1: TDBGrid
    Left = 416
    Top = 152
    Width = 320
    Height = 120
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 192
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open DB'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ComPort1: TComPort
    BaudRate = br9600
    Port = 'COM5'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    OnRxChar = ComPort1RxChar
    Left = 104
    Top = 48
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 344
    Top = 40
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 384
    Top = 40
  end
  object MyConnection1: TMyConnection
    Database = 'edoferi1_sts'
    Username = 'edoferi1_demo'
    Password = 'q1w2e3r4t5'
    Server = 'edoferiyus.com'
    Left = 56
    Top = 24
  end
  object MyQuery1: TMyQuery
    Connection = MyConnection1
    Left = 96
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = MyQuery1
    Left = 128
    Top = 24
  end
end
