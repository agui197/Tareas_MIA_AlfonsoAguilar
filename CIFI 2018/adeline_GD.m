function [Wgd,J]=adeline_GD(X,Y,k)
m=size(X,1);
Xa=func_polinomio(X,k);

Wgd=rand(size(Xa,2),1); %Pesos iniciales
eta=0.00000000001; %Velocidad de convergencia

for k=1:1000000
    Yg_gd=Xa*Wgd; %Y estimada de gradiente descendiente
    E=Y-Yg_gd;
    J(k,1)=E'*E/(2*m);
    dJdW=-E'*Xa/m;
    Wgd=Wgd-eta*dJdW';
end

end




