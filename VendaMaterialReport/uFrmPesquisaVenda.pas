unit uFrmPesquisaVenda;

interface

uses
  uVenda, uVendaMaterial,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB,
  Datasnap.Provider, Datasnap.DBClient, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmPesquisaVenda = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Panel1: TPanel;
    rad_filtro: TRadioGroup;
    Label1: TLabel;
    Panel3: TPanel;
    btn_novo: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    btn_print: TBitBtn;
    edt_pesquisa: TEdit;
    btn_buscar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_buscarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private


    procedure CarregaForm(venda :TVenda);
    procedure CarregaGrid(vendas :TVendas);
    procedure CarregaGridItens(itens :TVendaMateriais);
  public
    procedure CarregaConsulta;
  end;

var
  frmPesquisaVenda: TfrmPesquisaVenda;

implementation
uses StringGridHelper, uDaoVenda, uFrmVenda, uRelOrcamento;
{$R *.dfm}

procedure TfrmPesquisaVenda.btn_buscarClick(Sender: TObject);
begin
  carregaConsulta;
end;

procedure TfrmPesquisaVenda.btn_deleteClick(Sender: TObject);
var dao :TDaoVenda;
begin
  dao := TDaoVenda.Create;
  try
    dao.ExcluirDetalhe(StrToInt(StringGrid1.Cells[0, StringGrid1.Row]));
    dao.Excluir(StrToInt(StringGrid1.Cells[0, StringGrid1.Row]));
  finally
    dao.Free;
  end;
  CarregaConsulta;
end;


procedure TfrmPesquisaVenda.btn_editClick(Sender: TObject);
var
  nova_venda :TVenda;
begin
  nova_venda := TVenda.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                               StrToDate(StringGrid1.Cells[1, StringGrid1.Row]),
                               StringGrid1.Cells[2, StringGrid1.Row],
                               StrToFloat(StringGrid1.Cells[3, StringGrid1.Row]));
  CarregaForm(nova_venda);
end;


procedure TfrmPesquisaVenda.btn_novoClick(Sender: TObject);
begin
  CarregaForm(nil);
end;


procedure TfrmPesquisaVenda.btn_printClick(Sender: TObject);
var
  i :Integer;
  str :String;
begin
  for i := 1 to StringGrid1.RowCount do
  begin
    if i = 1 then
      str := StringGrid1.Cells[0, i]
    else
      str := str + ', ' + StringGrid1.Cells[0, i];
  end;

  relOrcamento.CarregaRelatorio(str);
  relOrcamento.QuickRep1.Preview;
end;


procedure TfrmPesquisaVenda.CarregaConsulta;
var
  dao :TDaoVenda;
  vendas :TVendas;
begin
  dao := TDaoVenda.Create;
  try
    vendas := dao.buscaVenda(rad_filtro.ItemIndex, edt_pesquisa.Text);
    CarregaGrid(vendas);
  finally
    dao.Free;
  end;
end;

procedure TfrmPesquisaVenda.CarregaForm(venda :TVenda);
var
  frm :TfrmVenda;
begin
  //Limpa Consulta
  StringGrid1.Clear;
  StringGrid2.Clear;

  frm := TfrmVenda.Create(frmPesquisaVenda, venda);
  frm.venda := venda;
  frm.Show;

end;

procedure TfrmPesquisaVenda.CarregaGrid(vendas: TVendas);
var
  i :Integer;
begin
  StringGrid1.RowCount := Length(vendas)+1;
  for i := 0 to Length(vendas)-1 do
  begin
    StringGrid1.Cells[0, i+1] := IntToStr(vendas[i].codigo);
    StringGrid1.Cells[1, i+1] := DateToStr(vendas[i].data);
    StringGrid1.Cells[2, i+1] := vendas[i].nome_cliente;
    StringGrid1.Cells[3, i+1] := FloatToStr(vendas[i].valor_total);
  end;
end;

procedure TfrmPesquisaVenda.CarregaGridItens(itens: TVendaMateriais);
var
  i :Integer;
begin
  StringGrid2.RowCount := Length(itens)+1;
  for i := 0 to Length(itens)-1 do
  begin
    StringGrid2.Cells[0, i+1] := IntToStr(itens[i].codvenda);
    StringGrid2.Cells[1, i+1] := IntToStr(itens[i].codmat);
    StringGrid2.Cells[2, i+1] := IntToStr(itens[i].quantidade);
    StringGrid2.Cells[3, i+1] := FloatToStr(itens[i].valor_unitario);
    StringGrid2.Cells[4, i+1] := itens[i].nome_material;
  end;
end;

procedure TfrmPesquisaVenda.FormActivate(Sender: TObject);
begin
  CarregaConsulta;
end;

procedure TfrmPesquisaVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    frmPesquisaVenda := nil;
    Action    := caFree;
end;

procedure TfrmPesquisaVenda.FormCreate(Sender: TObject);
begin
  //Cabeçalho
  StringGrid1.Cells[0, 0] := 'Codigo';
  StringGrid1.Cells[1, 0] := 'Data';
  StringGrid1.Cells[2, 0] := 'Nome Cliente';
  StringGrid1.Cells[3, 0] := 'Valor Total';

  //Cabeçalho
  StringGrid2.Cells[0, 0] := 'CodVenda';
  StringGrid2.Cells[1, 0] := 'CodMat';
  StringGrid2.Cells[2, 0] := 'Qtdade';
  StringGrid2.Cells[3, 0] := 'Valor';
  StringGrid2.Cells[4, 0] := 'Nome do Material';
end;

procedure TfrmPesquisaVenda.StringGrid1DblClick(Sender: TObject);
var
  nova_venda :TVenda;
begin
  nova_venda := TVenda.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                               StrToDate(StringGrid1.Cells[1, StringGrid1.Row]),
                               StringGrid1.Cells[2, StringGrid1.Row],
                               StrToFloat(StringGrid1.Cells[3, StringGrid1.Row]));
  CarregaForm(nova_venda);
end;

procedure TfrmPesquisaVenda.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  dao :TDaoVenda;
  itens :TVendaMateriais;
begin
  dao := TDaoVenda.Create;

  itens := dao.buscaItens(StrToInt(StringGrid1.Cells[0, Arow]));
  CarregaGridItens(itens);
end;

end.
