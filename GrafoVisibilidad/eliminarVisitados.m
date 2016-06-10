% Funcion que se utiliza para eliminar los nodos que han sido visitados del 
% conjunto cerrado de nodos.
function cjtoNodosFinales = eliminarVisitados(cjtoNodos,cjtoCerrado)
numeroNodos = size(cjtoNodos,1);
tamanioCjtoCerrado = size(cjtoCerrado,1);
cjtoNodosFinales = [];
for i = 1:numeroNodos
    nodo = cjtoNodos(i);
    vertice = nodo.punto;    
    noVisitado = 0;    
    for j = 1:tamanioCjtoCerrado
        nodoDos = cjtoCerrado(j);
        verticeDos = nodoDos.punto;        
        if sum(vertice == verticeDos) == 2
            noVisitado = noVisitado + 1;
        else
            noVisitado = noVisitado + 0;
        end
    end    
    if noVisitado == 0
        cjtoNodosFinales = [cjtoNodosFinales;nodo];
    end    
end
end