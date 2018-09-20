clear all;
close all;
clc;
%% descarga de datos
tic
act1=downloadValues('AAPL','17/09/2017','17/09/2018','d','history');
act2=downloadValues('AMZN','09/17/2017','09/17/2018','d','history');
act3=downloadValues('TWTR','09/17/2017', '09/17/2018','d','history');

%% calculo de pesos con markowitz

money=100000;
weights=optime_ponderations(act1,act2,act3); %ponderaciones markowitz

%% Ventana optima de tiempo de promedio movil
v1=[optime_window(act1) optime_window(act2) optime_window(act3)]; %venta optima promedio movil

%% Serie de tiempo
precios = [act1.AdjClose act2.AdjClose act3.AdjClose];
%% Rendimiento con una ponderacion inicial aleatoria
%No es necesaria esta parte
pontemp=rand(8,1)
primera_ronda=pontemp./sum(pontemp);
result=trading_PMP_Proyecto(money,weights(1),precios(:,1),[primera_ronda],v1(1));

%% Rendimiento con una ponderacion de PMP optima
optime_result=[optime_PMP(money,weights(1),precios(:,1),v1(1),200) 0 optime_PMP(money,weights(2),precios(:,2),v1(2),200) 0 optime_PMP(money,weights(3),precios(:,3),v1(3),200)]
toc