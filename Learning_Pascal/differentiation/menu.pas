Unit menu;

Interface

Procedure startMenu();

Implementation

Uses userDates;

Var ex:boolean;

Procedure getMenu();//����� ���� �� �����
var i:char;
begin
    Write('��� �� ������ �������?',#10,
            '1 - ������ ������� ��� � ����������� �����������������',#10,
            '0 - ����� �� ���������',#10,
            '������� �������: ');
    Readln(i);
    case i of
        '1': getDates();//��������� ������ (�������)
        '0': ex:=true;
        else WriteLn('������! ����� ������� �� ����������!');
    end;
end;

Procedure startMenu();//����� ���� (���������� ��������)
begin
    ex:=false;
    while not ex do begin
        getMenu();
    end;
end;

Initialization

End.