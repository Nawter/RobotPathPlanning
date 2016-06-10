% Funcion que se utiliza para generar el espacio de configuraciones a
% partir del espacio de trabajo representado por un mapa y un robot.
function espacioConfiguracionesMapa = generaEspacioConfiguraciones(robot,mapa)
espacioConfiguracionesObstaculo = [];
espacioConfiguracionesMapa = [];
% Calculcar el tamaño del mapa.
tamanioMapa = size(mapa,2);
% Por cada obstaculo en el mapa.
for i = 1: tamanioMapa
    obstaculo = mapa{i};    
    obstaculoCoordX = obstaculo(:,1);
    obstaculoCoordY = obstaculo(:,2); 
    % Comprobar si las vertices del poligono estan en direccion a las
    % agujas del reloj.
    % 
    if not(ispolycw(obstaculoCoordX,obstaculoCoordY))
       [obstaculoCoordX obstaculoCoordY ]=poly2cw(obstaculoCoordX,obstaculoCoordY);
    end   
    % Triangulación de Delaunay generar una matriz con todos los
    % triangulos del poligono(obstaculo).
    triangulosTotales = delaunay(obstaculoCoordX,obstaculoCoordY);     
    triangulosInternos = zeros(triangulosTotales,3);
    indiceTriangulos = 1;
    % Por cada triangulo.
    for j = 1: size(triangulosTotales,1)            
        % Eliminar los triangulos externos aplicando una operacion and 
        % entre el obstaculo y los trinangulos dentro del obstaculo. Es 
        % decir se aplica una interseccion entre el poligono y cada 
        % triangulo para eliminar los triangulos que no estan dentro del 
        % obstaculo.
        [lineaCoordX, lineaCoordY] = polybool('and',obstaculoCoordX,obstaculoCoordY,obstaculoCoordX(triangulosTotales(j,:)),obstaculoCoordY(triangulosTotales(j,:)));                   
        if size(lineaCoordX,1) > 0
            triangulosInternos(indiceTriangulos,:) = triangulosTotales(j,:);
            indiceTriangulos = indiceTriangulos + 1;          
        end
    end 
    % Eliminar las filas que contienen ceros.     
    triangulosInternosSinCerosTraspuesta = sum(triangulosInternos');
    triangulosInternosSinCeros = triangulosInternos(1:size(triangulosInternosSinCerosTraspuesta(triangulosInternosSinCerosTraspuesta>0),2),:);       
    triangulosFinales = [];
    % Por cada triangulo dentro del obstaculo.
    % Encontrar el espacio de configuraciones de cada triangulo utilizando 
    % la matriz de coordenadas reales en vez de la matriz de triangulos de 
    % delauny.
    for k = 1: size(triangulosInternosSinCeros,1) 
        trianguloCoordX = obstaculoCoordX(triangulosInternosSinCeros(k,:));
        trianguloCoordY = obstaculoCoordY(triangulosInternosSinCeros(k,:)); 
        % Donde se aplican las dos condiciones.
        triangulosFinales = buscaConfiguracionesRobotObstaculo(robot,[trianguloCoordX trianguloCoordY]);                
        if k == 1
            espacioConfiguracionesObstaculo = triangulosFinales;         
        else        
        % Aplicar una operacion de union entre la matriz que contiene los
        % triangulos finales de cada obstaculo y la matriz que contiene el espacio 
        % de configuraciones, 
           [unionCoordX unionCoordY] = polybool('or', espacioConfiguracionesObstaculo(:,1),espacioConfiguracionesObstaculo(:,2),triangulosFinales(:,1),triangulosFinales(:,2));
           espacioConfiguracionesObstaculo = [unionCoordX unionCoordY];        
        end        
           %figure(2)         
           hold on;
           patch(trianguloCoordX,trianguloCoordY,'w');            
           axis([0 200 -10 300])        
    end     
  espacioConfiguracionesMapa{i} = espacioConfiguracionesObstaculo;  
end
end
