Unit myIntegerList;
Interface
Type oList = record
     info:integer;
     next:^oList;
     end;
     oPoint = ^oList;
     nonNegativeNumber = 0..Integer.MaxValue;//��������� ��������������� ����� �����
Var  pHead,pTail:oPoint;//���������� ���������� - ��������� ������ � �����
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
Procedure add(x:integer);//���������� �������� � ����� ������
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

Procedure init();//������������ - ��������� ���������� ������ � �����
begin
    pHead:=nil;
    pTail:=nil;
end;

Function getOList(count:integer):oPoint;//��������� ������ �� ����������� ������
var newPoint:oPoint;
    i:nonNegativeNumber;
    x:integer;
begin
    new(newPoint);
    init();//������������ - ��������� ���������� ������ � �����
    for i:=1 to count do begin
        WriteLn('������� ',i,' - �� �������');
        ReadLn(x);
        add(x);//���������� �������� � ����� ������
    end;
    newPoint:=pHead;
    getOList:=newPoint;
end;

Function getLength(oHead:oPoint):integer;//���������� ���������� ��������� � ������
var count:integer;
begin
    count:=0;
    while oHead<>nil do begin
        count+=1;
        oHead:=oHead^.next;
    end;
    getLength:=count;
end;

Procedure getUnion(headOne:oPoint;headTwo:oPoint);//������������� ����������� ���� ������� � ������ (�� ����� �������� ������ ������
var isNull:boolean;                               //� �������� ���� �������)
    metk:oPoint;
begin
    init();
    isNull:=(headOne = nil) or (headTwo = nil);
    while not isNull do begin
        if headOne^.info>headTwo^.info then begin
            add(headTwo^.info);//���������� �������� � ����� ������
            metk:=headTwo;
            headTwo:=headTwo^.next;
            dispose(metk);
        end
        else begin
            add(headOne^.info);//���������� �������� � ����� ������
            metk:=headOne;
            headOne:=headOne^.next;
            dispose(metk);
        end;
        isNull:=(headOne = nil) or (headTwo = nil);
    end;
    while headOne<>nil do begin
            add(headOne^.info);//���������� �������� � ����� ������
            metk:=headOne;
            headOne:=headOne^.next;
            dispose(metk);
    end;
    while headTwo<>nil do begin
            add(headTwo^.info);//���������� �������� � ����� ������
            metk:=headTwo;
            headTwo:=headTwo^.next;
            dispose(metk);
    end;
end;

Function getPHead():oPoint;//���������� ��������� ������ ������
begin
    getPHead:=pHead;
end;

Procedure printList();//����� ��������� ����������������� ������
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