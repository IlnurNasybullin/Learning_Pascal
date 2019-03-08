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

Function isEmpty(pHead:listPoint):boolean;//�������� - ������ ������
begin
    isEmpty:=pHead = nil;
end;

Procedure add(str:oneWord);//���� �������� � ����� ������
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

Procedure initPoints();//������������� ����������
begin
    pHead:=nil;
    pTail:=nil;
end;

Function getPHead():listPoint;//���������� ��������� ������
begin
    getPHead:=pHead;
end;

Function getPTail():listPoint;//���������� ��������� �����
begin
    getPTail:=pTail;
end;

Function getWord(point:listPoint):oneWord;//���������� ����� �� ������
begin
    getWord:=point^.info;
end;

Procedure addQueue(point:queuePoint);//���������� ������� � ������
begin
    While not myAlphavitQueue.isEmpty(point) do begin
        add(point^.info);
        point:=point^.next;
    end;
end;

Procedure cleanMainList();//������ ����������� ������
var metk:listPoint;
begin
    metk:=pHead;
    while not isEmpty(pHead) do begin
        dispose(pHead);
        metk:=metk^.next;
        pHead:=metk;
    end;
end;

Procedure cleanList(var point:listPoint);//������� �������
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

Procedure printList(point:listPoint);//����� ������ �����
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