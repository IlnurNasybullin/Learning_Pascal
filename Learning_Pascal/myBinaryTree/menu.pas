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
        WriteLn('���� ������� ��� ��������� ������:',#10,
            '1 - �������� ������� � ������',#10,
            '2 - ������� ������� �� ������',#10,
            '3 - ����� ������ ���',#10,
            '4 - ������ ����� ������',#10,
            '5 - �������� ����� ������',#10,
            '6 - �������������� ����� ������',#10,
            '0 - �����',#10);
        ReadLn(symb);
        case symb of
           '1': addToTree(rootTree);
           '2': delete(rootTree);
           '3': RootLeftRight(rootTree);
           '4': LeftRootRight(rootTree);
           '5': RightRootLeft(rootTree);
           '6': horyzontalBypass(rootTree);
           '0': exitMenu:=true;
          else WriteLn('����� ������� ���');
        end;
        WriteLn();
    end;
end;

Initialization

End.