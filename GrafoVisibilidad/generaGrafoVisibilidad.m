% function grafoVisibilidad = generaGrafoVisibilidad(espacioConfiguraciones)
% Funcion que se utiliza para generar un grafo de visibilidad utilizando el
% algoritmo de barrido de superficie rotacional 
% (Rotational Plane Sweep Algorithm).
% Entrada espacioConfiguraciones.
% Salida grafoVisibilidad.
function grafoVisibilidad = generaGrafoVisibilidad(espacioConfiguraciones)
espacioConfiguracionesTam = size(espacioConfiguraciones,2);
grafoVisibilidadTemporal = [];
% Primero se calcula el grafo de visibilidad solo para el punto de inicio y
% el punto final respecto a los todos los vertices de los obstaculos.
for indiceVertices = espacioConfiguracionesTam-1:espacioConfiguracionesTam
  grafoVisibilidadTemporal=generaGrafoInicioFinal(indiceVertices,espacioConfiguraciones,espacioConfiguracionesTam,grafoVisibilidadTemporal);  
end
% Segundo se calcula el grafo de visibilidad para el resto de vertices de
% los obstaculos.
% Por cada obstaculo.
for indiceObstaculos = 1:espacioConfiguracionesTam-2         
    % Por cada vertice del obstaculo.        
    grafoVisibilidadTemporal=generaGrafoObstaculos(indiceObstaculos,espacioConfiguraciones,espacioConfiguracionesTam,grafoVisibilidadTemporal);                   
end
grafoVisibilidad = grafoVisibilidadTemporal;
end