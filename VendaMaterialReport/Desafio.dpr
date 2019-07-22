program Desafio;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uDAO in 'uDAO.pas',
  uFrmPesquisaMaterial in 'uFrmPesquisaMaterial.pas' {frmPesquisaMaterial},
  uFrmMaterial in 'uFrmMaterial.pas' {frmMaterial},
  uDaoMaterial in 'uDaoMaterial.pas',
  uFrmPesquisaVenda in 'uFrmPesquisaVenda.pas' {frmPesquisaVenda},
  uMaterial in 'uMaterial.pas',
  uDaoVenda in 'uDaoVenda.pas',
  uVenda in 'uVenda.pas',
  uFrmVenda in 'uFrmVenda.pas' {frmVenda},
  uFrmVendaMaterial in 'uFrmVendaMaterial.pas' {frmVendaMaterial},
  uVendaMaterial in 'uVendaMaterial.pas',
  uRelOrcamento in 'uRelOrcamento.pas' {relOrcamento},
  StringGridHelper in 'StringGridHelper.pas',
  ApplicationHelper in 'ApplicationHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TrelOrcamento, relOrcamento);
  Application.Run;
end.
