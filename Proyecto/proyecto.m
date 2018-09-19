clear all;
close all;
clc;
%%
act1=downloadValues('CEMEXCPO.MX','17/09/2017','17/09/2018','d','history');
act2=downloadValues('PE&OLES.MX','09/17/2017','09/17/2018','d','history');
act3=downloadValues('AMXL.MX','09/17/2017', '09/17/2018','d','history');

k=100;
weights=optime_ponderations(act1,act2,act3); %ponderaciones markowitz

%%
v1=optime_window(act3); %venta optima promedio movil
%ponderaciones para promedio movil ponderado
pon1=.5;
pon2=.5;

precios = act3.AdjClose;
result=trading_PMP_Proyecto(k,weights(3),precios,[pon1;pon2],v1)
%%

np=200; %Número de particulas

x1p=pon1.*ones(np,1); % inicialización
x1pg=0; %valor inicial del mejor global
x1pL=x1p; %valores inciales de mejores locales
vx1=zeros(np,1);  %velocidad del enjambre

x2p=pon2.*ones(np,1); % inicialización
x2pg=0; %valor inicial del mejor global
x2pL=x1p; %valores inciales de mejores locales
vx2=zeros(np,1);  %velocidad del enjambre
fxpg=1000000; %desempeño valor inicial del mejor global
fxpL=ones(np,1)*fxpg; %desempeño delos mejores locales

c1=0.1;  %Velocidad de convergencia al  mejor global
c2=0.1; %velocidad de convergencia al mejor local

%%
for k=1:2500
a=-1000;

for i=1:np
    
    fx(i,1)=-(trading_PMP_Proyecto(k,weights(3),precios,[x1p(i);x2p(i)],v1)+a*abs(x1p(1)+x2p(1)-1)+a*max(-x1p,0)+a*max(-x2p,0));
end

[val,ind]=min(fx);
if val<fxpg
    x1pg=x1p(ind,1);
    x2pg=x2p(ind,1);
    fxpg=val;
end
for p=1:np
    if fx(p,1)<fxpL(p,1)
        fxpL(p,1)=fx(p,1);
        x1pL(p,1)=x1p(p,1);
        x2pL(p,1)=x2p(p,1);
    end
end
fxpg=trading_PMP_Proyecto(k,weights(3),precios,[x1pg;x2pg],v1);
vx1=vx1+c1*rand(np,1).*(x1pg-x1p)+c2*rand()*(x1pL-x1p);
x1p=x1p+vx1;
%rand(np,1). sirve para darle una velocidad diferente a cada particula

vx2=vx2+c1*rand(np,1).*(x2pg-x2p)+c2*rand()*(x2pL-x2p);
x2p=x2p+vx2;
end
success=x1pg+x2pg