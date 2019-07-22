unit Unit2;

interface

uses
  uDmMain,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Data.Win.ADODB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    Materiais1: TMenuItem;
    Materiais2: TMenuItem;
    Vendas1: TMenuItem;
    procedure Materiais2Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses uFrmPesquisaMaterial, uFrmPesquisaVenda;

{$R *.dfm}


procedure TForm2.Materiais2Click(Sender: TObject);
var  frm :TfrmPesquisaMaterial;
begin
  //
  frm := TfrmPesquisaMaterial.Create(self);
  frm.Show;
end;

procedure TForm2.Vendas1Click(Sender: TObject);
var frm :TfrmPesquisaVenda;
begin
  frm := TfrmPesquisaVenda.Create(self);
  frm.Show;
end;

end.
