Unit myAlphavitList;

Interface

Uses myAlphavitTypes;

Function getPHead():listPoint;
Function getPTail():listPoint;
Function getWord(point:listPoint):oneWord;
Procedure cleanList(var point:listPoint);
Procedure addQueue(point:queuePoint);
Procedure printList(point:listPoint);
Procedure add(str:oneWord);

Implementation

Uses myAlphavitQueue;
Var pHead, pTail: listPoint;

Function isEmpty(pHead:listPoint):boolean;//проверка - список пустой
begin
    isEmpty:=pHead = nil;
end;

Procedure add(str:oneWord);//ввод элемента в конец списка
var y:listPoint;
begin
    new(y);
    y^.info:=str;
    if isEmpty(pHead) then begin
        pHead:=y;
        pTail:=y;
    end
    else begin
        pTail^.next:=y;
        pTail:=y;
    end;
end;

Procedure initPoints();//инициализация указателей
begin
    pHead:=nil;
    pTail:=nil;
end;

Function getPHead():listPoint;//возвращает указатель начала
begin
    getPHead:=pHead;
end;

Function getPTail():listPoint;//возвращает указатель конца
begin
    getPTail:=pTail;
end;

Function getWord(point:listPoint):oneWord;//возвращает слово из списка
begin
    getWord:=point^.info;
end;

Procedure addQueue(point:queuePoint);//добавление очереди в список
begin
    While not myAlphavitQueue.isEmpty(point) do begin
        add(point^.info);
        point:=point^.next;
    end;
end;

Procedure cleanMainList();//очиска внутреннего списка
var metk:listPoint;
begin
    metk:=pHead;
    while not isEmpty(pHead) do begin
        dispose(pHead);
        metk:=metk^.next;
        pHead:=metk;
    end;
end;

Procedure cleanList(var point:listPoint);//очистка очереди
var metk:listPoint;
begin
    cleanMainList();
    metk:=point;
    while not isEmpty(metk) do begin
        dispose(point);
        metk:=metk^.next;
        point:=metk;
    end;
end;

Procedure printList(point:listPoint);//вывод данных листа
begin
    WriteLn();
    While not isEmpty(point) do begin
        WriteLn(point^.info);
        point:=point^.next;
    end;
end;

Initialization
    initPoints();
End.