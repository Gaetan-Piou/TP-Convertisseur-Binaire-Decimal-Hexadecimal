unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Spin,
  StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Choix: TRadioGroup;
    Saisie: TEdit;
    Resultat: TEdit;
    procedure ChoixClick(Sender: TObject);
    procedure SaisieChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function exposant(nb,expo:INTEGER):INTEGER;
var
  compteur,puissance:INTEGER;

begin
  puissance:=1;
  FOR compteur:=1 TO expo DO
    puissance:=puissance*nb;
  exposant:=puissance;
end;

function decbin(nb:INTEGER):STRING;
var
  converti:STRING;

begin
  WHILE nb>0 DO
  begin
    converti:=IntToStr(nb MOD 2)+ converti;
    nb := nb DIV 2;
  end;
  WHILE ((length(converti) MOD 4) > 0) OR (length(converti) = 0) DO
  begin
    converti:='0'+converti;
  end;
  decbin:=converti;
end;


function bindec(bin:STRING):STRING;
var
  converti,compt:INTEGER;

begin
  converti:=0;
  FOR compt:=0 TO length(bin)-1 DO
  begin
    IF bin[length(bin)-compt]='1' THEN
    begin
      converti:=converti+exposant(2,compt);
    end;
  end;
  bindec:=IntToStr(converti);
end;


function binhex(bin:STRING):STRING;
var
  converti:STRING;
  addit,compt1,compt2:INTEGER;

begin
  converti:='';
  compt2:=1;
  addit:=0;
  WHILE ((length(bin) MOD 4) > 0) OR (length(bin) = 0) DO
  begin
    bin:='0'+bin;
  end;
  FOR compt1:=1 TO length(bin) DO
  begin
    IF bin[compt1]='1' THEN
    begin
      addit:=addit+(8 DIV exposant(2,compt2-1));
    end;
    IF compt2 = 4 THEN
    begin
      CASE addit OF
       0,1,2,3,4,5,6,7,8,9:converti:=converti+IntToStr(addit);
       10:converti:=converti+'A';
       11:converti:=converti+'B';
       12:converti:=converti+'C';
       13:converti:=converti+'D';
       14:converti:=converti+'E';
       15:converti:=converti+'F';
      end;
      addit:=0;
      compt2:=1
    end
    else
    begin
      compt2:=compt2+1
    end;
  end;
  binhex:=converti;
end;

procedure TForm1.SaisieChange(Sender: TObject);
var
  conversion:INTEGER;
  converti,conversbin:STRING;

begin
  conversbin:=Saisie.Text;
  IF conversbin='' THEN
    conversion:=0
  ELSE
    conversion:=StrToInt(conversbin);
  converti:='';
  CASE Choix.ItemIndex OF
   0:converti:=decbin(conversion);
   1:converti:=bindec(conversbin);
   2:begin
     converti:=decbin(conversion);
     converti:=binhex(converti);
   end;
   3:converti:=binhex(conversbin);
  end;
  Resultat.Text:=converti;
end;

procedure TForm1.ChoixClick(Sender: TObject);
begin
  SaisieChange(Sender);
end;

end.

