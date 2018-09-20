function [esperanzaport, desvestport]=fun_portafolio(Precios,part)
% FUN_PORTAFOLIO es una funcion encargada de devolver el valor esperado de
% los activos que conformaran el portafolio asi como su desviacion estandar
%sus parametros son PRECIOS = el precio de cierre ajustado de los activos
%                   PART = es la ponderacion que se dara a cada uno de los
%                   activos
%La funcion puede calcular los rendimientos logaritmicos descomentando la
%linea 14, esto volveria mas eficiente el codigo 
[nprecios,activos]=size(Precios);
npart=size(part,1);
for k=1:activos
rend(:,k)=(Precios(2:nprecios,k)-Precios(1:nprecios-1,k))./Precios(1:nprecios-1,k);
end
%rend=diff(log(a));

esperanza=mean(rend);
varianza=var(rend);
desvest=std(rend);
covar=cov(rend);
esperanzaport=part*esperanza';
for k=1:npart
   riesgoport(k,:)=part(k,:)*covar*part(k,:)'; 
end
desvestport=sqrt(riesgoport);
end