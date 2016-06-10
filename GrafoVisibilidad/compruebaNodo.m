% Funcion cuyo cometido es detectar nodos(vertices) repetidos utilizando la
% condicion de que la suma sea igual a dos.
function [resultadoFinal,nodoFinal] = compruebaNodo(nodos,nodo)
numeroNodos = size(nodos,1);
nodoFinal = [];
resultado = 0;
for i = 1:numeroNodos     
   nodoActual = nodos(i);  
   vertice = nodoActual.punto;  
   if sum(vertice == nodo) == 2
       resultado = resultado + 1;
       nodoFinal = nodoActual;
   else
       resultado = resultado + 0;
   end             
end
    if resultado > 0
        resultadoFinal = 1;
    else
        resultadoFinal = 0;
        nodoFinal = [];
    end
end