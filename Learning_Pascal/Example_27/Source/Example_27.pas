Unit Example_27;

Interface

Procedure inputDates();
Procedure sortDates();
Procedure outputDates();

Implementation

Uses myAlphavitList;
Uses myAlphavitQueue;
Uses myAlphavitTypes;

Type wordLength = 1..Integer.MaxValue;
     queueArray = array[MIN_ELEMENT..MAX_ELEMENT]of queuePoint;
Var i:integer;
    pTail,pHead: listPoint;
    wordQueue: queueArray;

Procedure inputList();//���� ������
var i,n:integer;
    str:oneWord;
begin
    WriteLn('������� ���� � ������?');
    ReadLn(n);
    for i:=1 to n do begin
        WriteLn('������� ',i,' - �� �����');
        ReadLn(str);
        myAlphavitList.add(str);
    end;
end;

Procedure inputDates(); //���� ������
begin
    WriteLn('������� i');
    ReadLn(i);
    InputList();
end;

Procedure initWordQueue();// ������������� �������� (�� ����������);
var i:element;
begin
    for i:=MIN_ELEMENT to MAX_ELEMENT do
        wordQueue[i]:=nil;
end;

Function isExistElement(i:integer):boolean;//������������� ��������
begin
    isExistElement:= i>0;
end;

Procedure initListPoints();//������������� ���������� ������
begin
    pHead:=myAlphavitList.getPHead();
    pTail:=myAlphavitList.getPTail();
end;

Function isEmptyList(point:listPoint):boolean;//������ �� ���������
begin
    isEmptyList:=point = nil;
end;

Function isContainIndex(str:oneWord; i:integer):boolean;//�������� �� ������ ������� ��������
begin
    isContainIndex:=length(str)>=i;
end;

Function isAlphavitElement(str:oneWord; i:integer):boolean;//���������� �� ������� ������
begin
    isAlphavitElement:=(str[i] >= MIN_ELEMENT) and (str[i]<=MAX_ELEMENT);
end;

Procedure fillQueues(i:integer);//���������� ��������
var str:oneWord;
begin
    initListPoints();
    While not isEmptyList(pHead) do begin
        str:=myAlphavitList.getWord(pHead);
        If isContainIndex(str, i) then begin
            If isAlphavitElement(str, i) then myAlphavitQueue.add(wordQueue[str[i]], str);
        end;
        pHead:=pHead^.next;
    end;
end;

Procedure unionQueues();//����������� ��������
var c:element;
begin
    myAlphavitList.cleanList(pHead);
    for c:=MIN_ELEMENT to MAX_ELEMENT do
        myAlphavitList.addQueue(wordQueue[c]);
        myAlphavitQueue.cleanQueue(wordQueue[c]);
end;

Procedure sortRealization(i:integer);//��������� ���������� ����������
begin
    if isExistElement(i) then begin
        initWordQueue();
        fillQueues(i);
        unionQueues();
        i -= 1;
        sortRealization(i);
    end
    else initListPoints();
end;

Procedure sortDates();// ���������� ������
begin
    sortRealization(i);
end;

Procedure outputDates();//����� ������
begin
    myAlphavitList.printList(pHead);
end;

Initialization

End.