unit uVenda;

interface

type TVenda = class
private
  Fcodigo :Integer;
  Fdata :TDate;
  Fnome_cliente :String;
  Fvalor_total :Double;
  procedure setCodigo(codigo :integer);
protected
  { protected declarations }
public
  function Equals(obj :TVenda) :Boolean;
  procedure Salvar;
  constructor Create(codigo :Integer; data :TDate; nome_cliente :String; valor_total :Double);
published
  property codigo :Integer read Fcodigo;
  property data :TDate read Fdata;
  property nome_cliente :String read Fnome_cliente;
  property valor_total :Double read Fvalor_total;
end;

type TVendas = array of TVenda;

implementation
uses System.SysUtils, uDaoVenda;
{ TVenda }

constructor TVenda.Create(codigo: Integer; data: TDate; nome_cliente: String;
  valor_total: Double);
begin
  Fcodigo := codigo;
  Fdata := data;
  Fnome_cliente := nome_cliente;
  Fvalor_total := valor_total;
end;

function TVenda.Equals(obj: TVenda): Boolean;
begin
  Result := False;
  if (Self.nome_cliente = obj.nome_cliente) and (Self.data = obj.data) then
    Result := True;
end;

procedure TVenda.Salvar;
var dao :TDaoVenda;
begin
  if (Fnome_cliente = '') or (Fdata = 0) then
    raise Exception.Create('Dados Incompletos');

  dao := TDaoVenda.Create;
  try
    if Fcodigo = 0 then
    begin
      Self.setCodigo(dao.get_increment('codvenda', 'venda'));
      dao.Inserir(Self);
    end
    else
      dao.Atualizar(Self);
  finally

  end;
end;

procedure TVenda.setCodigo(codigo: integer);
begin
  Fcodigo := codigo;
end;

end.
