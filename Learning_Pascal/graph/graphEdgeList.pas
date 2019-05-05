Unit graphEdgeList;

Interface

Uses myDates;

Procedure addEdge(ID_one:node_ID; ID_two:node_ID);
Function isExistEdge(ID_one:node_ID; ID_two:node_ID):boolean;
Procedure setCount();
Procedure sortByCount();
Function getEdgeHead():pointEdge;

Implementation

Var edgeHead: pointEdge;

Procedure initEdge();
begin
    new(edgeHead);
    edgeHead^.next:=edgeHead;
end;

Procedure addEdge(ID_one:node_ID; ID_two:node_ID);
var edge:pointEdge;
begin
    new(edge);
    edge^.next:=edgeHead^.next;
    edgeHead^.ID_nodeOne:=ID_one;
    edgeHead^.ID_nodeTwo:=ID_two;
    edgeHead^.count:=0;
    edgeHead^.next:=edge;
    edgeHead:=edge;
end;

Function isExistEdge(ID_one:node_ID; ID_two:node_ID):boolean;
var metk: pointEdge;
    f:boolean;
begin
    f:=false;
    metk:=edgeHead^.next;
    While not f and (metk<>edgeHead) do begin
        f:=(metk^.ID_nodeOne = ID_one) and (metk^.ID_nodeTwo = ID_two);
        metk:=metk^.next;
    end;
    isExistEdge:=f;
end;

Procedure setCount();
var edgeSort: pointEdge;
    edge: pointEdge;
begin
    edgeSort:=edgeHead^.next;
    While edgeSort<>edgeHead do begin
        edge:=edgeHead^.next;
        While edge<>edgeHead do begin
            If (edge<>edgeSort) and ((edge^.ID_nodeOne = edgeSort^.ID_nodeOne) or (edge^.ID_nodeOne = edgeSort^.ID_nodeTwo) or 
                                      (edge^.ID_nodeTwo = edgeSort^.ID_nodeOne) or (edge^.ID_nodeTwo = edgeSort^.ID_nodeTwo))
                                      then edge^.count+=1;
            edge:=edge^.next;
        end;
        edgeSort:=edgeSort^.next;
    end;
end;

Function getMaxCountPoint(metk:pointEdge):pointEdge;
var count:integer;
    maxPoint:pointEdge;
begin
    count:=-1;
    maxPoint:=metk;
    While metk<>edgeHead do begin
        if metk^.count>count then begin
            count:=metk^.count;
            maxPoint:=metk;
        end;
        metk:=metk^.next;
    end;
    getMaxCountPoint:=maxPoint;
end;

Procedure exchangeDates(var edgeOne:pointEdge; var edgeTwo:pointEdge);
var x:node_ID;
    y:integer;
begin
    x:=edgeOne^.ID_nodeOne;
    edgeOne^.ID_nodeOne:=edgeTwo^.ID_nodeOne;
    edgeTwo^.ID_nodeOne:=x;
    x:=edgeOne^.ID_nodeTwo;
    edgeOne^.ID_nodeTwo:=edgeTwo^.ID_nodeTwo;
    edgeTwo^.ID_nodeTwo:=x;
    y:=edgeOne^.count;
    edgeOne^.count:=edgeTwo^.count;
    edgeTwo^.count:=y;
end;

Procedure sortByCount();
var metk:pointEdge;
    maxCountPoint:pointEdge;
begin
    metk:=edgeHead^.next;
    maxCountPoint:=nil;
    While metk<>edgeHead do begin
        maxCountPoint:=getMaxCountPoint(metk);
        exchangeDates(maxCountPoint,metk);
        metk:=metk^.next;
    end;
end;

Function getEdgeHead():pointEdge;
begin
    getEdgeHead:=edgeHead;
end;

Initialization
    initEdge();
End.