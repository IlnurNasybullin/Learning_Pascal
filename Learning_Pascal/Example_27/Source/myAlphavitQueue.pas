Unit myAlphavitQueue;

Interface

Uses myAlphavitTypes;
Var  qHead: queuePoint;

Function isEmpty(point:queuePoint):boolean;
Procedure add(var point:queuePoint;str:oneWord);
Procedure cleanQueue(var point:queuePoint);

Implementation

Function isEmpty(point:queuePoint):boolean;//остутсвует ли указатель
begin
    isEmpty:= point = nil;
end;

Procedure add(var point:queuePoint;str:oneWord);//добавление слова в очередь
var y,metk:queuePoint;
begin
    new(y);
    y^.info := str;
    if isEmpty(point) then point:=y
    else begin
        metk:=point;
        while not isEmpty(metk^.next) do
            metk:=metk^.next;
        metk^.next:=y;
    end;
end;

Procedure initPoint();//инициализация указателя начала
begin
    qHead:=nil;
end;

Procedure cleanQueue(var point:queuePoint);//очистка очереди
var metk:queuePoint;
begin
    metk:=point;
    while not isEmpty(metk) do begin
        dispose(point);
        metk:=metk^.next;
        point:=metk;
    end;
end;

Initialization
    initPoint();
End.