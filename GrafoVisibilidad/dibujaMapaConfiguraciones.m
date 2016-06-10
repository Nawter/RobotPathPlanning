function  dibujaMapaConfiguraciones(mapa,robot,inicio,final,espacioConfiguraciones)
tamanio = size(espacioConfiguraciones,2);
%la ruta del robot encima de los obstaculos
for i=1:tamanio
   obstaculo = espacioConfiguraciones{i};   
   patch(obstaculo(:,1),obstaculo(:,2),'k');
end
%los obstaculos
for i=1:tamanio
   obstaculo = mapa{i};
   patch(obstaculo(:,1),obstaculo(:,2),'g');
end
hold on;
plot(final(:,1),final(:,2),'ro');
hold on;
plot(inicio(:,1),inicio(:,2),'bo');
hold on;
rx=(robot(:,1)-robot(3,1))+inicio(1);
ry=(robot(:,2)-robot(3,2))+inicio(2);
line([rx ;rx(1)],[ry; ry(1)],'Color','g');
axis([0 200 -10 300]);
end