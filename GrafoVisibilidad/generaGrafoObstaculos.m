% Se utiliza esa funciona para calcular el grafo de visibilidad de todos 
% los obstaculos usando el algoritmo de barriado rotacional.
function grafoVisibilidadTemporal=generaGrafoObstaculos(indiceObstaculos,espacioConfiguraciones,espacioConfiguracionesTam,grafoVisibilidadTemporal)  
obstaculoOrigen = espacioConfiguraciones{indiceObstaculos};
obstaculosVisitados{indiceObstaculos}=1;
longitudObstaculoOrigen = size(obstaculoOrigen,1);
% Condicion que se aplica cuando el obstaculo tiene tres vertices
if(longitudObstaculoOrigen==6)
    longitudObstaculoOrigen = longitudObstaculoOrigen +1;
end
for j = 1:longitudObstaculoOrigen -1    
verticeOrigen = obstaculoOrigen(j,:);
    for m = 1:espacioConfiguracionesTam -2                               
                obstaculoDestino = espacioConfiguraciones{m};               
                longitudObstaculoDestino = size(obstaculoDestino,1); 
                % Condicion que se aplica cuando el obstaculo tiene tres vertices
                if(longitudObstaculoDestino==6)
                    longitudObstaculoDestino = longitudObstaculoDestino +1;
                end
                % Comprobar los vertices visibles en el mismo obstaculo. Es
                % decir los vertices origen y destino estan el mismo obstaculo.
                if indiceObstaculos == m
                    for n = 1:longitudObstaculoDestino -1 
                        verticeDestino = obstaculoDestino(n,:);                        
                        % Uno comprobar que el vertice origen no es igual al 
                        % vertice destino. 
                        if n~=j                                           
                            linea = [verticeOrigen(1) verticeOrigen(2); verticeDestino(1) verticeDestino(2)];
                            % Dos comprobar si el vertice destino es adyacente
                            % al vertice origen en caso de serlo se calcula el 
                            % vector entre el vertice origen y el vertice 
                            % destino.                        
                            if (n == mod(j+1,longitudObstaculoOrigen -1) || (n == (mod(j-1,longitudObstaculoOrigen -1) + (j==1)*(longitudObstaculoOrigen -1))))               
                               lineaFinal = [linea(2,:) linea(1,:)];                                                                           
                               if not(existeVector(grafoVisibilidadTemporal,lineaFinal))
                                    grafoVisibilidadTemporal = [grafoVisibilidadTemporal; [linea(1,:) linea(2,:)]];                               
                               end                          
                            else
                             % Tres si no es adyacente comprobar que la linea 
                             % entre los dos vertices del obstaculo tiene 
                             % contacto con el obstaculo. Despues comprobar la 
                             % visiblidad del vertice destino y por ultimo que
                             % no se repite la linea dentro del grafo de
                             % visibilidad generado.
                               [lineaCoordX,lineaCoordY] = polyxpoly(linea(:,1),linea(:,2),obstaculoDestino(:,1),obstaculoDestino(:,2),'unique');
                               %if size(lineaCoordX,1) >= 2
                               if size(lineaCoordX,1) == 1
                                    puntosCoordX = linspace(linea(1,1),linea(2,1));
                                    puntosCoordY = linspace(linea(1,2),linea(2,2));
                                    matrizPuntosDentro = inpolygon(puntosCoordX,puntosCoordY,obstaculoDestino(:,1),obstaculoDestino(:,2));                                
                                    if sum(matrizPuntosDentro) <= 2
                                        lineaFinal = [linea(2,:) linea(1,:)];
                                        if not(existeVector(grafoVisibilidadTemporal,lineaFinal))
                                            grafoVisibilidadTemporal = [grafoVisibilidadTemporal; [linea(1,:) linea(2,:)]];                       
                                        end                                    
                                    end                               
                               end                                                         
                            end                        
                        end                       
                    end            
                % Comprobacion de vertices visibles en los demas obstaculos. Es 
                % decir el vertice origen y el vertice destino estan en 
                % distintos obstaculos.                 
                else                  
                    % Actualizar matriz de obstaculos visitados.
                    for i= 1:espacioConfiguracionesTam -2
                        if (i~=m && i~=indiceObstaculos) obstaculosVisitados{i}=0;
                        else obstaculosVisitados{m}=1;
                        end
                    end                 
                    for n = 1:longitudObstaculoDestino -1
                        verticeDestino = obstaculoDestino(n,:);                         
                        % Uno generar un linea entre el vertice origen y el vertice
                        % destino.
                        linea = [verticeOrigen(1) verticeOrigen(2); verticeDestino(1) verticeDestino(2)];    
                        % Dos comprobar que la linea tiene un punto de interesccion
                        % con el obstaculo origen y que es diagonal.
                        [lineaCoordX,lineaCoordY] = polyxpoly(linea(:,1),linea(:,2),obstaculoOrigen(:,1),obstaculoOrigen(:,2),'unique');                                        
                        if size(lineaCoordX,1) == 1
                            puntosCoordX = linspace(linea(1,1),linea(2,1));
                            puntosCoordY = linspace(linea(1,2),linea(2,2));
                            % Tres comprobar la visibilidad del vertice
                            % origen.(no hay mas vertices en el camino).
                            matrizPuntosDentro = inpolygon(puntosCoordX,puntosCoordY,obstaculoOrigen(:,1),obstaculoOrigen(:,2));                                                                       
                            if sum(matrizPuntosDentro) <= 2
                                % Cuatro comprobar que la linea tiene un punto de interesccion
                                % con el obstaculo destino y que es diagonal.
                                [lineaCoordXDos,lineaCoordYDos] = polyxpoly(linea(:,1),linea(:,2),obstaculoDestino(:,1),obstaculoDestino(:,2),'unique');                                                        
                                if size(lineaCoordXDos,1) == 1
                                    % Cinco comprobar la visibilidad del 
                                    % vertice destino.
                                    matrizPuntosDentroDos = inpolygon(puntosCoordX,puntosCoordY,obstaculoDestino(:,1),obstaculoDestino(:,2));                                                                                        
                                    if sum(matrizPuntosDentroDos) <= 2
                                        lineaFinal = [linea(2,:) linea(1,:)];                                   
                                        % Seis comprobar que no se repite la
                                        % linea dentro del grafo de visibilidad 
                                        % generado.
                                        if not(existeVector(grafoVisibilidadTemporal,lineaFinal))                                      
                                            vacio=0;
                                            for i= 1:espacioConfiguracionesTam -2
                                                if (obstaculosVisitados{i}==0)                                              
                                                    obstaculoFinal = espacioConfiguraciones{i};                                                       
                                                    matrizPuntosDentroTres = inpolygon(puntosCoordX,puntosCoordY,obstaculoFinal(:,1),obstaculoFinal(:,2));                                                                                        
                                                    if sum(matrizPuntosDentroTres) <= 2                                                         
                                                        vacio=vacio+1;
                                                        if (vacio==(espacioConfiguracionesTam -2) -2)
                                                            grafoVisibilidadTemporal = [grafoVisibilidadTemporal; [linea(1,:) linea(2,:)]];
                                                        end    
                                                    %else break;
                                                    end
                                                end                                                    
                                            end                                             
                                        end                                    
                                     end                                                                      
                                end                                
                            end                            
                        end                        
                    end                    
                end                                
    end
end   
end