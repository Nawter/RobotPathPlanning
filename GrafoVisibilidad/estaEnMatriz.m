% Funcion que se utiliza para comprobar que la matriz de configuraciones 
% esta vacia o que no contiene un vector de configuraciones utilizando las 
% funciones nativas de  matlab isempty y find.
function resultado = estaEnMatriz(vectorConfiguraciones,matrizConfiguraciones)
if isempty(matrizConfiguraciones)
    resultado = 1;    
else
    resParcial1 = (matrizConfiguraciones(:,1) - vectorConfiguraciones(1)== 0);
    resParcial2 = (matrizConfiguraciones(:,2) - vectorConfiguraciones(2)== 0);  
    indiceVectores = find((resParcial1 + resParcial2) == 2,1);   
    if isempty(indiceVectores)
        resultado = 1;
    else
        resultado = 0;
    end    
end
end
