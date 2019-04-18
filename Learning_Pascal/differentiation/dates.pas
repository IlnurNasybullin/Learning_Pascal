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

Procedure initFirstPriority();//инициализация операций первого приоритета (слабые операции)
begin
    mathsSymbolsArray[FIRST_PRIORITY] += [PLUS];
    mathsSymbolsArray[FIRST_PRIORITY] += [MINUS];
end;

Procedure initSecondPriority();//инициализация операций второго приритета (средние операции)
begin
    mathsSymbolsArray[SECOND_PRIORITY] += [MULTIPLICATION];
    mathsSymbolsArray[SECOND_PRIORITY] += [DIVISION];
end;

Procedure initThirdPriority();//инициализация операций третьего приоритета (сильные операции)
begin
    mathsSymbolsArray[THIRD_PRIORITY] += [EXPONENTATION];
end;

Procedure initSpecialFunctions();//инициализация специальных математических функций (наивысшие операции)
begin
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [SINUS];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [COSINUS];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [TANGENS];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [LOGARITHM];
    mathsSymbolsArray[SPECIAL_FUNCTIONS] += [EXPONENTA];
end;

Procedure initMathsSymbolsArray();//заполнение массива множеств оператических операций
begin
    initFirstPriority();//инициализация операций первого приоритета (слабые операции)
    initSecondPriority();//инициализация операций второго приритета (средние операции)
    initThirdPriority();//инициализация операций третьего приоритета (сильные операции)
    initSpecialFunctions();//инициализация специальных математических функций (наивысшие операции)
end;

Initialization
    initMathsSymbolsArray();//заполнение массива множеств оператических операций
End.