Unit Example_9_Test;

Interface

Procedure getDates();

Implementation

Uses myStek;

Const OPEN_ROUND_BRACKET = '(';
      CLOSE_ROUND_BRACKET = ')';
      OPEN_SQUARE_BRACKET = '[';
      CLOSE_SQUARE_BRACKET = ']';

Var f:text;
    fileName:string;
    symb:element;
    openRoundBracketStek, openSquareBracketStek: stekPoint;
    position:integer;
    collisionPosition:boolean;

Procedure setCollisionPosition(symb:element; position:integer);
begin
    collisionPosition:= true;
    if (symb = CLOSE_ROUND_BRACKET) and not isEmpty(openSquareBracketStek) then begin
        collisionPosition:=(position > openSquareBracketStek^.info);
    end;
    if (symb = CLOSE_SQUARE_BRACKET) and not isEmpty(openRoundBracketStek) then begin 
        collisionPosition:=(position > openRoundBracketStek^.info);
    end;
end;

Function getCollisionPosition():boolean;
begin
    getCollisionPosition:=collisionPosition;
end;

Function emptyStek():boolean;
begin
    emptyStek:=empty or not getCollisionPosition();
end;

Procedure initDates();
begin
    empty:=false;
    collisionPosition:=true;
end;

Function getSymb(var f:text):element;
var c:element;
begin
    If Eoln(f) and not Eof(f) then ReadLn(f);
    Read(f,c);
    getSymb:=c;
end;

Procedure getException();
begin
    WriteLn('Неправильный ввод данных');
end;

Function isCloseBracket(symb:element):boolean;
begin
    isCloseBracket:= (symb = CLOSE_ROUND_BRACKET) or (symb = CLOSE_SQUARE_BRACKET);
end;

Procedure getDates();
begin
    initDates();
    WriteLn('Введите полный путь файла');
    ReadLn(fileName);
    Assign(f,fileName);
    Reset(f);
    position:=1;
    While not Eof(f) and not emptyStek() do begin
        symb := getSymb(f);
        if symb = OPEN_ROUND_BRACKET then add(openRoundBracketStek,position);
        if symb = OPEN_SQUARE_BRACKET then add(openSquareBracketStek,position);
        if symb = CLOSE_ROUND_BRACKET then pop(openRoundBracketStek);
        if symb = CLOSE_SQUARE_BRACKET then pop(openSquareBracketStek);
        setCollisionPosition(symb,openPosition);
        if isCloseBracket(symb) and not emptyStek() then Write(openPosition,' ',position,' ');
        position+=1;
    end;
    if not Eof(f) and emptyStek() then getException();
    Close(f);
end;

Initialization

end.