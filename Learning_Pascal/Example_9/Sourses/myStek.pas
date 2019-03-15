Unit myStek;

Interface

Type element = char;
     stekPoint = ^stek;
     stek = record
        info:integer;
        next:stekPoint;
     end;

Var empty:boolean;
    openPosition:integer;   

Procedure add(var point:stekPoint;i:integer);
Procedure pop(var point:stekPoint);
Function isEmpty(point:stekPoint):boolean;

Implementation

Function isEmpty(point:stekPoint):boolean;
begin
    isEmpty:= point = nil;
end;

Procedure getPosition(position: integer);
begin
    openPosition:=position;
end;

Procedure add(var point:stekPoint;i:integer);
var y:stekPoint;
begin
    new(y);
    if isEmpty(point) then begin
        y^.info:=i;
        point := y;
    end
    else begin
        y^.next:=point^.next;
        y^.info:=point^.info;
        point^.info:=i;
        point^.next:=y;
    end;
end;



Procedure pop(var point:stekPoint);
var metk:stekPoint;
begin
    If isEmpty(point) then empty := true
    else begin
        metk:=point^.next;
        getPosition(point^.info);
        point:=metk;
        dispose(metk);
        empty:=false;
    end;
end;

Initialization

End.