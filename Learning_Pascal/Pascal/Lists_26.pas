Program Lists_26;
Uses myIntegerList; //подключение собственноручно созданного модуля
Type lPoint = ^lLists;
     nonNegativeNumber = 0..Integer.MaxValue;//неотрицательное множесвто целых чисел
     lLists = record
     info: ^oList;
     next: lPoint;
     end;
Var lHead,lTail:lPoint; //глобальные указатели

Procedure getList(i:integer);//получение данных об одном списке
var y:lPoint;
    count:nonNegativeNumber;
begin
    new(y);
    WriteLn('Введите количество чисел в ',i,' - ом списке');
    ReadLn(count);
    y^.info:=myIntegerList.getOList(count);//получение данных для односвязного списка
    if lHead = nil then begin
        lHead:=y;
        lTail:=y;
    end
    else begin
        lTail^.next:=y;
        lTail:=y;
    end;
end;

Procedure getListOfLists();//получение данных о списке списков
var i,n:nonNegativeNumber;
    x:integer;
begin
    WriteLn('Введите количество списков в списке');
    ReadLn(n);
    for i:=1 to n do begin
        WriteLn('Ввод данных ',i,' - го списка');
        getList(i);//получение данных об одном списке
    end;
end;

Function isEmpty():boolean;//проверка на пустоту списка
begin
    isEmpty:=lHead = nil;
end;

Function getLength():integer;//возвращает количество списков
var count:integer;
    metk:lPoint;
begin
    if isEmpty() then count:=0
    else begin
        metk:=lHead;
        while metk<>nil do begin
            count+=1;
            metk:=metk^.next;
        end;
    end;
    getLength:=count;
end;

Procedure printList();//вывод элементов списка списков
var lQ:lPoint;
    pQ:oPoint;
begin
    lQ:=lHead;
    while lQ<>nil do begin
        pQ:=lQ^.info;
        while pQ<>nil do begin
            Write(pQ^.info,' ');
            pQ:=pQ^.next;
        end;
        lQ:=lQ^.next;
    end;
    WriteLn();
end;

Procedure initSort(var metk:lPoint;var last:lPoint);//инициализаөия некоторых переменных для сортировки списка списков
begin
    metk:=lHead;
    last:=nil;
end;

Procedure sort();//сортировка списка списков по возрастанию количества элементов в этих списках
var last,metk,dop:lPoint;
    isSorted:boolean;
begin
    isSorted:=false;
    initSort(metk,last);//инициализаөия некоторых переменных для сортировки списка списков
    while not isSorted do begin
        if myIntegerList.getLength(metk^.info)>myIntegerList.getLength(metk^.next^.info) then begin //получение элементов одного односвязного
            dop:=metk^.next;                                                                        //списка
            metk^.next:=metk^.next^.next;
            dop^.next:=metk;
            if last<>nil then last^.next:=dop;
            if lHead = metk then lHead:=dop;
            if lTail = dop then lTail:=dop^.next;
            initSort(metk,last);//инициализаөия некоторых переменных для сортировки списка списков
        end
        else begin
            last:=metk;
            metk:=metk^.next;
            isSorted:=metk^.next = nil;
        end;
    end;
end;

Procedure getUnion(metkOne,metkTwo:lPoint);//объединение двух упорядоченных односвязных списков
begin
    myIntegerList.getUnion(metkOne^.info,metkTwo^.info);//объединение двух упорядоченных односвязных списков в модуле
    metkOne^.info:=myIntegerList.getPHead();//получение указателя-начала нового односвязного списка
end;

Procedure deletePoint(point:lPoint);//удаление указателя
var metk,last:lPoint;
begin
    metk:=lHead;
    last:=nil;
    while metk<>point do begin
        last:=metk;
        metk:=metk^.next;
    end;
    last^.next:=metk^.next;
    dispose(point);
    if lHead = nil then lHead:=last;
    if lTail = nil then lTail:=last^.next;
end;

Procedure getUnionLists();//объединение списков
begin
    while getLength()<>1 do begin //возвращает количество списков
        sort();//сортировка списка списков по возрастанию количества элементов в этих списках
        getUnion(lHead,lHead^.next);//объединение двух упорядоченных односвязных списков
        deletePoint(lHead^.next);//удаление указателя
     end;
end;

Procedure printOneList();//вывод нового упорядоченного списка
var metk:oPoint;
begin
    metk:=lHead^.info;
    while metk<>nil do begin
        Write(metk^.info,' ');
        metk:=metk^.next;
    end;
end;

Begin
    getListOfLists();//получение данных о списке списков
    printList();
    getUnionLists();//объединение списков
    printOneList();//вывод нового упорядоченного списка
End.