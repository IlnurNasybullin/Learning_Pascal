Unit myDates;

Interface

Type pointEdge = ^edgeList;
     pointEdgeSet = ^edgeSet;
     node_ID = integer;
     
     edgeList = record
        ID_nodeOne:node_ID;
        ID_nodeTwo:node_ID;
        count:integer;
        next:pointEdge;
     end;
     
     edgeSet = record
        ID_nodeOne:node_ID;
        ID_nodeTwo:node_ID;
        next:pointEdgeSet;
     end;
     
Implementation

Initialization

End.