% Funcion que se utiliza para obtener el nodo con la mejor funcion de coste.
function [mejorNodo,cjtoAbiertoFinal] = buscaElMejor(cjtoAbierto)
infinito = 1e100;
tamanioConjunto = size(cjtoAbierto,1);
indiceNodo = 0;
for i = 1:tamanioConjunto
    nodo = cjtoAbierto(i);
    funcionCoste = nodo.distActual + nodo.distHeuristica;
    if funcionCoste < infinito
       infinito = funcionCoste;
       mejorNodo = nodo;
       indiceNodo = i;
    end    
end
% Una vez obtenido el indice del nodo con la mejor funcion de coste se
% elimina del conjunto abierto.
cjtoAbiertoFinal = [cjtoAbierto(1:indiceNodo-1);cjtoAbierto(indiceNodo+1:tamanioConjunto)];
end