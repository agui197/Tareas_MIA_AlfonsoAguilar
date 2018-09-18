clear all;
close all;
clc;

hoy=datestr(date,23);
inicio=datestr(datenum(date)-365,23);
data = downloadValues('GRUMAB.MX',inicio,hoy,'d','history');
precios = data.AdjClose; %Seleccionar los precios de cierre
pon1=.2;
pon2=.5;
pon3=.3;
result=trading_PMovilPonderado(precios,pon1,pon2,pon3)