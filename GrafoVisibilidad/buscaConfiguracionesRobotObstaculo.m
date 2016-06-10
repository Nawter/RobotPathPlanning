%
%
function espacioConfiguraciones = buscaConfiguracionesRobotObstaculo(robot,triangulo)
espacioConfiguraciones = [];
% Posicionar los vertices del triangulo direccion contraria a la del reloj. 
[x y] = poly2ccw(triangulo(:,1),triangulo(:,2));
triangulo = [x y];
% Por cada vertice del triangulo.
for i = 1:3
    % Por cada vertice del robot.
   for j = 1:3       
       % Calcular la normal de las aristas del robot.          
       normalRobot = calculaNormal(robot(j,:),robot(mod(j,3)+1,:));                
       % En el primer caso se trata de comprobar si hay un contacto entre
       % las aristas del robot y cada vertice del obstaculo. Para ello
       % se tiene dos condiciones una por cada arista conectada al vertice 
       % del obstaculo. Se hace el producto escalar entre la normal y cada
       % vector que representa una arista, si el producto es mayor o igual 
       % a cero(grado del angulo menor que pi/2) entonces eso indica que 
       % hay contacto entre el obstaculo y el robot.
       condicionUno = (triangulo(mod(i+2,3) + (i==1)*3 ,:) - triangulo(i,:))*normalRobot' >= 0;
       condicionDos = (triangulo(mod(i,3)+1,:) - triangulo(i,:))*normalRobot' >= 0;       
       % Cuando se cumplen las dos condiciones primero se calcula la
       % diferencia entre el vertice del obstaculo y la
       % longitud de la arista del robot donde se ha producido el
       % contacto, dando como resultado un vector , segundo se comprueba 
       % si ese vector generado esta en la matriz del espacio de 
       % configuraciones en caso de no estar se añade a la matriz.
       if condicionUno && condicionDos                       
            vectorUno = triangulo(i,:)-(robot(j,:) - robot(3,:));   
            if estaEnMatriz(vectorUno,espacioConfiguraciones)
                espacioConfiguraciones = [espacioConfiguraciones; vectorUno];             
            end                     
            vectorDos = triangulo(i,:)-(robot(mod(j,3) + 1,:) - robot(3,:));           
            if estaEnMatriz(vectorDos,espacioConfiguraciones)
                espacioConfiguraciones = [espacioConfiguraciones; vectorDos];               
            end          
       end
       % Calcular la normal de las aristas del obstaculo.                    
       normalTriangulo = calculaNormal(triangulo(i,:),triangulo(mod(i,3)+1,:));      
       % En el segundo caso se trata de comprobar si hay un contacto entre
       % cada vertice del robot y las aristas del obstaculo. Para ello
       % se tiene dos condiciones. Se hace el producto escalar entre la normal y cada
       % vector que representa la arista conectada al vertice del robot,
       % si elproducto es mayor o igual a cero(grado del angulo menor que 
       % pi/2) entonces eso indica que hay contacto entre el obstaculo y el
       % robot.
       condicionUno = (robot(mod(j+2,3) + (j == 1)*3,:)- robot(j,:))*normalTriangulo' >= 0;
       condicionDos = (robot(mod(j,3)+1,:) - robot(j,:) )*normalTriangulo' >= 0;       
       % Cuando se cumplen las dos condiciones primero se calcula la
       % diferencia entre el vertice del obastaculo y la
       % longitud de la arista del robot donde se ha producido el
       % contacto, dando como resultado un vector segundo se comprueba 
       % si ese vector generado esta en la matriz del espacion de 
       % configuraciones en caso de no estar se añade a la matriz.   
       if condicionUno && condicionDos
           vectorUno = triangulo(i,:)-(robot(j,:)-robot(3,:));       
           if estaEnMatriz(vectorUno,espacioConfiguraciones)
                espacioConfiguraciones = [espacioConfiguraciones; vectorUno];               
           end         
           vectorDos = triangulo(mod(i,3)+1,:)-(robot(j,:)-robot(3,:));      
           if estaEnMatriz(vectorDos,espacioConfiguraciones)
                espacioConfiguraciones = [espacioConfiguraciones; vectorDos];                
           end            
        end     
   end    
end
% Organizar la matriz del espacio de configuraciones.
espacioConfiguraciones=organizaMatriz(espacioConfiguraciones);
end