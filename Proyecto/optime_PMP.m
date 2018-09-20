function result=optime_PMP(money,weights,precios,v1,n)
% OPTIME_PMP es la funcion encargada de encontrar los pesos por medio del
% metodo de PSO para cada dia del promedio movil ponderado en donde se 
% busca maximizar el rendimiento obtenido de cada
% activo en especifico
% los argumentos de la funcion son MONEY = la cantidad de dinero invertida
%                                 WEIGHTS = La participacion del activo en
%                                 el portafolio preferentemente calculada
%                                 con el metodo de portafolios de markowitz
%                                 PRECIOS = la serie de tiempo que contenga
%                                 los precios del activo
%                                 V1= La ventana de dias con los que se
%                                 calculara el promedio movil
%                                 N = el numero de particulas para buscar
%                                 ese optimo
np=n; %Número de particulas
for j=1:np
    pontemp=rand(v1,1)
    pon=pontemp./sum(pontemp)
    x1p(j,:)=transpose(pon); % inicialización
end
x1pg(v1,1)=0;
vx1(:,v1)=zeros(np,1);
x1pL=x1p;

%%
fxpg=1000; %desempeño valor inicial del mejor global
fxpL=ones(np,1)*fxpg; %desempeño delos mejores locales

c1=0.3;  %Velocidad de convergencia al  mejor global
c2=0.3; %velocidad de convergencia al mejor local

%%
%corregir el numero de vueltas a un numero mas grande
for k=1:2000
a=-10000;

for i=1:np
    %checar condicion de >= 0 para un vector
    fx(i,1)=-(trading_PMP_Proyecto(money,weights,precios,transpose(x1p(i,:)),v1)+a*abs(sum(x1p(i,:))-1)+sum(a*max(-x1p(i,:),0)));
end
[val,ind]=min(fx);
if val<fxpg
    for i=1:v1
        x1pg(i)=x1p(ind,i); 
    end
    fxpg=val;
end
for p=1:np
    if fx(p,1)<fxpL(p,1)
        fxpL(p,1)=fx(p,1);
        for i=1:v1
            x1pL(p,i)=x1p(p,i);
        end
    end
end
fxpg=trading_PMP_Proyecto(money,weights,precios,x1pg,v1);

for i=1:v1
    vx1(:,i)=vx1(:,i)+c1*rand().*(x1pg(i)-x1p(:,i))+c2*rand()*(x1pL(:,i)-x1p(:,i));
    x1p(:,i)=x1p(:,i)+vx1(:,i);
end

end


%%
result=[trading_PMP_Proyecto(money,weights,precios,x1pg,v1) transpose(x1pg)];

end