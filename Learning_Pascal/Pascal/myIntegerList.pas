Unit myIntegerList;
Interface
Type oList = record
     info:integer;
     next:^oList;
     end;
     oPoint = ^oList;
     nonNegativeNumber = 0..Integer.MaxValue;//множество неотрицательных целых чисел
Var  pHead,pTail:oPoint;//глобальные переменные - указатели начала и конца
     i:integer;
     x:integer;

Procedure add(x:integer);
Procedure init;
Function getOList(count:integer):oPoint;
Function getLength(oHead:oPoint):integer;
Procedure getUnion(headOne:oPoint;headTwo:oPoint);
Function getPHead:oPoint;
Procedure printList;

Implementation    
Procedure add(x:integer);//добавление элемента в конец списка
var y:oPoint;
begin
    new(y);
    y^.info:=x;
    if pHead = nil then begin
        pHead:=y;
        pTail:=y;
    end
    else begin
        pTail^.next:=y;
        pTail:=y;
    end;
end;

Procedure init();//иницализация - обнуление указателей начала и конца
begin
    pHead:=nil;
    pTail:=nil;
end;

Function getOList(count:integer):oPoint;//получение данных об односвязном списке
var newPoint:oPoint;
    i:nonNegativeNumber;
    x:integer;
begin
    new(newPoint);
    init();//иницализация - обнуление указателей начала и конца
    for i:=1 to count do begin
        WriteLn('Введите ',i,' - ый элемент');
        ReadLn(x);
        add(x);//добавление элемента в конец списка
    end;
    newPoint:=pHead;
    getOList:=newPoint;
end;

Function getLength(oHead:oPoint):integer;//возвращает количество элементов в списке
var count:integer;
begin
    count:=0;
    while oHead<>nil do begin
        count+=1;
        oHead:=oHead^.next;
    end;
    getLength:=count;
end;

Procedure getUnion(headOne:oPoint;headTwo:oPoint);//упорядоченное объединение двух списков в списке (по факту создание одного списка
var isNull:boolean;                               //и удаление двух прежних)
    metk:oPoint;
begin
    init();
    isNull:=(headOne = nil) or (headTwo = nil);
    while not isNull do begin
        if headOne^.info>headTwo^.info then begin
            add(headTwo^.info);//добавление элемента в конец списка
            metk:=headTwo;
            headTwo:=headTwo^.next;
            dispose(metk);
        end
        else begin
            add(headOne^.info);//добавление элемента в конец списка
            metk:=headOne;
            headOne:=headOne^.next;
            dispose(metk);
        end;
        isNull:=(headOne = nil) or (headTwo = nil);
    end;
    while headOne<>nil do begin
            add(headOne^.info);//добавление элемента в конец списка
            metk:=headOne;
            headOne:=headOne^.next;
            dispose(metk);
    end;
    while headTwo<>nil do begin
            add(headTwo^.info);//добавление элемента в конец списка
            metk:=headTwo;
            headTwo:=headTwo^.next;
            dispose(metk);
    end;
end;

Function getPHead():oPoint;//возвращает указатель начала списка
begin
    getPHead:=pHead;
end;

Procedure printList();//вывод элементов однонаправленного списка
var metk:oPoint;
begin
    metk:=pHead;
    while metk<>nil do begin
        Write(metk^.info,' ');
        metk:=metk^.next;
    end;
end;

Initialization
end.