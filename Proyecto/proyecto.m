clear all;
close all;
clc;
%% descarga de datos
act1=downloadValues('AAPL','17/09/2017','17/09/2018','d','history');
act2=downloadValues('AMZN','09/17/2017','09/17/2018','d','history');
act3=downloadValues('TWTR','09/17/2017', '09/17/2018','d','history');

%% calculo de pesos con markowitz
money=100000;
weights=optime_ponderations(act1,act2,act3); %ponderaciones markowitz
%% Ventana optima de tiempo de promedio movil
v1=optime_window(act1); %venta optima promedio movil

%% Serie de tiempo
precios = act1.AdjClose;
%% rendimiento con una ponderacion inicial aleatoria
pontemp=rand(8,1)
primera_ronda=pontemp./sum(pontemp);
result=trading_PMP_Proyecto(money,weights(1),precios,[primera_ronda],v1(1));

%% rendimiento con una ponderacion de PMP optima
optime_result=optime_PMP(money,weights(1),precios,v1(1),200)