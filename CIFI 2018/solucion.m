
%% Problema 3
%datos=xlsread('Regresión.xlsx','Problema 3','A2:D201');
%X1=datos(:,1);
Y=xlsread('total_change_production.xlsx','Hoja1');
%grado=2;
%[Wmc,J]=adeline_MC(X,Y,grado)



%%
% Gradiente Descendiente
m=size(X1,1);
Xa=ones(m,1);

X=[X1 X2 X3];
for k=1:2
    Xa=func_polinomio(X,k);
end

Wmc=inv(Xa'*Xa)*Xa'*Y;
Wgd=rand(size(Xa,2),1); %Pesos iniciales
eta=0.000000001 %Velocidad de convergencia

for k=1:10000000
    Yg_gd=Xa*Wgd; %Y estimada de gradiente descendiente
    E=Y-Yg_gd;
    J(k,1)=E'*E/(2*m);
    dJdW=-E'*Xa/m;
    Wgd=Wgd-eta*dJdW';
end
Yg_mc=Xa*Wmc;
Yg_gd=Xa*Wgd;

[Wmc Wgd]