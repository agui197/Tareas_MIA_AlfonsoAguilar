clc;
clear all;
close all;
% Datos
% Modificar el estado del cual queremos los datos
state=1;

% X
a=3;
b=a+26;
dataX=xlsread('database.xlsx','data_by_states',['A' num2str(a+state) ':' 'N' num2str(b+state)]);
dataX=fillmissing(dataX,'constant',0);
X=dataX(:,2:end);
X( :, ~any(X,1) ) = [];  %columns

% Y
k=52;
dataY=xlsread('total_change_production.xlsx','Hoja1');
Y=dataY(2:end,k+state).*100;

% Modelo
grado=1;
[Wmc,J,Xa]=adeline_MC(X,Y,grado);
%[Wgd,J]=adeline_GD(X,Y,grado);

% Plot
% Modificar la energia que queremos graficar
energia=1;

Yg=Xa*Wmc;
figure(1)
plot(Y,'r')
title('Total de energia real vs Total de energia del modelo')
xlabel('Tiempo')
ylabel('Cambio porcentual')
hold on
plot(Yg,'g')
figure(2)
bar(Wmc)
title('Pesos del modelo')
xlabel('Variables')
figure(3)
plot(Y,'r')
title('Fuente especifica de energia vs Total de produccion del estado')
xlabel('Tiempo')
ylabel('Cambio porcentual')
hold on
plot(X(:,energia),'b')
%% Prediccion 
x=[5,5,5,5,5,5,5,5];
xa=func_polinomio(x,grado);
Yg_mc=xa*Wmc;