Unit simpleficationRules;

Interface

Uses dates;

Procedure simplefication(var rootDFT: pointDFT);
Procedure simpleficationFunction(var func:string);

Implementation

Uses DFTree;

Function isTerm(node: pointDFT):boolean;//проверка узла на вычисляемость
var i:integer;
    f:boolean;
begin
    f:=true;
    i:=FIRST_PRIORITY;
    while (i<=THIRD_PRIORITY) and f do begin
        f:=not (node^.info in mathsSymbolsArray[i]);
        i+=1;
    end;
    isTerm:=f;
end;

Procedure simpleficationDelete(var node:pointDFT);//удаление узла с проверкой
var isT:boolean;
    i:integer;
begin
    isT:=false;
    i:=1;
    while not isT and (i<=SPECIAL_FUNCTIONS) do begin
        isT:=node^.info in mathsSymbolsArray[i];
        i+=1;
    end;
    if not isT then begin
        deleteNodeDFT(node^.left);
        deleteNodeDFT(node^.right);
    end
    else begin
        if node^.info=node^.left^.info then copyTreeDFT(node, node^.left)
        else copyTreeDFT(node, node^.right);
    end;
end;

Procedure simpleficationSum(var node: pointDFT);//упрощение суммы
begin
    if node^.left^.info=ZERO then begin
        node^.info:=node^.right^.info;
        simpleficationDelete(node);
    end
    else if node^.right^.info=ZERO then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end;
end;

Procedure simpleficationSubtract(var node: pointDFT);//упрощение разности
begin
    if node^.right^.info=ZERO then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end
    else if node^.left^.info=ZERO then deleteNodeDFT(node^.left);
end;

Procedure simpleficationMultiplication(var node: pointDFT);//упрощение умножения
begin
    if (node^.left^.info=ZERO) or (node^.right^.info=ZERO) then begin
        node^.info:=ZERO;
        simpleficationDelete(node);
    end
    else if node^.left^.info=CONST_DIF then begin
        node^.info:=node^.right^.info;
        simpleficationDelete(node);
    end
    else if node^.right^.info=CONST_DIF then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end;
end;

Procedure simpleficationDivision(var node: pointDFT);//упрощение деления
begin
    if node^.left^.info=ZERO then begin
        node^.info:=ZERO;
        simpleficationDelete(node);
    end
    else if node^.right^.info=CONST_DIF then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end;
end;

Procedure simpleficationExponentiation(var node: pointDFT);//упрощение экспоненцирования
begin
    if (node^.left^.info<>ZERO) and (node^.right^.info<>ZERO) then begin
        if node^.left^.info=ZERO then begin
            node^.info:=ZERO;
            simpleficationDelete(node);
        end
        else if (node^.right^.info=ZERO) or (node^.left^.info=CONST_DIF) then begin
            node^.info:=CONST_DIF;
            simpleficationDelete(node);
        end
        else if node^.right^.info=CONST_DIF then begin
            node^.info:=node^.left^.info;
            simpleficationDelete(node);
        end;
    end;
end;

Procedure simpleficationRealization(var node: pointDFT);//упрощение функции (функция - рекурсия)
begin
    if not isTerm(node^.left) then simpleficationRealization(node^.left);
    if not isTerm(node^.right) then simpleficationRealization(node^.right);
    if isTerm(node^.left) or isTerm(node^.right) then begin
        case node^.info of
            PLUS: simpleficationSum(node);//упрощение суммы
            MINUS: simpleficationSubtract(node);//упрощение разности
            MULTIPLICATION: simpleficationMultiplication(node);//упрощение умножения
            DIVISION: simpleficationDivision(node);//упрощение деления
            EXPONENTATION: simpleficationExponentiation(node);//упрощение экспоненцирования
        end;
    end;
end;

Procedure simplefication(var rootDFT: pointDFT);//упрощение функции (функция-подготовка)
begin
    simpleficationRealization(rootDFT);//упрощение функции (функция - рекурсия)
end;

Procedure simpleficationFunction(var func:string);//удаление крайних скобок в функции
begin
    delete(func,1,1);
    delete(func,length(func),1);
end;

Initialization

End.