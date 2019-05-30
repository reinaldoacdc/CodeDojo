unit SingleDiscount;

interface

type TSingleDiscount = class
  private
    Fnumber :Integer;
    Fvalue :Double;
  public
    constructor Create(number :Integer);
    function calc :Double;
  published
    property  number :Integer read Fnumber;
    property value :Double read Fvalue;
end;

implementation

{ TSingleDiscount }

function TSingleDiscount.calc: Double;
var
  sobra :Integer;
begin
  Result := 0;

  if Fnumber = 0 then
    Result := 0
  else if Fnumber <= 9 then
    Result := Fnumber * 1.10
  else if (Fnumber >= 10) and (Fnumber < 20) then
  begin
    sobra := Fnumber - 9;
    Result := (9 * 1.10) + (sobra * 1.00);
  end
  else if Fnumber >= 20 then
  begin
    sobra := Fnumber - 19;
    Result := (9 * 1.10) + (9 * 1.00) + (sobra * 0.90);
  end;


end;

constructor TSingleDiscount.Create(number :Integer);
begin
  Fnumber := number;
end;

end.
