% Se utiliza esa funciona para calcular el grafo de visibilidad del punto
% inicial y final usando el algoritmo de barriado rotacional.
function grafoVisibilidadTemporal=generaGrafoInicioFinal(indiceVertices,espacioConfiguraciones,tamEspacioConfiguraciones,grafoVisibilidadTemporal) 
puntoInicioFinal = espacioConfiguraciones{indiceVertices};
% Por cada obstaculo en el mapa
    for indiceObstaculos = 1:tamEspacioConfiguraciones-2 
        obstaculoDestino = espacioConfiguraciones{indiceObstaculos};       
        longitudObstaculoDestino = size(obstaculoDestino,1);              
        % Por cada vertice en cada obstaculo.        
        for k = 1:longitudObstaculoDestino
            % Escoger un vertice destino.
            verticeDestino = obstaculoDestino(k,:);         
            % Dibujar una linea entre el vertice del punto inicial o el
            % punto final y el vertice destino del obstaculo.
            linea = [puntoInicioFinal(1) puntoInicioFinal(2); verticeDestino(1) verticeDestino(2)];                  
            % Comprobar que la linea tiene un punto de interesccion
            % con el obstaculo destino y que es diagonal.                   
            [lineaCoordX,lineaCoordY] = polyxpoly(linea(:,1),linea(:,2),obstaculoDestino(:,1),obstaculoDestino(:,2),'unique');           
            if size(lineaCoordX,1) <= 1
               puntosCoordX = linspace(linea(1,1),linea(2,1));
               puntosCoordY = linspace(linea(1,2),linea(2,2));                        
               % Comprobar la visibilidad del vertice
               % destino.(no hay mas vertices en el camino).
               matrizPuntosDentro = inpolygon(puntosCoordX,puntosCoordY,obstaculoDestino(:,1),obstaculoDestino(:,2));                             
                if sum(matrizPuntosDentro) <= 2
                    numeroPuntosEnArea = 0;
                    % Aplicar el mismo procedimiento descrito arriba para los
                    % obstaculos restantes.                    
                    for l = 1:tamEspacioConfiguraciones-2
                        if indiceObstaculos~=l
                            obstaculoDestinoDos = espacioConfiguraciones{l};
                            matrizPuntosDentroDos = inpolygon(puntosCoordX,puntosCoordY,obstaculoDestinoDos(:,1),obstaculoDestinoDos(:,2));
                            % Comprobar que el vertice es visible.
                            if sum(matrizPuntosDentroDos) <= 2
                                numeroPuntosEnArea = numeroPuntosEnArea + 0;
                            else
                                numeroPuntosEnArea = numeroPuntosEnArea + 1;
                            end                            
                        end                        
                    end                    
                    % Si el vertice es visible generar una linea final.
                    if numeroPuntosEnArea == 0
                        lineaFinal = [linea(2,:) linea(1,:)];
                        % Comprobar que no se repite la linea final dentro 
                        % del grafo de visibilidad generado.
                        if not(existeVector(grafoVisibilidadTemporal,lineaFinal))
                            grafoVisibilidadTemporal = [grafoVisibilidadTemporal; [linea(1,:) linea(2,:)]];                                                        
                        end  
                    end                    
                end                
            end            
        end            
    end    
end
