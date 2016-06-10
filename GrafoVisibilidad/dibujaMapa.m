function dibujaMapa(mapa,robot,inicio,fin)
tamanioMapa = size(mapa,2);
%Dibujar los obstaculos en el mapa
for i=1:tamanioMapa
   obstaculo = mapa{i};
   patch(obstaculo(:,1),obstaculo(:,2),'k');
end
hold on;
%Dibujar los puntos de inicio y fin 
plot(fin(:,1),fin(:,2),'ro');
hold on;
plot(inicio(:,1),inicio(:,2),'bo');
hold on;
% Dibujar el robot en el mapa
rx=(robot(:,1)-robot(3,1))+inicio(1);
ry=(robot(:,2)-robot(3,2))+inicio(2);
line([rx ;rx(1)],[ry; ry(1)],'Color','g');
axis([0 200 -10 300]);
end