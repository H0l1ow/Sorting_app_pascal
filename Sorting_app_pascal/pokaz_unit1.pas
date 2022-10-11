unit pokaz_unit1;
                                                                                  // F12 wywolywanie okna
{$mode objfpc}{$H+}                                                               // ctrl + spacja pomoc

interface

uses
  Windows, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { Lista }

  TLista_Jed = ^Lista;
  Lista  = record
          nastepny   :   TLista_Jed;
          wartosc    :   integer;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button_Info        :      TButton;
    Button_Konice      :      TButton;
    Button_Sortuj      :      TButton;
    Button_Losuj       :      TButton;
    Opis_2             :      TLabel;
    Opis_1             :      TLabel;

    TListBox_zbior_danych_zrodlowych           : TListBox;
    TListBox_zbior_danych_posortowanych        : TListBox;

    procedure Button_InfoClick(Sender: TObject);
    procedure Button_KoniceClick(Sender: TObject);
    procedure Button_LosujClick(Sender: TObject);
    procedure Button_SortujClick(Sender: TObject);
    procedure Opis_1Click(Sender: TObject);
    procedure Opis_2Click(Sender: TObject);
    procedure TListBox_zbior_danych_posortowanychClick(Sender: TObject);
    procedure TListBox_zbior_danych_zrodlowychClick(Sender: TObject);

  private
      LosujLista        : Lista;
      const n           : integer = 19;
      const Max         : integer = 1000;

  { Procedury }

  function OstatniElement                  : TLista_Jed;
  procedure Wyswietl(listBox : TListBox);
  procedure Czysc;
  procedure Czysc_2;
  procedure DodajNaKoncu;
  procedure Losowanie;
  procedure Sortowanie;

  public

  end;

var
  Form1: TForm1;

implementation

//Funkcja znajdowanie Ostatniego elementu na liscie
function TForm1.OstatniElement() : TLista_Jed;
begin
     Result := @LosujLista;
     while Result^.nastepny <> NIL do
     begin
       Result := Result^.nastepny;
     end;
end;

//Procedura wyswietlenie listy
procedure TForm1.Wyswietl(listBox : TListBox);
var
  aktualnyElement : ^Lista;
  i               : integer = 0;

begin
     aktualnyElement := @LosujLista;
     while aktualnyElement^.nastepny <> NIL do
     begin
       i := i + 1;
       listBox.Items.Add(IntToStr(i) + ' : ' + IntToStr(aktualnyElement^.wartosc));
       aktualnyElement:= aktualnyElement^.nastepny;
     end;
end;

//Procedura czyszczenia listy oraz obu kolumn
procedure TForm1.Czysc();
var
  aktualnyElement : TLista_Jed;

begin
     aktualnyElement:= @LosujLista;
     while aktualnyElement^.nastepny <> NIL do
     begin
       aktualnyElement:= aktualnyElement^.nastepny;
     end;

     Dispose(aktualnyElement);
     TListBox_zbior_danych_posortowanych.Items.Clear;
     TListBox_zbior_danych_zrodlowych.Items.Clear;
end;

//Procedura czyszczenia kolumny posortowanej
procedure TForm1.Czysc_2();
begin
     TListBox_zbior_danych_posortowanych.Items.Clear;
end;

//Procedura dodania elementu na koncu listy
procedure TForm1.DodajNaKoncu();
var
  newItem : TLista_Jed;
  lastItem : TLista_Jed;

begin
     new(newItem);
     newItem^.wartosc := Random(Max);
     newItem^.nastepny:= NIL;
     lastItem := OstatniElement;
     lastItem^.nastepny:= newItem;
end;

//Procedura losowania
procedure TForm1.Losowanie();
var
  i : integer;

begin
     randomize;
     LosujLista.nastepny := NIL;
     LosujLista.wartosc := Random(Max);
     for i := 0 to n do
     begin
       DodajNaKoncu;
     end;
end;

//Procedura sortowania babelkowego
procedure TForm1.Sortowanie();
var
  pierwszy : ^Lista;
  drugi    : ^Lista;
  temp     : integer;
begin
     pierwszy := @LosujLista;
     while pierwszy^.nastepny <> NIL do
     begin
         drugi := pierwszy^.nastepny;
         while drugi <> NIL do
         begin
             if (pierwszy^.wartosc > drugi^.wartosc) then
             begin
               temp := pierwszy^.wartosc;
               pierwszy^.wartosc := drugi^.wartosc;
               drugi^.wartosc := temp;
             end;
             drugi := drugi^.nastepny;
         end;
         pierwszy := pierwszy^.nastepny
     end;

end;


{$R *.lfm}

{ TForm1 }

procedure TForm1.Opis_1Click(Sender: TObject);
begin

end;

procedure TForm1.Opis_2Click(Sender: TObject);
begin

end;

procedure TForm1.TListBox_zbior_danych_posortowanychClick(Sender: TObject);
begin

end;

procedure TForm1.TListBox_zbior_danych_zrodlowychClick(Sender: TObject);
begin

end;

procedure TForm1.Button_KoniceClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Button_LosujClick(Sender: TObject);

begin
   Czysc;
   Losowanie;
   Wyswietl(TListBox_zbior_danych_zrodlowych);
end;

procedure TForm1.Button_SortujClick(Sender: TObject);
begin
   Czysc_2;
   Sortowanie;
   Wyswietl(TListBox_zbior_danych_posortowanych);
end;

procedure TForm1.Button_InfoClick(Sender: TObject);
   var
     komunikat : string;
begin
     komunikat := 'Damian Skorka, Semestr 1, v.1.0, 2022-01-21';
     Application.MessageBox(Pchar(komunikat),'Informacje o autorze',MB_OK);
end;

end.

