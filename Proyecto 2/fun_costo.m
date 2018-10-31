% Funcion que calcula la J y dJfW para la regresion logistica
%[J, dJdW] =[W,Xa,Y]
function [J,dJdW]=fun_costo(W,Xa,Y)
v=Xa*W;
Yg=1./(1+exp(-v));
m=size(Xa,1);
J=sum(-Y.*log(Yg)-(1-Y).*log(1-Yg))/m;
E=Yg-Y;
dJdW=(E'*Xa)'/m;
end
