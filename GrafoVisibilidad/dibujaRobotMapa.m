%Dibujar el robot dentro del area de trabajo
function dibujarRobotMapa(coordenadasRobot)
% Dibujar los lados del robot de color verde
plot(coordenadasRobot(1,:),coordenadasRobot(2,:),'g');
plot([coordenadasRobot(1,end),coordenadasRobot(1,1)],[coordenadasRobot(2,end),coordenadasRobot(2,1)],'g');
% Dibujar el punto de referencia de color azul.
plot(coordenadasRobot(1,1),coordenadasRobot(2,1),'b.');