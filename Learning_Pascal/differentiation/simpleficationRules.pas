Unit simpleficationRules;

Interface

Uses dates;

Procedure simplefication(var rootDFT: pointDFT);
Procedure simpleficationFunction(var func:string);

Implementation

Uses DFTree;

Function isTerm(node: pointDFT):boolean;//�������� ���� �� �������������
var i:integer;
    f:boolean;
begin
    f:=true;
    i:=FIRST_PRIORITY;
    while (i<=THIRD_PRIORITY) and f do begin
        f:=not (node^.info in mathsSymbolsArray[i]);
        i+=1;
    end;
    isTerm:=f;
end;

Procedure simpleficationDelete(var node:pointDFT);//�������� ���� � ���������
var isT:boolean;
    i:integer;
begin
    isT:=false;
    i:=1;
    while not isT and (i<=SPECIAL_FUNCTIONS) do begin
        isT:=node^.info in mathsSymbolsArray[i];
        i+=1;
    end;
    if not isT then begin
        deleteNodeDFT(node^.left);
        deleteNodeDFT(node^.right);
    end
    else begin
        if node^.info=node^.left^.info then copyTreeDFT(node, node^.left)
        else copyTreeDFT(node, node^.right);
    end;
end;

Procedure simpleficationSum(var node: pointDFT);//��������� �����
begin
    if node^.left^.info=ZERO then begin
        node^.info:=node^.right^.info;
        simpleficationDelete(node);
    end
    else if node^.right^.info=ZERO then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end;
end;

Procedure simpleficationSubtract(var node: pointDFT);//��������� ��������
begin
    if node^.right^.info=ZERO then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end
    else if node^.left^.info=ZERO then deleteNodeDFT(node^.left);
end;

Procedure simpleficationMultiplication(var node: pointDFT);//��������� ���������
begin
    if (node^.left^.info=ZERO) or (node^.right^.info=ZERO) then begin
        node^.info:=ZERO;
        simpleficationDelete(node);
    end
    else if node^.left^.info=CONST_DIF then begin
        node^.info:=node^.right^.info;
        simpleficationDelete(node);
    end
    else if node^.right^.info=CONST_DIF then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end;
end;

Procedure simpleficationDivision(var node: pointDFT);//��������� �������
begin
    if node^.left^.info=ZERO then begin
        node^.info:=ZERO;
        simpleficationDelete(node);
    end
    else if node^.right^.info=CONST_DIF then begin
        node^.info:=node^.left^.info;
        simpleficationDelete(node);
    end;
end;

Procedure simpleficationExponentiation(var node: pointDFT);//��������� �����������������
begin
    if (node^.left^.info<>ZERO) and (node^.right^.info<>ZERO) then begin
        if node^.left^.info=ZERO then begin
            node^.info:=ZERO;
            simpleficationDelete(node);
        end
        else if (node^.right^.info=ZERO) or (node^.left^.info=CONST_DIF) then begin
            node^.info:=CONST_DIF;
            simpleficationDelete(node);
        end
        else if node^.right^.info=CONST_DIF then begin
            node^.info:=node^.left^.info;
            simpleficationDelete(node);
        end;
    end;
end;

Procedure simpleficationRealization(var node: pointDFT);//��������� ������� (������� - ��������)
begin
    if not isTerm(node^.left) then simpleficationRealization(node^.left);
    if not isTerm(node^.right) then simpleficationRealization(node^.right);
    if isTerm(node^.left) or isTerm(node^.right) then begin
        case node^.info of
            PLUS: simpleficationSum(node);//��������� �����
            MINUS: simpleficationSubtract(node);//��������� ��������
            MULTIPLICATION: simpleficationMultiplication(node);//��������� ���������
            DIVISION: simpleficationDivision(node);//��������� �������
            EXPONENTATION: simpleficationExponentiation(node);//��������� �����������������
        end;
    end;
end;

Procedure simplefication(var rootDFT: pointDFT);//��������� ������� (�������-����������)
begin
    simpleficationRealization(rootDFT);//��������� ������� (������� - ��������)
end;

Procedure simpleficationFunction(var func:string);//�������� ������� ������ � �������
begin
    delete(func,1,1);
    delete(func,length(func),1);
end;

Initialization

End.