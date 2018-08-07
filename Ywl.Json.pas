unit Ywl.Json;

interface

uses
  System.SysUtils,
  System.Json,
  REST.Json;

type
  TJson = class(REST.Json.TJson)
  public
    class function Decode(AJsonString: String): string; overload;
    class function Decode(AJsonValue: TJsonValue): string; overload;
    class function Format(AJsonValue: TJsonValue): string;
  end;

implementation

{ TJson }

class function TJson.Decode(AJsonValue: TJsonValue): string;
begin
  Result := Decode(AJsonValue.ToString());
end;

class function TJson.Decode(AJsonString: String): string;
var
  jv: TJsonValue;
begin
  jv := TJSONObject.ParseJSONValue(AJsonString);
  Result := jv.ToString();
  jv.Free;
end;

class function TJson.Format(AJsonValue: TJsonValue): string;
var
  s, sResult: string;
  c: char;
  EOL: string;
  INDENT: string;
  LIndent: string;
  isEOL: boolean;
  isInString: boolean;
  isEscape: boolean;
  isLeftSquareBracket: boolean;
  isRightBrace: boolean;
begin
  sResult := '';
  EOL := #13#10;
  INDENT := '  ';
  isEOL := true;
  isInString := false;
  isEscape := false;
  s := AJsonValue.ToString;
  // This will basically display all strings as Delphi strings. Technically we should show "Json encoded" strings here.
  for c in s do
  begin
    if not isInString and (c = '[') then
    begin
      if not isEOL then
        sResult := sResult + EOL;
      sResult := sResult + LIndent + c + EOL;
      LIndent := LIndent + INDENT;
      sResult := sResult + LIndent;
      isEOL := true;
      isLeftSquareBracket := true;
      isRightBrace := false;
    end
    else if not isInString and (c = '{') then
    begin
      if not isEOL then
        sResult := sResult + EOL;
      if not isLeftSquareBracket then
        sResult := sResult + LIndent + c + EOL
      else
        sResult := sResult + c + EOL;
      LIndent := LIndent + INDENT;
      sResult := sResult + LIndent;
      isEOL := true;
      isLeftSquareBracket := false;
      isRightBrace := false;
    end
    else if not isInString and (c = ',') then
    begin
      if isRightBrace then
      begin
        sResult := sResult.Substring(0, sResult.Length - 2) + c + EOL;
      end
      else
        sResult := sResult + c + EOL + LIndent;
      isLeftSquareBracket := false;
      isRightBrace := false;
      isEOL := true;
    end
    else if not isInString and (c = ']') then
    begin
      Delete(LIndent, 1, Length(INDENT));
      if not isEOL then
        sResult := sResult + EOL;
      sResult := sResult + LIndent + c + EOL;
      isEOL := true;
      isLeftSquareBracket := false;
      isRightBrace := false;
    end
    else if not isInString and (c = '}') then
    begin
      Delete(LIndent, 1, Length(INDENT));
      if not isEOL then
        sResult := sResult + EOL;
      sResult := sResult + LIndent + c + EOL;
      isEOL := true;
      isLeftSquareBracket := false;
      isRightBrace := true;
    end
    else if not isInString and (c = ':') then
    begin
      isEOL := false;
      isLeftSquareBracket := false;
      isRightBrace := false;
      sResult := sResult + c + ' ';
    end
    else
    begin
      isEOL := false;
      isLeftSquareBracket := false;
      isRightBrace := false;
      sResult := sResult + c;
    end;
    isEscape := (c = '\') and not isEscape;
    if not isEscape and (c = '"') then
      isInString := not isInString;
  end;
  Result := sResult;
end;

end.
