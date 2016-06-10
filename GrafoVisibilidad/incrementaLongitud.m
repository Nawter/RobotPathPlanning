% Funcion cuyo cometido es aumentar la longitud de la linea original una
% cantidad que se indica en el parametro cantidad
function lineaFinal = incrementaLongitud(cantidad,linea)
    x1 = linea(1);
    y1 = linea(2);
    x2 = linea(3);    
    y2 = linea(4);
    angulo = atan2(y2-y1,x2-x1);
    x1 = x1 - cantidad*cos(angulo);
    y1 = y1 - cantidad*sin(angulo);        
    x2 = x2 + cantidad*cos(angulo);
    y2 = y2 + cantidad*sin(angulo);    
    lineaFinal = [ x1 y1 x2 y2];
end