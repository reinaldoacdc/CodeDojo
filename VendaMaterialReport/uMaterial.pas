unit uMaterial;

interface

type TMaterial = class
private
  Fcodigo :Integer;
  Fnome :String;
  Fpreco :Double;
  function ValidaNomeUnico :Boolean;

protected

public
  function Equals(obj :TMaterial) :Boolean;

  procedure Salvar;
  constructor Create(codigo :Integer; nome :String; preco :Double);
published
  property codigo :Integer read Fcodigo;
  property nome :String read Fnome;
  property preco :Double read Fpreco;
end;

type TMateriais = array of TMaterial;

implementation
uses uDaoMaterial, System.SysUtils;
{ TMaterial }


function TMaterial.Equals(obj: TMaterial): Boolean;
begin
  Result := False;
  if (Self.nome = obj.nome) and (Self.preco = obj.preco) then
    Result := True;
end;

constructor TMaterial.Create(codigo: Integer; nome: String; preco: Double);
begin
  Fcodigo := codigo;
  Fnome := nome;
  Fpreco := preco;
end;


procedure TMaterial.Salvar;
var dao :TDaoMaterial;
begin
  if (Fnome = '') or (Fpreco = 0) then
    raise Exception.Create('Dados Incompletos');

  if (Fcodigo = 0) and (not ValidaNomeUnico) then
    raise Exception.Create('Existe um item com o mesmo nome');

  dao := TDaoMaterial.Create;
  try
    if Fcodigo = 0 then
      dao.Inserir(Self)
    else
      dao.Atualizar(Self);
  finally
    dao.Free;
  end;
end;

function TMaterial.ValidaNomeUnico: Boolean;
var dao :TDaoMaterial;
begin
  dao := TDaoMaterial.Create;
  try
    Result := dao.temNomeUnico(Fnome);
  finally
    dao.Free;
  end;
end;

end.
