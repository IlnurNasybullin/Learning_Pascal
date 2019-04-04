Unit menu;

Interface

Procedure initMenu();

Implementation

Uses myBinaryTree;
Uses myDates;

Var i:integer;
    rootTree: pointTree;

Procedure initMenu();
var exitMenu:boolean;
    symb:char;
begin
    exitMenu:=false;
    while not exitMenu do begin
        WriteLn('Меню команды для бинарного дерева:',#10,
            '1 - Добавить элемент в дерево',#10,
            '2 - Удалить элемент из дерева',#10,
            '3 - Обход дерева КЛП',#10,
            '4 - Прямой обход дерева',#10,
            '5 - Обратный обход дерева',#10,
            '6 - Горизонтальный обход дерева',#10,
            '0 - Выход',#10);
        ReadLn(symb);
        case symb of
           '1': addToTree(rootTree);
           '2': delete(rootTree);
           '3': RootLeftRight(rootTree);
           '4': LeftRootRight(rootTree);
           '5': RightRootLeft(rootTree);
           '6': horyzontalBypass(rootTree);
           '0': exitMenu:=true;
          else WriteLn('Такой команды нет');
        end;
        WriteLn();
    end;
end;

Initialization

End.