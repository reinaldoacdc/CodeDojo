object frmVendaMaterial: TfrmVendaMaterial
  Left = 0
  Top = 0
  ClientHeight = 533
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 115
    Width = 81
    Height = 13
    Caption = 'C'#243'digo da Venda'
  end
  object Label2: TLabel
    Left = 16
    Top = 167
    Width = 38
    Height = 13
    Caption = 'Material'
  end
  object Label3: TLabel
    Left = 16
    Top = 194
    Width = 64
    Height = 13
    Caption = 'Valor Unit'#225'rio'
  end
  object Label4: TLabel
    Left = 16
    Top = 221
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label5: TLabel
    Left = 16
    Top = 140
    Width = 89
    Height = 13
    Caption = 'C'#243'digo do Material'
  end
  object edt_codvenda: TEdit
    Left = 120
    Top = 112
    Width = 121
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = '0'
  end
  object edt_nome: TEdit
    Left = 120
    Top = 164
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edt_preco: TEdit
    Left = 120
    Top = 191
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edt_qtdade: TEdit
    Left = 120
    Top = 218
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object edt_codmaterial: TEdit
    Left = 120
    Top = 137
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 4
    Text = '0'
  end
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 341
    Width = 484
    Height = 189
    Align = alBottom
    ColCount = 3
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 5
    OnSelectCell = StringGrid1SelectCell
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 73
    Align = alTop
    Color = 10340852
    ParentBackground = False
    TabOrder = 6
    object rad_filtro: TRadioGroup
      Left = 16
      Top = 5
      Width = 145
      Height = 33
      Caption = 'Filtro'
      Columns = 2
      Items.Strings = (
        'C'#243'digo   '
        ' Nome')
      TabOrder = 0
      WordWrap = True
    end
    object edt_pesquisa: TEdit
      Left = 16
      Top = 44
      Width = 145
      Height = 25
      AutoSize = False
      TabOrder = 1
    end
    object btn_buscar: TBitBtn
      Left = 167
      Top = 44
      Width = 26
      Height = 25
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F0030000C40E0000C40E00000000000000000000B8B9B6B8B9B6
        B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
        B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
        B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B2B3B0B8B9B6B8B9B6B8B9B6
        0000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
        B8B9B6B8B9B6B8B9B67C7D7B3F3F3EAEB0ADB8B9B6B8B9B60000B8B9B6B8B9B6
        B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B7B9B67576
        74000000767776B7B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B6B8B56A6B69000000767776B7B9B6B8
        B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B69C9E9B5758560000002E
        2E2D5A5B599E9F9D8A8B89000000767776B7B9B6B8B9B6B8B9B6B8B9B6B8B9B6
        0000B8B9B6B8B9B6B8B9B68688850000003F3F3E7677767D7E7C575856000000
        4344438E8F8DB7B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
        A6A7A50000005F605EB2B4B1B8B9B6B8B9B6B8B9B6919390000000A2A3A1B8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B67C7D7B141414AFB1
        AEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6555655656665B8B9B6B8B9B6B8B9B6B8
        B9B6B8B9B6B8B9B60000B8B9B6B8B9B6666765535453B8B9B6B8B9B6B8B9B6B8
        B9B6B8B9B6B8B9B67D7E7C313231B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
        0000B8B9B6B8B9B66E6F6E333332B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
        747573373837B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
        8E8F8D0000009C9D9AB8B9B6B8B9B6B8B9B6B8B9B6B3B5B23F3F3E6C6D6CB8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B5B6B34A4B4A3F3F
        3E939592B4B6B3B8B9B6B0B1AE5F605E242424A9AAA7B8B9B6B8B9B6B8B9B6B8
        B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6AAACA93636350000002F302F53
        53521C1C1C3F3F3E9FA19EB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
        0000B8B9B6B8B9B6B8B9B6B8B9B6B4B5B2929491636462717270919290B3B5B2
        B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
        B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
        B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
        B9B6B8B9B6B8B9B60000}
      TabOrder = 2
      OnClick = btn_buscarClick
    end
  end
  object btn_grava: TBitBtn
    Left = 166
    Top = 245
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
    TabOrder = 7
    OnClick = btn_gravaClick
  end
end
