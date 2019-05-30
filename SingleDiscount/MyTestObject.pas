unit MyTestObject;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TMyTestObject = class
  public


    [Test]
    procedure TestZero;
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('TestSingle','1, 1.10', ',')]
    [TestCase('TestMaximun','9, 9.90', ',')]
    [TestCase('TesteTen', '10, 10.90', ',')]
    [TestCase('TestEleven', '11, 11.90', ',')]
    [TestCase('TestNineTeen', '19, 19.90', ',')]
    [TestCase('TestTwenty', '20, 19.80', ',')]
    [TestCase('TestOverTwenty', '21, 20.70', ',')]
    procedure TestUnits( AValue1 : Integer; AValue2 : Double);
  end;

implementation
uses SingleDiscount;

procedure TMyTestObject.TestZero;
begin
  Assert.AreEqual( Double(0.0), TSingleDiscount.Create(0).calc());
end;

procedure TMyTestObject.TestUnits( AValue1 : Integer;  AValue2 : Double);
begin
  Assert.AreEqual( AValue2, TSingleDiscount.Create(AValue1).calc());
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
