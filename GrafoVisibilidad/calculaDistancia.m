% Funcion que se utiliza para calcular la distancia euclidea entre dos
% puntos del grafo.
function distanciaEuclidea = calculaDistancia(puntoUno,puntoDos)
distanciaEuclidea = sqrt((puntoUno(1)-puntoDos(1))^2+(puntoUno(2)-puntoDos(2))^2);
end