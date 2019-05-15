Unit myEdgeList;

Interface

Type pointList = ^edgeList;
     edgeList = record
        nodeOneID: string;
        nodeTwoID: string;
        countNearEdges: integer;
        isMetk: boolean;
        next: pointList;
     end;

Var pListHead: pointList;

Function getNewPointList():pointList;//создание нового указателя-начала списка
Procedure addPointInTail(var pList: pointList; metk: pointList);//добавление указателя в конец списка
Procedure fillList(var pList:pointList; FILE_NAME: string);//заполнение списка данными из файла
Procedure setMetk(var pList: pointList);//отмечаем ребро как пройденное
Procedure setCountNearEdges(var pList: pointList);//нахождение количества соседних рёбер у данного ребра
Function isExistNotMetk(pList: pointList):boolean;//проверка на существование непройденных рёбер
Function isExistMetkPoint(pList: pointList):boolean;//проверка на непройденость ребра
Function getNearNotMetkEdge(pList: pointList; edge:pointList):pointList;//получение указателя на соседнее непройденное ребро
Procedure sortEdgesByCountFromMinToMax(var pList: pointList);//сортировка рёбер по возрастанию количества соседних рёбер
Procedure sortEdgesByCountFromMaxToMin(var pList: pointList);//сортировка рёбер по убыванию количества соседних рёбер
Procedure printList(pList: pointList; FILE_NAME:string);//вывод списка рёбер в файл

Implementation

Procedure initList(var pList: pointList);//инициализация указателя
begin
    new(pList);
    pList^.next:=pList;
end;

Function getNewPointList():pointList;//создание нового указателя-начала списка
begin
    initList(pListHead);
    getNewPointList:=pListHead;
end;

Procedure addTail(var pList: pointList; nodeOneID: string; nodeTwoID: string);//добавление элемента в конец списка
var y: pointList;
begin
    new(y);
    y^.next:=pList^.next;
    pList^.nodeOneID:=nodeOneID;
    pList^.nodeTwoID:=nodeTwoID;
    pList^.countNearEdges:=0;
    pList^.isMetk:=false;
    pList^.next:=y;
    pList:=y;
end;

Function getLastPoint(pList: pointList):pointList;//получение последнего (не считая "болванчика") указателя списка
var metk:pointList;
begin
    metk:=pList^.next;
    While metk^.next<>pList do
        metk:=metk^.next;
    getLastPoint:=metk;
end;

Procedure copyPointDates(var pList: pointList; metk: pointList);//копирование данных одного указателя другим
begin
    pList^.nodeOneID:=metk^.nodeOneID;
    pList^.nodeTwoID:=metk^.nodeTwoID;
    pList^.countNearEdges:=metk^.countNearEdges;
    pList^.isMetk:=metk^.isMetk;
end;

Procedure addPointInTail(var pList: pointList; metk: pointList);//добавление указателя в конец списка
var lastPoint:pointList;
begin
    addTail(pList, metk^.nodeOneID, metk^.nodeTwoID);
    lastPoint:=getLastPoint(pList);
    copyPointDates(lastPoint, metk);
end;

Procedure getParseStr(str: string; var stringOne: string; var stringTwo: string);//парсинг строки в соответствии с задачей

const SPACE = ' ';

var i:integer;

begin
    stringOne:='';
    stringTwo:='';
    i:=1;
    While (i<=length(str)) and (str[i]<>SPACE) do
        i+=1;
    stringOne:=copy(str, 1, i-1);
    stringTwo:=copy(str, i+1, length(str)-i);
end;

Procedure fillList(var pList:pointList; FILE_NAME: string);//заполнение списка данными из файла
var f:text;
    str: string;
    nodeOneID: string;
    nodeTwoID: string;
begin
    Assign(f, FILE_NAME);
    Reset(f);
    While not Eof(f) do begin
        ReadLn(f, str);
        getParseStr(str, nodeOneID, nodeTwoID);
        addTail(pList, nodeOneID, nodeTwoID);
    end;
    Close(f);
end;

Procedure setMetk(var pList: pointList);//отмечаем ребро как пройденное
begin
    pList^.isMetk:=true;
end;

Function isNearEdges(edgeOne: pointList; edgeTwo: pointList):boolean;//проверка - являются ли два ребра соседними
begin
    isNearEdges:=(edgeOne<>edgeTwo) and ((edgeOne^.nodeOneID=edgeTwo^.nodeOneID)or(edgeOne^.nodeOneID=edgeTwo^.nodeTwoID)
    or(edgeOne^.nodeTwoID=edgeTwo^.nodeOneID)or(edgeOne^.nodeTwoID=edgeTwo^.nodeTwoID));
end;

Procedure setCountNearEdges(var pList: pointList);//нахождение количества соседних рёбер у данного ребра
var metkOne:pointList;
    metkTwo:pointList;
begin
    metkOne:=pList^.next;
    While metkOne<>pList do begin
        metkTwo:=metkOne^.next;
        While metkTwo<>pList do begin
            If isNearEdges(metkOne, metkTwo) then begin
                metkOne^.countNearEdges+=1;
                metkTwo^.countNearEdges+=1;
            end;
            metkTwo:=metkTwo^.next;
        end;
        metkOne:=metkOne^.next;
    end;
end;

Function isLess(edgeOne: pointList; edgeTwo: pointList):boolean;//проверка - является ли один элемент списка меньше другого (сравнение по количеству соседних рёбер)
begin
    isLess:=edgeOne^.countNearEdges<edgeTwo^.countNearEdges;
end;

Function isExistNotMetk(pList: pointList):boolean;//проверка на существование непройденных рёбер
var metk:pointList;
    f:boolean;
begin
    metk:=pList^.next;
    f:=not metk^.isMetk;
    While (metk<>pList) and not f do begin
        metk:=metk^.next;
        f:=not metk^.isMetk;
    end;
    isExistNotMetk:=f;
end;

Function isExistMetkPoint(pList: pointList):boolean;//проверка на непройденость ребра
begin
    isExistMetkPoint:=pList^.isMetk;
end;

Function getNearNotMetkEdge(pList: pointList; edge:pointList):pointList;//получение указателя на соседнее непройденное ребро
var metk:pointList;
    f:boolean;
begin
    metk:=pList^.next;
    f:=not isExistMetkPoint(metk) and (edge<>metk) and ((edge^.nodeOneID=metk^.nodeOneID)or(edge^.nodeOneID=metk^.nodeTwoID)
    or(edge^.nodeTwoID=metk^.nodeOneID)or(edge^.nodeTwoID=metk^.nodeTwoID));
    while (metk<>pList) and not f do begin
        metk:=metk^.next;
        f:=not isExistMetkPoint(metk) and (edge<>metk) and ((edge^.nodeOneID=metk^.nodeOneID)or(edge^.nodeOneID=metk^.nodeTwoID)
        or(edge^.nodeTwoID=metk^.nodeOneID)or(edge^.nodeTwoID=metk^.nodeTwoID));
    end;
    getNearNotMetkEdge:=metk;
end;

Procedure exchangePointDates(var pListOne: pointList; var pListTwo: pointList);//обмен данных между двумя элементами списка
var metk:pointList;
begin
    new(metk);
    metk^.nodeOneID:=pListOne^.nodeOneID;
    metk^.nodeTwoID:=pListOne^.nodeTwoID;
    metk^.countNearEdges:=pListOne^.countNearEdges;
    metk^.isMetk:=pListOne^.isMetk;
    pListOne^.nodeOneID:=pListTwo^.nodeOneID;
    pListOne^.nodeTwoID:=pListTwo^.nodeTwoID;
    pListOne^.countNearEdges:=pListTwo^.countNearEdges;
    pListOne^.isMetk:=pListTwo^.isMetk;
    pListTwo^.nodeOneID:=metk^.nodeOneID;
    pListTwo^.nodeTwoID:=metk^.nodeTwoID;
    pListTwo^.countNearEdges:=metk^.countNearEdges;
    pListTwo^.isMetk:=metk^.isMetk;
    dispose(metk);
end;

Procedure sortEdgesByCountFromMinToMax(var pList: pointList);//сортировка рёбер по возрастанию количества соседних рёбер
var metk:pointList;
    lastMetk:pointList;
    f:boolean;
begin
    lastMetk:=pList^.next;
    metk:=lastMetk^.next;
    while metk<>pList do begin
        f:=isLess(metk, lastMetk);
        If f then begin
            exchangePointDates(metk, lastMetk);
            metk:=lastMetk;
            While lastMetk^.next<>metk do
                lastMetk:=lastMetk^.next;
        end;
        If not f or (lastMetk=pList) then begin
            lastMetk:=metk;
            metk:=metk^.next;
        end;
    end;
end;

Procedure sortEdgesByCountFromMaxToMin(var pList: pointList);//сортировка рёбер по убыванию количества соседних рёбер
var metk:pointList;
    lastMetk:pointList;
    f:boolean;
begin
    lastMetk:=pList^.next;
    metk:=lastMetk^.next;
    while metk<>pList do begin
        f:=isLess(lastMetk, metk);
        If f then begin
            exchangePointDates(metk, lastMetk);
            metk:=lastMetk;
            While lastMetk^.next<>metk do
                lastMetk:=lastMetk^.next;
        end;
        If not f or (lastMetk=pList) then begin
            lastMetk:=metk;
            metk:=metk^.next;
        end;
    end;
end;

Procedure printList(pList: pointList; FILE_NAME:string);//вывод списка рёбер в файл
var f:text;
    metk:pointList;
begin
    metk:=pList^.next;
    Assign(f,FILE_NAME);
    Rewrite(f);
    While metk<>pList do begin
        WriteLn(f,metk^.nodeOneID,' ',metk^.nodeTwoID);
        metk:=metk^.next;
    end;
    Close(f);
end;

Initialization

End.