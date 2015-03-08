unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, CPort, DB, Grids, DBGrids, MemDS, DBAccess,
  MyAccess;

type
  TForm1 = class(TForm)
    ComPort1: TComPort;
    Button1: TButton;
    Timer1: TTimer;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape7: TShape;
    Timer2: TTimer;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  siklus:integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if Button1.Caption='start' then
  begin
  siklus:=1;
  ComPort1.Open;
  Button1.Caption:='stop';
  MyConnection1.Open;
  Timer1.Enabled:=true;
  end
else
  begin
  Button1.Caption:='start';
  Timer1.Enabled:=false;
  ComPort1.Close;
  MyConnection1.Close;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if (siklus=1)then ComPort1.WriteStr('*1111#')
else if(siklus=2)then ComPort1.WriteStr('*1111#')
else if(siklus=3)then ComPort1.WriteStr('*1111#')
else if(siklus=4)then ComPort1.WriteStr('*1101#')
else if(siklus=5)then ComPort1.WriteStr('*1101#')
else if(siklus=6)then ComPort1.WriteStr('*1001#')
else if(siklus=7)then ComPort1.WriteStr('*1001#')
else if(siklus=8)then ComPort1.WriteStr('*1000#')
else if(siklus=9)then ComPort1.WriteStr('*1000#')
else if(siklus=10)then ComPort1.WriteStr('*1000#')
else if(siklus=11)then ComPort1.WriteStr('*0000#')
else if(siklus=12)then ComPort1.WriteStr('*0000#')
else if(siklus=13)then ComPort1.WriteStr('*0000#')
else if(siklus=14)then ComPort1.WriteStr('*0000#')
else if(siklus=15)then ComPort1.WriteStr('*0001#')
else if(siklus=16)then ComPort1.WriteStr('*0001#')
else if(siklus=17)then ComPort1.WriteStr('*0111#')
else if(siklus=18)then ComPort1.WriteStr('*0111#')
else if(siklus=19)then ComPort1.WriteStr('*0111#')
else if(siklus=20)then
  begin
  siklus:=1;
  ComPort1.WriteStr('*0111#') ;
  end;
inc(siklus);
end;

procedure TForm1.ComPort1RxChar(Sender: TObject; Count: Integer);
var data:string;
begin
ComPort1.ReadStr(data,Count);
Memo1.Text:=Memo1.Text+data;
Timer2.Enabled:=true;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var buf:string;
    awal,akhir,panjang:integer;
begin
Timer2.Enabled:=false;
buf:=Memo1.Text;
akhir:=Pos('#',buf);
awal:=Pos('*',buf);
panjang:=akhir-awal;
if (akhir>5) and(panjang=5)then
  begin
  if copy(buf,awal+1,1)='0' then
    begin
    Shape6.Brush.Color:=clLime;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=0 where id_detail_parkir=1';
    MyQuery1.ExecSQL;
    end
  else if copy(buf,awal+1,1)='1' then
    begin
    Shape6.Brush.Color:=clRed;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=1 where id_detail_parkir=1';
    MyQuery1.ExecSQL;
    end;

  if copy(buf,awal+2,1)='0' then
    begin
    Shape7.Brush.Color:=clLime;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=0 where id_detail_parkir=2';
    MyQuery1.ExecSQL;
    end
  else if copy(buf,awal+2,1)='1' then
    begin
    Shape7.Brush.Color:=clRed;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=1 where id_detail_parkir=2';
    MyQuery1.ExecSQL;
    end;

  if copy(buf,awal+3,1)='0' then
    begin
    Shape8.Brush.Color:=clLime;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=0 where id_detail_parkir=4';
    MyQuery1.ExecSQL;
    end
  else if copy(buf,awal+3,1)='1' then
    begin
    Shape8.Brush.Color:=clRed;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=1 where id_detail_parkir=4';
    MyQuery1.ExecSQL;
    end;

  if copy(buf,awal+4,1)='0' then
    begin
    Shape9.Brush.Color:=clLime;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=0 where id_detail_parkir=5';
    MyQuery1.ExecSQL;
    end
  else if copy(buf,awal+4,1)='1' then
    begin
    Shape9.Brush.Color:=clRed;
    MyQuery1.Close;
    MyQuery1.SQL.Text:='update detail_parkir set status=1 where id_detail_parkir=5';
    MyQuery1.ExecSQL;
    end;
  end;
Memo1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
MyQuery1.Close;
MyQuery1.SQL.Text:='select * from detail_parkir';
MyQuery1.Open;
end;

end.
