unit ApplicationHelper;

interface
uses Vcl.Forms;

type
  TApplicationHelper = class helper for TApplication
    procedure OpenForm( frm :TForm; obj :TFormClass);
  end;

implementation

{ TApplicationHelper }
procedure TApplicationHelper.OpenForm(frm: TForm; obj: TFormClass);
begin
  if frm = nil then
    frm := obj.Create(nil);
  frm.Show;
end;

end.
