object frmMaterial: TfrmMaterial
  Left = 0
  Top = 0
  Caption = 'Material'
  ClientHeight = 197
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 59
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 8
    Top = 86
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object edt_nome: TEdit
    Left = 64
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edt_preco: TEdit
    Left = 64
    Top = 83
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 213
    Height = 41
    Align = alTop
    Color = 10340852
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object edt_codigo: TEdit
      Left = 64
      Top = 8
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '0'
    end
  end
  object btn_salvar: TBitBtn
    Left = 110
    Top = 110
    Width = 75
    Height = 25
    Hint = 'Salvar'
    Glyph.Data = {
      26040000424D2604000000000000360000002800000012000000120000000100
      180000000000F0030000C40E0000C40E00000000000000000000B8B9B6B8B9B6
      B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
      B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
      B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
      B9B6B8B9B6B8B9B60000B8B9B6B8B9B6ABADAA64656361626161626161626161
      6261616261616261616261616261616261616261646563ABADAAB8B9B6B8B9B6
      0000B8B9B6B8B9B66E6F6E0000000000000000000000000000003F3F3E40413F
      0000000000000000000000000000006E6F6EB8B9B6B8B9B60000B8B9B6B8B9B6
      616261000000000000000000000000848583B7B9B6B7B9B68485830000000000
      00000000000000616261B8B9B6B8B9B60000B8B9B6B8B9B66162610000000000
      00000000454645B8B9B6B8B9B6B8B9B6B8B9B645464500000000000000000061
      6261B8B9B6B8B9B60000B8B9B6B8B9B66162610000000000000000004E4F4EB8
      B9B6B8B9B6B8B9B6B8B9B64F504F000000000000000000616261B8B9B6B8B9B6
      0000B8B9B6B8B9B6616261000000000000000000000000898A88B8B9B6B7B9B6
      898A88000000000000000000000000616261B8B9B6B8B9B60000B8B9B6B8B9B6
      6162610000000000000000000000000000004243424243420000000000000000
      00000000000000616261B8B9B6B8B9B60000B8B9B6B8B9B66162610000000000
      0000000000000000000000000000000000000000000000000000000000000061
      6261B8B9B6B8B9B60000B8B9B6B8B9B661626100000000000000000000000000
      0000000000000000000000000000000000000000000000616261B8B9B6B8B9B6
      0000B8B9B6B8B9B6616261555655A1A3A0A1A3A0A1A3A0A1A3A0A1A3A0A1A3A0
      A1A3A0555655000000000000000000616261B8B9B6B8B9B60000B8B9B6B8B9B6
      616261616261B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B66162610000
      00000000000000676866B8B9B6B8B9B60000B8B9B6B8B9B6616261616261B8B9
      B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6616261000000000000454645AF
      B0ADB8B9B6B8B9B60000B8B9B6B8B9B66E6F6D33333261626161626161626161
      6261616261616261616261333332000000454645AFB0ADB8B9B6B8B9B6B8B9B6
      0000B8B9B6B8B9B6ABADAA646563616261616261616261616261616261616261
      616261616261676866AFB0ADB8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
      B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
      B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
      B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
      B9B6B8B9B6B8B9B60000}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btn_salvarClick
  end
end
