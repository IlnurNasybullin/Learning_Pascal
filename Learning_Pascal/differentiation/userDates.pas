Unit userDates;

Interface

Procedure getDates();

Implementation

Uses dates;
Uses AFTree;
Uses differentiationRules;
Uses simpleficationRules;
Uses DFTree;

Var func: string;
    rootAFT: pointAFT;
    rootDFT: pointDFT;
    difFunc: string;

Function isCorrect(func: string):boolean;//проверка на правильность введённой функции
begin
    isCorrect:=true;//по дефолту считаем правильной
end;

Procedure addInTreeRealization(func: string; priority:integer; var node: pointAFT);//добавление в дерево (функция - рекурсия)

var isFound:boolean;
    i:integer;
    openBracketsCount:integer;
    exprOne: string;
    exprTwo: string;

begin
    isFound:=false;
    i:=1;
    openBracketsCount:=0;
    while (i<=length(func)) and not isFound do begin
        if func[i]=OPEN_BRACKET then openBracketsCount+=1;
        if func[i]=CLOSE_BRACKET then openBracketsCount-=1;
        if (func[i] in mathsSymbolsArray[priority]) and (openBracketsCount = 0) then begin
            add(node, func[i]);//добавление в AFT-дерево
            exprOne:=copy(func, 1, i-1);
            exprTwo:=copy(func, i+1, length(func) - i);
            addInTreeRealization(exprOne, FIRST_PRIORITY, node^.left);
            addInTreeRealization(exprTwo, FIRST_PRIORITY, node^.right);
            isFound:=true;
        end;
        i+=1;
    end;
    if not isFound then begin
        if priority<SPECIAL_FUNCTIONS then addInTreeRealization(func, priority+1, node)
        else begin
            if length(func)>0 then begin
                if (func[1]=OPEN_BRACKET) and (func[length(func)] = CLOSE_BRACKET) then begin
                    simpleficationFunction(func);//удаление крайних скобок в функции
                    addInTreeRealization(func,1,node);
                end
                else if length(func)=1 then add(node, func[1]);
            end;
        end;
    end;
end;

Procedure addInTree(func:string);//добавление в дерево (функция - подготовка к рекурсии)
begin
    addInTreeRealization(func, FIRST_PRIORITY, rootAFT);//добавление в дерево (функция - рекурсия)
end;

Procedure getException();//выкидаем ошибку (по дефолту - никогда)
begin
    WriteLn('Error!');
end;

Procedure getDates();//получение данных (функции) от пользователя
begin
    deleteNodeAFT(rootAFT);
    deleteNodeDFT(rootDFT);
    difFunc:='';
    WriteLn('Введите дифференцируемую функцию: ');
    ReadLn(func);
    If isCorrect(func) then addInTree(func)
    else getException();
    differentiation(rootAFT, rootDFT);//дифференцирование функции
    simplefication(rootDFT);//упрощение продифференцированной функции
    setDifFunc(rootDFT, difFunc);//запись продифференцированной функции
    simpleficationFunction(difFunc);
    WriteLn(difFunc);
end;

Initialization

End.