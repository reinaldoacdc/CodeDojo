unit uVendaMaterial;

interface

Type TVendaMaterial = class
private
  Fcodvenda :Integer;
  Fcodmat :Integer;
  Fnome_material :String;
  Fquantidade :Integer;
  Fvalor_unitario :Double;
protected

public
  function Equals(obj :TVendaMaterial) :Boolean;
  procedure Salvar;
  constructor Create(codvenda, codmat, qtdade :Integer; valor :Double; nome_material :String);
published
  property codvenda :Integer read Fcodvenda;
  property codmat :Integer read Fcodmat;
  property nome_material :String read Fnome_material;
  property quantidade :Integer read Fquantidade;
  property valor_unitario :Double read Fvalor_unitario;
end;

type TVendaMateriais = array of TVendaMaterial;

implementation
uses System.SysUtils, uDaoVenda;
{ TVendaMaterial }

constructor TVendaMaterial.Create(codvenda, codmat, qtdade: Integer;
  valor: Double; nome_material :String);
begin
  Fcodvenda := codvenda;
  Fcodmat := codmat;
  Fquantidade := qtdade;
  Fvalor_unitario := valor;
  Fnome_material := nome_material;
end;

function TVendaMaterial.Equals(obj: TVendaMaterial): Boolean;
begin
  Result := False;
  if (Self.quantidade = obj.quantidade) and (Self.valor_unitario = obj.valor_unitario) then
    Result := True;
end;

procedure TVendaMaterial.Salvar;
var dao :TDaoVenda;
begin
  if (Fquantidade = 0) or (Fvalor_unitario = 0) then
    raise Exception.Create('Dados Incompletos');

  dao := TDaoVenda.Create;
  try
    if dao.itemCriado(Self) then
      dao.AtualizarItem(Self)
    else
      dao.InserirItem(Self);

    dao.AtualizaValorVenda(dao.BuscaValorTotal(Self.Fcodvenda), Self.Fcodvenda);
  finally
    dao.Free;
  end;
end;

end.
