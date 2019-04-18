Unit menu;

Interface

Procedure startMenu();

Implementation

Uses userDates;

Var ex:boolean;

Procedure getMenu();//вывод меню на экран
var i:char;
begin
    Write('Что вы хотите сделать?',#10,
            '1 - Ввести функцию для её дальнейшего дифференцирования',#10,
            '0 - Выйти из программы',#10,
            'Введите команду: ');
    Readln(i);
    case i of
        '1': getDates();//получение данных (функции)
        '0': ex:=true;
        else WriteLn('Ошибка! Такой команды не обнаружено!');
    end;
end;

Procedure startMenu();//вызов меню (происходит единожды)
begin
    ex:=false;
    while not ex do begin
        getMenu();
    end;
end;

Initialization

End.