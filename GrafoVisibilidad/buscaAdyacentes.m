% Funcion que se utiliza para buscar y guardar los vertices adyacentes a un
% nodo del grafo.
function nodosAdyacentesFinales = buscaAdyacentes(nodo, lineas,cjtoNodos)
numeroLineas = size(lineas,1);
nodosAdyacentes = [];
for i = 1: numeroLineas
    nodoCoordX = nodo(1);
    nodoCoordY = nodo(2);   
    lineaSeleccionada = lineas(i,:);    
    if nodoCoordX == lineaSeleccionada(1) && nodoCoordY == lineaSeleccionada(2)
        nodosAdyacentes = [nodosAdyacentes; [lineaSeleccionada(3) lineaSeleccionada(4)]];
    end     
    if nodoCoordX == lineaSeleccionada(3) && nodoCoordY == lineaSeleccionada(4)
        nodosAdyacentes = [nodosAdyacentes;[lineaSeleccionada(1) lineaSeleccionada(2)]];
    end
end
numeroAdyacentes = size(nodosAdyacentes,1);
nodosAdyacentesFinales = [];
% Una vez obtenidos los nodos adyacentes dado un nodo se comprueba primero 
% que no estan repetidos, segundo se calcula su distancia, y por ultimo 
% se guarda el puntero a ese nodo en cada en el campo punteroCamino de cada
% nodo adyacente.
for i =1:numeroAdyacentes
    [noRepetido,nodoAdyacente] = compruebaNodo(cjtoNodos,nodosAdyacentes(i,:));
    nodoAdyacente.distActual = calculaDistancia(nodo,nodosAdyacentes(i,:));
    nodoAdyacente.punteroCamino = nodo;    
    nodosAdyacentesFinales = [nodosAdyacentesFinales;nodoAdyacente];             
end
end