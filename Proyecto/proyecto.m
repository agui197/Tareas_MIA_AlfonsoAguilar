clear all;
close all;
clc;
%% descarga de datos
act1=downloadValues('AAPL','17/09/2017','17/09/2018','d','history');
act2=downloadValues('AMZN','09/17/2017','09/17/2018','d','history');
act3=downloadValues('TWTR','09/17/2017', '09/17/2018','d','history');

%% calculo de pesos con markowitz
money=100000;
weights=optime_ponderations(act1,act2,act3) %ponderaciones markowitz
%%
v1=optime_window(act1); %venta optima promedio movil
%% ponderaciones para promedio movil ponderado
for i=1:v1(1)
    pon(i,1)=1/v1(1);
end
%%
precios = act1.AdjClose;
%%
result=trading_PMP_Proyecto(money,weights(1),precios,[pon],v1(1))

%% Creacion de las variables necesaras de manera dinamica

%corregir numero de particulas a un numero mas grande
np=5; %N�mero de particulas
for i=1:v1(1)
    
    x1p(:,i)=pon(1).*ones(np,1); % inicializaci�n
    x1pg(i,1)=0; %valor inicial del mejor global
    x1pL(:,i)=x1p(:,1); %valores inciales de mejores locales
    vx1(:,i)=zeros(np,1); 
end
%%
fxpg=1000; %desempe�o valor inicial del mejor global
fxpL=ones(np,1)*fxpg; %desempe�o delos mejores locales

c1=0.5;  %Velocidad de convergencia al  mejor global
c2=0.5; %velocidad de convergencia al mejor local

%%
%corregir el numero de vueltas a un numero mas grande
for k=1:10
a=-100;

for i=1:np
    %checar condicion de >= 0 para un vector
    fx(i,1)=-(trading_PMP_Proyecto(money,weights(1),precios,transpose(x1p(1,:)),v1(1))+a*abs(sum(x1p(1,:))-1));
end
[val,ind]=min(fx);
if val<fxpg
    for i=1:v1(1)
        x1pg(i)=x1p(ind,i); 
    end
    fxpg=val;
end
for p=1:np
    if fx(p,1)<fxpL(p,1)
        fxpL(p,1)=fx(p,1);
        for i=1:v1(1)
            x1pL(p,i)=x1p(p,i);
        end
    end
end
fxpg=trading_PMP_Proyecto(money,weights(1),precios,x1pg,v1(1));

for i=1:v1(1)
    vx1(:,i)=vx1(:,i)+c1*rand().*(x1pg(i)-x1p(:,i))+c2*rand()*(x1pL(:,i)-x1p(:,i));
    x1p(:,i)=x1p(:,i)+vx1(:,i);
end

end
sprintf('success')