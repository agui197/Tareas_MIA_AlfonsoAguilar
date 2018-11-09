clc;
clear all;
close all;
% Datos
%dataX=xlsread('database.xlsx','data_by_states','A4:N30');
dataX=xlsread('database.xlsx','data_by_states','B33:N59');

dataX=fillmissing(dataX,'constant',0);
X=dataX(:,2:end);
X( :, ~any(X,1) ) = [];  %columns
dataY=xlsread('total_change_production.xlsx','Hoja1');
Y=dataY(2:end,53);

grado=1;
[Wmc,J]=adeline_MC(X,Y,grado);
[Wgd,J]=adeline_GD(X,Y,grado);

Wgd
