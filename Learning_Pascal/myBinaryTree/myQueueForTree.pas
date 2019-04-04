Unit myQueueForTree;

Interface

Uses myDates;

Type pointQueue = ^treeQueue;
     treeQueue = record
        info: pointTree;
        next: pointQueue;
     end;

Var headQueue: pointQueue;

Procedure addToQueue(var point: pointQueue; x: pointTree);
Function isEmptyPointQueue(point: pointQueue):boolean;
Function queuePop(var point: pointQueue):pointTree;

Implementation

Procedure initHeadQueue(var point: pointQueue);
begin
    new(point);
    point^.next:=point;
end;

Procedure addToQueue(var point: pointQueue; x: pointTree);
var y:pointQueue;
begin
    point^.info:=x;
    new(y);
    y^.next:=point^.next;
    point^.next:=y;
    point:=y;
end;

Function isEmptyPointQueue(point: pointQueue):boolean;
begin
    isEmptyPointQueue:=point=point^.next;
end;

Function queuePop(var point: pointQueue):pointTree;
var metk: pointQueue;
    info: pointTree;
begin
    metk:=point^.next;
    info:=metk^.info;
    point^.next:=metk^.next;
    dispose(metk);
    queuePop:=info;
end;

Initialization
    initHeadQueue(headQueue);
End.