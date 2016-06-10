% Funcion que se utiliza para crear la estructura de los nodos definiendo 
% los siguientes campos.
% use struct type node
% nodo -> punto para guardar un nodo con sus coordenadas [x,y]
% nodo -> distHeuristica para representar la distancia heuristica entre el nodo
% y el punto final.
% nodo -> distActual para almacenar la distancia euclieda entre cualquier par
% de puntos.
% nodo -> punteroCamino que apunta al nodo anterior, y que mas tarde se
% usara en la funcion reconstruirCamino.
function cjtoNodos = creaNodos(objetivo,lineas)
numeroDeLineas = size(lineas,1);
cjtoNodos = [];
for i = 1:numeroDeLineas
    nodoUno = lineas(i,1:2);    
    [noRepetido, nodo] = compruebaNodo(cjtoNodos,nodoUno);   
    if not(noRepetido)
        distHeuristica = calculaDistancia(nodoUno,objetivo);
        datosNodo = struct('punto',nodoUno,'distHeuristica',distHeuristica,'distActual',0,'punteroCamino',[0 0]);
        cjtoNodos = [cjtoNodos;datosNodo];
    end
    nodoDos = lineas(i,3:4);    
    [noRepetido,nodo] = compruebaNodo(cjtoNodos,nodoDos);
    if not(noRepetido)
        distHeuristica = calculaDistancia(nodoDos,objetivo);
        datosNodoDos = struct('punto',nodoDos,'distHeuristica',distHeuristica,'distActual',0,'punteroCamino',[0 0]);
        cjtoNodos = [cjtoNodos;datosNodoDos];
    end    
end
end