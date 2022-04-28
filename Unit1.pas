unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,IdHashMessageDigest, idHash;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  getStream: TFileStream;
  setStream: TMemoryStream;
  IdMD5: TIdHashMessageDigest5;
  s:string;
begin
  if OpenDialog1.Execute then
  begin
    IdMD5 := TIdHashMessageDigest5.Create;
    getStream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead or fmShareExclusive);
    setStream := TMemoryStream.Create;
    s := IdMD5.HashStreamAsHex(getStream)+ '#';
    getStream.Position := 0;
    setStream.CopyFrom(getStream, 262144);
    setStream.Position := 0;
    s := s + IdMD5.HashStreamAsHex(setStream) + '#';
    s := s + inttostr(getStream.Size) + '#';;
    s := s + ExtractFileName(OpenDialog1.FileName);
    memo1.Lines.Add(s);
    memo1.Lines.Add('');
    getStream.Free;
    setStream.Free;
    IdMD5.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  memo1.Lines.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.SelectAll;
  Memo1.CopyToClipboard;
  ShowMessage('已经复制到剪贴板');
end;

end.
