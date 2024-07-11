//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit untContador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCounterThread = class(TThread)
  private
    FCount: Integer;
    FLabel: TLabel;
    procedure UpdateLabel;
  protected
    procedure Execute; override;
  public
    constructor Create(ALabel: TLabel);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TCounterThread }

constructor TCounterThread.Create(ALabel: TLabel);
begin
  inherited Create(False);
  FLabel := ALabel;
  FreeOnTerminate := True;
end;

procedure TCounterThread.Execute;
begin
  FCount := 0;
  while not Terminated and (FCount < 100) do
  begin
    Inc(FCount);
    Sleep(100); // Simula uma operação de longa duração
    Synchronize(UpdateLabel); // Atualiza a interface gráfica de forma segura Utilizando Syncronize
    //Você poderia substituir a linha acima pela linha abaixo caso gostaria que a execução fosse enfileirada
    //Queue(UpdateLabel); // Atualiza a interface gráfica de forma segura Utilizando Queue
  end;
end;

procedure TCounterThread.UpdateLabel;
begin
  FLabel.Caption := 'Contagem: ' + IntToStr(FCount);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TCounterThread.Create(Label1);
end;

end.

