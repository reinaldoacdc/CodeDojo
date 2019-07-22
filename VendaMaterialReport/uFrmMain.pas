unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Data.Win.ADODB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Materiais1: TMenuItem;
    Materiais2: TMenuItem;
    Vendas1: TMenuItem;
    Image1: TImage;
    procedure Materiais2Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses ApplicationHelper, uFrmPesquisaMaterial, uFrmPesquisaVenda, uRelOrcamento;

{$R *.dfm}


procedure TfrmMain.Materiais2Click(Sender: TObject);
begin
  Application.OpenForm(frmPesquisaMaterial, TfrmPesquisaMaterial);
end;

procedure TfrmMain.Vendas1Click(Sender: TObject);
begin
  Application.OpenForm(frmPesquisaVenda, TfrmPesquisaVenda);
end;

end.
