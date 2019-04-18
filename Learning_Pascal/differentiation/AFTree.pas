Unit AFTree;//Arifmetic Function Tree

Interface

Uses dates;

Procedure add(var node: pointAFT; symb: mathsSymbol);
Procedure deleteNodeAFT(var node: pointAFT);

Implementation

Procedure add(var node: pointAFT; symb: mathsSymbol);//���������� � AFT-������
begin
    new(node);
    node^.info:=symb;
    node^.left:=nil;
    node^.right:=nil;
end;

Procedure deleteNodeAFT(var node: pointAFT);//�������� ���� (������� ������)
begin
    if node<>nil then begin
        deleteNodeAFT(node^.left);
        deleteNodeAFT(node^.right);
        dispose(node);
    end;
end;

Initialization

End.