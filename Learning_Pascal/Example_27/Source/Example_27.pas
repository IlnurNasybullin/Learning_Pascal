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

Procedure inputList();//¬вод списка
var i,n:integer;
    str:oneWord;
begin
    WriteLn('—колько слов в списке?');
    ReadLn(n);
    for i:=1 to n do begin
        WriteLn('¬ведите ',i,' - ое слово');
        ReadLn(str);
        myAlphavitList.add(str);
    end;
end;

Procedure inputDates(); //¬вод данных
begin
    WriteLn('¬ведите i');
    ReadLn(i);
    InputList();
end;

Procedure initWordQueue();// инициализаци€ очередей (их указателей);
var i:element;
begin
    for i:=MIN_ELEMENT to MAX_ELEMENT do
        wordQueue[i]:=nil;
end;

Function isExistElement(i:integer):boolean;//существование элемента
begin
    isExistElement:= i>0;
end;

Procedure initListPoints();//инициализаци€ указателей списка
begin
    pHead:=myAlphavitList.getPHead();
    pTail:=myAlphavitList.getPTail();
end;

Function isEmptyList(point:listPoint):boolean;//пустой ли указатель
begin
    isEmptyList:=point = nil;
end;

Function isContainIndex(str:oneWord; i:integer):boolean;//содержит ли строка столько символов
begin
    isContainIndex:=length(str)>=i;
end;

Function isAlphavitElement(str:oneWord; i:integer):boolean;//алфавитный ли элемент строки
begin
    isAlphavitElement:=(str[i] >= MIN_ELEMENT) and (str[i]<=MAX_ELEMENT);
end;

Procedure fillQueues(i:integer);//заполнение очередей
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

Procedure unionQueues();//объединение очередей
var c:element;
begin
    myAlphavitList.cleanList(pHead);
    for c:=MIN_ELEMENT to MAX_ELEMENT do
        myAlphavitList.addQueue(wordQueue[c]);
        myAlphavitQueue.cleanQueue(wordQueue[c]);
end;

Procedure sortRealization(i:integer);//процедура реализации сортировки
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

Procedure sortDates();// —ортировка данных
begin
    sortRealization(i);
end;

Procedure outputDates();//вывод данных
begin
    myAlphavitList.printList(pHead);
end;

Initialization

End.