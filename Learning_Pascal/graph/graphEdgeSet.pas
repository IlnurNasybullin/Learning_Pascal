Unit graphEdgeSet;

Interface

Uses myDates;

Procedure copyEdgeToSet(edge:pointEdge);
Procedure createSubset();
Function getEdgeSubsetHead():pointEdgeSet;

Implementation

Var edgeSetHead:pointEdgeSet;
    edgeSubsetHead:pointEdgeSet;

Procedure initEdgeSet();
begin
    new(edgeSetHead);
    edgeSetHead^.next:=edgeSetHead;
    
    new(edgeSubsetHead);
    edgeSubsetHead^.next:=edgeSubsetHead;
end;

Procedure addEdgeSet(edge:pointEdge);
var edgeSet:pointEdgeSet;
begin
    new(edgeSet);
    edgeSet^.next:=edgeSetHead^.next;
    edgeSetHead^.ID_nodeOne:=edge^.ID_nodeOne;
    edgeSetHead^.ID_nodeTwo:=edge^.ID_nodeTwo;
    edgeSetHead^.next:=edgeSet;
    edgeSetHead:=edgeSet;
end;

Procedure addEdgeSubset(edgeSet:pointEdgeSet);
var edgeSubset:pointEdgeSet;
begin
    new(edgeSubset);
    edgeSubset^.next:=edgeSubsetHead^.next;
    edgeSubsetHead^.ID_nodeOne:=edgeSet^.ID_nodeOne;
    edgeSubsetHead^.ID_nodeTwo:=edgeSet^.ID_nodeTwo;
    edgeSubsetHead^.next:=edgeSubset;
    edgeSubsetHead:=edgeSubset;
end;

Procedure copyEdgeToSet(edge:pointEdge);
var metk:pointEdge;
begin
    metk:=edge^.next;
    While metk<>edge do begin
        addEdgeSet(metk);
        metk:=metk^.next;
    end;
end;

Function pop(edgeSet:pointEdgeSet):pointEdgeSet;
var x:pointEdgeSet;
    metk:pointEdgeSet;
begin
    metk:=edgeSetHead;
    While metk^.next<>edgeSet do
        metk:=metk^.next;
    x:=edgeSet;
    metk^.next:=edgeSet^.next;
    dispose(edgeSet);
    pop:=x;
end;

Function getNearEdge(edgeSet:pointEdgeSet):pointEdgeSet;
var metk:pointEdgeSet;
    x:pointEdgeSet;
begin
    x:=nil;
    metk:=edgeSetHead^.next;
    While (x=nil) and (metk<>edgeSetHead) do begin
        If (metk<>edgeSet) and ((metk^.ID_nodeOne = edgeSet^.ID_nodeOne) or (metk^.ID_nodeOne = edgeSet^.ID_nodeTwo) or
                                (metk^.ID_nodeTwo = edgeSet^.ID_nodeOne) or (metk^.ID_nodeTwo = edgeSet^.ID_nodeTwo)) then x:=metk;
        metk:=metk^.next;
    end;
    getNearEdge:=x;
end;

Procedure createSubset();
var x:pointEdgeSet;
    metk:pointEdgeSet;
begin
    x:=pop(edgeSetHead^.next);
    addEdgeSubset(x);
    metk:=edgeSubsetHead^.next;
    While metk<>edgeSubsetHead do begin
        x:=getNearEdge(metk);
        While x<>nil do begin
            x:=pop(x);
            addEdgeSubset(x);
            x:=getNearEdge(metk);
        end;
        metk:=metk^.next;
    end;
end;

Function getEdgeSubsetHead():pointEdgeSet;
begin
    getEdgeSubsetHead:=edgeSubsetHead;
end;

Initialization
    initEdgeSet();
End.