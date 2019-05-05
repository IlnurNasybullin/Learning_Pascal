Program graph;

Uses graphEdgeList;
Uses graphEdgeSet;
Uses myDates;

Procedure fillEdges(edgeStr: string; ID_one:node_ID);
const IS_EDGE = '1';
      IS_NOT_EDGE = '0';
var i:integer;
    ID_two:node_ID;
begin
    ID_two:=1;
    For i:=1 to length(edgeStr) do begin
        If (edgeStr[i] = IS_EDGE) and not isExistEdge(ID_two, ID_one) then addEdge(ID_one, ID_two);
        If (edgeStr[i] = IS_EDGE) or (edgeStr[i] = IS_NOT_EDGE) then ID_two += 1;
    end;
end;

Procedure getDates();
const FILE_NAME = 'input.txt';
var f:text;
    edgeStr:string;
    ID:node_ID;
begin
    Assign(f,FILE_NAME);
    Reset(f);
    ID:=1;
    While not Eof(f) do begin
        ReadLn(f, edgeStr);
        fillEdges(edgeStr,ID);
        ID+=1;
    end;
    Close(f);
end;

Procedure sortEdges();
begin
    setCount();
    sortByCount();
end;

Procedure getSubset();
begin
    copyEdgeToSet(getEdgeHead());
    createSubset();
end;

Procedure printAnswer();
const FILE_NAME='output.txt';
var edgeSubset:pointEdgeSet;
    metk:pointEdgeSet;
    f:text;
begin
    edgeSubset:=getEdgeSubsetHead();
    metk:=edgeSubset^.next;
    Assign(f,FILE_NAME);
    Rewrite(f);
    While metk<>edgeSubset do begin
        WriteLn(f,metk^.ID_nodeOne,' ',metk^.ID_nodeTwo);
        metk:=metk^.next;
    end;
    Close(f);
end;

Begin
    getDates();
    sortEdges();
    getSubset();
    printAnswer();
End.