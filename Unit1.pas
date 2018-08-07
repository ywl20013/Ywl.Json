unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Json,
  REST.Json,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Models.OpRecord;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btnParser: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtCount: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btnParserClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function FillData(Count: Cardinal): Models.OpRecord.TOpRecords;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.FillData(Count: Cardinal): Models.OpRecord.TOpRecords;
var
  rec: Models.OpRecord.TOpRecord;
  recs: Models.OpRecord.TOpRecords;
  i: Integer;
  jo: TJSONObject;
begin
  recs := Models.OpRecord.TOpRecords.Create;

  Randomize;
  for i := 0 to Count - 1 do
  begin
    rec := Models.OpRecord.TOpRecord.Create;
    rec.Id := i;
    rec.Name := '≤‚ ‘_' + i.ToString();
    rec.Time := Now;
    rec.Value01 := Random();
    rec.Value02 := Random();
    rec.Value03 := Random();
    rec.Value04 := Random();
    rec.Value05 := Random();
    rec.Value06 := Random();
    rec.Value07 := Random();
    rec.Value08 := Random();
    rec.Value09 := Random();
    rec.Value10 := Random();
    recs.Add(rec);
  end;
  Result := recs;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edtCount.Text := '10';
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  sCount: string;
  tick: Cardinal;
  recs: Models.OpRecord.TOpRecords;
begin
  sCount := edtCount.Text;
  tick := GetTickCount;
  recs := FillData(sCount.ToInteger);
  recs.SaveToJson.Free;
  self.Label1.Caption := 'used ' + (GetTickCount - tick).ToString;
end;

procedure TForm1.btnParserClick(Sender: TObject);
var
  recs: Models.OpRecord.TOpRecords;
  tick: Cardinal;
begin
  tick := GetTickCount;
  recs := Models.OpRecord.TOpRecords.LoadFromJsonFile;
  self.Label2.Caption := 'used ' + (GetTickCount - tick).ToString;
  recs.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  sCount: string;
  tick: Cardinal;
  recs: Models.OpRecord.TOpRecords;
begin
  sCount := edtCount.Text;
  tick := GetTickCount;
  recs := FillData(sCount.ToInteger);
  self.Memo1.Text := recs.ToJson;
  recs.Free;
  self.Label1.Caption := 'used ' + (GetTickCount - tick).ToString;
end;

end.
