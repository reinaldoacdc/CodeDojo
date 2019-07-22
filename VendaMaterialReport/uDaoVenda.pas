unit uDaoVenda;

interface
uses uDao, uVenda, uVendaMaterial;

type TDaoVenda = class(TDao)
private

protected

public
  procedure Inserir(venda :TVenda);
  procedure Atualizar(venda :TVenda);
  procedure ExcluirDetalhe(codigo :Integer);
  procedure Excluir(codigo :Integer);
  function buscaVenda(option :Integer; text :String) :TVendas;


  procedure InserirItem(item :TVendaMaterial);
  procedure AtualizarItem(item :TVendaMaterial);
  procedure ExcluirItem(item :TVendaMaterial);
  function buscaItens(codvenda :Integer) :TVendaMateriais;
  function itemCriado(item :TVendaMaterial) :Boolean;

  function BuscaValorTotal(codvenda :Integer) :Double;
  procedure AtualizaValorVenda(valor :Double;  codvenda :Integer);

  constructor Create;
  destructor Destroy; override;

published

end;

implementation
uses System.SysUtils, Data.DB, Data.Win.ADODB;
{ TDaoVenda }

procedure TDaoVenda.Atualizar(venda: TVenda);
var str :String;
begin
  query.Close;
  str := 'update venda set data = :data, nome_cliente = :nome where codvenda = :codigo';

  query.SQL.Text := str;
  query.Parameters[0].DataType := ftDate;
  query.Parameters[0].Value := venda.data;
  query.Parameters[1].Value := venda.nome_cliente;
  query.Parameters[2].Value := venda.codigo;
  query.ExecSQL;
end;

procedure TDaoVenda.AtualizarItem(item: TVendaMaterial);
var str :String;
begin
  query.Close;
  str := 'update venda_material set quantidade = :quantidade, valor_unitario = :valor where codvenda = :codvenda and codmat = :codmat ';

  query.SQL.Text := str;
  query.Parameters[0].Value := item.quantidade;
  query.Parameters[1].Value := item.valor_unitario;
  query.Parameters[2].Value := item.codvenda;
  query.Parameters[3].Value := item.codmat;
  query.ExecSQL;
end;

procedure TDaoVenda.AtualizaValorVenda(valor: Double; codvenda :Integer);
var
  qr_aux :TADOQuery;
begin
  qr_aux := TADOQuery.Create(nil);
  try
  qr_aux.Connection := Self.connection;

  qr_aux.SQL.Text := 'update venda set valor_total = :valor where codvenda = :codvenda';
  qr_aux.Parameters[0].Value := valor;
  qr_aux.Parameters[1].Value := codvenda;
  qr_aux.ExecSQL;
  finally
    qr_aux.Free;
  end;
end;

function TDaoVenda.buscaItens(codvenda: Integer): TVendaMateriais;
var
  str :String;
  itens :TVendaMateriais;
  i :Integer;
begin
  str := 'select venda_material.*, material.nome '
       + ' from venda_material '
       + ' left join material on material.codmat = venda_material.codmat '
       + ' where codvenda = :codvenda';
  query.SQL.Text := str;
  query.Parameters[0].Value := codvenda;
  query.Open;

  SetLength(itens, query.RecordCount);
  for i := 0 to query.RecordCount-1 do
  begin
    itens[i] := TVendaMaterial.Create( query.FieldByName('codvenda').AsInteger
                              , query.FieldByName('codmat').AsInteger
                              , query.FieldByName('quantidade').AsInteger
                              , query.FieldByName('valor_unitario').AsFloat
                              , query.FieldByName('nome').AsString);
    query.Next;
  end;
  Result := itens;

end;

function TDaoVenda.BuscaValorTotal(codvenda: Integer): Double;
var
  qr_aux :TADOQuery;
begin
  qr_aux := TADOQuery.Create(nil);
  try
  qr_aux.Connection := Self.connection;

  qr_aux.SQL.Text := 'SELECT Sum(venda_material.valor_unitario * venda_material.quantidade ) as valor FROM venda_material where codvenda = :codvenda';
  qr_aux.Parameters[0].Value := codvenda;
  qr_aux.Open;

  Result := qr_aux.FieldByName('valor').AsInteger;
  finally
    qr_aux.Free;
  end;
end;

function TDaoVenda.buscaVenda(option: Integer; text: String): TVendas;
var
  str :String;
  vendas :TVendas;
  i :Integer;
begin
  str := 'select * from venda';
  if option = 0 then
    str := str + ' where codvenda in ' + '(' + text + ')'
  else if option = 1 then
    str := str + ' where data = ' + '#' + text + '#'
  else
    str := str + ' where nome_cliente like' + QuotedStr('%' + text + '%');
  str := str + ' order by nome_cliente';


  query.SQL.Text := str;
  query.Open;

  SetLength(vendas, query.RecordCount);
  for i := 0 to query.RecordCount-1 do
  begin
    vendas[i] := TVenda.Create( query.FieldByName('codvenda').AsInteger
                              , query.FieldByName('data').AsDateTime
                              , query.FieldByName('nome_cliente').AsString
                              , query.FieldByName('valor_total').AsFloat);
    query.Next;
  end;
  Result := vendas;
end;

constructor TDaoVenda.Create;
begin
  inherited;
  AbreBanco;
end;

destructor TDaoVenda.Destroy;
begin
  FechaBanco;
  inherited;
end;

procedure TDaoVenda.Excluir(codigo :Integer);
var str :String;
begin
  query.Close;
  str := 'delete from venda where codvenda = :codigo';
  query.SQL.Text := str;
  query.Parameters[0].Value := codigo;
  query.ExecSQL;
end;

procedure TDaoVenda.ExcluirDetalhe(codigo: Integer);
var str :String;
begin
  query.Close;
  str := 'delete from venda_material where codvenda = :codigo';
  query.SQL.Text := str;
  query.Parameters[0].Value := codigo;
  query.ExecSQL;
end;

procedure TDaoVenda.ExcluirItem(item: TVendaMaterial);
var str :String;
begin
  query.Close;
  str := 'delete from venda_material where codvenda = :codvenda and codmat = :codmat';
  query.SQL.Text := str;
  query.Parameters[0].Value := item.codvenda;
  query.Parameters[1].Value := item.codmat;
  query.ExecSQL;
end;

procedure TDaoVenda.Inserir(venda: TVenda);
var str :String;
begin
  query.Close;
  str := 'insert into venda (codvenda, data, nome_cliente, valor_total) values ( :codigo, :data, :nome, :valor )';
  query.SQL.Text := str;
  query.Parameters[0].Value := venda.codigo;
  query.Parameters[1].DataType := ftDate;
  query.Parameters[1].Value := venda.data;
  query.Parameters[2].Value := venda.nome_cliente;
  query.Parameters[3].Value := venda.valor_total;
  query.ExecSQL;

end;

procedure TDaoVenda.InserirItem(item: TVendaMaterial);
var str :String;
begin
  query.Close;
  str := 'insert into venda_material (codvenda, codmat, quantidade, valor_unitario) values ( :codvenda, :codmat, :qtdade, :valor )';
  query.SQL.Text := str;
  query.Parameters[0].Value := item.codvenda;
  query.Parameters[1].Value := item.codmat;
  query.Parameters[2].Value := item.quantidade;
  query.Parameters[3].Value := item.valor_unitario;
  query.ExecSQL;
end;

function TDaoVenda.itemCriado(item: TVendaMaterial): Boolean;
var str :String;
begin
  Result := False;
  query.Close;
  str := 'select count(codvenda) as total from venda_material where codvenda = :codvenda and codmat = :codmat ';
  query.SQL.Text := str;
  query.Parameters[0].Value := item.codvenda;
  query.Parameters[1].Value := item.codmat;
  query.Open;

  if query.FieldByName('total').AsInteger > 0 then
    Result := True;
end;

end.
