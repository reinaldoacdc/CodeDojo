unit uDAO;

interface
  uses Data.Win.ADODB;

type TDao = class
private
  Fconnection :TADOConnection;
  Fquery :TADOQuery;
protected

public
  function get_increment(campo, tabela :String) :Integer;

  procedure AbreBanco;
  procedure FechaBanco;

  constructor Create;
  destructor Destroy; override;
published
  property connection :TADOConnection read Fconnection;
  property query :TADOQuery read Fquery;
end;

implementation
uses System.SysUtils;


{ TDao }
constructor TDao.Create;
begin
  Fconnection := TADOConnection.Create(nil);
  Fconnection.LoginPrompt := False;
  Fconnection.Provider := 'Microsoft.Jet.OLEDB.4.0';
  Fconnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;'
                        +'Data Source=testeprogramacao2.mdb;'
                        +'Persist Security Info=False';

  Fquery := TADOQuery.Create(nil);
  Fquery.Connection := Self.Fconnection;
end;

destructor TDao.Destroy;
begin
  Fquery.Free;
  Fconnection.Free;
  inherited;
end;

procedure TDao.AbreBanco;
begin
  Fconnection.Connected := True;
end;

procedure TDao.FechaBanco;
begin
  Fconnection.Connected := False;
end;

function TDao.get_increment(campo, tabela: String): Integer;
var
  qr_aux :TADOQuery;
  valor :Integer;
begin
  qr_aux := TADOQuery.Create(nil);
  try
  qr_aux.Connection := Self.Fconnection;

  qr_aux.SQL.Text := Format('select max(%s)+1 as valor from %s', [campo, tabela]);
  qr_aux.Open;

  valor := qr_aux.FieldByName('valor').AsInteger;
  if valor = 0 then
    valor := 1;

  Result := valor;
  finally
    qr_aux.Free;
  end;
end;

end.
