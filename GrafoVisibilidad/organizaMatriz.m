% Funcion que se utiliza para organizar la matriz de forma ordenada que siga
% una secuencia de vertices igual al triangulo antes de aplicar el
% tratamiento para generar la matriz del espacio de configuraciones.
function espacioConfiguraciones = organizaMatriz(espacioConfiguraciones)
[x y] = size(espacioConfiguraciones);
medio = sum(espacioConfiguraciones)/x;
angulo = atan2(espacioConfiguraciones(:,2)-medio(2), espacioConfiguraciones(:,1)-medio(1));
angulo = mod(angulo,2*pi);
[angulo srt] = sort(angulo);
espacioConfiguraciones = [espacioConfiguraciones(srt,1) espacioConfiguraciones(srt,2)];
end
