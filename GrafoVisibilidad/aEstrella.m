function resultado = aEstrella(inicio,fin,lineas)
conjuntoNodos = creaNodos(fin,lineas);
currVert = inicio;
conjuntoAbierto = buscaAdyacentes(currVert,lineas,conjuntoNodos);
datosNodo = struct('punto',inicio,'distHeuristica',calculaDistancia(inicio,fin),'distActual',0,'punteroCamino',[0 0]);
conjuntoCerrado = [datosNodo];
acierto = 1;
while(1)
    if isempty(conjuntoAbierto)
        acierto = 0;
        break;
    end    
    [mejorNodo,conjuntoAbierto] = buscaElMejor(conjuntoAbierto); 
    conjuntoCerrado = [conjuntoCerrado; mejorNodo];
    if sum(mejorNodo.punto == fin) == 2
        acierto = 1;
        break;
    end    
    conjuntoAdyacentes = buscaAdyacentes(mejorNodo.punto,lineas,conjuntoNodos);
    conjuntoAdyacentes = eliminarVisitados(conjuntoAdyacentes,conjuntoCerrado);    
    if not(isempty(conjuntoAdyacentes))          
        numeroAdyacentes = size(conjuntoAdyacentes,1);       
        for i = 1:numeroAdyacentes
            nodo = conjuntoAdyacentes(i);
            nodo.distActual = nodo.distActual + mejorNodo.distActual;            
            conjuntoAbierto = [conjuntoAbierto;nodo];            
            if mejorNodo.distActual + calculaDistancia(mejorNodo.punto,nodo.punto) < nodo.distActual
                nodo.punteroCamino = mejorNodo;
            end         
        end        
    end    
end
if acierto
    linesFinales = reconstruirCamino(mejorNodo,datosNodo,conjuntoCerrado);
    resultado = linesFinales;
else    
end
end 