unit DataModule;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, Tina4HttpServer, IdContext, IdScheduler, IdSchedulerOfThread, IdSchedulerOfThreadPool, IdServerIOHandler, IdSSL, IdSSLOpenSSL, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, Tina4Core, JSON, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmDataModule = class(TDataModule)
    Tina4HttpServer1: TTina4HttpServer;
    IdSchedulerOfThreadPool1: TIdSchedulerOfThreadPool;
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    procedure Tina4HttpServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetBrands() : TJSONObject;
    function GetSBrands(): TJSONObject;
  end;

var
  frmDataModule: TfrmDataModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TfrmDataModule.GetBrands: TJSONObject;
begin
  Result := GetJSONFromDB(FDConnection1, 'select * from brands');
  WriteLn(Result.ToString);
end;

function TfrmDataModule.GetSBrands: TJSONObject;
var
  Params: TFDParams;
begin
  Params := TFDParams.Create;
  try
    Params.Add('name', '%', TParamType.ptInput);

    Result := GetJSONFromDB(FDConnection1, 'select * from brands where brand_name like :name', 'brands', Params);
    WriteLn(Result.ToString);
  finally
    Params.Free;
  end;
end;

procedure TfrmDataModule.Tina4HttpServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  i: Integer;
begin
  AResponseInfo.ResponseText := 'Hello';
  WriteLn('Received ....');
  WriteLn('Request:'+ARequestInfo.Document);

  i := 0;
  while i < 10000 do
  begin
    WriteLn('Running '+IntToStr(i));
    i := i + 1;
  end;
end;

end.
