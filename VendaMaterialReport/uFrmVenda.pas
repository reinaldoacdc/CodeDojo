unit uFrmVenda;

interface

uses
  uVenda, uVendaMaterial,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmVenda = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    edt_nome: TEdit;
    edt_preco: TEdit;
    Label4: TLabel;
    edt_data: TDateTimePicker;
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    Label1: TLabel;
    edt_codigo: TEdit;
    Panel3: TPanel;
    btn_novo: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    btn_print: TBitBtn;
    btn_grava: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_gravaClick(Sender: TObject);
  private
    procedure CarregaGrid(materiais :TVendaMateriais);
    procedure CarregaForm(item :TVendaMaterial);
    procedure CarregaVenda(venda :TVenda);
  public
    venda :TVenda;
    constructor Create(AOwner: TComponent; venda :TVenda); overload;
  end;

var
  frmVenda: TfrmVenda;

implementation
uses StringGridHelper, uDaoVenda, uFrmVendaMaterial, uFrmPesquisaVenda, uRelOrcamento;
{$R *.dfm}


procedure TfrmVenda.btn_deleteClick(Sender: TObject);
var
  dao :TDaoVenda;
  item :TVendaMaterial;
begin
  dao := TDaoVenda.Create;
  try
    item := TVendaMaterial.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                                   StrToInt(StringGrid1.Cells[1, StringGrid1.Row]),
                                   StrToInt(StringGrid1.Cells[2, StringGrid1.Row]),
                                   StrToFloat(StringGrid1.Cells[3, StringGrid1.Row]),
                                   StringGrid1.Cells[4, StringGrid1.Row]);
    dao.ExcluirItem(item);
    dao.AtualizaValorVenda(dao.BuscaValorTotal(Self.venda.codigo), Self.venda.codigo);
  finally
    dao.Free;
  end;
  CarregaVenda(Self.venda);
end;

procedure TfrmVenda.btn_editClick(Sender: TObject);
var
  item :TVendaMaterial;
begin
  item := TVendaMaterial.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                               StrToInt(StringGrid1.Cells[1, StringGrid1.Row]),
                               StrToInt(StringGrid1.Cells[2, StringGrid1.Row]),
                               StrToFloat(StringGrid1.Cells[3, StringGrid1.Row]),
                               StringGrid1.Cells[4, StringGrid1.Row]);
  CarregaForm(item);
end;

procedure TfrmVenda.btn_gravaClick(Sender: TObject);
var nova_venda :TVenda;
begin
  nova_venda := TVenda.Create( StrToInt(edt_codigo.Text)
                        , edt_data.Date
                        , edt_nome.Text
                        , StrToFloat(edt_preco.Text));

  nova_venda.Salvar;
  Self.venda := nova_venda;
end;

procedure TfrmVenda.btn_novoClick(Sender: TObject);
var frm :TfrmVendaMaterial;
begin
  if not Assigned(venda) then
    raise Exception.Create('Atenção: É necessário gravar a venda antes de adicionar os itens!');

  frm := TfrmVendaMaterial.Create(nil);
  frm.codvenda := venda.codigo;
  frm.ShowModal;
  CarregaVenda(Self.venda);
end;

procedure TfrmVenda.btn_printClick(Sender: TObject);
begin
  relOrcamento.CarregaRelatorio(edt_codigo.Text);
  relOrcamento.QuickRep1.Preview;
end;


procedure TfrmVenda.CarregaForm(item: TVendaMaterial);
var
  frm :TfrmVendaMaterial;
begin
  frm := TfrmVendaMaterial.Create(nil);
  frm.frm_item := item;
  frm.ShowModal;

  if frm.ModalResult = mrOk then
    CarregaVenda(Self.venda);
end;

procedure TfrmVenda.CarregaGrid(materiais: TVendaMateriais);
var
  i :Integer;
begin
  StringGrid1.Clear;
  StringGrid1.RowCount := Length(materiais)+1;
  for i := 0 to Length(materiais)-1 do
  begin
    StringGrid1.Cells[0, i+1] := IntToStr(materiais[i].codvenda);
    StringGrid1.Cells[1, i+1] := IntToStr(materiais[i].codmat);
    StringGrid1.Cells[2, i+1] := IntToStr(materiais[i].quantidade);
    StringGrid1.Cells[3, i+1] := FloatToStr(materiais[i].valor_unitario);
    StringGrid1.Cells[4, i+1] := materiais[i].nome_material;
  end;

end;

procedure TfrmVenda.CarregaVenda(venda: TVenda);
var
  dao :TDaoVenda;
  nova_venda :TVenda;
  itens :TVendaMateriais;
begin
  dao := TDaoVenda.Create;
  try

    nova_venda := dao.buscaVenda(0, IntToStr(venda.codigo))[0];

    edt_codigo.Text := IntToStr(nova_venda.codigo);
    edt_data.Date := nova_venda.data;
    edt_nome.Text := nova_venda.nome_cliente;
    edt_preco.Text := FloatToStr(nova_venda.valor_total);

    itens := dao.buscaItens(nova_venda.codigo);
    CarregaGrid(itens);
  finally
    dao.Free;
  end;

end;

constructor TfrmVenda.Create(AOwner: TComponent; venda: TVenda);
begin
  inherited  Create(AOwner);
  Self.venda := venda;
end;

procedure TfrmVenda.FormClose(Sender: TObject; var Action: TCloseAction);
var nova_venda :TVenda;
begin
  if Assigned(venda) then
  begin
    nova_venda := TVenda.Create(StrToInt(edt_codigo.Text), edt_data.Date, edt_nome.Text, StrToFloat(edt_preco.Text));
    if not venda.Equals(nova_venda) then
    begin
      if  MessageDlg('Foram realizadas alterações. Deseja sair sem gravar?'
                    ,mtConfirmation,[mbyes,mbno],0)= mrno then
       Abort;
    end;
  end
  else
  begin
    if (edt_nome.Text <> '') or (edt_data.Date > 0) then
    begin
    if  MessageDlg('Foram realizadas alterações. Deseja sair sem gravar?'
                  ,mtConfirmation,[mbyes,mbno],0)= mrno then
     Abort;
    end;
  end;

  frmVenda := nil;
  Action    := caFree;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  edt_data.Date := 0;
  //Cabeçalho
  StringGrid1.Cells[0, 0] := 'Venda';
  StringGrid1.Cells[1, 0] := 'CodMaterial';
  StringGrid1.Cells[2, 0] := 'Qtdade';
  StringGrid1.Cells[3, 0] := 'Valor';
  StringGrid1.Cells[4, 0] := 'Nome Material';
end;

procedure TfrmVenda.FormShow(Sender: TObject);
begin
  if venda <> nil then
    CarregaVenda(venda);
end;

procedure TfrmVenda.StringGrid1DblClick(Sender: TObject);
var
  item :TVendaMaterial;
begin
  item := TVendaMaterial.Create( StrToInt(StringGrid1.Cells[0, StringGrid1.Row]),
                               StrToInt(StringGrid1.Cells[1, StringGrid1.Row]),
                               StrToInt(StringGrid1.Cells[2, StringGrid1.Row]),
                               StrToFloat(StringGrid1.Cells[3, StringGrid1.Row]),
                               StringGrid1.Cells[4, StringGrid1.Row]);
  CarregaForm(item);
end;

end.
