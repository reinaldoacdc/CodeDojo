unit uDaoMaterial;

interface
uses Data.DB, Data.Win.ADODB, uDao, uMaterial;

type TDaoMaterial = class(TDao)
private

protected

public
  function temNomeUnico(nome :string) :Boolean;
  procedure Inserir(material :TMaterial);
  procedure Atualizar(material :TMaterial);
  procedure Excluir(codigo :Integer);

  function buscaMaterial(option :Integer; text :String) :TMateriais;

  constructor Create;
  destructor Destroy; override;
published

end;



implementation
uses System.SysUtils;


{ TDaoMaterial }
function TDaoMaterial.buscaMaterial(option: Integer; text: String): TMateriais;
var
  str :String;
  materiais :TMateriais;
  i :Integer;
begin
  str := 'select * from material ';
  if option = 0 then
    str := str + ' where codmat = ' + text
  else
    str := str + ' where nome like ' + QuotedStr('%' + text + '%');

  str := str + ' order by nome';

  query.SQL.Text := str;
  query.Open;


  SetLength(materiais, query.RecordCount);
  for i:=0 to query.RecordCount -1 do
  begin
    materiais[i] := TMaterial.Create(query.FieldByName('codmat').AsInteger,
                                     query.FieldByName('nome').AsString,
                                     query.FieldByName('preco').AsFloat);
    query.Next;
  end;

  Result := materiais;
end;


constructor TDaoMaterial.Create;
begin
  inherited;
  AbreBanco;
end;

destructor TDaoMaterial.Destroy;
begin
  FechaBanco;
  inherited;
end;

procedure TDaoMaterial.Excluir(codigo: Integer);
var str :String;
begin
  query.Close;
  str := 'delete from material where codmat = :codigo';
  query.SQL.Text := str;
  query.Parameters[0].Value := codigo;
  query.ExecSQL;
end;

procedure TDaoMaterial.Inserir(material: TMaterial);
var str :String;
begin
  query.Close;
  str := 'insert into material (codmat, nome, preco) values ( :codigo, :nome, :preco )';
  query.SQL.Text := str;
  query.Parameters[0].Value := get_increment('codmat', 'material');
  query.Parameters[1].Value := material.nome;
  query.Parameters[2].Value := material.preco;
  query.ExecSQL;
end;


function TDaoMaterial.temNomeUnico(nome: string): Boolean;
var str :String;
begin
  Result := True;
  query.Close;
  str := 'select count(codmat) as valor from material where lcase(nome) = :nome';
  query.SQL.Text := str;
  query.Parameters[0].Value := LowerCase(nome);
  query.Open;

  if query.FieldByName('valor').AsInteger > 0 then
    Result := False;
end;

procedure TDaoMaterial.Atualizar(material: TMaterial);
var str :String;
begin
  query.Close;
  str := 'update material set nome = :nome, preco = :preco where codmat = :codigo';

  query.SQL.Text := str;
  query.Parameters[0].Value := material.nome;
  query.Parameters[1].Value := material.preco;
  query.Parameters[2].Value := material.codigo;
  query.ExecSQL;
end;


end.
