function calculaGrafo
    warning off; %se utiliza para eliminar los warnings.
    % Declaracion de variables de mapa, robot, obstaculos y el punto de
    % inicio y fin.
    mapa = [];
%       obs1 = [100,160; 140, 190; 170, 240];
% %      %obs2 = [30,80;60,150; 90,110;100,70;60,100];
%       obs2 = [30,80;60,150; 90,110];
%       obs3 = [140,20; 160,50; 180,50];
      robot = [5 15; 10 10; 10 25];
     inicio = [100 270];
     fin = [40 10];
    obs1 = [30,70; 70,70; 70,110; 30, 110];
    obs2 = [110,140;150,140; 150,160;110,160];
%    obs3 = [100,40; 160,40; 160,90;100,90];
 %   obs4 = [80,190;110,190;110,230;80,230];
% robot = [10 15; 10 10; 5 25];
% inicio = [150 210];
% fin = [40 10];
    % Asignar los obstaculos a los mapas.
    mapa{1} = obs1;
    mapa{2} = obs2;
    %mapa{3} = obs3;
    %mapa{4} = obs4;
    % Dibujar el mapa con los obstaculos, el robot, y los puntos de inicio
    % y final.
    dibujaMapa(mapa,robot,inicio,fin);
    % Crear el espacio de configuraciones.
    espacioConfiguraciones = generaEspacioConfiguraciones(robot,mapa);
    %figure(3)
    % Dibujar el mapa generado a partir del algoritmo encargado de producir 
    % el espacio de configuraciones.
    dibujaMapaConfiguraciones(mapa,robot,inicio,fin,espacioConfiguraciones);
    hold on;
    espacioConfiguracionesTam = size(espacioConfiguraciones,2);   
    espacioConfiguraciones{espacioConfiguracionesTam+1} = inicio;
    espacioConfiguraciones{espacioConfiguracionesTam+2} = fin;
%     % Crear el grafo de visibilidad.
    lineas = generaGrafoVisibilidad(espacioConfiguraciones);
    disp('numero de lineas');
    disp(size(lineas,1));
    for i = 1:size(lineas,1) 
         plot([lineas(i,1) lineas(i,3)],[lineas(i,2) lineas(i,4)],'r');
    end     
%     lineas = reduceGrafoVisibilidad(espacioConfiguraciones,lineas);  
%     for i = 1:size(lineas,1)        
%         plot([lineas(i,1) lineas(i,3)],[lineas(i,2) lineas(i,4)],'b','LineWidth',2);
%     end              
%     lineas = aEstrella(inicio,fin,lineas);
%     for i = 1:size(lineas,1) 
%        plot([lineas(i,1) lineas(i,3)],[lineas(i,2) lineas(i,4)],'g','LineWidth',4);
%     end
end