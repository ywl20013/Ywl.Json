unit Models.OpRecord;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  Ywl.Json;

type
  TOpRecord = class
  private
    FId: Integer;
    FName: String;
    FTime: TDateTime;
    FValue08: Double;
    FValue09: Double;
    FValue02: Double;
    FValue03: Double;
    FValue10: Double;
    FValue01: Double;
    FValue06: Double;
    FValue07: Double;
    FValue04: Double;
    FValue05: Double;
  public
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Time: TDateTime read FTime write FTime;
    property Value01: Double read FValue01 write FValue01;
    property Value02: Double read FValue02 write FValue02;
    property Value03: Double read FValue03 write FValue03;
    property Value04: Double read FValue04 write FValue04;
    property Value05: Double read FValue05 write FValue05;
    property Value06: Double read FValue06 write FValue06;
    property Value07: Double read FValue07 write FValue07;
    property Value08: Double read FValue08 write FValue08;
    property Value09: Double read FValue09 write FValue09;
    property Value10: Double read FValue10 write FValue10;

    function SaveToJson(): TOpRecord;
  end;

  TOpRecords = class
  private
    FItems: TArray<TOpRecord>;
  public
    property Items: TArray<TOpRecord> read FItems write FItems;

    destructor Destroy; override;

    function Add(value: TOpRecord): TOpRecords;
    function ToJson(): String;
    function SaveToJson(): TOpRecords;
    Class function LoadFromJsonFile(): TOpRecords;
  end;

implementation

{ TOpRecord }

function TOpRecord.SaveToJson: TOpRecord;
var
  strs: TStringList;
  jo: TJSONObject;
begin
  Result := Self;
  strs := TStringList.Create;
  try
    // strs.Text := REST.Json.TJson.ObjectToJsonString(Self);
    jo := TJson.ObjectToJsonObject(Self);
    strs.Text := TJson.Format(jo);
    jo.Free;
    strs.SaveToFile(ExtractFilePath(ParamStr(0)) + 'oprecord.json');

  finally
    strs.Free;
  end;
end;

{ TOpRecords }

function TOpRecords.Add(value: TOpRecord): TOpRecords;
begin
  SetLength(Self.FItems, Length(Self.FItems) + 1);
  Self.FItems[High(Self.FItems)] := value;
  Result := Self;
end;

destructor TOpRecords.Destroy;
var
  item: TObject;
begin
  for item in Self.FItems do
    item.Destroy;
  inherited;
end;

class function TOpRecords.LoadFromJsonFile: TOpRecords;
var
  strs: TStringList;
begin
  strs := TStringList.Create;
  try
    strs.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'oprecords.json');
    Result := TJson.JsonToObject<TOpRecords>(strs.Text);
  finally
    strs.Free;
  end;
end;

function TOpRecords.SaveToJson: TOpRecords;
var
  strs: TStringList;
  jo: TJSONObject;
begin
  Result := Self;
  strs := TStringList.Create;
  try
    jo := TJson.ObjectToJsonObject(Self);
    strs.Text := TJson.Format(jo);
    jo.Free;
    strs.SaveToFile(ExtractFilePath(ParamStr(0)) + 'oprecords.json');
  finally
    strs.Free;
  end;
end;

function TOpRecords.ToJson: String;
var
  jo: TJSONObject;
begin
  jo := TJson.ObjectToJsonObject(Self);
  Result := TJson.Format(jo);
  jo.Free;
end;

end.
