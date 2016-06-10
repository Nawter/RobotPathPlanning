% Funcion que se utiliza para comprobar la existencia del vector que
% contiene el vertice visibile en la matriz del grafo de visibilidad
function grafoVisibilidad = existeVector(grafo,vector)
tamanio = size(grafo,1);
cumpleCondicion = 0;
for i = 1:tamanio
   fila = grafo(i,:);   
   if fila == vector
       cumpleCondicion = cumpleCondicion + 1;
   else
       cumpleCondicion = cumpleCondicion + 0;
   end
end
if cumpleCondicion>0
    grafoVisibilidad = 1;
else
    grafoVisibilidad = 0;
end
end