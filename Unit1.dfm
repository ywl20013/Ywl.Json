object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Consolas'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    635
    299)
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 240
    Top = 29
    Width = 42
    Height = 14
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 128
    Top = 77
    Width = 42
    Height = 14
    Caption = 'Label1'
  end
  object btn1: TButton
    Left = 159
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Insert Data'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btnParser: TButton
    Left = 32
    Top = 72
    Width = 75
    Height = 25
    Caption = 'btnParser'
    TabOrder = 1
    OnClick = btnParserClick
  end
  object edtCount: TEdit
    Left = 32
    Top = 26
    Width = 121
    Height = 22
    TabOrder = 2
    Text = '1000'
  end
  object Memo1: TMemo
    Left = 32
    Top = 120
    Width = 577
    Height = 161
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button1: TButton
    Left = 295
    Top = 24
    Width = 75
    Height = 25
    Caption = 'ToJsonString'
    TabOrder = 4
    OnClick = Button1Click
  end
end
