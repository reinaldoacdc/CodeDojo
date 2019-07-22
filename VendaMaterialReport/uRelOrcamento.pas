unit uRelOrcamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, Db, ExtCtrls, Datasnap.DBClient, Data.Win.ADODB,
  Datasnap.Provider, Vcl.Imaging.pngimage;

type
  TrelOrcamento = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRSubDetail1: TQRSubDetail;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRGroup1: TQRGroup;
    ordfooter: TQRBand;
    QRSysData1: TQRSysData;
    QRImage1: TQRImage;
    QRShape4: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText6: TQRDBText;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel11: TQRLabel;
    QRDBText8: TQRDBText;
    cdsDetail: TClientDataSet;
    cdsDetailcodvenda: TIntegerField;
    cdsDetailnome_cliente: TStringField;
    cdsDetaildata: TDateField;
    cdsDetailvalor_total: TFloatField;
    cdsSubDetail: TClientDataSet;
    cdsSubDetailcodvenda: TIntegerField;
    cdsSubDetailcodmat: TIntegerField;
    cdsSubDetailquantidade: TIntegerField;
    cdsSubDetailvalor_unitario: TFloatField;
    cdsSubDetailvalor_total: TFloatField;
    cdsSubDetailnome: TStringField;
    procedure cdsDetailAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure CarregaRelatorio(codvendas :String);
  end;

var
  relOrcamento: TrelOrcamento;

implementation
uses uDaoVenda, uVenda, uVendaMaterial;
{$R *.DFM}

procedure TrelOrcamento.CarregaRelatorio(codvendas :String);
var
  dao :TDaoVenda;
  vendas :TVendas;
  i :Integer;
begin
  cdsDetail.EmptyDataSet;
  dao := TDaoVenda.Create;
  try
    vendas := dao.buscaVenda(0, codvendas);
    for i := 0 to Length(vendas)-1 do
    begin
      cdsDetail.Insert;
      cdsDetailcodvenda.AsInteger := vendas[i].codigo;
      cdsDetaildata.AsDateTime := vendas[i].data;
      cdsDetailnome_cliente.AsString := vendas[i].nome_cliente;
      cdsDetailvalor_total.AsFloat := vendas[i].valor_total;
      
      cdsDetail.Post;
    end;
      
  finally
    dao.Free;
  end;
end;

procedure TrelOrcamento.cdsDetailAfterScroll(DataSet: TDataSet);
var
  dao :TDaoVenda;
  itens :TVendaMateriais;
  i :Integer;
begin
  cdsSubDetail.EmptyDataSet;
  dao := TDaoVenda.Create;
  try
    itens := dao.buscaItens(cdsDetailcodvenda.AsInteger);
    for i := 0 to Length(itens)-1 do
    begin
      cdsSubDetail.Insert;
      cdsSubDetailcodvenda.AsInteger := itens[i].codvenda;
      cdsSubDetailcodmat.AsInteger := itens[i].codmat;
      cdsSubDetailnome.AsString := itens[i].nome_material;
      cdsSubDetailvalor_unitario.AsFloat := itens[i].valor_unitario;
      cdsSubDetailvalor_total.AsFloat := (itens[i].valor_unitario * itens[i].quantidade);
      cdsSubDetailquantidade.AsInteger := itens[i].quantidade;

      cdsSubDetail.Post;
    end;

  finally
    dao.Free;

  end;

end;

end.
