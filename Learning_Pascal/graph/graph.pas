Program graph;

Uses myEdgeList;

Const INPUT_FILE_NAME = 'input.txt';
      OUTPUT_FILE_NAME = 'output.txt';
      
Var pEdgeList: pointList;
    pEdgeSetList: pointList;

Procedure getSetEdges(var pEdgeSetList: pointList; pEdgeList: pointList);
var metk:pointList;
    nearEdge:pointList;
begin
    metk:=pEdgeList^.next;
    While isExistNotMetk(pEdgeList) and (metk<>pEdgeList) do begin
        addPointInTail(pEdgeSetList, metk);
        setMetk(metk);
        nearEdge:=getNearNotMetkEdge(pEdgeList,metk);
        While nearEdge<>pEdgeList do begin
            setMetk(nearEdge);
            nearEdge:=getNearNotMetkEdge(pEdgeList,metk);
        end;
        While isExistMetkPoint(metk) and (metk<>pEdgeList) do
            metk:=metk^.next;
    end;
end;

Begin
    pEdgeList:=getNewPointList();
    fillList(pEdgeList, INPUT_FILE_NAME);
    setCountNearEdges(pEdgeList);
    sortEdgesByCountFromMinToMax(pEdgeList);
    //sortEdgesByCountFromMaxToMin(pEdgeList);
    pEdgeSetList:=getNewPointList();
    getSetEdges(pEdgeSetList, pEdgeList);
    printList(pEdgeSetList, OUTPUT_FILE_NAME);
End.
      