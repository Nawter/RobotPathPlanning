%function calculaGrafoVisibilidad(mapa,robot,puntoInicial,puntoFinal)  
% Entrada
% Salida
function calculaGrafoVisibilidad(mapa,robot,puntoInicial,puntoFinal)  
warning off; %se utiliza para eliminar los warnings.  
espacioConfiguraciones = generaEspacioConfiguraciones(robot,mapa);
% Dibujar el mapa generado a partir del algoritmo encargado de producir 
% el espacio de configuraciones.    
dibujaMapaConfiguraciones(mapa,robot,puntoInicial,puntoFinal,espacioConfiguraciones);
hold on;
espacioConfiguracionesTam = size(espacioConfiguraciones,2);   
espacioConfiguraciones{espacioConfiguracionesTam+1} = puntoInicial;
espacioConfiguraciones{espacioConfiguracionesTam+2} = puntoFinal;
% Crear el grafo de visibilidad.
lineas = generaGrafoVisibilidad(espacioConfiguraciones);   
for i = 1:size(lineas,1) 
    plot([lineas(i,1) lineas(i,3)],[lineas(i,2) lineas(i,4)],'r');
end
% % Crear el grafo reducido de visibilidad. 
lineas = reduceGrafoVisibilidad(espacioConfiguraciones,lineas);  
for i = 1:size(lineas,1)
    plot([lineas(i,1) lineas(i,3)],[lineas(i,2) lineas(i,4)],'b','LineWidth',2);
end
%Lanzar la busqueda basada en el algoritmo A-Estrella.
lineas = aEstrella(puntoInicial,puntoFinal,lineas);
for i = 1:size(lineas,1) 
    plot([lineas(i,1) lineas(i,3)],[lineas(i,2) lineas(i,4)],'c','LineWidth',4);
end
end