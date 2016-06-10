function varargout = InterfazUsuarioGVI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InterfazUsuarioGV_OpeningFcn, ...
                   'gui_OutputFcn',  @InterfazUsuarioGV_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% Funcion que se utiliza para arrancar la interfaz. 
function InterfazUsuarioGV_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
% Funcion que se utiliza para salir del programa y volver a la linea de 
% comandos.  
function varargout = InterfazUsuarioGV_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% Funcion que se utiliza para dibujar un triangulo como representacion 
% geometrica de un robot.
function dibujaRobot(hObject, eventdata, handles)
hold on;
numeroDeVertices = 0;
coordenadasRobot= [];
while numeroDeVertices ~= 3
    puntoEnPantalla = ginput(1);
    coordenadasRobot = [coordenadasRobot, puntoEnPantalla'];
    plot(coordenadasRobot(1,:),coordenadasRobot(2,:),'g');
    numeroDeVertices = numeroDeVertices + 1;
end
dibujaRobotMapa(coordenadasRobot);
handles.coordenadasRobot=coordenadasRobot;
guidata(hObject, handles);
% Funcion cuyo cometido es dibujar obstaculos en la pantalla que se recoger
% gracias a un combo de texto, y que cada obstaculo tiene cinco aristas de
% forma predeterminada.
function dibujaObstaculos(hObject, eventdata, handles)
hold on;
numeroObstaculos = handles.numeroObstaculos;
numeroAristas = handles.numeroAristas;
if numeroAristas < 3
    disp('Se sale del programa debido a que el numero de aristas no esta permitido');
    close(handles.output);
    return;
end
contadorObstaculos = 0;
contadorAristas = 0;
while (contadorObstaculos < numeroObstaculos)
    contadorObstaculos = contadorObstaculos + 1;
    obstaculos{contadorObstaculos} = [];
    while (contadorAristas < numeroAristas)
        puntoEnPantalla = ginput(1);
        obstaculos{contadorObstaculos} = [obstaculos{contadorObstaculos}, puntoEnPantalla'];
        plot(obstaculos{contadorObstaculos}(1,:),obstaculos{contadorObstaculos}(2,:),'k');
        contadorAristas = contadorAristas + 1;   
    end
    plot([obstaculos{contadorObstaculos}(1,1),obstaculos{contadorObstaculos}(1,end)],[obstaculos{contadorObstaculos}(2,1),obstaculos{contadorObstaculos}(2,end)],'k');   
    contadorAristas = 0;  
end 
dibujaObstaculo(obstaculos,numeroObstaculos,'g');
handles.obstaculos=obstaculos;
guidata(hObject, handles);
% Funcion que tiene como mision dibujar el punto final donde tiene que ir el
% robot.
function dibujaPuntoFinal(hObject, eventdata, handles)
hold on;
puntoFinal = [];
puntoEnPantalla = ginput(1);
puntoFinal = [puntoFinal, puntoEnPantalla'];
plot(puntoFinal(1,:),puntoFinal(2,:),'ro');
handles.puntoFinal=puntoFinal;
guidata(hObject, handles);
% Funcion que se usa para limpiar el espacio de trabajo.
function limpiaEntorno(hObject, eventdata, handles)
cla;
axis([0 200 -10 300]);
% La funcion responsable de dibujar el grafo de visibilidad.
% En esta funcion se utilizan las martices traspuestas en vez de las 
% matrices normales.
function calculaGrafo(hObject, eventdata, handles)
obstaculos=handles.obstaculos;
numeroObstaculos=size(obstaculos,2);
mapaAux = [];
mapa = [];
for i = 1:numeroObstaculos 
    mapaAux{i}=obstaculos{i};        
    mapa{i} = (mapaAux{i}');
end
try
    t = cputime;
    calculaGrafoVisibilidad(mapa,handles.coordenadasRobot',handles.puntoInicial',handles.puntoFinal');
    e = cputime-t;
    disp(e);
    disp('segundos');
catch
    disp('Error de funcionamiento, por favor comprueba tus datos.');
end
% Funcion que tiene como mision dibujar el punto inicial donde tiene que 
% empezar el robot.
function dibujaPuntoInicial(hObject, eventdata, handles)
hold on;
puntoInicial = [];
puntoEnPantalla = ginput(1);
puntoInicial = [puntoInicial, puntoEnPantalla'];
plot(puntoInicial(1,:),puntoInicial(2,:),'bo');
handles.puntoInicial=puntoInicial;
guidata(hObject, handles);
% Funcion que se usa para recoger el numero de obstaculos solo cuando se produce un 
% cambio.
function ponNumeroObstaculos(hObject, eventdata, handles)
handles.numeroObstaculos=str2double(get(hObject,'String'));
guidata(hObject, handles);
% Funcion que se usa para recoger el numero de obstaculos que esta ubicado 
% dentro del combo de tipo texto solo cuando se carga la aplicacion.
function ConstructorPonNumeroObstaculos(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.numeroObstaculos=str2double(get(hObject,'String'));
guidata(hObject, handles);
% Funcion que se usa para recoger el numero de obstaculos solo cuando se produce un 
% cambio.
function ponNumeroAristas(hObject, eventdata, handles)
handles.numeroAristas=str2double(get(hObject,'String'));
guidata(hObject, handles);
% Funcion que se usa para recoger el numero de obstaculos que esta ubicado 
% dentro del combo de tipo texto solo cuando se carga la aplicacion.
function ConstructorPonNumeroAristas(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.numeroAristas=str2double(get(hObject,'String'));
guidata(hObject, handles);
