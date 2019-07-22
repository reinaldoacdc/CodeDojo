unit uFrmMaterial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uMaterial, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmMaterial = class(TForm)
    edt_nome: TEdit;
    Label2: TLabel;
    edt_preco: TEdit;
    Label3: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    edt_codigo: TEdit;
    btn_salvar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    material :TMaterial;
  end;

var
  frmMaterial: TfrmMaterial;

implementation
uses uDaoMaterial;

{$R *.dfm}

procedure TfrmMaterial.btn_salvarClick(Sender: TObject);
var
  mat :TMaterial;
begin
  mat := TMaterial.Create(StrToInt(edt_codigo.Text), edt_nome.Text, StrToFloat(edt_preco.Text));
  mat.Salvar;

  Self.material := mat;
  ModalResult := mrOk;
end;

procedure TfrmMaterial.FormClose(Sender: TObject; var Action: TCloseAction);
var mat :TMaterial;
begin
  if Assigned(material) then
  begin
    mat := TMaterial.Create(StrToInt(edt_codigo.Text), edt_nome.Text, StrToFloat(edt_preco.Text));

    if not material.Equals(mat) then
    begin
      if  MessageDlg('Foram realizadas alterações. Deseja sair sem gravar?'
                    ,mtConfirmation,[mbyes,mbno],0)= mrno then
       Abort;
    end;
  end
  else
  begin
    if (edt_nome.Text <> '') or (edt_preco.Text <> '') then
    begin
      if  MessageDlg('Foram realizadas alterações. Deseja sair sem gravar?'
                    ,mtConfirmation,[mbyes,mbno],0)= mrno then
       Abort;
    end;
  end;
  ModalResult := mrOk;
end;

procedure TfrmMaterial.FormShow(Sender: TObject);
begin
  if material <> nil then
  begin
    edt_codigo.Text := IntToStr(material.codigo);
    edt_nome.Text   := material.nome;
    edt_preco.Text  := FloatToStr(material.preco);
  end;
end;

end.
