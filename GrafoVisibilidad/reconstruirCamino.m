% Funcion que se utiliza para construir la ruta utilizando la informacion
% almacenada en el campo punteroCamino.
function lineas = reconstruirCamino(mejorNodo,nodoInicial,cjtoAbierto)
verticeUno = mejorNodo.punto;
verticeDos = mejorNodo.punteroCamino;
lineas = [verticeUno verticeDos];
while(1)   
    [noRepetido,nuevoNodo] = compruebaNodo(cjtoAbierto,verticeDos);       
    verticeUno = nuevoNodo.punto;    
    verticeDos = nuevoNodo.punteroCamino;    
    lineas = [lineas; [verticeUno verticeDos]];    
    if  sum(verticeDos == nodoInicial.punto ) == 2
        break;
    end
end
end