object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 491
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object Materiais1: TMenuItem
      Caption = 'Pesquisa'
      object Materiais2: TMenuItem
        Caption = 'Materiais'
        OnClick = Materiais2Click
      end
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas1Click
      end
    end
  end
end
