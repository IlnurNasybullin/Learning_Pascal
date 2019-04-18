Unit DFTree;//Differentiation Function Tree

Interface

Uses dates;

Procedure copyTree(var nodeDFT: pointDFT; nodeAFT: pointAFT);
Procedure copyTreeDFT(var nodeOne: pointDFT; nodeTwo: pointDFT);
Procedure isDifferentiationNode(var node: pointDFT);
Procedure deleteNodeDFT(var node: pointDFT);
Procedure setDifFunc(node: pointDFT; var func:string);

Implementation

Procedure copyTree(var nodeDFT: pointDFT; nodeAFT: pointAFT);//копирование AFT-дерева в DFT-дерево
begin
    if nodeAFT<>nil then begin
        new(nodeDFT);
        nodeDFT^.info:=nodeAFT^.info;
        nodeDFT^.isDif:=false;
        if not (nodeDFT^.info in mathsSymbolsArray[4]) then begin
            copyTree(nodeDFT^.left, nodeAFT^.left);
            copyTree(nodeDFT^.right, nodeAFT^.right);
        end
        else begin
            copyTree(nodeDFT^.left, nodeAFT^.right);
            copyTree(nodeDFT^.right, nodeAFT^.left);
        end;
    end;
end;

Procedure copyTreeDFT(var nodeOne: pointDFT; nodeTwo: pointDFT);//копирование одного DFT-дерева в другое
begin
    if nodeTwo<>nil then begin
        new(nodeOne);
        nodeOne^.info:=nodeTwo^.info;
        nodeOne^.isDif:=nodeTwo^.isDif;
        copyTreeDFT(nodeOne^.left, nodeTwo^.left);
        copyTreeDFT(nodeOne^.right, nodeTwo^.right);
    end;
end;

Procedure isDifferentiationNode(var node: pointDFT);//поддерево отмечается как продифференцированное
begin
    if node<>nil then begin
        node^.isDif:=true;
        isDifferentiationNode(node^.left);
        isDifferentiationNode(node^.right);
    end;
end;

Procedure deleteNodeDFT(var node: pointDFT);//удаление узла (очистка памяти)
begin
    if node<>nil then begin
        deleteNodeDFT(node^.left);
        deleteNodeDFT(node^.right);
        dispose(node);
    end;
end;

Procedure setDifFunc(node: pointDFT; var func:string);//запись продифференцированной функции
begin
    if node<>nil then begin
        func+=OPEN_BRACKET;
        if (node^.info in mathsSymbolsArray[SPECIAL_FUNCTIONS]) then func+=node^.info;
        setDifFunc(node^.left,func);
        if not (node^.info in mathsSymbolsArray[SPECIAL_FUNCTIONS]) then func+=node^.info;
        setDifFunc(node^.right,func);
        func+=CLOSE_BRACKET;
    end;
end;

Initialization

End.