% Funcion cuyo cometido es la de reducir el grafo de visibilidad para ello
% se vale del metodo de barrido rotacional y en cada barriado lo que hace
% es comprobar si existen lineas tangentes o no tangentes. Es decir para
% detectar lineas tangantes se incrementa la longitud de la linea una
% cierta cantidad y si la nueva linea esta incluida en el obstaculo, se
% consider una linea no tangente y se descarta.
function resultado = reduceGrafoVisibilidad(espacioConfiguraciones,lineas)
espacioConfiguracionesTam = size(espacioConfiguraciones,2);
resultado = [];
numeroDeLineas = size(lineas,1);
for i = 1:numeroDeLineas
    % La antigua linea.
    linea = lineas(i,:);           
    % La nueva linea incrementada 13 unidades.
    lineaIncrementada = incrementaLongitud(13,linea); 
    noTangente = 0;    
    % Se dibuja dos nuevas lineas representando las partes extendidas sobre
    % la antigua linea.
    parteExtendida1 = [linea(1) linea(2);lineaIncrementada(1) lineaIncrementada(2)];    
    parteExtendida2 = [linea(3) linea(4);lineaIncrementada(3) lineaIncrementada(4)];             
    for j = 1:espacioConfiguracionesTam        
        obstaculo = espacioConfiguraciones{j};                       
        parteExtendida1CoordX = linspace(parteExtendida1(1,1),parteExtendida1(2,1));
        parteExtendida1CoordY = linspace(parteExtendida1(1,2),parteExtendida1(2,2));        
        matrizPuntosDentro = inpolygon(parteExtendida1CoordX,parteExtendida1CoordY,obstaculo(:,1),obstaculo(:,2));        
        if sum(matrizPuntosDentro) <= 2
           noTangente = noTangente + 0; 
        else
           noTangente = noTangente + 1; 
        end      
        parteExtendidaCoordX2 = linspace(parteExtendida2(1,1),parteExtendida2(2,1));
        parteExtendidaCoordY2 = linspace(parteExtendida2(1,2),parteExtendida2(2,2));        
        matrizPuntosDentro2 = inpolygon(parteExtendidaCoordX2,parteExtendidaCoordY2,obstaculo(:,1),obstaculo(:,2)); 
        if sum(matrizPuntosDentro2) <= 2
           noTangente = noTangente + 0; 
        else
           noTangente = noTangente + 1; 
        end        
    end
    % Si la linea es tangente entonces se incluye en resultado que
    % representa la matriz del grafo de visibilidad reducido.
    if noTangente == 0
        resultado = [resultado;lineas(i,:)];        
    end   
end
end
