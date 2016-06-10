% Calcular la normal al objeto que puede ser robot u un obstaculo dados 
% dos vertices.
function normal = calculaNormal(verticeUno,verticeDos)
normal = [0 0];
angulo = atan2(verticeDos(2)-verticeUno(2),verticeDos(1)-verticeUno(1));
normal(1) = cos(angulo - pi/2);
normal(2) = sin(angulo - pi/2);
end