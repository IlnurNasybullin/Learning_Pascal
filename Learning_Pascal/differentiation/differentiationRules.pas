Unit differentiationRules;

Interface

Uses dates;

Procedure differentiation(var rootAFT: pointAFT; var rootDFT: pointDFT);

Implementation

Uses DFTree;

Procedure differentiationMultiplication(var node: pointDFT);//дифференцирование умножения
var x,y:pointDFT;
begin
    new(x);
    x^.info:=MULTIPLICATION;
    copyTreeDFT(x^.left, node^.left);//копирование одного DFT-дерева в другое
    copyTreeDFT(x^.right, node^.right);
    x^.isDif:=true;
    new(y);
    y^.info:=MULTIPLICATION;
    copyTreeDFT(y^.left, node^.left);
    copyTreeDFT(y^.right, node^.right);
    y^.isDif:=true;
    isDifferentiationNode(x^.right);//поддерево отмечается как продифференцированное
    isDifferentiationNode(y^.left);
    node^.info:=PLUS;
    node^.isDif:=true;
    deleteNodeDFT(node^.left);//удаление узла (очистка памяти)
    deleteNodeDFT(node^.right);
    node^.left:=x;
    node^.right:=y;
end;

Procedure differentiationDivision(var node: pointDFT);//дифференцирование деления
var x,y,z,f,a:pointDFT;
begin
    new(a);
    a^.info:=SQUARE;
    a^.isDif:=true;
    a^.left:=nil;
    a^.right:=nil;
    new(x);
    x^.info:=MULTIPLIcATION;
    x^.isDif:=true;
    copyTreeDFT(x^.left, node^.left);
    copyTreeDFT(x^.right, node^.right);
    isDifferentiationNode(x^.right);
    new(y);
    y^.info:=MULTIPLICATION;
    y^.isDif:=true;
    copyTreeDFT(y^.left, node^.left);
    copyTreeDFT(y^.right, node^.right);
    isDifferentiationNode(y^.left);
    new(z);
    z^.info:=MINUS;
    z^.isDif:=true;
    z^.left:=x;
    z^.right:=y;
    new(f);
    f^.info:=EXPONENTATION;
    f^.isDif:=true;
    copyTreeDFT(f^.left, node^.right);
    f^.right:=a;
    isDifferentiationNode(f^.left);
    node^.isDif:=true;
    deleteNodeDFT(node^.left);
    deleteNodeDFT(node^.right);
    node^.left:=z;
    node^.right:=f;
end;

Procedure differentiationExponentiation(var node: pointDFT);//дифференцирование показательно-степенной функции
var x,y,z:pointDFT;
begin
    new(x);
    x^.info:=LOGARITHM;
    x^.isDif:=false;
    copyTreeDFT(x^.left, node^.left);
    x^.right:=nil;
    new(y);
    y^.info:=MULTIPLICATION;
    y^.isDif:=false;
    copyTreeDFT(y^.left, node^.right);
    y^.right:=x;
    new(z);
    z^.info:=EXPONENTATION;
    z^.isDif:=true;
    copyTreeDFT(z^.left, node^.left);
    copyTreeDFT(z^.right, node^.right);
    isDifferentiationNode(z);
    node^.info:=MULTIPLICATION;
    node^.isDif:=true;
    deleteNodeDFT(node^.left);
    deleteNodeDFT(node^.right);
    node^.left:=y;
    node^.right:=z;
end;

Procedure differentiationSinus(var node: pointDFT);//дифференцирование синуса
var x:pointDFT;
begin
    new(x);
    x^.info:=COSINUS;
    x^.isDif:=true;
    copyTreeDFT(x^.left, node^.left);
    x^.right:=nil;
    isDifferentiationNode(x);
    node^.info:='*';
    node^.isDif:=true;
    deleteNodeDFT(node^.right);
    node^.right:=x;
end;

Procedure differentiationCosinus(var node: pointDFT);//дифференцирование косинуса
var x,y,z:pointDFT;
begin
    new(z);
    z^.info:=ZERO;
    z^.isDif:=true;
    z^.left:=nil;
    z^.right:=nil;
    new(x);
    x^.info:=SINUS;
    x^.isDif:=true;
    copyTreeDFT(x^.left, node^.left);
    x^.right:=nil;
    isDifferentiationNode(x);
    new(y);
    y^.info:=MINUS;
    y^.isDif:=true;
    y^.right:=x;
    y^.left:=z;
    node^.info:=MULTIPLICATION;
    node^.isDif:=true;
    deleteNodeDFT(node^.right);
    node^.right:=y;
end;

Procedure differentiationTangens(var node: pointDFT);//дифференцирование тангенса
var x,y,z:pointDFT;
begin
    new(x);
    x^.info:=COSINUS;
    x^.isDif:=true;
    copyTreeDFT(x^.left, node^.left);
    x^.right:=nil;
    new(z);
    z^.info:=SQUARE;
    z^.isDif:=true;
    z^.left:=nil;
    z^.right:=nil;
    new(y);
    y^.info:=EXPONENTATION;
    y^.isDif:=true;
    y^.left:=x;
    y^.right:=z;
    node^.info:=DIVISION;
    node^.isDif:=true;
    deleteNodeDFT(node^.right);
    node^.right:=y;
    isDifferentiationNode(node^.right);
end;

Procedure differentiationLogarithm(var node: pointDFT);//дифференцирование логарифма
var x,y:pointDFT;
begin
    new(y);
    y^.info:=CONST_DIF;
    y^.isDif:=true;
    y^.left:=nil;
    y^.right:=nil;
    new(x);
    x^.info:=DIVISION;
    x^.isDif:=true;
    x^.left:=y;
    copyTreeDFT(x^.right, node^.left);
    isDifferentiationNode(x^.right);
    node^.info:=MULTIPLICATION;
    node^.isDif:=true;
    deleteNodeDFT(node^.right);
    node^.right:=x;
end;

Procedure differentiationX(var node: pointDFT);
begin
    node^.info:=CONST_DIF;
    node^.isDif:=true;
end;

Procedure differentiationConst(var node:pointDFT);//дифференцирование числа
begin
    node^.info:=ZERO;
    node^.isDif:=true;
end;

Procedure differentiationRealization(var node: pointDFT);
begin
    if node<>nil then begin
        if not node^.isDif then begin
            case node^.info of
                PLUS, MINUS: node^.isDif:=true;
                MULTIPLICATION: differentiationMultiplication(node);//дифференцирование умножения
                DIVISION: differentiationDivision(node);//дифференцирование деления
                EXPONENTATION: differentiationExponentiation(node);//дифференцирование показательно-степенной функции
                SINUS: differentiationSinus(node);//дифференцирование синуса
                COSINUS: differentiationCosinus(node);//дифференцирование косинуса
                TANGENS: differentiationTangens(node);//дифференцирование тангенса
                LOGARITHM: differentiationLogarithm(node);//дифференцирование логарифма
                'x': differentiationX(node);
                else differentiationConst(node);//дифференцирование числа
            end;
        end;
        differentiationRealization(node^.left);
        differentiationRealization(node^.right);            
    end;
end;

Procedure differentiation(var rootAFT: pointAFT; var rootDFT: pointDFT);//дифференцирование функции (функция-подготовка)
begin
    copyTree(rootDFT, rootAFT);//копирование AFT-дерева в DFT-дерево
    differentiationRealization(rootDFT);//дифференцирование функции (функция-рекурсия)
end;

Initialization

End.