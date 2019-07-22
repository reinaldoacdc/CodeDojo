unit uFrmVendaMaterial;

interface

uses
  uMaterial, uVendaMaterial,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmVendaMaterial = class(TForm)
    Label1: TLabel;
    edt_codvenda: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edt_nome: TEdit;
    edt_preco: TEdit;
    Label4: TLabel;
    edt_qtdade: TEdit;
    Label5: TLabel;
    edt_codmaterial: TEdit;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    rad_filtro: TRadioGroup;
    edt_pesquisa: TEdit;
    btn_buscar: TBitBtn;
    btn_grava: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_buscarClick(Sender: TObject);
    procedure btn_gravaClick(Sender: TObject);
  private
    procedure CarregaGrid(materiais :TMateriais);

  public
    codvenda :Integer;
    frm_item :TVendaMaterial;
  end;

var
  frmVendaMaterial: TfrmVendaMaterial;

implementation
uses StringGridHelper, uDaoMaterial, uDaoVenda;
{$R *.dfm}

{ TForm3 }


procedure TfrmVendaMaterial.btn_buscarClick(Sender: TObject);
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


procedure TfrmVendaMaterial.btn_gravaClick(Sender: TObject);
var item :TVendaMaterial;
begin
  item := TVendaMaterial.Create( StrToInt(edt_codvenda.Text)
                               , StrToInt(edt_codmaterial.Text)
                               , StrToInt(edt_qtdade.Text)
                               , StrToFloat(edt_preco.Text)
                               , edt_nome.Text );
  item.Salvar;
  Self.frm_item := item;
  ModalResult := mrOk;
end;

procedure TfrmVendaMaterial.CarregaGrid(materiais: TMateriais);
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

procedure TfrmVendaMaterial.FormClose(Sender: TObject;
  var Action: TCloseAction);
var item :TVendaMaterial;
begin
  if Assigned(frm_item) then
  begin
    item := TVendaMaterial.Create( StrToInt(edt_codvenda.Text)
                                 , StrToInt(edt_codmaterial.Text)
                                 , StrToInt(edt_qtdade.Text)
                                 , StrToFloat(edt_preco.Text)
                                 , edt_nome.Text );

    if not frm_item.Equals(item) then
    begin
      if  MessageDlg( 'Foram realizadas alterações. Deseja sair sem gravar?'
                    , mtConfirmation,[mbyes,mbno],0)= mrno then
       Abort;
    end;
  end
  else
  begin
    if (edt_nome.Text <> '') or (edt_preco.Text <> '0') or (edt_qtdade.Text <> '0') then
    begin
      if  MessageDlg( 'Foram realizadas alterações. Deseja sair sem gravar?'
                    , mtConfirmation,[mbyes,mbno],0)= mrno then
       Abort;
    end;
  end;
  ModalResult := mrCancel;
end;

procedure TfrmVendaMaterial.FormCreate(Sender: TObject);
begin
  //Cabeçalho
  StringGrid1.Cells[0, 0] := 'Codigo';
  StringGrid1.Cells[1, 0] := 'Nome';
  StringGrid1.Cells[2, 0] := 'Preço';
end;

procedure TfrmVendaMaterial.FormShow(Sender: TObject);
begin
  edt_codvenda.Text := IntToStr(codvenda);
  if frm_item <> nil then
  begin
    edt_codvenda.Text := IntToStr(frm_item.codvenda);
    edt_codmaterial.Text := IntToStr(frm_item.codmat);
    edt_preco.Text := FloatToStr(frm_item.valor_unitario);
    edt_qtdade.Text := IntToStr(frm_item.quantidade);
    edt_nome.Text := frm_item.nome_material;
  end;
end;

procedure TfrmVendaMaterial.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  edt_codmaterial.Text := (StringGrid1.Cells[0, Arow]);
  edt_nome.Text := StringGrid1.Cells[1, Arow];
  edt_preco.Text := (StringGrid1.Cells[2, Arow]);
  edt_qtdade.Text := '1';
end;

end.
