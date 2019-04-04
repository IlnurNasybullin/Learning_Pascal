Unit myBinaryTree;

Interface

Uses myDates;
Uses myQueueForTree;

Procedure addToTree(var point:pointTree);
Procedure delete(var point:pointTree);
Procedure LeftRootRight(point:pointTree);
Procedure RootLeftRight(point: pointTree);
Procedure RightRootLeft(point: pointTree);
Procedure horyzontalBypass(point: pointTree);

Implementation

Procedure initPoint(var point: pointTree;x:element);
begin
    new(point);
    point^.left:=nil;
    point^.right:=nil;
    point^.info:=x;
end;

Procedure addToTreeRealization(var point:pointTree; x:element);
begin
    if point <> nil then begin
        if x<point^.info then addToTreeRealization(point^.left,x)
        else addToTreeRealization(point^.right,x);
    end
    else initPoint(point,x);
end;

Procedure addToTree(var point: pointTree);
var x:element;
    i, count:integer;
begin
    WriteLn('Введите количество элементов');
    ReadLn(count);
    for i:=1 to count do begin
        ReadLn(x);
        addToTreeRealization(point, x);
    end;
end;

Procedure deleteTree(var point:pointTree);
var metk:pointTree;
begin
    if point<>nil then begin
        deleteTree(point^.left);
        dispose(point^.left);
        deleteTree(point^.right);
        dispose(point^.right);
    end;
end;

Procedure copyTree(var leftRoot: pointTree;rightRoot:pointTree);
begin
    if rightRoot<>nil then begin
        leftRoot^.info:=rightRoot^.info;
        copyTree(leftRoot^.left, rightRoot^.left);
        copyTree(leftRoot^.right, rightRoot^.right);
    end;
end;

Procedure addTree(var leftRoot:pointTree; rightRoot:pointTree);
begin
    if leftRoot<>nil then addTree(leftRoot^.right, rightRoot)
    else leftRoot:=rightRoot;
end;

Procedure deleteRealization(var point: pointTree; x:element);
begin
    if point^.info<>x then begin
        if x<point^.info then deleteRealization(point^.left,x)
        else deleteRealization(point^.right,x);
    end
    else begin
        addTree(point^.left, point^.right);
        point^.right:=nil;
        point:=point^.left;
    end;
end;

Procedure delete(var point:pointTree);
var x:element;
begin
    WriteLn('Введите элемент');
    ReadLn(x);
    if point<>nil then deleteRealization(point, x)
    else WriteLn('Error! Tree is empty!');
end;

Procedure LeftRootRight(point:pointTree);
begin
    if point<>nil then begin
        LeftRootRight(point^.left);
        Write(point^.info,' ');
        LeftRootRight(point^.right);
    end;
end;

Procedure RootLeftRight(point: pointTree);
begin
    if point <> nil then begin
        Write(point^.info,' ');
        RootLeftRight(point^.left);
        RootLeftRight(point^.right);
    end;
end;

Procedure RightRootLeft(point: pointTree);
begin
    if point<>nil then begin
        RightRootLeft(point^.right);
        Write(point^.info,' ');
        RightRootLeft(point^.left);
    end;
end;

Procedure horyzontalBypass(point: pointTree);
begin
    if point<>nil then begin
        Write(point^.info,' ');
        addToQueue(headQueue, point^.left);
        addToQueue(headQueue, point^.right);
    end;
    if not isEmptyPointQueue(headQueue) then horyzontalBypass(queuePop(headQueue));
end;

Procedure printTree(point: pointTree);
begin
    WriteLn();
    RootLeftRight(point);
    WriteLn();
    LeftRootRight(point);
    WriteLn();
    RightRootLeft(point);
    WriteLn();
    horyzontalBypass(point);
end;

Begin
    
End.