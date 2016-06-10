function dibujaObstaculo(obstaculo,numeroObstaculos,color)
for i = 1 : numeroObstaculos,
    fill(obstaculo{i}(1,:),obstaculo{i}(2,:),color);
    plot(obstaculo{i}(1,:),obstaculo{i}(2,:),'k');
    plot([obstaculo{i}(1,1),obstaculo{i}(1,end)],[obstaculo{i}(2,1),obstaculo{i}(2,end)],'k');       
end
