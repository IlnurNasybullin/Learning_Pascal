Unit dates;

Interface

Const FIRST_PRIORITY = 1;
      SECOND_PRIORITY = 2;
      THIRD_PRIORITY = 3;
      SPECIAL_FUNCTIONS = 4;
      
      PLUS = '+';
      MINUS = '-';
      
      MULTIPLICATION = '*';
      DIVISION = '/';
      
      EXPONENTATION = '^';
      
      SINUS = 's';
      COSINUS = 'c';
      TANGENS = 't';
      LOGARITHM = 'L';
      EXPONENTA = 'e';
      
      SQUARE = '2';
      ZERO = '0';
      CONST_DIF = '1';
      
      OPEN_BRACKET = '(';
      CLOSE_BRACKET = ')';

Type pointAFT = ^AFT;
     mathsSymbol = char;
     mathsSymbolsSet = set of mathsSymbol;
     AFT = record
        info: mathsSymbol;
        left: pointAFT;
        right: pointAFT;
     end;

    pointDFT  = ^DFT;
    DFT = record
        info: mathsSymbol;
        isDif: boolean;
        left: pointDFT;
        right: pointDFT;
    end;
    
Var mathsSymbolsArray: array[FIRST_PRIORITY..SPECIAL_FUNCTIONS] of mathsSymbolsSet;    

Implementation

Procedure initFirstPriority();//������������� �������� ������� ���������� (������ ��������)
begin
    mathsSymbolsArray[FIRST_PRIORITY] += [PLUS];
    mathsSymbolsArray[FIRST_PRIORITY] += [MINUS];
end;

Procedure initSecondPriority();//������������� �������� ������� ��������� (������� ��������)
begin
    mathsSymbolsArray[SECOND_PRIORITY] += [MULTIPLICATION];
    mathsSymbolsArray[SECOND_PRIORITY] += [DIVISION];
end;

Procedure initThirdPriority();//������������� �������� �������� ���������� (������� ��������)
begin
    mathsSymbolsArray[THIRD_PRIORITY] += [EXPONENTATION];
end;

Procedure initSpecialFunctions();//������������� ����������� �������������� ������� (��������� ��������)
begin
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [SINUS];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [COSINUS];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [TANGENS];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [LOGARITHM];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [EXPONENTA];
end;

Procedure initMathsSymbolsArray();//���������� ������� �������� ������������� ��������
begin
    initFirstPriority();//������������� �������� ������� ���������� (������ ��������)
    initSecondPriority();//������������� �������� ������� ��������� (������� ��������)
    initThirdPriority();//������������� �������� �������� ���������� (������� ��������)
    initSpecialFunctions();//������������� ����������� �������������� ������� (��������� ��������)
end;

Initialization
    initMathsSymbolsArray();//���������� ������� �������� ������������� ��������
End.