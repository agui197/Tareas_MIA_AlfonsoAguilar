%% Obteniendo los datos que ser�n usandos para simular el algoritmo de trading
function y=trading_PMP_Proyecto(k,w,precios,pond,n)
% TRADING_PMP_PROYECTO es la funcion encargada de realizar el trading para
% un activo deseado con una ponderacion calculada de un portafolio para una
% ventana de dias especifica
% los parametros de la funcion son K = Capital total a invertir
%                                  W = La ponderacion para ese activo en el
%                                  portafolio 
%                                  PRECIOS = La serie de tiempo de los
%                                  precios de ciere ajustado del activo
%                                  PON = Los pesos para cada dia del
%                                  promedio movil
%                                  N = La ventana de dias para el promedio
%                                  movil
%% Algoritmo de trading basado en un promedio movil
npm = n; %N�mero de d�as usados para calcular el promedio m�vil
cap = (k*w)*ones(size(precios)); %Capital inicial a invertir
nac = 0*ones(size(precios)); %N�mero de acciones disponibles al inicio de la simulaci�n
com = 0.0029; %Comisi�n por operaci�n

% Simulaci�n del algoritmo
for t = 0:size(precios,1)-npm
    pm(npm+t,1) = sum(pond.*precios(t+1:npm+t,1)); %Calculando el promedio movil
    
    if pm(npm+t,1)<precios(npm+t,1)
        % Comprar, si el promedio movil es m�s grande que el precio actual
        u = floor((cap(npm+t,1))/((1+com)*precios(npm+t,1)));
    else
        % Vender, si el promedio movil es m�s peque�o que el precio actual
        u = -nac(npm+t,1);
    end
    nac(npm+t+1,1) = nac(npm+t,1)+u;
    cap(npm+t+1,1) = cap(npm+t,1)-precios(npm+t,1)*u-com*precios(npm+t,1)*abs(u);
end

% Visualizaci�n de los resultados
% T = (1:size(precios,1))';
% figure(1);
% subplot(4,1,1);
% plot(T,precios,'b-',T(npm:end),pm(npm:end),'r--');
% title(sprintf('Promedio Movil a %d d�as',npm)),xlabel('# dias'), ylabel('precio');
% legend('precio','promedio','Location','NorthEastOutside');
% grid;
% subplot(4,1,2);
% plot(T,nac(1:end-1,1),'b-');
% xlabel('# dias'), ylabel('# acciones');
% legend('# acciones','Location','NorthEastOutside');
% grid;
% subplot(4,1,3);
% plot(T,cap(1:end-1,1),'b-');
% xlabel('# dias'), ylabel('$');
% legend('capital','Location','NorthEastOutside');
% grid;
% subplot(4,1,4);
% plot(T,100*(cap(1:end-1,1)+precios.*nac(1:end-1,1)-cap(1,1))/cap(1,1),'b-');
% xlabel('# dias'), ylabel('rendimiento (%)');
% legend('Total','Location','NorthEastOutside');
% grid;
rendimiento=100*(cap(1:end-1,1)+precios.*nac(1:end-1,1)-cap(1,1))/cap(1,1);  %rendimiento
y=rendimiento(end,1);
end
