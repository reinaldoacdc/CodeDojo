unit uFrmPesquisaMaterial;

interface

uses
  uMaterial,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Datasnap.DBClient, Datasnap.Provider,
  Vcl.DBCtrls, Vcl.Buttons;

type
  TfrmPesquisaMaterial = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    rad_filtro: TRadioGroup;
    edt_pesquisa: TEdit;
    Panel2: TPanel;
    btn_buscar: TBitBtn;
    btn_novo: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure btn_buscarClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
  private
    procedure CarregaConsulta;
    procedure CarregaGrid(materiais :TMateriais);
    procedure CarregaForm(material :TMaterial);
  public
    { Public declarations }
  end;

var
  frmPesquisaMaterial: TfrmPesquisaMaterial;

implementation
uses StringGridHelper, uDaoMaterial, uFrmMaterial;
{$R *.dfm}

procedure TfrmPesquisaMaterial.btn_buscarClick(Sender: TObject);
begin
  CarregaConsulta;
end;

procedure TfrmPesquisaMaterial.btn_deleteClick(Sender: TObject);
var dao :TDaoMaterial;
begin
  dao := TDaoMaterial.Create;
  try
    dao.Excluir(StrToInt(StringGrid1.Cells[0, StringGrid1.row]));
  finally
    dao.Free;
  end;
  CarregaConsulta;
end;

procedure TfrmPesquisaMaterial.btn_editClick(Sender: TObject);
var
  frm :TfrmMaterial;
  mat :TMaterial;
begin
  mat := TMaterial.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                                            StringGrid1.Cells[1, StringGrid1.Row],
                                            StrToFloat(StringGrid1.Cells[2, StringGrid1.Row]));
  CarregaForm(mat);
end;

procedure TfrmPesquisaMaterial.btn_novoClick(Sender: TObject);
begin
  CarregaForm(nil);
end;

procedure TfrmPesquisaMaterial.CarregaConsulta;
var
  dao :TDaoMaterial;
  materiais :TMateriais;
begin
  StringGrid1.Clear;

  dao := TDaoMaterial.Create;
  try
    materiais := dao.buscaMaterial(rad_filtro.ItemIndex, edt_pesquisa.Text);
    CarregaGrid(materiais);

  finally
    dao.Free;
    materiais := nil;
  end;
end;

procedure TfrmPesquisaMaterial.CarregaForm(material: TMaterial);
var
  frm :TfrmMaterial;
begin
  frmMaterial := TfrmMaterial.Create(nil);
  frmMaterial.material := material;
  frmMaterial.ShowModal;

  edt_pesquisa.Clear;
  CarregaConsulta;
end;

procedure TfrmPesquisaMaterial.CarregaGrid(materiais :TMateriais);
var
  i :Integer;
begin
  StringGrid1.RowCount := Length(materiais)+1;
  for i := 0 to Length(materiais)-1 do
  begin
    StringGrid1.Cells[0, i+1] := IntToStr(materiais[i].codigo);
    StringGrid1.Cells[1, i+1] := materiais[i].nome;
    StringGrid1.Cells[2, i+1] := FloatToStr(materiais[i].preco);
  end;

end;

procedure TfrmPesquisaMaterial.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
    frmPesquisaMaterial := nil;
    Action    := caFree;
end;

procedure TfrmPesquisaMaterial.FormCreate(Sender: TObject);
begin
  //Cabeçalho
  StringGrid1.Cells[0, 0] := 'Codigo';
  StringGrid1.Cells[1, 0] := 'Nome';
  StringGrid1.Cells[2, 0] := 'Preço';
end;

procedure TfrmPesquisaMaterial.StringGrid1DblClick(Sender: TObject);
var
  frm :TfrmMaterial;
  mat :TMaterial;
begin
  mat := TMaterial.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                                            StringGrid1.Cells[1, StringGrid1.Row],
                                            StrToFloat(StringGrid1.Cells[2, StringGrid1.Row]));
  CarregaForm(mat);
end;

end.
